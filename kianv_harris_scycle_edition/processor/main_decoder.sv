/*
 *  kianv harris single cycle RISC-V rv32im
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
    input wire logic [6:0] op,
    input wire logic [0:0] funct7b1,
    output AluSrcA_t AluSrcA,
    output AluSrcB_t AluSrcB,
    output AluOp_t AluOp,
    output ResultSrc_t ResultSrc,
    output ImmSrc_t ImmSrc,
    output PCTargetSrc_t PCTargetSrc,
    output logic Branch,
    output logic Jump,
    output logic RegWrite,
    output logic MemWrite,
    output logic ICycleInc
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

  assign is_load = op == load;
  assign is_store = op == store;
  assign is_rtype = op == rtype;
  assign is_itype = op == itype;
  assign is_jal = op == jal;
  assign is_jalr = op == jalr;
  assign is_branch = op == branch;
  assign is_lui = op == lui;
  assign is_aupic = op == aupic;
  assign is_system = op == system;

  always_comb begin : ImmSrcComb
    case (1'b1)
      is_rtype:                                 ImmSrc = IMMSRC_R_TYPE;
      is_itype | is_jalr | is_load | is_system: ImmSrc = IMMSRC_I_TYPE;
      is_store:                                 ImmSrc = IMMSRC_S_TYPE;
      is_branch:                                ImmSrc = IMMSRC_B_TYPE;
      is_lui | is_aupic:                        ImmSrc = IMMSRC_U_TYPE;
      is_jal:                                   ImmSrc = IMMSRC_J_TYPE;
      default:                                  ImmSrc = IMMSRC_R_TYPE;
    endcase
  end

  always_comb begin : AluOpComb
    AluOp = ALU_OP_ADD;
    case (1'b1)
      (is_load | is_store):   AluOp = ALU_OP_ADD;
      (is_rtype & !funct7b1): AluOp = ALU_OP_ARITH_LOGIC;
      //(is_rtype &  funct7b1  ) reg op reg in mul/div
      (is_itype):             AluOp = ALU_OP_ARITH_LOGIC;
      (is_jal):               AluOp = ALU_OP_ADD;
      (is_jalr):              AluOp = ALU_OP_ADD;
      (is_branch):            AluOp = ALU_OP_BRANCH;
      (is_lui):               AluOp = ALU_OP_LUI;
      (is_aupic):             AluOp = ALU_OP_AUIPC;  // pc + imm<<12
      default:                AluOp = ALU_OP_ADD;
    endcase
  end

  always_comb begin : CtrlSignalComb
    Branch = 1'b0;
    Jump = 1'b0;
    AluSrcA = ALU_SRCA_RD1;
    AluSrcB = ALU_SRCB_RD2;
    ResultSrc = RESULT_SRC_ALURESULT;
    RegWrite = 1'b0;
    MemWrite = 1'b0;
    PCTargetSrc = PCSRC_TARGET_SRCA_SRC;  // PC += imm
    ICycleInc = 1'b1;

    case (1'b1)
      is_load: begin
        AluSrcA   = ALU_SRCA_RD1;
        AluSrcB   = ALU_SRCB_IMM_EXT;
        ResultSrc = RESULT_SRC_READDATA;
        RegWrite  = 1'b1;
      end
      is_store: begin
        AluSrcB  = ALU_SRCB_IMM_EXT;
        MemWrite = 1'b1;
      end
      is_rtype: begin
        RegWrite = 1'b1;
      end
      is_itype: begin
        AluSrcB  = ALU_SRCB_IMM_EXT;
        RegWrite = 1'b1;
      end
      is_jal: begin
        Jump = 1'b1;
        ResultSrc = RESULT_SRC_PCPLUS4;  // rd = PC + 4
        RegWrite = 1'b1;
        PCTargetSrc = PCSRC_TARGET_PC_SRC;  // PC += imm
      end
      is_jalr: begin
        Jump = 1'b1;
        AluSrcA = ALU_SRCA_RD1;
        ResultSrc = RESULT_SRC_PCPLUS4;  // rd = PC + 4
        RegWrite = 1'b1;
      end
      is_branch: begin
        Branch = 1'b1;
        PCTargetSrc = PCSRC_TARGET_PC_SRC;  // PC += imm
      end
      is_lui: begin
        AluSrcA   = ALU_SRCA_RD1;
        AluSrcB   = ALU_SRCB_IMM_EXT;
        ResultSrc = RESULT_SRC_ALURESULT;  // rd = imm << 12
        RegWrite  = 1'b1;
      end
      is_aupic: begin
        AluSrcA   = ALU_SRCA_PC;
        AluSrcB   = ALU_SRCB_IMM_EXT;
        ResultSrc = RESULT_SRC_ALURESULT;  // rd = PC + (imm << 12)
        RegWrite  = 1'b1;
      end
      is_system: begin
        ResultSrc = RESULT_SRC_CSRDATA;
        RegWrite  = 1'b1;
      end
      default: ICycleInc = 1'b0;
    endcase
  end

  /* verilator lint_on WIDTH */
endmodule
// verilog_lint: waive-stop explicit-parameter-storage-type
