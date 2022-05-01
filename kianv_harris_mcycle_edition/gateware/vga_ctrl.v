/*
  vga_ctrl
  Copyright (C) 2022  Hirosh Dabui <hirosh@dabui.de>

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
`timescale 1ns / 1ps
/* todo: reset */
module vga_ctrl #(
        /* VGA_640_480_60Hz */
        parameter VPOL            = 1,
        parameter HPOL            = 0,
        parameter FRAME_RATE      = 60,
        /* vertical timing frame */
        parameter VBP             = 33,
        parameter VFP             = 10,
        parameter VSLEN           = 2,
        parameter VACTIVE         = 480,
        /* horizontal timing frame */
        parameter HBP             = 48,
        parameter HFP             = 16,
        parameter HSLEN           = 96,
        parameter HACTIVE         = 640
    )(
        input   wire pclk,
        output  wire hsync_o,
        output  wire vsync_o,
        output  wire blank_o,
        output  reg [10:0] hcnt_o, /* 0..2043 */
        output  reg [10:0] vcnt_o, /* 0..2043 */
        input   wire resetn
    );

    localparam VTOTAL            = VACTIVE + VFP + VSLEN + VBP;
    localparam HTOTAL            = HACTIVE + HFP + HSLEN + HBP;
    localparam PIXEL_CLK         = (VTOTAL * HTOTAL) * FRAME_RATE;
    initial begin
        $display("VACTIVE:%d", VACTIVE);
        $display("HACTIVE:%d", HACTIVE);
        $display("VBP:%d", VBP);
        $display("VFP:%d", VFP);
        $display("HBP:%d", HBP);
        $display("HFP:%d", HFP);
        $display("VSLEN:%d", VSLEN);
        $display("HSLEN:%d", HSLEN);
        $display("VTOTAL:%d", VTOTAL);
        $display("HTOTAL:%d", HTOTAL);
        $display("VFP_START:%d", VACTIVE);
        $display("HFP_START:%d", HACTIVE);
        $display("VSYNC_START:%d", VACTIVE + VFP);
        $display("HSYNC_START:%d", HACTIVE + HFP);
        $display("VBP_START:%d", VACTIVE + VFP + VSLEN);
        $display("HBP_START:%d", HACTIVE + HFP + HSLEN);
        $display("Vertical refresh:%d", VTOTAL*FRAME_RATE);
        $display("Horizontal refresh:%d", HTOTAL*FRAME_RATE);
        $display("Framerate:%d", FRAME_RATE);
        $display("PIXEL Frequency:%d", PIXEL_CLK);
    end


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

    assign vsync_o = ((vcnt_o >= (VACTIVE + VFP -1)) && (vcnt_o < (VACTIVE + VFP + VSLEN))) ^ ~VPOL;
    assign hsync_o = ((hcnt_o >= (HACTIVE + HFP -1)) && (hcnt_o < (HACTIVE + HFP + HSLEN))) ^ ~HPOL;
    assign blank_o = (hcnt_o >= HACTIVE) || (vcnt_o >= VACTIVE);

    wire hcycle = hcnt_o == (HTOTAL -1) || ~resetn;
    wire vcycle = vcnt_o == (VTOTAL -1) || ~resetn;

    always @(posedge pclk) hcnt_o <= hcycle ? 0 : hcnt_o + 1;

    always @(posedge pclk) begin
        if (hcycle) vcnt_o <= vcycle ? 0 : vcnt_o + 1;
    end

endmodule
