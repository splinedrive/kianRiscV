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
module csr_unit
    (
        input  wire clk,
        input  wire resetn,
        input  wire IRWrite,
        input  wire [11: 0] ImmExt,
        input  wire [`CSR_OP_WIDTH -1: 0] CSRop,
        output reg  [              31: 0] rdata
    );
    // CSR
    // csr rdcycle[H], rdtime[H], rdinstret[H]
    wire [63:0] cycle_counter;
    wire [63:0] instr_counter;

    counter     #(64) instr_cnt_I (resetn, clk, IRWrite, instr_counter);
    counter     #(64) cycle_cnt_I (resetn, clk, 1'b 1,   cycle_counter);

    wire [11: 0] csr_register = ImmExt;

    wire decode_csrs = CSRop == `CSR_OP_CSRRS;
    wire is_rdcycle  = decode_csrs & (csr_register == `CSR_REG_CYCLE    );
    wire is_rdcycleh = decode_csrs & (csr_register == `CSR_REG_CYCLEH   );

    wire is_instret  = decode_csrs & (csr_register == `CSR_REG_INSTRET  );
    wire is_instreth = decode_csrs & (csr_register == `CSR_REG_INSTRETH );

    wire is_time     = decode_csrs & (csr_register == `CSR_REG_TIME     );
    wire is_timeh    = decode_csrs & (csr_register == `CSR_REG_TIMEH    );

    always @(*) begin
        case (1'b 1)
            /* read only registers */
            is_instret  : rdata = instr_counter[31: 0];
            is_instreth : rdata = instr_counter[63:32];
            is_rdcycle  : rdata = cycle_counter[31: 0];
            is_rdcycleh : rdata = cycle_counter[63:32];
            is_time     : rdata = cycle_counter[31: 0];
            is_timeh    : rdata = cycle_counter[63:32];
            default:
                rdata = 32'h x;
        endcase


    end

endmodule
