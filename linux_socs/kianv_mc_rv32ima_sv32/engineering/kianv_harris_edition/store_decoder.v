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

module store_decoder (
    input wire [2:0] funct3,
    input wire amo_operation_store,
    output reg [`STORE_OP_WIDTH-1:0] STOREop,
    input wire [1:0] addr_align_bits,
    output reg is_store_unaligned
);

  wire is_sb = funct3[1:0] == 2'b00;
  wire is_sh = funct3[1:0] == 2'b01;
  wire is_sw = funct3[1:0] == 2'b10;

  always @(*) begin
    is_store_unaligned = 1'b0;
    if (!amo_operation_store) begin
      case (1'b1)
        is_sb:   STOREop = `STORE_OP_SB;
        is_sh: begin
          STOREop = `STORE_OP_SH;
          is_store_unaligned = addr_align_bits[0];
        end
        is_sw: begin
          STOREop = `STORE_OP_SW;
          is_store_unaligned = |addr_align_bits;
        end
        default: STOREop = `STORE_OP_SB;
      endcase
    end else begin
      STOREop = `STORE_OP_SW;
      is_store_unaligned = |addr_align_bits;
    end
  end
endmodule

