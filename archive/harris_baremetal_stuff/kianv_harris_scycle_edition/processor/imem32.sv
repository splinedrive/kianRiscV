`default_nettype none `timescale 1 ns / 100 ps
// verilog_lint: waive-start explicit-parameter-storage-type
module imem32 #(
    parameter DEPTH = 64,
    parameter FILE  = ""
) (
    input  wire logic [29:0] addr,
    output wire logic [31:0] data
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
  assign data = rom[addr];
  /* verilator lint_on WIDTH */

endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

