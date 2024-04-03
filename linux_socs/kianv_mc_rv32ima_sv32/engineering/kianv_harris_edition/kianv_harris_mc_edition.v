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
module kianv_harris_mc_edition #(
    parameter RESET_ADDR = 0,
    parameter SYSTEM_CLK = 50_000_000,
    parameter NUM_ENTRIES_PER_TLB = 64
) (
    input  wire        clk,
    input  wire        resetn,
    output wire        mem_valid,
    input  wire        mem_ready,
    output wire [ 3:0] mem_wstrb,
    output wire [33:0] mem_addr,
    output wire [31:0] mem_wdata,
    input  wire [31:0] mem_rdata,
    output wire [31:0] PC,
    input  wire        access_fault,
    input  wire        IRQ1,
    input  wire        IRQ5,
    input  wire        IRQ3,
    input  wire        IRQ7,
    output wire [63:0] timer_counter,
    output wire        is_instruction
);

  wire [                 31:0] Instr;
  wire [                  6:0] op;
  wire [                  2:0] funct3;
  wire [                  6:0] funct7;
  wire [                  0:0] immb10;

  wire                         Zero;

  wire [`RESULT_WIDTH    -1:0] ResultSrc;
  wire [`ALU_CTRL_WIDTH  -1:0] ALUControl;
  wire [`SRCA_WIDTH      -1:0] ALUSrcA;
  wire [`SRCB_WIDTH      -1:0] ALUSrcB;
  wire [                  2:0] ImmSrc;
  wire [`STORE_OP_WIDTH  -1:0] STOREop;
  wire [`LOAD_OP_WIDTH   -1:0] LOADop;
  wire [`MUL_OP_WIDTH    -1:0] MULop;
  wire [`DIV_OP_WIDTH    -1:0] DIVop;
  wire [`CSR_OP_WIDTH    -1:0] CSRop;
  wire                         CSRwe;
  wire                         CSRre;
  wire [                  4:0] Rs1;
  wire [                  4:0] Rs2;
  wire [                  4:0] Rd;

  wire                         RegWrite;
  wire                         PCWrite;
  wire                         AdrSrc;
  wire                         MemWrite;
  wire                         store_instr;
  wire                         incr_inst_retired;
  wire                         ALUOutWrite;

  wire                         mul_valid;
  wire                         mul_ready;
  wire                         div_valid;
  wire                         div_ready;

  assign op     = Instr[6:0];
  assign funct3 = Instr[14:12];
  assign funct7 = Instr[31:25];
  assign Rs1    = Instr[19:15];
  assign Rs2    = Instr[24:20];
  assign Rd     = Instr[11:7];

  wire        amo_temp_write_operation;
  wire        amo_set_reserved_state_load;
  wire        amo_buffered_data;
  wire        amo_buffered_address;
  wire        amo_reserved_state_load;
  wire        muxed_Aluout_or_amo_rd_wr;
  wire        select_ALUResult;
  wire        select_amo_temp;

  // Exception Handler
  wire        exception_event;
  wire [31:0] cause;
  wire [31:0] badaddr;
  wire        mret;
  wire        sret;
  wire        wfi_event;
  wire        csr_access_fault;
  wire [31:0] mstatus;

  wire        IRQ_TO_CPU_CTRL1;
  wire        IRQ_TO_CPU_CTRL5;
  wire        IRQ_TO_CPU_CTRL3;
  wire        IRQ_TO_CPU_CTRL7;

  wire        page_fault;
  wire        selectPC;
  wire        tlb_flush;
  wire        tlb_flush_csr;
  wire [31:0] satp;
  wire [ 1:0] privilege_mode;

  wire        cpu_mem_ready;
  wire        cpu_mem_valid;

  wire [ 3:0] cpu_mem_wstrb;
  wire [31:0] cpu_mem_addr;
  wire [31:0] cpu_mem_wdata;
  wire [31:0] cpu_mem_rdata;
  wire [31:0] sv32_fault_address;

  wire [ 1:0] addr_align_bits;

  wire        stall;

  control_unit control_unit_I (
      .clk              (clk),
      .resetn           (resetn),
      .op               (op),
      .funct3           (funct3),
      .funct7           (funct7),
      .immb10           (immb10),
      .Zero             (Zero),
      .Rs1              (Rs1),
      .Rs2              (Rs2),
      .Rd               (Rd),
      .ResultSrc        (ResultSrc),
      .ALUControl       (ALUControl),
      .ALUSrcA          (ALUSrcA),
      .ALUSrcB          (ALUSrcB),
      .ImmSrc           (ImmSrc),
      .STOREop          (STOREop),
      .LOADop           (LOADop),
      .CSRop            (CSRop),
      .CSRwe            (CSRwe),
      .CSRre            (CSRre),
      .RegWrite         (RegWrite),
      .PCWrite          (PCWrite),
      .AdrSrc           (AdrSrc),
      .fault_address    (sv32_fault_address),
      .MemWrite         (MemWrite),
      .store_instr      (store_instr),
      .is_instruction   (is_instruction),
      .stall            (stall),
      .incr_inst_retired(incr_inst_retired),
      .ALUOutWrite      (ALUOutWrite),
      .mem_valid        (cpu_mem_valid),
      .mem_ready        (cpu_mem_ready),
      .cpu_mem_addr     (cpu_mem_addr),
      .MULop            (MULop),
      .access_fault     (access_fault),
      .page_fault       (page_fault),
      .selectPC         (selectPC),
      .tlb_flush        (tlb_flush),

      .mul_valid                  (mul_valid),
      .mul_ready                  (mul_ready),
      .DIVop                      (DIVop),
      .div_valid                  (div_valid),
      .div_ready                  (div_ready),
      // AMO
      .amo_temp_write_operation   (amo_temp_write_operation),
      .amo_set_reserved_state_load(amo_set_reserved_state_load),
      .amo_buffered_data          (amo_buffered_data),
      .amo_buffered_address       (amo_buffered_address),
      .amo_reserved_state_load    (amo_reserved_state_load),
      .muxed_Aluout_or_amo_rd_wr  (muxed_Aluout_or_amo_rd_wr),
      .select_ALUResult           (select_ALUResult),
      .select_amo_temp            (select_amo_temp),

      .exception_event (exception_event),
      .cause           (cause),
      .badaddr         (badaddr),
      .mret            (mret),
      .sret            (sret),
      .wfi_event       (wfi_event),
      .privilege_mode  (privilege_mode),
      .csr_access_fault(csr_access_fault),

      .IRQ_TO_CPU_CTRL1(IRQ_TO_CPU_CTRL1),  // SSIP
      .IRQ_TO_CPU_CTRL3(IRQ_TO_CPU_CTRL3),  // MSIP
      .IRQ_TO_CPU_CTRL5(IRQ_TO_CPU_CTRL5),  // STIP
      .IRQ_TO_CPU_CTRL7(IRQ_TO_CPU_CTRL7)   // MTIP

  );

  datapath_unit #(
      .RESET_ADDR(RESET_ADDR),
      .SYSTEM_CLK(SYSTEM_CLK)
  ) datapath_unit_I (
      .clk   (clk),
      .resetn(resetn),

      .ResultSrc (ResultSrc),
      .ALUControl(ALUControl),
      .ALUSrcA   (ALUSrcA),
      .ALUSrcB   (ALUSrcB),
      .ImmSrc    (ImmSrc),
      .STOREop   (STOREop),
      .LOADop    (LOADop),
      .CSRop     (CSRop),
      .CSRwe     (CSRwe),
      .CSRre     (CSRre),
      .Zero      (Zero),
      .immb10    (immb10),

      .RegWrite         (RegWrite),
      .PCWrite          (PCWrite),
      .AdrSrc           (AdrSrc),
      .MemWrite         (MemWrite),
      .incr_inst_retired(incr_inst_retired),
      .store_instr      (store_instr),
      .ALUOutWrite      (ALUOutWrite),
      .Instr            (Instr),

      .mem_wstrb(cpu_mem_wstrb),
      .mem_addr (cpu_mem_addr),
      .mem_wdata(cpu_mem_wdata),
      .mem_rdata(cpu_mem_rdata),

      .MULop      (MULop),
      .mul_valid  (mul_valid),
      .mul_ready  (mul_ready),
      .DIVop      (DIVop),
      .div_valid  (div_valid),
      .div_ready  (div_ready),
      .ProgCounter(PC),

      // AMO
      .amo_temp_write_operation   (amo_temp_write_operation),
      .amo_set_reserved_state_load(amo_set_reserved_state_load),
      .amo_buffered_data          (amo_buffered_data),
      .amo_buffered_address       (amo_buffered_address),
      .amo_reserved_state_load    (amo_reserved_state_load),
      .muxed_Aluout_or_amo_rd_wr  (muxed_Aluout_or_amo_rd_wr),
      .select_ALUResult           (select_ALUResult),
      .select_amo_temp            (select_amo_temp),

      // Exception
      .exception_event (exception_event),
      .cause           (cause),
      .badaddr         (badaddr),
      .mret            (mret),
      .sret            (sret),
      .wfi_event       (wfi_event),
      .privilege_mode  (privilege_mode),
      .csr_access_fault(csr_access_fault),
      .mstatus         (mstatus),
      .satp            (satp),
      .tlb_flush       (tlb_flush_csr),
      .timer_counter   (timer_counter),
      .page_fault      (page_fault),
      .selectPC        (selectPC),

      .IRQ1(IRQ1),
      .IRQ5(IRQ5),
      .IRQ3(IRQ3),
      .IRQ7(IRQ7),

      .IRQ_TO_CPU_CTRL1(IRQ_TO_CPU_CTRL1),  // SSIP
      .IRQ_TO_CPU_CTRL3(IRQ_TO_CPU_CTRL3),  // MSIP
      .IRQ_TO_CPU_CTRL5(IRQ_TO_CPU_CTRL5),  // STIP
      .IRQ_TO_CPU_CTRL7(IRQ_TO_CPU_CTRL7)   // MTIP
  );

  sv32 #(
      .NUM_ENTRIES_PER_TLB(NUM_ENTRIES_PER_TLB)
  ) mmu_I (
      .clk   (clk),
      .resetn(resetn),

      .cpu_valid(cpu_mem_valid),
      .cpu_ready(cpu_mem_ready),
      .cpu_wstrb(cpu_mem_wstrb),
      .cpu_addr (cpu_mem_addr),
      .cpu_wdata(cpu_mem_wdata),
      .cpu_rdata(cpu_mem_rdata),

      .mem_valid    (mem_valid),
      .mem_ready    (mem_ready),
      .mem_wstrb    (mem_wstrb),
      .mem_addr     (mem_addr),
      .mem_wdata    (mem_wdata),
      .mem_rdata    (mem_rdata),
      .fault_address(sv32_fault_address),

      .privilege_mode(privilege_mode),
      .is_instruction(is_instruction),
      .tlb_flush     (tlb_flush | tlb_flush_csr),
      .stall         (stall),
      .satp          (satp),
      .mstatus       (mstatus),
      .page_fault    (page_fault)
  );


endmodule
