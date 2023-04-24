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
 */
`define RV32_AMO_OPCODE 7'h2F
`define RV32_AMO_FUNCT3 3'h2
`define RV32_AMOADD_W 5'h00
`define RV32_AMOSWAP_W 5'h01
`define RV32_LR_W 5'h02
`define RV32_SC_W 5'h03
`define RV32_AMOXOR_W 5'h04
`define RV32_AMOAND_W 5'h0C
`define RV32_AMOOR_W 5'h08
`define RV32_AMOMIN_W 5'h10
`define RV32_AMOMAX_W 5'h14
`define RV32_AMOMINU_W 5'h18
`define RV32_AMOMAXU_W 5'h1c
`define RV32_FENCE_OPCODE 7'b0001111

/* verilog_format: off */
`define RV32_IS_AMO_INSTRUCTION(opcode, funct3) (opcode == `RV32_AMO_OPCODE && funct3 == `RV32_AMO_FUNCT3)
`define RV32_IS_AMOADD_W(funct5) (funct5 == `RV32_AMOADD_W)
`define RV32_IS_AMOSWAP_W(funct5) (funct5 == `RV32_AMOSWAP_W)
`define RV32_IS_LR_W(funct5) (funct5 == `RV32_LR_W)
`define RV32_IS_SC_W(funct5) (funct5 == `RV32_SC_W)
`define RV32_IS_AMOXOR_W(funct5) ( funct5 == `RV32_AMOXOR_W)
`define RV32_IS_AMOAND_W(funct5) ( funct5 == `RV32_AMOAND_W)
`define RV32_IS_AMOOR_W(funct5) ( funct5 == `RV32_AMOOR_W)
`define RV32_IS_AMOMIN_W(funct5) ( funct5 == `RV32_AMOMIN_W)
`define RV32_IS_AMOMAX_W(funct5) ( funct5 == `RV32_AMOMAX_W)
`define RV32_IS_AMOMINU_W(funct5) ( funct5 == `RV32_AMOMINU_W)
`define RV32_IS_AMOMAXU_W(funct5) ( funct5 == `RV32_AMOMAXU_W)
`define RV32_IS_FENCE(opcode) ( opcode == `RV32_FENCE_OPCODE)
/* verilog_format: on */
