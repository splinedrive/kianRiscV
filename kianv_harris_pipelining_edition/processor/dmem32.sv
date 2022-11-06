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
module dmem32 #(
    parameter DEPTH = 64,
    parameter FILE  = ""
) (
    input wire logic clk,
    input wire logic [3:0] wmask,
    input wire logic [31:0] wdata,
    input wire logic [29:0] addr,
    output logic [31:0] rdata
);
  /* verilator lint_off WIDTH */
  logic [3:0][7:0] ram[0:DEPTH-1];


`ifdef SIM
  initial begin
    $display("=========================");
    $display("Module:\t%m");
    $display("DEPTH:\t\t%8d", DEPTH);
    $display("=========================");
  end
`endif

  initial begin
    if (FILE != "") begin
      $display(FILE);
      $readmemh(FILE, ram);
    end else begin
      for (int i = 0; i < $size(ram); i = i + 1) begin
        ram[i] = 0;
      end
    end
  end

  always_ff @(posedge clk) begin
    for (int i = 0; i < 4; i = i + 1) begin
      if (wmask[i]) ram[addr][i] <= wdata[i*8+:8];
    end
    rdata <= ram[addr];
  end

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
