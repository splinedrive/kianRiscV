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
           parameter SYSTEM_CLK           = 50_000_000,
           parameter SPI_TRANSFER_RATE    = 25_000_000
       ) (
           input     wire clk,
           input     wire resetn,

           input     wire strobe,
           input     wire setpixel_raw8tx,
           input     wire [7:0]  x_dc, // in raw dc = x[0]
           input     wire [7:0]  y_data, // in raw is 8 bit data
           input     wire [15:0] rgb,

           output    reg  ready,
           output    reg  valid,

           // external
           output    reg   spi_cs,
           output    reg   spi_dc,
           output    wire  spi_mosi,
           output    wire  spi_sck,
           output    wire  vccen,
           output    wire  pmoden,
           output    wire  oled_rst
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

assign spi_sck = spi_clk;
assign spi_mosi = shift_reg[7];
assign oled_rst = resetn;

reg [1:0] strobe_r;
reg spi_clk;

reg [7:0] data;
reg [5:0] rom_addr;
reg [CLK_DIV_WIDTH -1:0] clk_div;
always @(*) begin: oled_initial
    case(rom_addr)
        0 : data = 8'hfd;  1 : data = 8'h12;  2 : data = 8'hae;  3 : data = 8'ha0;
        4 : data = 8'h72;  5 : data = 8'ha1;  6 : data = 8'h00;  7 : data = 8'ha2;
        8 : data = 8'h00;  9 : data = 8'ha4; 10 : data = 8'ha8; 11 : data = 8'h3f;
        12 : data = 8'had; 13 : data = 8'h8e; 14 : data = 8'hb0; 15 : data = 8'h0b;
        16 : data = 8'hb1; 17 : data = 8'h31; 18 : data = 8'hb3; 19 : data = 8'hf0;
        20 : data = 8'h8a; 21 : data = 8'h64; 22 : data = 8'h8b; 23 : data = 8'h78;
        24 : data = 8'h8c; 25 : data = 8'h64; 26 : data = 8'hbb; 27 : data = 8'h3a;
        28 : data = 8'hbe; 29 : data = 8'h3e; 30 : data = 8'h87; 31 : data = 8'h0f;
        32 : data = 8'h81; 33 : data = 8'h91; 34 : data = 8'h82; 35 : data = 8'h50;
        36 : data = 8'h83; 37 : data = 8'h7d; 38 : data = 8'h2e; 39 : data = 8'h25;
        40 : data = 8'h00; 41 : data = 8'h00; 42 : data = 8'h5f; 43 : data = 8'h3f;
        44 : data = 8'haf;
        default: data = 8'hbc;  // nop
    endcase
end


reg [2:0] state;
reg [4:0] shift_cnt;
reg [7:0] shift_reg;
reg [6:0] setpixel_cmd_pos;

assign vccen  = 1'b1;
assign pmoden = 1'b1;

wire [63:0] setpixel_cmd = {8'h15, x_dc, 8'h5f, 8'h75, y_data, 8'h3f, rgb};
always @(posedge clk) begin
    if (!resetn) begin

        spi_cs <= 1'b1;
        spi_dc <= 1'b1;

        clk_div <= 0;
        setpixel_cmd_pos <= 64;
        rom_addr <= 0;
        state <= 3;
        shift_cnt <= 44;
        shift_reg <= 0;
        ready <= 1'b0;
        valid <= 1'b0;

        spi_clk    <= 0;
        strobe_r   <= 1;

    end else begin

        strobe_r <= {strobe_r[0], strobe};

        case (state)
            0: begin
                ready     <= 1'b1;
                valid     <= 1'b0;

                spi_cs   <= spi_cs ^ x_dc[1] ? ~spi_cs : spi_cs;

                if (strobe_r[1:0] == 2'b01) begin
                    if (setpixel_raw8tx) begin
                        spi_cs   <= 1'b0;
                        setpixel_cmd_pos <= 64;
                        ready <= 1'b0;
                        state <= 1;
                    end else begin
                        spi_cs   <= 1'b0;
                        ready <= 1'b0;
                        spi_dc    <= x_dc[0];
                        shift_reg <= y_data;
                        shift_cnt <= 7;
                        clk_div <= 0;
                        state <= 2;
                    end
                end
            end

            1: begin
                setpixel_cmd_pos <= setpixel_cmd_pos - 8;
                if (setpixel_cmd_pos == 0) begin
                    valid <= 1'b1;
                    state <= 0;
                end else begin
                    spi_dc    <= (setpixel_cmd_pos > 16) ? 1'b0 : 1'b1;  // data or cmd
                    shift_cnt <= 7;
                    shift_reg <= setpixel_cmd[(setpixel_cmd_pos-1) -:8];
                    clk_div <= 0;
                    state <= 2;
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
                            valid <= ~setpixel_raw8tx; // valid in raw data case only
                        end
                    end
                end
            end

            3: begin
                if (rom_addr == 45) begin
                    spi_cs   <= 1'b1;
                    state    <= 0;
                end else begin
                    spi_cs   <= 1'b0;  // always low
                    spi_dc   <= 1'b0;  // command
                    spi_clk  <= 1'b0;
                    shift_cnt <= 7;
                    shift_reg <= data; // rom data
                    clk_div <= 0;
                    state <= 4;
                end
            end

            4: begin
                clk_div <= clk_div + 1;
                if (&clk_div) begin
                    spi_clk <= ~spi_clk;
                    if (spi_clk) begin
                        shift_cnt <= shift_cnt - 1;
                        shift_reg <= {shift_reg[6:0], 1'b0};

                        if (shift_cnt == 0) begin
                            rom_addr <= rom_addr + 1;  // next rom data
                            state <= 3;
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
