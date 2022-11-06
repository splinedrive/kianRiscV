/*
 *  kianv 5-staged pipelined RISC-V
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

`include "riscv_defines.svh"
module extend (
    input wire logic [31:7] Instr,
    input wire ImmSrc_t ImmSrc,
    output logic [31:0] ImmExt
);

  always_comb begin
    case (ImmSrc)
      IMMSRC_I_TYPE: ImmExt = {{20{Instr[31]}}, Instr[31:20]};
      IMMSRC_S_TYPE: ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
      IMMSRC_B_TYPE: ImmExt = {{20{Instr[31]}}, Instr[7:7], Instr[30:25], Instr[11:8], 1'b0};
      IMMSRC_J_TYPE: ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};
      IMMSRC_U_TYPE: ImmExt = {Instr[31:12], 12'b0};
      default:       ImmExt = 32'bx;
    endcase
  end
endmodule
