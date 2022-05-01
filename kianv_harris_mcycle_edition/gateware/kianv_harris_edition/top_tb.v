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
`define SYSTEM_CLK 50

`include "riscv_defines.vh"
`define FIRMWARE_BRAM     "./firmware/firmware.hex"
//`define BRAM_WORDS        (2048*4*8)
`define BRAM_WORDS        (8192)
// sim stuff
`define DISABLE_WAVE      1'b0
`define SHOW_MACHINECODE  1'b0
`define SHOW_REGISTER_SET 1'b0
`define DUMP_MEMORY       1'b1
`define BRAM_ADDR_WIDTH   $clog2(`BRAM_WORDS)
module top_tb;
    wire clk;
    reg  resetn;
    wire         mem_valid;
    wire         mem_ready;
    wire [ 3: 0] mem_wstrb;
    wire [31: 0] mem_addr;
    wire [31: 0] mem_wdata;
    wire [31: 0] mem_rdata;

    localparam PERIOD_NS   = $rtoi(1.0/`SYSTEM_CLK*10**9);  /* 50 MHz */

    initial begin
        resetn = 1'b 0;
        #(PERIOD_NS/1);
        resetn = 1'b 1;
    end

    integer i;
    initial
    begin
        $dumpfile("top_tb.fst");
        $dumpvars(0, top_tb);
        if (`DISABLE_WAVE) $dumpoff;
        if (`DUMP_MEMORY) begin
            /*
              for (i = 0; i < `BRAM_WORDS; i = i + 1) begin
                  $dumpvars(0, bram_I.mem[i]);
              end
            */
            for (i = 0; i < 32; i = i + 1) begin
                $dumpvars(0, cpu_I.datapath_unit_I.register_file_I.bank0[i]);
            end
        end

        /* verilator lint_off STMTDLY */
        //    repeat(1000) @(posedge clk);
        //   $finish;
    end

    /* iverilog simulation generating signals */
    reg clk_1x_s = 1'b0;

    /* verilator lint_off STMTDLY */
    always #(PERIOD_NS/2) clk_1x_s = !clk_1x_s;

    assign clk = clk_1x_s;

    // bram wiring
    wire [31:0] bram_rdata;
    reg         bram_ready;
    wire        bram_valid;

    wire wr                       = |mem_wstrb;
    wire [29:0] word_aligned_addr = {mem_addr[31:2]};

    assign mem_ready   = bram_ready | test_valid;
    assign mem_rdata   = bram_ready ? bram_rdata :
           test_ready ? test_mem   :
           32'h 0000_0000;

    // BRAM
    assign bram_valid                 = !bram_ready && mem_valid && (mem_addr < (`BRAM_WORDS << 2));
    always @(posedge clk) bram_ready <= !resetn ? 0 : bram_valid;

    // test memory
    reg [31:0] test_mem = 0;
    wire       test_valid            = !test_ready && mem_valid && (mem_addr == 32'h 1000_0000);
    reg        test_ready = 0;

    // ebreak hack
    reg [255:0] test;
    reg result;
    initial begin
        result = $value$plusargs("test=%s", test);
    end
    always @(posedge clk) begin
        if (cpu_I.datapath_unit_I.Instr == 32'b 0000_0000_0001_00000_000_00000_111_00_11) begin
            $display("ebreak");
            $displayh(">", test_result);
            if (test_result[23:0] == 24'h 4f4b0a)
                $display("%0s", test, ": passed");
            else
                $display("%0s", test, ": failed");

            $finish;
        end
    end

    always @* begin
        if (test_ready) begin
            $writeh(cpu_I.datapath_unit_I.OldPC);
            $displayh(":", test_mem);
        end
    end
    reg [31:0] test_result = 0;
    always @(posedge clk) begin
        if (wr && test_valid) begin
            if (mem_wstrb[0]) test_mem[ 7: 0] <= mem_wdata[ 7: 0];
            if (mem_wstrb[1]) test_mem[15: 8] <= mem_wdata[15: 8];
            if (mem_wstrb[2]) test_mem[23:16] <= mem_wdata[23:16];
            if (mem_wstrb[3]) test_mem[31:24] <= mem_wdata[31:24];

            test_result <= test_result<<8 | mem_wdata[ 7: 0];
        end
        test_ready <= !resetn ? 0 : test_valid;
    end

    bram
        #(
            .WIDTH          ( `BRAM_ADDR_WIDTH                 ),
            .SHOW_FIRMWARE  ( 0                                ),
            .INIT_FILE      ( `FIRMWARE_BRAM                   )
        )
        bram_I
        (
            .clk   ( clk                                       ),
            .wr    ( wr & bram_valid                           ),
            .addr  ( word_aligned_addr[`BRAM_ADDR_WIDTH -1:0]  ),
            .wdata ( mem_wdata                                 ),
            .rdata ( bram_rdata                                ),
            .wmask ( mem_wstrb                                 )
        );

    kianv_harris_mc_edition cpu_I
                            (
                                .clk             ( clk       ),
                                .resetn          ( resetn    ),
                                .mem_valid       ( mem_valid ),
                                .mem_ready       ( mem_ready ),
                                .mem_wstrb       ( mem_wstrb ),
                                .mem_addr        ( mem_addr  ),
                                .mem_wdata       ( mem_wdata ),
                                .mem_rdata       ( mem_rdata )
                            );
endmodule
