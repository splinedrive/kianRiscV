/*
 *  kianv harris single cycle RISC-V rv32im
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
module pseudo_havard #(
    parameter DEPTH = 64,
    parameter FILE  = ""
) (
    input wire logic clk,
    input wire logic [3:0] wmask,
    input wire logic [31:0] wdata,
    input wire logic [29:0] daddr,
    output wire logic [31:0] rdata,

    input  wire logic [29:0] iaddr,
    output wire logic [31:0] idata
);
  /* verilator lint_off WIDTH */
  logic [31:0] ram[DEPTH];

  initial begin
`ifdef SIM
    $display("=========================");
    $display("Module:\t%m");
    $display("DEPTH:\t\t%8d", DEPTH);
`endif
    if (FILE != "") begin
      $display(FILE);
      $readmemh(FILE, ram, 0, DEPTH - 1);
    end
    $display("=========================");
  end

  initial begin
    if (FILE != "") begin
      $display(FILE);
      $readmemh(FILE, ram);
    end else begin
      for (int i = 0; i < $size(ram); i++) begin
        ram[i] = 0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (wmask[0]) ram[daddr][7:0] <= wdata[7:0];
    if (wmask[1]) ram[daddr][15:8] <= wdata[15:8];
    if (wmask[2]) ram[daddr][23:16] <= wdata[23:16];
    if (wmask[3]) ram[daddr][31:24] <= wdata[31:24];
  end

  assign rdata = ram[daddr];

  assign idata = ram[iaddr];
  /* verilator lint_on WIDTH */

endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

