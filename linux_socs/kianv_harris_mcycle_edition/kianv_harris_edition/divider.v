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
module divider (
        input wire clk,
        input wire resetn,

        input  wire [              31 : 0] divident,
        input  wire [              31 : 0] divisor,
        input  wire [`DIV_OP_WIDTH -1 : 0] DIVop,
        output wire [                31:0] divOrRemRslt,
        input  wire                        valid,
        output reg                         ready,
        output wire                        div_by_zero_err
    );
    // division radix-2 restoring
    localparam IDLE_BIT = 0;
    localparam CALC_BIT = 1;
    localparam READY_BIT = 2;

    localparam IDLE = 1 << IDLE_BIT;
    localparam CALC = 1 << CALC_BIT;
    localparam READY = 1 << READY_BIT;

    localparam NR_STATES = 3;

    (* onehot *)
    reg [NR_STATES-1:0] div_state;

    reg [31:0] rem_rslt;
    reg [4:0] bit_idx;

    wire is_div = DIVop == `DIV_OP_DIV;
    wire is_divu = DIVop == `DIV_OP_DIVU;
    wire is_rem = DIVop == `DIV_OP_REM;
    wire is_remu = DIVop == `DIV_OP_REMU;

    wire is_signed = is_div | is_rem;

    wire [31:0] divident_abs = (is_signed & divident[31]) ? ~divident + 1 : divident;  // divident
    wire [31:0] divisor_abs = (is_signed & divisor[31]) ? ~divisor + 1 : divisor;  // divisor
    assign div_by_zero_err = divisor_abs == 32'b0;

    reg [31:0] div_rslt;
    wire [31:0] div_rslt_next = div_rslt << 1;
    /* verilator lint_off WIDTH */
    wire [31:0] rem_rslt_next = (rem_rslt << 1) | div_rslt[31];
    /* verilator lint_on WIDTH */
    wire [32:0] rem_rslt_sub_divident = rem_rslt_next - divisor_abs;

    always @(posedge clk) begin
        if (!resetn) begin
            div_rslt  <= 0;
            rem_rslt  <= 0;
            div_state <= IDLE;
            ready     <= 1'b0;
            bit_idx   <= 0;
        end else begin

            (* parallel_case, full_case *)
            case (1'b1)

                div_state[IDLE_BIT]: begin
                    ready <= 1'b0;
                    if (!ready && valid) begin
                        div_rslt  <= divident_abs;
                        rem_rslt  <= 0;

                        bit_idx   <= 0;
                        div_state <= CALC;
                    end
                end

                div_state[CALC_BIT]: begin
                    bit_idx <= bit_idx + 1'b1;
                    if (rem_rslt_sub_divident[32]) begin
                        rem_rslt <= rem_rslt_next;
                        /* verilator lint_off WIDTH */
                        div_rslt <= div_rslt_next | 1'b0;
                        /* verilator lint_on WIDTH */
                    end else begin
                        rem_rslt <= rem_rslt_sub_divident[31:0];
                        /* verilator lint_off WIDTH */
                        div_rslt <= div_rslt_next | 1'b1;
                        /* verilator lint_on WIDTH */
                    end

                    if (&bit_idx) begin
                        div_state <= READY;
                    end
                end

                div_state[READY_BIT]: begin
                    div_rslt  <= (is_signed & (divident[31] ^ divisor[31]) & |divisor) ? ~div_rslt + 1 : div_rslt;
                    rem_rslt <= (is_signed & divident[31]) ? ~rem_rslt + 1 : rem_rslt;
                    ready <= 1'b1;
                    div_state <= IDLE;
                end

            endcase

        end
    end

    assign divOrRemRslt = (is_div | is_divu) ? div_rslt : rem_rslt;
endmodule
