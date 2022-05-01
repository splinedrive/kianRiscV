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
`default_nettype none
`timescale 1 ns/100 ps
module bram #(
        parameter integer WIDTH = 8,
        parameter INIT_FILE = "",
        parameter SHOW_FIRMWARE = 0
    ) (
        input wire clk,
        input wire wr,
        input wire [WIDTH -1:0] addr,
        input wire [31:0] wdata,
        output reg [31:0] rdata,
        input wire [ 3:0] wmask
    );
    reg [31:0] mem [0:(1<<WIDTH) -1];

    integer i;
    initial
    begin
`ifdef SIM
        for (i = 0; i < (1<<WIDTH); i = i + 1)
            mem[i] = 0;
`endif

        if (INIT_FILE != "")begin
            $display(INIT_FILE);
            $readmemh(INIT_FILE, mem);

            if (SHOW_FIRMWARE > 0)
                for (i = 0; i < (1<<WIDTH); i = i + 1)
                    $display("%m:%x:->:%x", i, mem[i]);
        end
    end

    always @(posedge clk)begin

        if (wr) begin
            if (wmask[0]) mem[addr][ 7: 0] <= wdata[ 7: 0];
            if (wmask[1]) mem[addr][15: 8] <= wdata[15: 8];
            if (wmask[2]) mem[addr][23:16] <= wdata[23:16];
            if (wmask[3]) mem[addr][31:24] <= wdata[31:24];
        end

        rdata <= mem[addr];

    end

endmodule
