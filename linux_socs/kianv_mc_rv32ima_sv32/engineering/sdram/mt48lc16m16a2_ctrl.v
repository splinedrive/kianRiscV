// SPDX-License-Identifier: Apache-2.0
/*
 * mt48lc16m16a2_ctrl - SDR SDRAM controller
 * Target devices: Micron MT48LC16M16A2, Winbond W9816G6J (x16, 16M x 16)
 *
 * Copyright (c) 2022-2025 Hirosh Dabui <hirosh@dabui.de>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * Clocking note (important):
 * --------------------------
 * The *robust* way on real hardware is to use a PLL to generate two phases:
 *   - CK_0   (0°)   : drives the SDRAM CK pin
 *   - CK_180 (180°) : used inside the FPGA to capture DQ in the middle of the data eye
 *
 * ECP5 example (EHXPLLL) OUTSIDE of this module:
 *   - Generate clk_0  (0°)  and clk_180 (180°) at the SDRAM frequency.
 *   - Drive the SDRAM output pin with clk_0 using a proper ODDR/IO register.
 *   - Clock the input DQ capture registers with clk_180 (posedge).
 *   - Feed this module with clk_0 and set READ_NEGEDGE=0 (because you already have 180°).
 *
 * Generic fallback (no PLL available):
 *   - Tie sdram_clk = ~clk (approx. 180° shift) and enable READ_NEGEDGE=1.
 *   - This is less robust than a real PLL phase shift, but works on many boards.
 *
 * This file implements the *generic fallback* by default:
 *   sdram_clk is always ~clk (no SIM/BOARD distinction). See the header above
 *   for the recommended PLL wiring on ECP5 (or any FPGA with a phase-shifting PLL).
 */

`default_nettype none
`timescale 1ns/1ps

