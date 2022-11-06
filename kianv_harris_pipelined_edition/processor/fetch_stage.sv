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
// verilog_lint: waive-start explicit-parameter-storage-type
/* verilator lint_off WIDTH */
`include "riscv_defines.svh"

module fetch_stage (
    input wire logic clk,
    input wire logic resetn,
    input wire logic [31:0] Instr,
    input wire logic FlushD,
    input wire logic Stall,
    input wire logic [31:0] PCF,
    output wire logic [31:0] InstrD,
    output wire logic [31:0] PCPlus4F,
    output wire logic [31:0] PCPlus4D,
    output wire logic [31:0] PCD
);

  logic FlushD_resetn;
  assign FlushD_resetn = resetn & !FlushD;

  dflop #(32, `NOP_INSTR) InstrD_i (
      .resetn(FlushD_resetn),
      .clk(clk),
      .en(!Stall),
      .d(Instr),
      .q(InstrD)
  );

  adder #(
      .WIDTH(32)
  ) pc_plus4f_i (
      .a(PCF),
      .b(32'd4),
      .y(PCPlus4F)
  );

  dflop #(32, 0) PCPlus4D_i (
      .resetn(FlushD_resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCPlus4F),
      .q(PCPlus4D)
  );

  dflop #(32, 0) PCD_i (
      .resetn(FlushD_resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCF),
      .q(PCD)
  );
endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type
