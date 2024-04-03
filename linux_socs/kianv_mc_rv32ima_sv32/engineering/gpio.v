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
module gpio #(
    parameter GPIO_NR = 8
) (
    input  wire                clk,
    input  wire                resetn,
    input  wire [         3:0] addr,
    input  wire [         3:0] wrstb,
    input  wire [        31:0] wdata,
    output reg  [        31:0] rdata,
    input  wire                valid,
    output reg                 ready,
    inout  wire [GPIO_NR -1:0] gpio
);

  reg  [GPIO_NR -1:0] gpio_out_en;
  wire [GPIO_NR -1:0] gpio_in;
  reg  [GPIO_NR -1:0] gpio_out_val;

  // Read the input value of the GPIO pins
  assign gpio_in = gpio;

  genvar i;
  // Assigning output values
  generate
    for (i = 0; i < GPIO_NR; i = i + 1) begin
      assign gpio[i] = gpio_out_en[i] ? gpio_out_val[i] : 1'bz;
    end
  endgenerate

  wire wr = |wrstb;

  // Ready signal logic
  always @(posedge clk) ready <= !resetn ? 0 : valid;

  // Control logic for GPIO
  always @(posedge clk) begin
    if (!resetn) begin
      gpio_out_en  <= 0;  // default all pins as input
      gpio_out_val <= 0;  // default all output values to 0
    end else begin
      /* verilator lint_off WIDTH */
      if (valid) begin
        case (addr)
          0:  // 1 output, 0 input
          if (wr) gpio_out_en <= wdata[GPIO_NR-1:0];
          else rdata <= gpio_out_en;

          4:  // Set or Get the output value
          if (wr) gpio_out_val <= wdata[GPIO_NR-1:0];
          else rdata <= gpio_out_val;

          8:  // Get the input value
          if (!wr) rdata <= gpio_in;

          default:  // Safety: Ensure no stale value
          rdata <= 32'b0;
        endcase
      end
      /* verilator lint_on WIDTH */
    end
  end

endmodule

