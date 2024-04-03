/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2022/24 hirosh dabui <hirosh@dabui.de>
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
module alu (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [`ALU_CTRL_WIDTH -1:0] alucontrol,
    output reg [31:0] result,
    output wire zero
);

  wire signed [31:0] signed_a = $signed(a);
  wire signed [31:0] signed_b = $signed(b);

  always @* begin
    case (alucontrol)
      `ALU_CTRL_AUIPC, `ALU_CTRL_ADD_ADDI: result = a + b;
      `ALU_CTRL_SUB:                       result = a - b;
      `ALU_CTRL_XOR_XORI:                  result = a ^ b;
      `ALU_CTRL_OR_ORI:                    result = a | b;
      `ALU_CTRL_AND_ANDI:                  result = a & b;
      `ALU_CTRL_SLL_SLLI:                  result = a << b[4:0];
      `ALU_CTRL_SRL_SRLI:                  result = a >> b[4:0];
      `ALU_CTRL_SRA_SRAI:                  result = signed_a >>> b[4:0];
      `ALU_CTRL_SLT_SLTI:                  result = {31'b0, signed_a < signed_b};
      `ALU_CTRL_SLTU_SLTIU:                result = {31'b0, a < b};
      `ALU_CTRL_MIN:                       result = (signed_a < signed_b) ? a : b;
      `ALU_CTRL_MAX:                       result = (signed_a >= signed_b) ? a : b;
      `ALU_CTRL_MINU:                      result = (a < b) ? a : b;
      `ALU_CTRL_MAXU:                      result = (a >= b) ? a : b;
      `ALU_CTRL_LUI:                       result = b;
      `ALU_CTRL_BEQ:                       result = {31'b0, a == b};
      `ALU_CTRL_BNE:                       result = {31'b0, a != b};
      `ALU_CTRL_BGE:                       result = {31'b0, signed_a >= signed_b};
      `ALU_CTRL_BGEU:                      result = {31'b0, a >= b};
      `ALU_CTRL_BLT:                       result = {31'b0, signed_a < signed_b};
      `ALU_CTRL_BLTU:                      result = {31'b0, a < b};
      default:                             result = 32'b0;
    endcase
  end

  assign zero = (result == 32'b0);
endmodule
