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
`define FAST_CPU
 localparam SYSTEM_CLK = 35_000_000;
`ifndef SIM
`define FLASH_EXECUTION  // start from NOR-Flash
`endif
`define RV32M
`define CSR_TIME_COUNTER
`ifdef SIM
module kianv_soc;
wire   uart_tx;
wire  [18:0] sram_addr;
wire  [15:0] sram_data;
wire         sram_cen;
wire         sram_oen;
wire         sram_wen;
wire         sram_lbn;
wire         sram_ubn;

wire         video_vs;
wire         video_hs;
wire         video_de;
wire         video_b0;
wire         video_b1;
wire         video_ck;
wire         video_b2;
wire         video_b3;

`ifdef VGA_CTRL
wire         video_g0;
wire         video_g1;
wire         video_g2;
wire         video_g3;
wire         video_r0;
wire         video_r1;
wire         video_r2;
wire         video_r3;
`endif

`ifndef VGA_CTRL
wire   oled_cs;
wire   oled_mosi;
wire   oled_sck;
wire   oled_dc;
wire   oled_rst;
wire   oled_vccen;
wire   oled_pmoden;
`endif

wire         spi_mem_flash_cs;
wire         spi_mem_flash_miso = cycle_cnt[4];
wire         spi_mem_flash_mosi;
wire         spi_mem_flash_sclk;

`else
module kianv_soc(
           input wire clk_100mhz,
           output wire uart_tx,
           output wire [2:0] led,

           /* external interface sram */
           output wire  [18:0] sram_addr,
           inout  wire  [15:0] sram_data,
           output wire         sram_cen,
           output wire         sram_oen,
           output wire         sram_wen,
           output wire         sram_lbn,
           output wire         sram_ubn,

           /* external interface video */
           output video_vs,
           output video_hs,
           output video_de,
           output video_b0,
           output video_b1,
           output video_ck,
           output video_b2,
           output video_b3,


           /*
           output video_g0,
           output video_g1,
           output video_g2,
           output video_g3,
           output video_r0,
           output video_r1,
           output video_r2,
           output video_r3,
           */
           inout wire [GPIO_NR -1: 0] gpio,

           output wire pmod2_1,
           output wire pmod2_2,
           output wire pmod2_3,
           output wire pmod2_4,
           output wire pmod2_7,
           output wire pmod2_8,
           output wire pmod2_9,
           output wire pmod2_10,

           output wire spi_mem_flash_sclk,
           output wire spi_mem_flash_cs,
           input  wire spi_mem_flash_miso,
           output wire spi_mem_flash_mosi
       );

`ifndef VGA_CTRL
wire   oled_cs;
wire   oled_mosi;
wire   oled_sck;
wire   oled_dc;
wire   oled_rst;
wire   oled_vccen;
wire   oled_pmoden;

assign video_b3 = oled_cs;
assign video_ck = oled_mosi;
assign video_hs = oled_sck;
assign video_b2 = oled_dc;
assign video_b1 = oled_rst;
assign video_de = oled_vccen;
assign video_vs = oled_pmoden;

/*
assign video_r3 = oled_cs;
assign video_r1 = oled_mosi;
assign video_g1 = oled_sck;
assign video_r2 = oled_dc;
assign video_r0 = oled_rst;
assign video_g2 = oled_vccen;
assign video_g0 = oled_pmoden;
*/

`endif

wire clk;
wire locked;
pll pll_i(clk_100mhz, clk, locked);

localparam PWM_MSB = 13;

reg [PWM_MSB:0] pwm = 0;
always @(posedge clk) pwm <= pwm[PWM_MSB-1:0] + 100;//intensity;

wire led_pwm = pwm[PWM_MSB];

//assign led[0] = led_pwm & {cycle_cnt[26 -:2] &  cycle_cnt[21 -:1]};
//assign led[1] = led_pwm & {cycle_cnt[26 -:2] &  cycle_cnt[21 -:1]};
//assign led[2] = led_pwm & {cycle_cnt[26 -:2] &  cycle_cnt[21 -:1]};
assign led[0] = led_pwm & pc[10];
assign led[1] = led_pwm & pc[11];
assign led[2] = led_pwm & pc[12];

