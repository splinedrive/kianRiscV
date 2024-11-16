	.file	"kernelboot.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (GCC) version 11.1.0 (riscv32-unknown-elf)
#	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version none
# warning: GMP header version 6.2.0 differs from library version 6.3.0.
# warning: MPFR header version 4.0.2 differs from library version 4.2.1.
# warning: MPC header version 1.1.0 differs from library version 1.3.1.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=rv32ima -mabi=ilp32 -mtune=rocket -march=rv32ima -Os -fno-pic -fno-stack-protector -ffreestanding
	.text
	.align	2
	.globl	get_cycles
	.type	get_cycles, @function
get_cycles:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:28:   asm volatile("rdcycleh %0" : "=r"(tmph0));
 #APP
# 28 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp78
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp78, tmph0
# kianv_stdlib.h:29:   asm volatile("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 29 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp79
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp79, tmpl0
# kianv_stdlib.h:31:   return ((uint64_t)(tmph0) << 32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_1, tmph0
# kianv_stdlib.h:31:   return ((uint64_t)(tmph0) << 32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_4, tmpl0
# kianv_stdlib.h:32: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	get_cycles, .-get_cycles
	.align	2
	.globl	wait_cycles
	.type	wait_cycles, @function
wait_cycles:
	addi	sp,sp,-16	#,,
	sw	s0,8(sp)	#,
	sw	s1,4(sp)	#,
	sw	s2,0(sp)	#,
	mv	s1,a0	# wait, tmp97
	mv	s2,a1	# wait, tmp98
	sw	ra,12(sp)	#,
# kianv_stdlib.h:37:   uint64_t lim = get_cycles() + wait;
	call	get_cycles		#
# kianv_stdlib.h:37:   uint64_t lim = get_cycles() + wait;
	add	s1,a0,s1	# wait, tmp95, _1
	sltu	s0,s1,a0	# _1, tmp78, tmp95
	add	a1,a1,s2	# wait, tmp96, tmp100
	add	s0,s0,a1	# tmp96, tmp80, tmp78
.L6:
# kianv_stdlib.h:38:   while (get_cycles() < lim)
	call	get_cycles		#
# kianv_stdlib.h:38:   while (get_cycles() < lim)
	bgtu	s0,a1,.L6	#, tmp80, _2,
	bne	s0,a1,.L3	#, tmp80, _2,
	bgtu	s1,a0,.L6	#, tmp95, _2,
.L3:
# kianv_stdlib.h:40: }
	lw	ra,12(sp)		#,
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	lw	s2,0(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib.h:43:   if (us)
	beq	a0,zero,.L8	#, us,,
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:44:     wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a4,999424		# tmp82,
	addi	a4,a4,576	#, tmp81, tmp82
	divu	a5,a5,a4	# tmp81, tmp80, _8
# kianv_stdlib.h:44:     wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a1,0		#,
	mul	a0,a5,a0	#, tmp80, us
	tail	wait_cycles		#
.L8:
# kianv_stdlib.h:45: }
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:48:   if (ms)
	beq	a0,zero,.L10	#, ms,,
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:49:     wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a4,1000		# tmp80,
# kianv_stdlib.h:49:     wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a1,0		#,
# kianv_stdlib.h:49:     wait_cycles(ms * (get_cpu_freq() / 1000));
	divu	a5,a5,a4	# tmp80, tmp81, _8
# kianv_stdlib.h:49:     wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a0,a5,a0	#, tmp81, ms
	tail	wait_cycles		#
.L10:
# kianv_stdlib.h:50: }
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:53:   if (sec)
	beq	a0,zero,.L12	#, sec,,
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp77,
	lw	a5,16(a5)		# _7, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:54:     wait_cycles(sec * get_cpu_freq());
	li	a1,0		#,
	mul	a0,a0,a5	#, sec, _7
	tail	wait_cycles		#
.L12:
# kianv_stdlib.h:55: }
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:58:   return get_cycles() / (uint64_t)(get_cpu_freq() / 1000000);
	call	get_cycles		#
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:58:   return get_cycles() / (uint64_t)(get_cpu_freq() / 1000000);
	li	a5,999424		# tmp83,
	addi	a5,a5,576	#, tmp82, tmp83
	divu	a2,a2,a5	# tmp82,, _7
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:59: }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	nanoseconds, .-nanoseconds
	.align	2
	.globl	milliseconds
	.type	milliseconds, @function
milliseconds:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:62:   return get_cycles() / (uint64_t)(get_cpu_freq() / 1000);
	call	get_cycles		#
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:62:   return get_cycles() / (uint64_t)(get_cpu_freq() / 1000);
	li	a5,1000		# tmp81,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp81,, _7
	call	__udivdi3		#
# kianv_stdlib.h:63: }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	milliseconds, .-milliseconds
	.align	2
	.globl	seconds
	.type	seconds, @function
seconds:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:65: uint64_t seconds() { return get_cycles() / (uint64_t)(get_cpu_freq()); }
	call	get_cycles		#
# kianv_stdlib.h:34: inline uint32_t get_cpu_freq() { return *((volatile uint32_t *)CPU_FREQ); }
	li	a5,268435456		# tmp77,
	lw	a2,16(a5)		# _6, MEM[(volatile uint32_t *)268435472B]
