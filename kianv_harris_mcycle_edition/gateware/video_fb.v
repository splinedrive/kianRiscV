/*
 *  kianv.v - a simple RISC-V rv32im
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
`timescale 1 ns / 100 ps
`default_nettype none
`include "defines.vh"
module video_fb
    #(
         parameter FB_ADDR0   = 32'h 10_000_000,
         parameter FB_ADDR1   = 32'h 10_000_000 + (8192*4),
         parameter FRAME_BUFFER_CTRL = 32'h 30_000_024
     )
     (
         input  wire         clk_pclk,
         input  wire         clk_x5,
         input  wire         clk_sys,
         input  wire         resetn,
`ifdef ECP5
         output wire [ 3 :0] gpdi_dp,
`elsif ARTIX7
         output wire [ 3: 0] hdmi_p,
         output wire [ 3: 0] hdmi_n,
`endif
         output wire         video_sel,
         input  wire         iomem_valid,
         output wire         iomem_ready,
         input  wire [ 3: 0] iomem_wstrb,
         input  wire [31: 0] iomem_addr,
         input  wire [31: 0] iomem_wdata,
         output wire [31: 0] iomem_rdata
     );

    wire       clk = clk_sys;
    wire       hsync;
    wire       vsync;
    wire       blank;
    wire       [10: 0] hcnt; /* 0..2043 */
    wire       [10: 0] vcnt; /* 0..2043 */

    reg        [ 7: 0]  vga_red;
    reg        [ 7: 0]  vga_blue;
    reg        [ 7: 0]  vga_green;

    // hardwired inside but you can do parameter from it
    localparam XRES              = 80;
    localparam YRES              = 60;
    localparam SCREEN_RESOLUTION = XRES*YRES; // 24 bit

    // hardwired inside but you can do parameter from it
    localparam VPOL = 1'b 1;
    localparam HPOL = 1'b 0;

    // hardwired inside but you can do parameter from it
    vga_ctrl #(
                 .VPOL         ( VPOL       ),
                 .HPOL         ( HPOL       ),
                 .FRAME_RATE   ( 60         ),
                 .VBP          ( 33         ),
                 .VFP          ( 10         ),
                 .VSLEN        ( 2          ),
                 .VACTIVE      ( 480        ),
                 .HBP          ( 48         ),
                 .HFP          ( 16         ),
                 .HSLEN        ( 96         ),
                 .HACTIVE      ( 640        )
             )
             vga_ctrl_I (
                 .hcnt_o       ( hcnt       ),
                 .vcnt_o       ( vcnt       ),
                 .hsync_o      ( hsync      ),
                 .vsync_o      ( vsync      ),
                 .blank_o      ( blank      ),
                 .pclk         ( clk_pclk   ),
                 .resetn       ( resetn     )
             );

    wire [23: 0] fb_rdata[0:1];

    reg  [12: 0] fb_rd_addr;
    reg  fb_segment; /* 0 or 1 */
    reg  [ 2: 0] svcnt;
    reg  [ 2: 0] shcnt;

    wire fb_valid[0:1];

    reg  fb_ready[0:1];
    wire [1:0] fb_ready_comb;
    wire [1:0] video_sel_comb;
    wire fb_seg_valid;
    reg  fb_seg_ready;

    reg vsync_reg;
    always @(posedge clk_pclk) vsync_reg <= vsync;

    reg hsync_reg;
    always @(posedge clk_pclk) hsync_reg <= hsync;

    always @(*) begin
        if (!blank) begin
            vga_blue  = fb_rdata[fb_segment][ 7: 0];
            vga_green = fb_rdata[fb_segment][15 :8];
            vga_red   = fb_rdata[fb_segment][23:16];
        end else begin
            vga_red   = 8'b 0;
            vga_blue  = 8'b 0;
            vga_green = 8'b 0;
        end
    end


    genvar i;
    generate
        for (i = 0; i < 2; i = i +1) begin
            assign fb_ready_comb  [ i ]  = |fb_ready[i] | fb_seg_ready;
            assign video_sel_comb [ i ]  = |fb_valid[i];
        end
    endgenerate

    assign video_sel = |video_sel_comb | fb_seg_valid;
    assign iomem_ready = |fb_ready_comb | fb_seg_ready;

    assign iomem_rdata = fb_seg_valid & !(|iomem_wstrb) ? {30'hx, blank, fb_segment} : 32'b 0;

    assign fb_valid[0] = !fb_ready[0] && iomem_valid &&
           (iomem_addr >= FB_ADDR0) && (iomem_addr < (FB_ADDR0 + ((80*60*4))) );

    assign fb_valid[1] = !fb_ready[1] && iomem_valid &&
           (iomem_addr >= (FB_ADDR1) && (iomem_addr < (FB_ADDR1) + ((80*60*4))) );

    genvar j;
    generate
        for (j = 0; j < 2; j = j + 1)
            always @(posedge clk) fb_ready[j] <= !resetn ? 0 : fb_valid[j];
    endgenerate

    assign fb_seg_valid = !fb_seg_ready && iomem_valid && (iomem_addr == FRAME_BUFFER_CTRL) && (vcnt > 479);
    always @(posedge clk) begin
        if (!resetn) begin
            fb_segment <= 0;
        end else begin
            if (fb_seg_valid && |iomem_wstrb) fb_segment   <= iomem_wdata[0];
            fb_seg_ready <= !resetn ? 1'b 0 : fb_seg_valid;
        end
    end

    // this block has some hardwired parameters for vga
    // to scale from vga to 80x60 resolution
    always @(posedge clk_pclk) begin
        if (!resetn) begin
            fb_rd_addr <= 0;
            svcnt      <= 0;
            shcnt      <= 0;
        end else begin
            if (vcnt > 479) begin
                fb_rd_addr <= 0;
            end else begin

                if (HPOL ? !hsync_reg & hsync : hsync_reg & !hsync) begin
                    svcnt <= svcnt + 1;
                    if (!(&svcnt) /* duplicate line >= 0 && < 7 */) begin
                        fb_rd_addr <= fb_rd_addr - XRES;
                    end
                end
            end

            if (!blank) begin
                shcnt <= shcnt + 1;
                if (&shcnt) /* inc each 8 pixel */begin
                    fb_rd_addr <= fb_rd_addr +  1;
                end

            end
        end
    end

    genvar k;
    generate
        for (k = 0; k < 2; k = k + 1)
            dual_port_ram #(
                              .DATA_WIDTH( 24 ),
                              .ADDR_WIDTH( 13 ) // 80*60*1
                          ) fb_I[k:k]
                          (
                              .wdata   ( iomem_wdata[23:0]                    ),
                              .rd_addr ( fb_rd_addr                           ),  // read only fb ctrl
                              .rdata   ( fb_rdata[k]                          ),
                              .wr_addr ( iomem_addr[14:2]                     ),  // write only cpu
                              .we      ( fb_valid[k] && (|iomem_wstrb)        ),
                              .rd_clk  ( clk_pclk                             ),
                              .wr_clk  ( clk                                  )
                          );
    endgenerate

    // hardwired inside but you can do parameter from it
    //localparam DDR_HDMI_TRANSFER = 1'b 1;
    localparam OUT_TMDS_MSB = `DDR_HDMI_TRANSFER ? 1 : 0;
    wire [OUT_TMDS_MSB:0] out_tmds_red;
    wire [OUT_TMDS_MSB:0] out_tmds_green;
    wire [OUT_TMDS_MSB:0] out_tmds_blue;
    wire [OUT_TMDS_MSB:0] out_tmds_clk;

    hdmi_device #(
                    .DDR_ENABLED(`DDR_HDMI_TRANSFER)
                )
                hdmi_device_i
                (
                    clk_pclk,
                    clk_x5,

                    vga_red,
                    vga_green,
                    vga_blue,

                    blank,
                    vsync,
                    hsync,

                    out_tmds_red,
                    out_tmds_green,
                    out_tmds_blue,
                    out_tmds_clk
                );

