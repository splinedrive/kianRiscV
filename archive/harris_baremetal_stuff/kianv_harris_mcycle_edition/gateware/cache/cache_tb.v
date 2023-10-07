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

`define FIRMWARE_BRAM ""
`define SYSTEM_CLK 50_000_000
`define BRAM_WORDS 1024
module cache_tb;
    localparam BYTE_ADDRESS_LEN  = 32;
    localparam BYTES_PER_BLOCK   =  4;
    localparam DATA_LEN          = 32;
    localparam CACHE_BLOCK_LEN   = 16;
    localparam BLOCK_ADDRESS_LEN = BYTE_ADDRESS_LEN - $clog2(BYTES_PER_BLOCK);

    localparam BRAM_ADDR_WIDTH   = $clog2(`BRAM_WORDS);
    localparam PERIOD_NS         = $rtoi(1.0/`SYSTEM_CLK*10**9);

    localparam DISABLE_WAVE      = 0;
    localparam DUMP_MEMORY       = 0;

    reg resetn;

    reg clk_1x_s = 1'b0;

    /* verilator lint_off STMTDLY */
    always #(PERIOD_NS/2) clk_1x_s = !clk_1x_s;
    wire clk = clk_1x_s;

    integer i;
    initial
    begin
        $dumpfile("cache_tb.vcd");
        $dumpvars(0, cache_tb);
        if (DISABLE_WAVE) $dumpoff;
        if (DUMP_MEMORY) begin
            for (i = 0; i < `BRAM_WORDS; i = i + 1) begin
                $dumpvars(0, bram_I.mem[i]);
            end
        end

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            $displayb(cache_I.valid[i],":", cache_I.tag[i], ":", cache_I.data[i]);
        end

        /*
        for (i = 0; i < `BRAM_WORDS; i = i + 1) begin
            $display(bram_I.mem[i]);
        end
        */

        $display("==============================================================");

        #000 resetn = 1'b0;
        cblock_addr = 0;
        cwstrb      = 0;
        cvalid      = 0;
        #200 resetn = 1'b1;

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;
            cwstrb      = 4'b 0000;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end
        cvalid = 0;
        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;//i*2;
            cwstrb      = 4'b 0000;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end
        cvalid = 0;

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;
            cwdata      = 32'h deadbeaf;
            cwstrb      = 4'b 1111;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end
        cvalid = 0;

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;
            cwdata      = i;
            cwstrb      = 4'b 1111;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end
        cvalid = 0;

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;
            cwstrb      = 4'b 0000;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end

        cvalid = 0;
        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            repeat (1) @(posedge clk);
            cblock_addr = i;//i*2;
            cwstrb      = 4'b 0000;
            cvalid      = 1'b1;
            repeat (1) @(posedge clk);
            wait (cready);
        end
        cvalid = 0;

        /*
        repeat (1) @(posedge clk);
        cblock_addr = 0;
        cwdata    = 32'h deadbeaf;
        cwstrb      = 4'b 1111;
        cvalid      = 1'b1;
        repeat (1) @(posedge clk);
        wait (cready);
        */

        for (i = 0; i < CACHE_BLOCK_LEN; i = i + 1) begin
            $displayb(cache_I.valid[i],":", cache_I.tag[i], ":", cache_I.data[i]);
        end

        /* verilator lint_off STMTDLY */
        $finish;
    end


    // cache interface
    reg   [BLOCK_ADDRESS_LEN -1: 0] cblock_addr;
    reg   [DATA_LEN          -1: 0] cwdata;
    wire  [DATA_LEN          -1: 0] crdata;
    reg   [BYTES_PER_BLOCK   -1: 0] cwstrb;
    reg                             cvalid;
    wire                            cready;

    // mem interface
    wire   [BLOCK_ADDRESS_LEN -1: 0] maddr;
    wire   [BYTES_PER_BLOCK   -1: 0] mwstrb;
    wire   [DATA_LEN          -1: 0] mrdata;
    wire   [DATA_LEN          -1: 0] mwdata;
    wire                             mvalid;
    reg                              mready;

    cache #(
              .BYTE_ADDRESS_LEN ( BYTE_ADDRESS_LEN ),
              .BYTES_PER_BLOCK  ( BYTES_PER_BLOCK  ),
              .DATA_LEN         ( DATA_LEN         ),
              .CACHE_BLOCK_LEN  ( CACHE_BLOCK_LEN  )
          ) cache_I
          (
              .clk                ( clk          ),
              .resetn             ( resetn       ),

              .cblock_addr        ( cblock_addr  ),
              .cwdata             ( cwdata       ),
              .crdata             ( crdata       ),
              .cwstrb             ( cwstrb       ),
              .cvalid             ( cvalid       ),
              .cready             ( cready       ),

              .maddr              ( maddr        ),
              .mwstrb             ( mwstrb       ),
              .mrdata             ( mrdata       ),
              .mwdata             ( mwdata       ),
              .mvalid             ( mvalid       ),
              .mready             ( mready       )
          );

    // BRAM
    always @(posedge clk) mready <= !resetn ? 0 : mvalid;

    bram
        #(
            .WIDTH          ( BRAM_ADDR_WIDTH                ),
            .SHOW_FIRMWARE  ( 0                              ),
            .INIT_FILE      ( `FIRMWARE_BRAM                 )
        )
        bram_I
        (
            .clk   ( clk                                     ),
            .wr    ( |mwstrb & mvalid                        ),
            .addr  ( maddr [BRAM_ADDR_WIDTH -1:0]            ),
            .wdata ( mwdata                                  ),
            .rdata ( mrdata                                  ),
            .wmask ( mwstrb                                  )
        );

endmodule

