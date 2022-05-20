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
module spi_nor_flash #(
        parameter INIT_FILE     = "",
        parameter SHOW_FIRMWARE = 0
`ifdef SPI_NOR_PRESCALER_ENABLE
        ,parameter PRESCALER     = `SPI_NOR_PRESCALER_DIVIDER
`endif
    )
    (
        input     wire clk,
        input     wire resetn,

        input     wire [21:0] addr, // 4MWords
        output    wire [31:0] data,
        output    wire ready,
        input     wire valid,

        // external
        output    reg   spi_cs,
        input     wire  spi_miso,
        output    wire  spi_mosi,
        output    wire  spi_sclk
    );
    localparam WORDS         = 4*1024*1024;

`ifdef SIM
    reg [31:0] mem [0:WORDS -1];

    integer i;
    initial begin
        for (i = 0; i < WORDS; i = i + 1)
            mem[i] = 0;

        if (INIT_FILE != "")begin
            $display(INIT_FILE);
            $readmemh(INIT_FILE, mem);

            if (SHOW_FIRMWARE > 0)
                for (i = 0; i < WORDS; i = i + 1)
                    $display("%m:%x:->:%x", i + 'h 20_000_000, mem[i]);
        end
    end
`endif


    reg [31: 0]  shift_reg;
    assign spi_mosi = shift_reg[31];
`ifdef SPI_NOR_PRESCALER_ENABLE
    reg clk_latch;
    reg  [2:0] div_clk;

    assign spi_sclk = clk_latch && !spi_cs;
`else
    assign spi_sclk = !clk && !spi_cs;
`endif

    reg [31:0] rcv_buff;
    reg done;
    assign data  = rcv_buff;

`ifdef SPI_NOR_PRESCALER_ENABLE
    assign ready = done && clk_latch && &div_clk;
`else
    assign ready = done;
`endif

`ifdef SIM
    reg [7:0] sim_buf;
    reg [2:0] sim_state;
    reg [2:0] sim_cnt;
    wire [31:0] debug_data = mem[addr];
    always @(posedge spi_sclk or negedge resetn) begin
        if (!resetn) begin
            sim_buf   <= 0;
            sim_state <= 0;
        end else begin
            case (sim_state)

                0: begin
                    if (valid && state == 2) begin
                        sim_buf   <= mem[addr][7:0];
                        sim_cnt   <= 7;
                        sim_state <= 1;
                    end
                end

                1: begin
                    sim_cnt <= sim_cnt - 1;
                    sim_buf <= {sim_buf[6:0], 1'b0};

                    if (!(|sim_cnt)) begin
                        sim_buf   <= mem[addr][15:8];
                        sim_cnt   <= 7;
                        sim_state <= 2;
                    end
                end

                2: begin
                    sim_cnt <= sim_cnt - 1;
                    sim_buf <= {sim_buf[6:0], 1'b0};

                    if (!(|sim_cnt)) begin
                        sim_buf   <= mem[addr][23:16];
                        sim_cnt   <= 7;
                        sim_state <= 3;
                    end
                end

                3: begin
                    sim_cnt <= sim_cnt - 1;
                    sim_buf <= {sim_buf[6:0], 1'b0};

                    if (!(|sim_cnt)) begin
                        sim_buf   <= mem[addr][31:24];
                        sim_cnt   <= 7;
                        sim_state <= 4;
                    end
                end

                4: begin
                    sim_cnt <= sim_cnt - 1;
                    sim_buf <= {sim_buf[6:0], 1'b0};

                    if (!(|sim_cnt)) begin
                        sim_state <= 0;
                    end
                end

            endcase
        end
    end

    wire spi_miso_ = sim_buf[7];
`else
    wire spi_miso_ = spi_miso;
`endif

    reg [2 :0]  state;
    reg [4 :0]  shift_cnt;

    always @(posedge clk) begin
        if (!resetn) begin

            rcv_buff   <= 0;
            state      <= 0;
            shift_reg  <= 0;
            spi_cs     <= 1'b 1;
`ifdef SPI_NOR_PRESCALER_ENABLE
            clk_latch  <= 0;
            div_clk    <= 0;
`endif
            done       <= 0;
        end else begin

`ifdef SPI_NOR_PRESCALER_ENABLE
            div_clk <= div_clk + 1;
            if (div_clk == `SPI_NOR_PRESCALER_DIVIDER) begin
                div_clk <= 0;
                clk_latch <= ~clk_latch;
                if (clk_latch) begin
`endif
                    case (state)

                        0: begin
                            done   <= 1'b0;
                            spi_cs <= 1'b1;

                            if (valid && !ready) begin
                                shift_cnt <= 31;
                                shift_reg <= {8'h03, addr[21:0], 2'b00}; // Read 0x03
                                spi_cs    <= 1'b0;
                                state     <= 1;
                            end
                        end

                        1: begin
                            shift_cnt <= shift_cnt - 1;
                            shift_reg <= {shift_reg[30:0], 1'b0};

                            if (!(|shift_cnt)) begin
                                shift_cnt <= 7;
                                state     <= 2;
                            end
                        end

                        2: begin
                            shift_cnt     <= shift_cnt - 1;
                            rcv_buff[7:0] <= {rcv_buff[6:0], spi_miso_};

                            if (!(|shift_cnt)) begin
                                shift_cnt <= 7;
                                state     <= 3;
                            end
                        end

                        3: begin
                            shift_cnt      <= shift_cnt - 1;
                            rcv_buff[15:8] <= {rcv_buff[14:8], spi_miso_};

                            if (!(|shift_cnt)) begin
                                shift_cnt  <= 7;
                                state      <= 4;
                            end
                        end

                        4: begin
                            shift_cnt       <= shift_cnt - 1;
                            rcv_buff[23:16] <= {rcv_buff[22:16], spi_miso_};

                            if (!(|shift_cnt)) begin
                                shift_cnt   <= 7;
                                state       <= 5;
                            end
                        end

                        5: begin
                            shift_cnt       <= shift_cnt - 1;
                            rcv_buff[31:24] <= {rcv_buff[30:24], spi_miso_};

                            if (!(|shift_cnt)) begin
                                done        <= 1'b1;
                                state       <= 0;
                            end
                        end

                        default:
                            state           <= 0;

                    endcase
`ifdef SPI_NOR_PRESCALER_ENABLE
                end
            end
`endif
        end
    end

endmodule
