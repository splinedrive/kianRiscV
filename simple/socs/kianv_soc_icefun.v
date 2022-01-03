/*
 *  kianv.v - a simple RISC-V rv32i
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
`define FLASH_EXECUTION
`ifdef SIM
module kianv_soc;
wire uart_tx;
`else
module kianv_soc(
           input clk12,

           /* led  */
           output led1,
           output led2,
           output led3,
           output led4,
           output led5,
           output led6,
           output led7,
           output led8,
           output lcol1,
           output lcol2,
           output lcol3,
           output lcol4,

           /* spi flash */
           output spi_mem_flash_cs,
           input  spi_mem_flash_miso,
           output spi_mem_flash_mosi,
           output spi_mem_flash_sclk,

           /* gpio */
           inout  wire   [GPIO_NR -1: 0] gpio,

           /* oled */
           output oled_sck,
           output oled_mosi,
           output oled_rst,
           output oled_dc,
           output oled_cs,
           //       output oled_vccen,
           //       output oled_pmoden,

           /* uart */
           output uart_tx
       );
`endif

`include "kianv_soc_hw_reg.v"

`ifdef SIM
reg clk;
reg resetn = 0;

reg [31:0] cycle_cnt = 0;

always @(posedge clk) begin
    cycle_cnt <= cycle_cnt + 1;
end

always  #(10) clk = (clk === 1'b0);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, kianv_soc);
    $dumpon;
    $dumpoff;
    resetn = 1'b0;
    repeat(2) @(posedge clk);
    resetn = 1'b1;
    repeat(1000000) @(posedge clk);
    $finish;
end
`else

localparam SYSTEM_CLK = 35_250_000;
//reg [10:0] clk_div;
//always @(posedge clk12) clk_div <= clk_div + 1;
//wire clk = clk_div[10];
//wire clk = clk12;
wire clk;
wire locked;
pll pll_i(clk12, clk, locked);


wire [7:0] leds1;
wire [7:0] leds2;
wire [7:0] leds3;
wire [7:0] leds4;

// The output from the ledscan module
wire [7:0] leds;
wire [3:0] lcol;

// map the output of ledscan to the port pins
assign { led8, led7, led6, led5, led4, led3, led2, led1 } = leds[7:0];
assign { lcol4, lcol3, lcol2, lcol1 } = lcol[3:0];

assign leds1 = ~pc[31:24] & {8{~dimm}};
assign leds2 = ~pc[23:16] & {8{~dimm}};
assign leds3 = ~pc[15: 8] & {8{~dimm}};
assign leds4 = ~pc[7 : 0] & {8{~dimm}};

localparam PWM_MSB = 13;

reg [PWM_MSB:0] pwm = 0;
always @(posedge clk) pwm <= pwm[PWM_MSB-1:0] + 100;//intensity;

wire dimm = pwm[PWM_MSB];

LedScan scan (
            .clk(clk12),
            .leds1(leds1),
            .leds2(leds2),
            .leds3(leds3),
            .leds4(leds4),
            .leds(leds),
            .lcol(lcol)
        );

// reset
reg [15:0] reset_cnt = 0;
wire resetn = &reset_cnt;
always @(posedge clk) begin
    reset_cnt <= reset_cnt + {14'b0, !resetn};
end
`endif

localparam GPIO_NR = 8;
`include "gpio.v"

localparam BRAM_SIZE = 8192;
localparam FLASH_PC_START = 32'h 20_000_000 + (64*1024*4);  // 1M
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

    // ctrl signals
    mem_dout      = 0;
    mem_valid         = 1'b0;
    mem_ready         = 1'b0;

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
        mem_dout      = mem_bram_data_out;
        mem_valid         = 1'b1;
        /* spi flash rom */
    end else if (mem_addr >= 32'h 2_000_0000 && mem_addr < (32'h 2_000_0000 + (1024*1024))) begin
        /* ---> */
        mem_spi_cs        = 1'b1;
        mem_spi_addr      = {mem_addr[$clog2(1024*1024*16) -1:2], 2 'b00} >> 2;
        mem_spi_wmask     = mem_wmask;
        mem_spi_rd        = mem_rd;
        /* <--- */
        mem_ready         = mem_spi_ready;
        mem_dout      = mem_spi_data_out;
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
        mem_valid         = mem_rd ? 1'b1 : uart_ready;
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
        if (!mem_wmask & ~mem_rd) begin
            mem_ready = 1'b1;
            mem_valid = 1'b1;
        end
    end

end

`ifdef SIM
my_tx_uart #(.SYSTEM_CLK(50_000_000), .BAUDRATE(2_000_000))
`else // SIM
my_tx_uart #(.SYSTEM_CLK(SYSTEM_CLK), .BAUDRATE(115200))
`endif // SIM
           my_tx_uart_i(
               .clk(clk),
               .resetn(resetn),
               .strobe(uart_strobe),
               .tx_data(uart_tx_data),
               .tx_out(uart_tx),
               .ready(uart_ready)
           );
`ifdef SIM
always @* begin
    if (uart_ready) $write("%c", uart_tx_data);
end
`endif

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

oled_ssd1331 #(.SYSTEM_CLK(SYSTEM_CLK))
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
                 .spi_sck(oled_sck)
                 //.vccen(oled_vccen),
                 //.pmoden(oled_pmoden)
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

`ifndef SIM

    /**
     * PLL configuration
     *
     * This Verilog module was generated automatically
     * using the icepll tool from the IceStorm project.
     * Use at your own risk.
     *
     * Given input frequency:        12.000 MHz
     * Requested output frequency:   35.000 MHz
     * Achieved output frequency:    35.250 MHz
     */

    module pll(
        input  clock_in,
        output clock_out,
        output locked
    );

SB_PLL40_CORE #(
                  .FEEDBACK_PATH("SIMPLE"),
                  .DIVR(4'b0000),         // DIVR =  0
                  .DIVF(7'b0101110),      // DIVF = 46
                  .DIVQ(3'b100),          // DIVQ =  4
                  .FILTER_RANGE(3'b001)   // FILTER_RANGE = 1
              ) uut (
                  .LOCK(locked),
                  .RESETB(1'b1),
                  .BYPASS(1'b0),
                  .REFERENCECLK(clock_in),
                  .PLLOUTCORE(clock_out)
              );

endmodule

`endif
