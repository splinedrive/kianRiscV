/*
 *  kianv.v - RISC-V rv32im
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
`ifdef GENESYS2
        input  wire        clk200mhz_p,
        input  wire        clk200mhz_n,
`else
        input  wire         clk_osc,
`endif
`ifdef UART_TX
        output wire         uart_tx,
`endif
`ifdef ICESTICK
        output wire [ 4: 0] led,
`endif
`ifdef ICEFUN
        /* led  */
        output wire led1,
        output wire led2,
        output wire led3,
        output wire led4,
        output wire led5,
        output wire led6,
        output wire led7,
        output wire led8,
        output wire lcol1,
        output wire lcol2,
        output wire lcol3,
        output wire lcol4,
`endif
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

`ifdef ARTIX7
`ifdef HDMI_VIDEO_FB
        output wire [ 3: 0] hdmi_p,
        output wire [ 3: 0] hdmi_n,
`endif
`ifdef ARTY7
        output wire [ 3: 0] led,
`elsif NEXYSA7
        output wire [ 15: 0] led,
        output wire CA,
        output wire CB,
        output wire CC,
        output wire CD,
        output wire CE,
        output wire CF,
        output wire CG,
        output wire DP,
        output wire [ 7: 0] AN,
        input  wire [ 0: 0] SW,
`elsif NEXYS_VIDEO
        output wire [ 7: 0] led,
`elsif GENESYS2
        output wire [ 7: 0] led,
`elsif CMODA7
        output wire [ 1: 0] led,
`elsif WUKONG
        output wire [ 1: 0] led,
`endif
`endif

`ifdef LED_KROETE
        //  output wire [3:0]  led,
        output wire [2:0]  led,
`endif

`ifdef HDMI_VIDEO_FB
`ifdef ECP5
        output wire [3:0] gpdi_dp,
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

`ifdef ECP5
`define USR_SCLK
`endif
`ifdef ARTIX7
`define USR_SCLK
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
`ifndef BRAM_FIRMWARE
        output wire        flash_csn,
        input  wire        flash_miso,
        output wire        flash_mosi
`ifndef USR_SCLK
        ,output wire       flash_sclk
`endif
`endif
    );

    wire resetn;
    wire clk;

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

`ifdef PC_OUT
    wire [31: 0] PC;
`endif

`ifdef CPU_HALT
    wire halt;
`endif

`ifndef SIM
`ifdef ECP5
    wire   flash_sclk;
    wire   flash_clk;
    USRMCLK u1 (.USRMCLKI(flash_clk), .USRMCLKTS(1'b0));
    assign flash_clk          = flash_sclk;
`endif

`ifdef ARTIX7
    wire   flash_sclk;
    wire   flash_clk;
    STARTUPE2 STARTUPE2
              (.CLK(1'b0),
               .GSR(1'b0),
               .GTS(1'b0),
               .KEYCLEARB(1'b1),
               .PACK(1'b0),
               .PREQ(),

               // Drive clock.
               .USRCCLKO(flash_clk),
               .USRCCLKTS(1'b0),

               // These control the DONE pin.  UG470 says USRDONETS should
               // usually be low to enable DONE output.  But by default
               // (i.e. when the STARTUPE2 is not instaintiated), the DONE pin
               // goes to hi-z after initialization.  This is how to do that.
               .USRDONEO(1'b0),
               .USRDONETS(1'b1),

               .CFGCLK(),
               .CFGMCLK(),
               .EOS());
    assign flash_clk          = flash_sclk;
`endif
`endif

`ifdef LED_ULX3S
    assign led = iomem_addr[31:24];
