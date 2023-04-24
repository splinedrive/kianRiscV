/*
 *  fifo.v
 *
 *  copyright (c) 2021  hirosh dabui <hirosh@dabui.de>
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
module fifo #(
        parameter DATA_WIDTH = 8,
        parameter DEPTH = 4
    ) (
        input wire clk,
        input wire resetn,
        input wire [DATA_WIDTH-1:0] din,
        output wire [DATA_WIDTH-1:0] dout,
        input wire push,
        input wire pop,
        output wire full,
        output wire empty
    );

    reg [DATA_WIDTH-1:0] ram[0:DEPTH-1];

    reg [$clog2(DEPTH):0] cnt;
    reg [$clog2(DEPTH)-1:0] rd_ptr;
    reg [$clog2(DEPTH)-1:0] wr_ptr;

    reg [$clog2(DEPTH):0] cnt_next;
    reg [$clog2(DEPTH)-1:0] rd_ptr_next;
    reg [$clog2(DEPTH)-1:0] wr_ptr_next;

    assign empty = cnt == 0;
    assign full  = cnt == DEPTH;

    always @(posedge clk) begin
        if (~resetn) begin
            rd_ptr <= 0;
            wr_ptr <= 0;
            cnt <= 0;
        end else begin
            rd_ptr <= rd_ptr_next;
            wr_ptr <= wr_ptr_next;
            cnt <= cnt_next;
        end
    end

    always @(*) begin
        rd_ptr_next = rd_ptr;
        wr_ptr_next = wr_ptr;
        cnt_next = cnt;

        if (push) begin
            wr_ptr_next = wr_ptr + 1;
            cnt_next = (!pop || empty) ? cnt + 1 : cnt_next;
        end

        if (pop) begin
            rd_ptr_next = rd_ptr + 1;
            cnt_next = (!push || full) ? cnt - 1 : cnt_next;
        end

    end

    always @(posedge clk) begin
        if (push) ram[wr_ptr] <= din;
    end

    assign dout = ram[rd_ptr];

endmodule
