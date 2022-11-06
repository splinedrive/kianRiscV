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

module datapath_unit #(
    parameter RESET_ADDR = 0
) (
    input wire logic clk,
    input wire logic resetn,
    input wire logic halt,

    input  wire logic [31:0] Instr,
    output wire logic [31:0] InstrD,

    // ctrl signals
    input wire PCTargetSrc_t PCTargetSrcD,
    input wire ResultSrc_t   ResultSrcD,
    input wire AluControl_t  AluControlD,
    input wire AluSrcA_t     AluSrcAD,
    input wire AluSrcB_t     AluSrcBD,
    input wire ImmSrc_t      ImmSrcD,
    input wire logic         RegWriteD,
    input wire StoreOp_t     StoreOpD,
    input wire LoadOp_t      LoadOpD,
    input wire CsrOp_t       CsrOpD,

    output wire logic Immb10D,
    input  wire logic CsrInstrIncD,

    // dmem
    input wire logic MemWriteD,
    input wire logic JumpD,
    input wire logic BranchD,

    output wire logic [31:0] AluResultM,
    output wire logic [31:0] WriteDataM,
    input wire logic [31:0] ReadDataM,
    output wire logic [3:0] WriteMaskM,
    output wire logic ReadMemM,
    // branch logic
    output wire logic [31:0] PCF
);

  ///////////////////////////////////////////////////////////////////////////////////////
  logic [31:0] PCPlus4F;
  logic [31:0] PCPlus4D;
  logic [31:0] PCD;

  logic [4:0] Rs1E;
  logic [4:0] Rs2E;
  logic [31:0] Rd1D;
  logic [31:0] Rd2D;
  logic RegWriteE;
  ResultSrc_t ResultSrcE;
  PCTargetSrc_t PCTargetSrcE;
  LoadOp_t LoadOpE;
  StoreOp_t StoreOpE;
  logic MemWriteE;
  logic JumpE;
  logic BranchE;
  logic CsrInstrIncE;
  logic [4:0] Rs1D;
  logic [4:0] Rs2D;
  logic [4:0] RdE;
  logic [31:0] Rd1E;
  logic [31:0] Rd2E;
  AluControl_t AluControlE;
  AluSrcA_t AluSrcAE;
  AluSrcB_t AluSrcBE;
  logic [31:0] PCPlus4E;
  logic [31:0] ImmExtE;
  logic [31:0] PCE;
  CsrOp_t CsrOpE;
`ifdef SIM
  logic [31:0] InstrE;
`endif
  ///////////////////////////////////////////////////////////////////////////////////////

  logic RegWriteM;
  ResultSrc_t ResultSrcM;
  logic MemWriteM;
  LoadOp_t LoadOpM;
  StoreOp_t StoreOpM;
  logic [31:0] Rd2M;
  logic [4:0] RdM;
  logic [31:0] PCPlus4M;
  logic [31:0] PCTargetE;
  logic [31:0] SrcAE;
  logic [31:0] SrcBE;
  ResultSrc_t ResultSrcE_;
  logic [31:0] WriteDataUnAlignedM;
`ifdef SIM
  logic [31:0] InstrM;
`endif

  logic RegWriteW;
  ResultSrc_t ResultSrcW;
  LoadOp_t LoadOpW;
  logic [4:0] RdW;
  logic [31:0] AluResultW;
  logic [3:0] wmask;
  logic [31:0] PCPlus4W;
`ifndef SIM
  logic [31:0] ReadDataW;
`else
  logic [31:0] ReadDataW;
  logic [31:0] InstrW;
