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
module extend (
    input  wire [31:7] instr,
    input  wire [ 2:0] immsrc,
    output reg  [31:0] immext
);

  always @(*) begin
    case (immsrc)
      `IMMSRC_ITYPE: immext = {{20{instr[31]}}, instr[31:20]};
      `IMMSRC_STYPE: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
      `IMMSRC_BTYPE: immext = {{20{instr[31]}}, instr[7:7], instr[30:25], instr[11:8], 1'b0};
      `IMMSRC_JTYPE: immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
      `IMMSRC_UTYPE: immext = {instr[31:12], 12'b0};
      default:       immext = 32'b0;
    endcase
  end
endmodule
