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
module spi_flash_mem
       (
           input     wire clk,
           input     wire resetn,

           input     wire cs,
           input     wire rd,
           input     wire [21:0] addr, // 4MWord
           input     wire [3: 0] wmask,

           output    wire [31:0] data,
           output    reg  ready,
           output    reg  valid,

           // external
           output    reg  spi_cs,
           input     wire spi_miso,
           output    wire spi_mosi,
           output    wire  spi_sclk
       );

`ifdef SIM
localparam integer WORDS = 8*1024;
reg [31:0] mem [0:WORDS -1];

integer i;
initial begin
    // $readmemh("firmware.hex", mem);
    //for (i = 0; i < 8192; i = i + 1) $displayh(mem[i]);
end
`endif

function [31:0] adjust_word (
        input [31:0] data
    );
    begin

        adjust_word[31 :24]  = data[ 7  : 0];
        adjust_word[23 :16]  = data[15  : 8];
        adjust_word[15 : 8]  = data[23  :16];
        adjust_word[7  : 0]  = data[31  :24];

    end
endfunction

`ifdef SIM
assign data = mem[addr - (64*1024*16)];
`else
assign data = adjust_word(rcv_buff);
`endif

reg [2 :0]  state;
reg [4 :0]  shift_cnt;
reg [31:0]  shift_reg;

assign spi_sclk = !clk && !spi_cs;
assign spi_mosi = shift_reg[31];

reg [1:0] rd_r;
reg [31:0] rcv_buff;

always @(posedge clk) begin
    if (!resetn) begin

        rcv_buff    <= 0;
        state <= 0;
        shift_reg <= 0;
        spi_cs <= 1'b1;
        ready <= 1'b0;
        valid <= 1'b0;

        rd_r <= 0;

    end else begin

        rd_r <= {rd_r[1:0], rd};

        case (state)
            0: begin
                spi_cs <= 1'b1;
                ready <= 1'b1;
                valid <= 1'b0;

                if (cs && rd_r[1:0] == 2'b01) begin
                    shift_cnt <= 31;
                    shift_reg <= {8'h03, addr[21:0], 2'b00}; // Read 0x03
                    spi_cs <= 1'b0;
                    ready <= 1'b0;
                    state <= 1;
                end
            end

            1: begin
                shift_cnt <= shift_cnt - 1;
                shift_reg <= {shift_reg[30:0], 1'b0};

                if (shift_cnt == 0) begin
                    shift_cnt <= 31;
                    state <= 2;
                end
            end

            2: begin
                shift_cnt <= shift_cnt - 1;
                rcv_buff <= {rcv_buff[30:0], spi_miso};

                if (shift_cnt == 0) begin
                    valid <= 1'b1;
                    state <= 0;
                end

            end

            default:
                state <= 0;

        endcase

    end

end

endmodule