`endif

  ///////////////////////////////////////////////////////////////////////////////////////

  logic       [31:0] ReadDataAlignedW;
  PCSrc_t            PCSrcE;
  logic       [31:0] PCF_;
  logic       [31:0] ImmExtD;
  logic       [31:0] AluResultE;
  logic              ZeroE;
  logic              taken_branch;
  logic              ResultSrcE0;

  ForwardAE_t        ForwardAE;
  ForwardBE_t        ForwardBE;

  ForwardAD_t        ForwardAD;
  ForwardBD_t        ForwardBD;

  logic              StallF;
  logic              StallD;
  logic              FlushD;
  logic              FlushE;

  logic       [31:0] CsrDataE;
  logic       [31:0] ResultW;

  ///////////////////////////////////////////////////////////////////////////////////////

  fetch_stage fetch_stage_i (
      .clk     (clk),
      .resetn  (resetn),
      .Instr   (Instr),
      .FlushD  (FlushD),
      .Stall   (StallD),
      .PCF     (PCF),
      .InstrD  (InstrD),
      .PCPlus4F(PCPlus4F),
      .PCPlus4D(PCPlus4D),
      .PCD     (PCD)
  );

  decode_stage decode_stage_i (
      .clk         (clk),
      .resetn      (resetn),
      .Stall       (halt),
      .FlushE      (FlushE),
      .InstrD      (InstrD),
      .Rs1D        (Rs1D),
      .Rs2D        (Rs2D),
      .Rd1D        (Rd1D),
      .Rd2D        (Rd2D),
      .PCD         (PCD),
      .RegWriteD   (RegWriteD),
      .ResultSrcD  (ResultSrcD),
      .PCTargetSrcD(PCTargetSrcD),
      .LoadOpD     (LoadOpD),
      .StoreOpD    (StoreOpD),
      .MemWriteD   (MemWriteD),
      .JumpD       (JumpD),
      .BranchD     (BranchD),
      .CsrInstrIncD(CsrInstrIncD),
      .ResultW     (ResultW),
      .ForwardAD   (ForwardAD),
      .ForwardBD   (ForwardBD),
      .AluControlD (AluControlD),
      .AluSrcAD    (AluSrcAD),
      .AluSrcBD    (AluSrcBD),
      .PCPlus4D    (PCPlus4D),
      .ImmExtD     (ImmExtD),
      .CsrOpD      (CsrOpD),
      .Rs1E        (Rs1E),
      .Rs2E        (Rs2E),
      .Immb10D     (Immb10D),
      .RegWriteE   (RegWriteE),
      .ResultSrcE  (ResultSrcE),
      .PCTargetSrcE(PCTargetSrcE),
      .LoadOpE     (LoadOpE),
      .StoreOpE    (StoreOpE),
      .MemWriteE   (MemWriteE),
      .JumpE       (JumpE),
      .BranchE     (BranchE),
      .CsrInstrIncE(CsrInstrIncE),
      .RdE         (RdE),
      .Rd1E        (Rd1E),
      .Rd2E        (Rd2E),
      .AluControlE (AluControlE),
      .AluSrcAE    (AluSrcAE),
      .AluSrcBE    (AluSrcBE),
      .PCPlus4E    (PCPlus4E),
      .ImmExtE     (ImmExtE),
      .PCE         (PCE),
      .CsrOpE      (CsrOpE)
`ifdef SIM,
      .InstrE      (InstrE)
`endif
  );

  execute_stage execute_stage_i (
      .clk                (clk),
      .resetn             (resetn),
      .Stall              (halt),
      .RegWriteE          (RegWriteE),
      .ResultSrcE         (ResultSrcE),
      .LoadOpE            (LoadOpE),
      .StoreOpE           (StoreOpE),
      .Rd1E               (Rd1E),
      .Rd2E               (Rd2E),
      .RdE                (RdE),
      .PCPlus4E           (PCPlus4E),
      .PCE                (PCE),
      .ImmExtE            (ImmExtE),
      .ResultW            (ResultW),
      .AluResultE         (AluResultE),
      .MemWriteE          (MemWriteE),
      .PCTargetSrcE       (PCTargetSrcE),
      .AluSrcAE           (AluSrcAE),
      .AluSrcBE           (AluSrcBE),
      .ForwardAE          (ForwardAE),
      .ForwardBE          (ForwardBE),
      .CsrDataE           (CsrDataE),
      .AluResultM         (AluResultM),
      .RegWriteM          (RegWriteM),
      .ResultSrcM         (ResultSrcM),
      .MemWriteM          (MemWriteM),
      .LoadOpM            (LoadOpM),
      .StoreOpM           (StoreOpM),
      .Rd2M               (Rd2M),
      .RdM                (RdM),
      .PCPlus4M           (PCPlus4M),
      .PCTargetE          (PCTargetE),
      .SrcAE              (SrcAE),
      .SrcBE              (SrcBE),
      .ResultSrcE_        (ResultSrcE_),
`ifndef SIM
      .WriteDataUnAlignedM(WriteDataUnAlignedM)
