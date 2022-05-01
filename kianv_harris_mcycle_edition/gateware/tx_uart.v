/*
 *  tx_uart - a simple tx uart
 *
 *  copyright (c) 2021  hirosh dabui <hirosh@dabui.de>
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
`timescale 1ns/1ps
`default_nettype none
module tx_uart #(
        parameter SYSTEM_CLK = 100_000_000,
        parameter BAUDRATE = 9600
    ) (
        input wire clk,
        input wire resetn,
        input wire valid,
        input wire [7:0] tx_data,
        output reg tx_out,
        output wire ready
    );

    localparam SYSTEM_CYCLES = SYSTEM_CLK;
    localparam WAITSTATES_BIT_WIDTH = $clog2(SYSTEM_CYCLES);
    localparam [WAITSTATES_BIT_WIDTH-1:0] CYCLES_PER_SYMBOL = SYSTEM_CYCLES/BAUDRATE;//($rtoi(SYSTEM_CYCLES/BAUDRATE));

    initial begin
        $display("SYSTEM_CLK:\t\t", SYSTEM_CLK);
        $display("SYSTEM_CYCLES:\t\t", SYSTEM_CYCLES);
        $display("BAUDRATE:\t\t", BAUDRATE);
        $display("CYCLES_PER_SYMBOL:\t", CYCLES_PER_SYMBOL);
        $display("WAITSTATES_BIT_WIDTH:\t", WAITSTATES_BIT_WIDTH);
    end

    reg [2:0] state;
    reg [2:0] return_state;
    reg [2:0] bit_idx;
    reg [7:0] tx_data_reg;
    reg       txfer_done;

    assign ready = !(|state) & valid & txfer_done;

    reg [WAITSTATES_BIT_WIDTH-1:0] wait_states;

`ifdef SIM
    always @(posedge clk) begin
        if (ready) begin
            $write("%c", tx_data[7:0]);
            $fflush;
        end
    end
`endif

    always @(posedge clk) begin

        if (resetn == 1'b0) begin
            tx_out      <= 1'b1;
            state       <= 0;
            txfer_done  <= 1'b0;
            bit_idx     <= 0;
            tx_data_reg <= 0;
            txfer_done  <= 0;
        end else begin

            case (state)

                0: begin /* idle */
                    txfer_done <= 1'b0;
                    if (valid & !txfer_done) begin
                        tx_out <= 1'b0; /* start bit */
                        tx_data_reg <= tx_data;

                        wait_states <= CYCLES_PER_SYMBOL -1;
                        return_state <= 1;
                        state <= 3;

                    end else begin
                        tx_out <= 1'b1;
                    end
                end

                1: begin
                    tx_out  <= tx_data_reg[bit_idx]; /* lsb first */
                    bit_idx <= bit_idx + 1;

                    wait_states <= CYCLES_PER_SYMBOL -1;
                    return_state <= &bit_idx ? 2 : 1;
                    state <= 3;
                end

                2: begin
                    tx_out <= 1'b1; /* stop bit */

                    wait_states <= (CYCLES_PER_SYMBOL<<1) -1;
                    return_state <= 0;
                    state <= 3;
                end

                3: begin /* wait states */
                    wait_states <= wait_states -1;
                    if (wait_states == 1) begin
                        if (!(|return_state)) txfer_done <= 1'b1;
                        state <= return_state;
                    end
                end

                default: begin
                    state <= 0;
                end

            endcase

        end
    end /* !reset */

endmodule
