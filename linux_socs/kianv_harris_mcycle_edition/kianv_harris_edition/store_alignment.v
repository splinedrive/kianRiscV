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

`include "riscv_defines.vh"

module store_alignment (
        input  wire [                 1:0] addr,
        input  wire [`STORE_OP_WIDTH -1:0] STOREop,
        input  wire [                31:0] data,
        output reg  [                31:0] result,
        output reg  [                 3:0] wmask,
        output reg                         unaligned_access
    );

    always @* begin
        unaligned_access = 1'b0;
        wmask  = 0;
        result = 'hx;

        case (STOREop)
            (`STORE_OP_SB): begin
                result[7:0] = addr[1:0] == 2'b00 ? data[7:0] : 8'hx;
                result[15:8] = addr[1:0] == 2'b01 ? data[7:0] : 8'hx;
                result[23:16] = addr[1:0] == 2'b10 ? data[7:0] : 8'hx;
                result[31:24] = addr[1:0] == 2'b11 ? data[7:0] : 8'hx;
                wmask          = addr[1:0] == 2'b00 ? 4'b 0001 :
                    addr[1:0] == 2'b01 ? 4'b 0010 :
                        addr[1:0] == 2'b10 ? 4'b 0100 : 4'b 1000;
                unaligned_access = 1'b0;
            end
            (`STORE_OP_SH): begin
                result[15:0]  = ~addr[1] ? data[15:0] : 16'hx;
                result[31:16] = addr[1] ? data[15:0] : 16'hx;
                wmask         = addr[1] ? 4'b1100 : 4'b0011;
                unaligned_access = addr[0];
            end
            (`STORE_OP_SW): begin
                result = data;
                wmask  = 4'b1111;
                unaligned_access = addr[1:0] != 2'b00;
            end
            default: begin
                result = 'hx;
                wmask  = 4'b0000;
                unaligned_access = 1'b0;
            end
        endcase

    end
endmodule