# kianv_stdlib.h:65: uint64_t seconds() { return get_cycles() / (uint64_t)(get_cpu_freq()); }
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:65: uint64_t seconds() { return get_cycles() / (uint64_t)(get_cpu_freq()); }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib.h:68:   while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	li	a4,268435456		# tmp77,
.L21:
# kianv_stdlib.h:68:   while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	lbu	a5,5(a4)	# MEM[(volatile uint8_t *)268435461B], MEM[(volatile uint8_t *)268435461B]
# kianv_stdlib.h:68:   while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	andi	a5,a5,96	#, tmp82, MEM[(volatile uint8_t *)268435461B]
	beq	a5,zero,.L21	#, tmp82,,
# kianv_stdlib.h:70:   *((volatile uint32_t *)UART_TX) = c == 13 ? 10 : c;
	li	a5,13		# tmp83,
	bne	a0,a5,.L22	#, c, tmp83,
	li	a0,10		# c,
.L22:
# kianv_stdlib.h:70:   *((volatile uint32_t *)UART_TX) = c == 13 ? 10 : c;
	li	a5,268435456		# tmp84,
	sw	a0,0(a5)	# c, MEM[(volatile uint32_t *)268435456B]
# kianv_stdlib.h:71: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	tail	putchar		#
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_char
	.type	print_char, @function
print_char:
	tail	putchar		#
	.size	print_char, .-print_char
	.align	2
	.globl	print_str
	.type	print_str, @function
print_str:
	addi	sp,sp,-16	#,,
	sw	s0,8(sp)	#,
	sw	s1,4(sp)	#,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:77: void print_str(char *p) {
	mv	s0,a0	# p, tmp84
# kianv_stdlib.h:79:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	li	s1,268435456		# tmp83,
.L29:
# kianv_stdlib.h:78:   while (*p != 0) {
	lbu	a0,0(s0)	# _3, MEM[(char *)p_4]
# kianv_stdlib.h:78:   while (*p != 0) {
	bne	a0,zero,.L30	#, _3,,
# kianv_stdlib.h:83: }
	lw	ra,12(sp)		#,
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
.L30:
# kianv_stdlib.h:79:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	lbu	a5,5(s1)	# MEM[(volatile uint8_t *)268435461B], MEM[(volatile uint8_t *)268435461B]
# kianv_stdlib.h:79:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	andi	a5,a5,96	#, tmp82, MEM[(volatile uint8_t *)268435461B]
	beq	a5,zero,.L30	#, tmp82,,
# kianv_stdlib.h:81:     putchar(*(p++));
	addi	s0,s0,1	#, p, p
# kianv_stdlib.h:81:     putchar(*(p++));
	call	putchar		#
	j	.L29		#
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:86:   print_str(p);
	call	print_str		#
# kianv_stdlib.h:88: }
	lw	ra,12(sp)		#,
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	li	a0,13		#,
# kianv_stdlib.h:88: }
	addi	sp,sp,16	#,,
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	tail	putchar		#
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:92:   char *p = buffer;
	addi	a5,sp,4	#, p,
	mv	a3,a5	# p, p
# kianv_stdlib.h:94:     *(p++) = val % 10;
	li	a4,10		# tmp100,
.L38:
# kianv_stdlib.h:93:   while (val || p == buffer) {
	bne	a0,zero,.L39	#, val,,
# kianv_stdlib.h:93:   while (val || p == buffer) {
	beq	a5,a3,.L39	#, p, p,
# kianv_stdlib.h:99:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	li	a2,268435456		# tmp90,
.L40:
# kianv_stdlib.h:99:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	lbu	a4,5(a2)	# MEM[(volatile uint8_t *)268435461B], MEM[(volatile uint8_t *)268435461B]
# kianv_stdlib.h:99:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	andi	a4,a4,96	#, tmp95, MEM[(volatile uint8_t *)268435461B]
	beq	a4,zero,.L40	#, tmp95,,
# kianv_stdlib.h:101:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	lbu	a4,-1(a5)	# MEM[(char *)p_17], MEM[(char *)p_17]
# kianv_stdlib.h:101:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	addi	a5,a5,-1	#, p, p
# kianv_stdlib.h:101:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	addi	a4,a4,48	#, _7, MEM[(char *)p_17]
# kianv_stdlib.h:101:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	sw	a4,0(a2)	# _7, MEM[(volatile uint32_t *)268435456B]
# kianv_stdlib.h:98:   while (p != buffer) {
	bne	a5,a3,.L40	#, p, p,
# kianv_stdlib.h:103: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L39:
# kianv_stdlib.h:94:     *(p++) = val % 10;
	remu	a2,a0,a4	# tmp100, tmp84, val
# kianv_stdlib.h:94:     *(p++) = val % 10;
	addi	a5,a5,1	#, p, p
# kianv_stdlib.h:95:     val = val / 10;
	divu	a0,a0,a4	# tmp100, val, val
# kianv_stdlib.h:94:     *(p++) = val % 10;
	sb	a2,-1(a5)	# tmp84, MEM[(char *)p_19 + 4294967295B]
	j	.L38		#
	.size	print_dec, .-print_dec
	.globl	__umoddi3
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-64	#,,
	sw	s2,48(sp)	#,
# kianv_stdlib.h:107:   char *p = buffer;
	addi	s2,sp,12	#, p,
# kianv_stdlib.h:105: void print_dec64(uint64_t val) {
	sw	s0,56(sp)	#,
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	ra,60(sp)	#,
# kianv_stdlib.h:105: void print_dec64(uint64_t val) {
	mv	s0,a0	# val, tmp109
	mv	s1,a1	# val, tmp110
	mv	s3,s2	# p, p
