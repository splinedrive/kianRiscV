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
`timescale 1 ns/100 ps
`default_nettype none
`include "riscv_defines.vh"

module alu(
        input wire [                 31: 0] a, b,
        input wire [ `ALU_CTRL_WIDTH -1: 0] alucontrol,
        output reg [                 31: 0] result,
        output wire zero
    );

    wire [31:0] sltx_sltux_rslt  = {31'b0, a < b};

    wire [63:0] sext_rs1         = {{32{a[31]}}, a};
    wire [63:0] sra_srai_rslt    = sext_rs1 >> b[4:0];

    wire is_sub                  = alucontrol == `ALU_CTRL_SUB;

    wire [31:0] condinv = is_sub ? ~b : b;
    wire [31:0] sum     = a + (condinv + {30'b0, is_sub});

    always @(*) begin
        case (alucontrol)
            `ALU_CTRL_ADD_ADDI   : result = sum;
            `ALU_CTRL_SUB        : result = sum;
            `ALU_CTRL_XOR_XORI   : result = a ^ b;
            `ALU_CTRL_OR_ORI     : result = a | b;
            `ALU_CTRL_AND_ANDI   : result = a & b;
            `ALU_CTRL_SLL_SLLI   : result = a << b[4:0];
            `ALU_CTRL_SRL_SRLI   : result = a >> b[4:0];
            `ALU_CTRL_SRA_SRAI   : result = sra_srai_rslt[31:0];
            `ALU_CTRL_SLT_SLTI   : result = (a[31] == b[31]) ? sltx_sltux_rslt : {31'b0, a[31]};
            `ALU_CTRL_SLTU_SLTIU : result = sltx_sltux_rslt;
            `ALU_CTRL_LUI        : result = b;
            `ALU_CTRL_AUIPC      : result = sum;
            `ALU_CTRL_BEQ        : result = {31'b 0, a == b};
            `ALU_CTRL_BNE        : result = {31'b 0, a != b};
            `ALU_CTRL_BLT        : result = {31'b 0, (a  < b) ^ (a[31] != b[31])};
            `ALU_CTRL_BGE        : result = {31'b 0, (a >= b) ^ (a[31] != b[31])};
            `ALU_CTRL_BLTU       : result = {31'b 0, a  < b};
            `ALU_CTRL_BGEU       : result = {31'b 0, a >= b};
            default:
                result = 32'b 0;
        endcase
    end

    assign zero = result == 32'b 0;
endmodule
