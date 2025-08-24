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

module multiplier (
    input  wire                     clk,
    input  wire                     resetn,
    input  wire [             31:0] multiplicand_op,
    input  wire [             31:0] multiplier_op,
    input  wire [`MUL_OP_WIDTH-1:0] MULop,
    output wire [             31:0] result,
    input  wire                     valid,
    output reg                      ready
);

  reg [31:0] a_q, b_q;
  reg  [`MUL_OP_WIDTH-1:0] MULop_q;

  wire                     is_mulh_q = (MULop_q == `MUL_OP_MULH);
  wire                     is_mulsu_q = (MULop_q == `MUL_OP_MULSU);
  wire                     is_mulu_q = (MULop_q == `MUL_OP_MULU);
  wire                     is_mul_q = ~(is_mulh_q | is_mulsu_q | is_mulu_q);

  wire                     a_signed_q = is_mulh_q | is_mulsu_q;
  wire                     b_signed_q = is_mulh_q;

  localparam IDLE_BIT = 0;
  localparam PREP_BIT = 1;
  localparam CALC_BIT = 2;
  localparam MUL1_BIT = 3;
  localparam READY_BIT = 4;
  localparam DONE_BIT = 5;

  localparam IDLE = 1 << IDLE_BIT;
  localparam PREP = 1 << PREP_BIT;
  localparam CALC = 1 << CALC_BIT;
  localparam MUL1 = 1 << MUL1_BIT;
  localparam READY = 1 << READY_BIT;
  localparam DONE = 1 << DONE_BIT;

  (* onehot *)reg  [ 5:0] state;

  reg  [63:0] acc;
  reg  [63:0] mcand;
  reg  [31:0] mulr;
  reg         prod_neg_r;
  reg  [31:0] res_q;

  wire [31:0] a_abs = (a_signed_q && a_q[31]) ? (~a_q + 32'd1) : a_q;
  wire [31:0] b_abs = (b_signed_q && b_q[31]) ? (~b_q + 32'd1) : b_q;

  wire [31:0] mulr_next = mulr >> 1;

  wire [31:0] acc_lo = acc[31:0];
  wire [31:0] acc_hi = acc[63:32];

  wire [31:0] lo_tc = ~acc_lo + 32'd1;
  wire        carry_to_hi = (acc_lo == 32'd0);
  wire [31:0] hi_tc = ~acc_hi + {31'd0, carry_to_hi};

  assign result = res_q;

`ifndef FPGA_MULTIPLIER
  `include "design_func.vh"
  wire [5:0] tz_b_abs = ctz32(b_abs);
`else
  (* keep = "true" *) reg [31:0] a_dsp, b_dsp;
  (* use_dsp = "yes" *) wire [63:0] p_mul = a_dsp * b_dsp;
`endif

  always @(posedge clk) begin
    if (!resetn) begin
      state      <= IDLE;
      ready      <= 1'b0;
      a_q        <= 32'b0;
      b_q        <= 32'b0;
      MULop_q    <= {`MUL_OP_WIDTH{1'b0}};
      acc        <= 64'b0;
      mcand      <= 64'b0;
      mulr       <= 32'b0;
      prod_neg_r <= 1'b0;
      res_q      <= 32'b0;
`ifdef FPGA_MULTIPLIER
      a_dsp <= 32'b0;
      b_dsp <= 32'b0;
`endif
    end else begin
      case (1'b1)

        state[IDLE_BIT]: begin
          ready <= 1'b0;
          if (valid) begin
            a_q     <= multiplicand_op;
            b_q     <= multiplier_op;
            MULop_q <= MULop;
            state   <= PREP;
          end
        end

        state[PREP_BIT]: begin
          prod_neg_r <= (a_signed_q && a_q[31]) ^ (b_signed_q && b_q[31]);

`ifndef FPGA_MULTIPLIER
          acc <= 64'b0;
          if (b_abs == 32'd0) begin
            mcand <= 64'b0;
            mulr  <= 32'd0;
            state <= READY;
          end else begin
            mcand <= ({32'b0, a_abs}) << tz_b_abs;
            mulr  <= b_abs >> tz_b_abs;
            state <= CALC;
          end
`else
          a_dsp <= a_abs;
          b_dsp <= b_abs;
          state <= MUL1;
`endif
        end

        state[CALC_BIT]: begin
`ifndef FPGA_MULTIPLIER
          if (mulr[0]) acc <= acc + mcand;
          mcand <= mcand << 1;
          mulr  <= mulr_next;
          if (mulr_next == 32'b0) state <= READY;
`endif
        end

        state[MUL1_BIT]: begin
`ifdef FPGA_MULTIPLIER
          acc   <= p_mul;
          state <= READY;
`endif
        end

        state[READY_BIT]: begin
          if (is_mul_q) res_q <= (prod_neg_r ? lo_tc : acc_lo);
          else res_q <= (prod_neg_r ? hi_tc : acc_hi);
          state <= DONE;
        end

        state[DONE_BIT]: begin
          ready <= 1'b1;
          if (!valid) begin
            ready <= 1'b0;
            state <= IDLE;
          end
        end

        default: begin
          state <= IDLE;
          ready <= 1'b0;
        end
      endcase
    end
  end
endmodule
