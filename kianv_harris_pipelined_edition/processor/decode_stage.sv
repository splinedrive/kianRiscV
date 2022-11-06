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

module decode_stage (
    input wire logic clk,
    input wire logic resetn,
    input wire logic Stall,
    input wire logic FlushE,
    input wire logic [31:0] InstrD,
    input wire logic [31:0] PCD,
    input wire logic RegWriteD,
    input wire ResultSrc_t ResultSrcD,
    input wire PCTargetSrc_t PCTargetSrcD,
    input wire LoadOp_t LoadOpD,
    input wire StoreOp_t StoreOpD,
    input wire logic MemWriteD,
    input wire logic JumpD,
    input wire logic BranchD,
    input wire logic CsrInstrIncD,
    input wire logic [31:0] ResultW,
    input wire ForwardAD_t ForwardAD,
    input wire ForwardBD_t ForwardBD,
    input wire AluControl_t AluControlD,
    input wire AluSrcA_t AluSrcAD,
    input wire AluSrcB_t AluSrcBD,
    input wire logic [31:0] PCPlus4D,
    input wire logic [31:0] ImmExtD,
    input wire CsrOp_t CsrOpD,
    output wire logic [4:0] Rs1E,
    output wire logic [4:0] Rs2E,
    output wire logic [4:0] Rs1D,
    output wire logic [4:0] Rs2D,
    output wire logic Immb10D,
    output wire logic RegWriteE,
    output wire ResultSrc_t ResultSrcE,
    output wire PCTargetSrc_t PCTargetSrcE,
    output wire LoadOp_t LoadOpE,
    output wire StoreOp_t StoreOpE,
    output wire logic MemWriteE,
    output wire logic JumpE,
    output wire logic BranchE,
    output wire logic CsrInstrIncE,
    output wire logic [31:0] Rd1D,
    output wire logic [31:0] Rd2D,
    output wire logic [4:0] RdE,
    output wire logic [31:0] Rd1E,
    output wire logic [31:0] Rd2E,
    output wire AluControl_t AluControlE,
    output wire AluSrcA_t AluSrcAE,
    output wire AluSrcB_t AluSrcBE,
    output wire logic [31:0] PCPlus4E,
    output wire logic [31:0] ImmExtE,
    output wire logic [31:0] PCE,

`ifndef SIM  // formatter will cry without
    output wire CsrOp_t CsrOpE
`else
    output wire CsrOp_t CsrOpE,
    output wire logic [31:0] InstrE
`endif
);
  // decode stage

  logic FlushE_resetn;
  logic [4:0] RdD;

  assign FlushE_resetn = resetn & ~FlushE;

  assign Rs1D = InstrD[19:15];
  assign Rs2D = InstrD[24:20];
  assign RdD = InstrD[11:7];

  assign Immb10D = ImmExtD[10];

  dflop #(1, 0) RegWriteE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(RegWriteD),
      .q(RegWriteE)
  );

  dflop #($bits(
      ResultSrcE
  ), 0) ResultSrcE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(ResultSrcD),
`ifdef ICARUS
      .q(ResultSrcE)
`else
      .q({>>{ResultSrcE}})
`endif
  );

  dflop #($bits(
      PCTargetSrcE
  ), 0) PCTargetSrcE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCTargetSrcD),
`ifdef ICARUS
      .q(PCTargetSrcE)
`else
      .q({>>{PCTargetSrcE}})
`endif
  );

  dflop #($bits(
      LoadOpE
  ), 0) LoadOpE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(LoadOpD),
`ifdef ICARUS
      .q(LoadOpE)
`else
      .q({>>{LoadOpE}})
`endif
  );

  dflop #($bits(
      StoreOpE
  ), 0) StoreOpE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(StoreOpD),
`ifdef ICARUS
      .q(StoreOpE)
`else
      .q({>>{StoreOpE}})
`endif
  );

  dflop #(1, 0) MemWriteE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(MemWriteD),
      .q(MemWriteE)
  );

  dflop #(1, 0) JumpE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(JumpD),
      .q(JumpE)
  );

  dflop #(1, 0) BranchE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(BranchD),
      .q(BranchE)
  );

  dflop #(1, 0) CsrInstrIncD_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(CsrInstrIncD),
      .q(CsrInstrIncE)
  );

  //////

  dflop #(5, 0) RdE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(RdD),
      .q(RdE)
  );

  logic [31:0] SrcFWD_AD;
  mux2 #(32) ForwardAD_mux_i (
      .d0(Rd1D),
      .d1(ResultW),
      .s (ForwardAD),
      .y (SrcFWD_AD)
  );

  dflop #(32, 0) Rd1E_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(SrcFWD_AD),
      .q(Rd1E)
  );

  logic [31:0] SrcFWD_BD;
  mux2 #(32) ForwardBD_mux_i (
      .d0(Rd2D),
      .d1(ResultW),
      .s (ForwardBD),
      .y (SrcFWD_BD)
  );

  dflop #(32, 0) Rd2E_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(SrcFWD_BD),
      .q(Rd2E)
  );

  dflop #(5, 0) Rs1E_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(Rs1D),
      .q(Rs1E)
  );

  dflop #(5, 0) Rs2E_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(Rs2D),
      .q(Rs2E)
  );

  dflop #($bits(
      AluControlE
  ), 0) AluControlE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(AluControlD),
`ifdef ICARUS
      .q(AluControlE)
`else
      .q({>>{AluControlE}})
`endif
  );

  dflop #($bits(
      AluSrcAE
  ), 0) AluSrcAE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(AluSrcAD),
`ifdef ICARUS
      .q(AluSrcAE)
`else
      .q({>>{AluSrcAE}})
`endif
  );

  dflop #($bits(
      AluSrcBE
  ), 0) AluSrcBE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(AluSrcBD),
`ifdef ICARUS
      .q(AluSrcBE)
`else
      .q({>>{AluSrcBE}})
`endif
  );

  dflop #(32, 0) PCPlus4E_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCPlus4D),
      .q(PCPlus4E)
  );

  dflop #(32, 0) ImmExtE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(ImmExtD),
      .q(ImmExtE)
  );

  dflop #(32, 0) PCE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCD),
      .q(PCE)
  );

  dflop #($bits(
      CsrOpE
  ), 0) CsrOpE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(CsrOpD),
`ifdef ICARUS
      .q(CsrOpE)
`else
      .q({>>{CsrOpE}})
`endif
  );

`ifdef SIM
  dflop #(32, `NOP_INSTR) InstrE_i (
      .resetn(FlushE_resetn),
      .clk(clk),
      .en(!Stall),
      .d(InstrD),
      .q(InstrE)
  );
`endif
endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type
