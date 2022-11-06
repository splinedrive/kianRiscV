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
module kianv_harris_pipelined_edition #(
    parameter RESET_ADDR = 0
) (
    input wire logic clk,
    input wire logic resetn,
    input wire logic halt,
    output wire logic [31:0] PCF,
    input wire logic [31:0] Instr,
    output wire logic [3:0] WriteMaskM,
    output wire logic ReadMemM,
    output wire logic [31:0] AluResultM,
    output wire logic [31:0] WriteDataM,
    input wire logic [31:0] ReadDataM
);

  logic [6:0] opD;
  logic [2:0] funct3D;
  logic [0:0] funct7b5D;
  logic [0:0] funct7b1D;
  logic [0:0] immb10D;

  ResultSrc_t ResultSrcD;
  AluControl_t AluControlD;
  AluSrcA_t AluSrcAD;
  AluSrcB_t AluSrcBD;
  ImmSrc_t ImmSrcD;
  PCTargetSrc_t PCTargetSrcD;
  StoreOp_t StoreOpD;
  LoadOp_t LoadOpD;
  CsrOp_t CsrOpD;

  logic RegWriteD;
  logic PCWrite;
  logic MemWriteD;
  logic JumpD;
  logic BranchD;

  logic CsrInstrIncD;

  logic [31:0] InstrD;
  assign opD       = InstrD[6:0];
  assign funct3D   = InstrD[14:12];
  assign funct7b5D = InstrD[30];  // r-type
  assign funct7b1D = InstrD[25];  // r-type

`ifdef SIM
  initial begin
    $display("=========================");
    $display("Module:\t%m");
    $display("=========================");
  end
`endif

  control_unit control_unit_i (
      .opD         (opD),
      .funct3D     (funct3D),
      .funct7b5D   (funct7b5D),
      .funct7b1D   (funct7b1D),
      .immb10D     (immb10D),
      .PCTargetSrcD(PCTargetSrcD),
      .ResultSrcD  (ResultSrcD),
      .MemWriteD   (MemWriteD),
      .JumpD       (JumpD),
      .BranchD     (BranchD),
      .AluControlD (AluControlD),
      .AluSrcAD    (AluSrcAD),
      .AluSrcBD    (AluSrcBD),
      .ImmSrcD     (ImmSrcD),
      .RegWriteD   (RegWriteD),
      .StoreOpD    (StoreOpD),
      .LoadOpD     (LoadOpD),
      .CsrOpD      (CsrOpD),
      .CsrInstrIncD(CsrInstrIncD)
  );

  datapath_unit #(
      .RESET_ADDR(RESET_ADDR)
  ) datapath_unit_i (
      .clk         (clk),
      .resetn      (resetn),
      .halt        (halt),
      .Instr       (Instr),
      .InstrD      (InstrD),
      .PCTargetSrcD(PCTargetSrcD),
      .ResultSrcD  (ResultSrcD),
      .AluControlD (AluControlD),
      .AluSrcAD    (AluSrcAD),
      .AluSrcBD    (AluSrcBD),
      .ImmSrcD     (ImmSrcD),
      .RegWriteD   (RegWriteD),
      .StoreOpD    (StoreOpD),
      .LoadOpD     (LoadOpD),
      .CsrOpD      (CsrOpD),
      .Immb10D     (immb10D),
      .CsrInstrIncD(CsrInstrIncD),
      .MemWriteD   (MemWriteD),
      .JumpD       (JumpD),
      .BranchD     (BranchD),
      .AluResultM  (AluResultM),
      .WriteDataM  (WriteDataM),
      .ReadDataM   (ReadDataM),
      .WriteMaskM  (WriteMaskM),
      .ReadMemM    (ReadMemM),
      .PCF         (PCF)
  );

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
