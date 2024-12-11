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
`default_nettype none
module tx_uart (
    input wire clk,
    input wire resetn,
    input wire valid,
    input wire [7:0] tx_data,
    input wire [15:0] div,  /* SYSTEM_CYCLES/BAUDRATE */
    output reg tx_out,
    output wire ready,
    output wire busy
);


  reg [2:0] state;
  reg [2:0] return_state;
  reg [2:0] bit_idx;
  reg [7:0] tx_data_reg;
  reg       txfer_done;

  assign ready = txfer_done;
  assign busy  = |state;

  reg  [15:0] wait_states;
  wire [15:0] CYCLES_PER_SYMBOL;
  assign CYCLES_PER_SYMBOL = div;

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

        0: begin  /* idle */
          txfer_done <= 1'b0;
          if (valid & !txfer_done) begin
            tx_out <= 1'b0;  /* start bit */
            tx_data_reg <= tx_data;

            wait_states <= CYCLES_PER_SYMBOL - 1;
            return_state <= 1;
            state <= 3;

          end else begin
            tx_out <= 1'b1;
          end
        end

        1: begin
          tx_out <= tx_data_reg[bit_idx];  /* lsb first */
          bit_idx <= bit_idx + 1;

          wait_states <= CYCLES_PER_SYMBOL - 1;
          return_state <= &bit_idx ? 2 : 1;
          state <= 3;
        end

        2: begin
          tx_out <= 1'b1;  /* stop bit */

          wait_states <= (CYCLES_PER_SYMBOL << 1) - 1;
          return_state <= 0;
          state <= 3;
        end

        3: begin  /* wait states */
          wait_states <= wait_states - 1;
          if (wait_states == 1) begin
            if (~(|return_state)) txfer_done <= 1'b1;
            state <= return_state;
          end
        end

        default: begin
          state <= 0;
        end

      endcase

    end
  end  /* !reset */

endmodule
