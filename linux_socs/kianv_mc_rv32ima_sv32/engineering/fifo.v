/*
 *  kianv.v - a simple RISC-V rv32ima
 *  fifo.v  — simple synchronous FIFO (single clock), safe push+pop
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
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
module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16
) (
    input wire clk,
    input wire resetn,

    input  wire [DATA_WIDTH-1:0] din,
    output wire [DATA_WIDTH-1:0] dout,

    input wire push,
    input wire pop,

    output wire full,
    output wire empty
);

  // Memory
  reg [DATA_WIDTH-1:0] ram[0:DEPTH-1];

  // Pointers and count
  localparam AW = $clog2(DEPTH);
  reg [AW:0] cnt;
  reg [AW-1:0] rd_ptr, wr_ptr;
  reg [AW:0] cnt_next;
  reg [AW-1:0] rd_ptr_next, wr_ptr_next;

  assign empty = (cnt == 0);
  assign full  = (cnt == DEPTH);

  // Accept logic:
  // - We accept a write when not full, OR when full but a pop happens the same cycle.
  // - We accept a read only when not empty (simple variant).
  wire wr_accept = push && (!full || pop);
  wire rd_accept = pop && (!empty);

  // Next-state logic
  always @* begin
    rd_ptr_next = rd_ptr;
    wr_ptr_next = wr_ptr;
    cnt_next    = cnt;

    if (wr_accept) begin
      wr_ptr_next = wr_ptr + 1'b1;
    end
    if (rd_accept) begin
      rd_ptr_next = rd_ptr + 1'b1;
    end

    case ({
      push, pop
    })
      2'b00: cnt_next = cnt;
      2'b01: if (!empty) cnt_next = cnt - 1'b1;  // pop only
      2'b10: if (!full) cnt_next = cnt + 1'b1;  // push only
      2'b11: cnt_next = cnt;  // push+pop => depth unchanged
    endcase
  end

  // State regs
  always @(posedge clk) begin
    if (!resetn) begin
      rd_ptr <= 0;
      wr_ptr <= 0;
      cnt    <= 0;
    end else begin
      rd_ptr <= rd_ptr_next;
      wr_ptr <= wr_ptr_next;
      cnt    <= cnt_next;
    end
  end

  // Write RAM only on accepted push
  always @(posedge clk) begin
    if (wr_accept) ram[wr_ptr] <= din;
  end

  // Simple asynchronous read port (registered pointers)
  assign dout = ram[rd_ptr];

endmodule

