/*
my_hdmi_device 

Copyright (C) 2021  Hirosh Dabui <hirosh@dabui.de>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/
`timescale 1 ns / 100 ps
`default_nettype none
module hdmi_device(
        input pclk,
        input tmds_clk, /* 10 times faster of pclk */

        input [7:0] in_vga_red,
        input [7:0] in_vga_green,
        input [7:0] in_vga_blue,

        input in_vga_blank,
        input in_vga_vsync,
        input in_vga_hsync,

        output [OUT_TMDS_MSB:0] out_tmds_red,
        output [OUT_TMDS_MSB:0] out_tmds_green,
        output [OUT_TMDS_MSB:0] out_tmds_blue,
        output [OUT_TMDS_MSB:0] out_tmds_clk
    );

    /* verilator lint_off WIDTH */
    parameter DDR_ENABLED = 0;
    localparam OUT_TMDS_MSB = DDR_ENABLED ? 1 : 0;

    /* */
    wire [9:0] tmds_red;
    wire [9:0] tmds_green;
    wire [9:0] tmds_blue;
    tmds_encoder tmsds_encoder_i0(pclk, ~in_vga_blank, in_vga_red,   0,          0,              tmds_red);
    tmds_encoder tmsds_encoder_i1(pclk, ~in_vga_blank, in_vga_green, 0,          0,              tmds_green);
    tmds_encoder tmsds_encoder_i2(pclk, ~in_vga_blank, in_vga_blue,  in_vga_vsync, in_vga_hsync, tmds_blue);

    /**/
    reg       tmds_shift_load   = 0;
    reg [3:0] tmds_modulo       = 0;
    reg [9:0] tmds_shift_red    = 0;
    reg [9:0] tmds_shift_green  = 0;
    reg [9:0] tmds_shift_blue   = 0;
    reg [9:0] tmds_shift_clk    = 0;

    wire [9:0] tmds_pixel_clk = 10'b00000_11111;
    /* ddr 5 shifts a 2 bits, sdr 10 shifts a 1 bit */

    wire max_shifts_reached = tmds_modulo == (DDR_ENABLED ? 4 : 9);
    always @(posedge tmds_clk) tmds_modulo      <= max_shifts_reached ? 0 : tmds_modulo + 1;
    always @(posedge tmds_clk) tmds_shift_load  <= max_shifts_reached;

    always @(posedge tmds_clk) begin
        tmds_shift_red    <= tmds_shift_load ? tmds_red       : {DDR_ENABLED ? 2'b00 : 1'b0, tmds_shift_red   [9: DDR_ENABLED ? 2 : 1]};
        tmds_shift_green  <= tmds_shift_load ? tmds_green     : {DDR_ENABLED ? 2'b00 : 1'b0, tmds_shift_green [9: DDR_ENABLED ? 2 : 1]};
        tmds_shift_blue   <= tmds_shift_load ? tmds_blue      : {DDR_ENABLED ? 2'b00 : 1'b0, tmds_shift_blue  [9: DDR_ENABLED ? 2 : 1]};
        tmds_shift_clk    <= tmds_shift_load ? tmds_pixel_clk : {DDR_ENABLED ? 2'b00 : 1'b0, tmds_shift_clk   [9: DDR_ENABLED ? 2 : 1]};
    end

    assign out_tmds_clk   = tmds_shift_clk    [ OUT_TMDS_MSB : 0 ];
    assign out_tmds_red   = tmds_shift_red    [ OUT_TMDS_MSB : 0 ];
    assign out_tmds_green = tmds_shift_green  [ OUT_TMDS_MSB : 0 ];
    assign out_tmds_blue  = tmds_shift_blue   [ OUT_TMDS_MSB : 0 ];
    /* verilator lint_on WIDTH */

endmodule
