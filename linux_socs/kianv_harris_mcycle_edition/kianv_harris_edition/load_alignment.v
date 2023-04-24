/*
 *  kianv harris multicycle RISC-V rv32ima
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
`include "riscv_defines.vh"
module load_alignment (
        input  wire [                 1:0] addr,
        input  wire [`LOAD_OP_WIDTH  -1:0] LOADop,
        input  wire [                31:0] data,
        output reg  [                31:0] result,
        output reg                         unaligned_access
    );

    wire is_lb = `LOAD_OP_LB == LOADop;
    wire is_lbu = `LOAD_OP_LBU == LOADop;

    wire is_lh = `LOAD_OP_LH == LOADop;
    wire is_lhu = `LOAD_OP_LHU == LOADop;

    wire is_lw = `LOAD_OP_LW == LOADop;

    always @* begin
        result = 'hx;
        unaligned_access = 1'b0;
        if (is_lb | is_lbu) begin
            result[7:0] =
                  addr[1:0] == 2'b00 ? data[7  :0] :
                  addr[1:0] == 2'b01 ? data[15 :8] :
                  addr[1:0] == 2'b10 ? data[23:16] :
                  addr[1:0] == 2'b11 ? data[31:24] : 8'hx;
            result = {is_lbu ? 24'b0 : {24{result[7]}}, result[7:0]};
            unaligned_access = 1'b0;
        end

        if (is_lh | is_lhu) begin
            result[15:0] = ~addr[1] ? data[15 : 0] : addr[1] ? data[31 : 16] : 16'hx;
            result = {is_lhu ? 16'b0 : {16{result[15]}}, result[15:0]};
            unaligned_access = addr[0];
        end

        if (is_lw) begin
            result = data;
            unaligned_access = addr[1:0] != 2'b00;
        end
    end

endmodule