//assign {pmod2_1, pmod2_2, pmod2_3, pmod2_4, pmod2_7, pmod2_8, pmod2_9, pmod2_10} = ~{{8{led_pwm}}, {8{cycle_cnt[26 -:2] &  cycle_cnt[21 -:1]}}};
//assign {pmod2_1, pmod2_2, pmod2_3, pmod2_4, pmod2_7, pmod2_8, pmod2_9, pmod2_10} = {mem_rd, mem_wr, mem_valid, mem_ready, cpu_state};
assign {pmod2_1, pmod2_2, pmod2_3, pmod2_4, pmod2_7, pmod2_8, pmod2_9, pmod2_10} = {8{led_pwm}} & pc[9:2];

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
reg [15:0] reset_cnt;
wire resetn = &reset_cnt;
always @(posedge clk) begin
    if (!locked)
        reset_cnt <= 0;
    else
        reset_cnt <= reset_cnt + {14'b0, !resetn};
end
`endif

localparam GPIO_NR = 8;
`include "gpio.v"

localparam BRAM_SIZE = 8192;
localparam FLASH_PC_START = 32'h 20_000_000 + (1024*64*16);
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

// sram memory
reg [17:0]  mem_sram_addr;
reg         mem_sram_cen;
reg         mem_sram_wen;
reg         mem_sram_oen;
reg  [3:0]  mem_sram_wmask;
wire [15:0] sram_data_in;
wire [15:0] sram_data_out;

reg  [31:0] mem_sram_data_in;
wire [31:0] mem_sram_data_out;

wire        mem_sram_ready;
wire        mem_sram_valid;

`ifndef VGA_CTRL
// oled
reg [7:0]    oled_x_dc;
reg [7:0]    oled_y_data;
reg [15:0]   oled_rgb;
reg          oled_strobe;
reg          oled_setpixel_raw8tx;

wire         oled_ready;
wire         oled_valid;
`endif


`ifdef SIM
assign sram_data = (~mem_sram_cen & ~mem_sram_wen) ? sram_data_out : 16'h z;
assign sram_data_in = sram_data;
`else
SB_IO #(
          .PIN_TYPE(6'b1010_01),
          .PULLUP(1'b0)
      ) sram_bi [15:0] (
          .PACKAGE_PIN(sram_data),
          .OUTPUT_ENABLE({16{~sram_wen}}),
          .D_OUT_0(sram_data_out),
          .D_IN_0(sram_data_in)
      );
`endif

wire [31:0] sram_memory_range             = (mem_addr >= 32'h 10_000_000 && mem_addr < (32'h 10_000_000 + (256*1024*4)));
wire [31:0] video_reg                     = mem_addr == 32'h 30_00_0008;
`ifdef VGA_CTRL
reg cpu_in_sram_transaction;
reg [1:0] mem_sram_ready_r;
reg [1:0] mem_sram_valid_r;

always @(posedge clk) begin
    if (!resetn) begin
        cpu_in_sram_transaction <= 0;

        mem_sram_ready_r <= 0;
        mem_sram_valid_r <= 0;
    end else begin
        mem_sram_ready_r <= {mem_sram_ready_r[0], mem_sram_ready};
        mem_sram_valid_r <= {mem_sram_valid_r[0], mem_sram_valid};

        case (cpu_in_sram_transaction)
            0: begin
                if ((mem_sram_ready_r == 2'b10) && cpu_sram_operation_cond) begin
                    cpu_in_sram_transaction <= 1;
                end
            end
            1: begin
                if (mem_sram_valid_r == 2'b01) begin
                    cpu_in_sram_transaction <= 0;
                end
            end
        endcase

    end
end

/* vga 640x480: 0 - 799 | 0 - 524 */
//wire [31:0] cpu_sram_operation_cond       = (((hcnt >= 681 && hcnt <= 700) || (vcnt >= 481 && vcnt <= 524)));
wire [31:0] cpu_sram_operation_cond       = (((hcnt >= 681 && hcnt <= 700) || (vcnt >= 481 && vcnt <= 520)));
wire [31:0] cpu_sram_access               = (cpu_sram_operation_cond || cpu_in_sram_transaction || !video_reg_data_reg) && sram_memory_range;
reg [1:0] video_reg_data_reg;

always @(posedge clk) begin

    if (!resetn) begin
        video_reg_data_reg <= 1'b1;
    end else begin
        if (video_reg & |mem_wmask) begin
            video_reg_data_reg <= video_reg_data;
        end
    end

end

reg video_reg_data;
`else
wire [31:0] cpu_sram_access               = sram_memory_range;
`endif
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

    // sram
    mem_sram_addr     = 0;
    mem_sram_wmask    = 0;
    mem_sram_data_in  = 0;
    mem_sram_cen      = 1'b0;
    mem_sram_wen      = 1'b0;
    mem_sram_oen      = 1'b0;

    // uart
    uart_strobe       = 1'b0;
    uart_tx_data      = 0;

    // ctrl signals
    mem_dout      = 0;
    mem_valid         = 1'b0;
    mem_ready         = 1'b0;

`ifdef VGA_CTRL
    // video
    video_reg_data    = 1'b0;
`else
    oled_x_dc                = 0;
    oled_y_data              = 0;
    oled_rgb                 = 0;
    oled_setpixel_raw8tx     = 0;
    oled_strobe              = 0;
    // gpio
    gpio_output_wr               = 1'b0;
    gpio_output_en_wr            = 1'b0;
    gpio_output_val_wr           = 1'b0;
`endif

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
    end else if (cpu_sram_access) begin
        /* 512x16 -> 256x32 */
        /* ---> */
        mem_sram_cen           = 1'b1;
        mem_sram_addr          = {mem_addr[19:2], 2'b00} >> 2;
        mem_sram_wmask         = mem_rd ? 4'b1111 : mem_wmask;
        mem_sram_data_in       = mem_din;
        mem_sram_wen           = |mem_wmask;
        mem_sram_oen           = mem_rd;
        /* <--- */
        mem_ready              = mem_sram_ready;
        mem_dout               = mem_sram_data_out;
        mem_valid              = mem_sram_valid;
        /* spi flash rom */
    end else if (mem_addr >= 32'h 20_00_0000 && mem_addr < (32'h 20_00_0000 + (1024*1024*4))) begin
        /* ---> */
        mem_spi_cs        = 1'b1;
        //mem_spi_addr      = {mem_addr[23:0]};
        mem_spi_addr      = {mem_addr[23:2], 2 'b00} >> 2;
        mem_spi_wmask     = mem_wmask;
        mem_spi_rd        = mem_rd;
        /* <--- */
        mem_ready         = mem_spi_ready;
        //mem_ready         = stretch_ready_sync[1];
        mem_dout          = mem_spi_data_out;
        mem_valid         = mem_spi_valid;
        //mem_valid         = stretch_valid_sync[1];
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
`ifdef VGA_CTRL
    end else if (video_reg) begin
        if (|mem_wmask) video_reg_data     = mem_din[7:0];
        if (mem_rd) mem_dout       = {{31{1'b0}}, (vcnt >= 481 && vcnt <= 510)};
        /* <--- */
        mem_ready         = 1'b1;
        mem_valid         = 1'b1;
`else // oled
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
     mem_dout = {24'hz, gpio_output_val};
   end
   mem_ready            = 1'b1;
   mem_valid            = 1'b1;
 end else if (mem_addr == GPIO_INPUT) begin
   if (mem_rd) begin
     mem_dout = {24'hz, gpio_in};
   end
   mem_ready            = 1'b1;
   mem_valid            = 1'b1;
`endif
 end else if (mem_addr == CPU_FREQ_REG) begin
   /* get system frequency */
   mem_dout         = SYSTEM_CLK;
   mem_ready        = 1'b1;
   mem_valid        = 1'b1;
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
`ifdef FAST_CPU
my_tx_uart #(.SYSTEM_CLK(SYSTEM_CLK), .BAUDRATE(115200))
`else  // FAST_CPU
           my_tx_uart #(.SYSTEM_CLK(25_000_000), .BAUDRATE(115200))
`endif // FAST_CPU
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

`ifdef VGA_CTRL
wire [10:0] hcnt;
wire [10:0] vcnt;
wire hcycle;
wire vcycle;
wire hsync;
wire vsync;
wire blank;

reg [3:0] vga_red;
reg [3:0] vga_blue;
reg [3:0] vga_green;

reg vga_hsync = 0;
reg vga_vsync = 0;
reg vga_blank = 0;
wire pclk;
wire vga_clk = pclk;

assign {video_vs, video_hs, video_de, video_ck} = {vga_vsync, vga_hsync, ~vga_blank, vga_clk};

assign {video_b3, video_b2, video_b1, video_b0} = vga_blue  [3:0];
assign {video_g3, video_g2, video_g1, video_g0} = vga_green [3:0];
assign {video_r3, video_r2, video_r1, video_r0} = vga_red   [3:0];


always @(*) begin
    vga_blank = blank;
    vga_hsync = hsync;
    vga_vsync = vsync;

    if (~blank /*& video_reg_data_reg*/) begin
        vga_red   = {4'b0, mem_sram_data_out[11 :  8]};
        vga_green = {4'b0, mem_sram_data_out[ 7 :  4]};
        vga_blue  = {4'b0, mem_sram_data_out[ 3 :  0]};
    end else begin
        vga_red   = 8'h0;
        vga_blue  = 8'h0;
        vga_green = 8'h0;
    end

end

initial begin
`ifdef SIM
`ifndef VERILATOR
    //    $monitorh("fb_state:%d crt_start:%d mem_sram_ready:%d mem_sram_valid:%d sram_i.state:%d fb_oe:%d sram_i.cen:%d",
    //              fb_state, crt_start, mem_sram_ready, mem_sram_valid, sram_i.state, fb_oe, sram_i.cen);
    //$monitorh("fb_state:%d crt_start:%d", fb_state, crt_start);
    //$monitorh("crt_start:%d fb_state:%d fb_addr:%d hcnt:%d vcnt:%d video_ctrl_active:%d mem_sram_data_out[15:0]:",
    //         crt_start, fb_state, fb_addr, hcnt, vcnt, video_ctrl_active, mem_sram_data_out[15:0]);
    //$monitorh("crt_start:%d fb_state:%d", crt_start, fb_state);
    //$monitorh("fb_addr:%d", fb_addr);
`endif
`endif
end


reg [18:0] fb_addr;
reg fb_state;

wire crt_start = !hcnt && !vcnt;
wire video_ctrl_active = ~blank & video_reg_data_reg;//hcnt < 640 && vcnt < 480;
`ifdef FAST_CPU
reg clk_div;
`endif

always @(posedge clk) begin
    if (!resetn) begin
        fb_addr <= 0;
        fb_state <= 0;
`ifdef FAST_CPU
        clk_div <= 0;
`endif
    end else begin

`ifdef FAST_CPU
        clk_div <= ~clk_div;
        if (clk_div) begin
`endif
            case (fb_state)

                0: begin
                    fb_addr <= 0;
                    if (crt_start && mem_sram_ready) begin
                        fb_state <= 1;
                    end
                end

                1: begin
                    if (video_ctrl_active) begin
                        fb_addr <= fb_addr + 1;
                    end
                    if (vcnt == 480) begin
                        fb_state <= 0;
                    end
                end

                default:
                    fb_state <= 0;
            endcase

        end
`ifdef FAST_CPU
    end
`endif
end

/*                                 */
`ifdef FAST_CPU
wire [1:0] prescaler = 2'b01;
`else
wire [1:0] prescaler = 2'b00;
`endif

my_vga_clk_generator #(
                         .VPOL( 0 ),
                         .HPOL( 0 ),
                         .FRAME_RATE( 60 ),
                         .VBP( 33 ),
                         .VFP( 10 ),
                         .VSLEN( 2 ),
                         .VACTIVE( 480 ),
                         .HBP( 48 ),
                         .HFP( 16 ),
                         .HSLEN( 96 ),
                         .HACTIVE( 640 )
                     ) my_vga_clk_generator_i(
                         .clk(clk),
                         .prescaler(prescaler),
                         .out_hcnt(hcnt),
                         .out_vcnt(vcnt),
                         .out_hsync(hsync),
                         .out_vsync(vsync),
                         .out_blank(blank),
                         .out_pclk(pclk),
                         .reset_n(resetn)
                     );

`endif // VGA_CTRL 
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

`ifdef VGA_CTRL
sram sram_i(
         .clk(clk),
         .resetn(resetn),
         .valid(mem_sram_valid),
         .ready(mem_sram_ready),

         .raw_mode16(video_ctrl_active),
         .sram_addr(sram_addr),
         .sram_data_in(sram_data_in),
         .sram_data_out(sram_data_out),
         .sram_cen(sram_cen),
         .sram_oen(sram_oen),
         .sram_wen(sram_wen),
         .sram_lbn(sram_lbn),
         .sram_ubn(sram_ubn),

         .addr  ( video_ctrl_active ? fb_addr     :{mem_sram_addr[17:0]}),
         .cen   ( video_ctrl_active ? 1'b1        : mem_sram_cen),
         .oen   ( video_ctrl_active ? 1'b1        : mem_sram_oen),
         .wen   ( video_ctrl_active ? 1'b0        : mem_sram_wen),
         .wmask ( video_ctrl_active ? 4'b0011     : mem_sram_wmask),
         .dout  (mem_sram_data_out),  /* read sram  */
         .din   (mem_sram_data_in)    /* write sram */
     );
`else
sram sram_i(
         .clk(clk),
         .resetn(resetn),
         .valid(mem_sram_valid),
         .ready(mem_sram_ready),

         .raw_mode16(1'b0),
         .sram_addr(sram_addr),
         .sram_data_in(sram_data_in),
         .sram_data_out(sram_data_out),
         .sram_cen(sram_cen),
         .sram_oen(sram_oen),
         .sram_wen(sram_wen),
         .sram_lbn(sram_lbn),
         .sram_ubn(sram_ubn),

         .addr  (mem_sram_addr[17:0]),
         .cen   (mem_sram_cen),
         .oen   (mem_sram_oen),
         .wen   (mem_sram_wen),
         .wmask (mem_sram_wmask),
         .dout  (mem_sram_data_out),  /* read sram  */
         .din   (mem_sram_data_in)    /* write sram */
     );

`ifdef FAST_CPU
oled_ssd1331 #(.SYSTEM_CLK(SYSTEM_CLK))
`else
oled_ssd1331 #(.SYSTEM_CLK(25_000_000))
`endif
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
`endif

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
`ifdef FAST_CPU
    /**
     * PLL configuration
     *
     * This Verilog module was generated automatically
     * using the icepll tool from the IceStorm project.
     * Use at your own risk.
     *
     * Given input frequency:       100.000 MHz
     * Requested output frequency:   35.000 MHz
     * Achieved output frequency:    35.000 MHz
     */

    module pll(
        input  clock_in,
        output clock_out,
        output locked
    );

SB_PLL40_CORE #(
                  .FEEDBACK_PATH("SIMPLE"),
                  .DIVR(4'b0100),         // DIVR =  4
                  .DIVF(7'b0011011),      // DIVF = 27
                  .DIVQ(3'b100),          // DIVQ =  4
                  .FILTER_RANGE(3'b010)   // FILTER_RANGE = 2
              ) uut (
                  .LOCK(locked),
                  .RESETB(1'b1),
                  .BYPASS(1'b0),
                  .REFERENCECLK(clock_in),
                  .PLLOUTCORE(clock_out)
              );

endmodule

`else
    /**
    * PLL configuration
    *
    * This Verilog module was generated automatically
    * using the icepll tool from the IceStorm project.
    * Use at your own risk.
    *
    * Given input frequency:       100.000 MHz
    * Requested output frequency:   25.000 MHz
    * Achieved output frequency:    25.000 MHz
    */

    module pll(
        input  clock_in,
        output clock_out,
        output locked
    );

SB_PLL40_CORE #(
                  .FEEDBACK_PATH("SIMPLE"),
                  .DIVR(4'b0000),         // DIVR =  0
                  .DIVF(7'b0000111),      // DIVF =  7
                  .DIVQ(3'b101),          // DIVQ =  5
                  .FILTER_RANGE(3'b101)   // FILTER_RANGE = 5
              ) uut (
                  .LOCK(locked),
                  .RESETB(1'b1),
                  .BYPASS(1'b0),
                  .REFERENCECLK(clock_in),
                  .PLLOUTCORE(clock_out)
              );

endmodule


`endif

`endif