`endif

`ifdef ARTIX7
    localparam cnt_msb = $clog2(`SYSTEM_CLK);
    wire [cnt_msb -1: 0] cnt;
    counter #(cnt_msb) led_cnt_I (resetn, clk, 1'b 1, cnt);
    wire   led_msb = cnt[cnt_msb -1];
`ifdef ARTY7
    assign led = {~led_msb, led_msb, led_msb, ~led_msb};  // 0 is on
`elsif NEXYS_VIDEO
    assign led =
           {
               ~led_msb, ~led_msb, led_msb, led_msb,
               ~led_msb, ~led_msb, led_msb, led_msb
           };
`elsif GENESYS2
    assign led =
           {
               ~led_msb, ~led_msb, led_msb, led_msb,
               ~led_msb, ~led_msb, led_msb, led_msb
           };
`elsif CMODA7
    assign led =
           {
               ~led_msb, ~led_msb
           };
`elsif NEXYSA7
    assign halt = !SW[0];
    reg [ 1: 0] halt_sync;
    always @(posedge clk) halt_sync <= {halt_sync[0], halt};
    assign led =
           {
               ~led_msb, ~led_msb, led_msb, led_msb,
               ~led_msb, ~led_msb, led_msb, led_msb,
               ~led_msb, ~led_msb, led_msb, led_msb,
               ~led_msb, ~led_msb, led_msb, led_msb
           };  // 0 is on
`ifdef PC_OUT
    eight_seg_display pc_disp_I( clk, PC, CA, CB, CC, CD, CE, CF, CG, DP, AN );
`endif
`elsif WUKONG
    //    IBUF ibuf_I (.I(clk_osc), .O(clk_oscn));
    assign led = {~cnt[cnt_msb], cnt[cnt_msb]};
`endif
`ifdef GENESYS2
    wire clk_osc;
    IBUFDS ibufds_i (
               .O  (clk_osc),
               .I  (clk200mhz_p),
               .IB (clk200mhz_n));
`endif

    wire clk_x5;
    wire pclk;

    sys_clks sys_clks_I
             (
                 .pclk        ( pclk     ),
                 .pclk_x5     ( clk_x5   ),
                 .sys_clk     ( clk      ),
                 .clk_osc     ( clk_osc  )
             );

`endif

`ifdef KROETE
    ice40_hx8_pll
        pll_I0 (
            clk_osc,
            clk
        );
`endif

`ifdef TANGNANO1K
    assign clk = clk_osc;
`endif
`ifdef ICESTICK
    ice40hx8pll
        #(
            .freq(`SYSTEM_CLK_MHZ)
        ) pll_I0 (
            clk_osc,
            clk
        );
    //localparam cnt_msb = $clog2(`SYSTEM_CLK);
    localparam cnt_msb = 23;
    wire [cnt_msb -1: 0] cnt;
    counter #(cnt_msb) led_cnt_I (resetn, clk, 1'b 1, cnt);
    wire   led_msb = cnt[cnt_msb -1];
    assign led = {led_msb, ~led_msb, ~led_msb, ~led_msb, ~led_msb};  // 0 is on
`endif


`ifdef ICEFUN
    ice40hx8pll
        #(
            .freq(`SYSTEM_CLK_MHZ)
        ) pll_I0 (
            clk_osc,
            clk
        );

    wire [7:0] leds1;
    wire [7:0] leds2;
    wire [7:0] leds3;
    wire [7:0] leds4;

    wire [7:0] leds;
    wire [3:0] lcol;

    assign { led8, led7, led6, led5, led4, led3, led2, led1 } = leds[7:0];
    assign { lcol4, lcol3, lcol2, lcol1 } = lcol[3:0];

`ifdef PC_OUT
    assign leds1 = ~PC[31:24];
    assign leds2 = ~PC[23:16];
    assign leds3 = ~PC[15: 8];
    assign leds4 = ~PC[7 : 0];
`endif

`ifdef LED_MATRIX8X4_FB
    wire [31: 0] PC;
    assign leds1 = ~led_matrix8x4_fb[31:24];
    assign leds2 = ~led_matrix8x4_fb[23:16];
    assign leds3 = ~led_matrix8x4_fb[15: 8];
    assign leds4 = ~led_matrix8x4_fb[7 : 0];

    reg led_matrix_ready;
    reg  [31: 0] led_matrix8x4_fb;

    wire led_matrix_valid =  !led_matrix_ready && iomem_valid && (iomem_addr == `LED8X4_FB_ADDR);

    always @(posedge clk) begin
        if (led_matrix_valid && |iomem_wstrb) begin
            led_matrix8x4_fb <= iomem_wdata;
        end
        led_matrix_ready <= !resetn ? 0 : led_matrix_valid;
    end
`endif

    led_matrix8x4 #( .SYSTEM_FREQ( `SYSTEM_CLK) )
                  led_matrix_I
                  (
                      .clk     ( clk   ),
                      .leds1   ( leds1 ),
                      .leds2   ( leds2 ),
                      .leds3   ( leds3 ),
                      .leds4   ( leds4 ),
                      .leds    ( leds  ),
                      .lcol    ( lcol  )
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
    wire         gpio_ready;

    wire gpio_valid =  !gpio_ready && iomem_valid && (
             iomem_addr == `GPIO_DIR_ADDR      ||
             iomem_addr == `GPIO_INPUT_ADDR    ||
             iomem_addr == `GPIO_OUTPUT_ADDR
         );
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
    wire oled_valid =  !oled_ready && iomem_valid &&
         (iomem_addr == `VIDEOENABLE_ADDR || iomem_addr == `VIDEO_RAW_ADDR) && |iomem_wstrb;
    wire oled_ready;

    oled_ssd1331
        #(
            .SYSTEM_CLK         ( `SYSTEM_CLK )
`ifdef ICESTICK
            ,.SPI_TRANSFER_RATE ( 5_000_000  )
`endif
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
`ifdef ECP5
                 .clk_pclk     ( clk_osc                              ),
`elsif ARTIX7
                 .clk_pclk     ( pclk                                 ),
`endif
                 .clk_x5       ( clk_x5                               ),
                 .clk_sys      ( clk                                  ),
                 .resetn       ( resetn                               ),
`ifdef ECP5
                 .gpdi_dp      ( gpdi_dp                              ),
`elsif ARTIX7
                 .hdmi_p       ( hdmi_p                               ),
                 .hdmi_n       ( hdmi_n                               ),
`endif

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
`ifdef UART_TX
            .uart_tx       ( uart_tx                   ),
`endif
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
`ifndef BRAM_FIRMWARE
            .flash_csn     ( flash_csn                 ),
            .flash_miso    ( flash_miso                ),
            .flash_mosi    ( flash_mosi                ),
            .flash_sclk    ( flash_sclk                ),
`endif
            .resetn        ( resetn                    ),
`ifdef PC_OUT
            .PC            ( PC                        ),
`else
            .PC            (                           ),
`endif
`ifdef CPU_HALT
            .halt          ( halt_sync[1]              )
`else
            .halt          (                           )
`endif
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
`ifdef LED_MATRIX8X4_FB
           led_matrix_ready       |
`endif
           1'b 0;

    assign iomem_rdata =
`ifdef SPRAM
           spram_ready            ? spram_rdata :
`endif
`ifdef HDMI_VIDEO_FB
           hdmi_video_iomem_ready ? hdmi_video_iomem_rdata :
`endif
`ifdef GPIO
           gpio_ready             ? gpio_rdata :
`endif
`ifdef GPIO
           gpio_ready             ? gpio_rdata :
`endif
`ifdef LED_MATRIX8X4_FB
           led_matrix_ready       ? led_matrix8x4_fb :
`endif
           32'b 0;

endmodule
`ifdef ARTIX7
module sys_clks

    (// Clock in ports
        // Clock out ports
        output        wire pclk,
        output        wire pclk_x5,
        output        wire sys_clk,
        input         wire clk_osc
    );
    // Input buffering
    //------------------------------------
    wire clk_osc_sys_clks;
    wire clk_in2_sys_clks;
    IBUF clkin1_ibufg
         (.O (clk_osc_sys_clks),
          .I (clk_osc));




    // Clocking PRIMITIVE
    //------------------------------------

    // Instantiation of the MMCM PRIMITIVE
    //    * Unused inputs are tied off
    //    * Unused outputs are labeled unused

    wire        pclk_sys_clks;
    wire        pclk_x5_sys_clks;
    wire        sys_clk_sys_clks;
    wire        clk_out4_sys_clks;
    wire        clk_out5_sys_clks;
    wire        clk_out6_sys_clks;
    wire        clk_out7_sys_clks;

    wire [15:0] do_unused;
    wire        drdy_unused;
    wire        psdone_unused;
    wire        locked_int;
    wire        clkfbout_sys_clks;
    wire        clkfbout_buf_sys_clks;
    wire        clkfboutb_unused;
    wire clkout0b_unused;
    wire clkout1b_unused;
    wire clkout2b_unused;
    wire clkout3_unused;
    wire clkout3b_unused;
    wire clkout4_unused;
    wire        clkout5_unused;
    wire        clkout6_unused;
    wire        clkfbstopped_unused;
    wire        clkinstopped_unused;

`ifdef ARTY7
    MMCME2_ADV
        #(.BANDWIDTH            ("OPTIMIZED"),
          .CLKOUT4_CASCADE      ("FALSE"),
          .COMPENSATION         ("ZHOLD"),
          .STARTUP_WAIT         ("FALSE"),
          .DIVCLK_DIVIDE        (1),
          .CLKFBOUT_MULT_F      (8.750),
          .CLKFBOUT_PHASE       (0.000),
          .CLKFBOUT_USE_FINE_PS ("FALSE"),
          .CLKOUT0_DIVIDE_F     (35.000),
          .CLKOUT0_PHASE        (0.000),
          .CLKOUT0_DUTY_CYCLE   (0.500),
          .CLKOUT0_USE_FINE_PS  ("FALSE"),
          .CLKOUT1_DIVIDE       (7),
          .CLKOUT1_PHASE        (0.000),
          .CLKOUT1_DUTY_CYCLE   (0.500),
          .CLKOUT1_USE_FINE_PS  ("FALSE"),
          .CLKOUT2_DIVIDE       (5),
          .CLKOUT2_PHASE        (0.000),
          .CLKOUT2_DUTY_CYCLE   (0.500),
          .CLKOUT2_USE_FINE_PS  ("FALSE"),
          .CLKIN1_PERIOD        (10.000))
        mmcm_adv_inst
        // Output clocks
        (
            .CLKFBOUT            (clkfbout_sys_clks),
            .CLKFBOUTB           (clkfboutb_unused),
            .CLKOUT0             (pclk_sys_clks),
            .CLKOUT0B            (clkout0b_unused),
            .CLKOUT1             (pclk_x5_sys_clks),
            .CLKOUT1B            (clkout1b_unused),
            .CLKOUT2             (sys_clk_sys_clks),
            .CLKOUT2B            (clkout2b_unused),
            .CLKOUT3             (clkout3_unused),
            .CLKOUT3B            (clkout3b_unused),
            .CLKOUT4             (clkout4_unused),
            .CLKOUT5             (clkout5_unused),
            .CLKOUT6             (clkout6_unused),
            // Input clock control
            .CLKFBIN             (clkfbout_buf_sys_clks),
            .CLKIN1              (clk_osc_sys_clks),
            .CLKIN2              (1'b0),
            // Tied to always select the primary input clock
            .CLKINSEL            (1'b1),
            // Ports for dynamic reconfiguration
            .DADDR               (7'h0),
            .DCLK                (1'b0),
            .DEN                 (1'b0),
            .DI                  (16'h0),
            .DO                  (do_unused),
            .DRDY                (drdy_unused),
            .DWE                 (1'b0),
            // Ports for dynamic phase shift
            .PSCLK               (1'b0),
            .PSEN                (1'b0),
            .PSINCDEC            (1'b0),
            .PSDONE              (psdone_unused),
            // Other control and status signals
            .LOCKED              (locked_int),
            .CLKINSTOPPED        (clkinstopped_unused),
            .CLKFBSTOPPED        (clkfbstopped_unused),
            .PWRDWN              (1'b0),
            .RST                 (1'b0));

`elsif NEXYSA7

    MMCME2_ADV
        #(.BANDWIDTH            ("OPTIMIZED"),
          .CLKOUT4_CASCADE      ("FALSE"),
          .COMPENSATION         ("ZHOLD"),
          .STARTUP_WAIT         ("FALSE"),
          .DIVCLK_DIVIDE        (1),
          .CLKFBOUT_MULT_F      (10.000),
          .CLKFBOUT_PHASE       (0.000),
          .CLKFBOUT_USE_FINE_PS ("FALSE"),
          .CLKOUT0_DIVIDE_F     (40.000),
          .CLKOUT0_PHASE        (0.000),
          .CLKOUT0_DUTY_CYCLE   (0.500),
          .CLKOUT0_USE_FINE_PS  ("FALSE"),
          .CLKOUT1_DIVIDE       (4),
          .CLKOUT1_PHASE        (0.000),
          .CLKOUT1_DUTY_CYCLE   (0.500),
          .CLKOUT1_USE_FINE_PS  ("FALSE"),
          .CLKOUT2_DIVIDE       (8),
          .CLKOUT2_PHASE        (0.000),
          .CLKOUT2_DUTY_CYCLE   (0.500),
          .CLKOUT2_USE_FINE_PS  ("FALSE"),
          .CLKIN1_PERIOD        (10.000))
        mmcm_adv_inst
        // Output clocks
        (
            .CLKFBOUT            (clkfbout_sys_clks),
            .CLKFBOUTB           (clkfboutb_unused),
            .CLKOUT0             (pclk_sys_clks),
            .CLKOUT0B            (clkout0b_unused),
            .CLKOUT1             (pclk_x5_sys_clks),
            .CLKOUT1B            (clkout1b_unused),
            .CLKOUT2             (sys_clk_sys_clks),
            .CLKOUT2B            (clkout2b_unused),
            .CLKOUT3             (clkout3_unused),
            .CLKOUT3B            (clkout3b_unused),
            .CLKOUT4             (clkout4_unused),
            .CLKOUT5             (clkout5_unused),
            .CLKOUT6             (clkout6_unused),
            // Input clock control
            .CLKFBIN             (clkfbout_buf_sys_clks),
            .CLKIN1              (clk_osc_sys_clks),
            .CLKIN2              (1'b0),
            // Tied to always select the primary input clock
            .CLKINSEL            (1'b1),
            // Ports for dynamic reconfiguration
            .DADDR               (7'h0),
            .DCLK                (1'b0),
            .DEN                 (1'b0),
            .DI                  (16'h0),
            .DO                  (do_unused),
            .DRDY                (drdy_unused),
            .DWE                 (1'b0),
            // Ports for dynamic phase shift
            .PSCLK               (1'b0),
            .PSEN                (1'b0),
            .PSINCDEC            (1'b0),
            .PSDONE              (psdone_unused),
            // Other control and status signals
            .LOCKED              (locked_int),
            .CLKINSTOPPED        (clkinstopped_unused),
            .CLKFBSTOPPED        (clkfbstopped_unused),
            .PWRDWN              (1'b0),
            .RST                 (1'b0));


`elsif NEXYS_VIDEO

    MMCME2_ADV
        #(.BANDWIDTH            ("OPTIMIZED"),
          .CLKOUT4_CASCADE      ("FALSE"),
          .COMPENSATION         ("ZHOLD"),
          .STARTUP_WAIT         ("FALSE"),
          .DIVCLK_DIVIDE        (1),
          .CLKFBOUT_MULT_F      (7.500),
          .CLKFBOUT_PHASE       (0.000),
          .CLKFBOUT_USE_FINE_PS ("FALSE"),
          .CLKOUT0_DIVIDE_F     (30.000),
          .CLKOUT0_PHASE        (0.000),
          .CLKOUT0_DUTY_CYCLE   (0.500),
          .CLKOUT0_USE_FINE_PS  ("FALSE"),
          .CLKOUT1_DIVIDE       (3),
          .CLKOUT1_PHASE        (0.000),
          .CLKOUT1_DUTY_CYCLE   (0.500),
          .CLKOUT1_USE_FINE_PS  ("FALSE"),
          .CLKOUT2_DIVIDE       (5),
          .CLKOUT2_PHASE        (0.000),
          .CLKOUT2_DUTY_CYCLE   (0.500),
          .CLKOUT2_USE_FINE_PS  ("FALSE"),
          .CLKIN1_PERIOD        (10.000))
        mmcm_adv_inst
        // Output clocks
        (
            .CLKFBOUT            (clkfbout_sys_clks),
            .CLKFBOUTB           (clkfboutb_unused),
            .CLKOUT0             (pclk_sys_clks),
            .CLKOUT0B            (clkout0b_unused),
            .CLKOUT1             (pclk_x5_sys_clks),
            .CLKOUT1B            (clkout1b_unused),
            .CLKOUT2             (sys_clk_sys_clks),
            .CLKOUT2B            (clkout2b_unused),
            .CLKOUT3             (clkout3_unused),
            .CLKOUT3B            (clkout3b_unused),
            .CLKOUT4             (clkout4_unused),
            .CLKOUT5             (clkout5_unused),
            .CLKOUT6             (clkout6_unused),
            // Input clock control
            .CLKFBIN             (clkfbout_buf_sys_clks),
            .CLKIN1              (clk_osc_sys_clks),
            .CLKIN2              (1'b0),
            // Tied to always select the primary input clock
            .CLKINSEL            (1'b1),
            // Ports for dynamic reconfiguration
            .DADDR               (7'h0),
            .DCLK                (1'b0),
            .DEN                 (1'b0),
            .DI                  (16'h0),
            .DO                  (do_unused),
            .DRDY                (drdy_unused),
            .DWE                 (1'b0),
            // Ports for dynamic phase shift
            .PSCLK               (1'b0),
            .PSEN                (1'b0),
            .PSINCDEC            (1'b0),
            .PSDONE              (psdone_unused),
            // Other control and status signals
            .LOCKED              (locked_int),
            .CLKINSTOPPED        (clkinstopped_unused),
            .CLKFBSTOPPED        (clkfbstopped_unused),
            .PWRDWN              (1'b0),
            .RST                 (1'b0));

`elsif GENESYS2
/*
    MMCME2_ADV
        #(.BANDWIDTH            ("OPTIMIZED"),
          .CLKOUT4_CASCADE      ("FALSE"),
          .COMPENSATION         ("ZHOLD"),
          .STARTUP_WAIT         ("FALSE"),
          .DIVCLK_DIVIDE        (1),
          .CLKFBOUT_MULT_F      (3.750),
          .CLKFBOUT_PHASE       (0.000),
          .CLKFBOUT_USE_FINE_PS ("FALSE"),
          .CLKOUT0_DIVIDE_F     (30.000),
          .CLKOUT0_PHASE        (0.000),
          .CLKOUT0_DUTY_CYCLE   (0.500),
          .CLKOUT0_USE_FINE_PS  ("FALSE"),
          .CLKOUT1_DIVIDE       (6),
          .CLKOUT1_PHASE        (0.000),
          .CLKOUT1_DUTY_CYCLE   (0.500),
          .CLKOUT1_USE_FINE_PS  ("FALSE"),
          .CLKOUT2_DIVIDE       (5),
          .CLKOUT2_PHASE        (0.000),
          .CLKOUT2_DUTY_CYCLE   (0.500),
          .CLKOUT2_USE_FINE_PS  ("FALSE"),
          .CLKIN1_PERIOD        (5.000))
        mmcm_adv_inst
        // Output clocks
        (
            .CLKFBOUT            (clkfbout_sys_clks),
            .CLKFBOUTB           (clkfboutb_unused),
            .CLKOUT0             (pclk_sys_clks),
            .CLKOUT0B            (clkout0b_unused),
            .CLKOUT1             (pclk_x5_sys_clks),
            .CLKOUT1B            (clkout1b_unused),
            .CLKOUT2             (sys_clk_sys_clks),
            .CLKOUT2B            (clkout2b_unused),
            .CLKOUT3             (clkout3_unused),
            .CLKOUT3B            (clkout3b_unused),
            .CLKOUT4             (clkout4_unused),
            .CLKOUT5             (clkout5_unused),
            .CLKOUT6             (clkout6_unused),
            // Input clock control
            .CLKFBIN             (clkfbout_buf_sys_clks),
            .CLKIN1              (clk_osc_sys_clks),
            .CLKIN2              (1'b0),
            // Tied to always select the primary input clock
            .CLKINSEL            (1'b1),
            // Ports for dynamic reconfiguration
            .DADDR               (7'h0),
            .DCLK                (1'b0),
            .DEN                 (1'b0),
            .DI                  (16'h0),
            .DO                  (do_unused),
            .DRDY                (drdy_unused),
            .DWE                 (1'b0),
            // Ports for dynamic phase shift
            .PSCLK               (1'b0),
            .PSEN                (1'b0),
            .PSINCDEC            (1'b0),
            .PSDONE              (psdone_unused),
            // Other control and status signals
            .LOCKED              (locked_int),
            .CLKINSTOPPED        (clkinstopped_unused),
            .CLKFBSTOPPED        (clkfbstopped_unused),
            .PWRDWN              (1'b0),
            .RST                 (1'b0));
            */
            MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (5.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (40.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (8),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (5),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (5.000))
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_sys_clks),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (pclk_sys_clks),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (pclk_x5_sys_clks),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (sys_clk_sys_clks),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_sys_clks),
    .CLKIN1              (clk_osc_sys_clks),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0));

`elsif CMODA7
     MMCME2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (62.250),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (29.875),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (3),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (9),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (83.333))
  mmcm_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_sys_clks),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (pclk_sys_clks),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (pclk_x5_sys_clks),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (sys_clk_sys_clks),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_sys_clks),
    .CLKIN1              (clk_osc_sys_clks),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0)); 
`elsif WUKONG

    MMCME2_ADV
        #(.BANDWIDTH            ("OPTIMIZED"),
          .CLKOUT4_CASCADE      ("FALSE"),
          .COMPENSATION         ("ZHOLD"),
          .STARTUP_WAIT         ("FALSE"),
          .DIVCLK_DIVIDE        (1),
          .CLKFBOUT_MULT_F      (17.500),
          .CLKFBOUT_PHASE       (0.000),
          .CLKFBOUT_USE_FINE_PS ("FALSE"),
          .CLKOUT0_DIVIDE_F     (35.000),
          .CLKOUT0_PHASE        (0.000),
          .CLKOUT0_DUTY_CYCLE   (0.500),
          .CLKOUT0_USE_FINE_PS  ("FALSE"),
          .CLKOUT1_DIVIDE       (7),
          .CLKOUT1_PHASE        (0.000),
          .CLKOUT1_DUTY_CYCLE   (0.500),
          .CLKOUT1_USE_FINE_PS  ("FALSE"),
          .CLKOUT2_DIVIDE       (5),
          .CLKOUT2_PHASE        (0.000),
          .CLKOUT2_DUTY_CYCLE   (0.500),
          .CLKOUT2_USE_FINE_PS  ("FALSE"),
          .CLKIN1_PERIOD        (20.000))
        mmcm_adv_inst
        // Output clocks
        (
            .CLKFBOUT            (clkfbout_sys_clks),
            .CLKFBOUTB           (clkfboutb_unused),
            .CLKOUT0             (pclk_sys_clks),
            .CLKOUT0B            (clkout0b_unused),
            .CLKOUT1             (pclk_x5_sys_clks),
            .CLKOUT1B            (clkout1b_unused),
            .CLKOUT2             (sys_clk_sys_clks),
            .CLKOUT2B            (clkout2b_unused),
            .CLKOUT3             (clkout3_unused),
            .CLKOUT3B            (clkout3b_unused),
            .CLKOUT4             (clkout4_unused),
            .CLKOUT5             (clkout5_unused),
            .CLKOUT6             (clkout6_unused),
            // Input clock control
            .CLKFBIN             (clkfbout_buf_sys_clks),
            .CLKIN1              (clk_osc_sys_clks),
            .CLKIN2              (1'b0),
            // Tied to always select the primary input clock
            .CLKINSEL            (1'b1),
            // Ports for dynamic reconfiguration
            .DADDR               (7'h0),
            .DCLK                (1'b0),
            .DEN                 (1'b0),
            .DI                  (16'h0),
            .DO                  (do_unused),
            .DRDY                (drdy_unused),
            .DWE                 (1'b0),
            // Ports for dynamic phase shift
            .PSCLK               (1'b0),
            .PSEN                (1'b0),
            .PSINCDEC            (1'b0),
            .PSDONE              (psdone_unused),
            // Other control and status signals
            .LOCKED              (locked_int),
            .CLKINSTOPPED        (clkinstopped_unused),
            .CLKFBSTOPPED        (clkfbstopped_unused),
            .PWRDWN              (1'b0),
            .RST                 (1'b0));

    // Clock Monitor clock assigning
    //--------------------------------------
    // Output buffering
    //-----------------------------------

`endif
    BUFG clkf_buf
         (.O (clkfbout_buf_sys_clks),
          .I (clkfbout_sys_clks));


    BUFG clkout1_buf
         (.O   (pclk),
          .I   (pclk_sys_clks));


    BUFG clkout2_buf
         (.O   (pclk_x5),
          .I   (pclk_x5_sys_clks));

    BUFG clkout3_buf
         (.O   (sys_clk),
          .I   (sys_clk_sys_clks));
endmodule
`endif
