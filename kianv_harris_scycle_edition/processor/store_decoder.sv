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
`default_nettype none `timescale 1 ns / 100 ps
`include "riscv_defines.svh"
module store_decoder (
    input wire logic [2:0] funct3,
    output StoreOp_t StoreOp
);
  logic is_sb;
  logic is_sh;
  logic is_sw;

  assign is_sb = funct3[1:0] == 2'b00;
  assign is_sh = funct3[1:0] == 2'b01;
  assign is_sw = funct3[1:0] == 2'b10;

  always_comb begin
    case (1'b1)
      is_sb: StoreOp = STORE_OP_SB;
      is_sh: StoreOp = STORE_OP_SH;
      is_sw: StoreOp = STORE_OP_SW;
      default: begin
        /* verilator lint_off WIDTH */
        //  StoreOp = 'hxx;
        StoreOp = STORE_OP_SB;
        /* verilator lint_on WIDTH */
      end
    endcase
  end

endmodule
