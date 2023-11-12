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
`ifndef MCAUSE_VH
`define MCAUSE_VH
// Exception codes
`define EXC_INSTR_ADDR_MISALIGNED 32'h00000000
`define EXC_INSTR_ACCESS_FAULT 32'h00000001
`define EXC_ILLEGAL_INSTRUCTION 32'h00000002
`define EXC_BREAKPOINT 32'h00000003
`define EXC_LOAD_AMO_ADDR_MISALIGNED 32'h00000004
`define EXC_LOAD_AMO_ACCESS_FAULT 32'h00000005
`define EXC_STORE_AMO_ADDR_MISALIGNED 32'h00000006
`define EXC_STORE_AMO_ACCESS_FAULT 32'h00000007
`define EXC_ECALL_FROM_UMODE 32'h00000008
`define EXC_ECALL_FROM_SMODE 32'h00000009
`define EXC_ECALL_FROM_MMODE 32'h0000000B
`define EXC_INSTR_PAGE_FAULT 32'h0000000C
`define EXC_LOAD_PAGE_FAULT 32'h0000000D
`define EXC_STORE_AMO_PAGE_FAULT 32'h0000000F

// Interrupt codes
`define INTERRUPT_USER_SOFTWARE 32'h80000000
`define INTERRUPT_SUPERVISOR_SOFTWARE 32'h80000001
`define INTERRUPT_MACHINE_SOFTWARE 32'h80000003
`define INTERRUPT_USER_TIMER 32'h80000004
`define INTERRUPT_SUPERVISOR_TIMER 32'h80000005
`define INTERRUPT_MACHINE_TIMER 32'h80000007
`define INTERRUPT_USER_EXTERNAL 32'h80000008
`define INTERRUPT_SUPERVISOR_EXTERNAL 32'h80000009
`define INTERRUPT_MACHINE_EXTERNAL 32'h8000000B
`endif