.L47:
# kianv_stdlib.h:108:   while (val || p == buffer) {
	or	a5,s0,s1	# val, val, val
	bne	a5,zero,.L48	#, val,,
# kianv_stdlib.h:108:   while (val || p == buffer) {
	beq	s2,s3,.L48	#, p, p,
# kianv_stdlib.h:114:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	li	a4,268435456		# tmp95,
.L49:
# kianv_stdlib.h:114:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	lbu	a5,5(a4)	# MEM[(volatile uint8_t *)268435461B], MEM[(volatile uint8_t *)268435461B]
# kianv_stdlib.h:114:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	andi	a5,a5,96	#, tmp100, MEM[(volatile uint8_t *)268435461B]
	beq	a5,zero,.L49	#, tmp100,,
# kianv_stdlib.h:116:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	lbu	a5,-1(s2)	# MEM[(char *)p_17], MEM[(char *)p_17]
# kianv_stdlib.h:116:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	addi	s2,s2,-1	#, p, p
# kianv_stdlib.h:116:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_17]
# kianv_stdlib.h:116:     *((volatile uint32_t *)UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)268435456B]
# kianv_stdlib.h:113:   while (p != buffer) {
	bne	s2,s3,.L49	#, p, p,
# kianv_stdlib.h:118: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
.L48:
# kianv_stdlib.h:109:     *(p++) = val % 10;
	li	a2,10		#,
	li	a3,0		#,
	mv	a0,s0	#, val
	mv	a1,s1	#, val
	call	__umoddi3		#
# kianv_stdlib.h:110:     val = val / 10;
	mv	a1,s1	#, val
# kianv_stdlib.h:109:     *(p++) = val % 10;
	sb	a0,0(s2)	# tmp111, MEM[(char *)p_19 + 4294967295B]
# kianv_stdlib.h:110:     val = val / 10;
	li	a2,10		#,
	mv	a0,s0	#, val
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:109:     *(p++) = val % 10;
	addi	s2,s2,1	#, p, p
# kianv_stdlib.h:110:     val = val / 10;
	mv	s0,a0	# val, tmp113
	mv	s1,a1	# val, tmp114
	j	.L47		#
	.size	print_dec64, .-print_dec64
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"0123456789ABCDEF"
	.text
	.align	2
	.globl	print_hex
	.type	print_hex, @function
print_hex:
# kianv_stdlib.h:121:   for (int i = (4 * digits) - 4; i >= 0; i -= 4) {
	addi	a1,a1,-1	#, tmp82, tmp100
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	lui	a4,%hi(.LC0)	# tmp97,
# kianv_stdlib.h:121:   for (int i = (4 * digits) - 4; i >= 0; i -= 4) {
	slli	a1,a1,2	#, i, tmp82
# kianv_stdlib.h:122:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	li	a3,268435456		# tmp96,
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	addi	a4,a4,%lo(.LC0)	# tmp98, tmp97,
.L56:
# kianv_stdlib.h:121:   for (int i = (4 * digits) - 4; i >= 0; i -= 4) {
	bge	a1,zero,.L57	#, i,,
# kianv_stdlib.h:126: }
	ret	
.L57:
# kianv_stdlib.h:122:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	lbu	a5,5(a3)	# MEM[(volatile uint8_t *)268435461B], MEM[(volatile uint8_t *)268435461B]
# kianv_stdlib.h:122:     while ((*((volatile uint8_t *)UART_LSR) & 0x60) == 0)
	andi	a5,a5,96	#, tmp89, MEM[(volatile uint8_t *)268435461B]
	beq	a5,zero,.L57	#, tmp89,,
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a1	# i, tmp92, val
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp93, tmp92
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a4,a5	# tmp93, tmp94, tmp98
	lbu	a5,0(a5)	# _7, "0123456789ABCDEF"[_5]
# kianv_stdlib.h:121:   for (int i = (4 * digits) - 4; i >= 0; i -= 4) {
	addi	a1,a1,-4	#, i, i
# kianv_stdlib.h:124:     *((volatile uint32_t *)UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a3)	# _7, MEM[(volatile uint32_t *)268435456B]
	j	.L56		#
	.size	print_hex, .-print_hex
	.align	2
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-128	#,,
	sw	a5,116(sp)	#,
# stdlib.c:69:   va_start(ap, format);
	addi	a5,sp,100	#, tmp107,
# stdlib.c:65: int printf(const char *format, ...) {
	sw	s2,80(sp)	#,
	sw	s3,76(sp)	#,
	sw	s4,72(sp)	#,
	sw	s5,68(sp)	#,
	sw	s6,64(sp)	#,
	sw	s7,60(sp)	#,
	sw	ra,92(sp)	#,
	sw	s0,88(sp)	#,
	sw	s1,84(sp)	#,
	sw	s8,56(sp)	#,
# stdlib.c:65: int printf(const char *format, ...) {
	mv	s3,a0	# format, tmp175
	sw	a1,100(sp)	#,
	sw	a2,104(sp)	#,
	sw	a3,108(sp)	#,
	sw	a4,112(sp)	#,
	sw	a6,120(sp)	#,
	sw	a7,124(sp)	#,
# stdlib.c:69:   va_start(ap, format);
	sw	a5,12(sp)	# tmp107, MEM[(void * *)&ap]
# stdlib.c:71:   for (i = 0; format[i]; i++)
	li	s2,0		# i,
