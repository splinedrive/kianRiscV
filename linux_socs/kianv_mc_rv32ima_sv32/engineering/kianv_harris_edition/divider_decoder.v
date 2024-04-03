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
module divider_decoder (
    input  wire [               2:0] funct3,
    output reg  [`DIV_OP_WIDTH -1:0] DIVop,
    input  wire                      mul_ext_valid,
    output wire                      div_valid
);

  wire is_div = funct3 == 3'b100;
  wire is_divu = funct3 == 3'b101;
  wire is_rem = funct3 == 3'b110;
  wire is_remu = funct3 == 3'b111;
  reg  valid;

  assign div_valid = valid & mul_ext_valid;

  always @(*) begin
    valid = 1'b1;
    case (1'b1)
      is_div:  DIVop = `DIV_OP_DIV;
      is_divu: DIVop = `DIV_OP_DIVU;
      is_rem:  DIVop = `DIV_OP_REM;
      is_remu: DIVop = `DIV_OP_REMU;
      default: begin
        /* verilator lint_off WIDTH */
        DIVop = 'hxx;
        /* verilator lint_on WIDTH */
        valid = 1'b0;
      end
    endcase
  end

endmodule
