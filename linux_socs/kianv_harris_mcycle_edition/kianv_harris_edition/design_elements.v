/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2022/23 hirosh dabui <hirosh@dabui.de>
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

module mux2 #(
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH -1:0] d0,
        d1,
        input  wire              s,
        output wire [WIDTH -1:0] y
    );

    assign y = s ? d1 : d0;
endmodule

module mux3 #(
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH -1:0] d0,
        d1,
        d2,
        input  wire [       1:0] s,
        output wire [WIDTH -1:0] y
    );

    assign y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule

module mux4 #(
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH -1:0] d0,
        d1,
        d2,
        d3,
        input  wire [       1:0] s,
        output wire [WIDTH -1:0] y
    );

    wire [WIDTH -1:0] low, high;

    mux2 lowmux (
             d0,
             d1,
             s[0],
             low
         );
    mux2 highmux (
             d2,
             d3,
             s[0],
             high
         );
    mux2 finalmux (
             low,
             high,
             s[1],
             y
         );
endmodule

module mux5 #(
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH -1:0] d0,
        d1,
        d2,
        d3,
        d4,
        input  wire [       2:0] s,
        output wire [WIDTH -1:0] y

    );

    assign y = (s == 0) ? d0 : (s == 1) ? d1 : (s == 2) ? d2 : (s == 3) ? d3 : d4;

endmodule

module mux6 #(
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH -1:0] d0,
        d1,
        d2,
        d3,
        d4,
        d5,
        input  wire [       2:0] s,
        output wire [WIDTH -1:0] y

    );

    assign y = (s == 0) ? d0 : (s == 1) ? d1 : (s == 2) ? d2 : (s == 3) ? d3 : (s == 4) ? d4 : d5;

endmodule

module dlatch #(
        parameter WIDTH = 32
    ) (
        input wire clk,
        input wire [WIDTH -1:0] d,
        output reg [WIDTH -1:0] q
    );
    always @(posedge clk) q <= d;
endmodule

module dff #(
        parameter WIDTH  = 32,
        parameter PRESET = 0
    ) (
        input wire resetn,
        input wire clk,
        input wire en,
        input wire [WIDTH -1:0] d,
        output reg [WIDTH -1:0] q
    );
    always @(posedge clk)
        if (!resetn) q <= PRESET;
        else if (en) q <= d;

endmodule
module counter #(
        parameter WIDTH = 32
    ) (
        input wire resetn,
        input wire clk,
        input wire inc,
        output reg [WIDTH -1:0] q
    );
    always @(posedge clk)
        if (!resetn) q <= 0;
        else if (inc) q <= q + 1;

endmodule
/* verilator lint_on MULTITOP */
