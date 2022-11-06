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
`ifndef KIANV_RISCV_HARRIS
`define KIANV_RISCV_HARRIS

`define NOP_INSTR 32'h00000013

// Alu
typedef enum logic [0:0] {
  ALU_SRCA_RD1,
  ALU_SRCA_PC
} AluSrcA_t;

typedef enum logic [0:0] {
  ALU_SRCB_RD2,
  ALU_SRCB_IMM_EXT
} AluSrcB_t;

// writeback register file
typedef enum logic [1:0] {
  RESULT_SRC_ALURESULT,  // rd = Rd1 opD Rd2
  RESULT_SRC_READDATA,  // rd = mem[Rd1 + imm]
  RESULT_SRC_PCPLUS4,  // rd = PCF + 4
  RESULT_SRC_CSRDATA  // rd = CSRC[idx]
} ResultSrc_t;

typedef enum logic [0:0] {
  PCSRC_TARGET_SRCA_SRC,  // PCF += (imm << 12); PCF = Rs1 + imm
  PCSRC_TARGET_PC_SRC  // PCF += imm
} PCTargetSrc_t;

// PCNextF
typedef enum logic [0:0] {
  PCSRC_PCPLUS4,
  PCSRC_PCTARGET
} PCSrc_t;

typedef enum logic [2:0] {
  IMMSRC_R_TYPE = 3'bXXX,
  IMMSRC_I_TYPE = 3'b000,
  IMMSRC_S_TYPE = 3'b001,
  IMMSRC_B_TYPE = 3'b010,
  IMMSRC_U_TYPE = 3'b100,
  IMMSRC_J_TYPE = 3'b011
} ImmSrc_t;

typedef enum logic [2:0] {
  ALU_OP_ADD,
  ALU_OP_SUB,
  ALU_OP_ARITH_LOGIC,
  ALU_OP_LUI,
  ALU_OP_AUIPC,
  ALU_OP_BRANCH
} AluOp_t;

// multiplier operation
typedef enum logic [1:0] {
  MULOP_MUL,
  MULOP_MULH,
  MULOP_MULSU,
  MULOP_MULU
} MulOp_t;

// divider operation
typedef enum {
  DIVOP_DIV,
  DIVOP_DIVU,
  DIVOP_REM,
  DIVOP_REMU
} DivOp_t;

// csr operation
typedef enum logic [0:0] {
  CSR_OP_CSRRS,
  CSR_OP_NA
} CsrOp_t;

// csr register
typedef enum logic [11:0] {
  CSR_REG_CYCLE = 'hC00,
  CSR_REG_CYCLEH = 'hC80,
  CSR_REG_INSTRET = 'hC02,
  CSR_REG_INSTRETH = 'hC82,
  CSR_REG_TIME = 'hC01,
  CSR_REG_TIMEH = 'hC81
} CsrRegs_t;

// store operation
typedef enum logic [1:0] {
  STORE_OP_SB,
  STORE_OP_SH,
  STORE_OP_SW
} StoreOp_t;

// load operation
typedef enum logic [2:0] {
  LOAD_OP_LB,
  LOAD_OP_LBU,
  LOAD_OP_LH,
  LOAD_OP_LHU,
  LOAD_OP_LW
} LoadOp_t;

typedef enum logic [4:0] {
  // ADD bit0 should be 0 for alu add/sub
  ALU_CTRL_ADD_ADDI,
  ALU_CTRL_SUB,
  ALU_CTRL_XOR_XORI,
  ALU_CTRL_OR_ORI,
  ALU_CTRL_AND_ANDI,
  ALU_CTRL_SLL_SLLI,
  ALU_CTRL_SRL_SRLI,
  ALU_CTRL_SRA_SRAI,
  ALU_CTRL_SLT_SLTI,
  ALU_CTRL_AUIPC,
  ALU_CTRL_LUI,
  ALU_CTRL_SLTU_SLTIU,
  ALU_CTRL_BEQ,
  ALU_CTRL_BNE,
  ALU_CTRL_BLT,
  ALU_CTRL_BGE,
  ALU_CTRL_BLTU,
  ALU_CTRL_BGEU
} AluControl_t;

// ForwardAE mux
typedef enum logic [1:0] {
  FORWARD_SRCAE_RD1E,
  FORWARD_SRCAE_RESULTW,
  FORWARD_SRCAE_ALURESULTM
} ForwardAE_t;

// ForwardBE mux
typedef enum logic [1:0] {
  FORWARD_SRCBE_RD2E,
  FORWARD_SRCBE_RESULTW,
  FORWARD_SRCBE_ALURESULTM
} ForwardBE_t;

// ForwardAD mux
typedef enum logic [0:0] {
  FORWARD_SRCAD_RD1D,
  FORWARD_SRCAD_RESULTW
} ForwardAD_t;

// ForwardBD mux
typedef enum logic [0:0] {
  FORWARD_SRCBD_RD2D,
  FORWARD_SRCBD_RESULTW
} ForwardBD_t;

`endif  // KIANV_RISCV_HARRIS
