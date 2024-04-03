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
module load_decoder (
    input wire [2:0] funct3,
    input wire amo_data_load,
    output reg [`LOAD_OP_WIDTH -1:0] LOADop,
    input wire [1:0] addr_align_bits,
    output reg is_load_unaligned
);
  wire is_lb = funct3 == 3'b000;
  wire is_lh = funct3 == 3'b001;
  wire is_lw = funct3 == 3'b010;
  wire is_lbu = funct3 == 3'b100;
  wire is_lhu = funct3 == 3'b101;

  always @(*) begin
    is_load_unaligned = 1'b0;
    if (!amo_data_load) begin
      case (1'b1)
        is_lb:  LOADop = `LOAD_OP_LB;
        is_lbu: LOADop = `LOAD_OP_LBU;
        is_lhu: LOADop = `LOAD_OP_LHU;

        is_lh: begin
          LOADop = `LOAD_OP_LH;
          is_load_unaligned = addr_align_bits[0];
        end
        is_lw: begin
          LOADop = `LOAD_OP_LW;
          is_load_unaligned = |addr_align_bits;
        end
        default: LOADop = `LOAD_OP_LB;
        /* verilator lint_on WIDTH */
      endcase
    end else begin
      LOADop = `LOAD_OP_LW;
      is_load_unaligned = |addr_align_bits;
    end
  end

endmodule
