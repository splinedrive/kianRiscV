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

module hazard_unit (
    input  wire logic         clk,
    input  wire logic         resetn,
    input  wire logic         halt,
    input  wire logic   [4:0] Rs1D,
    input  wire logic   [4:0] Rs2D,
    input  wire logic   [4:0] Rs1E,
    input  wire logic   [4:0] Rs2E,
    input  wire logic   [4:0] RdE,
    input  wire logic   [4:0] RdM,
    input  wire logic   [4:0] RdW,
    input  wire logic         RegWriteM,
    input  wire logic         RegWriteW,
    input  wire logic         ReadMemE,   /* ReadData path */
    input  wire PCSrc_t       PCSrcE,
    output ForwardAE_t        ForwardAE,
    output ForwardBE_t        ForwardBE,
    output ForwardAD_t        ForwardAD,
    output ForwardBD_t        ForwardBD,
    output logic              StallF,
    output logic              StallD,
    output logic              FlushD,
    output logic              FlushE
);

  // data hazard
  always_comb begin
    if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 0)) begin
      // Case 1
      ForwardAE = ForwardAE_t'(FORWARD_SRCAE_ALURESULTM);
    end else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 0)) begin
      // Case 2
      ForwardAE = ForwardAE_t'(FORWARD_SRCAE_RESULTW);
    end else begin
      // Case 3
      ForwardAE = ForwardAE_t'(FORWARD_SRCAE_RD1E);
    end
  end

  always_comb begin
    if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 0)) begin
      // Case 1
      ForwardBE = ForwardBE_t'(FORWARD_SRCBE_ALURESULTM);
    end else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 0)) begin
      // Case 2
      ForwardBE = ForwardBE_t'(FORWARD_SRCBE_RESULTW);
    end else begin
      // Case 3
      ForwardBE = ForwardBE_t'(FORWARD_SRCBE_RD2E);
    end
  end

  always_comb begin
    if (((Rs1D == RdW) && RegWriteW) && (Rs1D != 0)) begin
      // Case 2
      ForwardAD = ForwardAD_t'(FORWARD_SRCAD_RESULTW);
    end else begin
      // Case 3
      ForwardAD = ForwardAD_t'(FORWARD_SRCAD_RD1D);
    end
  end

  always_comb begin
    if (((Rs2D == RdW) && RegWriteW) && (Rs2D != 0)) begin
      // Case 2
      ForwardBD = ForwardBD_t'(FORWARD_SRCAD_RESULTW);
    end else begin
      // Case 3
      ForwardBD = ForwardBD_t'(FORWARD_SRCAD_RD1D);
    end
  end

  logic is_pc_target;
  logic lwStall;
  logic is_load_data_dependency;

  // control hazard
  assign is_pc_target = logic'(PCSrcE);
  // load stall hazard
  assign is_load_data_dependency = ((Rs1D == RdE) || (Rs2D == RdE)) && ReadMemE;

  always_comb begin
    // stall hazard
    lwStall = is_load_data_dependency;
    {StallF, StallD, FlushE} = {lwStall, lwStall, lwStall};
    {StallF, StallD, FlushE} |= {halt, halt, halt};

    // control hazard
    FlushD = is_pc_target & !halt;
    FlushE |= is_pc_target;
    FlushE &= !halt;
  end

endmodule
/* verilator lint_on WIDTH */
// verilog_lint: waive-stop explicit-parameter-storage-type

