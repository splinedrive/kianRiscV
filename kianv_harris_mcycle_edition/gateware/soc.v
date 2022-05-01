/*
 *  kianv.v - a simple RISC-V rv32im
 *
 *  copyright (c) 2021 hirosh dabui <hirosh@dabui.de>
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
module soc
    (
        input  wire        clk_osc,
        output wire        uart_tx,

`ifdef IOMEM_INTERFACING_EXTERNAL
`ifdef IOMEM_INTERFACING
        output wire        iomem_valid,
        input  wire        iomem_ready,
        output wire [ 3:0] iomem_wstrb,
        output wire [31:0] iomem_addr,
        output wire [31:0] iomem_wdata,
        input  wire [31:0] iomem_rdata,
`endif
`endif

`ifdef LED_ULX3S
        output wire [7:0]  led,
`endif

`ifdef LED_KROETE
        //  output wire [3:0]  led,
        output wire [2:0]  led,
`endif

`ifdef HDMI_VIDEO_FB
`ifdef ECP5
        output [3:0] gpdi_dp,
`endif
`endif

`ifdef OLED_SD1331
`ifdef ULX3S
        output wire [24:21] gn,
        output wire [24:21] gp,
`else
        output wire         oled_sck,
        output wire         oled_mosi,
        output wire         oled_rst,
        output wire         oled_dc,
        output wire         oled_cs,
        output wire         oled_vccen,
        output wire         oled_pmoden,
`endif
`endif

`ifdef GPIO
        inout    wire [`GPIO_NR -1:0] gpio,
`endif

`ifdef PSRAM_MEMORY_32MB
        output   wire       psram_ss,
        output   wire       psram_sclk,
        inout    wire       psram_mosi,
        inout    wire       psram_miso,
        inout    wire       psram_sio2,
        inout    wire       psram_sio3,
        output   wire [1:0] psram_cs,
`endif  // PSRAM_MEMORY_32MB
        output wire        flash_csn,
        input  wire        flash_miso,
        output wire        flash_mosi
`ifndef ECP5
        ,output wire       flash_sclk
`endif
    );
`ifdef OLED_SD1331
`ifdef ULX3S
    wire         oled_sck;
    wire         oled_mosi;
    wire         oled_rst;
    wire         oled_dc;
    wire         oled_cs;

    assign gn[24] = oled_cs;
    assign gn[23] = oled_mosi;
    assign gn[21] = oled_sck;

    assign gp[24] = oled_dc;
    assign gp[23] = oled_rst;
    assign gp[22] = 1'b 1;
    assign gp[21] = 1'b 1;
`else
    assign oled_pmoden = 1'b 1;
    assign oled_vccen  = 1'b 1;
`endif
`endif

`ifdef SPRAM
    // SPRAM
    wire        spram_valid;
    reg         spram_ready;
    wire [31:0] spram_rdata;
`endif

`ifndef IOMEM_INTERFACING_EXTERNAL
    wire        iomem_valid;
    wire        iomem_ready;
    wire [ 3:0] iomem_wstrb;
    wire [31:0] iomem_addr;
    wire [31:0] iomem_wdata;
    wire [31:0] iomem_rdata;
`endif

`ifndef SIM
`ifdef ECP5
    wire   flash_sclk;
    wire   flash_clk;
    USRMCLK u1 (.USRMCLKI(flash_clk), .USRMCLKTS(1'b0));
    assign flash_clk          = flash_sclk;
`endif
`endif

`ifdef LED_ULX3S
    assign led = iomem_addr[31:24];
`endif

    wire resetn;
    wire clk;

`ifdef KROETE
    ice40_hx8_pll
        pll_I0 (
            clk_osc,
            clk
        );
`endif
`ifdef ICEBREAKER
    ice40up5k_pll #(
                      .freq(`SYSTEM_CLK_MHZ)
                  )
                  pll_I0 (
                      clk_osc,
                      clk
                  );
`endif

`ifdef ECP5
    pll #(
            .freq(`SYSTEM_CLK_MHZ)
        ) pll_I0 (
            clk_osc,
            clk
        );

`ifdef HDMI_VIDEO_FB
    wire clk_x5;
    pll #(
            .freq(125)
        ) pll_I1 (
            clk_osc,
            clk_x5
        );
`endif
`endif

`ifdef GPIO
    wire [31: 0] gpio_rdata;
    wire gpio_valid =  !gpio_ready && iomem_valid && (
             iomem_addr == `GPIO_DIR_ADDR      ||
             iomem_addr == `GPIO_INPUT_ADDR    ||
             iomem_addr == `GPIO_OUTPUT_ADDR
         );
    wire gpio_ready;

    gpio_ctrl
        #(
            .GPIO_NR(`GPIO_NR)
        )
        gpio_ctrl_I
        (
            .clk       ( clk         ),
            .resetn    ( resetn      ),
            .addr      ( iomem_addr  ),
            .wrstb     ( iomem_wstrb ),
            .wdata     ( iomem_wdata ),
            .rdata     ( gpio_rdata  ),
            .valid     ( gpio_valid  ),
            .ready     ( gpio_ready  ),

            .gpio      ( gpio        )
        );
`endif

`ifdef HDMI_VIDEO_FB
    wire        hdmi_video_iomem_ready;
    wire [31:0] hdmi_video_iomem_rdata;
`endif

`ifdef OLED_SD1331
    wire oled_valid =  iomem_valid &&
         (iomem_addr == `VIDEOENABLE_ADDR || iomem_addr == `VIDEO_RAW_ADDR) && |iomem_wstrb;
    wire oled_ready;

    oled_ssd1331
        #(
            .SYSTEM_CLK( `SYSTEM_CLK )
        )
        oled_ssd1331_I
        (
            .clk               ( clk                                   ),
            .resetn            ( resetn                                ),
            .setpixel_raw8tx   ( iomem_addr[3:0] == 4'h8 ? 1'b1 : 1'b0 ), // h[3]

            .x_dc              ( iomem_wdata[15: 8]                    ),
            .y_data            ( iomem_wdata[ 7: 0]                    ),
            .rgb               ( iomem_wdata[31:16]                    ),

            .valid             ( oled_valid                            ),
            .ready             ( oled_ready                            ),

            .oled_rst          ( oled_rst                              ),
            .spi_cs            ( oled_cs                               ),
            .spi_dc            ( oled_dc                               ),
            .spi_mosi          ( oled_mosi                             ),
            .spi_sck           ( oled_sck                              )
        );
`endif

`ifdef SPRAM
    // SPRAM
    assign spram_valid      = !spram_ready && iomem_valid && (iomem_addr >= `SPRAM_MEM_ADDR_START && iomem_addr < `SPRAM_MEM_ADDR_END);
    always @(posedge clk) spram_ready <= !resetn ? 0 : spram_valid;
    ice40up5k_spram
        #(
            .WORDS(32768)
        ) ice40up5k_spram_I
        (
            .clk   (   clk                                 ),
            .wen   (   iomem_wstrb & {4{spram_valid}}      ),
            .addr  (   iomem_addr[$clog2(`SPRAM_SIZE) -1:2] ),
            .wdata (   iomem_wdata                         ),
            .rdata (   spram_rdata                         )
        );
`endif

`ifdef HDMI_VIDEO_FB
    video_fb #(
                 .FB_ADDR0(`FB_ADDR0),
                 .FB_ADDR1(`FB_ADDR1),
                 .FRAME_BUFFER_CTRL(`FRAME_BUFFER_CTRL)
             ) video_fb_I (
                 .clk_pclk     ( clk_osc                              ),
                 .clk_x5       ( clk_x5                               ),
                 .clk_sys      ( clk                                  ),
                 .resetn       ( resetn                               ),
                 .gpdi_dp      ( gpdi_dp                              ),

                 .video_sel    (                                      ),
                 .iomem_valid  ( iomem_valid                          ),
                 .iomem_ready  ( hdmi_video_iomem_ready               ),
                 .iomem_wstrb  ( iomem_wstrb                          ),
                 .iomem_addr   ( iomem_addr                           ),
                 .iomem_wdata  ( iomem_wdata                          ),
                 .iomem_rdata  ( hdmi_video_iomem_rdata               )
             );
`endif

    top top_I (
            .clk_in        ( clk                       ),
            .uart_tx       ( uart_tx                   ),

`ifdef IOMEM_INTERFACING
            .iomem_valid   ( iomem_valid               ),
            .iomem_ready   ( iomem_ready               ),
            .iomem_wstrb   ( iomem_wstrb               ),
            .iomem_addr    ( iomem_addr                ),
            .iomem_wdata   ( iomem_wdata               ),
            .iomem_rdata   ( iomem_rdata               ),
`endif

`ifdef PSRAM_MEMORY_32MB
            .psram_ss      ( psram_ss                  ),
            .psram_sclk    ( psram_sclk                ),
            .psram_mosi    ( psram_mosi                ),
            .psram_miso    ( psram_miso                ),
            .psram_sio2    ( psram_sio2                ),
            .psram_sio3    ( psram_sio3                ),
            .psram_cs      ( psram_cs                  ),
`endif
            .flash_csn     ( flash_csn                 ),
            .flash_miso    ( flash_miso                ),
            .flash_mosi    ( flash_mosi                ),
            .flash_sclk    ( flash_sclk                ),
            .resetn        ( resetn                    )
        );

    assign iomem_ready =
`ifdef OLED_SD1331
           oled_ready             |
`endif
`ifdef SPRAM
           spram_ready            |
`endif
`ifdef HDMI_VIDEO_FB
           hdmi_video_iomem_ready |
`endif
`ifdef GPIO
           gpio_ready             |
`endif
           1'b 0;

    assign iomem_rdata =
`ifdef SPRAM
           spram_ready ? spram_rdata :
`endif
`ifdef HDMI_VIDEO_FB
           hdmi_video_iomem_ready ? hdmi_video_iomem_rdata :
`endif
`ifdef GPIO
           gpio_ready ? gpio_rdata :
`endif
           32'b 0;

endmodule