# stdlib.c:74:         if (format[i] == 'c') {
	li	s4,99		# tmp167,
# stdlib.c:78:         if (format[i] == 's') {
	li	s5,115		# tmp168,
# stdlib.c:82:         if (format[i] == 'd') {
	li	s6,100		# tmp169,
# stdlib.c:86:         if (format[i] == 'u') {
	li	s7,117		# tmp170,
.L62:
# stdlib.c:71:   for (i = 0; format[i]; i++)
	add	a5,s3,s2	# i, tmp157, format
	lbu	a0,0(a5)	# _14, *_13
# stdlib.c:71:   for (i = 0; format[i]; i++)
	bne	a0,zero,.L79	#, _14,,
# stdlib.c:96: }
	lw	ra,92(sp)		#,
	lw	s0,88(sp)		#,
	lw	s1,84(sp)		#,
	lw	s2,80(sp)		#,
	lw	s3,76(sp)		#,
	lw	s4,72(sp)		#,
	lw	s5,68(sp)		#,
	lw	s6,64(sp)		#,
	lw	s7,60(sp)		#,
	lw	s8,56(sp)		#,
	addi	sp,sp,128	#,,
	jr	ra		#
.L79:
# stdlib.c:72:     if (format[i] == '%') {
	li	a5,37		# tmp108,
	bne	a0,a5,.L84	#, _14, tmp108,
.L63:
# stdlib.c:73:       while (format[++i]) {
	addi	s2,s2,1	#, i, i
# stdlib.c:73:       while (format[++i]) {
	add	a5,s3,s2	# i, tmp156, format
	lbu	a5,0(a5)	# _10, MEM[(const char *)_27]
# stdlib.c:73:       while (format[++i]) {
	beq	a5,zero,.L66	#, _10,,
# stdlib.c:74:         if (format[i] == 'c') {
	bne	a5,s4,.L65	#, _10, tmp167,
# stdlib.c:75:           printf_c(va_arg(ap, int));
	lw	a5,12(sp)		# D.2024, ap
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	lbu	a0,0(a5)	#, MEM[(int *)_98]
# stdlib.c:75:           printf_c(va_arg(ap, int));
	addi	a4,a5,4	#, D.2025, D.2024
	sw	a4,12(sp)	# D.2025, ap
.L84:
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	call	putchar		#
# stdlib.c:30: static void printf_c(int c) { print_chr(c); }
	j	.L66		#
.L65:
# stdlib.c:78:         if (format[i] == 's') {
	bne	a5,s5,.L67	#, _10, tmp168,
# stdlib.c:79:           printf_s(va_arg(ap, char *));
	lw	a5,12(sp)		# D.2026, ap
	lw	s0,0(a5)		# p, MEM[(char * *)_67]
	addi	a4,a5,4	#, D.2027, D.2026
	sw	a4,12(sp)	# D.2027, ap
.L68:
# stdlib.c:33:   while (*p)
	lbu	a0,0(s0)	# _39, MEM[(char *)p_37]
	bne	a0,zero,.L69	#, _39,,
.L66:
# stdlib.c:71:   for (i = 0; format[i]; i++)
	addi	s2,s2,1	#, i, i
	j	.L62		#
.L69:
# stdlib.c:34:     print_chr(*(p++));
	addi	s0,s0,1	#, p, p
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	call	putchar		#
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	j	.L68		#
.L67:
# stdlib.c:82:         if (format[i] == 'd') {
	bne	a5,s6,.L70	#, _10, tmp169,
# stdlib.c:83:           printf_d(va_arg(ap, int));
	lw	a5,12(sp)		# D.2028, ap
	lw	s1,0(a5)		# val, MEM[(int *)_99]
	addi	a4,a5,4	#, D.2029, D.2028
	sw	a4,12(sp)	# D.2029, ap
# stdlib.c:40:   if (val < 0) {
	bge	s1,zero,.L71	#, val,,
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	li	a0,45		#,
	call	putchar		#
# stdlib.c:42:     val = -val;
	neg	s1,s1	# val, val
.L71:
# stdlib.c:65: int printf(const char *format, ...) {
	addi	s0,sp,16	#, p,
	mv	s8,s0	# p, p
# stdlib.c:45:     *(p++) = '0' + val % 10;
	li	a4,10		# tmp161,
.L72:
# stdlib.c:44:   while (val || p == buffer) {
	bne	s1,zero,.L73	#, val,,
	beq	s0,s8,.L73	#, p, p,
.L74:
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	lbu	a0,-1(s0)	#, MEM[(char *)p_49]
# stdlib.c:49:     printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	call	putchar		#
# stdlib.c:48:   while (p != buffer)
	bne	s0,s8,.L74	#, p, p,
	j	.L66		#
.L73:
# stdlib.c:45:     *(p++) = '0' + val % 10;
	rem	a5,s1,a4	# tmp161, tmp122, val
# stdlib.c:45:     *(p++) = '0' + val % 10;
	addi	s0,s0,1	#, p, p
# stdlib.c:45:     *(p++) = '0' + val % 10;
	addi	a5,a5,48	#, tmp124, tmp122
# stdlib.c:46:     val = val / 10;
	div	s1,s1,a4	# tmp161, val, val
# stdlib.c:45:     *(p++) = '0' + val % 10;
	sb	a5,-1(s0)	# tmp124, MEM[(char *)p_45 + 4294967295B]
	j	.L72		#
