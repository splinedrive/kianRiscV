/*
 *  kianv 5-staged pipelined RISC-V
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
`default_nettype none `timescale 1 ns / 100 ps

module register_file32 #(
    parameter REGISTER_DEPTH = 32,  // rv32e = 16; rv32i = 32
    parameter CLEAR_REGISTER_FILE = 0
) (
    input  wire logic        clk,
    input  wire logic        we,
    input  wire logic [ 4:0] A1,
    input  wire logic [ 4:0] A2,
    input  wire logic [ 4:0] A3,
    input  wire logic [31:0] wd,
    output wire logic [31:0] Rd1,
    output wire logic [31:0] Rd2
);
  logic [31:0] bank[0:REGISTER_DEPTH -1];

  initial begin
    if (CLEAR_REGISTER_FILE) begin
      for (int i = 0; i < $size(bank); i = i + 1) begin
        bank[i] = 32'd0;
        $display("cleared register file\n");
      end
    end
  end

  always_ff @(posedge clk) begin
    if (we && A3 != 0) begin
      bank[A3] <= wd;
    end
  end

  assign Rd1 = A1 != 0 ? bank[A1] : 32'b0;
  assign Rd2 = A2 != 0 ? bank[A2] : 32'b0;


endmodule
