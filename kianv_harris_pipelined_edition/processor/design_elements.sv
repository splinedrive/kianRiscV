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
/* verilator lint_off MULTITOP */
// verilog_lint: waive-start explicit-parameter-storage-type
// verilog_lint: waive-start module-filename
/* verilator lint_off DECLFILENAME */
module mux2 #(
    parameter WIDTH = 32
) (
    input  wire logic [WIDTH -1:0] d0,
    input  wire logic [WIDTH -1:0] d1,
    input  wire logic              s,
    output wire logic [WIDTH -1:0] y
);

  assign y = s ? d1 : d0;
endmodule

module mux3 #(
    parameter WIDTH = 32
) (
    input  wire logic [WIDTH -1:0] d0,
    d1,
    d2,
    input  wire logic [       1:0] s,
    output wire logic [WIDTH -1:0] y
);

  assign y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule

module mux4 #(
    parameter WIDTH = 32
) (
    input  wire logic [WIDTH -1:0] d0,
    input  wire logic [WIDTH -1:0] d1,
    input  wire logic [WIDTH -1:0] d2,
    input  wire logic [WIDTH -1:0] d3,
    input  wire logic [       1:0] s,
    output wire logic [WIDTH -1:0] y
);

  logic [WIDTH -1:0] low, high;

  mux2 #(
      .WIDTH(WIDTH)
  ) lowmux (
      .d0(d0),
      .d1(d1),
      .s (s[0]),
      .y (low)
  );

  mux2 #(
      .WIDTH(WIDTH)
  ) highmux (
      .d0(d2),
      .d1(d3),
      .s (s[0]),
      .y (high)
  );

  mux2 #(
      .WIDTH(WIDTH)
  ) finalmux (
      .d0(low),
      .d1(high),
      .s (s[1]),
      .y (y)
  );
endmodule

module mux5 #(
    parameter WIDTH = 32
) (
    input  wire logic [WIDTH -1:0] d0,
    input  wire logic [WIDTH -1:0] d1,
    input  wire logic [WIDTH -1:0] d2,
    input  wire logic [WIDTH -1:0] d3,
    input  wire logic [WIDTH -1:0] d4,
    input  wire logic [       2:0] s,
    output wire logic [WIDTH -1:0] y

);

  assign y = (s == 0) ? d0 : (s == 1) ? d1 : (s == 2) ? d2 : (s == 3) ? d3 : d4;

endmodule

module dflop #(
    parameter WIDTH  = 32,
    parameter PRESET = 0
) (
    input wire logic resetn,
    input wire logic clk,
    input wire logic en,
    input wire logic [WIDTH -1:0] d,
    output logic [WIDTH -1:0] q
);
  always_ff @(posedge clk)
    if (!resetn) q <= PRESET;
    else if (en) q <= d;
endmodule

module counter #(
    parameter WIDTH = 32
) (
    input wire logic resetn,
    input wire logic clk,
    input wire logic inc,
    output logic [WIDTH -1:0] q
);
  always_ff @(posedge clk)
    if (!resetn) q <= 0;
    else if (inc) q <= q + 1;

endmodule
/* verilator lint_on MULTITOP */
/* verilator lint_on DECLFILENAME */
// verilog_lint: waive-stop explicit-parameter-storage-type
// verilog_lint: waive-stop module-filename
