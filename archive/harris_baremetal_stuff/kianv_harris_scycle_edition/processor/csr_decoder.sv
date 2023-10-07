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
module csr_decoder (
    input wire logic [2:0] funct3,
    output CsrOp_t CsrOp
);
  logic is_csrrs;
  assign is_csrrs = funct3 == 3'b010;

  always_comb begin
    case (1'b1)
      is_csrrs: CsrOp = CSR_OP_CSRRS;
      default:  CsrOp = CSR_OP_NA;
    endcase
  end

endmodule
