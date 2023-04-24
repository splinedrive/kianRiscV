/*
 *  kianv 5-staged pipelined RISC-V
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
module unittest (
        input wire clk,
        input wire resetn,
        input wire [3:0] dmem_wmask,
        input wire [31:0] dmem_addr,
        input wire [31:0] dmem_wdata,
        output wire dmem_ready
    );
    // test memory
    reg  [31:0] test_mem = 0;
    wire        test_valid;
    reg         test_ready = 0;

    assign test_valid = !test_ready && |dmem_wmask && (dmem_addr == 32'h2000_0000);

    assign dmem_ready = test_ready;

    // ebreak hack
    reg [255:0] test;
    reg result;
    initial begin
        result = $value$plusargs("test=%s", test);
    end
    always @(posedge clk) begin
        if (cpu_I.datapath_unit_I.Instr == 32'b0000_0000_0001_00000_000_00000_111_00_11) begin
            $display("ebreak");
            $displayh(">", test_result);
            if (test_result[23:0] == 24'h4f4b0a) $display("%0s", test, ": passed");
            else $display("%0s", test, ": failed");

            $finish;
        end
    end

    always @* begin
        if (test_ready) begin
            $writeh(cpu_I.datapath_unit_I.PC);
            $displayh(":", test_mem);
        end
    end
    reg [31:0] test_result = 0;
    always @(posedge clk) begin
        if (|dmem_wmask && test_valid) begin
            if (dmem_wmask[0]) test_mem[7:0] <= dmem_wdata[7:0];
            if (dmem_wmask[1]) test_mem[15:8] <= dmem_wdata[15:8];
            if (dmem_wmask[2]) test_mem[23:16] <= dmem_wdata[23:16];
            if (dmem_wmask[3]) test_mem[31:24] <= dmem_wdata[31:24];

            test_result <= test_result << 8 | {24'b0, dmem_wdata[7:0]};
        end
        test_ready <= !resetn ? 0 : test_valid;
    end

endmodule
