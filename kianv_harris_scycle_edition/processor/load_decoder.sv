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
module load_decoder (
    input wire [2:0] funct3,
    output LoadOp_t LoadOp
);
  logic is_lb;
  logic is_lh;
  logic is_lw;
  logic is_lbu;
  logic is_lhu;

  assign is_lb  = funct3 == 3'b000;
  assign is_lh  = funct3 == 3'b001;
  assign is_lw  = funct3 == 3'b010;
  assign is_lbu = funct3 == 3'b100;
  assign is_lhu = funct3 == 3'b101;

  always_comb begin
    case (1'b1)
      is_lb:  LoadOp = LOAD_OP_LB;
      is_lh:  LoadOp = LOAD_OP_LH;
      is_lw:  LoadOp = LOAD_OP_LW;
      is_lbu: LoadOp = LOAD_OP_LBU;
      is_lhu: LoadOp = LOAD_OP_LHU;
      default: begin
        /* verilator lint_off WIDTH */
        //LoadOp = 'hxx;
        LoadOp = LOAD_OP_LB;
        /* vLoadOperilator lint_on WIDTH */
      end
    endcase
  end

endmodule
