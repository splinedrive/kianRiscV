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
`default_nettype none `timescale 1 ns / 100 ps
`include "riscv_defines.svh"

module alu32 (
    input  wire logic        [31:0] a,
    input  wire logic        [31:0] b,
    input  wire AluControl_t        AluControl,
    output logic             [31:0] result,
    output logic                    zero
);

  logic [31:0] sltx_sltux_rslt;
  logic [63:0] sext_rs1;
  /* verilator lint_off UNUSED */
  logic [63:0] sra_srai_rslt;
  /* verilator lint_on UNUSED */
  logic        is_sub;
  logic [31:0] condinv;
  logic [31:0] sum;

  assign sltx_sltux_rslt = {31'b0, a < b};
  assign sext_rs1 = {{32{a[31]}}, a};
  assign sra_srai_rslt = sext_rs1 >> b[4:0];

  assign is_sub = AluControl == ALU_CTRL_SUB;
  assign condinv = is_sub ? ~b : b;
  assign sum = a + (condinv + {30'b0, is_sub});

  always_comb begin
    case (AluControl)
      ALU_CTRL_ADD_ADDI:   result = sum;
      ALU_CTRL_SUB:        result = sum;
      ALU_CTRL_XOR_XORI:   result = a ^ b;
      ALU_CTRL_OR_ORI:     result = a | b;
      ALU_CTRL_AND_ANDI:   result = a & b;
      ALU_CTRL_SLL_SLLI:   result = a << b[4:0];
      ALU_CTRL_SRL_SRLI:   result = a >> b[4:0];
      ALU_CTRL_SRA_SRAI:   result = sra_srai_rslt[31:0];
      ALU_CTRL_SLT_SLTI:   result = (a[31] == b[31]) ? sltx_sltux_rslt : {31'b0, a[31]};
      ALU_CTRL_SLTU_SLTIU: result = sltx_sltux_rslt;
      ALU_CTRL_LUI:        result = b;
      ALU_CTRL_AUIPC:      result = sum;
      ALU_CTRL_BEQ:        result = {31'b0, a == b};
      ALU_CTRL_BNE:        result = {31'b0, a != b};
      ALU_CTRL_BLT:        result = {31'b0, (a < b) ^ (a[31] != b[31])};
      ALU_CTRL_BGE:        result = {31'b0, (a >= b) ^ (a[31] != b[31])};
      ALU_CTRL_BLTU:       result = {31'b0, a < b};
      ALU_CTRL_BGEU:       result = {31'b0, a >= b};
      default:             result = 32'b0;
    endcase
  end

  assign zero = result == 32'b0;
endmodule
