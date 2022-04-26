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

    wire is_beq                  = alucontrol == `ALU_CTRL_BEQ;
    wire is_bne                  = alucontrol == `ALU_CTRL_BNE;
    wire is_blt                  = alucontrol == `ALU_CTRL_BLT;
    wire is_bge                  = alucontrol == `ALU_CTRL_BGE;
    wire is_bltu                 = alucontrol == `ALU_CTRL_BLTU;
    wire is_bgeu                 = alucontrol == `ALU_CTRL_BGEU;
    wire is_slt_slti             = alucontrol == `ALU_CTRL_SLT_SLTI;
    wire is_sltu_sltiu           = alucontrol == `ALU_CTRL_SLTU_SLTIU;
    wire is_sum_zero;

    wire is_sub = alucontrol ==
         `ALU_CTRL_SUB || is_beq || is_bne || is_blt || is_bge
         || is_bltu || is_bgeu || is_slt_slti || is_sltu_sltiu;

    wire [31:0] condinv = is_sub ? ~b : b;
    // using a single 33 bits for LU, LTU got from Bruno's Levy (learn-fpga)
    wire [32:0] sum     = {1'b1, condinv} + {1'b0,a} + {32'b 0, is_sub};
    wire        LT      = (a[31] ^ b[31]) ? a[31] : sum[32];
    wire        LTU     = sum[32];

    wire [31:0] sltx_sltux_rslt  = {31'b0, is_slt_slti ? LT : LTU};

    wire [63:0] sext_rs1         = {{32{a[31]}}, a};
    wire [63:0] sra_srai_rslt    = sext_rs1 >> b[4:0];
    assign is_sum_zero           = sum[31: 0] == 32'b 0;


    always @(*) begin
        case (alucontrol)
            `ALU_CTRL_ADD_ADDI              : result = a + b;
            `ALU_CTRL_SUB                   : result = a - b;
            `ALU_CTRL_XOR_XORI              : result = a ^ b;
            `ALU_CTRL_OR_ORI                : result = a | b;
            `ALU_CTRL_AND_ANDI              : result = a & b;
            `ALU_CTRL_SLL_SLLI              : result = a << b[4:0];
            `ALU_CTRL_SRL_SRLI              : result = a >> b[4:0];
            `ALU_CTRL_SRA_SRAI              : result = sra_srai_rslt[31:0];
            `ALU_CTRL_LUI                   : result = b;
            `ALU_CTRL_AUIPC                 : result = sum[31: 0];
            default:
            case (1'b 1)
                is_beq                      : result = {31'b 0,  is_sum_zero  };
                is_bne                      : result = {31'b 0, !is_sum_zero  };
                is_blt                      : result = {31'b 0,  LT           };
                is_bge                      : result = {31'b 0, !LT           };
                is_bltu                     : result = {31'b 0,  LTU          };
                is_bgeu                     : result = {31'b 0, !LTU          };
                is_slt_slti | is_sltu_sltiu : result = sltx_sltux_rslt;
                default:
                    result = 32'b 0;
            endcase
        endcase
    end

    assign zero        = result     == 32'b 0;
endmodule
