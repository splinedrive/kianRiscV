/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
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
    input wire clk,
    input wire resetn,
    input wire is_instruction,

    input wire [31:0] cpu_addr_i,
    input wire [31:0] cpu_din_i,
    input wire [3:0] cpu_wmask_i,
    input wire cpu_valid_i,
    output reg [31:0] cpu_dout_o,
    output reg cpu_ready_o,

    output reg [31:0] cache_addr_o,
    output reg [31:0] cache_din_o,
    output reg [3:0] cache_wmask_o,
    output reg cache_valid_o,
    input wire [31:0] cache_dout_i,
    input wire cache_ready_i
);

  wire [31:0] icache_ram_addr_o;
  reg [31:0] icache_ram_rdata_i;
  wire [31:0] icache_cpu_dout_o;
  wire icache_cpu_ready_o;
  reg icache_cpu_valid_i;
  reg [31:0] icache_cpu_addr_i;
  reg [31:0] icache_cpu_din_i;
  wire icache_ram_valid_o;
  reg icache_ram_ready_i;

  always @* begin

    cache_addr_o = 0;
    cache_din_o = 0;
    cache_valid_o = 0;
    cache_wmask_o = 0;

    cpu_dout_o = 0;
    cpu_ready_o = 0;

    icache_cpu_addr_i = 0;
    icache_cpu_din_i = 0;
    icache_cpu_valid_i = 0;
    icache_ram_rdata_i = 0;
    icache_ram_ready_i = 0;

    if (is_instruction) begin
      cache_addr_o = icache_ram_addr_o;
      cache_valid_o = icache_ram_valid_o;

      cpu_dout_o = icache_cpu_dout_o;
      cpu_ready_o = icache_cpu_ready_o;

      icache_cpu_addr_i = cpu_addr_i;
      icache_cpu_valid_i = cpu_valid_i;
      icache_ram_rdata_i = cache_dout_i;
      icache_ram_ready_i = cache_ready_i;
    end else begin
      cache_addr_o = cpu_addr_i;
      cache_din_o = cpu_din_i;
      cache_valid_o = cpu_valid_i;
      cache_wmask_o = cpu_wmask_i;

      cpu_dout_o = cache_dout_i;
      cpu_ready_o = cache_ready_i;
    end
  end

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

endmodule

