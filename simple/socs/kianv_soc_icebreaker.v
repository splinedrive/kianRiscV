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
`ifndef SIM
`define FLASH_EXECUTION  // start from NOR-Flash
`endif
`define RV32M
`define CSR_TIME_COUNTER
`ifdef SIM
module kianv_soc;
wire   uart_tx;

wire   oled_cs;
wire   oled_mosi;
wire   oled_sck;
wire   oled_dc;
wire   oled_rst;
wire   oled_vccen;
wire   oled_pmoden;

wire         spi_mem_flash_cs;
wire         spi_mem_flash_miso = cycle_cnt[4];
wire         spi_mem_flash_mosi;
wire         spi_mem_flash_sclk;

`else
module kianv_soc(
           input wire clk_12mhz,
           output wire uart_tx,

           output wire LEDR_N,
           output wire LEDG_N,
           output wire LED_RED_N,
           output wire LED_GRN_N,
           output wire LED_BLU_N,

           output wire   oled_cs,
           output wire   oled_mosi,
           output wire   oled_sck,
           output wire   oled_dc,
           output wire   oled_rst,
           output wire   oled_vccen,
           output wire   oled_pmoden,

           output wire spi_mem_flash_sclk,
           output wire spi_mem_flash_cs,
           input  wire spi_mem_flash_miso,
           output wire spi_mem_flash_mosi,
           output wire FLASH_IO2,
           output wire FLASH_IO3,

           inout  wire   [GPIO_NR -1: 0] gpio,

           output wire   P1B1,
           output wire   P1B2,
           output wire   P1B3,
           output wire   P1B4,
           output wire   P1B7,
           output wire   P1B8,
           output wire   P1B9,
           output wire   P1B10

       );

`include "kianv_soc_hw_reg.v"

localparam SYSTEM_CLK = 30_000_000;

assign FLASH_IO2 = 1'b1;
assign FLASH_IO3 = 1'b1;

//assign {P1A1, P1A2, P1A3, P1A4, P1A7, P1A8, P1A9, P1A10} = {8{led_pwm}} & pc[17:10];
assign {P1B1, P1B2, P1B3, P1B4, P1B7, P1B8, P1B9, P1B10} = {8{led_pwm}} & pc[9:2];

wire clk;// = clk_12mhz;
pll_icebreaker #(.freq(SYSTEM_CLK / 1_000_000)) pll_i(clk_12mhz, clk);

localparam PWM_MSB = 13;

reg [PWM_MSB:0] pwm = 0;
always @(posedge clk) pwm <= pwm[PWM_MSB-1:0] + 100;//intensity;

assign LEDG_N = 1'b1;
assign LEDR_N = 1'b1;

assign LED_RED_N = 1'b1;
assign LED_GRN_N = 1'b1;
assign LED_BLU_N = 1'b1;

wire led_pwm = pwm[PWM_MSB];
/*

assign led[0] = led_pwm & pc[10];
assign led[1] = led_pwm & pc[11];
assign led[2] = led_pwm & pc[12];

assign {pmod2_1, pmod2_2, pmod2_3, pmod2_4, pmod2_7, pmod2_8, pmod2_9, pmod2_10} = {8{led_pwm}} & pc[9:2];
*/
`endif

`ifdef SIM
reg clk;
reg resetn = 0;

reg [31:0] cycle_cnt = 0;

always @(posedge clk) begin
    cycle_cnt <= cycle_cnt + 1;
end

`ifndef VERILATOR
always  #(10) clk = (clk === 1'b0);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, kianv_soc);
    //$dumpon;
    $dumpoff;
    resetn = 1'b0;
    repeat(2) @(posedge clk);
    resetn = 1'b1;
    //    repeat(1000000000) @(posedge clk);
    //   $finish;
end
`endif
`else

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
        /* spram */
    end else if (mem_addr >= 32'h 10_00_0000 && mem_addr < (32'h 10_00_0000 + (32*1024*4))) begin
        /* 32kx32 */
        /* ---> */
        mem_spram_addr          = {mem_addr[$clog2(32*1024*4) -1:2], 2'b00} >> 2;
        mem_spram_wmask         = mem_wmask;
        mem_spram_data_in       = mem_din;

        /* <--- */
        mem_ready              = 1'b1;
        mem_dout           = mem_spram_data_out;
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

ice40up5k_spram #(.WORDS(32768))
                spram_i
                (
                    .clk(clk),
                    .wen(mem_spram_wmask),
                    .addr(mem_spram_addr),
                    .wdata(mem_spram_data_in),
                    .rdata(mem_spram_data_out),
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
     *   FPGA kind      : ICE40
     *   Input frequency: 12 MHz
     */

    module pll_icebreaker #(
        parameter freq = 40
    ) (
        input wire pclk,
        output wire clk
    );
SB_PLL40_PAD pll (
                 .PACKAGEPIN(pclk),
                 .PLLOUTCORE(clk),
                 .RESETB(1'b1),
                 .BYPASS(1'b0)
             );
defparam pll.FEEDBACK_PATH="SIMPLE";
defparam pll.PLLOUT_SELECT="GENCLK";
generate
    case(freq)
        16: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1010100;
            defparam pll.DIVQ = 3'b110;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        20: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0110100;
            defparam pll.DIVQ = 3'b101;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        24: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111111;
            defparam pll.DIVQ = 3'b101;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        25: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1000010;
            defparam pll.DIVQ = 3'b101;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        30: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001111;
            defparam pll.DIVQ = 3'b101;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        35: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0101110;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        40: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0110100;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        45: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111011;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        48: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111111;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        50: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1000010;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        55: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001000;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        60: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001111;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        65: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1010110;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        66: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1010111;
            defparam pll.DIVQ = 3'b100;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        70: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0101110;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        75: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0110001;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        80: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0110100;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        85: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111000;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        90: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111011;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        95: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0111110;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        100: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1000010;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        105: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1000101;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        110: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001000;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        115: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001100;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        120: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1001111;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        125: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1010010;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        130: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b1010110;
            defparam pll.DIVQ = 3'b011;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        135: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0101100;
            defparam pll.DIVQ = 3'b010;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        140: begin
            defparam pll.DIVR = 4'b0000;
            defparam pll.DIVF = 7'b0101110;
            defparam pll.DIVQ = 3'b010;
            defparam pll.FILTER_RANGE = 3'b001;
        end
        default: UNKNOWN_FREQUENCY unknown_frequency();
    endcase
endgenerate

endmodule
