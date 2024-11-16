/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
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
`include "defines_soc.vh"
module pwm #(
    parameter DEPTH = 8192
) (
    input wire clk,
    input wire resetn,
    input wire we,
    input wire [7:0] pcm_i,
    output wire pwm_o,
    output wire fifo_full
);

  wire fifo_empty;
  wire [7:0] fifo_out;

  fifo #(
      .DATA_WIDTH(8),
      .DEPTH     (DEPTH)
  ) fifo_i (
      .clk   (clk),
      .resetn(resetn),
      .din   (pcm_i),
      .dout  (fifo_out),
      .push  (we),
      .pop   (tick & ~fifo_empty),
      .full  (fifo_full),
      .empty (fifo_empty)
  );

  reg [17:0] tick_cnt;
  /* verilator lint_off WIDTHEXPAND */
  wire tick = tick_cnt == (`SYSTEM_CLK / 8000) - 1;
  /* verilator lint_on WIDTHEXPAND */
  always @(posedge clk) begin
    if (!resetn || tick) begin
      tick_cnt <= 0;
    end else begin
      tick_cnt <= tick_cnt + 1;
    end
  end

  // https://www.fpga4fun.com/PWM_DAC_3.html
  reg [8:0] pwm_accumulator;
  reg [7:0] fifo_out_r;
  always @(posedge clk) fifo_out_r <= !resetn || fifo_empty ? 0 : fifo_out;
  always @(posedge clk) pwm_accumulator <= pwm_accumulator[7:0] + fifo_out_r;

  assign pwm_o = pwm_accumulator[8];

endmodule

