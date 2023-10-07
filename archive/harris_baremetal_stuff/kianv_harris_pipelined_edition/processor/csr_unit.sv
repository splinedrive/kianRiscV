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

`include "riscv_defines.svh"
module csr_unit (
    input  wire logic          clk,
    input  wire logic          resetn,
    input  wire logic          IncInstructionCycle,
    input  wire logic   [11:0] ImmExt,
    input  wire CsrOp_t        CsrOp,
    output logic        [31:0] rdata
);
  // CSR
  // csr rdcycle[H], rdtime[H], rdinstret[H]
  logic [63:0] cycle_counter;
  logic [63:0] instr_counter;

  counter #(64) instr_cnt_i (
      .resetn(resetn),
      .clk(clk),
      .inc(IncInstructionCycle),
      .q(instr_counter)
  );
  counter #(64) cycle_cnt_i (
      .resetn(resetn),
      .clk(clk),
      .inc(1'b1),
      .q(cycle_counter)
  );

  CsrRegs_t csr_register;

  logic     decode_csrs;
  logic     is_rdcycle;
  logic     is_rdcycleh;

  logic     is_instret;
  logic     is_instreth;

  logic     is_time;
  logic     is_timeh;

  assign csr_register = CsrRegs_t'(ImmExt);

  assign decode_csrs = CsrOp == CSR_OP_CSRRS;
  assign is_rdcycle = decode_csrs & (csr_register == CSR_REG_CYCLE);
  assign is_rdcycleh = decode_csrs & (csr_register == CSR_REG_CYCLEH);

  assign is_instret = decode_csrs & (csr_register == CSR_REG_INSTRET);
  assign is_instreth = decode_csrs & (csr_register == CSR_REG_INSTRETH);

  assign is_time = decode_csrs & (csr_register == CSR_REG_TIME);
  assign is_timeh = decode_csrs & (csr_register == CSR_REG_TIMEH);

  always_comb begin
    case (1'b1)
      /* read only registers */
      is_instret:  rdata = instr_counter[31:0];
      is_instreth: rdata = instr_counter[63:32];
      is_rdcycle:  rdata = cycle_counter[31:0];
      is_rdcycleh: rdata = cycle_counter[63:32];
      is_time:     rdata = cycle_counter[31:0];
      is_timeh:    rdata = cycle_counter[63:32];
      default:     rdata = 32'hx;
    endcase


  end

endmodule
