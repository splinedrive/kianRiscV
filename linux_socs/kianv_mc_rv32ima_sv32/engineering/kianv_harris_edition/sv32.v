/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2023/2024 hirosh dabui <hirosh@dabui.de>
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
/*
    VA: Virtual Address
    PA: Physical Address
    satp: Supervisor Address Translation and Protection
    VPN: Virtual Page Number
    PPN: Physical Page Number
    PTE: Page Table Entry

    +---------------------------------+
    |         Virtual Address         |
    +--------+--------+---------------+
    |  VPN[1]|  VPN[0]|    offset     |
    +---|----+----|---+---------------+
        |         |
      +-V-+     +-V-+
      |   |     |   |
      |Page Table   |
      |   |     |   |
      +---+     +---+
        |         |
        |         |
      +-V-+     +-V-+
      |PTE|     |PTE|
      +---+     +---+
        |         |
        +---------+
                |
    +-----------|--------------------+
    |        Physical Address        |
    +--------------------+-----------+
    |     PPN            |   offset  |
    +--------------------+-----------+
*/
`default_nettype none

`include "riscv_defines.vh"

module sv32 #(
    parameter NUM_ENTRIES_PER_TLB = 64
) (
    input wire clk,
    input wire resetn,

    input  wire        cpu_valid,
    output reg         cpu_ready,
    input  wire [ 3:0] cpu_wstrb,
    input  wire [31:0] cpu_addr,
    input  wire [31:0] cpu_wdata,
    output reg  [31:0] cpu_rdata,

    output reg         mem_valid,
    input  wire        mem_ready,
    output reg  [ 3:0] mem_wstrb,
    output reg  [33:0] mem_addr,
    output reg  [31:0] mem_wdata,
    input  wire [31:0] mem_rdata,

    input  wire is_instruction,
    input  wire tlb_flush,
    output reg  stall,

    input  wire [31:0] satp,
    input  wire [31:0] mstatus,
    input  wire [ 1:0] privilege_mode,
    output reg  [31:0] fault_address,
    output reg         page_fault
);

  localparam S0 = 0, S1 = 1, S2 = 2, S_LAST = 3;
  localparam STATE_WIDTH = $clog2(S_LAST);
  reg [STATE_WIDTH-1:0] state, next_state;

  wire is_page_fault;
  assign is_page_fault = page_fault_instruction || page_fault_data;
  always @(posedge clk) begin
    if (!resetn) begin
      page_fault <= 1'b0;
      fault_address <= 0;
    end else begin
      page_fault <= is_page_fault;
      if (is_page_fault) fault_address <= cpu_addr;
    end
  end

  always @(posedge clk) state <= !resetn ? S0 : next_state;

  wire translate_req_pending;
  assign translate_req_pending = mmu_translate_enable && cpu_valid && !mem_ready && !page_fault;
  /* verilator lint_off WIDTHEXPAND */
  /* verilator lint_off WIDTHTRUNC */
  wire mmu_translate_enable = `GET_SATP_MODE(satp);
  /* verilator lint_on WIDTHEXPAND */
  /* verilator lint_on WIDTHTRUNC */

  wire translation_complete;
  assign translation_complete = translate_instruction_ready || translate_data_ready;
  always @(*) begin
    next_state = state;
    case (state)
      S0: begin
        next_state = translate_req_pending ? S1 : S0;
      end
      S1: next_state = is_page_fault ? S0 : (translation_complete ? S2 : S1);
      S2: next_state =  /*!cpu_valid*/ mem_ready ? S0 : S2;
      default: next_state = S0;
    endcase
  end

  always @(*) begin
    translate_instruction_valid = 1'b0;
    translate_data_valid = 1'b0;

    case (state)
      S0: begin
        if (translate_req_pending) begin
          /* translate instruction */
          translate_instruction_valid = is_instruction;
          /* translate data */
          translate_data_valid = !is_instruction;
        end
      end
    endcase
  end

  wire [33:0] selected_phys_addr;
  assign selected_phys_addr = is_instruction ? physical_instruction_address : physical_data_address;

  always @(*) begin
    stall = 1'b0;
    mem_addr = 0;
    cpu_rdata = 0;
    mem_wstrb = 0;
    mem_wdata = 0;
    mem_valid = 1'b0;
    cpu_ready = mem_ready;
    walk_mem_rdata = 0;
    walk_mem_ready = 1'b0;

    case (state)
      S0: begin
        if (mmu_translate_enable && cpu_valid) begin
          /* translate */
          cpu_ready = 1'b0;
        end else begin
          /* no translation */
          mem_addr  = {2'b0, cpu_addr};
          mem_wstrb = cpu_wstrb;
          mem_wdata = cpu_wdata;
          cpu_rdata = mem_rdata;
          mem_valid = cpu_valid;
        end
      end
      S1: begin
        /* walk */
        stall = 1'b1;
        mem_addr = {2'b0, walk_mem_addr};
        mem_wstrb = 4'b0000;
        mem_wdata = 0;
        walk_mem_rdata = mem_rdata;
        mem_valid = walk_mem_valid;
        walk_mem_ready = mem_ready;
        cpu_ready = 1'b0;
        if (translation_complete && !is_page_fault) begin
          /* translated memory access */
          mem_addr  = selected_phys_addr;
          mem_wstrb = cpu_wstrb;
          mem_wdata = cpu_wdata;
          cpu_rdata = mem_rdata;
          mem_valid = cpu_valid;
        end
      end
      S2: begin
        /* translated memory access */
        mem_addr  = selected_phys_addr;
        mem_wstrb = cpu_wstrb;
        mem_wdata = cpu_wdata;
        cpu_rdata = mem_rdata;
        mem_valid = cpu_valid;
      end

    endcase
  end

  //////////////////////////////////////////////////////////////////////////////
  wire [33:0] physical_data_address;
  reg         translate_data_valid;
  wire        translate_data_ready;
  wire        page_fault_instruction;
  wire        page_fault_data;

  wire [33:0] physical_instruction_address;
  reg         translate_instruction_valid;
  wire        translate_instruction_ready;

  wire        walk_translate_instruction_mem_valid;
  wire        walk_translate_instruction_mem_ready;
  wire [31:0] walk_translate_instruction_mem_addr;

  wire        walk_translate_data_mem_valid;
  wire        walk_translate_data_mem_ready;
  wire [31:0] walk_translate_data_mem_addr;

  wire [31:0] pte;

  wire        walk_valid;
  wire        walk_ready;

  wire        trans_instr_to_phy_walk_valid;
  wire        trans_instr_to_phy_walk_ready;

  wire        trans_data_to_phy_walk_valid;
  wire        trans_data_to_phy_walk_ready;


  wire        walk_mem_valid;
  reg         walk_mem_ready;
  wire [31:0] walk_mem_addr;
  reg  [31:0] walk_mem_rdata;

  assign walk_valid = is_instruction ? trans_instr_to_phy_walk_valid : trans_data_to_phy_walk_valid;
  assign trans_instr_to_phy_walk_ready = is_instruction && walk_ready;
  assign trans_data_to_phy_walk_ready = !is_instruction && walk_ready;

  sv32_table_walk #(
      .TLB_ENTRY_COUNT(NUM_ENTRIES_PER_TLB)
  ) sv32_table_walk_I (
      .clk    (clk),
      .resetn (resetn),
      .address(cpu_addr),
      .satp   (satp),
      .pte    (pte),

      .is_instruction(is_instruction),
      .tlb_flush(tlb_flush),

      .valid(walk_valid),
      .ready(walk_ready),

      .walk_mem_valid(walk_mem_valid),
      .walk_mem_ready(walk_mem_ready),
      .walk_mem_addr (walk_mem_addr),
      .walk_mem_rdata(walk_mem_rdata)
  );

  sv32_translate_instruction_to_physical sv32_translate_instruction_to_physical_I (
      .clk             (clk),
      .resetn          (resetn),
      .address         (cpu_addr),
      .physical_address(physical_instruction_address),
      .page_fault      (page_fault_instruction),
      .privilege_mode  (privilege_mode),
      .satp            (satp),

      .valid(translate_instruction_valid),
      .ready(translate_instruction_ready),

      .walk_valid(trans_instr_to_phy_walk_valid),
      .walk_ready(trans_instr_to_phy_walk_ready),
      .pte(pte)
  );

  sv32_translate_data_to_physical sv32_translate_data_to_physical_I (
      .clk             (clk),
      .resetn          (resetn),
      .address         (cpu_addr),
      .physical_address(physical_data_address),
      .is_write        (|cpu_wstrb),
      .page_fault      (page_fault_data),
      .privilege_mode  (privilege_mode),
      .satp            (satp),
      .mstatus         (mstatus),

      .valid(translate_data_valid),
      .ready(translate_data_ready),

      .walk_valid(trans_data_to_phy_walk_valid),
      .walk_ready(trans_data_to_phy_walk_ready),
      .pte_(pte)
  );

endmodule
