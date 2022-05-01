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
`default_nettype none
`timescale 1ns / 1ps
`include "my_vga_clk_generator.vh"
/* todo: reset */
module my_vga_clk_generator #( `MY_VGA_DEFAULT_PARAMS ) (
           input clk,
           input [2:0] prescaler,
           output out_hsync,
           output out_vsync,
           output out_blank,
           output reg [10:0] out_hcnt, /* 0..2043 */
           output reg [10:0] out_vcnt, /* 0..2043 */
           output out_pclk,
           input reset_n
       );

`MY_VGA_DECLS

    /*
     *
     *         +
     *         |
     *         | VACTIVE
     *         |
     *         |       HACTIVE            HFP    HSLEN    HBP
     *         ------------------------++-----++-------+------+
     *         |
     *         |
     *         |
     *         |
     *         |
     *         +
     *         | VFP
     *         +
     *         +
     *         |
     *         | VSLEN
     *         |
     *         +
     *         +
     *         |
     *         | HBP
     *         |
     *         +
     *
     */

    /* verilator lint_off UNUSED */
    wire locked;

assign out_vsync = ((out_vcnt >= (VACTIVE + VFP -1)) && (out_vcnt < (VACTIVE + VFP + VSLEN))) ^ ~VPOL;
assign out_hsync = ((out_hcnt >= (HACTIVE + HFP -1)) && (out_hcnt < (HACTIVE + HFP + HSLEN))) ^ ~HPOL;
assign out_blank = (out_hcnt >= HACTIVE) || (out_vcnt >= VACTIVE);

wire hcycle = out_hcnt == (HTOTAL -1) || ~reset_n;
wire vcycle = out_vcnt == (VTOTAL -1) || ~reset_n;

reg [2:0] prescaler_cnt;
reg       prescaler_clk;

assign out_pclk = (|prescaler) ? prescaler_clk : clk;

always @(posedge clk) begin
    if (!reset_n) begin
        prescaler_clk <= 0;
        prescaler_cnt <= 0;
    end else begin
        prescaler_cnt <= prescaler_cnt + 1;

        if (prescaler_cnt == prescaler -1) begin
            prescaler_cnt <= 0;
            prescaler_clk <= ~prescaler_clk;
        end
    end
end

always @(posedge clk) begin
    if (!reset_n) begin
        out_hcnt <= 0;
        out_vcnt <= 0;
    end else begin
        if (!prescaler | out_pclk) begin
            out_hcnt <= hcycle ? 0 : out_hcnt + 1;
            if (hcycle) out_vcnt <= vcycle ? 0 : out_vcnt + 1;
        end
    end
end

endmodule
