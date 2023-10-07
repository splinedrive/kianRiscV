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

module memory_stage (
    input wire logic clk,
    input wire logic resetn,
    input wire logic Stall,
    input wire logic RegWriteM,
    input wire ResultSrc_t ResultSrcM,
    input wire LoadOp_t LoadOpM,
    input wire StoreOp_t StoreOpM,
    input wire logic [4:0] RdM,
    input wire logic [31:0] AluResultM,
    input wire logic [31:0] WriteDataUnAlignedM,
    input wire logic [31:0] PCPlus4M,
    input wire logic [31:0] ReadDataM,
    output wire logic [31:0] WriteDataM,
    output wire logic RegWriteW,
    output wire ResultSrc_t ResultSrcW,
    output wire LoadOp_t LoadOpW,
    output wire logic [4:0] RdW,
    output wire logic [31:0] AluResultW,
    output wire logic [3:0] wmask,
    output wire logic [31:0] PCPlus4W,
`ifndef SIM
    output wire logic [31:0] ReadDataW
`else
    output wire logic [31:0] ReadDataW,
    input wire logic [31:0] InstrM,
    output wire logic [31:0] InstrW
`endif
);
  dflop #(1, 0) RegWriteW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(RegWriteM),
      .q(RegWriteW)
  );

  dflop #($bits(
      ResultSrcW
  ), 0) ResultSrcW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(ResultSrcM),
`ifdef ICARUS
      .q(ResultSrcW)
`else
      .q({>>{ResultSrcW}})
`endif
  );

  dflop #($bits(
      LoadOpW
  ), 0) LoadOpW_t (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(LoadOpM),
`ifdef ICARUS
      .q(LoadOpW)
`else
      .q({>>{LoadOpW}})
`endif
  );

  //////

  dflop #(5, 0) RdW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(RdM),
      .q(RdW)
  );

  dflop #(32, 0) AluResultW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(AluResultM),
      .q(AluResultW)
  );

  store_alignment store_alignment_i (
      .addr(AluResultM[1:0]),
      .StoreOp(StoreOpM),
      .data(WriteDataUnAlignedM),
      .result(WriteDataM),
      .wmask(wmask)
  );

  dflop #(32, 0) PCPlus4W_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCPlus4M),
      .q(PCPlus4W)
  );

  dflop #(32, 0) ReadDataW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(ReadDataM),
      .q(ReadDataW)
  );

`ifdef SIM
  dflop #(32, `NOP_INSTR) InstrW_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(InstrM),
      .q(InstrW)
  );
`endif
  /* verilator lint_on WIDTH */
  // verilog_lint: waive-stop explicit-parameter-storage-type
endmodule
