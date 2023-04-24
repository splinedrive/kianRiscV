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
`default_nettype none
`timescale 1 ns/100 ps
`include "riscv_defines.vh"
module load_decoder
    (
        input  wire [ 2: 0] funct3,
        input wire amo_load,
        output reg  [`LOAD_OP_WIDTH -1: 0] LOADop
    );
    wire is_lb      = funct3 == 3'b 000;
    wire is_lh      = funct3 == 3'b 001;
    wire is_lw      = funct3 == 3'b 010;
    wire is_lbu     = funct3 == 3'b 100;
    wire is_lhu     = funct3 == 3'b 101;

    always @(*) begin
        if (!amo_load) begin
            case (1'b1)
                is_lb  : LOADop = `LOAD_OP_LB;
                is_lh  : LOADop = `LOAD_OP_LH;
                is_lw  : LOADop = `LOAD_OP_LW;
                is_lbu : LOADop = `LOAD_OP_LBU;
                is_lhu : LOADop = `LOAD_OP_LHU;
                default:
                    /* verilator lint_off WIDTH */
                    LOADop = 'hxx;
                /* verilator lint_on WIDTH */
            endcase
        end else begin
            LOADop = `LOAD_OP_LW;
        end
    end

endmodule
