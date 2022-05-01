/*
 *  kianv.v - a simple RISC-V rv32im
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
module cache #(
        parameter BYTE_ADDRESS_LEN  = 32,
        parameter BYTES_PER_BLOCK   =  4,
        parameter DATA_LEN          = 32,
        parameter CACHE_BLOCK_LEN   = 8
    )(
        input  wire clk,
        input  wire resetn,

        // cache interface
        input  wire  [BLOCK_ADDRESS_LEN -1: 0] cblock_addr,
        input  wire  [DATA_LEN          -1: 0] cwdata,
        output wire  [DATA_LEN          -1: 0] crdata,
        input  wire  [BYTES_PER_BLOCK   -1: 0] cwstrb,
        input  wire                            cvalid,
        output reg                             cready,

        // mem interface
        output reg   [BLOCK_ADDRESS_LEN -1: 0] maddr,
        output reg   [BYTES_PER_BLOCK   -1: 0] mwstrb,
        input  wire  [DATA_LEN          -1: 0] mrdata,
        output reg   [DATA_LEN          -1: 0] mwdata,
        output reg                             mvalid,
        input  wire                            mready
    );
    localparam CACHE_INDEX_LEN   = $clog2(CACHE_BLOCK_LEN);
    localparam TAG_LEN           = BYTE_ADDRESS_LEN - CACHE_INDEX_LEN - $clog2(BYTES_PER_BLOCK);
    localparam CACHE_LINE_LEN    = 1 /* valid */ + TAG_LEN + DATA_LEN -1;
    localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);

    reg [          0 :0] valid [0:CACHE_BLOCK_LEN -1];
    reg [TAG_LEN  -1 :0] tag   [0:CACHE_BLOCK_LEN -1];
    reg [DATA_LEN -1 :0] data  [0:CACHE_BLOCK_LEN -1];

    integer i;
    integer ii;
    initial begin
        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            {valid[i], tag[i], data[i]} = 0;
        end
    end

    //wire [CACHE_LINE_LEN  -1:0] cache_line;

    /* verilator lint_off WIDTH */
    wire [CACHE_INDEX_LEN -1:0] cache_index = (cblock_addr &  (CACHE_BLOCK_LEN -1));
    wire [TAG_LEN -1:        0] tag_req     = (cblock_addr >> (CACHE_INDEX_LEN   ));
    /* verilator lint_on WIDTH */

    reg [0                 :0] valid_reg;
    reg [TAG_LEN         -1:0] tag_reg;
    reg [DATA_LEN        -1:0] data_reg;

    assign crdata = data_reg;

    reg [2:0] state;

    reg  hit    = 0;
    wire missed = !hit;

    //wire [CACHE_LINE_LEN -1:0] cache_line = {valid[cache_index], tag[cache_index], data[cache_index]};
    always @(posedge clk) begin
        if (!resetn) begin
            valid_reg <= 0;
            tag_reg   <= 0;
            cready    <= 1'b0;
            maddr     <= 0;
            mvalid    <= 0;
            state     <= 0;
        end else begin
            case (state)
                0: begin
                    cready <= 1'b0;
                    if (cvalid & !cready) begin
                        maddr  <= cblock_addr;
                        /* write */
                        if (|cwstrb) begin
                            mwstrb   <= cwstrb;
                            mwdata   <= cwdata;
                            mvalid   <= 1'b1;
                            state    <= 1;
                        end else /* read */ begin
                            mwstrb    <= 0;
                            valid_reg <= valid [cache_index];
                            tag_reg   <= tag   [cache_index];
                            data_reg  <= data  [cache_index];
                            state     <= 3;
                        end
                    end
                end
                1: begin
                    if (mvalid & mready) begin
                        mwstrb <= 0;
                        if (&cwstrb) begin
                            valid [cache_index] <= 1'b1;
                            tag   [cache_index] <= tag_req;
                            data  [cache_index] <= cwdata;
                            data_reg            <= cwdata;

                            cready <= 1'b1;
                            maddr  <= 0;
                            mvalid <= 1'b0;
                            state  <= 0;
                        end else begin
                            mvalid <= 1'b0;
                            state  <= 2;
                        end
                    end
                end

                2: begin
                    mvalid <= 1'b1;
                    state  <= 4;
                end

                3: begin
                    if (valid_reg && tag_reg == tag_req) begin
                        // hit
                        cready  <= 1'b1;
                        hit     <= 1'b1;
                        state   <= 0;
                    end else begin
                        // miss
                        mvalid  <= 1'b1;
                        hit     <= 1'b0;
                        state   <= 4;
                    end
                end

                4: begin
                    if (mvalid & mready) begin
                        mvalid              <= 1'b0;
                        valid [cache_index] <= 1'b1;
                        tag   [cache_index] <= tag_req;
                        data  [cache_index] <= mrdata;
                        data_reg            <= mrdata;

                        cready              <= 1'b1;
                        state               <= 0;
                    end
                end

                default:
                    state <= 0;
            endcase
        end
    end
endmodule
