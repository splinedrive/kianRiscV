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
module main_decoder (
    input wire logic [6:0] opD,
    input wire logic [0:0] funct7b1D,
    output AluSrcA_t AluSrcAD,
    output AluSrcB_t AluSrcBD,
    output AluOp_t AluOp,
    output ResultSrc_t ResultSrcD,
    output ImmSrc_t ImmSrcD,
    output PCTargetSrc_t PCTargetSrcD,
    output logic JumpD,
    output logic BranchD,
    output logic RegWriteD,
    output logic MemWriteD,
    output logic CsrInstrIncD
);
  /* verilator lint_off WIDTH */
  localparam load = 'b000_0011;
  localparam store = 'b010_0011;
  localparam rtype = 'b011_0011;
  localparam itype = 'b001_0011;
  localparam jal = 'b110_1111;  // j-type
  localparam jalr = 'b110_0111;  // implicit i-type
  localparam branch = 'b110_0011;
  localparam lui = 'b011_0111;  // u-type
  localparam aupic = 'b001_0111;  // u-type
  localparam system = 'b111_0011;  // privileged/CSR/implicit i-type

  logic is_load;
  logic is_store;
  logic is_rtype;
  logic is_itype;
  logic is_jal;
  logic is_jalr;
  logic is_branch;
  logic is_lui;
  logic is_aupic;
  logic is_system;

  assign is_load = opD == load;
  assign is_store = opD == store;
  assign is_rtype = opD == rtype;
  assign is_itype = opD == itype;
  assign is_jal = opD == jal;
  assign is_jalr = opD == jalr;
  assign is_branch = opD == branch;
  assign is_lui = opD == lui;
  assign is_aupic = opD == aupic;
  assign is_system = opD == system;

  always_comb begin : ImmSrcComb
    case (1'b1)
      is_rtype:                                 ImmSrcD = IMMSRC_R_TYPE;
      is_itype | is_jalr | is_load | is_system: ImmSrcD = IMMSRC_I_TYPE;
      is_store:                                 ImmSrcD = IMMSRC_S_TYPE;
      is_branch:                                ImmSrcD = IMMSRC_B_TYPE;
      is_lui | is_aupic:                        ImmSrcD = IMMSRC_U_TYPE;
      is_jal:                                   ImmSrcD = IMMSRC_J_TYPE;
      default:                                  ImmSrcD = IMMSRC_R_TYPE;
    endcase
  end

  always_comb begin : AluOpComb
    AluOp = ALU_OP_ADD;
    case (1'b1)
      (is_load | is_store):    AluOp = ALU_OP_ADD;
      (is_rtype & !funct7b1D): AluOp = ALU_OP_ARITH_LOGIC;
      //(is_rtype &  funct7b1D  ) reg opD reg in mul/div
      (is_itype):              AluOp = ALU_OP_ARITH_LOGIC;
      (is_jal):                AluOp = ALU_OP_ADD;
      (is_jalr):               AluOp = ALU_OP_ADD;
      (is_branch):             AluOp = ALU_OP_BRANCH;
      (is_lui):                AluOp = ALU_OP_LUI;
      (is_aupic):              AluOp = ALU_OP_AUIPC;  // pc + imm<<12
      default:                 AluOp = ALU_OP_ADD;
    endcase
  end

  always_comb begin : CtrlSignalComb
    BranchD = 1'b0;
    JumpD = 1'b0;
    AluSrcAD = ALU_SRCA_RD1;
    AluSrcBD = ALU_SRCB_RD2;
    ResultSrcD = RESULT_SRC_ALURESULT;
    RegWriteD = 1'b0;
    MemWriteD = 1'b0;
    PCTargetSrcD = PCSRC_TARGET_SRCA_SRC;  // PCF = rs1 + imm
    CsrInstrIncD = 1'b1;

    case (1'b1)
      is_load: begin
        AluSrcAD   = ALU_SRCA_RD1;
        AluSrcBD   = ALU_SRCB_IMM_EXT;
        ResultSrcD = RESULT_SRC_READDATA;
        RegWriteD  = 1'b1;
      end
      is_store: begin
        AluSrcBD  = ALU_SRCB_IMM_EXT;
        MemWriteD = 1'b1;
      end
      is_rtype: begin
        RegWriteD = 1'b1;
      end
      is_itype: begin
        AluSrcBD  = ALU_SRCB_IMM_EXT;
        RegWriteD = 1'b1;
      end
      is_jal: begin
        JumpD = 1'b1;
        AluSrcBD = ALU_SRCB_IMM_EXT;
        ResultSrcD = RESULT_SRC_PCPLUS4;  // rd = PCF + 4
        PCTargetSrcD = PCSRC_TARGET_PC_SRC;  // PCF += imm
        RegWriteD = 1'b1;
      end
      is_jalr: begin
        JumpD = 1'b1;
        AluSrcBD = ALU_SRCB_IMM_EXT;
        ResultSrcD = RESULT_SRC_PCPLUS4;  // rd = PCF + 4
        PCTargetSrcD = PCSRC_TARGET_SRCA_SRC;  // PCF = rs1 + imm
        RegWriteD = 1'b1;
      end
      is_branch: begin
        PCTargetSrcD = PCSRC_TARGET_PC_SRC;  // PCF += imm
        BranchD = 1'b1;
      end
      is_lui: begin
        AluSrcBD   = ALU_SRCB_IMM_EXT;
        ResultSrcD = RESULT_SRC_ALURESULT;  // rd = imm << 12
        RegWriteD  = 1'b1;
      end
      is_aupic: begin
        AluSrcAD   = ALU_SRCA_PC;
        AluSrcBD   = ALU_SRCB_IMM_EXT;
        ResultSrcD = RESULT_SRC_ALURESULT;  // rd = PCF + (imm << 12)
        RegWriteD  = 1'b1;
      end
      is_system: begin
        ResultSrcD = RESULT_SRC_CSRDATA;
        RegWriteD  = 1'b1;
      end
      default: CsrInstrIncD = 1'b0;
    endcase
  end

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
