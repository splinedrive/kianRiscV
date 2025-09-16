/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2022/23/24 hirosh dabui <hirosh@dabui.de>
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

module control_unit (
    input  wire                        clk,
    input  wire                        resetn,
    input  wire [                 6:0] op,
    input  wire [                 2:0] funct3,
    input  wire [                 6:0] funct7,
    input  wire [                 0:0] immb10,
    input  wire                        Zero,
    input  wire [                 4:0] Rs1,
    input  wire [                 4:0] Rs2,
    input  wire [                 4:0] Rd,
    output wire [`RESULT_WIDTH   -1:0] ResultSrc,
    output wire [`ALU_CTRL_WIDTH -1:0] ALUControl,
    output wire [`SRCA_WIDTH     -1:0] ALUSrcA,
    output wire [`SRCB_WIDTH     -1:0] ALUSrcB,
    output wire [                 2:0] ImmSrc,
    output wire [`STORE_OP_WIDTH -1:0] STOREop,
    output wire [`LOAD_OP_WIDTH  -1:0] LOADop,
    output wire [`MUL_OP_WIDTH   -1:0] MULop,
    output wire [`DIV_OP_WIDTH   -1:0] DIVop,
    output wire [`CSR_OP_WIDTH   -1:0] CSRop,
    output wire                        CSRwe,
    output wire                        CSRre,
    output wire                        RegWrite,
    output wire                        PCWrite,
    output wire                        AdrSrc,
    output wire                        MemWrite,
    input  wire                        access_fault,
    input  wire                        page_fault,
    input  wire                        mstatus_tvm,
    input  wire                        satp_mode,
    output wire                        store_instr,
    output wire                        incr_inst_retired,
    output wire                        ALUOutWrite,
    output wire                        amo_temp_write_operation,
    output wire                        muxed_Aluout_or_amo_rd_wr,
    output wire                        amo_set_reserved_state_load,
    output wire                        amo_buffered_data,
    output wire                        amo_buffered_address,
    input  wire                        amo_reserved_state_load,
    output wire                        select_ALUResult,
    output wire                        select_amo_temp,

    // Exception Handler
    output wire        exception_event,
    output wire [31:0] cause,
    output wire [31:0] badaddr,
    output wire        mret,
    output wire        sret,
    output wire        wfi_event,
    input  wire [ 1:0] privilege_mode,
    input  wire        csr_access_fault,
    input  wire [31:0] fault_address,
    output wire        selectPC,
    output wire        tlb_flush,
    output wire        icache_flush,

    input wire IRQ_TO_CPU_CTRL1,  // SSIP
    input wire IRQ_TO_CPU_CTRL3,  // MSIP
    input wire IRQ_TO_CPU_CTRL5,  // STIP
    input wire IRQ_TO_CPU_CTRL7,  // MTIP
    input wire IRQ_TO_CPU_CTRL9,  // SEIP
    input wire IRQ_TO_CPU_CTRL11, // MEIP

    output wire is_instruction,
    input  wire stall,

    output wire mem_valid,
    input wire mem_ready,
    input wire [31:0] cpu_mem_addr,

    output wire mul_valid,
    input  wire mul_ready,

    output wire div_valid,
    input  wire div_ready
);

  wire [`ALU_OP_WIDTH   -1:0] ALUOp;
  wire [`AMO_OP_WIDTH   -1:0] AMOop;
  wire PCUpdate;
  wire Branch;
  wire mul_ext_ready;
  wire mul_ext_valid;

  wire taken_branch = !Zero;
  assign PCWrite = Branch & taken_branch | PCUpdate;

  assign mul_ext_ready = mul_ready | div_ready;

  wire amo_data_load;
  wire amo_operation_store;
  wire is_load_unaligned;
  wire is_store_unaligned;
  wire is_instruction_unaligned;
  assign is_instruction_unaligned = |cpu_mem_addr[1:0];

  wire CSRvalid;
  main_fsm main_fsm_I (
      .clk              (clk),
      .resetn           (resetn),
      .op               (op),
      .funct7           (funct7),
      .funct3           (funct3),
      .Rs1              (Rs1),
      .Rs2              (Rs2),
      .Rd               (Rd),
      .Zero             (Zero),
      .mstatus_tvm      (mstatus_tvm),
      .satp_mode        (satp_mode),
      .AdrSrc           (AdrSrc),
      .is_instruction   (is_instruction),
      .stall            (stall),
      .store_instr      (store_instr),
      .incr_inst_retired(incr_inst_retired),
      .ALUSrcA          (ALUSrcA),
      .ALUSrcB          (ALUSrcB),
      .ALUOp            (ALUOp),
      .AMOop            (AMOop),
      .ResultSrc        (ResultSrc),
      .ImmSrc           (ImmSrc),
      .CSRvalid         (CSRvalid),
      .PCUpdate         (PCUpdate),
      .Branch           (Branch),
      .RegWrite         (RegWrite),
      .ALUOutWrite      (ALUOutWrite),
      .fault_address    (fault_address),
      .cpu_mem_addr     (cpu_mem_addr),

      .amo_temp_write_operation   (amo_temp_write_operation),
      .amo_data_load              (amo_data_load),
      .amo_operation_store        (amo_operation_store),
      .muxed_Aluout_or_amo_rd_wr  (muxed_Aluout_or_amo_rd_wr),
      .amo_set_reserved_state_load(amo_set_reserved_state_load),
      .amo_buffered_data          (amo_buffered_data),
      .amo_buffered_address       (amo_buffered_address),
      .amo_reserved_state_load    (amo_reserved_state_load),
      .select_ALUResult           (select_ALUResult),
      .select_amo_temp            (select_amo_temp),
      .MemWrite                   (MemWrite),
      .is_instruction_unaligned   (is_instruction_unaligned),
      .is_load_unaligned          (is_load_unaligned),
      .is_store_unaligned         (is_store_unaligned),
      .access_fault               (access_fault),
      .page_fault                 (page_fault),
      .selectPC                   (selectPC),
      .tlb_flush                  (tlb_flush),
      .icache_flush               (icache_flush),

      .exception_event (exception_event),
      .cause           (cause),
      .badaddr         (badaddr),
      .mret            (mret),
      .sret            (sret),
      .wfi_event       (wfi_event),
      .privilege_mode  (privilege_mode),
      .csr_access_fault(csr_access_fault),

      .IRQ_TO_CPU_CTRL1 (IRQ_TO_CPU_CTRL1),  // SSIP
      .IRQ_TO_CPU_CTRL3 (IRQ_TO_CPU_CTRL3),  // MSIP
      .IRQ_TO_CPU_CTRL5 (IRQ_TO_CPU_CTRL5),  // STIP
      .IRQ_TO_CPU_CTRL7 (IRQ_TO_CPU_CTRL7),  // MTIP
      .IRQ_TO_CPU_CTRL9 (IRQ_TO_CPU_CTRL9),  // SEIP
      .IRQ_TO_CPU_CTRL11(IRQ_TO_CPU_CTRL11), // MEIP

      .mem_valid(mem_valid),
      .mem_ready(mem_ready),

      .mul_ext_valid(mul_ext_valid),
      .mul_ext_ready(mul_ext_ready)
  );


  load_decoder load_decoder_I (
      .funct3           (funct3),
      .amo_data_load    (amo_data_load),
      .LOADop           (LOADop),
      .addr_align_bits  (cpu_mem_addr[1:0]),
      .is_load_unaligned(is_load_unaligned)
  );

  store_decoder store_decoder_I (
      .funct3             (funct3),
      .amo_operation_store(amo_operation_store),
      .STOREop            (STOREop),
      .addr_align_bits    (cpu_mem_addr[1:0]),
      .is_store_unaligned (is_store_unaligned)
  );


  csr_decoder csr_decoder_I (
      .funct3(funct3),
      .Rs1Uimm(Rs1),
      .Rd(Rd),
      .valid(CSRvalid),
      .CSRwe(CSRwe),
      .CSRre(CSRre),
      .CSRop(CSRop)
  );

  alu_decoder alu_decoder_I (
      .imm_bit10 (immb10),
      .op_bit5   (op[5]),
      .funct3    (funct3),
      .funct7b5  (funct7[5]),
      .ALUOp     (ALUOp),
      .AMOop     (AMOop),
      .ALUControl(ALUControl)
  );

  multiplier_extension_decoder multiplier_extension_decoder_I (
      .funct3       (funct3),
      .MULop        (MULop),
      .DIVop        (DIVop),
      .mul_ext_valid(mul_ext_valid),
      .mul_valid    (mul_valid),
      .div_valid    (div_valid)
  );

endmodule
