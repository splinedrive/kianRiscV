/*
 *  kianv.v - a simple RISC-V rv32i
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
`default_nettype none `timescale 1 ns / 100 ps
module bram #(
        parameter integer WIDTH = 8,
        parameter INIT_FILE = "",
        parameter SHOW_FIRMWARE = 0
    ) (
        input wire clk,
        input wire [WIDTH -1:0] addr,
        input wire [31:0] wdata,
        output reg [31:0] rdata,
        input wire [3:0] wmask
    );
    reg [31:0] mem[0:(1<<WIDTH) -1];

    integer i;
    always @(posedge clk) begin

        for (i = 0; i < 4; i = i + 1) begin
            if (wmask[i]) mem[addr][8*i +: 8] <= wdata[8*i +: 8];
        end

        rdata <= mem[addr];

    end

endmodule
