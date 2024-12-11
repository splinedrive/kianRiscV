/*
 *  kianv.v - a simple RISC-V rv32i
 *
 *  copyright (c) 2022 hirosh dabui <hirosh@dabui.de>
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

module bram #(
    parameter integer WIDTH = 8,
    parameter INIT_FILE0 = "",
    parameter INIT_FILE1 = "",
    parameter INIT_FILE2 = "",
    parameter INIT_FILE3 = ""
) (
    input wire clk,
    input wire [WIDTH-1:0] addr,
    input wire [31:0] wdata,
    output reg [31:0] rdata,
    input wire [3:0] wmask
);

  localparam integer MEM_DEPTH = (1 << WIDTH);
  reg [7:0] mem0[0:MEM_DEPTH-1];
  reg [7:0] mem1[0:MEM_DEPTH-1];
  reg [7:0] mem2[0:MEM_DEPTH-1];
  reg [7:0] mem3[0:MEM_DEPTH-1];

  initial begin
    if (INIT_FILE0 != "") begin
      $readmemh(INIT_FILE0, mem0, 0, MEM_DEPTH - 1);
    end
    if (INIT_FILE1 != "") begin
      $readmemh(INIT_FILE1, mem1, 0, MEM_DEPTH - 1);
    end
    if (INIT_FILE2 != "") begin
      $readmemh(INIT_FILE2, mem2, 0, MEM_DEPTH - 1);
    end
    if (INIT_FILE3 != "") begin
      $readmemh(INIT_FILE3, mem3, 0, MEM_DEPTH - 1);
    end
  end

  always @(posedge clk) begin
    if (wmask[0]) mem0[addr] <= wdata[7:0];
    if (wmask[1]) mem1[addr] <= wdata[15:8];
    if (wmask[2]) mem2[addr] <= wdata[23:16];
    if (wmask[3]) mem3[addr] <= wdata[31:24];

    rdata <= {mem3[addr], mem2[addr], mem1[addr], mem0[addr]};
  end

endmodule
