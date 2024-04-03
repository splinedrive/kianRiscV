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
module multiplier_decoder (
    input  wire [               2:0] funct3,
    output reg  [`MUL_OP_WIDTH -1:0] MULop,
    input  wire                      mul_ext_valid,
    output wire                      mul_valid
);

  wire is_mul = funct3 == 3'b000;
  wire is_mulh = funct3 == 3'b001;
  wire is_mulsu = funct3 == 3'b010;
  wire is_mulu = funct3 == 3'b011;
  reg  valid;

  assign mul_valid = valid & mul_ext_valid;
  always @(*) begin
    valid = 1'b1;
    case (1'b1)
      is_mul:   MULop = `MUL_OP_MUL;
      is_mulh:  MULop = `MUL_OP_MULH;
      is_mulsu: MULop = `MUL_OP_MULSU;
      is_mulu:  MULop = `MUL_OP_MULU;
      default: begin
        /* verilator lint_off WIDTH */
        MULop = 'hxx;
        /* verilator lint_on WIDTH */
        valid = 1'b0;
      end
    endcase
  end

endmodule
