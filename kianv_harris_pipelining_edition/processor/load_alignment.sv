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
module load_alignment (
    input  wire logic    [ 1:0] addr,
    input  wire LoadOp_t        LoadOp,
    input  wire logic    [31:0] data,
    output logic         [31:0] result
);

  logic is_lb;
  logic is_lbu;

  logic is_lh;
  logic is_lhu;

  logic is_lw;

  assign is_lb  = LOAD_OP_LB == LoadOp;
  assign is_lbu = LOAD_OP_LBU == LoadOp;

  assign is_lh  = LOAD_OP_LH == LoadOp;
  assign is_lhu = LOAD_OP_LHU == LoadOp;

  assign is_lw  = LOAD_OP_LW == LoadOp;

  always_comb begin
    result = 'hx;

    if (is_lb | is_lbu) begin
      result[7:0] =
                  addr[1:0] == 2'b00 ? data[7  :0] :
                  addr[1:0] == 2'b01 ? data[15 :8] :
                  addr[1:0] == 2'b10 ? data[23:16] :
                  addr[1:0] == 2'b11 ? data[31:24] : 8'hx;
      result = {is_lbu ? 24'b0 : {24{result[7]}}, result[7:0]};
    end

    if (is_lh | is_lhu) begin
      result[15:0] = ~addr[1] ? data[15 : 0] : addr[1] ? data[31 : 16] : 16'hx;
      result = {is_lhu ? 16'b0 : {16{result[15]}}, result[15:0]};
    end

    if (is_lw) result = data;

  end

endmodule
