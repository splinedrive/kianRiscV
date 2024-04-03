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
`include "riscv_defines.vh"
module multiplier_extension_decoder (
    input  wire [               2:0] funct3,
    output wire [`MUL_OP_WIDTH -1:0] MULop,
    output wire [`DIV_OP_WIDTH -1:0] DIVop,
    input  wire                      mul_ext_valid,
    output wire                      mul_valid,
    output wire                      div_valid
);

  multiplier_decoder multiplier_I (
      funct3,
      MULop,
      mul_ext_valid,
      mul_valid
  );
  divider_decoder divider_decoder_I (
      funct3,
      DIVop,
      mul_ext_valid,
      div_valid
  );

endmodule
