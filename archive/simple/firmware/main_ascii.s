	.file	"main_ascii.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (GCC) version 11.1.0 (riscv32-unknown-elf)
#	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=rv32im -mabi=ilp32 -mtune=rocket -march=rv32im -Os -fno-pic -fno-stack-protector -ffreestanding
	.text
	.align	2
	.globl	set_reg
	.type	set_reg, @function
set_reg:
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp85,
	sll	a1,a5,a1	# tmp88, _12, tmp85
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a5,0(a0)		# _1,* p
# kianv_stdlib.h:42:     if (bit) {
	beq	a2,zero,.L2	#, tmp89,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a1,a1,a5	# _1, _5, _12
.L4:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	sw	a1,0(a0)	# _18,* p
# kianv_stdlib.h:47: }
	ret	
.L2:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a1,a1	# tmp86, _12
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a1,a1,a5	# _13, _18, tmp86
	j	.L4		#
	.size	set_reg, .-set_reg
	.align	2
	.globl	gpio_set_value
	.type	gpio_set_value, @function
gpio_set_value:
# kianv_stdlib.h:49: void gpio_set_value(int gpio, int bit) {
	mv	a2,a1	# tmp76, bit
# kianv_stdlib.h:50:     set_reg(GPIO_OUTPUT, gpio, bit);
	mv	a1,a0	#, tmp75
	li	a0,805306368		# tmp74,
	addi	a0,a0,28	#,, tmp74
	tail	set_reg		#
	.size	gpio_set_value, .-gpio_set_value
	.align	2
	.globl	gpio_get_input_value
	.type	gpio_get_input_value, @function
gpio_get_input_value:
# kianv_stdlib.h:54:   uint32_t read = IO_IN(GPIO_INPUT);
	li	a5,805306368		# tmp77,
	lw	a5,32(a5)		# read, MEM[(volatile uint32_t *)805306400B]
# kianv_stdlib.h:57:   return ((read >> gpio) & 0x01);
	srl	a0,a5,a0	# tmp80, tmp79, read
# kianv_stdlib.h:58: }
	andi	a0,a0,1	#,, tmp79
	ret	
	.size	gpio_get_input_value, .-gpio_get_input_value
	.align	2
	.globl	gpio_set_direction
	.type	gpio_set_direction, @function
gpio_set_direction:
# kianv_stdlib.h:60: void gpio_set_direction(int gpio, int bit) {
	mv	a2,a1	# tmp76, bit
# kianv_stdlib.h:61:     set_reg(GPIO_DIR, gpio, bit);
	mv	a1,a0	#, tmp75
	li	a0,805306368		# tmp74,
	addi	a0,a0,20	#,, tmp74
	tail	set_reg		#
	.size	gpio_set_direction, .-gpio_set_direction
	.align	2
	.globl	get_cycles
	.type	get_cycles, @function
get_cycles:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp78
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp78, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp79
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp79, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_1, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_4, tmpl0
# kianv_stdlib.h:73: }
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
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	call	get_cycles		#
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	add	s1,a0,s1	# wait, tmp95, _1
	sltu	s0,s1,a0	# _1, tmp78, tmp95
	add	a1,a1,s2	# wait, tmp96, tmp100
	add	s0,s0,a1	# tmp96, tmp80, tmp78
.L13:
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	call	get_cycles		#
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	s0,a1,.L13	#, tmp80, _2,
	bne	s0,a1,.L10	#, tmp80, _2,
	bgtu	s1,a0,.L13	#, tmp95, _2,
.L10:
# kianv_stdlib.h:83: }
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
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L15	#, us,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a4,999424		# tmp82,
	addi	a4,a4,576	#, tmp81, tmp82
	divu	a5,a5,a4	# tmp81, tmp80, _8
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a1,0		#,
	mul	a0,a5,a0	#, tmp80, us
	tail	wait_cycles		#
.L15:
# kianv_stdlib.h:87: }
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L17	#, ms,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a4,1000		# tmp80,
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a1,0		#,
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	divu	a5,a5,a4	# tmp80, tmp81, _8
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a0,a5,a0	#, tmp81, ms
	tail	wait_cycles		#
.L17:
# kianv_stdlib.h:91: }
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L19	#, sec,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp77,
	lw	a5,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	li	a1,0		#,
	mul	a0,a0,a5	#, sec, _7
	tail	wait_cycles		#
.L19:
# kianv_stdlib.h:95: }
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:98:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	call	get_cycles		#
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:98:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	li	a5,999424		# tmp83,
	addi	a5,a5,576	#, tmp82, tmp83
	divu	a2,a2,a5	# tmp82,, _7
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:99: }
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
# kianv_stdlib.h:102:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	call	get_cycles		#
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:102:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	li	a5,1000		# tmp81,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp81,, _7
	call	__udivdi3		#
