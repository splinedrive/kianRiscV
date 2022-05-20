/*
 *  kianv harris multicycle RISC-V rv32im
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

`ifndef RV32M
`define RV32M
`endif
//`undef  RV32M
`ifndef CSR
`define CSR
`endif
//`undef  CSR
 
// mux SRCA
`define     SRCA_WIDTH  $clog2(`SRCA_LAST)
`define     SRCA_PC              0
`define     SRCA_OLD_PC          1
`define     SRCA_RD1_BUF         2
`define     SRCA_LAST            3

// mux SRCB
`define     SRCB_WIDTH  $clog2(`SRCB_LAST)
`define     SRCB_RD2_BUF          0
`define     SRCB_IMM_EXT          1
`define     SRCB_CONST_4          2
`define     SRCB_LAST             3

// mux4 in data_unit RESULT
`define     RESULT_WIDTH  $clog2(`RESULT_LAST)
`define     RESULT_ALUOUT         0
`define     RESULT_DATA           1
`define     RESULT_ALURESULT      2
`define     RESULT_MULOUT         3
`define     RESULT_CSROUT         4
`define     RESULT_LAST           5

`define     ADDR_PC               0
`define     ADDR_RESULT           1

`define     IMMSRC_RTYPE          3'b xxx
`define     IMMSRC_ITYPE          3'b 000
`define     IMMSRC_STYPE          3'b 001
`define     IMMSRC_BTYPE          3'b 010
`define     IMMSRC_UTYPE          3'b 100
`define     IMMSRC_JTYPE          3'b 011
//
// alu operation
`define     ALU_OP_WIDTH  $clog2(`ALU_OP_LAST)
`define     ALU_OP_ADD             0
`define     ALU_OP_SUB             1
`define     ALU_OP_ARITH_LOGIC     2
`define     ALU_OP_LUI             3
`define     ALU_OP_AUIPC           4
`define     ALU_OP_BRANCH          5
`define     ALU_OP_LAST            6

// multiplier operation
`define     MUL_OP_WIDTH  $clog2(`MUL_OP_LAST)
`define     MUL_OP_MUL             0
`define     MUL_OP_MULH            1
`define     MUL_OP_MULSU           2
`define     MUL_OP_MULU            3
`define     MUL_OP_LAST            4

// divider operation
`define     DIV_OP_WIDTH  $clog2(`DIV_OP_LAST)
`define     DIV_OP_DIV             0
`define     DIV_OP_DIVU            1
`define     DIV_OP_REM             2
`define     DIV_OP_REMU            3
`define     DIV_OP_LAST            4

// csr operation
`define     CSR_OP_WIDTH  $clog2(`CSR_OP_LAST)
`define     CSR_OP_CSRRS            0
`define     CSR_OP_NA               1
`define     CSR_OP_LAST             2

// csr register
`define     CSR_REG_CYCLE          12'h C00
`define     CSR_REG_CYCLEH         12'h C80
`define     CSR_REG_INSTRET        12'h C02
`define     CSR_REG_INSTRETH       12'h C82
`define     CSR_REG_TIME           12'h C01
`define     CSR_REG_TIMEH          12'h C81

// store operation
`define     STORE_OP_WIDTH  $clog2(`STORE_OP_LAST)
`define     STORE_OP_SB            0
`define     STORE_OP_SH            1
`define     STORE_OP_SW            2
`define     STORE_OP_LAST          3

// load operation
`define     LOAD_OP_WIDTH  $clog2(`LOAD_OP_LAST)
`define     LOAD_OP_LB             0
`define     LOAD_OP_LBU            1
`define     LOAD_OP_LH             2
`define     LOAD_OP_LHU            3
`define     LOAD_OP_LW             4
`define     LOAD_OP_LAST           5

// ALU
`define     ALU_CTRL_WIDTH  $clog2(`ALU_CTRL_LAST)
// ADD bit0 should be 0 for alu add/sub
`define     ALU_CTRL_ADD_ADDI           0
`define     ALU_CTRL_SUB                1

`define     ALU_CTRL_XOR_XORI           2
`define     ALU_CTRL_OR_ORI             3
`define     ALU_CTRL_AND_ANDI           4
`define     ALU_CTRL_SLL_SLLI           5
`define     ALU_CTRL_SRL_SRLI           6
`define     ALU_CTRL_SRA_SRAI           7
`define     ALU_CTRL_SLT_SLTI           8
`define     ALU_CTRL_AUIPC              9
`define     ALU_CTRL_LUI               10
`define     ALU_CTRL_SLTU_SLTIU        11
`define     ALU_CTRL_BEQ               12
`define     ALU_CTRL_BNE               13
`define     ALU_CTRL_BLT               14
`define     ALU_CTRL_BGE               15
`define     ALU_CTRL_BLTU              16
`define     ALU_CTRL_BGEU              17
`define     ALU_CTRL_LAST              18

`endif  // KIANV_RISCV_HARRIS
