/*
 *  kianv.v - a simple RISC-V rv32im
 *
 *  copyright (c) 2021 hirosh dabui <hirosh@dabui.de>
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

 /* gpio */
 reg  [GPIO_NR -1:0] gpio_output_en;
 wire [GPIO_NR -1:0] gpio_in;
 reg  [GPIO_NR -1:0] gpio_output_val;

 wire gpio_output_wr;
 wire gpio_output_val_wr;
 wire gpio_output_en_wr;

 /* input */
 assign gpio_in = gpio;

 /* output */
 genvar i;
 generate
   for (i = 0; i < GPIO_NR; i = i +1) begin
     assign gpio[i] = gpio_output_en[i] ? gpio_output_val[i] : 1'bz;
   end
 endgenerate

 always @(posedge clk) begin
   if (!resetn) begin
     gpio_output_en  <=  0;  // default all is input pin
     gpio_output_val <=  0;  // digilent led 0: off 1:0
   end else begin
     gpio_output_val <= gpio_output_val_wr ? mem_din[7:0] : gpio_output_val;
     gpio_output_en  <= gpio_output_en_wr  ? mem_din[7:0] : gpio_output_en;
   end
 end
