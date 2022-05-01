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
`define MY_VGA_DEFAULT_PARAMS parameter \
/* VGA_640_480_60Hz */          \
     VPOL            = 1,	      \
     HPOL            = 0,	      \
     FRAME_RATE      = 60,	    \
/* vertical timing frame */     \
     VBP             = 33,      \
     VFP             = 10,      \
     VSLEN           = 2,	      \
     VACTIVE         = 480,	    \
/* horizontal timing frame */   \
     HBP             = 48,	    \
     HFP             = 16,	    \
     HSLEN           = 96,	    \
     HACTIVE         = 640

`define MY_VGA_DECLS \
localparam VTOTAL            = VACTIVE + VFP + VSLEN + VBP;	\
localparam HTOTAL            = HACTIVE + HFP + HSLEN + HBP;	\
localparam PIXEL_CLK         = (VTOTAL * HTOTAL) * FRAME_RATE;\
initial begin \
  $display("VACTIVE:%d", VACTIVE); \
  $display("HACTIVE:%d", HACTIVE); \
  $display("VBP:%d", VBP); \
  $display("VFP:%d", VFP); \
  $display("HBP:%d", HBP); \
  $display("HFP:%d", HFP); \
  $display("VSLEN:%d", VSLEN); \
  $display("HSLEN:%d", HSLEN); \
  $display("VTOTAL:%d", VTOTAL); \
  $display("HTOTAL:%d", HTOTAL); \
  $display("VFP_START:%d", VACTIVE); \
  $display("HFP_START:%d", HACTIVE); \
  $display("VSYNC_START:%d", VACTIVE + VFP); \
  $display("HSYNC_START:%d", HACTIVE + HFP); \
  $display("VBP_START:%d", VACTIVE + VFP + VSLEN); \
  $display("HBP_START:%d", HACTIVE + HFP + HSLEN); \
  $display("Vertical refresh:%d", VTOTAL*FRAME_RATE); \
  $display("Horizontal refresh:%d", HTOTAL*FRAME_RATE); \
  $display("Framerate:%d", FRAME_RATE); \
  $display("PIXEL Frequency:%d", PIXEL_CLK); \
end 

