/*
my_hdmi_device

Copyright (C) 2021/2022  Hirosh Dabui <hirosh@dabui.de>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/
/*
 * tmds_encode implementation (c) 2020/2021 Hirosh Dabui <hirosh@dabui.de>
 * based on Digital Visual Interface Revision 1.0, Page 29
 */
`timescale 1 ns / 100 ps
`default_nettype none
module tmds_encoder(
        input wire clk,
        input wire DE,
        input wire [7:0]D,
        input wire C1,
        input wire C0,
        output reg[9:0] q_out = 0
    );
    /* verilator lint_off WIDTH */
    parameter LEGACY_DVI_CONTROL_LUT = 0;

    function [3:0] N0;
        input [7:0] d;
        integer i;
        begin
            N0 = 0;
            for (i = 0; i < 8; i = i +1)
                N0 = N0 + !d[i];
        end
    endfunction

    function [3:0] N1;
        input [7:0] d;
        integer i;
        begin
            N1 = 0;
            for (i = 0; i < 8; i = i +1)
                N1 = N1 + d[i];
        end
    endfunction

    reg signed [7:0] cnt_prev = 0;
    reg signed [7:0] cnt = 0;

    reg [8:0] q_m;

    always @(*) begin

        if ( (N1(D) > 4) | (N1(D) == 4) & (D[0] == 0) ) begin

            q_m[0] =           D[0];
            q_m[1] = q_m[0] ~^ D[1];
            q_m[2] = q_m[1] ~^ D[2];
            q_m[3] = q_m[2] ~^ D[3];
            q_m[4] = q_m[3] ~^ D[4];
            q_m[5] = q_m[4] ~^ D[5];
            q_m[6] = q_m[5] ~^ D[6];
            q_m[7] = q_m[6] ~^ D[7];
            q_m[8] = 1'b0;

        end else begin

            q_m[0] =          D[0];
            q_m[1] = q_m[0] ^ D[1];
            q_m[2] = q_m[1] ^ D[2];
            q_m[3] = q_m[2] ^ D[3];
            q_m[4] = q_m[3] ^ D[4];
            q_m[5] = q_m[4] ^ D[5];
            q_m[6] = q_m[5] ^ D[6];
            q_m[7] = q_m[6] ^ D[7];
            q_m[8] = 1'b1;

        end /* (N1(D) > 4) | (N1(D) == 4) & (D[0] == 0) */

    end

    always @(posedge clk) begin

        if (DE) begin

            if ((cnt_prev == 0) | (N1(q_m[7:0]) == N0(q_m[7:0]))) begin

                q_out[9]   <= ~q_m[8];
                q_out[8]   <=  q_m[8];
                q_out[7:0] <= q_m[8] ? q_m[7:0] : ~q_m[7:0];

                if (q_m[8] == 0) begin
                    cnt <= cnt_prev + (N0(q_m[7:0]) - N1(q_m[7:0]));
                end else begin
                    cnt <= cnt_prev + (N1(q_m[7:0]) - N0(q_m[7:0]));
                end /*q_m[8] == 0*/

            end else begin

                if ( (cnt_prev > 0 & (N1(q_m[7:0]) > N0(q_m[7:0]))) |
                        (cnt_prev < 0 & (N0(q_m[7:0]) > N1(q_m[7:0]))) ) begin
                    q_out[9]   <= 1;
                    q_out[8]   <= q_m[8];
                    q_out[7:0] <= ~q_m[7:0];
                    cnt <= cnt_prev + 2*q_m[8] + (N0(q_m[7:0]) - N1(q_m[7:0]));
                end else begin
                    q_out[9]   <= 0;
                    q_out[8]   <= q_m[8];
                    q_out[7:0] <= q_m[7:0];
                    cnt <= cnt_prev - {~q_m[8], 1'b0} + (N1(q_m[7:0]) - N0(q_m[7:0]));
                end /*
                    (cnt_prev > 0 & N1(q_m[7:0]) > N0(q_m[7:0]))) |
                    (cnt_prev < 0 & N0(q_m[7:0]) > N1(q_m[7:0])))
                  */

            end /* ((cnt_prev == 0) | (N1(q_m[7:0]) == N0(q_m[7:0]))) */

        end else begin
            /* !DE */
            cnt <= 0;
            /* hsync -> c0 | vsync -> c1 */
            case ({C1, C0})
`ifdef LEGACY_DVI_CONTROL_LUT
                /* dvi control data lut */
                2'b00: q_out <= 10'b00101_01011;
                2'b01: q_out <= 10'b11010_10100;
                2'b10: q_out <= 10'b00101_01010;
                2'b11: q_out <= 10'b11010_10101;
`else
                /* hdmi control data period */
                2'b00: q_out <= 10'b1101010100;
                2'b01: q_out <= 10'b0010101011;
                2'b10: q_out <= 10'b0101010100;
                2'b11: q_out <= 10'b1010101011;
`endif
            endcase

        end /* DE */

        cnt_prev <= cnt;

    end
    /* verilator lint_on WIDTH */

endmodule