.L70:
# stdlib.c:86:         if (format[i] == 'u') {
	bne	a5,s7,.L63	#, _10, tmp170,
# stdlib.c:87:           printf_u(va_arg(ap, int));
	lw	a5,12(sp)		# D.2030, ap
# stdlib.c:54:   char *p = buffer;
	addi	s0,sp,16	#, p,
	mv	s1,s0	# p, p
# stdlib.c:87:           printf_u(va_arg(ap, int));
	addi	a4,a5,4	#, D.2031, D.2030
# stdlib.c:56:   val = val >= 0 ? val : -val;
	lw	a5,0(a5)		# MEM[(int *)_102], MEM[(int *)_102]
# stdlib.c:87:           printf_u(va_arg(ap, int));
	sw	a4,12(sp)	# D.2031, ap
# stdlib.c:58:     *(p++) = '0' + val % 10;
	li	a3,10		# tmp162,
# stdlib.c:56:   val = val >= 0 ? val : -val;
	srai	a4,a5,31	#, tmp136, MEM[(int *)_102]
	xor	a5,a4,a5	# MEM[(int *)_102], val, tmp136
	sub	a5,a5,a4	# val, val, tmp136
.L75:
# stdlib.c:57:   while (val || p == buffer) {
	bne	a5,zero,.L76	#, val,,
	beq	s0,s1,.L76	#, p, p,
.L77:
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	lbu	a0,-1(s0)	#, MEM[(char *)p_62]
# stdlib.c:62:     printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# kianv_stdlib.h:73: void print_chr(char ch) { putchar(ch); }
	call	putchar		#
# stdlib.c:61:   while (p != buffer)
	bne	s0,s1,.L77	#, p, p,
	j	.L66		#
.L76:
# stdlib.c:58:     *(p++) = '0' + val % 10;
	rem	a4,a5,a3	# tmp162, tmp144, val
# stdlib.c:58:     *(p++) = '0' + val % 10;
	addi	s0,s0,1	#, p, p
# stdlib.c:58:     *(p++) = '0' + val % 10;
	addi	a4,a4,48	#, tmp146, tmp144
# stdlib.c:59:     val = val / 10;
	div	a5,a5,a3	# tmp162, val, val
# stdlib.c:58:     *(p++) = '0' + val % 10;
	sb	a4,-1(s0)	# tmp146, MEM[(char *)p_58 + 4294967295B]
	j	.L75		#
	.size	printf, .-printf
	.align	2
	.globl	malloc
	.type	malloc, @function
malloc:
# stdlib.c:100:   char *p = heap_memory + heap_memory_used;
	lui	a3,%hi(heap_memory_used)	# tmp77,
	lw	a4,%lo(heap_memory_used)(a3)		# heap_memory_used.17_1, heap_memory_used
# stdlib.c:100:   char *p = heap_memory + heap_memory_used;
	lui	a5,%hi(.LANCHOR0)	# tmp79,
	addi	a5,a5,%lo(.LANCHOR0)	# tmp78, tmp79,
	add	a5,a5,a4	# heap_memory_used.17_1, <retval>, tmp78
# stdlib.c:103:   heap_memory_used += size;
	add	a4,a4,a0	# tmp83, _3, heap_memory_used.17_1
	sw	a4,%lo(heap_memory_used)(a3)	# _3, heap_memory_used
# stdlib.c:104:   if (heap_memory_used > 1024)
	li	a3,1024		# tmp81,
	ble	a4,a3,.L86	#, _3, tmp81,
# stdlib.c:105:     asm volatile("ebreak");
 #APP
# 105 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L86:
# stdlib.c:107: }
	mv	a0,a5	#, <retval>
	ret	
	.size	malloc, .-malloc
	.align	2
	.globl	memcpy
	.type	memcpy, @function
memcpy:
# stdlib.c:113:   while (n--)
	li	a5,0		# ivtmp.176,
.L89:
# stdlib.c:113:   while (n--)
	bne	a5,a2,.L90	#, ivtmp.176, _16,
# stdlib.c:116: }
	ret	
.L90:
# stdlib.c:114:     *(a++) = *(b++);
	add	a4,a1,a5	# ivtmp.176, tmp81, bb
	lbu	a3,0(a4)	# _1, MEM[(const char *)_17]