# kianv_stdlib.h:103: }
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
# kianv_stdlib.h:106:   return get_cycles() / (uint64_t) (get_cpu_freq());
	call	get_cycles		#
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp77,
	lw	a2,16(a5)		# _6, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:106:   return get_cycles() / (uint64_t) (get_cpu_freq());
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:107: }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp75,
.L28:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L28	#, _1,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a5)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:113: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
	tail	putchar		#
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_str
	.type	print_str, @function
print_str:
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp78,
.L33:
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a5,0(a0)	# _3, MEM[(char *)p_4]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a5,zero,.L34	#, _3,,
# kianv_stdlib.h:127: }
	ret	
.L34:
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	lw	a3,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a3,zero,.L34	#, _1,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a5,0(a4)	# _3, MEM[(volatile uint32_t *)805306368B]
	j	.L33		#
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:129:   print_str(p);
	call	print_str		#
# kianv_stdlib.h:131: }
	lw	ra,12(sp)		#,
# kianv_stdlib.h:130:   print_chr(10);
	li	a0,10		#,
# kianv_stdlib.h:131: }
	addi	sp,sp,16	#,,
# kianv_stdlib.h:130:   print_chr(10);
	tail	putchar		#
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:135:   char *p = buffer;
	addi	a5,sp,4	#, p,
	mv	a3,a5	# p, p
# kianv_stdlib.h:137:     *(p++) = val % 10;
	li	a4,10		# tmp93,
.L41:
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a0,zero,.L42	#, val,,
# kianv_stdlib.h:136:   while (val || p == buffer) {
	beq	a5,a3,.L42	#, p, p,
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	li	a2,805306368		# tmp88,
.L43:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a2)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L43	#, _3,,
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a4,-1(a5)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,-1	#, p, p
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a4,0(a2)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:141:   while (p != buffer) {
	bne	a5,a3,.L43	#, p, p,
# kianv_stdlib.h:146: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L42:
# kianv_stdlib.h:137:     *(p++) = val % 10;
	remu	a2,a0,a4	# tmp93, tmp83, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	addi	a5,a5,1	#, p, p
# kianv_stdlib.h:138:     val = val / 10;
	divu	a0,a0,a4	# tmp93, val, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	sb	a2,-1(a5)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L41		#
	.size	print_dec, .-print_dec
	.globl	__umoddi3
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-64	#,,
	sw	s2,48(sp)	#,
# kianv_stdlib.h:150:   char *p = buffer;
	addi	s2,sp,12	#, p,
# kianv_stdlib.h:148: void print_dec64(uint64_t val) {
	sw	s0,56(sp)	#,
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	ra,60(sp)	#,
# kianv_stdlib.h:148: void print_dec64(uint64_t val) {
	mv	s0,a0	# val, tmp102
	mv	s1,a1	# val, tmp103
	mv	s3,s2	# p, p
.L50:
# kianv_stdlib.h:151:   while (val || p == buffer) {
	or	a5,s0,s1	# val, val, val
	bne	a5,zero,.L51	#, val,,
# kianv_stdlib.h:151:   while (val || p == buffer) {
	beq	s2,s3,.L51	#, p, p,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp93,
.L52:
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L52	#, _3,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(s2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	s2,s2,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	s2,s3,.L52	#, p, p,
# kianv_stdlib.h:161: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
.L51:
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	a2,10		#,
	li	a3,0		#,
	mv	a0,s0	#, val
	mv	a1,s1	#, val
	call	__umoddi3		#
# kianv_stdlib.h:153:     val = val / 10;
	mv	a1,s1	#, val
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sb	a0,0(s2)	# tmp104, MEM[(char *)p_18 + 4294967295B]
# kianv_stdlib.h:153:     val = val / 10;
	li	a2,10		#,
	mv	a0,s0	#, val
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	s2,s2,1	#, p, p
# kianv_stdlib.h:153:     val = val / 10;
	mv	s0,a0	# val, tmp106
	mv	s1,a1	# val, tmp107
	j	.L50		#
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
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-1	#, tmp81, tmp93
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	lui	a4,%hi(.LC0)	# tmp90,
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a1,a1,2	#, i, tmp81
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp89,
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	addi	a4,a4,%lo(.LC0)	# tmp91, tmp90,
.L59:
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bge	a1,zero,.L60	#, i,,
# kianv_stdlib.h:169: }
	ret	
.L60:
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L60	#, _2,,
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a1	# i, tmp85, val
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp86, tmp85
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a4,a5	# tmp86, tmp87, tmp91
	lbu	a5,0(a5)	# _6, "0123456789ABCDEF"[_4]
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-4	#, i, i
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a3)	# _6, MEM[(volatile uint32_t *)805306368B]
	j	.L59		#
	.size	print_hex, .-print_hex
	.align	2
	.globl	setpixel
	.type	setpixel, @function
