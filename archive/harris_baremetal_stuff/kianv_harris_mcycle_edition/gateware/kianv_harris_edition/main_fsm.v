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
`timescale 1 ns/100 ps
`include "riscv_defines.vh"

module main_fsm(
        input  wire clk,
        input  wire resetn,
        input  wire [ 6: 0] op,
        input  wire [ 0: 0] funct7b1,
        input  wire Zero,
        output reg AdrSrc,
        output reg IRWrite,
        output reg  [`SRCA_WIDTH     -1: 0] ALUSrcA,
        output reg  [`SRCB_WIDTH     -1: 0] ALUSrcB,
        output reg  [`ALU_OP_WIDTH   -1: 0] ALUOp,
        output reg  [`RESULT_WIDTH   -1: 0] ResultSrc,
        output reg  [                 2: 0] ImmSrc,
        output reg  PCUpdate,
        output reg  Branch,
        output reg  RegWrite,
        output reg  MemWrite,
        output wire ALUOutWrite,
        output reg  mem_valid,

        output reg  alu_valid,
        input  wire alu_ready,

        output reg  mul_ext_valid,
        input  wire mul_ext_ready,

        input  wire mem_ready
    );
    // S0  --> Fetch
    // S1  --> Decode
    // S2  --> MemAddr
    // S3  --> MemRead
    // S4  --> MemWb
    // S5  --> MemWrite
    // S6  --> ExecuteR
    // S7  --> AluWB
    // S8  --> ExecuteI
    // S9  --> J-TYPE
    // S10 --> B-TYPE
    // S11 --> JALR
    // S12 --> LUI
    // S13 --> AUPIC
    // S14 --> ExecuteMul
    // S15 --> MulWB
    // S16 --> ExecuteSystem
    // S17 --> SystemWB

    localparam  S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5,
                S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10, S11 = 11,
                S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16, S17 = 17,
                S_LAST = 18;

    reg [$clog2(S_LAST) -1:0] state, next_state;

    localparam      load    = 'b 000_0011,
                    store   = 'b 010_0011,
                    rtype   = 'b 011_0011,
                    itype   = 'b 001_0011,
                    jal     = 'b 110_1111,  // j-type
                    jalr    = 'b 110_0111,  // implicit i-type
                    branch  = 'b 110_0011,
                    lui     = 'b 011_0111,  // u-type
                    aupic   = 'b 001_0111,  // u-type
                    system  = 'b 111_0011;  // privileged/CSR/implicit i-type

    wire is_load    = op == load;
    wire is_store   = op == store;
    wire is_rtype   = op == rtype;
    wire is_itype   = op == itype;
    wire is_jal     = op == jal;
    wire is_jalr    = op == jalr;
    wire is_branch  = op == branch;
    wire is_lui     = op == lui;
    wire is_aupic   = op == aupic;
`ifdef CSR
    wire is_system  = op == system;
`else
    wire is_system  = 1'b 0;
`endif

    assign ALUOutWrite = !mem_valid;

    always @(*)
    begin
        case (1'b 1)
            is_rtype                                    :  ImmSrc = `IMMSRC_RTYPE;
            is_itype | is_jalr | is_load | is_system    :  ImmSrc = `IMMSRC_ITYPE;
            is_store                                    :  ImmSrc = `IMMSRC_STYPE;
            is_branch                                   :  ImmSrc = `IMMSRC_BTYPE;
            is_lui | is_aupic                           :  ImmSrc = `IMMSRC_UTYPE;
            is_jal                                      :  ImmSrc = `IMMSRC_JTYPE;
            default:
                ImmSrc = 3'b xxx;
        endcase
    end

    always @(posedge clk) state <= !resetn ? S0 : next_state;

    always @(*)
    begin
        next_state = S0;
        case (state)
`ifndef CYCLE_BASED_SHIFTER
            S0: next_state = mem_ready ? S1 : S0;  // fetch