`else
      .WriteDataUnAlignedM(WriteDataUnAlignedM),
      .InstrE             (InstrE),
      .InstrM             (InstrM)
`endif
  );

  memory_stage memory_stage_i (
      .clk                (clk),
      .resetn             (resetn),
      .Stall              (halt),
      .RegWriteM          (RegWriteM),
      .ResultSrcM         (ResultSrcM),
      .LoadOpM            (LoadOpM),
      .StoreOpM           (StoreOpM),
      .RdM                (RdM),
      .AluResultM         (AluResultM),
      .WriteDataUnAlignedM(WriteDataUnAlignedM),
      .PCPlus4M           (PCPlus4M),
      .ReadDataM          (ReadDataM),
      .WriteDataM         (WriteDataM),
      .RegWriteW          (RegWriteW),
      .ResultSrcW         (ResultSrcW),
      .LoadOpW            (LoadOpW),
      .RdW                (RdW),
      .AluResultW         (AluResultW),
      .wmask              (wmask),
      .PCPlus4W           (PCPlus4W),
`ifndef SIM
      .ReadDataW          (ReadDataW)
`else
      .ReadDataW          (ReadDataW),
      .InstrM             (InstrM),
      .InstrW             (InstrW)
`endif
  );

  writeback_stage writeback_stage_i (
      .AluResultW      (AluResultW),
      .LoadOpW         (LoadOpW),
      .ReadDataW       (ReadDataW),
      .ReadDataAlignedW(ReadDataAlignedW)
  );

  extend extend_i (
      .Instr (InstrD[31:7]),
      .ImmSrc(ImmSrcD),
      .ImmExt(ImmExtD)
  );

  alu32 alu32_i (
      .a         (SrcAE),
      .b         (SrcBE),
      .AluControl(AluControlE),
      .result    (AluResultE),
      .zero      (ZeroE)
  );

  csr_unit csr_unit_i (
      .clk   (clk),
      .resetn(resetn),
      .IncInstructionCycle(CsrInstrIncE&!halt),
      .ImmExt(ImmExtE[11:0]),
      .CsrOp (CsrOpE),
      .rdata (CsrDataE)
  );

  //
  assign taken_branch = (!ZeroE & BranchE);
  assign PCSrcE = PCSrc_t'(((taken_branch) || JumpE) ? PCSRC_PCTARGET : PCSRC_PCPLUS4);

  mux2 #(32) pcf__mux_i (
      .d0(PCPlus4F),
      .d1(PCTargetE),
      .s (PCSrcE),
      .y (PCF_)
  );

  dflop #(32, RESET_ADDR) PCF_i (
      .resetn(resetn),
      .clk(clk),
      .en(!StallF),
      .d(PCF_),
      .q(PCF)
  );

  mux3 #(32) result_mux_i (
      .d0(AluResultW),
      .d1(ReadDataAlignedW),
      .d2(PCPlus4W),
      .s (ResultSrcW),
      .y (ResultW)
  );

  register_file32 #(
      .REGISTER_DEPTH     (32),
      .CLEAR_REGISTER_FILE(1'b0)
  ) register_file32_i (
      .clk(clk),
      .we (RegWriteW),
      .A1 (Rs1D),
      .A2 (Rs2D),
      .A3 (RdW),
      .wd (ResultW),
      .Rd1(Rd1D),
      .Rd2(Rd2D)
  );

  logic isReadMemE;
  assign isReadMemE = ResultSrcE_[0];  // csr is stripped away in exec stage

  // hazard unit
  hazard_unit hazard_unit_i (
      .clk(clk),
      .resetn(resetn),
      .halt(halt),
      .Rs1D(Rs1D),
      .Rs2D(Rs2D),
      .Rs1E(Rs1E),
      .Rs2E(Rs2E),
      .RdE(RdE),
      .RdM(RdM),
      .RdW(RdW),
      .RegWriteM(RegWriteM),
      .RegWriteW(RegWriteW),
      .ReadMemE(isReadMemE),
      .PCSrcE(PCSrcE),
      .ForwardAE(ForwardAE),
      .ForwardBE(ForwardBE),
      .ForwardAD(ForwardAD),
      .ForwardBD(ForwardBD),
      .StallF(StallF),
      .StallD(StallD),
      .FlushD(FlushD),
      .FlushE(FlushE)
  );

  // output world
  assign WriteMaskM = wmask & {4{MemWriteM & !halt}};
  assign ReadMemM   = ResultSrcM[0];

endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type

