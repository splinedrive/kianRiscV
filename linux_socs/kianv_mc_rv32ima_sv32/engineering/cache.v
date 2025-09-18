/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2024/2025 hirosh dabui <hirosh@dabui.de>
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

module cache #(
    parameter ICACHE_ENTRIES_PER_WAY = 64
) (
    input  wire        clk,
    input  wire        resetn,
    input  wire        is_instruction,

    input  wire [31:0] cpu_addr_i,
    input  wire [31:0] cpu_din_i,
    input  wire [3:0]  cpu_wmask_i,
    input  wire        cpu_valid_i,
    output reg  [31:0] cpu_dout_o,
    output reg         cpu_ready_o,

    // external memory/bus side (shared by i/d caches)
    output reg  [31:0] cache_addr_o,
    output reg  [31:0] cache_din_o,
    output reg  [3:0]  cache_wmask_o,
    output reg         cache_valid_o,
    input  wire [31:0] cache_dout_i,
    input  wire        cache_ready_i
);

  // ---------------- I$ wires/regs ----------------
  reg  [31:0] icache_cpu_addr_i;
  reg         icache_cpu_valid_i;
  reg  [31:0] icache_ram_rdata_i;
  reg         icache_ram_ready_i;
  wire [31:0] icache_cpu_dout_o;
  wire        icache_cpu_ready_o;
  wire [31:0] icache_ram_addr_o;
  wire        icache_ram_valid_o;

  // ---------------- D$ wires/regs ----------------
  reg  [31:0] dcache_cpu_addr_i;
  reg         dcache_cpu_valid_i;
  // feed these as continuous wires; the D$ ignores them when valid_i=0
  wire [31:0] dcache_cpu_din_i  = cpu_din_i;
  wire [3:0]  dcache_cpu_wmask_i = cpu_wmask_i;

  reg  [31:0] dcache_ram_rdata_i;
  reg         dcache_ram_ready_i;

  wire [31:0] dcache_cpu_dout_o;
  wire        dcache_cpu_ready_o;
  wire [31:0] dcache_ram_addr_o;
  wire [3:0]  dcache_ram_wmask_o;
  wire [31:0] dcache_ram_wdata_o;   // submodule output → must be wire
  wire        dcache_ram_valid_o;

  // ---------------- Top-level muxing ----------------
  always @* begin
    // defaults
    cache_addr_o   = 32'b0;
    cache_din_o    = 32'b0;
    cache_valid_o  = 1'b0;
    cache_wmask_o  = 4'b0;

    cpu_dout_o     = 32'b0;
    cpu_ready_o    = 1'b0;

    // icache defaults
    icache_cpu_addr_i  = 32'b0;
    icache_cpu_valid_i = 1'b0;
    icache_ram_rdata_i = 32'b0;
    icache_ram_ready_i = 1'b0;

    // dcache defaults
    dcache_cpu_addr_i  = 32'b0;
    dcache_cpu_valid_i = 1'b0;
    dcache_ram_rdata_i = 32'b0;
    dcache_ram_ready_i = 1'b0;

    if (is_instruction) begin
      // -------- I$ path --------
      cache_addr_o   = icache_ram_addr_o;
      cache_valid_o  = icache_ram_valid_o;
      cache_wmask_o  = 4'b0000;           // reads only
      cache_din_o    = 32'b0;

      cpu_dout_o     = icache_cpu_dout_o;
      cpu_ready_o    = icache_cpu_ready_o;

      icache_cpu_addr_i  = cpu_addr_i;
      icache_cpu_valid_i = cpu_valid_i;
      icache_ram_rdata_i = cache_dout_i;
      icache_ram_ready_i = cache_ready_i;
    end else begin
      // -------- D$ path --------
      cache_addr_o   = dcache_ram_addr_o;
      cache_valid_o  = dcache_ram_valid_o;
      cache_wmask_o  = dcache_ram_wmask_o;
      cache_din_o    = dcache_ram_wdata_o;

      cpu_dout_o     = dcache_cpu_dout_o;
      cpu_ready_o    = dcache_cpu_ready_o;

      dcache_cpu_addr_i  = cpu_addr_i;
      dcache_cpu_valid_i = cpu_valid_i;

      dcache_ram_rdata_i = cache_dout_i;
      dcache_ram_ready_i = cache_ready_i;
    end
  end

  // ---------------- Instances ----------------
  icache #(
      .ICACHE_ENTRIES_PER_WAY(ICACHE_ENTRIES_PER_WAY),
      .WAYS(2)
  ) icache_I (
      .clk        (clk),
      .resetn     (resetn),
      .cpu_addr_i (icache_cpu_addr_i),
      .cpu_dout_o (icache_cpu_dout_o),
      .cpu_valid_i(icache_cpu_valid_i),
      .cpu_ready_o(icache_cpu_ready_o),
      .ram_addr_o (icache_ram_addr_o),
      .ram_rdata_i(icache_ram_rdata_i),
      .ram_valid_o(icache_ram_valid_o),
      .ram_ready_i(icache_ram_ready_i)
  );

  dcache #(
      .DCACHE_ENTRIES_PER_WAY(ICACHE_ENTRIES_PER_WAY),
      .WAYS(2)
  ) dcache_I (
      .clk         (clk),
      .resetn      (resetn),

      // CPU side
      .cpu_addr_i  (dcache_cpu_addr_i),
      .cpu_wmask_i (dcache_cpu_wmask_i),
      .cpu_din_i   (dcache_cpu_din_i),
      .cpu_dout_o  (dcache_cpu_dout_o),
      .cpu_valid_i (dcache_cpu_valid_i),
      .cpu_ready_o (dcache_cpu_ready_o),

      // RAM/bus side
      .ram_addr_o  (dcache_ram_addr_o),
      .ram_wmask_o (dcache_ram_wmask_o),
      .ram_wdata_o (dcache_ram_wdata_o),
      .ram_rdata_i (dcache_ram_rdata_i),
      .ram_valid_o (dcache_ram_valid_o),
      .ram_ready_i (dcache_ram_ready_i)
  );

endmodule

