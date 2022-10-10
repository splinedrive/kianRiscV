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
    output wire logic [31:0] rdata
);
  /* verilator lint_off WIDTH */
  //logic [31:0] ram[DEPTH] = '{default: 0};
  logic [31:0] ram[DEPTH];


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
      for (int i = 0; i < $size(ram); i++) begin
        ram[i] = 0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (wmask[0]) ram[addr][7:0] <= wdata[7:0];
    if (wmask[1]) ram[addr][15:8] <= wdata[15:8];
    if (wmask[2]) ram[addr][23:16] <= wdata[23:16];
    if (wmask[3]) ram[addr][31:24] <= wdata[31:24];
  end

  assign rdata = ram[addr];

  /* verilator lint_on WIDTH */

endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
