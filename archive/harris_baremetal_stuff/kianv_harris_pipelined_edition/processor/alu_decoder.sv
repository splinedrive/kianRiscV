/*
 *  kianv 5-staged pipelined RISC-V
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

module alu_decoder (
    input  wire logic         imm_bit10,
    input  wire               op_bit5,
    input  wire logic   [2:0] funct3D,
    input  wire logic         funct7bit5D,
    input  wire AluOp_t       AluOp,
    output AluControl_t       AluControlD
);

  logic is_rtype_sub;
  logic is_srl_srli;

  assign is_rtype_sub = op_bit5 & funct7bit5D;
  assign is_srl_srli  = (op_bit5 && !funct7bit5D) || (!op_bit5 && !imm_bit10);

  always_comb begin
    case (AluOp)
      ALU_OP_ADD:   AluControlD = ALU_CTRL_ADD_ADDI;
      ALU_OP_SUB:   AluControlD = ALU_CTRL_SUB;
      ALU_OP_AUIPC: AluControlD = ALU_CTRL_AUIPC;
      ALU_OP_LUI:   AluControlD = ALU_CTRL_LUI;
      ALU_OP_BRANCH: begin
        case (funct3D)
          3'b000: AluControlD = ALU_CTRL_BEQ;
          3'b001: AluControlD = ALU_CTRL_BNE;
          3'b100: AluControlD = ALU_CTRL_BLT;
          3'b101: AluControlD = ALU_CTRL_BGE;
          3'b110: AluControlD = ALU_CTRL_BLTU;
          3'b111: AluControlD = ALU_CTRL_BGEU;
          default: begin
            /* verilator lint_off WIDTH */
            //AluControlD = 'hx;
            AluControlD = ALU_CTRL_ADD_ADDI;
            /* verilator lint_on WIDTH */
          end
        endcase
      end
      ALU_OP_ARITH_LOGIC: begin
        case (funct3D)
          3'b000: AluControlD = AluControl_t'(is_rtype_sub ? ALU_CTRL_SUB : ALU_CTRL_ADD_ADDI);
          3'b100: AluControlD = ALU_CTRL_XOR_XORI;
          3'b110: AluControlD = ALU_CTRL_OR_ORI;
          3'b111: AluControlD = ALU_CTRL_AND_ANDI;
          3'b010: AluControlD = ALU_CTRL_SLT_SLTI;
          3'b001: AluControlD = ALU_CTRL_SLL_SLLI;
          3'b011: AluControlD = ALU_CTRL_SLTU_SLTIU;
          3'b101: AluControlD = AluControl_t'(is_srl_srli ? ALU_CTRL_SRL_SRLI : ALU_CTRL_SRA_SRAI);
          default: begin
            /* verilator lint_off WIDTH */
            AluControlD = ALU_CTRL_ADD_ADDI;
            //  AluControlD = AluControl_t'('hx);
            /* verilator lint_on WIDTH */
          end
        endcase
      end
      default: begin
        /* verilator lint_off WIDTH */
        //AluControlD = 'hx;
        AluControlD = ALU_CTRL_ADD_ADDI;
        /* verilator lint_on WIDTH */
      end
    endcase
  end

endmodule
