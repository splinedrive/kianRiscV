/*
 *  kianv.v - RISC-V rv32ima
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
`ifndef CSR_UTILITIES_VH
`define CSR_UTILITIES_VH

// Unprivileged Counter/Timers
`define CSR_REG_CYCLE 12'h C00
`define CSR_REG_CYCLEH 12'h C80
`define CSR_REG_INSTRET 12'h C02
`define CSR_REG_INSTRETH 12'h C82
`define CSR_REG_TIME 12'h C01
`define CSR_REG_TIMEH 12'h C81

// Machine Trap Setup
`define CSR_REG_MSTATUS 12'h 300
`define CSR_REG_MISA 12'h 301
`define CSR_REG_MIE 12'h 304
`define CSR_REG_MTVEC 12'h 305

// Machine Trap Handling
`define CSR_REG_MSCRATCH 12'h 340
`define CSR_REG_MEPC 12'h 341
`define CSR_REG_MCAUSE 12'h 342
`define CSR_REG_MTVAL 12'h 343
`define CSR_REG_MIP 12'h 344

`define CSR_REG_MCOUNTEREN 12'h 306

`define CSR_REG_MHARTID 12'h f14
`define CSR_REG_MVENDORID 12'h f11
`define CSR_REG_MARCHID 12'h f12

// Machine-Level CSRs
// custrom read-only
`define CSR_PRIVILEGE_MODE 12'h fc0 // machine privilege mode


// RISC-V CSR instruction opcodes (7-bit) and funct3 (3-bit)
`define CSR_OPCODE `SYSTEM_OPCODE
`define CSR_FUNCT3_RW 3'b001
`define CSR_FUNCT3_RS 3'b010
`define CSR_FUNCT3_RC 3'b011
`define CSR_FUNCT3_RWI 3'b101
`define CSR_FUNCT3_RSI 3'b110
`define CSR_FUNCT3_RCI 3'b111

`include "riscv_priv_csr_status.vh"
`include "misa.vh"
`endif
