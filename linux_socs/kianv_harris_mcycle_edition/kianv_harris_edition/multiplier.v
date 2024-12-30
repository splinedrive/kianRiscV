/*
 *  kianv harris multicycle RISC-V rv32im
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
    input  wire                        clk,
    input  wire                        resetn,
    input  wire [              31 : 0] multiplicand_op,
    input  wire [              31 : 0] multiplier_op,
    input  wire [`MUL_OP_WIDTH -1 : 0] MULop,
    output wire [              31 : 0] result,
    input  wire                        valid,
    output reg                         ready
);


  wire is_mulh;
  assign is_mulh = MULop == `MUL_OP_MULH;

  wire is_mulsu;
  assign is_mulsu = MULop == `MUL_OP_MULSU;

  wire is_mulu;
  assign is_mulu = MULop == `MUL_OP_MULU;

  wire multiplicand_op_is_signed;
  assign multiplicand_op_is_signed = is_mulh | is_mulsu;

  wire multiplier_op_is_signed;
  assign multiplier_op_is_signed = is_mulh;

  // multiplication
  reg [63:0] rslt;
  reg [31:0] multiplicand_op_abs;
  reg [31:0] multiplier_op_abs;

  localparam IDLE_BIT = 0;
  localparam CALC_BIT = 1;
  localparam READY_BIT = 2;

  localparam IDLE = 1 << IDLE_BIT;
  localparam CALC = 1 << CALC_BIT;
  localparam READY = 1 << READY_BIT;

  localparam NR_STATES = 3;

  (* onehot *)
  reg [NR_STATES-1:0] state;

  wire [31:0] rslt_upper_low;
  assign rslt_upper_low = (is_mulh | is_mulu | is_mulsu) ? rslt[63:32] : rslt[31:0];
  always @(posedge clk) begin
    if (!resetn) begin
      state   <= IDLE;
      ready   <= 1'b0;
    end else begin

      (* parallel_case, full_case *)
      case (1'b1)

        state[IDLE_BIT]: begin
          ready <= 1'b0;
          if (!ready && valid) begin
            multiplicand_op_abs <= (multiplicand_op_is_signed & multiplicand_op[31]) ? ~multiplicand_op + 1 : multiplicand_op;
            multiplier_op_abs <= (multiplier_op_is_signed & multiplier_op[31]) ? ~multiplier_op + 1 : multiplier_op;
            rslt <= 0;
            state <= CALC;
          end
        end

        state[CALC_BIT]: begin
`ifndef FAKE_MULTIPLIER
          /* verilator lint_off WIDTH */
          if (multiplier_op_abs & 1'b1) begin
            rslt <= rslt + multiplicand_op_abs;
          end
          multiplicand_op_abs <= multiplicand_op_abs << 1;
          multiplier_op_abs   <= multiplier_op_abs >> 1;

          /* verilator lint_on WIDTH */
          if (|multiplier_op_abs) begin
            state <= READY;
          end
`else
          rslt  <= multiplicand_op_abs * multiplier_op_abs;
          state <= READY;
`endif
        end

        state[READY_BIT]: begin
          /* verilator lint_off WIDTH */
          rslt <= ((multiplicand_op[31] & multiplicand_op_is_signed ^ multiplier_op[31] & multiplier_op_is_signed)) ? ~rslt + 1 : rslt;
          /* verilator lint_on WIDTH */

          ready <= 1'b1;
          state <= IDLE;
        end

      endcase

    end

  end

  assign result = rslt_upper_low;

endmodule