`else
            S0: next_state = alu_ready ? S1 : S0;  // fetch
`endif
            S1:  // decode
            begin
                if (alu_ready) begin
                    if (is_load  |  is_store  ) next_state = S2;
                    if (is_rtype & !funct7b1  ) next_state = S6;  // reg op reg in common alu
`ifdef RV32M
                    if (is_rtype &  funct7b1  ) next_state = S14; // reg op reg in mul/div
`endif
                    if (is_itype              ) next_state = S8;
                    if (is_jal                ) next_state = S9;
                    if (is_jalr               ) next_state = S11;
                    if (is_branch             ) next_state = S10;
                    if (is_lui                ) next_state = S12;
                    if (is_aupic              ) next_state = S13;
                    if (is_aupic              ) next_state = S13;
`ifdef CSR
                    if (is_system             ) next_state = S16;
`endif
                end else begin
                    next_state = S1;
                end
            end
            S2:  // memaddr
            begin
                if (alu_ready) begin
                    if (is_load            ) next_state = S3;
                    if (is_store           ) next_state = S5;
                end else begin
                    next_state = S1;
                end
            end
            S3:   next_state = mem_ready ? S4 : S3;   // memread
            S4:   next_state = S0;                    // mem wb
            S5:   next_state = mem_ready ? S0 : S5;   // mem write
            S6:   next_state = alu_ready ? S7 : S6;   // exec rtype
            S7:   next_state = S0;                    // alu wb
            S8:   next_state = alu_ready ? S7 : S8;   // exec itype
            S9:   next_state = alu_ready ? S7 : S9;   // jal
            S10:  next_state = alu_ready ? S0 : S10;  // branch
            S11:  next_state = alu_ready ? S9 : S11;  // jalr
            S12:  next_state = alu_ready ? S7 : S12;  // lui
            S13:  next_state = alu_ready ? S7 : S13;  // auipc
