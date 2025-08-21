
/*
 *  kianv harris multicycle RISC-V rv32im – divider (early-exit, no barrel-shift preload)
 *
 *  This version keeps the CLZ-based early-exit, but avoids the large
 *  one-cycle variable left shift. Instead, it indexes bits from the
 *  latched |dividend| with a 32:1 mux and builds the quotient separately.
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */

`default_nettype none
`include "riscv_defines.vh"

module divider (
    input wire clk,
    input wire resetn,

    input  wire [             31:0] divident,
    input  wire [             31:0] divisor,
    input  wire [`DIV_OP_WIDTH-1:0] DIVop,
    output wire [             31:0] divOrRemRslt,
    input  wire                     valid,
    output reg                      ready,
    output wire                     div_by_zero_err
);
  localparam IDLE_BIT = 0;
  localparam CALC_BIT = 1;
  localparam READY_BIT = 2;
  localparam FAST_BIT = 3;

  localparam IDLE = 1 << IDLE_BIT;
  localparam CALC = 1 << CALC_BIT;
  localparam READY = 1 << READY_BIT;
  localparam FAST = 1 << FAST_BIT;

  localparam NR_STATES = 4;

  (* onehot *) reg [NR_STATES-1:0] div_state;


  reg [31:0] rem_rslt;
  reg [31:0] quo_rslt;


  reg [5:0] iter_cnt;


  reg [31:0] divident_q, divisor_q;
  reg [`DIV_OP_WIDTH-1:0] DIVop_q;


  reg [31:0] dvd_q;

  reg [4:0] bit_idx;


  reg [4:0] pow2_shift_q;


  wire is_div_q = (DIVop_q == `DIV_OP_DIV);
  wire is_divu_q = (DIVop_q == `DIV_OP_DIVU);
  wire is_rem_q = (DIVop_q == `DIV_OP_REM);
  wire is_remu_q = (DIVop_q == `DIV_OP_REMU);
  wire is_signed_q = is_div_q | is_rem_q;


  wire [31:0] divident_abs_q = (is_signed_q & divident_q[31]) ? (~divident_q + 32'd1) : divident_q;
  wire [31:0] divisor_abs_q = (is_signed_q & divisor_q[31]) ? (~divisor_q + 32'd1) : divisor_q;


  wire is_div_in = (DIVop == `DIV_OP_DIV);
  wire is_rem_in = (DIVop == `DIV_OP_REM);
  wire is_signed_in = is_div_in | is_rem_in;
  wire [31:0] divisor_abs_in = (is_signed_in & divisor[31]) ? (~divisor + 32'd1) : divisor;
  assign div_by_zero_err = (divisor_abs_in == 32'b0);


  function automatic [5:0] clz32;
    input [31:0] x;
    reg [31:0] y;
    reg [ 5:0] n;
    begin
      if (x == 32'b0) begin
        clz32 = 6'd32;
      end else begin
        y = x;
        n = 6'd0;
        if (y[31:16] == 0) begin
          n = n + 16;
          y = y << 16;
        end
        if (y[31:24] == 0) begin
          n = n + 8;
          y = y << 8;
        end
        if (y[31:28] == 0) begin
          n = n + 4;
          y = y << 4;
        end
        if (y[31:30] == 0) begin
          n = n + 2;
          y = y << 2;
        end
        if (y[31] == 0) begin
          n = n + 1;
        end
        clz32 = n;
      end
    end
  endfunction


  function automatic [5:0] ctz32;
    input [31:0] x;
    reg [31:0] y;
    reg [ 5:0] n;
    begin
      if (x == 32'b0) begin
        ctz32 = 6'd32;
      end else begin
        y = x;
        n = 6'd0;
        if (y[15:0] == 0) begin
          n = n + 16;
          y = y >> 16;
        end
        if (y[7:0] == 0) begin
          n = n + 8;
          y = y >> 8;
        end
        if (y[3:0] == 0) begin
          n = n + 4;
          y = y >> 4;
        end
        if (y[1:0] == 0) begin
          n = n + 2;
          y = y >> 2;
        end
        if (y[0] == 0) begin
          n = n + 1;
        end
        ctz32 = n;
      end
    end
  endfunction


  wire [5:0] lz_divident_q = clz32(divident_abs_q);
  wire [5:0] iter_cnt_init_q = (divident_abs_q == 32'b0) ? 6'd0 : (6'd32 - lz_divident_q);

  wire [31:0] divident_abs_in = (is_signed_in & divident[31]) ? (~divident + 32'd1) : divident;
  wire [5:0] lz_divident_in = clz32(divident_abs_in);
  wire [5:0] iter_cnt_init_in = (divident_abs_in == 32'b0) ? 6'd0 : (6'd32 - lz_divident_in);


  wire        is_pow2_in = (divisor_abs_in != 32'b0) &&
                           ((divisor_abs_in & (divisor_abs_in - 32'd1)) == 32'b0);

  wire [5:0] pow2_shift_full_in = ctz32(divisor_abs_in);
  wire [4:0] pow2_shift_in = pow2_shift_full_in[4:0];


  wire in_bit = dvd_q[bit_idx];
  wire [31:0] rem_rslt_next = {rem_rslt[30:0], in_bit};
  (* use_dsp = "yes" *)
  wire [32:0] rem_rslt_sub_divident = {1'b0, rem_rslt_next} - {1'b0, divisor_abs_q};
  wire [31:0] quo_rslt_next_sub_neg = (quo_rslt << 1);
  wire [31:0] quo_rslt_next_sub_ok = (quo_rslt << 1) | 32'b1;


  always @(posedge clk) begin
    if (!resetn) begin
      div_state    <= IDLE;
      ready        <= 1'b0;

      rem_rslt     <= 32'b0;
      quo_rslt     <= 32'b0;
      iter_cnt     <= 6'd0;

      divident_q   <= 32'b0;
      divisor_q    <= 32'b0;
      DIVop_q      <= {`DIV_OP_WIDTH{1'b0}};

      dvd_q        <= 32'b0;
      bit_idx      <= 5'd0;
      pow2_shift_q <= 5'd0;

    end else begin
      (* parallel_case, full_case *)
      case (1'b1)


        div_state[IDLE_BIT]: begin
          ready <= 1'b0;
          if (!ready && valid) begin

            divident_q   <= divident;
            divisor_q    <= divisor;
            DIVop_q      <= DIVop;
            dvd_q        <= divident_abs_in;
            iter_cnt     <= iter_cnt_init_in;
            bit_idx      <= (lz_divident_in == 6'd32) ? 5'd0 : (5'd31 - lz_divident_in[4:0]);
            rem_rslt     <= 32'b0;
            quo_rslt     <= 32'b0;
            pow2_shift_q <= pow2_shift_in;

            if (div_by_zero_err || (iter_cnt_init_in == 6'd0)) begin
              div_state <= READY;
            end else if (is_pow2_in) begin
              div_state <= FAST;
            end else begin
              div_state <= CALC;
            end
          end
        end


        div_state[FAST_BIT]: begin
          rem_rslt  <= divident_abs_q & (divisor_abs_q - 32'd1);
          quo_rslt  <= divident_abs_q >> pow2_shift_q;
          div_state <= READY;
        end


        div_state[CALC_BIT]: begin

          if (rem_rslt_sub_divident[32]) begin
            rem_rslt <= rem_rslt_next;
            quo_rslt <= quo_rslt_next_sub_neg;
          end else begin
            rem_rslt <= rem_rslt_sub_divident[31:0];
            quo_rslt <= quo_rslt_next_sub_ok;
          end


          bit_idx  <= bit_idx - 5'd1;
          iter_cnt <= iter_cnt - 6'd1;

          if (iter_cnt == 6'd1) begin
            div_state <= READY;
          end
        end


        div_state[READY_BIT]: begin
          if (divisor_abs_q == 32'b0) begin
            quo_rslt <= 32'hFFFF_FFFF;
            rem_rslt <= divident_q;
          end else begin
            if (is_signed_q & (divident_q[31] ^ divisor_q[31])) begin
              quo_rslt <= ~quo_rslt + 32'd1;
            end
            if (is_signed_q & divident_q[31]) begin
              rem_rslt <= ~rem_rslt + 32'd1;
            end
          end
          ready     <= 1'b1;
          div_state <= IDLE;
        end

      endcase
    end
  end


  assign divOrRemRslt = (is_div_q | is_divu_q) ? quo_rslt : rem_rslt;

endmodule
