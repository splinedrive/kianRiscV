/*
 *  kianv.v - a simple RISC-V rv32im
 *
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
module oled_ssd1331 #(
        parameter SYSTEM_CLK           = 35_000_000,
        parameter SPI_TRANSFER_RATE    = 25_000_000
    ) (
        input     wire          clk,
        input     wire          resetn,

        input     wire          setpixel_raw8tx,
        input     wire [ 7: 0]  x_dc, // in raw dc = x[0]
        input     wire [ 7: 0]  y_data, // in raw is 8 bit data
        input     wire [15: 0]  rgb,

        input     wire          valid,
        output    reg           ready,

        // external
        output    reg           spi_cs,
        output    reg           spi_dc,
        output    wire          spi_mosi,
        output    wire          spi_sck,
        output    wire          oled_rst
    );

    localparam SYSTEM_CYCLES        = SYSTEM_CLK;
    localparam CYCLES_PER_SYMBOL    = SYSTEM_CYCLES/SPI_TRANSFER_RATE/2;
    localparam CLK_DIV_WIDTH        = $clog2(CYCLES_PER_SYMBOL);

    initial begin
        $display("SYSTEM_CLK:\t\t", SYSTEM_CLK);
        $display("SYSTEM_CYCLES:\t\t", SYSTEM_CYCLES);
        $display("SPI_TRANSFER_RATE:\t\t", SPI_TRANSFER_RATE);
        $display("CYCLES_PER_SYMBOL:\t", CYCLES_PER_SYMBOL);
        $display("CLK_DIV_WIDTH:\t", CLK_DIV_WIDTH);
    end

    reg    spi_clk;
    assign spi_sck  = spi_clk;
    assign oled_rst = resetn;


    reg [CLK_DIV_WIDTH : 0] clk_div;

    reg [ 1: 0] state;
    reg [ 4: 0] shift_cnt;
    reg [ 7: 0] shift_reg;
    reg [ 6: 0] setpixel_cmd_pos;

    assign spi_mosi = shift_reg[7];

    wire [63: 0] setpixel_cmd = {8'h15, x_dc, 8'h5f, 8'h75, y_data, 8'h3f, rgb};
    always @(posedge clk) begin
        if (!resetn) begin

            spi_cs           <= 1'b1;
            spi_dc           <= 1'b1;

            clk_div          <= 0;
            setpixel_cmd_pos <= 64;
            state            <= 0;
            shift_cnt        <= 0;
            shift_reg        <= 0;
            ready            <= 1'b0;
            spi_clk          <= 0;
        end else begin
            case (state)
                0: begin
                    ready    <= 1'b0;
                    spi_cs   <= spi_cs ^ x_dc[1] ? ~spi_cs : spi_cs;
                    if (valid && !ready) begin
                        if (setpixel_raw8tx) begin
                            spi_cs           <= 1'b0;
                            setpixel_cmd_pos <= 64;
                            state            <= 1;
                        end else begin
                            spi_cs    <= 1'b0;
                            spi_dc    <= x_dc[0];
                            shift_reg <= y_data;
                            shift_cnt <= 7;
                            clk_div   <= 0;
                            state     <= 2;
                        end
                    end
                end

                1: begin
                    setpixel_cmd_pos <= setpixel_cmd_pos - 8;
                    if (setpixel_cmd_pos == 0) begin
                        ready     <= 1'b1;
                        state     <= 0;
                    end else begin
                        spi_dc    <= (setpixel_cmd_pos > 16) ? 1'b0 : 1'b1;  // data or cmd
                        shift_cnt <= 7;
                        shift_reg <= setpixel_cmd[(setpixel_cmd_pos-1) -:8];
                        clk_div   <= 0;
                        state     <= 2;
                    end
                end

                2: begin
                    clk_div <= clk_div + 1;
                    if (&clk_div) begin
                        spi_clk <= ~spi_clk;
                        if (spi_clk) begin
                            shift_cnt <= shift_cnt - 1;
                            shift_reg <= {shift_reg[6:0], 1'b0};

                            if (shift_cnt == 0) begin
                                state <= setpixel_raw8tx ? 1 : 0; // pixel or raw data
                                ready <= ~setpixel_raw8tx;
                            end
                        end
                    end
                end

                default:
                    state <= 0;
            endcase

        end

    end

endmodule