`ifdef RV32M
            S14:  next_state = mul_ext_ready ? S15 : S14; // exec multplier
            S15:  next_state = S0;                        // multiplier wb
`endif
`ifdef CSR
            S16:  next_state = alu_ready ? S17 : S16;  // exec system/itype
`endif
            S17:  next_state = S0;                     // system wb
            default:
                next_state = S0;
        endcase
    end

    always @(*) begin
        AdrSrc    = 1'b 0;
        IRWrite   = 1'b 0;
        ALUSrcA   = `SRCA_PC;
        ALUSrcB   = `SRCB_RD2_BUF;
        ALUOp     = `ALU_OP_ADD;
        ResultSrc = 'b 00;
        PCUpdate  = 1'b 0;
        Branch    = 1'b 0;
        RegWrite  = 1'b 0;
        MemWrite  = 1'b 0;

        mem_valid = 1'b 0;
        alu_valid = 1'b 0;
        mul_ext_valid = 1'b 0;

        case (state)
            S0  : begin
                // fetch
                // Instr <- MEM[PC], PC <- PC + 4, OldPC <- PC
                mem_valid     = 1'b 1;

                AdrSrc        = `ADDR_PC;
                IRWrite       = mem_ready;
                ALUSrcA       = `SRCA_PC;
                ALUSrcB       = `SRCB_CONST_4;
                ALUOp         = `ALU_OP_ADD;
                ResultSrc     = `RESULT_ALURESULT;
                alu_valid     = mem_ready;
                PCUpdate      = alu_ready;
            end
            S1  : begin
                // decode
                // ALUOut <- PCTarget (oldPC + imm)
                ALUSrcA   = `SRCA_OLD_PC;
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_ADD;
                alu_valid = 1'b 1;
            end
            S2  : begin
                // mem addr
                // ALUOut <- rs1 + imm
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_ADD;
                alu_valid = 1'b 1;
            end
            S3  : begin
                // mem read
                // Data <- Mem[ALUOUt]
                mem_valid = 1'b 1;
                ResultSrc = 'b 00;
                AdrSrc    = `ADDR_RESULT;
            end
            S4  : begin
                // mem wb
                // rd <- Data
                mem_valid     = 1'b 1;
                ResultSrc = `RESULT_DATA;
                RegWrite  = 1'b 1;
            end
            S5  : begin
                // mem write
                // Mem[ALUOUt] <- rd
                mem_valid = 1'b 1;
                ResultSrc = `RESULT_ALUOUT;
                AdrSrc    = `ADDR_RESULT;
                MemWrite  = 1'b 1;
            end
            S6  : begin
                // execute rtype
                // ALUOut <- rs1 op rs2
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_RD2_BUF;
                ALUOp     = `ALU_OP_ARITH_LOGIC;
                alu_valid = 1'b 1;
            end
            S7  : begin
                // alu wb
                // rd <- ALUOut
                mem_valid     = 1'b 1;
                ResultSrc = `RESULT_ALUOUT;
                RegWrite  = 1'b 1;
            end
            S8  : begin
                // execute itype
                // ALUOut <- rs1 op imm
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_ARITH_LOGIC;
                alu_valid = 1'b 1;
            end
            S9  : begin
                // jal
                // PC <- ALUOut , rd<- OldPC + 4;
                ALUSrcA   = `SRCA_OLD_PC;
                ALUSrcB   = `SRCB_CONST_4;
                ALUOp     = `ALU_OP_ADD;
                ResultSrc = `RESULT_ALUOUT;
                PCUpdate  = 1'b 1;
                alu_valid = 1'b 1;
            end
            S10 : begin
                // branch
                // rd <- rs1 - rs2,
                // if zero, PC <- ALUOut, else PC <- PC
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_RD2_BUF;
                ALUOp     = `ALU_OP_BRANCH;
                ResultSrc = `RESULT_ALUOUT;
                Branch    = 1'b 1;
                alu_valid = 1'b 1;
                mem_valid = Zero;
            end
            S11  : begin
                // jalr itype
                // ALUOut <- rs1 + imm
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_ADD;
                alu_valid = 1'b 1;
            end
            S12  : begin
                // lui utype
                // ALUOut <- 0 + imm<<12
                // ignore PC in ALU
                // not used: ALUSrcA   =
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_LUI; // 0 + imm<<12
                alu_valid = 1'b 1;
            end
            S13  : begin
                // aupic utype
                // ALUOut <- PC + imm<<12
                ALUSrcA   = `SRCA_OLD_PC;
                ALUSrcB   = `SRCB_IMM_EXT;
                ALUOp     = `ALU_OP_AUIPC; // pc + imm<<12
                alu_valid = 1'b 1;
            end
`ifdef RV32M
            S14  : begin
                // execute rtype
                // MULOut <- rs1 op rs2
                ALUSrcA       = `SRCA_RD1_BUF;
                ALUSrcB       = `SRCB_RD2_BUF;
                mul_ext_valid = 1'b 1;  // todo ALU_OP
            end
            S15  : begin
                // multiplier wb
                // rd <- MULOut
                mem_valid     = 1'b 1;
                ResultSrc = `RESULT_MULOUT;
                RegWrite  = 1'b 1;
            end
`endif
`ifdef CSR
            S16  : begin
                // execute itype
                // CSRData
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_IMM_EXT;
                alu_valid = 1'b 1;
            end
            S17  : begin
                // system wb
                // rd <- RESULT_CSR
                mem_valid     = 1'b 1;
                ResultSrc = `RESULT_CSROUT;
                RegWrite  = 1'b 1;
            end
`endif
            default: begin
                /* verilator lint_off WIDTH */
                AdrSrc    = 'b 0;
                IRWrite   = 'b 0;
                ALUSrcA   = 'b 0;
                ALUSrcB   = 'b 0;
                ALUOp     = 'b 0;
                ResultSrc = 'b 0;
                PCUpdate  = 'b 0;
                Branch    = 'b 0;
                RegWrite  = 'b 0;
                MemWrite  = 'b 0;
                alu_valid = 1'b 0;
                /* verilator lint_on WIDTH */
            end
        endcase
    end
endmodule
