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
// verilog_lint: waive-start explicit-parameter-storage-type
module imem32 #(
    parameter DEPTH = 64,
    parameter FILE  = ""
) (
    input wire logic clk,
    input wire logic [29:0] raddr,
    output logic [31:0] rdata
);
  logic [31:0] rom[DEPTH];

  initial begin
`ifdef SIM
    $display("=========================");
    $display("Module:\t%m");
    $display("DEPTH:\t\t%8d", DEPTH);
`endif
    if (FILE != "") begin
      $display(FILE);
      $readmemh(FILE, rom, 0, DEPTH - 1);
    end
    $display("=========================");
  end

  /* verilator lint_off WIDTH */
  always @(posedge clk) rdata <= rom[raddr];
  /* verilator lint_on WIDTH */

endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

