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
`include "riscv_defines.svh"
`default_nettype none `timescale 1 ns / 100 ps
// verilog_lint: waive-start explicit-parameter-storage-type
module control_unit (
    input wire logic [6:0] opD,
    input wire logic [2:0] funct3D,
    input wire logic [0:0] funct7b5D,
    input wire logic [0:0] funct7b1D,
    input wire logic [0:0] immb10D,

    output wire PCTargetSrc_t PCTargetSrcD,
    output wire ResultSrc_t ResultSrcD,
    output wire logic MemWriteD,
    output wire logic JumpD,
    output wire logic BranchD,
    output wire AluControl_t AluControlD,
    output wire AluSrcA_t AluSrcAD,
    output wire AluSrcB_t AluSrcBD,
    output wire ImmSrc_t ImmSrcD,
    output wire logic RegWriteD,

    output wire StoreOp_t StoreOpD,
    output wire LoadOp_t LoadOpD,
    output wire CsrOp_t CsrOpD,
    output wire logic CsrInstrIncD
);
  /* verilator lint_off WIDTH */

  main_decoder main_decoder_i (
      .opD         (opD),
      .funct7b1D   (funct7b1D),
      .AluSrcAD    (AluSrcAD),
      .AluSrcBD    (AluSrcBD),
      .AluOp       (AluOp),
      .ResultSrcD  (ResultSrcD),
      .ImmSrcD     (ImmSrcD),
      .PCTargetSrcD(PCTargetSrcD),
      .JumpD       (JumpD),
      .BranchD     (BranchD),
      .RegWriteD   (RegWriteD),
      .MemWriteD   (MemWriteD),
      .CsrInstrIncD(CsrInstrIncD)
  );

  wire AluOp_t AluOp;
  alu_decoder alu_decoder_i (
      .imm_bit10  (immb10D),
      .op_bit5    (opD[5]),
      .funct3D    (funct3D),
      .funct7bit5D(funct7b5D),
      .AluOp      (AluOp),
      .AluControlD(AluControlD)
  );

  load_decoder load_decoder_i (
      .funct3D(funct3D),
      .LoadOpD(LoadOpD)
  );

  store_decoder store_decoder_i (
      .funct3D (funct3D),
      .StoreOpD(StoreOpD)
  );

  csr_decoder csr_decoder_i (
      funct3D,
      CsrOpD
  );

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