`ifdef ECP5
    // SDR and DDR
    generate
        if (`DDR_HDMI_TRANSFER) begin
            ODDRX1F ddr0_clock (.D0(out_tmds_clk   [0] ), .D1(out_tmds_clk   [1] ), .Q(gpdi_dp[3]), .SCLK(clk_x5), .RST(0));
            ODDRX1F ddr0_red   (.D0(out_tmds_red   [0] ), .D1(out_tmds_red   [1] ), .Q(gpdi_dp[2]), .SCLK(clk_x5), .RST(0));
            ODDRX1F ddr0_green (.D0(out_tmds_green [0] ), .D1(out_tmds_green [1] ), .Q(gpdi_dp[1]), .SCLK(clk_x5), .RST(0));
            ODDRX1F ddr0_blue  (.D0(out_tmds_blue  [0] ), .D1(out_tmds_blue  [1] ), .Q(gpdi_dp[0]), .SCLK(clk_x5), .RST(0));
        end else begin
            assign gpdi_dp[3] = out_tmds_clk;
            assign gpdi_dp[2] = out_tmds_red;
            assign gpdi_dp[1] = out_tmds_green;
            assign gpdi_dp[0] = out_tmds_blue;
        end
    endgenerate
`elsif ARTIX7
    wire tmds_clk = clk_x5;
generate if (!`DDR_HDMI_TRANSFER) begin
            /*
                      OBUFDS OBUFDS_clock     ( .I( out_tmds_clk   ),   .O( hdmi_p[3]), .OB(hdmi_n[3]) );
                      OBUFDS OBUFDS_red       ( .I( out_tmds_red   ),   .O( hdmi_p[2]), .OB(hdmi_n[2]) );
                      OBUFDS OBUFDS_green     ( .I( out_tmds_green ),   .O( hdmi_p[1]), .OB(hdmi_n[1]) );
                      OBUFDS OBUFDS_blue      ( .I( out_tmds_blue  ),   .O( hdmi_p[0]), .OB(hdmi_n[0]) );
            */
            assign hdmi_p[3] = out_tmds_clk;
            assign hdmi_p[2] = out_tmds_red;
            assign hdmi_p[1] = out_tmds_green;
            assign hdmi_p[0] = out_tmds_blue;

            assign hdmi_n[3] = ~out_tmds_clk;
            assign hdmi_n[2] = ~out_tmds_red;
            assign hdmi_n[1] = ~out_tmds_green;
            assign hdmi_n[0] = ~out_tmds_blue;

        end else begin
            wire out_ddr_tmds_clk;
            ODDR
                #(.DDR_CLK_EDGE   ("SAME_EDGE"), //"OPPOSITE_EDGE" "SAME_EDGE"
                  .INIT           (1'b 0      ),
                  .SRTYPE         ("ASYNC"))
                oddr_clk
                (
                    .D1( out_tmds_clk[0]  ),
                    .D2( out_tmds_clk[1]  ) ,
                    .C ( tmds_clk         ),
                    .CE( 1'b1             ),
                    .Q ( out_ddr_tmds_clk ),
                    .R ( 1'b0             ),
                    .S ( 1'b0             )
                );
            OBUFDS OBUFDS_clock( .I(out_ddr_tmds_clk), .O(hdmi_p[3]), .OB(hdmi_n[3]) );

            wire out_ddr_tmds_red;
            ODDR
                #(.DDR_CLK_EDGE   ("SAME_EDGE"), //"OPPOSITE_EDGE" "SAME_EDGE"
                  .INIT           (1'b 0      ),
                  .SRTYPE         ("ASYNC"))
                oddr_red
                (
                    .D1( out_tmds_red[0]  ),
                    .D2( out_tmds_red[1]  ),
                    .C ( tmds_clk         ),
                    .CE( 1'b1             ),
                    .Q ( out_ddr_tmds_red ),
                    .R ( 1'b0             ),
                    .S ( 1'b0             )
                );
            OBUFDS OBUFDS_red( .I(out_ddr_tmds_red), .O(hdmi_p[2]), .OB(hdmi_n[2]) );

            wire out_ddr_tmds_green;
            ODDR
                #(.DDR_CLK_EDGE   ("SAME_EDGE"), //"OPPOSITE_EDGE" "SAME_EDGE"
                  .INIT           (1'b       0),
                  .SRTYPE         ("ASYNC"))
                oddr_green
                (
                    .D1( out_tmds_green[0]   ),
                    .D2( out_tmds_green[1]   ),
                    .C ( tmds_clk            ),
                    .CE( 1'b1                ),
                    .Q ( out_ddr_tmds_green  ),
                    .R ( 1'b0                ),
                    .S ( 1'b0                )
                );
            OBUFDS OBUFDS_green( .I(out_ddr_tmds_green), .O(hdmi_p[1]), .OB(hdmi_n[1]) );

            wire out_ddr_tmds_blue;
            ODDR
                #(.DDR_CLK_EDGE   ("SAME_EDGE"), //"OPPOSITE_EDGE" "SAME_EDGE"
                  .INIT           (1'b       0),
                  .SRTYPE         ("ASYNC"))
                oddr_blue
                (
                    .D1( out_tmds_blue[0]    ),
                    .D2( out_tmds_blue[1]    ),
                    .C ( tmds_clk            ),
                    .CE( 1'b1                ),
                    .Q ( out_ddr_tmds_blue   ),
                    .R ( 1'b0                ),
                    .S ( 1'b0                )
                );
            OBUFDS OBUFDS_blue( .I(out_ddr_tmds_blue), .O(hdmi_p[0]), .OB(hdmi_n[0]) );
        end endgenerate
`endif
endmodule
