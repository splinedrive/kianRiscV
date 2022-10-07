/*
 *  kianv harris single cycle RISC-V rv32i
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
module kianv_harris_sc_edition #(
    parameter RESET_ADDR = 0
) (
    input wire logic clk,
    input wire logic resetn,
    output logic [31:0] PC,
    input wire logic [31:0] Instr,
    output logic [3:0] WriteMask,
    output logic [31:0] AluResult,
    output logic [31:0] WriteData,
    input wire logic [31:0] ReadData
);

  logic [6:0] op;
  logic [2:0] funct3;
  logic [0:0] funct7b5;
  logic [0:0] funct7b1;
  logic [0:0] immb10;

  logic Zero;

  ResultSrc_t ResultSrc;
  AluControl_t AluControl;
  AluSrcA_t AluSrcA;
  AluSrcB_t AluSrcB;
  ImmSrc_t ImmSrc;
  PCSrc_t PCSrc;
  PCTargetSrc_t PCTargetSrc;
  StoreOp_t StoreOp;
  LoadOp_t LoadOp;
  CsrOp_t CsrOp;

  logic RegWrite;
  logic PCWrite;
  logic MemWrite;
  logic PCUpdate;

  logic ICycleInc;

  assign op       = Instr[6:0];
  assign funct3   = Instr[14:12];
  assign funct7b5 = Instr[30];  // r-type
  assign funct7b1 = Instr[25];  // r-type

`ifdef SIM
  initial begin
    $display("=========================");
    $display("Module:\t%m");
    $display("=========================");
  end
`endif

  control_unit control_unit_i (
      .op         (op),
      .funct3     (funct3),
      .funct7b5   (funct7b5),
      .funct7b1   (funct7b1),
      .immb10     (immb10),
      .Zero       (Zero),
      .PCTargetSrc(PCTargetSrc),
      .PCSrc      (PCSrc),
      .ResultSrc  (ResultSrc),
      .MemWrite   (MemWrite),
      .AluControl (AluControl),
      .AluSrcA    (AluSrcA),
      .AluSrcB    (AluSrcB),
      .ImmSrc     (ImmSrc),
      .RegWrite   (RegWrite),
      .PCUpdate   (PCUpdate),
      .StoreOp    (StoreOp),
      .LoadOp     (LoadOp),
      .CsrOp      (CsrOp),
      .ICycleInc  (ICycleInc)
  );

  datapath_unit #(
      .RESET_ADDR(RESET_ADDR)
  ) datapath_unit_i (
      .clk        (clk),
      .resetn     (resetn),
      .Instr      (Instr),
      .PCTargetSrc(PCTargetSrc),
      .PCSrc      (PCSrc),
      .ResultSrc  (ResultSrc),
      .AluControl (AluControl),
      .AluSrcA    (AluSrcA),
      .AluSrcB    (AluSrcB),
      .ImmSrc     (ImmSrc),
      .RegWrite   (RegWrite),
      .StoreOp    (StoreOp),
      .LoadOp     (LoadOp),
      .CsrOp      (CsrOp),
      .Immb10     (immb10),
      .ICycleInc  (ICycleInc),
      .MemWrite   (MemWrite),
      .AluResult  (AluResult),
      .WriteData  (WriteData),
      .ReadData   (ReadData),
      .WriteMask  (WriteMask),
      .Zero       (Zero),
      .PC         (PC)
  );

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
