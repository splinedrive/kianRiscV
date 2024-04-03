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

`include "riscv_defines.vh"
module tag_ram #(
    parameter TAG_RAM_ADDR_WIDTH = 6,
    parameter TAG_WIDTH = 20,
    parameter PAYLOAD_WIDTH = 32
) (
    input wire clk,
    input wire resetn,
    input wire [TAG_RAM_ADDR_WIDTH -1:0] idx,
    input wire [TAG_WIDTH -1:0] tag,
    input wire [PAYLOAD_WIDTH -1:0] payload_i,
    input wire we,
    input wire valid_i,
    output reg hit_o,
    output wire [PAYLOAD_WIDTH -1:0] payload_o
);
  localparam LINES = 2 ** TAG_RAM_ADDR_WIDTH;
  reg [TAG_WIDTH -1:0] tags[0:LINES -1];
  reg [PAYLOAD_WIDTH -1:0] payloads[0:LINES -1];
  reg [LINES -1:0] v;

  always @(*) begin
    /* verilator lint_off WIDTHTRUNC */
    hit_o = tag == tags[idx] && v[idx];
    /* verilator lint_on WIDTHTRUNC */
  end

  always @(posedge clk) begin
    if (!resetn) begin
      v <= 0;
    end else begin
      if (valid_i) begin
        if (we) begin
          /* verilator lint_off WIDTHTRUNC */
          tags[idx] <= tag;
          payloads[idx] <= payload_i;
          v[idx] <= 1'b1;
          /* verilator lint_on WIDTHTRUNC */
        end
      end
    end
  end
  /* verilator lint_off WIDTHTRUNC */
  assign payload_o = hit_o ? payloads[idx] : 0;
  /* verilator lint_on WIDTHTRUNC */
endmodule

