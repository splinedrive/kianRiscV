/*
 *  kianv.v - a simple RISC-V rv32ima
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
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
module clint #(
        parameter SYSTEM_CLK = 25_000_000,
        parameter CLOCK_TICK = 1000
    ) (
        input wire clk,
        input wire resetn,
        input wire valid,
        input wire [31:0] addr,
        input wire [3:0] wmask,
        input wire [31:0] wdata,
        output reg [31:0] rdata,
        output wire is_valid,
        output reg ready,
        output wire IRQ3,
        output wire IRQ7
    );

    /* verilator lint_off WIDTHTRUNC */
    localparam CLOCK_TICK_BIT_WIDTH = $clog2(CLOCK_TICK);
    localparam [CLOCK_TICK_BIT_WIDTH -1:0] CYCLES_TO_TICK = ($rtoi((SYSTEM_CLK) / (CLOCK_TICK)));
    /* verilator lint_on WIDTHTRUNC */
    wire is_msip = (addr == 32'h1100_0000);
    wire is_mtimecmpl = (addr == 32'h1100_4000);
    wire is_mtimecmph = (addr == 32'h1100_4004);
    wire is_mtimeh = (addr == 32'h1100_bffc);
    wire is_mtimel = (addr == 32'h1100_bff8);

    assign is_valid = valid && (is_msip || is_mtimecmpl || is_mtimecmph || is_mtimel || is_mtimeh);
    always @(posedge clk) ready <= !resetn ? 1'b0 : is_valid;

    reg [63:0] mtime;
    always @(posedge clk) mtime <= !resetn ? 0 : (tick) ? mtime + 1 : mtime;

    wire is_we = |wmask;

    reg [63:0] mtimecmp;
    reg msip;

    always @(posedge clk)
        if (!resetn) begin
            mtimecmp <= 0;
            msip <= 0;
        end else if (is_mtimecmpl && is_valid) begin
            if (wmask[0]) mtimecmp[7:0] <= wdata[7:0];
            if (wmask[1]) mtimecmp[15:8] <= wdata[15:8];
            if (wmask[2]) mtimecmp[23:16] <= wdata[23:16];
            if (wmask[3]) mtimecmp[31:24] <= wdata[31:24];
        end else if (is_mtimecmph && is_valid) begin
            if (wmask[0]) mtimecmp[39:32] <= wdata[7:0];
            if (wmask[1]) mtimecmp[47:40] <= wdata[15:8];
            if (wmask[2]) mtimecmp[55:48] <= wdata[23:16];
            if (wmask[3]) mtimecmp[63:56] <= wdata[31:24];
        end else if (is_msip && is_valid) begin
            if (wmask[0]) msip <= wdata[0];
        end

    always @(*) begin
        case (1'b1)
            is_mtimecmpl: rdata = mtimecmp[31:0];
            is_mtimecmph: rdata = mtimecmp[63:32];
            is_mtimel:    rdata = mtime[31:0];
            is_mtimeh:    rdata = mtime[63:32];
            is_msip:      rdata = {31'b0, msip};
            default:      rdata = 0;
        endcase
    end


    reg [CLOCK_TICK_BIT_WIDTH -1:0] tick_cnt;
    wire tick = tick_cnt == (CYCLES_TO_TICK - 1);
    always @(posedge clk) begin
        if (!resetn) begin
            tick_cnt <= 0;
        end else begin
            if (tick) begin
                tick_cnt <= 0;
            end else begin
                tick_cnt <= tick_cnt + 1;
            end
        end
    end

    assign IRQ3 = msip;
    assign IRQ7 = (mtime >= mtimecmp);

endmodule

