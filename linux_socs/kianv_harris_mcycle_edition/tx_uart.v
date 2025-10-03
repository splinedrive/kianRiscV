/*
 *  tx_uart - a simple tx uart
 *
 *  copyright (c) 2021/2025  hirosh dabui <hirosh@dabui.de>
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
module tx_uart #(
    parameter FIFO_DEPTH = 16,  // choose 16/32/64…
    parameter STOP_BITS  = 1    // set 2 for extra margin
) (
    input wire clk,
    input wire resetn,

    // enqueue interface
    input wire       valid,   // assert 1-cycle when tx_data is valid
    input wire [7:0] tx_data,

    // baud divisor: div = SYS_CLK / BAUD  (bit time = div clocks)
    input wire [15:0] div,

    // serial line
    output reg tx_out,

    // status
    output wire ready,  // FIFO can accept a byte (not full)
    output wire busy    // shifter active OR FIFO non-empty
);

  // ------------------------------
  // Internal FIFO
  // ------------------------------
  wire       fifo_full;
  wire       fifo_empty;
  wire [7:0] fifo_dout;
  reg        fifo_pop;

  assign ready = ~fifo_full;

  fifo #(
      .DATA_WIDTH(8),
      .DEPTH     (FIFO_DEPTH)
  ) tx_fifo_i (
      .clk   (clk),
      .resetn(resetn),
      .din   (tx_data),
      .dout  (fifo_dout),
      .push  (valid & ~fifo_full),  // push only when not full
      .pop   (fifo_pop),            // 1-cycle when shifter loads a byte
      .full  (fifo_full),
      .empty (fifo_empty)
  );

  // ------------------------------
  // Transmit FSM
  // ------------------------------
  localparam S_IDLE = 3'd0;
  localparam S_DATA = 3'd1;
  localparam S_STOP = 3'd2;
  localparam S_WAIT = 3'd3;

  reg [2:0] state, return_state;
  reg [ 2:0] bit_idx;
  reg [ 7:0] tx_data_reg;

  // use 17 bits to hold up to (2*div - 1)
  reg [16:0] wait_states;

  // Busy if shifting or data pending
  assign busy = (state != S_IDLE) | ~fifo_empty;

  always @(posedge clk) begin
    if (!resetn) begin
      tx_out       <= 1'b1;  // idle high
      state        <= S_IDLE;
      return_state <= S_IDLE;
      bit_idx      <= 3'd0;
      tx_data_reg  <= 8'd0;
      wait_states  <= 17'd0;
      fifo_pop     <= 1'b0;
    end else begin
      fifo_pop <= 1'b0;  // default

      case (state)
        // ----------------------------------------------------------
        // IDLE: fetch next byte if available, drive start bit
        // ----------------------------------------------------------
        S_IDLE: begin
          tx_out  <= 1'b1;
          bit_idx <= 3'd0;

          if (!fifo_empty) begin
            tx_data_reg  <= fifo_dout;
            fifo_pop     <= 1'b1;  // consume from FIFO
            tx_out       <= 1'b0;  // start bit
            wait_states  <= {1'b0, div} - 17'd1;  // exactly div clocks
            return_state <= S_DATA;
            state        <= S_WAIT;
          end
        end

        // ----------------------------------------------------------
        // DATA: 8 bits, LSB first
        // ----------------------------------------------------------
        S_DATA: begin
          tx_out       <= tx_data_reg[bit_idx];
          bit_idx      <= bit_idx + 3'd1;

          wait_states  <= {1'b0, div} - 17'd1;
          return_state <= (&bit_idx) ? S_STOP : S_DATA;
          state        <= S_WAIT;
        end

        // ----------------------------------------------------------
        // STOP: 1 or 2 stop bits
        // ----------------------------------------------------------
        S_STOP: begin
          tx_out       <= 1'b1;
          wait_states  <= ({1'b0, div} * STOP_BITS) - 17'd1;
          return_state <= S_IDLE;
          state        <= S_WAIT;
        end

        // ----------------------------------------------------------
        // WAIT: zero-based countdown
        // ----------------------------------------------------------
        S_WAIT: begin
          if (wait_states == 17'd0) begin
            state <= return_state;
          end else begin
            wait_states <= wait_states - 17'd1;
          end
        end

        default: state <= S_IDLE;
      endcase
    end
  end

endmodule

