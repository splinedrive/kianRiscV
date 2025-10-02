/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2022/2023/2024/2025 hirosh dabui <hirosh@dabui.de>
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
    input  wire                        mstatus_tvm,
    input  wire                        satp_mode,
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
    output reg icache_flush,
    input wire [1:0] privilege_mode,
    input wire csr_access_fault,
    input wire IRQ_TO_CPU_CTRL1,  // SSIP
    input wire IRQ_TO_CPU_CTRL3,  // MSIP
    input wire IRQ_TO_CPU_CTRL5,  // STIP
    input wire IRQ_TO_CPU_CTRL7,  // MTIP
    input wire IRQ_TO_CPU_CTRL9,  // SEIP
    input wire IRQ_TO_CPU_CTRL11, // MEIP
    output reg  mul_ext_valid,
    input  wire mul_ext_ready,
    output reg  is_instruction,
    input  wire stall,
    input wire mem_ready
);

  // =========================================================================
  // Instruction Opcodes
  // =========================================================================
  localparam load   = 7'b000_0011,
             store  = 7'b010_0011,
             rtype  = 7'b011_0011,
             itype  = 7'b001_0011,
             jal    = 7'b110_1111,
             jalr   = 7'b110_0111,
             branch = 7'b110_0011,
             lui    = 7'b011_0111,
             auipc  = 7'b001_0111,
             amo    = 7'b010_1111;

  // =========================================================================
  // State Definitions
  // =========================================================================
  localparam [5:0]
      // Core instruction flow
      FETCH           = 6'd0,
      DECODE          = 6'd1,

      // Memory operations
      MEM_ADDR        = 6'd2,
      MEM_READ        = 6'd3,
      MEM_WB          = 6'd4,
      MEM_WRITE       = 6'd5,

      // ALU operations
      EXEC_RTYPE      = 6'd6,
      ALU_WB          = 6'd7,
      EXEC_ITYPE      = 6'd8,

      // Control flow
      JAL             = 6'd9,
      BRANCH          = 6'd10,
      JALR            = 6'd11,
      LUI             = 6'd12,
      AUIPC           = 6'd13,

      // Multiply extension
      EXEC_MUL        = 6'd14,
      MUL_WB          = 6'd15,

      // System/CSR
      EXEC_SYSTEM     = 6'd16,
      SYSTEM_WB       = 6'd17,

      // AMO operations
      AMO_ADDR        = 6'd18,
      AMO_LR_READ     = 6'd19,
      AMO_LR_WB       = 6'd20,
      AMO_SC_WRITE    = 6'd21,
      AMO_SC_SUCCESS  = 6'd22,
      AMO_SC_FAIL     = 6'd23,
      AMO_OP_READ     = 6'd24,
      AMO_OP_WB       = 6'd25,
      AMO_OP_EXEC     = 6'd26,
      AMO_OP_ADDR     = 6'd27,
      AMO_OP_WRITE    = 6'd28,
      AMO_COMPLETE    = 6'd29,

      // Privilege operations
      MRET_0          = 6'd30,
      MRET_1          = 6'd31,
      CSR_FAULT_0     = 6'd32,
      CSR_FAULT_1     = 6'd33,
      ECALL_0         = 6'd34,
      ECALL_1         = 6'd35,
      IRQ_0           = 6'd36,
      IRQ_1           = 6'd37,
      WFI             = 6'd38,
      EBREAK_0        = 6'd39,

      // Exception handling
      ILLEGAL_0       = 6'd40,
      ILLEGAL_1       = 6'd41,
      LOAD_MISALIGN_0 = 6'd42,
      LOAD_MISALIGN_1 = 6'd43,
      STORE_MISALIGN_0= 6'd44,
      STORE_MISALIGN_1= 6'd45,
      LOAD_FAULT_0    = 6'd46,
      LOAD_FAULT_1    = 6'd47,
      STORE_FAULT_0   = 6'd48,
      STORE_FAULT_1   = 6'd49,
      SRET_0          = 6'd50,
      SRET_1          = 6'd51,
      IPAGE_FAULT_0   = 6'd52,
      IPAGE_FAULT_1   = 6'd53,
      LPAGE_FAULT_0   = 6'd54,
      LPAGE_FAULT_1   = 6'd55,
      SPAGE_FAULT_0   = 6'd56,
      SPAGE_FAULT_1   = 6'd57,
      INSTR_MISALIGN_0= 6'd58,
      INSTR_MISALIGN_1= 6'd59,
      INSTR_FAULT_0   = 6'd60,
      INSTR_FAULT_1   = 6'd61,
      EBREAK_1        = 6'd62;

  reg [5:0] state, state_nxt;

  // =========================================================================
  // Instruction Decode Helpers
  // =========================================================================
  wire funct7b5 = funct7[5];
  wire funct7b0 = funct7[0];
  wire [4:0] funct5 = funct7[6:2];

  wire is_csr = (op == `CSR_OPCODE) && (funct3 == `CSR_FUNCT3_RW    ||
                                        funct3 == `CSR_FUNCT3_RS || funct3 == `CSR_FUNCT3_RC   ||
                                        funct3 == `CSR_FUNCT3_RWI || funct3 == `CSR_FUNCT3_RSI ||
                                        funct3 == `CSR_FUNCT3_RCI);

  wire is_load   = op == load;
  wire is_store  = op == store;
  wire is_rtype  = op == rtype;
  wire is_itype  = op == itype;
  wire is_jal    = op == jal;
  wire is_jalr   = op == jalr;
  wire is_branch = op == branch;
  wire is_lui    = op == lui;
  wire is_auipc  = op == auipc;
  wire is_amo    = `RV32_IS_AMO_INSTRUCTION(op, funct3);

  wire is_amoadd_w  = `RV32_IS_AMOADD_W(funct5);
  wire is_amoswap_w = `RV32_IS_AMOSWAP_W(funct5);
  wire is_amo_lr_w  = `RV32_IS_LR_W(funct5);
  wire is_amo_sc_w  = `RV32_IS_SC_W(funct5);
  wire is_amoxor_w  = `RV32_IS_AMOXOR_W(funct5);
  wire is_amoand_w  = `RV32_IS_AMOAND_W(funct5);
  wire is_amoor_w   = `RV32_IS_AMOOR_W(funct5);
  wire is_amomin_w  = `RV32_IS_AMOMIN_W(funct5);
  wire is_amomax_w  = `RV32_IS_AMOMAX_W(funct5);
  wire is_amominu_w = `RV32_IS_AMOMINU_W(funct5);
  wire is_amomaxu_w = `RV32_IS_AMOMAXU_W(funct5);

  wire is_fence      = `RV32_IS_FENCE(op, funct3);
  wire is_sfence_vma = `RV32_IS_SFENCE_VMA(op, funct3, funct7);
  wire is_fence_i    = `RV32_IS_FENCE_I(op, funct3);
  wire is_ebreak     = `IS_EBREAK(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_ecall      = `IS_ECALL(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_mret       = `IS_MRET(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_sret       = `IS_SRET(op, funct3, funct7, Rs1, Rs2, Rd);
  wire is_wfi        = `IS_WFI(op, funct3, funct7, Rs1, Rs2, Rd);

  wire is_sfence_vma_legal = `IS_MACHINE(privilege_mode) ||
                             (`IS_SUPERVISOR(privilege_mode) && !mstatus_tvm);
  wire sfence_vma_effective = is_sfence_vma & is_sfence_vma_legal & satp_mode;

  // Interrupt pending signal
  wire irq_pending = IRQ_TO_CPU_CTRL1 | IRQ_TO_CPU_CTRL3 | IRQ_TO_CPU_CTRL5 |
                     IRQ_TO_CPU_CTRL7 | IRQ_TO_CPU_CTRL9 | IRQ_TO_CPU_CTRL11;

  // =========================================================================
  // AMO Operation Decode
  // =========================================================================
  always @* begin
    amo_data_load = is_amo & is_amo_lr_w;
    amo_operation_store = is_amo & is_amo_sc_w;
  end

  always @* begin
    case (1'b1)
      is_amoadd_w  : AMOop = `AMO_OP_ADD_W;
      is_amoswap_w : AMOop = `AMO_OP_SWAP_W;
      is_amo_lr_w  : AMOop = `AMO_OP_LR_W;
      is_amo_sc_w  : AMOop = `AMO_OP_SC_W;
      is_amoxor_w  : AMOop = `AMO_OP_XOR_W;
      is_amoand_w  : AMOop = `AMO_OP_AND_W;
      is_amoor_w   : AMOop = `AMO_OP_OR_W;
      is_amomin_w  : AMOop = `AMO_OP_MIN_W;
      is_amomax_w  : AMOop = `AMO_OP_MAX_W;
      is_amominu_w : AMOop = `AMO_OP_MINU_W;
      is_amomaxu_w : AMOop = `AMO_OP_MAXU_W;
      default      : AMOop = {`AMO_OP_WIDTH{1'bx}};
    endcase
  end

  assign ALUOutWrite = !mem_valid;

  // =========================================================================
  // Immediate Source Selection
  // =========================================================================
  always @(*) begin
    case (1'b1)
      is_rtype                           : ImmSrc = `IMMSRC_RTYPE;
      is_itype | is_jalr | is_load | is_csr : ImmSrc = `IMMSRC_ITYPE;
      is_store                           : ImmSrc = `IMMSRC_STYPE;
      is_branch                          : ImmSrc = `IMMSRC_BTYPE;
      is_lui | is_auipc                  : ImmSrc = `IMMSRC_UTYPE;
      is_jal                             : ImmSrc = `IMMSRC_JTYPE;
      default                            : ImmSrc = 3'bxxx;
    endcase
  end

  // =========================================================================
  // State Register
  // =========================================================================
  always @(posedge clk) begin
    if (!resetn)
      state <= FETCH;
    else
      state <= !stall ? state_nxt : state;
  end

  // =========================================================================
  // Trap Address Register
  // =========================================================================
  reg [31:0] trap_addr, trap_addr_nxt;

  always @(posedge clk) begin
    if (!resetn)
      trap_addr <= 32'b0;
    else
      trap_addr <= trap_addr_nxt;
  end

  // =========================================================================
  // Next State Logic
  // =========================================================================
  always @(*) begin
    state_nxt = FETCH;
    is_instruction = 1'b0;
    trap_addr_nxt = trap_addr;

    case (state)
      FETCH: begin
        trap_addr_nxt = cpu_mem_addr;
        is_instruction = 1'b1;

        case (1'b1)
          is_instruction_unaligned : state_nxt = INSTR_MISALIGN_0;
          page_fault               : state_nxt = IPAGE_FAULT_0;
          mem_ready                : state_nxt = access_fault ? INSTR_FAULT_0 : DECODE;
          default                  : state_nxt = FETCH;
        endcase
      end

      DECODE: begin
        case (1'b1)
          irq_pending              : state_nxt = IRQ_0;
          (is_load || is_store)    : state_nxt = MEM_ADDR;
          (is_rtype && !funct7b0)  : state_nxt = EXEC_RTYPE;
          (is_rtype && funct7b0)   : state_nxt = EXEC_MUL;
          is_itype                 : state_nxt = EXEC_ITYPE;
          is_jal                   : state_nxt = JAL;
          is_jalr                  : state_nxt = JALR;
          is_branch                : state_nxt = BRANCH;
          is_lui                   : state_nxt = LUI;
          is_auipc                 : state_nxt = AUIPC;
          is_csr                   : state_nxt = EXEC_SYSTEM;
          is_amo                   : state_nxt = AMO_ADDR;
          is_sfence_vma            : state_nxt = is_sfence_vma_legal ? FETCH : ILLEGAL_0;
          is_fence                 : state_nxt = FETCH;
          is_fence_i               : state_nxt = FETCH;
          is_wfi                   : state_nxt = FETCH;
          is_mret                  : state_nxt = MRET_0;
          is_sret                  : state_nxt = SRET_0;
          is_ecall                 : state_nxt = ECALL_0;
          is_ebreak                : state_nxt = EBREAK_0;
          default                  : state_nxt = ILLEGAL_0;
        endcase
      end

      MEM_ADDR: begin
        state_nxt = is_load ? MEM_READ : MEM_WRITE;
      end

      MEM_READ: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned : state_nxt = LOAD_MISALIGN_0;
          page_fault        : state_nxt = LPAGE_FAULT_0;
          mem_ready         : state_nxt = access_fault ? LOAD_FAULT_0 : MEM_WB;
          default           : state_nxt = MEM_READ;
        endcase
      end

      MEM_WB: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      MEM_WRITE: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned : state_nxt = STORE_MISALIGN_0;
          page_fault         : state_nxt = SPAGE_FAULT_0;
          mem_ready          : state_nxt = access_fault ? STORE_FAULT_0 : FETCH;
          default            : state_nxt = MEM_WRITE;
        endcase
      end

      EXEC_RTYPE: state_nxt = ALU_WB;

      ALU_WB: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      EXEC_ITYPE: state_nxt = ALU_WB;

      JAL: state_nxt = ALU_WB;

      BRANCH: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      JALR: state_nxt = JAL;

      LUI: state_nxt = ALU_WB;

      AUIPC: state_nxt = ALU_WB;

      EXEC_MUL: state_nxt = mul_ext_ready ? MUL_WB : EXEC_MUL;

      MUL_WB: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      EXEC_SYSTEM: state_nxt = csr_access_fault ? CSR_FAULT_0 : SYSTEM_WB;

      SYSTEM_WB: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      AMO_ADDR: begin
        case (1'b1)
          is_amo_lr_w : state_nxt = AMO_LR_READ;
          is_amo_sc_w : state_nxt = amo_reserved_state_load ? AMO_SC_WRITE : AMO_SC_FAIL;
          (is_amoadd_w | is_amoswap_w | is_amoxor_w | is_amoand_w |
           is_amoor_w | is_amomin_w | is_amomax_w | is_amominu_w | is_amomaxu_w) :
                         state_nxt = AMO_OP_READ;
          default      : state_nxt = AMO_ADDR;
        endcase
      end

      AMO_LR_READ: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned : state_nxt = LOAD_MISALIGN_0;
          page_fault        : state_nxt = LPAGE_FAULT_0;
          mem_ready         : state_nxt = access_fault ? LOAD_FAULT_0 : AMO_LR_WB;
          default           : state_nxt = AMO_LR_READ;
        endcase
      end

      AMO_LR_WB: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      AMO_SC_WRITE: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned : state_nxt = STORE_MISALIGN_0;
          page_fault         : state_nxt = SPAGE_FAULT_0;
          mem_ready          : state_nxt = access_fault ? STORE_FAULT_0 : AMO_SC_SUCCESS;
          default            : state_nxt = AMO_SC_WRITE;
        endcase
      end

      AMO_SC_SUCCESS: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      AMO_SC_FAIL: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      AMO_OP_READ: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_load_unaligned : state_nxt = LOAD_MISALIGN_0;
          page_fault        : state_nxt = LPAGE_FAULT_0;
          mem_ready         : state_nxt = access_fault ? LOAD_FAULT_0 : AMO_OP_WB;
          default           : state_nxt = AMO_OP_READ;
        endcase
      end

      AMO_OP_WB    : state_nxt = AMO_OP_EXEC;
      AMO_OP_EXEC  : state_nxt = AMO_OP_ADDR;
      AMO_OP_ADDR  : state_nxt = AMO_OP_WRITE;

      AMO_OP_WRITE: begin
        trap_addr_nxt = cpu_mem_addr;
        case (1'b1)
          is_store_unaligned : state_nxt = STORE_MISALIGN_0;
          page_fault         : state_nxt = SPAGE_FAULT_0;
          mem_ready          : state_nxt = access_fault ? STORE_FAULT_0 : FETCH;
          default            : state_nxt = AMO_OP_WRITE;
        endcase
      end

      AMO_COMPLETE: begin
        is_instruction = 1'b1;
        state_nxt = FETCH;
      end

      MRET_0 : state_nxt = MRET_1;
      MRET_1 : state_nxt = FETCH;

      CSR_FAULT_0 : state_nxt = CSR_FAULT_1;
      CSR_FAULT_1 : state_nxt = FETCH;

      ECALL_0 : state_nxt = ECALL_1;
      ECALL_1 : state_nxt = FETCH;

      IRQ_0 : state_nxt = IRQ_1;
      IRQ_1 : state_nxt = FETCH;

      WFI : state_nxt = FETCH;

      EBREAK_0 : state_nxt = EBREAK_1;

      ILLEGAL_0 : state_nxt = ILLEGAL_1;
      ILLEGAL_1 : state_nxt = FETCH;

      LOAD_MISALIGN_0  : state_nxt = LOAD_MISALIGN_1;
      LOAD_MISALIGN_1  : state_nxt = FETCH;

      STORE_MISALIGN_0 : state_nxt = STORE_MISALIGN_1;
      STORE_MISALIGN_1 : state_nxt = FETCH;

      LOAD_FAULT_0 : state_nxt = LOAD_FAULT_1;
      LOAD_FAULT_1 : state_nxt = FETCH;

      STORE_FAULT_0 : state_nxt = STORE_FAULT_1;
      STORE_FAULT_1 : state_nxt = FETCH;

      SRET_0 : state_nxt = SRET_1;
      SRET_1 : state_nxt = FETCH;

      IPAGE_FAULT_0 : state_nxt = IPAGE_FAULT_1;
      IPAGE_FAULT_1 : state_nxt = FETCH;

      LPAGE_FAULT_0 : state_nxt = LPAGE_FAULT_1;
      LPAGE_FAULT_1 : state_nxt = FETCH;

      SPAGE_FAULT_0 : state_nxt = SPAGE_FAULT_1;
      SPAGE_FAULT_1 : state_nxt = FETCH;

      INSTR_MISALIGN_0 : state_nxt = INSTR_MISALIGN_1;
      INSTR_MISALIGN_1 : state_nxt = FETCH;

      INSTR_FAULT_0 : state_nxt = INSTR_FAULT_1;
      INSTR_FAULT_1 : state_nxt = FETCH;

      EBREAK_1 : state_nxt = FETCH;

      default: state_nxt = FETCH;
    endcase
  end

  // =========================================================================
  // Output Logic
  // =========================================================================
  reg [31:0] tmp_cause;

  always @(*) begin
    // Default values for all outputs
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
    icache_flush                = 1'b0;

    case (state)
      FETCH: begin
        mem_valid   = 1'b1;
        AdrSrc      = `ADDR_PC;
        store_instr = mem_ready;
        ALUSrcA     = `SRCA_PC;
        ALUSrcB     = `SRCB_CONST_4;
        ALUOp       = `ALU_OP_ADD;
        ResultSrc   = `RESULT_ALURESULT;
        PCUpdate    = mem_ready;
      end

      DECODE: begin
        ALUSrcA      = `SRCA_OLD_PC;
        ALUSrcB      = `SRCB_IMM_EXT;
        ALUOp        = `ALU_OP_ADD;
        tlb_flush    = sfence_vma_effective;
        icache_flush = is_fence_i;
      end

      MEM_ADDR: begin
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp   = `ALU_OP_ADD;
      end

      MEM_READ: begin
        mem_valid = !is_load_unaligned;
        ResultSrc = `RESULT_ALUOUT;
        AdrSrc    = `ADDR_RESULT;

        end

      MEM_WB: begin
        mem_valid             = 1'b1;
        ResultSrc             = `RESULT_DATA;
        RegWrite              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      MEM_WRITE: begin
        mem_valid             = !is_store_unaligned;
        ResultSrc             = `RESULT_ALUOUT;
        AdrSrc                = `ADDR_RESULT;
        MemWrite              = 1'b1;
        incr_inst_retired     = mem_ready || is_store_unaligned;
      end

      EXEC_RTYPE: begin
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_RD2_BUF;
        ALUOp   = `ALU_OP_ARITH_LOGIC;
      end

      ALU_WB: begin
        mem_valid             = 1'b1;
        ResultSrc             = `RESULT_ALUOUT;
        RegWrite              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      EXEC_ITYPE: begin
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp   = `ALU_OP_ARITH_LOGIC;
      end

      JAL: begin
        ALUSrcA               = `SRCA_OLD_PC;
        ALUSrcB               = `SRCB_CONST_4;
        ALUOp                 = `ALU_OP_ADD;
        ResultSrc             = `RESULT_ALUOUT;
        PCUpdate              = 1'b1;
      end

      BRANCH: begin
        ALUSrcA               = `SRCA_RD1_BUF;
        ALUSrcB               = `SRCB_RD2_BUF;
        ALUOp                 = `ALU_OP_BRANCH;
        ResultSrc             = `RESULT_ALUOUT;
        Branch                = 1'b1;
        mem_valid             = Zero;
        incr_inst_retired     = 1'b1;
      end

      JALR: begin
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp   = `ALU_OP_ADD;
      end

      LUI: begin
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp   = `ALU_OP_LUI;
      end

      AUIPC: begin
        ALUSrcA = `SRCA_OLD_PC;
        ALUSrcB = `SRCB_IMM_EXT;
        ALUOp   = `ALU_OP_AUIPC;
      end

      EXEC_MUL: begin
        ALUSrcA               = `SRCA_RD1_BUF;
        ALUSrcB               = `SRCB_RD2_BUF;
        mul_ext_valid         = 1'b1;
      end

      MUL_WB: begin
        mem_valid             = 1'b1;
        ResultSrc             = `RESULT_MULOUT;
        RegWrite              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      EXEC_SYSTEM: begin
        ALUSrcA  = `SRCA_RD1_BUF;
        ALUSrcB  = `SRCB_IMM_EXT;
        CSRvalid = 1'b1;
      end

      SYSTEM_WB: begin
        mem_valid             = 1'b1;
        ResultSrc             = `RESULT_CSROUT;
        RegWrite              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      AMO_ADDR: begin
        ALUSrcA                 = `SRCA_RD1_BUF;
        ALUSrcB                 = `SRCB_CONST_0;
        ALUOp                   = `ALU_OP_ADD;
        amo_buffered_address    = 1'b1;
      end

      AMO_LR_READ: begin
        amo_set_reserved_state_load = !is_load_unaligned;
        amo_buffered_data           = 1'b1;
        mem_valid                   = !is_load_unaligned;
        ResultSrc                   = `RESULT_ALUOUT;
        AdrSrc                      = `ADDR_RESULT;
      end

      AMO_LR_WB: begin
        mem_valid             = 1'b1;
        ResultSrc             = `RESULT_DATA;
        RegWrite              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      AMO_SC_WRITE: begin
        amo_set_reserved_state_load = 1'b1;
        amo_buffered_data           = 1'b0;
        mem_valid                   = !is_store_unaligned;
        ResultSrc                   = `RESULT_AMO_TEMP_ADDR;
        AdrSrc                      = `ADDR_RESULT;
        MemWrite                    = 1'b1;
      end

      AMO_SC_SUCCESS: begin
        amo_buffered_data           = 1'b0;
        muxed_Aluout_or_amo_rd_wr   = 1'b1;
        ResultSrc                   = `RESULT_ALUOUT;
        RegWrite                    = 1'b1;
        mem_valid                   = 1'b1;
        incr_inst_retired           = 1'b1;
      end

      AMO_SC_FAIL: begin
        amo_buffered_data           = 1'b1;
        muxed_Aluout_or_amo_rd_wr   = 1'b1;
        ResultSrc                   = `RESULT_ALUOUT;
        RegWrite                    = 1'b1;
        mem_valid                   = 1'b1;
        incr_inst_retired           = 1'b1;
      end

      AMO_OP_READ: begin
        mem_valid                 = !is_load_unaligned;
        AdrSrc                    = `ADDR_RESULT;
        ResultSrc                 = `RESULT_ALUOUT;
        amo_temp_write_operation  = !is_load_unaligned;
      end

      AMO_OP_WB: begin
        ALUOp     = `ALU_OP_ADD;
        ALUSrcA   = `SRCA_AMO_TEMP_DATA;
        ALUSrcB   = `SRCB_CONST_0;
        ResultSrc = `RESULT_DATA;
        RegWrite  = 1'b1;
      end

      AMO_OP_EXEC: begin
        ALUOp                     = `ALU_OP_AMO;
        ALUSrcA                   = is_amoswap_w ? `SRCA_CONST_0 : `SRCA_AMO_TEMP_DATA;
        ALUSrcB                   = `SRCB_RD2_BUF;
        ResultSrc                 = `RESULT_ALURESULT;
        select_ALUResult          = 1'b1;
        amo_temp_write_operation  = 1'b1;
      end

      AMO_OP_ADDR: begin
        ALUSrcA = `SRCA_RD1_BUF;
        ALUSrcB = `SRCB_CONST_0;
        ALUOp   = `ALU_OP_ADD;
      end

      AMO_OP_WRITE: begin
        MemWrite              = 1'b1;
        select_amo_temp       = 1'b1;
        ResultSrc             = `RESULT_AMO_TEMP_ADDR;
        AdrSrc                = `ADDR_RESULT;
        mem_valid             = !is_store_unaligned;
        incr_inst_retired     = mem_ready || is_store_unaligned;
      end

      AMO_COMPLETE: begin
        mem_valid             = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      MRET_0: begin
        mret = 1'b1;
      end

      MRET_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      CSR_FAULT_0: begin
        cause                 = `EXC_ILLEGAL_INSTRUCTION;
        badaddr               = {25'b0, op};
        exception_event       = 1'b1;
      end

      CSR_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      ECALL_0: begin
        tmp_cause             = `EXC_ECALL_FROM_UMODE;
        cause                 = {tmp_cause[31:2], privilege_mode};
        badaddr               = 32'b0;
        exception_event       = 1'b1;
      end

      ECALL_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      IRQ_0: begin
        case (1'b1)
          IRQ_TO_CPU_CTRL1  : cause = `INTERRUPT_SUPERVISOR_SOFTWARE;
          IRQ_TO_CPU_CTRL3  : cause = `INTERRUPT_MACHINE_SOFTWARE;
          IRQ_TO_CPU_CTRL5  : cause = `INTERRUPT_SUPERVISOR_TIMER;
          IRQ_TO_CPU_CTRL7  : cause = `INTERRUPT_MACHINE_TIMER;
          IRQ_TO_CPU_CTRL9  : cause = `INTERRUPT_SUPERVISOR_EXTERNAL;
          IRQ_TO_CPU_CTRL11 : cause = `INTERRUPT_MACHINE_EXTERNAL;
          default           : cause = 32'b0;
        endcase
        badaddr               = 32'b0;
        exception_event       = 1'b1;
      end

      IRQ_1: begin
        PCUpdate = 1'b1;
      end

      WFI: begin
        wfi_event             = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      EBREAK_0: begin
        cause                 = `EXC_BREAKPOINT;
        badaddr               = 32'b0;
        exception_event       = 1'b1;
      end

      ILLEGAL_0: begin
        cause                 = `EXC_ILLEGAL_INSTRUCTION;
        badaddr               = {25'b0, op};
        exception_event       = 1'b1;
      end

      ILLEGAL_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      LOAD_MISALIGN_0: begin
        cause                 = `EXC_LOAD_AMO_ADDR_MISALIGNED;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      LOAD_MISALIGN_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      STORE_MISALIGN_0: begin
        cause                 = `EXC_STORE_AMO_ADDR_MISALIGNED;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      STORE_MISALIGN_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      LOAD_FAULT_0: begin
        cause                 = `EXC_LOAD_AMO_ACCESS_FAULT;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      LOAD_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      STORE_FAULT_0: begin
        cause                 = `EXC_STORE_AMO_ACCESS_FAULT;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      STORE_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      SRET_0: begin
        sret = 1'b1;
      end

      SRET_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      IPAGE_FAULT_0: begin
        cause                 = `EXC_INSTR_PAGE_FAULT;
        badaddr               = fault_address;
        exception_event       = 1'b1;
        selectPC              = 1'b1;
      end

      IPAGE_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
        selectPC              = 1'b1;
      end

      LPAGE_FAULT_0: begin
        cause                 = `EXC_LOAD_PAGE_FAULT;
        badaddr               = fault_address;
        exception_event       = 1'b1;
      end

      LPAGE_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      SPAGE_FAULT_0: begin
        cause                 = `EXC_STORE_AMO_PAGE_FAULT;
        badaddr               = fault_address;
        exception_event       = 1'b1;
      end

      SPAGE_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      INSTR_MISALIGN_0: begin
        cause                 = `EXC_INSTR_ADDR_MISALIGNED;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      INSTR_MISALIGN_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      INSTR_FAULT_0: begin
        cause                 = `EXC_INSTR_ACCESS_FAULT;
        badaddr               = trap_addr;
        exception_event       = 1'b1;
      end

      INSTR_FAULT_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      EBREAK_1: begin
        PCUpdate              = 1'b1;
        incr_inst_retired     = 1'b1;
      end

      default: begin
        AdrSrc    = 1'b0;
        ALUSrcA   = {`SRCA_WIDTH{1'b0}};
        ALUSrcB   = {`SRCB_WIDTH{1'b0}};
        ALUOp     = {`ALU_OP_WIDTH{1'b0}};
        PCUpdate  = 1'b0;
        Branch    = 1'b0;
        ResultSrc = `RESULT_ALUOUT;
        RegWrite  = 1'b0;
        MemWrite  = 1'b0;
      end
    endcase
  end

endmodule
