/*
 *  kianv single cycle RISC-V
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

    input wire logic [31:0] Instr,

    // ctrl signals
    input wire PCTargetSrc_t PCTargetSrc,
    input wire PCSrc_t       PCSrc,
    input wire ResultSrc_t   ResultSrc,
    input wire AluControl_t  AluControl,
    input wire AluSrcA_t     AluSrcA,
    input wire AluSrcB_t     AluSrcB,
    input wire ImmSrc_t      ImmSrc,
    input wire logic         RegWrite,
    input wire StoreOp_t     StoreOp,
    input wire LoadOp_t      LoadOp,
    input wire CsrOp_t       CsrOp,

    output wire logic Immb10,
    input  wire logic ICycleInc,
    input  wire logic PCUpdate,

    // dmem
    input wire logic MemWrite,
    output wire logic [31:0] AluResult,
    output wire logic [31:0] WriteData,
    input wire logic [31:0] ReadData,
    output wire logic [3:0] WriteMask,
    // branch logic
    output wire logic Zero,
    output logic [31:0] PC
);

  logic [31:0] PCNext;
  dff #(32, RESET_ADDR) PC_I (
      resetn,
      clk,
      PCUpdate,
      PCNext,
      PC
  );

  logic [4:0] Rs1;
  logic [4:0] Rs2;
  logic [4:0] Rd;

  assign Rs1 = Instr[19:15];
  assign Rs2 = Instr[24:20];
  assign Rd  = Instr[11:7];

  logic [31:0] wd;
  logic [31:0] rd1;
  logic [31:0] rd2;

  logic [31:0] SrcA;
  logic [31:0] SrcB;

  logic [31:0] Result;
  logic [31:0] ReadDataAligned;

  logic [31:0] CsrData;

  logic [31:0] ImmExt;

  logic [ 3:0] wmask;

  assign Immb10 = ImmExt[10];

  assign WriteMask = wmask & {4{MemWrite}};
  register_file32 #(
      .REGISTER_DEPTH     (32),
      .CLEAR_REGISTER_FILE(1'b0)
  ) register_file32_i (
      .clk(clk),
      .we (RegWrite),
      .A1 (Rs1),
      .A2 (Rs2),
      .A3 (Rd),
      .wd (Result),
      .rd1(rd1),
      .rd2(rd2)
  );

  mux2 #(32) srca_mux (
      .d0(rd1),
      .d1(PC),
      .s (AluSrcA),
      .y (SrcA)
  );

  mux2 #(32) srcb_mux (
      .d0(rd2),
      .d1(ImmExt),
      .s (AluSrcB),
      .y (SrcB)
  );

  alu32 alu32_i (
      .a         (SrcA),
      .b         (SrcB),
      .AluControl(AluControl),
      .result    (AluResult),
      .zero      (Zero)
  );

  extend extend_i (
      .Instr (Instr[31:7]),
      .ImmSrc(ImmSrc),
      .ImmExt(ImmExt)
  );

  logic [31:0] src_rd1_pc;
  mux2 #(32) src_rd1_pc_mux_i (
      .d0(rd1),
      .d1(PC),
      .s (PCTargetSrc),
      .y (src_rd1_pc)
  );

  logic [31:0] PCTarget;
  adder #(
      .WIDTH(32)
  ) pc_target_add_i (
      .a(src_rd1_pc),
      .b(ImmExt),
      .y(PCTarget)
  );

  logic [31:0] PCPlus4;
  adder #(
      .WIDTH(32)
  ) pc_plus4_i (
      .a(PC),
      .b(32'd4),
      .y(PCPlus4)
  );

  mux2 #(32) pc_next_mux_I (
      .d0(PCPlus4),
      .d1(PCTarget),
      .s (PCSrc),
      .y (PCNext)
  );

  mux4 #(32) result_mux (
      .d0(AluResult),
      .d1(ReadDataAligned),
      .d2(PCPlus4),
      .d3(CsrData),
      .s (ResultSrc),
      .y (Result)
  );

  store_alignment store_alignment_I (
      .addr(AluResult[1:0]),
      .StoreOp(StoreOp),
      .data(rd2),
      .result(WriteData),
      .wmask(wmask)
  );

  load_alignment load_alignment_I (
      .addr  (AluResult[1:0]),
      .LoadOp(LoadOp),
      .data  (ReadData),
      .result(ReadDataAligned)
  );

  csr_unit csr_unit_t (
      .clk   (clk),
      .resetn(resetn),
      .ICycleInc(ICycleInc),
      .ImmExt(ImmExt[11:0]),
      .CsrOp (CsrOp),
      .rdata (CsrData)
  );

endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type

