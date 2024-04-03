/*
 *  kianv harris multicycle RISC-V rv32im
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
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
`default_nettype none
`include "riscv_defines.vh"
module csr_decoder (
    input wire [2:0] funct3,
    input wire [4:0] Rs1Uimm,
    input wire [4:0] Rd,
    input wire valid,
    output wire CSRwe,
    output wire CSRre,
    output reg [`CSR_OP_WIDTH -1:0] CSRop
);

  wire is_csrrw = funct3 == 3'b001;
  wire is_csrrs = funct3 == 3'b010;
  wire is_csrrc = funct3 == 3'b011;

  wire is_csrrwi = funct3 == 3'b101;
  wire is_csrrsi = funct3 == 3'b110;
  wire is_csrrci = funct3 == 3'b111;

  reg  we;
  reg  re;

  assign CSRwe = we && valid;
  assign CSRre = re && valid;

  always @(*) begin
    we = 1'b0;
    re = 1'b0;
    case (1'b1)
      // Instruction rd rs1 read CSR? write CSR?
      // CSRRW       x0  -       no      yes
      // CSRRW      !x0  -       yes     yes
      is_csrrw: begin
        we = 1'b1;
        //      re = |Rs1Uimm; // rd todo
        re = |Rd;
        CSRop = `CSR_OP_CSRRW;
      end
      // Instruction rd rs1 read CSR? write CSR?
      // CSRRS/C      -  x0      yes     no
      // CSRRS/C      - !x0      yes     yes
      is_csrrs: begin
        we = |Rs1Uimm;
        re = 1'b1;
        CSRop = `CSR_OP_CSRRS;
      end
      // Instruction rd rs1 read CSR? write CSR?
      // CSRRS/C      -  x0      yes     no
      // CSRRS/C      - !x0      yes     yes
      is_csrrc: begin
        we = |Rs1Uimm;
        re = 1'b1;
        CSRop = `CSR_OP_CSRRC;
      end

      // Instruction rd uimm read CSR? write CSR?
      // CSRRWI      x0   -      no       yes
      // CSRRWI     !x0   -      yes      yes
      is_csrrwi: begin
        we = 1'b1;
        //re = |Rs1Uimm;
        re = |Rd;
        CSRop = `CSR_OP_CSRRWI;
      end
      // Instruction rd uimm read CSR? write CSR?
      // CSRRS/CI     -   0      yes      no
      // CSRRS/CI     -  !0      yes      yes
      is_csrrsi: begin
        we = |Rs1Uimm;
        re = 1'b1;
        CSRop = `CSR_OP_CSRRSI;
      end
      // Instruction rd uimm read CSR? write CSR?
      // CSRRS/CI     -   0      yes      no
      // CSRRS/CI     -  !0      yes      yes
      is_csrrci: begin
        we = |Rs1Uimm;
        re = 1'b1;
        CSRop = `CSR_OP_CSRRCI;
      end

      default: begin
        we = 1'b0;
        re = 1'b0;
        CSRop = `CSR_OP_NA;
      end
    endcase
  end

endmodule
//  imm[11:0] rs1 funct3 rd opcode analog to I-type
//  RV32/RV64 Zicsr Standard Extension
//  csr rs1 001 rd 1110011 CSRRW
//  csr rs1 010 rd 1110011 CSRRS
//  csr rs1 011 rd 1110011 CSRRC
//  csr uimm 101 rd 1110011 CSRRWI
//  csr uimm 110 rd 1110011 CSRRSI
//  csr uimm 111 rd 1110011 CSRRCI

//  31 20 19 15 14 12 11 7 6 0
//  csr rs1 funct3 rd opcode
//      12         5     3    5     7
//  source/dest source CSRRW dest SYSTEM
//  source/dest source CSRRS dest SYSTEM
//  source/dest source CSRRC dest SYSTEM
//  source/dest uimm[4:0] CSRRWI dest SYSTEM
//  source/dest uimm[4:0] CSRRSI dest SYSTEM
//  source/dest uimm[4:0] CSRRCI dest SYSTEM

//   Register operand
// Instruction rd rs1 read CSR? write CSR?
// CSRRW       x0  -       no      yes
// CSRRW      !x0  -       yes     yes
// CSRRS/C      -  x0      yes     no
// CSRRS/C      - !x0      yes     yes
// Immediate operand
// Instruction rd uimm read CSR? write CSR?
// CSRRWI      x0   -      no       yes
// CSRRWI     !x0   -      yes      yes
// CSRRS/CI     -   0      yes      no
// CSRRS/CI     -  !0      yes      yes

