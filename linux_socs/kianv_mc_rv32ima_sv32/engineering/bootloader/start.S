/*
 *  kianv.v - RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
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
.section .text
.global main
.global _entry

_entry:
    li t0, 0                /* Clear temporary register */
    la sp, _stack_top

    /* Copy initialized data from _data_load to _data_start */
    la t0, _data_load       /* Load address of the start of data in flash */
    la t1, _data_start      /* Load address of the start of data in RAM */
    la t2, _edata           /* Load end address of data in RAM */
copy_data:
    beq t1, t2, zero_bss    /* If data copy is done, move to .bss clearing */
    lw t3, 0(t0)
    sw t3, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    j copy_data

zero_bss:
    /* Zero out the .bss section */
    la t1, _bss_start       /* Start of the .bss section */
    la t2, _ebss            /* End of the .bss section */
clear_bss:
    beq t1, t2, init_done   /* If .bss is cleared, move to program start */
    sw zero, 0(t1)
    addi t1, t1, 4
    j clear_bss

init_done:
    call main               /* Call the main function */

halt:
    wfi                     /* Wait for interrupt (infinite loop) */
    j halt