module mt48lc16m16a2_ctrl #(
    // SDRAM clock frequency in MHz
    parameter integer SDRAM_CLK_FREQ = 64,

    // --- timing in ns (JEDEC) ---
    parameter integer       TRP_NS   = 15,   // precharge -> activate
    parameter integer       TRCD_NS  = 15,   // activate  -> read/write
    parameter integer       TCH_NS   = 2,    // tMRD helper (min 2 cycles)
    parameter [2:0]         CAS      = 3'd2, // CAS = 2 or 3
    parameter integer       TRFC_NS  = 66,   // auto-refresh cycle time
    parameter integer       TWR_NS   = 15,   // write recovery
    parameter integer       TREFI_NS = 7800, // ~7.8us average

    // Refresh credit scheduling
    parameter integer REF_CREDITS_MAX  = 8,  // cap outstanding refreshes
    parameter integer REF_FORCE_THRESH = 4,  // force refresh if >= this
    parameter integer REF_SOFT_THRESH  = 1,  // opportunistic if idle

    // Row policy: 0 = closed-page (auto-precharge), 1 = keep-open
    parameter integer KEEP_OPEN        = 1,

    // Read capture tuning (fallback path, see header):
    // - If you use the generic "~clk" trick, set READ_NEGEDGE=1 (default).
    // - If you use a PLL 180° capture clock outside, set READ_NEGEDGE=0.
    parameter integer READ_NEGEDGE     = 1,  // 1 = sample on negedge clk (fallback)
    parameter integer READ_EXTRA_CYC   = 0   // extra NOPs before first read sample
)(
    input  wire        clk,
    input  wire        resetn,

    input  wire [24:0] addr,
    input  wire [31:0] din,
    input  wire [3:0]  wmask,
    input  wire        valid,
    output reg  [31:0] dout,
    output reg         ready,

    output wire        sdram_clk,
    output wire        sdram_cke,
    output wire [1:0]  sdram_dqm,
    output wire [12:0] sdram_addr,
    output wire [1:0]  sdram_ba,
    output wire        sdram_csn,
    output wire        sdram_wen,
    output wire        sdram_rasn,
    output wire        sdram_casn,
    inout  wire [15:0] sdram_dq
);

  // -------------------------------------------------
  // Helpers: ceil(ns*MHz/1000) -> cycles
  // -------------------------------------------------
  function integer ns2cyc;
    input integer ns;
    input integer f_mhz;
    integer num;
  begin
    num = ns * f_mhz + 999;
    ns2cyc = num / 1000;
    if (ns2cyc < 1) ns2cyc = 1;
  end
  endfunction

  localparam integer ONE_US_CYC  = SDRAM_CLK_FREQ;
  localparam integer WAIT_200US  = 200 * ONE_US_CYC;

  // Derived timing (clamp to >= 2 cycles where required)
  localparam integer TRP_CYC   = (ns2cyc(TRP_NS,  SDRAM_CLK_FREQ)  < 2) ? 2 : ns2cyc(TRP_NS,  SDRAM_CLK_FREQ);
  localparam integer TRCD_CYC  = (ns2cyc(TRCD_NS, SDRAM_CLK_FREQ)  < 2) ? 2 : ns2cyc(TRCD_NS, SDRAM_CLK_FREQ);
  localparam integer TCH_TMP   =  ns2cyc(TCH_NS,  SDRAM_CLK_FREQ);
  localparam integer TCH_CYC   = (TCH_TMP < 2) ? 2 : TCH_TMP; // tMRD >= 2
  localparam integer TRFC_CYC  =  ns2cyc(TRFC_NS, SDRAM_CLK_FREQ);
  localparam integer TWR_CYC   =  ns2cyc(TWR_NS,  SDRAM_CLK_FREQ);
  localparam integer TDAL_CYC  =  TWR_CYC + TRP_CYC;  // write(AP) -> tWR + tRP
  localparam integer TREFI_CYC =  ns2cyc(TREFI_NS, SDRAM_CLK_FREQ);

  // Mode register fields
  localparam [2:0] BURST_LENGTH   = 3'b001; // BL=2
  localparam       ACCESS_TYPE    = 1'b0;   // sequential
  localparam [2:0] CAS_LATENCY    = CAS;    // 2 or 3
  localparam [1:0] OP_MODE        = 2'b00;  // standard
  localparam       NO_WRITE_BURST = 1'b0;   // write burst enabled
  localparam [12:0] MODE_REG      = {1'b0, NO_WRITE_BURST, OP_MODE, CAS_LATENCY, ACCESS_TYPE, BURST_LENGTH};

  // Column address helpers:
  // - AP (A10=1) for closed-page
  // - KO (A10=0) for keep-open
  wire [12:0] col_ap = {3'b001, addr[10:2], 1'b0}; // A12..A10=001, A0=0
  wire [12:0] col_ko = {3'b000, addr[10:2], 1'b0}; // A12..A10=000, A0=0

  // -------------------------------------------------
  // Banner
  // -------------------------------------------------
  initial begin
    $display("====================================================");
    $display("SDR SDRAM controller @%0d MHz", SDRAM_CLK_FREQ);
    $display("Power-up wait               : %0d cycles (200 us)", WAIT_200US);

    $display("--- Timing (ns -> cycles) --------------------------");
    $display("tRP   = %0d ns -> %0d cycles", TRP_NS,  TRP_CYC);
    $display("tRCD  = %0d ns -> %0d cycles", TRCD_NS, TRCD_CYC);
    $display("tRFC  = %0d ns -> %0d cycles", TRFC_NS, TRFC_CYC);
    $display("tWR   = %0d ns -> %0d cycles", TWR_NS,  TWR_CYC);
    $display("tDAL  = tWR+tRP -> %0d cycles", TDAL_CYC);
    $display("tMRD  = max(2, TCH_CYC=%0d) -> %0d cycles", TCH_CYC, TCH_CYC);
    $display("tREFI = %0d ns -> %0d cycles", TREFI_NS, TREFI_CYC);

    $display("--- Mode register ---------------------------------");
    $display("MODE_REG                   : 0x%0h (CAS=%0d, BL=%0b, WB=%0b)", MODE_REG, CAS_LATENCY, BURST_LENGTH, NO_WRITE_BURST);

    $display("--- Policy / scheduler ----------------------------");
    $display("Row-open policy            : %s", (KEEP_OPEN != 0) ? "KEEP OPEN" : "CLOSED PAGE");
    $display("Credit max/soft/force      : %0d / %0d / %0d", REF_CREDITS_MAX, REF_SOFT_THRESH, REF_FORCE_THRESH);

    $display("Clocking (generic fallback): sdram_clk = ~clk; READ_NEGEDGE=%0d", READ_NEGEDGE);
    $display("See file header for the recommended PLL 0°/180° solution.");

    $display("--- Address mapping -------------------------------");
    $display("bank = addr[22:21]");
    $display("row  = {addr[24:23], addr[20:10]}");
    $display("col  = {addr[10:2], A0=0} (BL=2)");
    $display("====================================================");
  end

  // -------------------------------------------------
  // SDRAM command encoding: {CS, RAS, CAS, WE}
  // -------------------------------------------------
  localparam [3:0] CMD_MRS   = 4'b0000;
  localparam [3:0] CMD_ACT   = 4'b0011;
  localparam [3:0] CMD_READ  = 4'b0101;
  localparam [3:0] CMD_WRITE = 4'b0100;
  localparam [3:0] CMD_BST   = 4'b0110;
  localparam [3:0] CMD_PRE   = 4'b0010;
  localparam [3:0] CMD_REF   = 4'b0001;
  localparam [3:0] CMD_NOP   = 4'b0111;

  // -------------------------------------------------
  // Outputs / main registers
  // -------------------------------------------------
  reg [3:0]  command, command_nxt;
  reg        cke, cke_nxt;
  reg [1:0]  dqm, dqm_nxt;
  reg [12:0] saddr, saddr_nxt;
  reg [1:0]  ba, ba_nxt;
  reg [15:0] dq, dq_nxt;
  reg        oe, oe_nxt;

  // Generic fallback: drive SDRAM CK with inverted fabric clk (~180° shift).
  // For PLL-based designs, drive this module with CK_0 and set sdram_clk = CK_0
  // outside (or adapt this line) and capture DQ on CK_180 (then READ_NEGEDGE=0).
  assign sdram_clk = ~clk;

  assign sdram_cke  = cke;
  assign sdram_addr = saddr;
  assign sdram_dqm  = dqm;
  assign {sdram_csn, sdram_rasn, sdram_casn, sdram_wen} = command;
  assign sdram_ba   = ba;

  assign sdram_dq = oe ? dq : 16'hzzzz;

  // -------------------------------------------------
  // Read capture (fallback path uses negedge sampling)
  // -------------------------------------------------
  reg  [15:0] dq_negedge;
  wire [15:0] dq_rd = (READ_NEGEDGE != 0) ? dq_negedge : sdram_dq;

  always @(negedge clk) begin
    if (!resetn) dq_negedge <= 16'h0000;
    else         dq_negedge <= sdram_dq;
  end

  // -------------------------------------------------
  // FSM
  // -------------------------------------------------
  localparam RESET        = 0;
  localparam ASSERT_CKE   = 1;
  localparam INIT_PRE_ALL = 2;
  localparam INIT_REF0    = 3;
  localparam INIT_REF1    = 4;
  localparam INIT_MRS     = 5;
  localparam IDLE         = 6;
  localparam ACTIVATE     = 7;
  localparam PRE_BANK     = 8;
  localparam PRE_ALL      = 9;
  localparam REFRESH      = 10;
  localparam READ_CMD     = 11;
  localparam READ_L       = 12;
  localparam READ_H       = 13;
  localparam WRITE_L      = 14;
  localparam WRITE_H      = 15;
  localparam WAIT_STATE   = 16;  // <- kept for TB hierarchical checks

  localparam STATE_W = 5; // enough for 0..16
  reg [STATE_W-1:0] state, state_nxt;
  reg [STATE_W-1:0] ret_state, ret_state_nxt;

  // Wait counter sized for worst-case (200us @ <= 65k cycles)
  localparam WAIT_W = 16;
  reg [WAIT_W-1:0] wait_cnt, wait_cnt_nxt;

  reg        ready_nxt;
  reg [31:0] dout_nxt;
  reg        update_ready, update_ready_nxt;

  // -------------------------------------------------
  // Refresh scheduler
  // -------------------------------------------------
  reg [15:0] ref_timer,  ref_timer_nxt;
  reg [3:0]  ref_credit, ref_credit_nxt;

  // -------------------------------------------------
  // Address decode helpers
  // -------------------------------------------------
  wire [1:0]  cur_bank_w = addr[22:21];
  wire [12:0] cur_row_w  = {addr[24:23], addr[20:10]};

  // -------------------------------------------------
  // Per-bank open-row tracking (KEEP_OPEN)
  // -------------------------------------------------
  reg [3:0]  bank_open_valid, bank_open_valid_nxt;
  reg [12:0] open_row0, open_row1, open_row2, open_row3;
  reg [12:0] open_row0_nxt, open_row1_nxt, open_row2_nxt, open_row3_nxt;

  reg [12:0] open_row_cur;
  always @* begin
    case (cur_bank_w)
      2'd0: open_row_cur = open_row0;
      2'd1: open_row_cur = open_row1;
      2'd2: open_row_cur = open_row2;
      default: open_row_cur = open_row3;
    endcase
  end

  wire same_row_hit = (bank_open_valid[cur_bank_w] == 1'b1) &&
                      (open_row_cur == cur_row_w);

  // -------------------------------------------------
  // Registers
  // -------------------------------------------------
  always @(posedge clk) begin
    if (!resetn) begin
      state        <= RESET;
      ret_state    <= RESET;
      ready        <= 1'b0;
      wait_cnt     <= 0;
      dout         <= 32'h0;
      command      <= CMD_NOP;
      dqm          <= 2'b11;
      dq           <= 16'h0;
      ba           <= 2'b00;
      oe           <= 1'b0;
      saddr        <= 13'h0;
      update_ready <= 1'b0;
      cke          <= 1'b0;

      ref_timer    <= TREFI_CYC;
      ref_credit   <= 4'd0;

      bank_open_valid <= 4'b0000;
      open_row0 <= 13'h0000;
      open_row1 <= 13'h0000;
      open_row2 <= 13'h0000;
      open_row3 <= 13'h0000;
    end else begin
      state        <= state_nxt;
      ret_state    <= ret_state_nxt;
      ready        <= ready_nxt;
      wait_cnt     <= wait_cnt_nxt;
      dout         <= dout_nxt;
      command      <= command_nxt;
      dqm          <= dqm_nxt;
      dq           <= dq_nxt;
      ba           <= ba_nxt;
      oe           <= oe_nxt;
      saddr        <= saddr_nxt;
      update_ready <= update_ready_nxt;
      cke          <= cke_nxt;

      ref_timer    <= ref_timer_nxt;
      ref_credit   <= ref_credit_nxt;

      bank_open_valid <= bank_open_valid_nxt;
      open_row0 <= open_row0_nxt;
      open_row1 <= open_row1_nxt;
      open_row2 <= open_row2_nxt;
      open_row3 <= open_row3_nxt;
    end
  end

  // -------------------------------------------------
  // Next-state logic
  // -------------------------------------------------
  always @* begin
    // defaults
    state_nxt        = state;
    ret_state_nxt    = ret_state;
    ready_nxt        = 1'b0;
    wait_cnt_nxt     = wait_cnt;
    dout_nxt         = dout;
    command_nxt      = CMD_NOP;
    dqm_nxt          = dqm;
    cke_nxt          = cke;
    saddr_nxt        = saddr;
    ba_nxt           = ba;
    dq_nxt           = dq;
    oe_nxt           = 1'b0;
    update_ready_nxt = update_ready;

    bank_open_valid_nxt = bank_open_valid;
    open_row0_nxt = open_row0;
    open_row1_nxt = open_row1;
    open_row2_nxt = open_row2;
    open_row3_nxt = open_row3;

    // refresh scheduler tick
    ref_timer_nxt  = (ref_timer != 0) ? (ref_timer - 1'b1) : TREFI_CYC;
    ref_credit_nxt = ref_credit;
    if (ref_timer == 0) begin
      if (ref_credit < REF_CREDITS_MAX[3:0]) ref_credit_nxt = ref_credit + 1'b1;
    end

    case (state)
      // --- init sequence ---
      RESET: begin
        cke_nxt       = 1'b0;
        wait_cnt_nxt  = WAIT_200US;
        ret_state_nxt = ASSERT_CKE;
        state_nxt     = WAIT_STATE;
      end

      ASSERT_CKE: begin
        cke_nxt       = 1'b1;
        wait_cnt_nxt  = 2;
        ret_state_nxt = INIT_PRE_ALL;
        state_nxt     = WAIT_STATE;
      end

      INIT_PRE_ALL: begin
        command_nxt   = CMD_PRE;
        saddr_nxt[10] = 1'b1; // all banks
        wait_cnt_nxt  = TRP_CYC;
        bank_open_valid_nxt = 4'b0000;
        ret_state_nxt = INIT_REF0;
        state_nxt     = WAIT_STATE;
      end

      INIT_REF0: begin
        command_nxt   = CMD_REF;
        wait_cnt_nxt  = TRFC_CYC;
        ret_state_nxt = INIT_REF1;
        state_nxt     = WAIT_STATE;
      end

      INIT_REF1: begin
        command_nxt   = CMD_REF;
        wait_cnt_nxt  = TRFC_CYC;
        ret_state_nxt = INIT_MRS;
        state_nxt     = WAIT_STATE;
      end

      INIT_MRS: begin
        command_nxt   = CMD_MRS;
        saddr_nxt     = MODE_REG;
        wait_cnt_nxt  = TCH_CYC; // tMRD >= 2 already enforced
        ret_state_nxt = IDLE;
        state_nxt     = WAIT_STATE;
      end

      // --- idle arbitration ---
      IDLE: begin
        dqm_nxt          = 2'b11;
        update_ready_nxt = 1'b0;

        // refresh hard / soft (when idle)
        if (ref_credit >= REF_FORCE_THRESH[3:0] ||
           (ref_credit >= REF_SOFT_THRESH[3:0] && !(valid && !ready))) begin
          // need all banks closed before REF
          if (bank_open_valid != 4'b0000) begin
            command_nxt         = CMD_PRE;
            saddr_nxt[10]       = 1'b1; // precharge all
            wait_cnt_nxt        = TRP_CYC;
            bank_open_valid_nxt = 4'b0000;
            ret_state_nxt       = REFRESH;
            state_nxt           = WAIT_STATE;
          end else begin
            command_nxt   = CMD_REF;
            wait_cnt_nxt  = TRFC_CYC;
            ref_credit_nxt= ref_credit - 1'b1;
            ret_state_nxt = IDLE;
            state_nxt     = WAIT_STATE;
          end

        end else if (valid && !ready) begin
          ba_nxt = cur_bank_w;

          if (KEEP_OPEN != 0) begin
            if (same_row_hit) begin
              // hit: go emit READ/WRITE now
              if (wmask == 4'b0000) begin
                state_nxt = READ_CMD;
              end else begin
                state_nxt = WRITE_L;
              end
            end else begin
              // miss: if bank open, precharge it; else activate
              if (bank_open_valid[cur_bank_w]) begin
                command_nxt   = CMD_PRE;
                saddr_nxt[10] = 1'b0; // bank-only
                ba_nxt        = cur_bank_w;
                wait_cnt_nxt  = TRP_CYC;
                case (cur_bank_w)
                  2'd0: bank_open_valid_nxt[0] = 1'b0;
                  2'd1: bank_open_valid_nxt[1] = 1'b0;
                  2'd2: bank_open_valid_nxt[2] = 1'b0;
                  default: bank_open_valid_nxt[3] = 1'b0;
                endcase
                ret_state_nxt = ACTIVATE;
                state_nxt     = WAIT_STATE;
              end else begin
                state_nxt = ACTIVATE;
              end
            end

          end else begin
            // closed-page policy: always ACT then access with AP
            state_nxt = ACTIVATE;
          end
        end
      end

      // --- ACTIVATE selected row ---
      ACTIVATE: begin
        command_nxt  = CMD_ACT;
        ba_nxt       = cur_bank_w;
        saddr_nxt    = cur_row_w;
        wait_cnt_nxt = TRCD_CYC;
        ret_state_nxt= (wmask == 4'b0000) ? READ_CMD : WRITE_L;

        // record open row (for KEEP_OPEN)
        if (KEEP_OPEN != 0) begin
          case (cur_bank_w)
            2'd0: begin open_row0_nxt = cur_row_w; bank_open_valid_nxt[0] = 1'b1; end
            2'd1: begin open_row1_nxt = cur_row_w; bank_open_valid_nxt[1] = 1'b1; end
            2'd2: begin open_row2_nxt = cur_row_w; bank_open_valid_nxt[2] = 1'b1; end
            default: begin open_row3_nxt = cur_row_w; bank_open_valid_nxt[3] = 1'b1; end
          endcase
        end
        state_nxt = WAIT_STATE;
      end

      // --- READ path ---
      READ_CMD: begin
        command_nxt   = CMD_READ;
        dqm_nxt       = 2'b00;
        ba_nxt        = cur_bank_w;
        if (KEEP_OPEN != 0) saddr_nxt = col_ko; // A10=0 keep open
        else                saddr_nxt = col_ap; // A10=1 auto-precharge

        wait_cnt_nxt  = CAS_LATENCY + READ_EXTRA_CYC;
        ret_state_nxt = READ_L;
        state_nxt     = WAIT_STATE;
      end

      READ_L: begin
        dqm_nxt        = 2'b00;
        dout_nxt[15:0] = dq_rd;
        state_nxt      = READ_H;
      end

      READ_H: begin
        dqm_nxt          = 2'b00;
        dout_nxt[31:16]  = dq_rd;
        if (KEEP_OPEN == 0) wait_cnt_nxt = TRP_CYC; // let AP precharge finish
        else                wait_cnt_nxt = 1;
        update_ready_nxt = 1'b1;
        ret_state_nxt    = IDLE;
        state_nxt        = WAIT_STATE;
      end

      // --- WRITE path ---
      WRITE_L: begin
        command_nxt = CMD_WRITE;
        dqm_nxt     = ~wmask[1:0];
        ba_nxt      = cur_bank_w;
        if (KEEP_OPEN != 0) saddr_nxt = col_ko; else saddr_nxt = col_ap;
        dq_nxt      = din[15:0];
        oe_nxt      = 1'b1;
        state_nxt   = WRITE_H;
      end

      WRITE_H: begin
        command_nxt      = CMD_NOP;
        dqm_nxt          = ~wmask[3:2];
        ba_nxt           = cur_bank_w;
        if (KEEP_OPEN != 0) saddr_nxt = col_ko; else saddr_nxt = col_ap;
        dq_nxt           = din[31:16];
        oe_nxt           = 1'b1;

        // write recovery: if AP (closed page), need tWR+tRP; else only tWR
        wait_cnt_nxt     = (KEEP_OPEN != 0) ? TWR_CYC : TDAL_CYC;
        update_ready_nxt = 1'b1;
        ret_state_nxt    = IDLE;
        state_nxt        = WAIT_STATE;
      end

      // --- PRECHARGE helpers ---
      PRE_BANK: begin
        command_nxt   = CMD_PRE;
        saddr_nxt[10] = 1'b0; // bank-only
        wait_cnt_nxt  = TRP_CYC;
        ret_state_nxt = IDLE;
        state_nxt     = WAIT_STATE;
      end

      PRE_ALL: begin
        command_nxt   = CMD_PRE;
        saddr_nxt[10] = 1'b1;
        wait_cnt_nxt  = TRP_CYC;
        ret_state_nxt = IDLE;
        state_nxt     = WAIT_STATE;
      end

      REFRESH: begin
        command_nxt   = CMD_REF;
        wait_cnt_nxt  = TRFC_CYC;
        ref_credit_nxt= (ref_credit != 0) ? (ref_credit - 1'b1) : 4'd0;
        ret_state_nxt = IDLE;
        state_nxt     = WAIT_STATE;
      end

      // --- shared wait ---
      WAIT_STATE: begin
        command_nxt  = CMD_NOP;
        wait_cnt_nxt = wait_cnt - 1'b1;
        if (wait_cnt == 1) begin
          state_nxt = ret_state;
          if (ret_state == IDLE && update_ready) begin
            update_ready_nxt = 1'b0;
            ready_nxt        = 1'b1; // pulse
          end
        end
      end

      default: begin
        state_nxt = IDLE;
      end
    endcase
  end

endmodule
