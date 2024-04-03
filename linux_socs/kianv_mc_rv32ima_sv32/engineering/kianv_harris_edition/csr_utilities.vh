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
`define CSR_CYCLE 12'h C00
`define CSR_CYCLEH 12'h C80
`define CSR_INSTRET 12'h C02
`define CSR_INSTRETH 12'h C82
`define CSR_TIME 12'h C01
`define CSR_TIMEH 12'h C81

`define CSR_MTIMECMP 12'h 7c0
`define CSR_MTIMECMPH 12'h 7c1

// Machine Trap Setup
`define CSR_MSTATUS 12'h 300
`define CSR_MISA 12'h 301
`define CSR_MIE 12'h 304
`define CSR_MTVEC 12'h 305

// Machine Trap Handling
`define CSR_MSCRATCH 12'h 340
`define CSR_MEPC 12'h 341
`define CSR_MCAUSE 12'h 342
`define CSR_MTVAL 12'h 343
`define CSR_MIP 12'h 344

// Supervisor Trap Handling
`define CSR_SSTATUS 12'h 100
`define CSR_SSCRATCH 12'h 140
`define CSR_SEPC 12'h 141
`define CSR_SCAUSE 12'h 142
`define CSR_STVAL 12'h 143
`define CSR_STVEC 12'h 105
`define CSR_SIE 12'h 104
`define CSR_SIP 12'h 144
`define CSR_SATP 12'h 180

`define CSR_MEDELEG 12'h 302
`define CSR_MIDELEG 12'h 303

`define CSR_MCOUNTEREN 12'h 306

`define CSR_MVENDORID 12'h f11
`define CSR_MARCHID 12'h f12
`define CSR_MIMPID 12'h f13
`define CSR_MHARTID 12'h f14


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