setpixel:
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a5,65536		# tmp88,
	addi	a5,a5,-1	#, tmp87, tmp88
	slli	a1,a1,8	#, tmp85, tmp94
	and	a1,a1,a5	# tmp87, tmp86, tmp85
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	a3,a3,16	#, tmp89, tmp96
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a1,a1,a3	# tmp89, tmp90, tmp86
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	andi	a2,a2,0xff	# tmp91, tmp95
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a1,a1,a2	# tmp91, _9, tmp90
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a5,805306368		# tmp93,
	sw	a1,8(a5)	# _9, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:184: }
	ret	
	.size	setpixel, .-setpixel
	.align	2
	.globl	draw_bresenham
	.type	draw_bresenham, @function
draw_bresenham:
	addi	sp,sp,-64	#,,
	sw	s7,28(sp)	#,
	mv	s7,a0	# fb, tmp101
# kianv_stdlib.h:189:   int dx =  abs(x1 - x0);
	sub	a0,a3,a1	#, x1, x0
# kianv_stdlib.h:187: {
	sw	s0,56(sp)	#,
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	s5,36(sp)	#,
	sw	s6,32(sp)	#,
	sw	s8,24(sp)	#,
	sw	s10,16(sp)	#,
	sw	ra,60(sp)	#,
	sw	s2,48(sp)	#,
	sw	s4,40(sp)	#,
	sw	s9,20(sp)	#,
	sw	s11,12(sp)	#,
# kianv_stdlib.h:187: {
	mv	s1,a1	# x0, tmp102
	mv	s0,a2	# y0, tmp103
	mv	s5,a3	# x1, tmp104
	mv	s6,a4	# y1, tmp105
	mv	s8,a5	# color, tmp106
# kianv_stdlib.h:189:   int dx =  abs(x1 - x0);
	call	abs		#
	mv	s3,a0	# dx, tmp107
# kianv_stdlib.h:190:   int sx = x0 < x1 ? 1 : -1;
	li	s10,-1		# iftmp.6_9,
	ble	s5,s1,.L66	#, x1, x0,
	li	s10,1		# iftmp.6_9,
.L66:
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
	mv	s4,a0	# _3, tmp108
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	neg	s11,a0	# dy, _3
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	li	s9,1		# iftmp.7_10,
	bgt	s6,s0,.L67	#, y1, y0,
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	li	s9,-1		# iftmp.7_10,
.L67:
	sub	s2,s3,s4	# err, dx, _3
.L68:
# kianv_stdlib.h:196:     setpixel(fb, x0, y0, color);
	mv	a3,s8	#, color
	mv	a2,s0	#, y0
	mv	a1,s1	#, x0
	mv	a0,s7	#, fb
	call	setpixel		#
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s5,.L69	#, x0, x1,
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s6,.L65	#, y0, y1,
.L69:
# kianv_stdlib.h:198:     e2 = 2*err;
	slli	a5,s2,1	#, e2, err
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	s11,a5,.L71	#, dy, e2,
	sub	s2,s2,s4	# err, err, _3
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s10	# iftmp.6_9, x0, x0
.L71:
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s3,a5,.L68	#, dx, e2,
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s2,s2,s3	# dx, err, err
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,s9	# iftmp.7_10, y0, y0
	j	.L68		#
.L65:
# kianv_stdlib.h:202: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	lw	s4,40(sp)		#,
	lw	s5,36(sp)		#,
	lw	s6,32(sp)		#,
	lw	s7,28(sp)		#,
	lw	s8,24(sp)		#,
	lw	s9,20(sp)		#,
	lw	s10,16(sp)		#,
	lw	s11,12(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
	.size	draw_bresenham, .-draw_bresenham
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16	#,,
	sw	s1,4(sp)	#,
	sw	ra,12(sp)	#,
	sw	s0,8(sp)	#,
# main_ascii.c:8:     for (char i = ' '; i < 'z'; i++) {
	li	s1,122		# tmp74,
.L79:
# main_ascii.c:8:     for (char i = ' '; i < 'z'; i++) {
	li	s0,32		# i,
.L78:
# main_ascii.c:9:       putchar(i);
	mv	a0,s0	#, i
# main_ascii.c:8:     for (char i = ' '; i < 'z'; i++) {
	addi	s0,s0,1	#, tmp73, i
	andi	s0,s0,0xff	# i, tmp73
# main_ascii.c:9:       putchar(i);
	call	putchar		#
# main_ascii.c:8:     for (char i = ' '; i < 'z'; i++) {
	bne	s0,s1,.L78	#, i, tmp74,
	j	.L79		#
	.size	main, .-main
	.ident	"GCC: (GNU) 11.1.0"