# stdlib.c:114:     *(a++) = *(b++);
	add	a4,a0,a5	# ivtmp.176, tmp82, aa
	addi	a5,a5,1	#, ivtmp.176, ivtmp.176
	sb	a3,0(a4)	# _1, MEM[(char *)_18]
	j	.L89		#
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:121:   while ((((uint32_t)dst | (uint32_t)src) & 3) != 0) {
	mv	a5,a0	# dst, dst
.L92:
# stdlib.c:121:   while ((((uint32_t)dst | (uint32_t)src) & 3) != 0) {
	or	a4,a5,a1	# src, tmp96, dst
# stdlib.c:121:   while ((((uint32_t)dst | (uint32_t)src) & 3) != 0) {
	andi	a4,a4,3	#, tmp97, tmp96
# stdlib.c:121:   while ((((uint32_t)dst | (uint32_t)src) & 3) != 0) {
	bne	a4,zero,.L94	#, tmp97,,
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	li	a2,-16842752		# tmp100,
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	li	a6,-2139062272		# tmp105,
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	addi	a2,a2,-257	#, tmp99, tmp100
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	addi	a6,a6,128	#, tmp104, tmp105
.L97:
# stdlib.c:129:     uint32_t v = *(uint32_t *)src;
	lw	a4,0(a1)		# v, MEM[(uint32_t *)src_21]
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	add	a3,a4,a2	# tmp99, tmp98, v
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	not	a7,a4	# tmp101, v
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	and	a3,a3,a7	# tmp101, tmp102, tmp98
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	and	a3,a3,a6	# tmp104, tmp103, tmp102
# stdlib.c:131:     if (__builtin_expect((((v)-0x01010101UL) & ~(v)&0x80808080UL), 0)) {
	beq	a3,zero,.L95	#, tmp103,,
# stdlib.c:132:       dst[0] = v & 0xff;
	sb	a4,0(a5)	# v, *dst_19
# stdlib.c:133:       if ((v & 0xff) == 0)
	andi	a3,a4,255	#, tmp106, v
# stdlib.c:133:       if ((v & 0xff) == 0)
	beq	a3,zero,.L96	#, tmp106,,
# stdlib.c:135:       v = v >> 8;
	srli	a3,a4,8	#, v, v
# stdlib.c:137:       dst[1] = v & 0xff;
	sb	a3,1(a5)	# v, MEM[(char *)dst_19 + 1B]
# stdlib.c:138:       if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp107, v
# stdlib.c:138:       if ((v & 0xff) == 0)
	beq	a3,zero,.L96	#, tmp107,,
# stdlib.c:140:       v = v >> 8;
	srli	a3,a4,16	#, v, v
# stdlib.c:142:       dst[2] = v & 0xff;
	sb	a3,2(a5)	# v, MEM[(char *)dst_19 + 2B]
# stdlib.c:143:       if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp108, v
# stdlib.c:143:       if ((v & 0xff) == 0)
	beq	a3,zero,.L96	#, tmp108,,
# stdlib.c:145:       v = v >> 8;
	srli	a4,a4,24	#, v, v
# stdlib.c:147:       dst[3] = v & 0xff;
	sb	a4,3(a5)	# v, MEM[(char *)dst_19 + 3B]
# stdlib.c:148:       return r;
	ret	
.L94:
# stdlib.c:122:     char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:122:     char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:123:     *(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:123:     *(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:124:     if (!c)
	bne	a4,zero,.L92	#, c,,
.L96:
# stdlib.c:155: }
	ret	
.L95:
# stdlib.c:151:     *(uint32_t *)dst = v;
	sw	a4,0(a5)	# v, MEM[(uint32_t *)dst_19]
# stdlib.c:152:     src += 4;
	addi	a1,a1,4	#, src, src
# stdlib.c:153:     dst += 4;
	addi	a5,a5,4	#, dst, dst
# stdlib.c:128:   while (1) {
	j	.L97		#
	.size	strcpy, .-strcpy
	.align	2
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.L111:
# stdlib.c:158:   while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0) {
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:158:   while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0) {
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:158:   while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0) {
	bne	a5,zero,.L115	#, tmp102,,
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	li	a3,-16842752		# tmp156,
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	li	a2,-2139062272		# tmp158,
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	addi	a3,a3,-257	#, tmp157, tmp156
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	addi	a2,a2,128	#, tmp159, tmp158
.L120:
# stdlib.c:169:     uint32_t v1 = *(uint32_t *)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_15]
# stdlib.c:170:     uint32_t v2 = *(uint32_t *)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_17]
# stdlib.c:172:     if (__builtin_expect(v1 != v2, 0)) {
	beq	a5,a4,.L116	#, v1, v2,
# stdlib.c:175:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:175:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:176:       if (c1 != c2)
	beq	a3,a2,.L117	#, c1, c2,
.L134:
# stdlib.c:163:       return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:191:         return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L110	#, c1, c2,
.L132:
# stdlib.c:163:       return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
.L115:
# stdlib.c:159:     char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:160:     char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:159:     char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:160:     char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:162:     if (c1 != c2)
	beq	a5,a4,.L112	#, c1, c2,
# stdlib.c:163:       return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	bltu	a5,a4,.L110	#, c1, c2,
	li	a0,1		# <retval>,
	ret	
.L112:
# stdlib.c:164:     else if (!c1)
	bne	a5,zero,.L111	#, c1,,
.L130:
# stdlib.c:165:       return 0;
	li	a0,0		# <retval>,
	j	.L110		#
.L117:
	li	a0,0		# <retval>,
# stdlib.c:178:       if (!c1)
	beq	a3,zero,.L110	#, c1,,
# stdlib.c:180:       v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:180:       v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:182:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:182:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:183:       if (c1 != c2)
	bne	a3,a2,.L134	#, c1, c2,
# stdlib.c:165:       return 0;
	li	a0,0		# <retval>,
# stdlib.c:185:       if (!c1)
	beq	a3,zero,.L110	#, c1,,
# stdlib.c:187:       v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:187:       v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:189:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:189:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:190:       if (c1 != c2)
	bne	a3,a2,.L134	#, c1, c2,
# stdlib.c:165:       return 0;
	li	a0,0		# <retval>,
# stdlib.c:192:       if (!c1)
	beq	a3,zero,.L110	#, c1,,
# stdlib.c:196:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:196:       c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:197:       if (c1 != c2)
	beq	a5,a4,.L110	#, c1, c2,
# stdlib.c:163:       return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:198:         return c1 < c2 ? -1 : +1;
	bltu	a5,a4,.L132	#, c1, c2,
.L110:
# stdlib.c:208: }
	ret	
.L116:
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	add	a4,a5,a3	# tmp157, tmp109, v1
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	not	a5,a5	# tmp112, v1
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	and	a5,a4,a5	# tmp112, tmp113, tmp109
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	and	a5,a5,a2	# tmp159, tmp114, tmp113
# stdlib.c:202:     if (__builtin_expect((((v1)-0x01010101UL) & ~(v1)&0x80808080UL), 0))
	bne	a5,zero,.L130	#, tmp114,,
# stdlib.c:205:     s1 += 4;
	addi	a0,a0,4	#, s1, s1
# stdlib.c:206:     s2 += 4;
	addi	a1,a1,4	#, s2, s2
# stdlib.c:168:   while (1) {
	j	.L120		#
	.size	strcmp, .-strcmp
	.align	2
	.globl	generate_crc32_table
	.type	generate_crc32_table, @function
generate_crc32_table:
	lui	a4,%hi(.LANCHOR0+1024)	# tmp81,
# kernelboot.c:37:       crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
	li	a2,79765504		# tmp84,
	addi	a4,a4,%lo(.LANCHOR0+1024)	# ivtmp.244, tmp81,
# kernelboot.c:34:   for (uint32_t i = 0; i < 256; i++) {
	li	a3,0		# i,
# kernelboot.c:37:       crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
	addi	a2,a2,-585	#, iftmp.37_6, tmp84
# kernelboot.c:34:   for (uint32_t i = 0; i < 256; i++) {
	li	a0,256		# tmp83,
.L139:
	slli	a5,a3,24	#, crc, i
# kernelboot.c:34:   for (uint32_t i = 0; i < 256; i++) {
	li	a1,8		# ivtmp_17,
.L138:
# kernelboot.c:37:       crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
	slli	a6,a5,1	#, _1, crc
# kernelboot.c:37:       crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
	srai	a5,a5,31	#, tmp90, crc
	and	a5,a5,a2	# iftmp.37_6, tmp91, tmp90
# kernelboot.c:36:     for (int j = 0; j < 8; j++) {
	addi	a1,a1,-1	#, ivtmp_17, ivtmp_17
# kernelboot.c:37:       crc = (crc << 1) ^ ((crc & 0x80000000) ? polynomial : 0);
	xor	a5,a6,a5	# iftmp.37_6, crc, _1
# kernelboot.c:36:     for (int j = 0; j < 8; j++) {
	bne	a1,zero,.L138	#, ivtmp_17,,
# kernelboot.c:39:     crc32_table[i] = crc;
	sw	a5,0(a4)	# crc, MEM[(long unsigned int *)_19]
# kernelboot.c:34:   for (uint32_t i = 0; i < 256; i++) {
	addi	a3,a3,1	#, i, i
# kernelboot.c:34:   for (uint32_t i = 0; i < 256; i++) {
	addi	a4,a4,4	#, ivtmp.244, ivtmp.244
	bne	a3,a0,.L139	#, i, tmp83,
# kernelboot.c:41: }
	ret	
	.size	generate_crc32_table, .-generate_crc32_table
	.align	2
	.globl	crc32
	.type	crc32, @function
crc32:
# kernelboot.c:47:     crc = (crc << 8) ^ crc32_table[index];
	lui	a2,%hi(.LANCHOR0)	# tmp97,
# kernelboot.c:45:   for (size_t i = 0; i < len; i++) {
	li	a3,0		# i,
# kernelboot.c:44:   uint32_t crc = 0xFFFFFFFF;
	li	a5,-1		# crc,
# kernelboot.c:47:     crc = (crc << 8) ^ crc32_table[index];
	addi	a2,a2,%lo(.LANCHOR0)	# tmp98, tmp97,
.L144:
# kernelboot.c:45:   for (size_t i = 0; i < len; i++) {
	bne	a3,a1,.L145	#, i, len,
# kernelboot.c:50: }
	not	a0,a5	#, crc
	ret	
.L145:
# kernelboot.c:46:     uint8_t index = (crc >> 24) ^ data[i];
	add	a4,a0,a3	# i, tmp87, data
# kernelboot.c:46:     uint8_t index = (crc >> 24) ^ data[i];
	lbu	a4,0(a4)	# MEM[(uint8_t *)_18], MEM[(uint8_t *)_18]
# kernelboot.c:47:     crc = (crc << 8) ^ crc32_table[index];
	slli	a6,a5,8	#, _5, crc
# kernelboot.c:46:     uint8_t index = (crc >> 24) ^ data[i];
	srli	a5,a5,24	#, tmp88, crc
# kernelboot.c:47:     crc = (crc << 8) ^ crc32_table[index];
	xor	a5,a4,a5	# tmp88, tmp93, MEM[(uint8_t *)_18]
	slli	a5,a5,2	#, tmp95, tmp93
	add	a5,a2,a5	# tmp95, tmp94, tmp98
	lw	a5,1024(a5)		# _7, crc32_table[_6]
# kernelboot.c:45:   for (size_t i = 0; i < len; i++) {
	addi	a3,a3,1	#, i, i
# kernelboot.c:47:     crc = (crc << 8) ^ crc32_table[index];
	xor	a5,a6,a5	# _7, crc, _5
	j	.L144		#
	.size	crc32, .-crc32
	.section	.rodata.str1.4
	.align	2
.LC1:
	.string	"\nKianV RISC-V Linux SOC\n"
	.align	2
.LC2:
	.string	"----------------------\n"
	.align	2
.LC3:
	.string	"loading kernel Image from flash...\n"
	.align	2
.LC4:
	.string	"loading dtb Image from flash...\n"
	.align	2
.LC5:
	.string	"\nCRC-32 checksum of kernel: 0x"
	.align	2
.LC6:
	.string	"CRC-32 checksum of DTB   : 0x"
	.align	2
.LC7:
	.string	"\nstarting kernel at 0x80000000...\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
# kernelboot.c:57:   printf("\nKianV RISC-V Linux SOC\n");
	lui	a0,%hi(.LC1)	# tmp74,
# kernelboot.c:53: void main() {
	addi	sp,sp,-16	#,,
# kernelboot.c:57:   printf("\nKianV RISC-V Linux SOC\n");
	addi	a0,a0,%lo(.LC1)	#, tmp74,
# kernelboot.c:53: void main() {
	sw	ra,12(sp)	#,
	sw	s0,8(sp)	#,
	sw	s1,4(sp)	#,
	sw	s2,0(sp)	#,
# kernelboot.c:57:   printf("\nKianV RISC-V Linux SOC\n");
	call	printf		#
# kernelboot.c:58:   printf("----------------------\n");
	lui	a0,%hi(.LC2)	# tmp75,
	addi	a0,a0,%lo(.LC2)	#, tmp75,
	call	printf		#
# kernelboot.c:59:   printf("loading kernel Image from flash...\n");
	lui	a0,%hi(.LC3)	# tmp76,
	addi	a0,a0,%lo(.LC3)	#, tmp76,
	call	printf		#
# kernelboot.c:60:   memcpy(SDRAM_START, KERNEL_IMAGE, 1024 * 1024 * 4);
	li	a2,4194304		#,
	li	a1,538968064		#,
	li	a0,-2147483648		#,
	call	memcpy		#
# kernelboot.c:61:   printf("loading dtb Image from flash...\n");
	lui	a0,%hi(.LC4)	# tmp77,
	addi	a0,a0,%lo(.LC4)	#, tmp77,
	call	printf		#
# kernelboot.c:62:   memcpy(DTB_TARGET, DTB_IMAGE, 2048);
	li	s0,-2139095040		# tmp79,
	li	s2,4096		# tmp78,
	addi	a2,s2,-2048	#,, tmp78
	li	a1,538443776		#,
	addi	a0,s0,-2048	#,, tmp79
	call	memcpy		#
# kernelboot.c:68:   crc_32 = crc32(SDRAM_START, 4 * 1024 * 1024);
	li	a1,4194304		#,
	li	a0,-2147483648		#,
	call	crc32		#
	mv	s1,a0	# crc_32, tmp87
# kernelboot.c:69:   printf("\nCRC-32 checksum of kernel: 0x");
	lui	a0,%hi(.LC5)	# tmp80,
	addi	a0,a0,%lo(.LC5)	#, tmp80,
	call	printf		#
# kernelboot.c:70:   print_hex(crc_32, 8);
	li	a1,8		#,
	mv	a0,s1	#, crc_32
	call	print_hex		#
# kernelboot.c:71:   putchar(13);
	li	a0,13		#,
	call	putchar		#
# kernelboot.c:72:   crc_32 = crc32(DTB_TARGET, 2048);
	addi	a1,s2,-2048	#,, tmp78
	addi	a0,s0,-2048	#,, tmp79
	call	crc32		#
	mv	s1,a0	# crc_32, tmp88
# kernelboot.c:73:   printf("CRC-32 checksum of DTB   : 0x");
	lui	a0,%hi(.LC6)	# tmp83,
	addi	a0,a0,%lo(.LC6)	#, tmp83,
	call	printf		#
# kernelboot.c:74:   print_hex(crc_32, 8);
	li	a1,8		#,
	mv	a0,s1	#, crc_32
	call	print_hex		#
# kernelboot.c:75:   putchar(13);
	li	a0,13		#,
	call	putchar		#
# kernelboot.c:76:   printf("\nstarting kernel at 0x80000000...\n");
	lui	a0,%hi(.LC7)	# tmp84,
	addi	a0,a0,%lo(.LC7)	#, tmp84,
	call	printf		#
# kernelboot.c:82:   kernel_entry(hartId, dtb);
	addi	a1,s0,-2048	#,, tmp79
# kernelboot.c:83: }
	lw	s0,8(sp)		#,
	lw	ra,12(sp)		#,
	lw	s1,4(sp)		#,
	lw	s2,0(sp)		#,
# kernelboot.c:82:   kernel_entry(hartId, dtb);
	li	a0,0		#,
# kernelboot.c:83: }
# kernelboot.c:82:   kernel_entry(hartId, dtb);
	li	a5,-2147483648		# tmp85,
# kernelboot.c:83: }
	addi	sp,sp,16	#,,
# kernelboot.c:82:   kernel_entry(hartId, dtb);
	jr	a5		# tmp85
	.size	main, .-main
	.globl	crc32_table
	.globl	heap_memory_used
	.globl	heap_memory
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory, @object
	.size	heap_memory, 1024
heap_memory:
	.zero	1024
	.type	crc32_table, @object
	.size	crc32_table, 1024
crc32_table:
	.zero	1024
	.section	.sbss,"aw",@nobits
	.align	2
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.ident	"GCC: (GNU) 11.1.0"
