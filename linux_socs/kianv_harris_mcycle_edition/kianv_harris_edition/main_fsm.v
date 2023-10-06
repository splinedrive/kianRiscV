/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2022/2023 hirosh dabui <hirosh@dabui.de>
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
`include "riscv_defines.vh"

module main_fsm (
        input  wire                        clk,
        input  wire                        resetn,
        input  wire [                 6:0] op,
        input  wire [                 6:0] funct7,
        input  wire [                 2:0] funct3,
        input  wire [                 4:0] Rs1,
        input  wire [                 4:0] Rs2,
        input  wire [                 4:0] Rd,
        input  wire                        Zero,
        output reg                         AdrSrc,
        output reg                         fetched_instr,
        output reg                         incr_inst_retired,
        output reg  [`SRCA_WIDTH     -1:0] ALUSrcA,
        output reg  [`SRCB_WIDTH     -1:0] ALUSrcB,
        output reg  [`ALU_OP_WIDTH   -1:0] ALUOp,
        output reg  [`AMO_OP_WIDTH   -1:0] AMOop,
        output reg  [`RESULT_WIDTH   -1:0] ResultSrc,
        output reg  [                 2:0] ImmSrc,
        output reg                         CSRvalid,
        output reg                         PCUpdate,
        output reg                         Branch,
        output reg                         RegWrite,
        output reg                         MemWrite,
        input wire                         unaligned_access_load,
        input wire                         unaligned_access_store,
        input wire                         access_fault,
        output wire                        ALUOutWrite,
        output reg                         mem_valid,
        output reg                         amo_temp_write_operation,
        // AMO
        output reg                         amo_data_load,
        output reg                         amo_operation_store,
        output reg                         muxed_Aluout_or_amo_rd_wr,
        output reg                         amo_set_reserved_state_load,
        output reg                         amo_buffered_data,
        output reg                         amo_buffered_address,
        output reg                         select_ALUResult,
        output reg                         select_amo_temp,
        input  wire                        amo_reserved_state_load,

        // Exception Handler
        output reg exception_event,
        output reg [31:0] cause,
        output reg [31:0] badaddr,
        output reg mret,
        output reg wfi_event,
        input wire [1:0] privilege_mode,
        input wire csr_access_fault,
        input wire [31:0] mie,
        input wire [31:0] mip,
        input wire [31:0] mstatus,

        output reg  mul_ext_valid,
        input  wire mul_ext_ready,

        input wire mem_ready
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
    //
    // amo stuff
    // amo memaddr
    // amoLoadLR
    // -> S18 (mem addr)
    // -> S19 (load)
    // -> S20 (LoadLR wb)
    // amoStoreSC
    // -> S18 (mem addr) if r; S21; e; S23
    // -> S21 (store) -> S22 -> S0
    // -> S23 -> S0 -> S0

    // amo op: S0 (is amo)
    // amo
    // tmp = mem[rs1d]
    // mem[rs1d] = tmp & rs2d;
    // rd = tmp
    // -> S18 (mem addr)
    // -> S24 (amo load)
    // -> S25 (wb)
    // -> S26 (alu exec amo)
    // -> S27 (mem addr)
    // -> S28 (mem write)
    // -> s29 -> s0
    wire funct7b5 = funct7[5];  // r-type
    wire funct7b0 = funct7[0];  // r-type
    wire [4:0] funct5 = funct7[6:2];

    localparam    S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5,
                  S6 = 6, S7 = 7, S8 = 8, S9 = 9, S10 = 10, S11 = 11,
                  S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16, S17 = 17,
                  S18 = 18, S19 = 19, S20 = 20, S21 = 21, S22 = 22, S23 = 23,
                  S24 = 24, S25 = 25, S26 = 26, S27 = 27, S28 = 28, S29 = 29,
                  S30 = 30, S31 = 31, S32 = 32, S33 = 33, S34 = 34, S35 = 35, S36 = 36,
                  S37 = 37, S38 = 38, S39 = 39, S40 = 40, S41 = 41, S42 = 42, S43 = 43,
                  S44 = 44, S45 = 45, S46 = 46, S47 = 47, S48 = 48, S49 = 49, S_LAST = 50; // fixme

    reg [$clog2(S_LAST) -1:0] state, next_state;

    localparam      load    = 7'b 000_0011,
                    store   = 7'b 010_0011,
                    rtype   = 7'b 011_0011,
                    itype   = 7'b 001_0011,
                    jal     = 7'b 110_1111,  // j-type
                    jalr = 7'b110_0111,  // implicit i-type
                    branch = 7'b110_0011,
                    lui = 7'b011_0111,  // u-type
                    aupic = 7'b001_0111,  // u-type
                    amo = 7'b010_1111;

    // Determine if the instruction is a CSR type using assign statement
    wire is_csr = (op == `CSR_OPCODE) && (funct3 == `CSR_FUNCT3_RW    ||
                                          funct3 == `CSR_FUNCT3_RS || funct3 == `CSR_FUNCT3_RC   ||
                                          funct3 == `CSR_FUNCT3_RWI || funct3 == `CSR_FUNCT3_RSI ||
                                          funct3 == `CSR_FUNCT3_RCI /* && funct7 == 0 */);

    wire is_load = op == load;
    wire is_store = op == store;
    wire is_rtype = op == rtype;
    wire is_itype = op == itype;
    wire is_jal = op == jal;
    wire is_jalr = op == jalr;
    wire is_branch = op == branch;
    wire is_lui = op == lui;
    wire is_aupic = op == aupic;
    wire is_amo = `RV32_IS_AMO_INSTRUCTION(op, funct3);
    wire is_amoadd_w = `RV32_IS_AMOADD_W(funct5);
    wire is_amoswap_w = `RV32_IS_AMOSWAP_W(funct5);
    wire is_amo_lr_w = `RV32_IS_LR_W(funct5);
    wire is_amo_sc_w = `RV32_IS_SC_W(funct5);
    wire is_amoxor_w = `RV32_IS_AMOXOR_W(funct5);
    wire is_amoand_w = `RV32_IS_AMOAND_W(funct5);
    wire is_amoor_w = `RV32_IS_AMOOR_W(funct5);
    wire is_amomin_w = `RV32_IS_AMOMIN_W(funct5);
    wire is_amomax_w = `RV32_IS_AMOMAX_W(funct5);
    wire is_amominu_w = `RV32_IS_AMOMINU_W(funct5);
    wire is_amomaxu_w = `RV32_IS_AMOMAXU_W(funct5);
    wire is_fence = `RV32_IS_FENCE(op);
    wire is_ebreak = `IS_EBREAK(op, funct3, funct7, Rs1, Rs2, Rd);
    wire is_ecall = `IS_ECALL(op, funct3, funct7, Rs1, Rs2, Rd);
    wire is_mret = `IS_MRET(op, funct3, funct7, Rs1, Rs2, Rd);
    wire is_wfi = `IS_WFI(op, funct3, funct7, Rs1, Rs2, Rd);

    // ===========================================================================

    // amo
    always @* begin
        amo_data_load = is_amo & is_amo_lr_w;
        amo_operation_store = is_amo & is_amo_sc_w;
    end

    always @* begin
        case (1'b1)
            is_amoadd_w  :AMOop = `AMO_OP_ADD_W;
            is_amoswap_w :AMOop = `AMO_OP_SWAP_W;
            is_amo_lr_w  :AMOop = `AMO_OP_LR_W;
            is_amo_sc_w  :AMOop = `AMO_OP_SC_W;
            is_amoxor_w  :AMOop = `AMO_OP_XOR_W;
            is_amoand_w  :AMOop = `AMO_OP_AND_W;
            is_amoor_w   :AMOop = `AMO_OP_OR_W;
            is_amomin_w  :AMOop = `AMO_OP_MIN_W;
            is_amomax_w  :AMOop = `AMO_OP_MAX_W;
            is_amominu_w :AMOop = `AMO_OP_MINU_W;
            is_amomaxu_w :AMOop = `AMO_OP_MAXU_W;
            default:
                /* verilator lint_off WIDTH */
                AMOop = 'hx;
            /* verilator lint_on WIDTH */
        endcase
    end


    assign ALUOutWrite             = !mem_valid;

    always @(*) begin
        case (1'b1)
            is_rtype:                              ImmSrc = `IMMSRC_RTYPE;
            is_itype | is_jalr | is_load | is_csr: ImmSrc = `IMMSRC_ITYPE;
            is_store:                              ImmSrc = `IMMSRC_STYPE;
            is_branch:                             ImmSrc = `IMMSRC_BTYPE;
            is_lui | is_aupic:                     ImmSrc = `IMMSRC_UTYPE;
            is_jal:                                ImmSrc = `IMMSRC_JTYPE;
            default:                               ImmSrc = 3'bxxx;
        endcase
    end

    always @(posedge clk) state <= !resetn ? S0 : next_state;

    /* verilator lint_off WIDTHEXPAND */
    /* verilator lint_off WIDTHTRUNC */
    wire mtip_raised = `GET_MSTATUS_MIE(mstatus) & `GET_MIP_MTIP(mip) & `GET_MIE_MTIP(mie);
    wire msip_raised = `GET_MSTATUS_MIE(mstatus) & `GET_MIP_MSIP(mip) & `GET_MIE_MSIP(mie);
    /* verilator lint_on WIDTHTRUNC */
    /* verilator lint_on WIDTHEXPAND */

    always @(*) begin
        next_state = S0;
        case (state)
            S0:  next_state = mem_ready ? S1 : S0;  // fetch
            S1:  // decode
            begin
                if (mtip_raised || msip_raised) next_state = S36; //interrupt
                else if (is_load || is_store) next_state = S2;
                else if (is_rtype && !funct7b0) next_state = S6;  // reg op reg in common alu
                else if (is_rtype && funct7b0) next_state = S14;  // reg op reg in mul/div
                else if (is_itype) next_state = S8;
                else if (is_jal) next_state = S9;
                else if (is_jalr) next_state = S11;
                else if (is_branch) next_state = S10;
                else if (is_lui) next_state = S12;
                else if (is_aupic) next_state = S13;
                else if (is_csr) next_state = S16;
                else if (is_amo) next_state = S18;
                else if (is_fence) next_state = S0;  // fixme
                else if (is_wfi) next_state = S0;//S38; // fixme
                else if (is_mret) next_state = S30; /* fixme exception != machine mode */
                else if (is_ecall) next_state = S34;
                else if (is_ebreak) next_state = S39; // fixme;
                else next_state = S40; // illegal;
            end
            S2:  // memaddr
            begin
                if (is_load) next_state  = access_fault ? S46 : (unaligned_access_load  ? S42 : S3);
                if (is_store) next_state = access_fault  ? S48 : (unaligned_access_store ? S44 : S5);
            end
            S3:  next_state = mem_ready ? S4 : S3;  // memread
            S4:  next_state = S0;  // mem wb
            S5:  next_state = mem_ready ? S0 : S5;  // mem write
            S6:  next_state = S7;  // exec rtype
            S7:  next_state = S0;  // alu wb
            S8:  next_state = S7;  // exec itype
            S9:  next_state = S7;  // jal
            S10: next_state = S0;  // branch
            S11: next_state = S9;  // jalr
            S12: next_state = S7;  // lui
            S13: next_state = S7;  // auipc
            S14: next_state = mul_ext_ready ? S15 : S14;  // exec multplier
            S15: next_state = S0;  // multiplier wb
            S16: next_state = csr_access_fault ? S32 : S17;  // exec system/itype
            S17: next_state = S0;  // system wb

            S18: begin
                if (is_amo_lr_w) begin
                    next_state = access_fault ? S46 : (unaligned_access_load ? S42 : S19);  // amoloadlr
                end
                if (is_amo_sc_w) begin
                    next_state = access_fault ? S48 : (unaligned_access_store ? S44 : (amo_reserved_state_load ? S21 : S23));
                end
                if (is_amoadd_w | is_amoswap_w | is_amoxor_w | is_amoand_w
                        | | is_amoor_w | is_amomin_w | is_amomax_w | is_amominu_w | is_amomaxu_w) begin
                    next_state = access_fault ? S46 : (unaligned_access_load ? S42 : S24);  // load memaddr
                end
            end

            S19:  // lr.w
                next_state = mem_ready ? S20 : S19;
            S20:  // lr.w wb
                next_state = S0;
            S21: next_state = mem_ready ? S22 : S21;  // sc.w mem wr
            S22:  // wb rdw = 1'b0
                next_state = S0;  // !res
            S23:  // wb rd = 1'b1
                next_state = S0;

            S24:  // amo load
                next_state = mem_ready ? S25 : S24;
            S25:  // alu wb
                next_state = S26;
            S26:  // alu amo exec
                next_state = S27;
            S27: next_state = unaligned_access_store ? S42 : S28;  // alu addr amo
            S28:  // mem write
                next_state = mem_ready ? S0 : S28;
            S29:  // wb
                next_state = S0;
            S30: // mret
                next_state = S31;
            S31: // mret
                next_state = S0;
            S32: // csr_access_fault
                next_state = S33;
            S33: // csr_access_fault
                next_state = S0;
            S34: // ecall0
                next_state = S35;
            S35: // ecall1
                next_state = S0;
            S36: // irq_0
                next_state = S37;
            S37: // irq_1
                next_state = S0;
            S38: // wfi
                next_state = S0;
            S39: // ebreak
                next_state = S39;
            S40: // illegal0
                next_state = S41;
            S41: // illegal1
                next_state = S0;
            S42: // unaligned_access_load0
                next_state = S43;
            S43: // unaligned_access_load1
                next_state = S0;
            S44: // unaligned_access_store0
                next_state = S45;
            S45: // unaligned_access_store1
                next_state = S0;
            S46: // load acces fault0
                next_state = S47;
            S47: // load acces fault1
                next_state = S0;
            S48: // store acces fault0
                next_state = S49;
            S49: // store acces fault1
                next_state = S0;

            default: next_state = S0;
        endcase
    end

    always @(*) begin
        incr_inst_retired          = 1'b0;
        AdrSrc                      = `ADDR_PC;
        fetched_instr               =  1'b0;
        ALUSrcA                     = `SRCA_PC;
        ALUSrcB                     = `SRCB_RD2_BUF;
        ALUOp                       = `ALU_OP_ADD;
        ResultSrc                   = `RESULT_ALUOUT;
        PCUpdate                    = 1'b0;
        Branch                      = 1'b0;
        RegWrite                    = 1'b0;
        MemWrite                    = 1'b0;
        CSRvalid                    = 1'b0;
        select_ALUResult                    = 1'b0;

        amo_temp_write_operation               = 1'b0;
        amo_set_reserved_state_load = 1'b0;
        amo_buffered_data       = 1'b0;
        amo_buffered_address       = 1'b0;
        select_amo_temp                  = 1'b0;
        muxed_Aluout_or_amo_rd_wr     = 1'b0;

        mem_valid                   = 1'b0;
        mul_ext_valid               = 1'b0;

        exception_event = 1'b0;
        cause = 32'b0;
        badaddr = 32'b0;
        mret = 1'b0;

        wfi_event = 1'b0;

        case (state)
            S0: begin
                // fetch
                // Instr <- MEM[PC], PC <- PC + 4, OldPC <- PC
                mem_valid  = 1'b1;

                AdrSrc     = `ADDR_PC;
                fetched_instr  = mem_ready; // fixme for interrupt we haven't to count
                ALUSrcA    = `SRCA_PC;
                ALUSrcB    = `SRCB_CONST_4;
                ALUOp      = `ALU_OP_ADD;
                ResultSrc  = `RESULT_ALURESULT;
                PCUpdate   = mem_ready;
            end
            S1: begin
                // decode
                // ALUOut <- PCTarget (oldPC + imm)
                ALUSrcA = `SRCA_OLD_PC;
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_ADD;
            end
            S2: begin
                // mem addr
                // ALUOut <- rs1 + imm
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_ADD;
            end
            S3: begin
                // mem read
                // Data <- Mem[ALUOUt]
                mem_valid = 1'b 1;
                ResultSrc = `RESULT_ALUOUT;
                AdrSrc    = `ADDR_RESULT;
            end
            S4: begin
                // mem wb
                // rd <- Data
                mem_valid = 1'b1;
                ResultSrc = `RESULT_DATA;
                RegWrite  = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S5: begin
                // mem write
                // Mem[ALUOUt] <- rd
                mem_valid = 1'b 1;
                ResultSrc = `RESULT_ALUOUT;
                AdrSrc    = `ADDR_RESULT;
                MemWrite  = 1'b1;
                incr_inst_retired = mem_ready;
            end
            S6: begin
                // execute rtype
                // ALUOut <- rs1 op rs2
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_RD2_BUF;
                ALUOp   = `ALU_OP_ARITH_LOGIC;
            end
            S7: begin
                // alu wb
                // rd <- ALUOut
                mem_valid = 1'b1;
                ResultSrc = `RESULT_ALUOUT;
                RegWrite  = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S8: begin
                // execute itype
                // ALUOut <- rs1 op imm
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_ARITH_LOGIC;
            end
            S9: begin
                // jal
                // PC <- ALUOut , rd<- OldPC + 4;
                ALUSrcA   = `SRCA_OLD_PC;
                ALUSrcB   = `SRCB_CONST_4;
                ALUOp     = `ALU_OP_ADD;
                ResultSrc = `RESULT_ALUOUT;
                PCUpdate  = 1'b1;
            end
            S10: begin
                // branch
                // rd <- rs1 - rs2,
                // if zero, PC <- ALUOut, else PC <- PC
                ALUSrcA   = `SRCA_RD1_BUF;
                ALUSrcB   = `SRCB_RD2_BUF;
                ALUOp     = `ALU_OP_BRANCH;
                ResultSrc = `RESULT_ALUOUT;
                Branch    = 1'b1;
                mem_valid = Zero;
                incr_inst_retired = 1'b1;
            end
            S11: begin
                // jalr itype
                // ALUOut <- rs1 + imm
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_ADD;
            end
            S12: begin
                // lui utype
                // ALUOut <- 0 + imm<<12
                // ignore PC in ALU
                // not used: ALUSrcA   =
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_LUI;  // 0 + imm<<12
            end
            S13: begin
                // aupic utype
                // ALUOut <- PC + imm<<12
                ALUSrcA = `SRCA_OLD_PC;
                ALUSrcB = `SRCB_IMM_EXT;
                ALUOp   = `ALU_OP_AUIPC;  // pc + imm<<12
            end
            S14: begin
                // execute rtype
                // MULOut <- rs1 op rs2
                ALUSrcA       = `SRCA_RD1_BUF;
                ALUSrcB       = `SRCB_RD2_BUF;
                mul_ext_valid = 1'b1;  // todo ALU_OP
            end
            S15: begin
                // multiplier wb
                // rd <- MULOut
                mem_valid = 1'b1;
                ResultSrc = `RESULT_MULOUT;
                RegWrite  = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S16: begin
                // execute itype
                // CSRData
                ALUSrcA  = `SRCA_RD1_BUF;
                ALUSrcB  = `SRCB_IMM_EXT;
                CSRvalid = 1'b1;
            end
            S17: begin
                // system wb
                // rd <- RESULT_CSR
                mem_valid = 1'b1;
                ResultSrc = `RESULT_CSROUT;
                RegWrite  = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S18: begin
                // -> S18 (mem addr)
                // ALUOut <- rs1d + 0
                // fixme: alu reserved
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_CONST_0;
                ALUOp   = `ALU_OP_ADD;
                amo_buffered_address = 1'b1;
            end
            S19: begin
                // -> S19 (load)
                // amo mem read LR.w
                // Data <= Mem[ALUOUt]
                amo_set_reserved_state_load = 1'b1;  // fixme mem exception revert
                amo_buffered_data = 1'b1;  // set amo_reserved
                mem_valid = 1'b1;
                ResultSrc = `RESULT_ALUOUT;
                AdrSrc = `ADDR_RESULT;
            end
            S20: begin
                // alu wb
                // rd <- ALUOut
                mem_valid = 1'b1;
                ResultSrc = `RESULT_DATA;
                RegWrite  = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S21: begin
                // sc.w amo store sucesseded0
                // mem write
                // Mem[ALUOUt] <- rd2->A2
                amo_set_reserved_state_load = 1'b1; // fixme mem exception revert
                amo_buffered_data = 1'b0; // clr amo_reserved

                mem_valid = 1'b1;
                ResultSrc = `RESULT_AMO_TEMP_ADDR;
                AdrSrc    = `ADDR_RESULT;
                MemWrite  = 1'b1;
            end
            S22: begin
                // sc.w rdw = 1'b0 sucesseded1
                amo_buffered_data = 1'b0;  // clr amo_reserved
                muxed_Aluout_or_amo_rd_wr = 1'b1;
                ResultSrc = `RESULT_ALUOUT;
                RegWrite = 1'b1;
                mem_valid = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S23: begin
                // sc.w rdw = 1'b1 failed
                amo_buffered_data = 1'b1;  // clr amo_reserved
                muxed_Aluout_or_amo_rd_wr = 1'b1;
                ResultSrc = `RESULT_ALUOUT;
                RegWrite = 1'b1;
                mem_valid = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S24: begin
                // (amo load)
                mem_valid = 1'b1;
                AdrSrc = `ADDR_RESULT;
                ResultSrc = `RESULT_ALUOUT;
                amo_temp_write_operation = 1'b1;
            end
            S25: begin
                // amo wb
                ALUOp = `ALU_OP_ADD;
                ALUSrcA = `SRCA_AMO_TEMP_DATA;
                ALUSrcB = `SRCB_CONST_0;
                ResultSrc = `RESULT_DATA;
                RegWrite = 1'b1;
            end
            S26: begin
                // alu exec amo
                ALUOp = `ALU_OP_AMO;
                ALUSrcA = is_amoswap_w ? `SRCA_CONST_0 : `SRCA_AMO_TEMP_DATA;
                ALUSrcB = `SRCB_RD2_BUF;
                ResultSrc = `RESULT_ALURESULT;
                select_ALUResult = 1'b1;
                amo_temp_write_operation = 1'b1;
            end
            S27: begin
                // mem addr
                ALUSrcA = `SRCA_RD1_BUF;
                ALUSrcB = `SRCB_CONST_0;
                ALUOp   = `ALU_OP_ADD;
            end
            S28: begin
                // mem write
                MemWrite = 1'b1;
                select_amo_temp = 1'b1;
                ResultSrc = `RESULT_AMO_TEMP_ADDR;
                AdrSrc    = `ADDR_RESULT;
                mem_valid = 1'b1;
                incr_inst_retired = mem_ready;
            end
            S29: begin
                mem_valid = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S30: begin // mret0
                mret = 1'b1;
            end
            S31: begin // mret1
                PCUpdate = 1'b1;
                // mret = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S32: begin // csr_access_fault0
                cause = `EXC_ILLEGAL_INSTRUCTION; // fixme: newer csr.S needs EXC_ECALL_FROM_UMODE
                badaddr = {25'b0, op};
                exception_event = 1'b1;
            end
            S33: begin // csr_access_fault1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S34: begin // ecall0
                cause = `EXC_ECALL_FROM_UMODE; // + priv in handler
                cause = {cause[31:2], privilege_mode};
                badaddr = 0;
                exception_event = 1'b1;
            end
            S35: begin // ecall1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S36: begin // irq_0
                cause = mtip_raised ? `INTERRUPT_MACHINE_TIMER : `INTERRUPT_MACHINE_SOFTWARE; // + priv in handler
                badaddr = 0;
                exception_event = 1'b1;
                //      PCUpdate = 1'b1;
            end
            S37: begin // irq_1
                PCUpdate = 1'b1;
            end
            S38: begin // irq_1
                wfi_event = 1'b1;
                incr_inst_retired = 1'b1;
            end
            S39: begin // ebreak
            end
            S40: begin // illegal
                cause = `EXC_ILLEGAL_INSTRUCTION; // + priv in handler
                badaddr = ~0; // pc
                exception_event = 1'b1;
            end
            S41: begin // illegal
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end

            S42: begin // unaligned_access_load0
                cause = `EXC_LOAD_AMO_ADDR_MISALIGNED;
                badaddr = ~0; // pc
                exception_event = 1'b1;
            end
            S43: begin // unaligned_access_load1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end

            S44: begin // unaligned_access_store0
                cause = `EXC_STORE_AMO_ADDR_MISALIGNED;
                badaddr = ~0; // pc
                exception_event = 1'b1;
            end
            S45: begin // unaligned_access_store1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end

            S46: begin // load access_fault0
                cause = `EXC_LOAD_AMO_ACCESS_FAULT;
                badaddr = ~0; // pc
                exception_event = 1'b1;
            end
            S47: begin // load access_fault1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end

            S48: begin // store access_fault0
                cause = `EXC_STORE_AMO_ACCESS_FAULT;
                badaddr = ~0; // pc
                exception_event = 1'b1;
            end
            S49: begin // store access_fault1
                PCUpdate = 1'b1;
                incr_inst_retired = 1'b1;
            end

            default: begin
                /* verilator lint_off WIDTH */
                AdrSrc     = 'b0;
                ALUSrcA    = 'b0;
                ALUSrcB    = 'b0;
                ALUOp      = 'b0;
                PCUpdate   = 'b0;
                Branch     = 'b0;
                ResultSrc  = `RESULT_ALUOUT;
                RegWrite   = 'b0;
                MemWrite   = 'b0;
                /* verilator lint_on WIDTH */
            end
        endcase
    end
endmodule
