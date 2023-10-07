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

module execute_stage (
    input wire logic clk,
    input wire logic resetn,
    input wire logic Stall,
    input wire logic RegWriteE,
    input wire ResultSrc_t ResultSrcE,
    input wire LoadOp_t LoadOpE,
    input wire StoreOp_t StoreOpE,
    input wire logic [31:0] Rd1E,
    input wire logic [31:0] Rd2E,
    input wire logic [4:0] RdE,
    input wire logic [31:0] PCPlus4E,
    input wire logic [31:0] PCE,
    input wire logic [31:0] ImmExtE,
    input wire logic [31:0] ResultW,
    input wire logic [31:0] AluResultE,
    input wire logic MemWriteE,
    input wire PCTargetSrc_t PCTargetSrcE,
    input wire AluSrcA_t AluSrcAE,
    input wire AluSrcB_t AluSrcBE,
    input wire ForwardAE_t ForwardAE,
    input wire ForwardBE_t ForwardBE,
    input wire logic [31:0] CsrDataE,
    output wire logic [31:0] AluResultM,
    output wire logic RegWriteM,
    output wire ResultSrc_t ResultSrcM,
    output wire logic MemWriteM,
    output wire LoadOp_t LoadOpM,
    output wire StoreOp_t StoreOpM,
    output wire logic [31:0] Rd2M,
    output wire logic [4:0] RdM,
    output wire logic [31:0] PCPlus4M,
    output wire logic [31:0] PCTargetE,
    output wire logic [31:0] SrcAE,
    output wire logic [31:0] SrcBE,
    output wire ResultSrc_t ResultSrcE_,
`ifndef SIM
    output wire logic [31:0] WriteDataUnAlignedM
`else
    input wire logic [31:0] InstrE,
    output wire logic [31:0] WriteDataUnAlignedM,
    output wire logic [31:0] InstrM
`endif
);

  dflop #(1, 0) RegWriteM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(RegWriteE),
      .q(RegWriteM)
  );

  logic isCsrOperation;
  assign isCsrOperation = ResultSrcE == ResultSrc_t'(RESULT_SRC_CSRDATA);
  assign ResultSrcE_ = isCsrOperation ? RESULT_SRC_ALURESULT : ResultSrcE;

  dflop #($bits(
      ResultSrcM
  ), 0) ResultSrcM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(ResultSrcE_),
`ifdef ICARUS
      .q(ResultSrcM)
`else
      .q({>>{ResultSrcM}})
`endif
  );

  dflop #(1, 0) MemWriteM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(MemWriteE),
      .q(MemWriteM)
  );

  dflop #($bits(
      LoadOpM
  ), 0) LoadOpM_t (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(LoadOpE),
`ifdef ICARUS
      .q(LoadOpM)
`else
      .q({>>{LoadOpM}})
`endif
  );

  dflop #($bits(
      StoreOpM
  ), 0) StoreOpM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(StoreOpE),
`ifdef ICARUS
      .q(StoreOpM)
`else
      .q({>>{StoreOpM}})
`endif
  );

  //////

  dflop #(32, 0) Rd2M_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(Rd2E),
      .q(Rd2M)
  );

  dflop #(5, 0) RdM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(RdE),
      .q(RdM)
  );

  dflop #(32, 0) PCPlus4M_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(PCPlus4E),
      .q(PCPlus4M)
  );


  //PC += imm
  //PC = rs1 + imm
  logic [31:0] SrcAE_PCE;
  mux2 #(32) SrcAE_PCE_i (
      .d0(SrcAE),  // rs1 + imm
      .d1(PCE),  // PC + imm
      .s(PCTargetSrcE),
      .y(SrcAE_PCE)
  );

  adder #(
      .WIDTH(32)
  ) pc_target_add_i (
      .a(SrcAE_PCE),
      .b(ImmExtE),
      .y(PCTargetE)
  );

  // todo: correction: in csr cycle case: we lose 2 cycles without forwarding
  logic [31:0] AluResultOrCsrDataE;
  mux2 #(32) AluResultOrCsrDataE_i (
      .d0(AluResultE),
      .d1(CsrDataE),
      .s (isCsrOperation),
      .y (AluResultOrCsrDataE)
  );

  dflop #(32, 0) AluResultM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(AluResultOrCsrDataE),
      .q(AluResultM)
  );

  // forwarding logic
  logic [31:0] SrcFWD_AE;
  mux3 #(32) ForwardAE_mux_i (
      .d0(Rd1E),
      .d1(ResultW),
      .d2(AluResultM),
      .s (ForwardAE),
      .y (SrcFWD_AE)
  );

  mux2 #(32) srca_mux (
      .d0(SrcFWD_AE),
      .d1(PCE),
      .s (AluSrcAE),
      .y (SrcAE)
  );

  logic [31:0] SrcFWD_BE;
  mux3 #(32) ForwardBE_mux_i (
      .d0(Rd2E),
      .d1(ResultW),
      .d2(AluResultM),
      .s (ForwardBE),
      .y (SrcFWD_BE)
  );

  mux2 #(32) srcb_mux (
      .d0(SrcFWD_BE),
      .d1(ImmExtE),
      .s (AluSrcBE),
      .y (SrcBE)
  );

  logic [31:0] WriteDataE;

  assign WriteDataE = SrcFWD_BE;
  dflop #(32, 0) WriteDataUnAlignedM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(WriteDataE),
      .q(WriteDataUnAlignedM)
  );

`ifdef SIM
  dflop #(32, `NOP_INSTR) InstrM_i (
      .resetn(resetn),
      .clk(clk),
      .en(!Stall),
      .d(InstrE),
      .q(InstrM)
  );
`endif
endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type

