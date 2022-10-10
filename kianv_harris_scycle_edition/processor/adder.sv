`default_nettype none `timescale 1 ns / 100 ps
// verilog_lint: waive-start explicit-parameter-storage-type
module adder #(
    parameter WIDTH = 32
) (
    input  wire logic [WIDTH-1:0] a,
    input  wire logic [WIDTH-1:0] b,
    output wire logic [WIDTH-1:0] y
);
  assign y = a + b;
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

