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
`include "riscv_defines.vh"
module csr_decoder
    (
        input  wire [ 2: 0] funct3,
        output reg  [`CSR_OP_WIDTH -1: 0] CSRop
    );
    wire is_csrrs      = funct3 == 3'b 010;

    always @(*) begin
        case (1'b1)
            is_csrrs  : CSRop = `CSR_OP_CSRRS;
            default:
                CSRop = `CSR_OP_NA;
        endcase
    end

endmodule
