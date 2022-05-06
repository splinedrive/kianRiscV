/*
 *  kianv.v - RISC-V rv32im
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
module led_matrix8x4
    #(
         parameter SYSTEM_FREQ   = 100_000_000
     )
     (
         input  wire       clk,
         input  wire [7:0] leds1,
         input  wire [7:0] leds2,
         input  wire [7:0] leds3,
         input  wire [7:0] leds4,
         output reg  [7:0] leds,
         output reg  [3:0] lcol
     );

    localparam CYC_WIDTH = $clog2(SYSTEM_FREQ / 1000);

    reg [CYC_WIDTH -1:0] cnt = 0;

    always @* begin
        case (cnt[CYC_WIDTH -1:CYC_WIDTH -2])
            2'b00: begin
                leds[7:0] = leds1[7:0];
                lcol[3:0] = ~(1<<0);
            end
            2'b01: begin
                leds[7:0] = leds2[7:0];
                lcol[3:0] = ~(1<<1);
            end
            2'b10: begin
                leds[7:0] = leds3[7:0];
                lcol[3:0] = ~(1<<2);
            end
            2'b11: begin
                leds[7:0] = leds4[7:0];
                lcol[3:0] = ~(1<<3);
            end
            default: begin
                leds[7:0] = 8'hx;
                lcol[3:0] = 4'hx;
            end
        endcase
    end

    always @ (posedge clk) begin
        cnt <= cnt + 1;
    end

endmodule
