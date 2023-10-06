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
`default_nettype none `timescale 1 ns / 100 ps
`define SYSTEM_CLK 50
`include "riscv_defines.vh"
`define FIRMWARE_BRAM "./firmware/firmware.hex"
`define BRAM_WORDS (8192)
// sim stuff
`define DISABLE_WAVE 1'b0
`define SHOW_MACHINECODE 1'b0
`define SHOW_REGISTER_SET 1'b0
`define DUMP_MEMORY 1'b1
`define BRAM_ADDR_WIDTH $clog2(`BRAM_WORDS)
module top_tb;
    wire        clk;
    reg         resetn;
    wire        mem_valid;
    wire        mem_ready;
    wire [ 3:0] mem_wstrb;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [31:0] mem_rdata;

    localparam PERIOD_NS = $rtoi(1.0 / `SYSTEM_CLK * 10 ** 9);  /* 50 MHz */

    initial begin
        resetn = 1'b0;
        #(PERIOD_NS / 1);
        resetn = 1'b1;
    end

    integer i;
    initial begin
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

    end

    /* iverilog simulation generating signals */
    reg clk_1x_s = 1'b0;

    /* verilator lint_off STMTDLY */
    always #(PERIOD_NS / 2) clk_1x_s = !clk_1x_s;

    assign clk = clk_1x_s;

    // bram wiring
    wire                  [31:0]                                       bram_rdata;
    reg                                                                bram_ready;
    wire                                                               bram_valid;

    wire wr = |mem_wstrb;
    wire                  [29:0] word_aligned_addr = {mem_addr[31:2]};

    assign mem_ready  = bram_ready | unittest_ready;
    assign mem_rdata  = bram_ready ? bram_rdata : 32'h0000_0000;

    // BRAM
    assign bram_valid = !bram_ready && mem_valid && (mem_addr < (`BRAM_WORDS << 2));
    always @(posedge clk) bram_ready <= !resetn ? 0 : bram_valid;

    /*
      always @(posedge clk) begin
          if (mem_addr == ('h150 >> 0) && bram_valid) begin
            $display("wdata:%x", mem_wdata);
            $display("rdata:%x", bram_rdata);
          end
      end
      */

    bram #(
             .WIDTH        (`BRAM_ADDR_WIDTH),
             .SHOW_FIRMWARE(0),
             .INIT_FILE    (`FIRMWARE_BRAM)
         ) bram_I (
             .clk  (clk),
             .addr (word_aligned_addr[`BRAM_ADDR_WIDTH-1:0]),
             .wdata(mem_wdata),
             .rdata(bram_rdata),
             .wmask(mem_wstrb)
         );

    wire unittest_ready;
    unittest unittest_i (
                 .clk       (clk),
                 .resetn    (resetn),
                 .dmem_addr (mem_addr),
                 .dmem_wmask(mem_wstrb),
                 .dmem_wdata(mem_wdata),
                 .dmem_ready(unittest_ready)
             );

    kianv_harris_mc_edition cpu_I (
                                .clk      (clk),
                                .resetn   (resetn),
                                .mem_valid(mem_valid),
                                .mem_ready(mem_ready),
                                .mem_wstrb(mem_wstrb),
                                .mem_addr (mem_addr),
                                .mem_wdata(mem_wdata),
                                .mem_rdata(mem_rdata),
				.access_fault(1'b0),
                                .IRQ3     (1'b0),
                                .IRQ7     (1'b0),
                                .PC       ()
                            );
endmodule
