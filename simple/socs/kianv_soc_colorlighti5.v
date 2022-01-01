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
 `default_nettype none
 `timescale 1ns/1ps
 `include "kianv_soc_hw_reg.v"
 `define FLASH_EXECUTION  // start from NOR-Flash
 `define RV32M
 `define CSR_TIME_COUNTER
 module kianv_soc_colorlighti5(
   input  wire clk_25mhz,
   output wire led,
   output wire rxd,

   output wire  oled_cs,
   output wire  oled_mosi,
   output wire  oled_sck,
   output wire  oled_dc,
   output wire  oled_rst,
   output wire  oled_vccen,
   output wire  oled_pmoden,

   //           output wire wifi_en,

   output wire flash_csn,
   input  wire flash_miso,
   output wire flash_mosi,
   output wire flash_holdn,
   output wire flash_wpn,

   // gpio
   inout [7:0] gpio
 );

 localparam GPIO_NR = 8;
 `include "gpio.v"

 /* uart */
 wire         uart_tx;
 assign rxd = uart_tx;

 //localparam SYSTEM_CLK = 110_000_000;
 localparam SYSTEM_CLK = 115_000_000;

 /* pll */
 wire clk;
 pll #(SYSTEM_CLK/1_000_000) pll_i(clk_25mhz, clk);

 /* flash */
 wire spi_mem_flash_sclk;
 wire spi_mem_flash_cs;
 wire spi_mem_flash_miso;
 wire spi_mem_flash_mosi;
 wire flash_holdn = 1'b1;
 wire flash_wpn   = 1'b1;

 wire flash_clk;
 USRMCLK u1 (.USRMCLKI(flash_clk), .USRMCLKTS(1'b0));

 assign flash_csn = spi_mem_flash_cs;
 assign flash_clk = spi_mem_flash_sclk;
 assign flash_miso = spi_mem_flash_miso;
 assign flash_mosi = spi_mem_flash_mosi;

 localparam PWM_MSB = 13;


 // reset
 reg [15:0] reset_cnt = 0;
 wire resetn = &reset_cnt;
 always @(posedge clk) begin
   reset_cnt <= reset_cnt + {14'b0, !resetn};
 end

 reg [$clog2(SYSTEM_CLK) -1: 0] cnt = 0;

 wire tick = cnt == (SYSTEM_CLK -1);
 reg led;
 always @(posedge clk) begin
   cnt <= (tick) ? 0 : cnt + 1;
   led <= led ^ tick;
 end

 localparam BRAM_SIZE = 393216/2/4;  // 98304 word
 localparam FLASH_PC_START = 32'h 20_000_000 + (1024*64*16);  // 1M
 // cpu memory ctrl signals
 wire [3:0]  mem_wmask;
 wire        mem_rd;
 wire [31:0] mem_addr;
 wire [31:0] mem_din;
 reg  [31:0] mem_dout;
 reg         mem_valid;
 reg         mem_ready;
 wire [31:0] pc;

 // bram memory
 reg  [3:0]  mem_bram_wmask;
 reg         mem_bram_rd;
 reg  [31:0] mem_bram_addr;
 reg  [31:0] mem_bram_data_in;
 wire [31:0] mem_bram_data_out;

 // uart
 reg         uart_strobe;
 reg [7:0]   uart_tx_data;
 wire        uart_ready;

 // spi memory
 reg [23:0]  mem_spi_addr;
 reg         mem_spi_cs;
 reg         mem_spi_rd;
 reg  [3:0]  mem_spi_wmask;

 wire [31:0] mem_spi_data_out;

 wire        mem_spi_ready;
 wire        mem_spi_valid;

 // spram memory
 reg  [21 :0] mem_spram_addr;
 reg  [3  :0] mem_spram_wmask;
 reg  [31 :0] mem_spram_data_in;
 wire [31 :0] mem_spram_data_out;

 // oled
 reg [7:0]    oled_x_dc;
 reg [7:0]    oled_y_data;
 reg [15:0]   oled_rgb;
 reg          oled_strobe;
 reg          oled_setpixel_raw8tx;

 wire         oled_ready;
 wire         oled_valid;


 always @(*) begin
   // bram
   mem_bram_wmask    = 0;
   mem_bram_rd       = 1'b0;
   mem_bram_addr     = 0;
   mem_bram_data_in  = 0;

   // spi flash memory
   mem_spi_addr      = 0;
   mem_spi_wmask     = 0;
   mem_spi_rd        = 1'b0;
   mem_spi_cs        = 1'b0;

   // uart
   uart_strobe       = 1'b0;
   uart_tx_data      = 0;

   // spram
   mem_spram_addr     = 0;
   mem_spram_wmask    = 0;
   mem_spram_data_in  = 0;

   // ctrl signals
   mem_dout                 = 0;
   mem_valid                = 1'b0;
   mem_ready                = 1'b0;

   oled_x_dc                = 0;
   oled_y_data              = 0;
   oled_rgb                 = 0;
   oled_setpixel_raw8tx     = 0;
   oled_strobe              = 0;

   // gpio
   gpio_output_wr               = 1'b0;
   gpio_output_en_wr            = 1'b0;
   gpio_output_val_wr           = 1'b0;

   /* ram */
   if ((mem_addr >= 0 && mem_addr < BRAM_SIZE)) begin
     /* ---> */
     mem_bram_addr     = {mem_addr[$clog2(BRAM_SIZE) -1:2], 2'b00} >> 2;
     mem_bram_wmask    = mem_wmask;
     mem_bram_data_in  = mem_din;
     mem_bram_rd       = mem_rd;
     /* <--- */
     mem_ready         = 1'b1;
     mem_dout          = mem_bram_data_out;
     mem_valid         = 1'b1;
     /* spram */
   end else if (mem_addr >= 32'h 10_00_0000 && mem_addr < (32'h 10_00_0000 + (32*1024*4))) begin
     /* 32kx32 */
     /* ---> */
     mem_spram_addr          = {mem_addr[$clog2(32*1024*4) -1:2], 2'b00} >> 2;
     mem_spram_wmask         = mem_wmask;
     mem_spram_data_in       = mem_din;

     /* <--- */
     mem_ready              = 1'b1;
     mem_dout               = mem_spram_data_out;
     mem_valid              = 1'b1;
     /* spi flash rom */
   end else if (mem_addr >= 32'h 20_00_0000 && mem_addr < (32'h 20_00_0000 + (1024*1024*16))) begin
     /* ---> */
     mem_spi_cs        = 1'b1;
     mem_spi_addr      = {mem_addr[$clog2(1024*1024*16) -1:2], 2 'b00} >> 2;
     mem_spi_wmask     = mem_wmask;
     mem_spi_rd        = mem_rd;
     /* <--- */
     mem_ready         = mem_spi_ready;
     mem_dout          = mem_spi_data_out;
     mem_valid         = mem_spi_valid;
   end else if (mem_addr == 32'h 30_00_0000) begin
     /* uart write */
     /* ---> */
     if (|mem_wmask) begin
       uart_strobe       = 1'b1;
       uart_tx_data      = mem_din[7:0];
     end
     /* uart ready */
     /* <--- */
     if (mem_rd) mem_dout      = {{31{1'b0}}, uart_ready};
     mem_ready         = 1'b1;
   //mem_valid         = mem_rd ? 1'b1 : uart_ready;
   mem_valid         = uart_ready;
 end else if (mem_addr == 32'h 30_00_0008 || mem_addr == 32'h 30_00_000C) begin
   /* oled write */
   /* ---> */
   if (|mem_wmask) begin
     oled_strobe          = 1'b1;
     oled_setpixel_raw8tx = mem_addr[3:0] == 4'h8 ? 1'b1 : 1'b0;
     oled_x_dc            = mem_din[15:8];
     oled_y_data          = mem_din[7:0];
     oled_rgb             = mem_din[31:16];
   end

   /* <--- */
   mem_ready         = oled_ready;
   mem_valid         = oled_valid;
 end else if (mem_addr == CPU_FREQ_REG) begin
   /* get system frequency */
   mem_dout         = SYSTEM_CLK;
   mem_ready        = 1'b1;
   mem_valid        = 1'b1;
 end else if (mem_addr == GPIO_DIR) begin
   if (|mem_wmask) begin
     gpio_output_en_wr   = 1'b1;
   end
   if (mem_rd) begin
     mem_dout = {24'hz, gpio_output_en};
   end
   mem_ready            = 1'b1;
   mem_valid            = 1'b1;
   /*
 end else if (mem_addr == GPIO_PULLUP) begin
   mem_ready        = 1'b1;
   mem_valid        = 1'b1;
   */
 end else if (mem_addr == GPIO_OUTPUT) begin
   if (|mem_wmask) begin
     gpio_output_val_wr   = 1'b1;
   end
   if (mem_rd) begin
     mem_dout = gpio_output_val;
   end
   mem_ready            = 1'b1;
   mem_valid            = 1'b1;
 end else if (mem_addr == GPIO_INPUT) begin
   if (mem_rd) begin
     mem_dout = gpio_in;
   end
   mem_ready            = 1'b1;
   mem_valid            = 1'b1;
 end else begin
   /* default */
   if (~mem_wmask & ~mem_rd) begin
     mem_ready = 1'b1;
     mem_valid = 1'b1;
   end
 end

end

my_tx_uart #(.SYSTEM_CLK(SYSTEM_CLK), .BAUDRATE(115200))
my_tx_uart_i(
  .clk(clk),
  .resetn(resetn),
  .strobe(uart_strobe),
  .tx_data(uart_tx_data),
  .tx_out(uart_tx),
  .ready(uart_ready)
);

spi_flash_mem spi_flash_mem_i(
  .clk(clk),
  .resetn(resetn),

  .cs(mem_spi_cs),
  .rd(mem_spi_rd),
  .addr(mem_spi_addr[21:0]),
  .wmask(mem_spi_wmask),

  .data(mem_spi_data_out),

  .ready(mem_spi_ready),
  .valid(mem_spi_valid),

  .spi_cs(spi_mem_flash_cs),
  .spi_miso(spi_mem_flash_miso),
  .spi_mosi(spi_mem_flash_mosi),
  .spi_sclk(spi_mem_flash_sclk)
);

oled_ssd1331 #(.SYSTEM_CLK(SYSTEM_CLK),
  .SPI_TRANSFER_RATE(30_000_000))
  oled_ssd1331_i(
    .clk(clk),
    .resetn(resetn),
    .oled_rst(oled_rst),
    .strobe(oled_strobe),
    .setpixel_raw8tx(oled_setpixel_raw8tx),
    .x_dc(oled_x_dc),
    .y_data(oled_y_data),
    .rgb(oled_rgb),

    .ready(oled_ready),
    .valid(oled_valid),


    .spi_cs(oled_cs),
    .spi_dc(oled_dc),
    .spi_mosi(oled_mosi),
    .spi_sck(oled_sck),
    .vccen(oled_vccen),
    .pmoden(oled_pmoden)
  );

  bram #( .WORDS(BRAM_SIZE) )
  bram_i
  (
    .clk(clk),
    .resetn(resetn),
    .addr(mem_bram_addr[$clog2(BRAM_SIZE)-1:0]),
    .wmask(mem_bram_wmask),
    .rd(mem_bram_rd),
    .wdata(mem_bram_data_in),
    .rdata(mem_bram_data_out)
  );

 wire [3:0] cpu_state;
 kianv #(.rv32e(1'b0),
   .rv32m(1'b1),
   `ifdef FLASH_EXECUTION
     .reset_addr(FLASH_PC_START))
   `else
     .reset_addr(0))
   `endif
   kianv_i(
     .clk(clk),
     .resetn(resetn),
     .mem_ready(mem_ready),
     .mem_valid(mem_valid),
     .mem_wmask(mem_wmask),
     .mem_rd(mem_rd),
     .mem_addr(mem_addr),
     .mem_din(mem_din),
     .mem_dout(mem_dout),
     .pc(pc),
     .state(cpu_state)
   );

   endmodule

   /*
    * Do not edit this file, it was generated by gen_pll.sh
    *
    *   FPGA kind      : ECP5
    *   Input frequency: 25 MHz
    */

    module pll #(
      parameter freq = 40
    ) (
      input wire pclk,
      output wire clk
    );
    (* ICP_CURRENT="12" *) (* LPF_RESISTOR="8" *) (* MFG_ENABLE_FILTEROPAMP="1" *) (* MFG_GMCREF_SEL="2" *)
    EHXPLLL pll_i (
      .RST(1'b0),
      .STDBY(1'b0),
      .CLKI(pclk),
      .CLKOP(clk),
      .CLKFB(clk),
      .CLKINTFB(),
      .PHASESEL0(1'b0),
      .PHASESEL1(1'b0),
      .PHASEDIR(1'b1),
      .PHASESTEP(1'b1),
      .PHASELOADREG(1'b1),
      .PLLWAKESYNC(1'b0),
      .ENCLKOP(1'b0)
    );
    defparam pll_i.PLLRST_ENA = "DISABLED";
    defparam pll_i.INTFB_WAKE = "DISABLED";
    defparam pll_i.STDBY_ENABLE = "DISABLED";
    defparam pll_i.DPHASE_SOURCE = "DISABLED";
    defparam pll_i.OUTDIVIDER_MUXA = "DIVA";
    defparam pll_i.OUTDIVIDER_MUXB = "DIVB";
    defparam pll_i.OUTDIVIDER_MUXC = "DIVC";
    defparam pll_i.OUTDIVIDER_MUXD = "DIVD";
    defparam pll_i.CLKOP_ENABLE = "ENABLED";
    defparam pll_i.CLKOP_FPHASE = 0;
    defparam pll_i.FEEDBK_PATH = "CLKOP";
    generate
      case(freq)
        16: begin
          defparam pll_i.CLKI_DIV=8;
          defparam pll_i.CLKOP_DIV=38;
          defparam pll_i.CLKOP_CPHASE=18;
          defparam pll_i.CLKFB_DIV=5;
        end
        20: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=30;
          defparam pll_i.CLKOP_CPHASE=15;
          defparam pll_i.CLKFB_DIV=4;
        end
        24: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=24;
          defparam pll_i.CLKOP_CPHASE=11;
          defparam pll_i.CLKFB_DIV=1;
        end
        25: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=24;
          defparam pll_i.CLKOP_CPHASE=11;
          defparam pll_i.CLKFB_DIV=1;
        end
        30: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=20;
          defparam pll_i.CLKOP_CPHASE=9;
          defparam pll_i.CLKFB_DIV=6;
        end
        35: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=17;
          defparam pll_i.CLKOP_CPHASE=8;
          defparam pll_i.CLKFB_DIV=7;
        end
        40: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=15;
          defparam pll_i.CLKOP_CPHASE=7;
          defparam pll_i.CLKFB_DIV=8;
        end
        45: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=13;
          defparam pll_i.CLKOP_CPHASE=6;
          defparam pll_i.CLKFB_DIV=9;
        end
        48: begin
          defparam pll_i.CLKI_DIV=8;
          defparam pll_i.CLKOP_DIV=13;
          defparam pll_i.CLKOP_CPHASE=6;
          defparam pll_i.CLKFB_DIV=15;
        end
        50: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=12;
          defparam pll_i.CLKOP_CPHASE=5;
          defparam pll_i.CLKFB_DIV=2;
        end
        55: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=11;
          defparam pll_i.CLKOP_CPHASE=5;
          defparam pll_i.CLKFB_DIV=11;
        end
        60: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=10;
          defparam pll_i.CLKOP_CPHASE=4;
          defparam pll_i.CLKFB_DIV=12;
        end
        65: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=9;
          defparam pll_i.CLKOP_CPHASE=4;
          defparam pll_i.CLKFB_DIV=13;
        end
        66: begin
          defparam pll_i.CLKI_DIV=8;
          defparam pll_i.CLKOP_DIV=9;
          defparam pll_i.CLKOP_CPHASE=4;
          defparam pll_i.CLKFB_DIV=21;
        end
        70: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=9;
          defparam pll_i.CLKOP_CPHASE=4;
          defparam pll_i.CLKFB_DIV=14;
        end
        75: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=8;
          defparam pll_i.CLKOP_CPHASE=4;
          defparam pll_i.CLKFB_DIV=3;
        end
        80: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=7;
          defparam pll_i.CLKOP_CPHASE=3;
          defparam pll_i.CLKFB_DIV=16;
        end
        85: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=7;
          defparam pll_i.CLKOP_CPHASE=3;
          defparam pll_i.CLKFB_DIV=17;
        end
        90: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=7;
          defparam pll_i.CLKOP_CPHASE=3;
          defparam pll_i.CLKFB_DIV=18;
        end
        95: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=6;
          defparam pll_i.CLKOP_CPHASE=3;
          defparam pll_i.CLKFB_DIV=19;
        end
        100: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=6;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=4;
        end
        105: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=6;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=21;
        end
        110: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=5;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=22;
        end
        115: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=5;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=23;
        end
        120: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=5;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=24;
        end
        125: begin
          defparam pll_i.CLKI_DIV=1;
          defparam pll_i.CLKOP_DIV=5;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=5;
        end
        130: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=5;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=26;
        end
        135: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=4;
          defparam pll_i.CLKOP_CPHASE=2;
          defparam pll_i.CLKFB_DIV=27;
        end
        140: begin
          defparam pll_i.CLKI_DIV=5;
          defparam pll_i.CLKOP_DIV=4;
          defparam pll_i.CLKOP_CPHASE=1;
          defparam pll_i.CLKFB_DIV=28;
        end
        default: UNKNOWN_FREQUENCY unknown_frequency();
      endcase
    endgenerate
    endmodule
