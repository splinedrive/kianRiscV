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
`include "riscv_defines.svh"
`default_nettype none `timescale 1 ns / 100 ps
// verilog_lint: waive-start explicit-parameter-storage-type
module control_unit (
    input wire logic [6:0] op,
    input wire logic [2:0] funct3,
    input wire logic [0:0] funct7b5,
    input wire logic [0:0] funct7b1,
    input wire logic [0:0] immb10,
    input wire logic       Zero,

    output wire PCTargetSrc_t PCTargetSrc,
    output wire PCSrc_t PCSrc,
    output wire ResultSrc_t ResultSrc,
    output wire logic MemWrite,
    output wire AluControl_t AluControl,
    output wire AluSrcA_t AluSrcA,
    output wire AluSrcB_t AluSrcB,
    output wire ImmSrc_t ImmSrc,
    output wire logic RegWrite,

    output wire logic PCUpdate,

    output wire StoreOp_t StoreOp,
    output wire LoadOp_t LoadOp,
    output wire CsrOp_t CsrOp,
    output wire logic ICycleInc
);
  /* verilator lint_off WIDTH */
  logic Branch;
  logic Jump;

  // Branch
  logic taken_branch;
  assign taken_branch = (!Zero & Branch);
  // PCNext
  assign PCSrc = PCSrc_t'(((taken_branch) || Jump) ? PCSRC_PCTARGET : PCSRC_PCPLUS4);
  assign PCUpdate = 1'b1;

  main_decoder main_decoder_I (
      .op         (op),
      .funct7b1   (funct7b1),
      .AluSrcA    (AluSrcA),
      .AluSrcB    (AluSrcB),
      .AluOp      (AluOp),
      .ResultSrc  (ResultSrc),
      .ImmSrc     (ImmSrc),
      .PCTargetSrc(PCTargetSrc),
      .Branch     (Branch),
      .Jump       (Jump),
      .RegWrite   (RegWrite),
      .MemWrite   (MemWrite),
      .ICycleInc  (ICycleInc)
  );

  wire AluOp_t AluOp;
  alu_decoder alu_decoder_i (
      .imm_bit10  (immb10),
      .op_bit5    (op[5]),
      .funct3     (funct3),
      .funct7_bit5(funct7b5),
      .AluOp      (AluOp),
      .AluControl (AluControl)
  );

  load_decoder load_decoder_I (
      .funct3(funct3),
      .LoadOp(LoadOp)
  );

  store_decoder store_decoder_I (
      .funct3 (funct3),
      .StoreOp(StoreOp)
  );

  csr_decoder csr_decoder_I (
      funct3,
      CsrOp
  );

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type

