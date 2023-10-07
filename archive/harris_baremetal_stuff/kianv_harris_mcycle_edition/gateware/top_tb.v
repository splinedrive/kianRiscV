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
`timescale 1 ns / 100 ps
`default_nettype none
`include "defines.vh"
`define SIM

module top_tb;
    localparam DUMP_MEMORY = `DUMP_MEMORY;
    localparam DISABLE_WAVE = `DISABLE_WAVE;
    localparam PERIOD_NS   = $rtoi(1.0/`SYSTEM_CLK*10**9);  /* 50 MHz */

    wire uart_tx;

    /* iverilog simulation generating signals */
    reg clk_1x_s = 1'b0;

    /* verilator lint_off STMTDLY */
    always #(PERIOD_NS/2) clk_1x_s = !clk_1x_s;

    wire clk = clk_1x_s;

    integer i;
    initial
    begin
        $dumpfile("top_tb.fst");
        $dumpvars(0, top_tb);
        if (DISABLE_WAVE) $dumpoff;
        if (DUMP_MEMORY) begin
            for (i = 0; i < `BRAM_WORDS; i = i + 1) begin
                $dumpvars(0, dut_I.bram_I.mem[i]);
            end
        end
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(0, dut_I.kianv_I.datapath_unit_I.register_file_I.bank0[i]);
        end

        /* verilator lint_off STMTDLY */
        #2000000 $finish;
    end
    top
        dut_I (
            .clk_in(clk),
            .uart_tx       ( uart_tx                   ),

`ifdef IOMEM_INTERFACING
            .iomem_valid   (                           ),
            .iomem_ready   (       1'b 0               ),
            .iomem_wstrb   (                           ),
            .iomem_addr    (                           ),
            .iomem_wdata   (                           ),
            .iomem_rdata   (                           ),
`endif

`ifdef PSRAM_MEMORY_32MB
            .psram_ss      (                           ),
            .psram_sclk    (                           ),
            .psram_mosi    (                           ),
            .psram_miso    (                           ),
            .psram_sio2    (                           ),
            .psram_sio3    (                           ),
            .psram_cs      (                           ),
`ifdef PSRAM_DEBUG_LA
            .gpio          (                           ),
`endif
`endif

            .flash_csn     (                           ),
            .flash_miso    (                           ),
            .flash_mosi    (                           ),
            .flash_sclk    (                           )
        );
endmodule
