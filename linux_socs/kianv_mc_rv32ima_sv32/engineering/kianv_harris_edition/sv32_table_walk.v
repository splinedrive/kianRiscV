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
`default_nettype none

`include "riscv_defines.vh"
module sv32_table_walk #(
    parameter TLB_ENTRY_COUNT = 64
) (
    input  wire        clk,
    input  wire        resetn,
    input  wire [31:0] address,
    input  wire [31:0] satp,
    output reg  [31:0] pte,
    input  wire        is_instruction,  /* differ tlb */
    input  wire        tlb_flush,

    input  wire valid,
    output reg  ready,

    output reg         walk_mem_valid,
    input  wire        walk_mem_ready,
    output reg  [31:0] walk_mem_addr,
    input  wire [31:0] walk_mem_rdata
);
  localparam TLB_ENTRY_COUNT_WIDTH = $clog2(TLB_ENTRY_COUNT);
  localparam S0 = 0, S1 = 1, S2 = 2, S_LAST = 3;

  reg [$clog2(S_LAST) -1:0] state, next_state;


  reg  [                      31:0] base;
  reg  [                      31:0] base_nxt;
  reg  [                       3:0] vpn_shift;
  reg  [                       9:0] idx;
  reg  [                      31:0] ppn;
  reg  [                       9:0] pte_flags;
  reg  [                      20:0] vpn;

  reg  [                      31:0] pte_nxt;

  reg                               ready_nxt;

  reg  [                       1:0] level;
  reg  [                       1:0] level_nxt;
  reg  [                      19:0] tag;


  reg  [TLB_ENTRY_COUNT_WIDTH -1:0] tlb_idx;
  reg                               tlb_we;
  reg                               tlb_valid [1:0];
  wire                              tlb_hit   [1:0];
  reg  [                      31:0] tlb_pte_i;
  wire [                      31:0] tlb_pte_o [1:0];

  genvar i;
  generate
    for (i = 0; i < 2; i = i + 1) begin : gen_tlb_I
      tag_ram #(
          .TAG_RAM_ADDR_WIDTH(TLB_ENTRY_COUNT_WIDTH),
          .TAG_WIDTH(20),
          .PAYLOAD_WIDTH(32)
      ) tlb_I (
          .clk      (clk),
          .resetn   (resetn && !tlb_flush),
          .idx      (tlb_idx),
          .tag      (tag),
          .we       (tlb_we),
          .valid_i  (tlb_valid[i]),
          .hit_o    (tlb_hit[i]),
          .payload_i(tlb_pte_i),
          .payload_o(tlb_pte_o[i])
      );
    end
  endgenerate

  always @(posedge clk) state <= !resetn ? S0 : next_state;

  always @(posedge clk) begin
    if (!resetn) begin
      pte   <= 0;
      ready <= 0;
      level <= 1;
      base  <= 0;
    end else begin
      pte   <= pte_nxt;
      ready <= ready_nxt;
      level <= level_nxt;
      base  <= base_nxt;

    end
  end

  /* verilator lint_off WIDTHEXPAND */
  /* verilator lint_off WIDTHTRUNC */
  wire mmu_translate_enable;
  assign mmu_translate_enable = `GET_SATP_MODE(satp);
  /* verilator lint_on WIDTHEXPAND */
  /* verilator lint_on WIDTHTRUNC */
  always @(*) begin
    next_state = state;

    case (state)
      S0: next_state = mmu_translate_enable && valid && !ready ? S1 : S0;
      S1: next_state = tlb_hit[is_instruction] ? S0 : (!(&level) ? S2 : S0);
      S2: next_state = !walk_mem_ready ? S2 : (!ready_nxt ? S1 : S0);
      default: next_state = S0;
    endcase
  end

  integer j;
  always @(*) begin
    pte_nxt = pte;
    base_nxt = base;
    vpn_shift = 0;
    vpn = 0;
    pte_flags = 0;
    ready_nxt = ready;

    walk_mem_valid = 1'b0;
    walk_mem_addr = 0;
    level_nxt = level;
    ppn = 0;
    tlb_we = 0;
    for (j = 0; j < 2; j = j + 1) begin
      tlb_valid[j] = 0;
    end
    tlb_pte_i = 0;
    /* verilator lint_off WIDTHEXPAND */
    /* verilator lint_off WIDTHTRUNC */
    tag = address >> (`SV32_PAGE_OFFSET_BITS);
    tlb_idx = tag & (TLB_ENTRY_COUNT - 1);

    vpn_shift = level ? `SV32_VPN0_BITS : 0;
    idx = (tag >> vpn_shift) & ((1 << `SV32_VPN0_BITS) - 1);
    walk_mem_addr = base + (idx << `SV32_PTE_SHIFT);  // word aligned
    /* verilator lint_on WIDTHEXPAND */
    /* verilator lint_on WIDTHTRUNC */


    /* verilator lint_off WIDTHEXPAND */
    /* verilator lint_off WIDTHTRUNC */
    case (state)
      S0: begin
        base_nxt = `GET_SATP_PPN(satp) << `SV32_PAGE_OFFSET_BITS;
        // bare mode
        if (!`GET_SATP_MODE(satp) && valid && !ready) begin
          pte_nxt = `PTE_V_MASK | `PTE_R_MASK | `PTE_W_MASK | `PTE_X_MASK | ((address >> `SV32_OFFSET_BITS) << `SV32_OFFSET_BITS);
          ready_nxt = 1'b1;
        end else begin
          ready_nxt = 1'b0;
          level_nxt = 1;
        end
      end

      S1: begin
        tlb_valid[is_instruction] = 1'b1;
        if (tlb_hit[is_instruction]) begin
          pte_nxt   = tlb_pte_o[is_instruction];
          ready_nxt = 1'b1;
        end else begin
          walk_mem_valid = 1'b1;
        end
      end

      S2: begin
        // load pte
        walk_mem_valid = 1'b1;
        pte_nxt = walk_mem_rdata;
        ppn = pte_nxt >> `SV32_PTE_PPN_SHIFT;

        // pte invalid
        if (walk_mem_ready) begin
          if (!`GET_PTE_V(pte_nxt)) begin
            pte_nxt   = 0;
            ready_nxt = 1'b1;
          end else begin
            /* Pointer to next level of page table */
            if ((!
                `GET_PTE_R(pte_nxt)
                && !
                `GET_PTE_W(pte_nxt)
                && !
                `GET_PTE_X(pte_nxt)
                )) begin
              ready_nxt = 1'b0;
              level_nxt = level - 1;
              base_nxt  = ppn << `SV32_PAGE_OFFSET_BITS;
            end else begin
              // actual pte
              pte_flags = pte_nxt & `PTE_FLAGS;
              // idx for pte
              vpn = address >> `SV32_PAGE_OFFSET_BITS;
              pte_nxt = ((level ? (ppn | vpn & ((1 << `SV32_VPN0_SHIFT) - 1)) : ppn) << `SV32_PAGE_OFFSET_BITS) | pte_flags;
              level_nxt = 1;
              ready_nxt = 1'b1;
              tlb_valid[is_instruction] = 1'b1;
              tlb_we = 1'b1;
              tlb_pte_i = pte_nxt;
            end
          end
        end
      end

      default: begin
        level_nxt = 1;
        ready_nxt = 1'b0;
      end
    endcase
    /* verilator lint_on WIDTHEXPAND */
    /* verilator lint_on WIDTHTRUNC */

  end

endmodule
