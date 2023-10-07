.section .init
.global main

/* begin: custom PicoRV32 opcodes */

#define regnum_q0   0
#define regnum_q1   1
#define regnum_q2   2
#define regnum_q3   3

#define regnum_x0   0
#define regnum_x1   1
#define regnum_x2   2
#define regnum_x3   3
#define regnum_x4   4
#define regnum_x5   5
#define regnum_x6   6
#define regnum_x7   7
#define regnum_x8   8
#define regnum_x9   9
#define regnum_x10 10
#define regnum_x11 11
#define regnum_x12 12
#define regnum_x13 13
#define regnum_x14 14
#define regnum_x15 15
#define regnum_x16 16
#define regnum_x17 17
#define regnum_x18 18
#define regnum_x19 19
#define regnum_x20 20
#define regnum_x21 21
#define regnum_x22 22
#define regnum_x23 23
#define regnum_x24 24
#define regnum_x25 25
#define regnum_x26 26
#define regnum_x27 27
#define regnum_x28 28
#define regnum_x29 29
#define regnum_x30 30
#define regnum_x31 31

#define regnum_zero 0
#define regnum_ra   1
#define regnum_sp   2
#define regnum_gp   3
#define regnum_tp   4
#define regnum_t0   5
#define regnum_t1   6
#define regnum_t2   7
#define regnum_s0   8
#define regnum_s1   9
#define regnum_a0  10
#define regnum_a1  11
#define regnum_a2  12
#define regnum_a3  13
#define regnum_a4  14
#define regnum_a5  15
#define regnum_a6  16
#define regnum_a7  17
#define regnum_s2  18
#define regnum_s3  19
#define regnum_s4  20
#define regnum_s5  21
#define regnum_s6  22
#define regnum_s7  23
#define regnum_s8  24
#define regnum_s9  25
#define regnum_s10 26
#define regnum_s11 27
#define regnum_t3  28
#define regnum_t4  29
#define regnum_t5  30
#define regnum_t6  31

// x8 is s0 and also fp
#define regnum_fp   8

start:
	/* zero-initialize all registers */
/*
	addi x1, zero, 0
	addi x2, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0
  */

	/* set stack pointer */
//	lui sp, %hi(1024<<2)
//	addi sp, sp, %lo(1024<<2)
lui sp, %hi(__stacktop);
addi sp, sp, %lo(__stacktop);

	/* call main */
	call main
loop:
        j loop
.balign 4

