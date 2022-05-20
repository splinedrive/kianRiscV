/*
 *  kianv harris multicycle RISC-V rv32im
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

`timescale 1 ns/100 ps
`default_nettype none
`include "defines.vh"
module gpio_ctrl
    #(
         parameter GPIO_NR = 8
     )
     (
         input  wire clk,
         input  wire resetn,
         input  wire [31: 0] addr,
         input  wire [ 3: 0] wrstb,
         input  wire [31: 0] wdata,
         output reg  [31: 0] rdata,
         input  wire         valid,
         output reg          ready,

         inout  wire [GPIO_NR -1:0] gpio
     );

    reg  [GPIO_NR -1:0] gpio_out_en;
    wire [GPIO_NR -1:0] gpio_in;
    reg  [GPIO_NR -1:0] gpio_out_val;

    /* input */
    assign gpio_in = gpio;

    /* output */
    genvar i;
    generate
        for (i = 0; i < GPIO_NR; i = i +1) begin
            assign gpio[i] = gpio_out_en[i] ? gpio_out_val[i] : 1'bz;
        end
    endgenerate

    wire wr =  |wrstb;

    always @(posedge clk) ready <= !resetn ? 0 : valid;


    always @(posedge clk) begin
        if (!resetn) begin
            gpio_out_en  <=  0;  // default all is input pin
            gpio_out_val <=  0;  // digilent led 0: off 1:0
        end else begin
            /* verilator lint_off WIDTH */
            if (valid) begin
                // 1 output, 0 input
                if (addr == `GPIO_DIR_ADDR) begin
                    if (wr) begin
                        gpio_out_en  <= wdata[GPIO_NR -1:0];
                    end else begin
                        rdata        <= gpio_out_en;
                    end
                    // output value
                end else if (addr == `GPIO_OUTPUT_ADDR) begin
                    if (wr) begin
                        gpio_out_val <= wdata[GPIO_NR -1:0];
                    end else begin
                        rdata        <= gpio_out_val;
                    end
                    // input value
                end else if (addr == `GPIO_INPUT_ADDR) begin
                    if (!wr) begin
                        rdata <= gpio_in;
                    end
                end
            end
            /* verilator lint_on WIDTH */
        end
    end

endmodule
