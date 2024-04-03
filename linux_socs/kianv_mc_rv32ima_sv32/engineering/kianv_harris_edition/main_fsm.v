/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2022/2023/2024 hirosh dabui <hirosh@dabui.de>
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
    output reg                         store_instr,
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
    input  wire [                31:0] fault_address,
    input  wire [                31:0] cpu_mem_addr,
    input  wire                        is_instruction_unaligned,
    input  wire                        is_load_unaligned,
    input  wire                        is_store_unaligned,
    input  wire                        access_fault,
    input  wire                        page_fault,
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
    output reg sret,
    output reg wfi_event,
    output reg selectPC,
    output reg tlb_flush,
    input wire [1:0] privilege_mode,
    input wire csr_access_fault,

    input wire IRQ_TO_CPU_CTRL1,  // SSIP
    input wire IRQ_TO_CPU_CTRL3,  // MSIP
    input wire IRQ_TO_CPU_CTRL5,  // STIP
    input wire IRQ_TO_CPU_CTRL7,  // MTIP

    output reg  mul_ext_valid,
    input  wire mul_ext_ready,
    output reg  is_instruction,
    input  wire stall,

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

  localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9,
               S10 = 10, S11 = 11, S12 = 12, S13 = 13, S14 = 14, S15 = 15, S16 = 16, S17 = 17, S18 = 18, S19 = 19,
               S20 = 20, S21 = 21, S22 = 22, S23 = 23, S24 = 24, S25 = 25, S26 = 26, S27 = 27, S28 = 28, S29 = 29,
               S30 = 30, S31 = 31, S32 = 32, S33 = 33, S34 = 34, S35 = 35, S36 = 36, S37 = 37, S38 = 38, S39 = 39,
               S40 = 40, S41 = 41, S42 = 42, S43 = 43, S44 = 44, S45 = 45, S46 = 46, S47 = 47, S48 = 48, S49 = 49,
               S50 = 50, S51 = 51, S52 = 52, S53 = 53, S54 = 54, S55 = 55, S56 = 56, S57 = 57, S58 = 58, S59 = 59,
               S60 = 60, S61 = 61, S62= 62, S_LAST = 63;

  reg [$clog2(S_LAST) -1:0] state, state_nxt;

  localparam      load    = 7'b 000_0011,
                    store   = 7'b 010_0011,
                    rtype   = 7'b 011_0011,
                    itype   = 7'b 001_0011,
                    jal     = 7'b 110_1111,  // j-type
  jalr = 7'b110_0111,  // implicit i-type
  branch = 7'b110_0011, lui = 7'b011_0111,  // u-type
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
  wire is_fence = `RV32_IS_FENCE(op, funct3);
  wire is_sfence_vma = `RV32_IS_SFENCE_VMA(op, funct3, funct7);
  wire is_fence_i = `RV32_IS_FENCE_I(op, funct3);
  wire is_ebreak = `IS_EBREAK(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_ecall = `IS_ECALL(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_mret = `IS_MRET(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_sret = `IS_SRET(op, funct3, funct7, Rs1, Rs2, Rd);
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

  assign ALUOutWrite = !mem_valid;

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

  always @(posedge clk) begin
    if (!resetn) begin
      state <= S0;
    end else begin
      state <= !stall ? state_nxt : state;
    end
  end

  reg [31:0] trap_addr, trap_addr_nxt;
  always @(posedge clk) begin
    if (!resetn) begin
      trap_addr <= 0;
    end else begin
      trap_addr <= trap_addr_nxt;
    end
  end

  always @(*) begin
    state_nxt = S0;
    is_instruction = 1'b0;
    trap_addr_nxt = trap_addr;

    case (state)
      S0: begin
        // fetch instruction
        trap_addr_nxt  = cpu_mem_addr;
        is_instruction = 1'b1;
        case (1'b1)
          is_instruction_unaligned: state_nxt = S58;
          page_fault: state_nxt = S52;
          mem_ready: state_nxt = access_fault ? S60 : S1;
          default: state_nxt = S0;
        endcase
      end
      S1: begin
        // decode
        case (1'b1)
          (IRQ_TO_CPU_CTRL1 || IRQ_TO_CPU_CTRL3 || IRQ_TO_CPU_CTRL5 || IRQ_TO_CPU_CTRL7):
          state_nxt = S36;
          (is_load || is_store): state_nxt = S2;
          (is_rtype && !funct7b0): state_nxt = S6;
          (is_rtype && funct7b0): state_nxt = S14;
          is_itype: state_nxt = S8;
          is_jal: state_nxt = S9;
          is_jalr: state_nxt = S11;
          is_branch: state_nxt = S10;
          is_lui: state_nxt = S12;
          is_aupic: state_nxt = S13;
          is_csr: state_nxt = S16;
          is_amo: state_nxt = S18;
          is_sfence_vma: state_nxt = S0;
          is_fence: state_nxt = S0;
          is_fence_i: state_nxt = S0;
          is_wfi: state_nxt = S0;
          is_mret: state_nxt = S30;
          is_sret: state_nxt = S50;
          is_ecall: state_nxt = S34;
          is_ebreak: state_nxt = S39;
          default: state_nxt = S40;  // Illegal or no condition met
        endcase
      end
      S2: begin
        // memaddr
        case (1'b1)
          is_load:  state_nxt = S3;
          is_store: state_nxt = S5;
          default:  state_nxt = S2;
        endcase
      end
      S3: begin
        // mem read
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned: state_nxt = S42;
          page_fault: state_nxt = S54;
          mem_ready: state_nxt = access_fault ? S46 : S4;
          default: state_nxt = S3;
        endcase
      end
      S4: begin
        is_instruction = 1'b1;
        state_nxt = S0;
      end  // mem wb
      S5: begin
        // mem store
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned: state_nxt = S44;
          page_fault: state_nxt = S56;
          mem_ready: state_nxt = access_fault ? S48 : S0;
          default: state_nxt = S5;
        endcase
      end
      S6:  state_nxt = S7;  // exec rtype
      S7: begin
        is_instruction = 1'b1;
        state_nxt = S0;
      end  // alu wb
      S8:  state_nxt = S7;  // exec itype
      S9:  state_nxt = S7;  // jal
      S10: begin
        //is_instruction = Zero;
        is_instruction = 1'b1;  //Zero;
        state_nxt = S0;
      end  // branch
      S11: state_nxt = S9;  // jalr
      S12: state_nxt = S7;  // lui
      S13: state_nxt = S7;  // auipc
      S14: state_nxt = mul_ext_ready ? S15 : S14;  // exec multplier
      S15: begin
        is_instruction = 1'b1;
        state_nxt = S0;
      end  // multiplier wb
      S16: state_nxt = csr_access_fault ? S32 : S17;  // exec system/itype
      S17: begin
        is_instruction = 1'b1;
        state_nxt = S0;
      end  // system wb
      S18: begin
        case (1'b1)
          is_amo_lr_w: state_nxt = S19;  // amoloadlr
          is_amo_sc_w: state_nxt = (amo_reserved_state_load ? S21 : S23);
          (is_amoadd_w | is_amoswap_w | is_amoxor_w | is_amoand_w
                     |  is_amoor_w | is_amomin_w | is_amomax_w | is_amominu_w | is_amomaxu_w):
          state_nxt = S24;  // load memaddr
          default: state_nxt = S18;
        endcase
      end
      S19:  // lr.w
            begin
        // mem read
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned: state_nxt = S42;
          page_fault: state_nxt = S54;
          mem_ready: state_nxt = access_fault ? S46 : S20;
          default: state_nxt = S19;
        endcase
      end
      S20: begin
        // lr.w wb
        is_instruction = 1'b1;
        state_nxt = S0;
      end
      S21: begin
        // sc.w mem wr
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned: state_nxt = S44;
          page_fault: state_nxt = S56;
          mem_ready: state_nxt = access_fault ? S48 : S22;
          default: state_nxt = S21;
        endcase
      end
      S22: begin
        // wb rdw = 1'b0
        is_instruction = 1'b1;
        state_nxt = S0;  // !res
      end
      S23: begin
        // wb rd = 1'b1
        is_instruction = 1'b1;
        state_nxt = S0;
      end
      S24:  // amo load
            begin
        // mem read
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned: state_nxt = S42;
          page_fault: state_nxt = S54;
          mem_ready: state_nxt = access_fault ? S46 : S25;
          default: state_nxt = S24;
        endcase
      end

      S25:  // alu wb
      state_nxt = S26;
      S26:  // alu amo exec
      state_nxt = S27;
      S27: state_nxt = S28;  // alu addr amo
      S28:  // mem write
            begin
        // sc.w mem wr
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned: state_nxt = S44;
          page_fault: state_nxt = S56;
          mem_ready: state_nxt = access_fault ? S48 : S0;
          default: state_nxt = S28;
        endcase
      end
      S29: begin
        // wb
        is_instruction = 1'b1;
        state_nxt = S0;
      end
      S30:  // mret
      state_nxt = S31;
      S31:  // mret
      state_nxt = S0;
      S32:  // csr_access_fault
      state_nxt = S33;
      S33:  // csr_access_fault
      state_nxt = S0;
      S34:  // ecall0
      state_nxt = S35;
      S35:  // ecall1
      state_nxt = S0;
      S36:  // irq_0
      state_nxt = S37;
      S37:  // irq_1
      state_nxt = S0;
      S38:  // wfi
      state_nxt = S0;
      S39:  // ebreak0
      state_nxt = S62;
      S40:  // illegal0
      state_nxt = S41;
      S41:  // illegal1
      state_nxt = S0;
      S42:  // unaligned_access_load0
      state_nxt = S43;
      S43:  // unaligned_access_load1
      state_nxt = S0;
      S44:  // unaligned_access_store0
      state_nxt = S45;
      S45:  // unaligned_access_store1
      state_nxt = S0;
      S46:  // load acces fault0
      state_nxt = S47;
      S47:  // load acces fault1
      state_nxt = S0;
      S48:  // store acces fault0
      state_nxt = S49;
      S49:  // store acces fault1
      state_nxt = S0;
      S50:  // sret
      state_nxt = S51;
      S51:  // sret
      state_nxt = S0;
      S52:  // instruction page fault0
      state_nxt = S53;
      S53:  // instructon page fault1
      state_nxt = S0;
      S54:  // load page fault0
      state_nxt = S55;
      S55:  // load page fault1
      state_nxt = S0;
      S56:  // store page fault0
      state_nxt = S57;
      S57:  //store page fault1
      state_nxt = S0;
      S58:  // misaligned instruction0
      state_nxt = S59;
      S59:  // misaligned instruction1
      state_nxt = S0;
      S60:  // access_fault instruction0
      state_nxt = S61;
      S61:  // access_fault instruction1
      state_nxt = S0;
      S62:  // ebreak1
      state_nxt = S0;

      default: state_nxt = S0;
    endcase
  end

  reg [31:0] tmp_cause;
  always @(*) begin
    incr_inst_retired           = 1'b0;
    AdrSrc                      = `ADDR_PC;
    store_instr                 = 1'b0;
    ALUSrcA                     = `SRCA_PC;
    ALUSrcB                     = `SRCB_RD2_BUF;
    ALUOp                       = `ALU_OP_ADD;
    ResultSrc                   = `RESULT_ALUOUT;
    PCUpdate                    = 1'b0;
    Branch                      = 1'b0;
    RegWrite                    = 1'b0;
    MemWrite                    = 1'b0;
    CSRvalid                    = 1'b0;
    select_ALUResult            = 1'b0;

    amo_temp_write_operation    = 1'b0;
    amo_set_reserved_state_load = 1'b0;
    amo_buffered_data           = 1'b0;
    amo_buffered_address        = 1'b0;
    select_amo_temp             = 1'b0;
    muxed_Aluout_or_amo_rd_wr   = 1'b0;

    mem_valid                   = 1'b0;
    mul_ext_valid               = 1'b0;

    exception_event             = 1'b0;
    cause                       = 32'b0;
    tmp_cause                   = 32'b0;
    badaddr                     = 32'b0;
    mret                        = 1'b0;
    sret                        = 1'b0;

    wfi_event                   = 1'b0;
    selectPC                    = 1'b0;
    tlb_flush                   = 1'b0;

    case (state)
      S0: begin
        // fetch
        // Instr <- MEM[PC], PC <- PC + 4, OldPC <- PC
        mem_valid   = 1'b1;

        AdrSrc      = `ADDR_PC;
        store_instr = mem_ready;
        ALUSrcA     = `SRCA_PC;
        ALUSrcB     = `SRCB_CONST_4;
        ALUOp       = `ALU_OP_ADD;
        ResultSrc   = `RESULT_ALURESULT;
        PCUpdate    = mem_ready;
      end
      S1: begin
        // decode
        // ALUOut <- PCTarget (oldPC + imm)
        ALUSrcA = `SRCA_OLD_PC;
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp = `ALU_OP_ADD;
        tlb_flush = is_sfence_vma;
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
        mem_valid = !is_load_unaligned;
        ResultSrc = `RESULT_ALUOUT;
        AdrSrc    = `ADDR_RESULT;
      end
      S4: begin
        // mem wb
        // rd <- Data
        mem_valid = 1'b1;
        ResultSrc = `RESULT_DATA;
        RegWrite = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S5: begin
        // mem write
        // Mem[ALUOUt] <- rd
        //mem_valid = 1'b1;
        mem_valid = !is_store_unaligned;
        ResultSrc = `RESULT_ALUOUT;
        AdrSrc    = `ADDR_RESULT;
        MemWrite  = 1'b1;
        incr_inst_retired = mem_ready || is_store_unaligned;
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
        RegWrite = 1'b1;
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
        ALUSrcA           = `SRCA_RD1_BUF;
        ALUSrcB           = `SRCB_RD2_BUF;
        ALUOp             = `ALU_OP_BRANCH;
        ResultSrc         = `RESULT_ALUOUT;
        Branch            = 1'b1;
        mem_valid         = Zero;
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
        RegWrite = 1'b1;
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
        RegWrite = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S18: begin
        // -> S18 (mem addr)
        // ALUOut <- rs1d + 0
        // fixme: alu reserved
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_CONST_0;
        ALUOp = `ALU_OP_ADD;
        amo_buffered_address = 1'b1;
      end
      S19: begin
        // -> S19 (load)
        // amo mem read LR.w
        // Data <= Mem[ALUOUt]
        amo_set_reserved_state_load = !is_load_unaligned;
        amo_buffered_data = 1'b1;  // set amo_reserved
        mem_valid = !is_load_unaligned;
        ResultSrc = `RESULT_ALUOUT;
        AdrSrc = `ADDR_RESULT;
      end
      S20: begin
        // alu wb
        // rd <- ALUOut
        mem_valid = 1'b1;
        ResultSrc = `RESULT_DATA;
        RegWrite = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S21: begin
        // sc.w amo store sucesseded0
        // mem write
        // Mem[ALUOUt] <- rd2->A2
        amo_set_reserved_state_load = 1'b1; // fixme mem exception revert
        amo_buffered_data = 1'b0; // clr amo_reserved

        mem_valid = !is_store_unaligned;
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
        mem_valid = !is_load_unaligned;
        AdrSrc = `ADDR_RESULT;
        ResultSrc = `RESULT_ALUOUT;
        amo_temp_write_operation = !is_load_unaligned;
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
        mem_valid = !is_store_unaligned;
        incr_inst_retired = mem_ready || is_store_unaligned;
      end
      S29: begin
        mem_valid = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S30: begin  // mret0
        mret = 1'b1;
      end
      S31: begin  // mret1
        PCUpdate = 1'b1;
        // mret = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S32: begin  // csr_access_fault0
        cause = `EXC_ILLEGAL_INSTRUCTION;  // fixme: newer csr.S needs EXC_ECALL_FROM_UMODE
        badaddr = {25'b0, op};
        exception_event = 1'b1;
      end
      S33: begin  // csr_access_fault1
        PCUpdate = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S34: begin  // ecall0
        tmp_cause = `EXC_ECALL_FROM_UMODE;
        cause = {tmp_cause[31:2], privilege_mode};  // + priv in handler
        badaddr = 0;
        exception_event = 1'b1;
      end
      S35: begin  // ecall1
        PCUpdate = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S36: begin  // irq_0
        case (1'b1)
          IRQ_TO_CPU_CTRL1: cause = `INTERRUPT_SUPERVISOR_SOFTWARE;
          IRQ_TO_CPU_CTRL3: cause = `INTERRUPT_MACHINE_SOFTWARE;
          IRQ_TO_CPU_CTRL5: cause = `INTERRUPT_SUPERVISOR_TIMER;
          IRQ_TO_CPU_CTRL7: cause = `INTERRUPT_MACHINE_TIMER;
          default: cause = 0;
        endcase
        badaddr = 0;
        exception_event = 1'b1;
        //      PCUpdate = 1'b1;
      end
      S37: begin  // irq_1
        PCUpdate = 1'b1;
      end
      S38: begin  // irq_1
        wfi_event = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S39: begin  // ebreak
        cause = `EXC_BREAKPOINT;
        badaddr = 0;
        exception_event = 1'b1;
      end
      S40: begin  // illegal
        cause = `EXC_ILLEGAL_INSTRUCTION;  // + priv in handler
        badaddr = {25'b0, op};
        exception_event = 1'b1;
      end
      S41: begin  // illegal
        PCUpdate = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S42: begin  // unaligned_access_load0
        cause           = `EXC_LOAD_AMO_ADDR_MISALIGNED;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S43: begin  // unaligned_access_load1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S44: begin  // unaligned_access_store0
        cause           = `EXC_STORE_AMO_ADDR_MISALIGNED;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S45: begin  // unaligned_access_store1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S46: begin  // load access_fault0
        cause           = `EXC_LOAD_AMO_ACCESS_FAULT;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S47: begin  // load access_fault1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S48: begin  // store access_fault0
        cause           = `EXC_STORE_AMO_ACCESS_FAULT;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S49: begin  // store access_fault1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S50: begin  // sret0
        sret = 1'b1;
      end
      S51: begin  // sret1
        PCUpdate = 1'b1;
        // sret = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S52: begin  // instruction page fault0
        cause           = `EXC_INSTR_PAGE_FAULT;
        badaddr         = fault_address;
        exception_event = 1'b1;
        selectPC        = 1'b1;
      end
      S53: begin  // instruction page fault0
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
        selectPC          = 1'b1;
      end
      S54: begin  // load page fault0
        cause           = `EXC_LOAD_PAGE_FAULT;
        badaddr         = fault_address;
        exception_event = 1'b1;
      end
      S55: begin  // load page fault0
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S56: begin  // store amo page fault0
        cause           = `EXC_STORE_AMO_PAGE_FAULT;
        badaddr         = fault_address;
        exception_event = 1'b1;
      end
      S57: begin  // store amo page fault0
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S58: begin  // unaligned instruction0
        cause           = `EXC_INSTR_ADDR_MISALIGNED;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S59: begin  // unaligned instruction1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S60: begin  // instruction access_fault0
        cause           = `EXC_INSTR_ACCESS_FAULT;
        badaddr         = trap_addr;
        exception_event = 1'b1;
      end
      S61: begin  // instruction access_fault1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end
      S62: begin  // ebreak1
        PCUpdate          = 1'b1;
        incr_inst_retired = 1'b1;
      end

      default: begin
        /* verilator lint_off WIDTH */
        AdrSrc    = 'b0;
        ALUSrcA   = 'b0;
        ALUSrcB   = 'b0;
        ALUOp     = 'b0;
        PCUpdate  = 'b0;
        Branch    = 'b0;
        ResultSrc = `RESULT_ALUOUT;
        RegWrite  = 'b0;
        MemWrite  = 'b0;
        /* verilator lint_on WIDTH */
      end
    endcase
  end
endmodule
