	.file	"main_seeed.c"
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
	.align	2
	.globl	time
	.type	time, @function
time:
# stdlib.c:33: 	asm volatile ("rdcycle %0" : "=r"(cycles));
 #APP
# 33 "stdlib.c" 1
	rdcycle a0	# cycles
# 0 "" 2
# stdlib.c:36: }
 #NO_APP
	ret	
	.size	time, .-time
	.align	2
	.globl	insn
	.type	insn, @function
insn:
# stdlib.c:41: 	asm volatile ("rdinstret %0" : "=r"(insns));
 #APP
# 41 "stdlib.c" 1
	rdinstret a0	# insns
# 0 "" 2
# stdlib.c:44: }
 #NO_APP
	ret	
	.size	insn, .-insn
	.align	2
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-128	#,,
	sw	a5,116(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	addi	a5,sp,100	#, tmp107,
# stdlib.c:90: {
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
# stdlib.c:90: {
	mv	s3,a0	# format, tmp175
	sw	a1,100(sp)	#,
	sw	a2,104(sp)	#,
	sw	a3,108(sp)	#,
	sw	a4,112(sp)	#,
	sw	a6,120(sp)	#,
	sw	a7,124(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	sw	a5,12(sp)	# tmp107, MEM[(void * *)&ap]
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	li	s2,0		# i,
# stdlib.c:99: 				if (format[i] == 'c') {
	li	s4,99		# tmp167,
# stdlib.c:103: 				if (format[i] == 's') {
	li	s5,115		# tmp168,
# stdlib.c:107: 				if (format[i] == 'd') {
	li	s6,100		# tmp169,
# stdlib.c:111: 				if (format[i] == 'u') {
	li	s7,117		# tmp170,
.L80:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a5,s3,s2	# i, tmp157, format
	lbu	a0,0(a5)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	a0,zero,.L97	#, _14,,
# stdlib.c:121: }
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
.L97:
# stdlib.c:97: 		if (format[i] == '%') {
	li	a5,37		# tmp108,
	bne	a0,a5,.L102	#, _14, tmp108,
.L81:
# stdlib.c:98: 			while (format[++i]) {
	addi	s2,s2,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a5,s3,s2	# i, tmp156, format
	lbu	a5,0(a5)	# _10, MEM[(const char *)_27]
# stdlib.c:98: 			while (format[++i]) {
	beq	a5,zero,.L84	#, _10,,
# stdlib.c:99: 				if (format[i] == 'c') {
	bne	a5,s4,.L83	#, _10, tmp167,
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a5,12(sp)		# D.2746, ap
# stdlib.c:49:     print_chr(c);
	lbu	a0,0(a5)	#, MEM[(int *)_98]
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	addi	a4,a5,4	#, D.2747, D.2746
	sw	a4,12(sp)	# D.2747, ap
.L102:
# stdlib.c:49:     print_chr(c);
	call	putchar		#
# stdlib.c:50: }
	j	.L84		#
.L83:
# stdlib.c:103: 				if (format[i] == 's') {
	bne	a5,s5,.L85	#, _10, tmp168,
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a5,12(sp)		# D.2748, ap
	lw	s0,0(a5)		# p, MEM[(char * *)_67]
	addi	a4,a5,4	#, D.2749, D.2748
	sw	a4,12(sp)	# D.2749, ap
.L86:
# stdlib.c:54: 	while (*p)
	lbu	a0,0(s0)	# _39, MEM[(char *)p_37]
	bne	a0,zero,.L87	#, _39,,
.L84:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	s2,s2,1	#, i, i
	j	.L80		#
.L87:
# stdlib.c:56:     print_chr(*(p++));
	addi	s0,s0,1	#, p, p
# stdlib.c:56:     print_chr(*(p++));
	call	putchar		#
	j	.L86		#
.L85:
# stdlib.c:107: 				if (format[i] == 'd') {
	bne	a5,s6,.L88	#, _10, tmp169,
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a5,12(sp)		# D.2750, ap
	lw	s1,0(a5)		# val, MEM[(int *)_99]
	addi	a4,a5,4	#, D.2751, D.2750
	sw	a4,12(sp)	# D.2751, ap
# stdlib.c:63: 	if (val < 0) {
	bge	s1,zero,.L89	#, val,,
# stdlib.c:49:     print_chr(c);
	li	a0,45		#,
	call	putchar		#
# stdlib.c:65: 		val = -val;
	neg	s1,s1	# val, val
.L89:
# stdlib.c:90: {
	addi	s0,sp,16	#, p,
	mv	s8,s0	# p, p
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	li	a4,10		# tmp161,
.L90:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	s1,zero,.L91	#, val,,
	beq	s0,s8,.L91	#, p, p,
.L92:
# stdlib.c:49:     print_chr(c);
	lbu	a0,-1(s0)	#, MEM[(char *)p_49]
# stdlib.c:72: 		printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# stdlib.c:49:     print_chr(c);
	call	putchar		#
# stdlib.c:71: 	while (p != buffer)
	bne	s0,s8,.L92	#, p, p,
	j	.L84		#
.L91:
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	rem	a5,s1,a4	# tmp161, tmp122, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	s0,s0,1	#, p, p
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	a5,a5,48	#, tmp124, tmp122
# stdlib.c:69: 		val = val / 10;
	div	s1,s1,a4	# tmp161, val, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	sb	a5,-1(s0)	# tmp124, MEM[(char *)p_45 + 4294967295B]
	j	.L90		#
.L88:
# stdlib.c:111: 				if (format[i] == 'u') {
	bne	a5,s7,.L81	#, _10, tmp170,
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a5,12(sp)		# D.2752, ap
# stdlib.c:78: 	char *p = buffer;
	addi	s0,sp,16	#, p,
	mv	s1,s0	# p, p
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a4,a5,4	#, D.2753, D.2752
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a5,0(a5)		# MEM[(int *)_102], MEM[(int *)_102]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	sw	a4,12(sp)	# D.2753, ap
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	li	a3,10		# tmp162,
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a4,a5,31	#, tmp136, MEM[(int *)_102]
	xor	a5,a4,a5	# MEM[(int *)_102], val, tmp136
	sub	a5,a5,a4	# val, val, tmp136
.L93:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a5,zero,.L94	#, val,,
	beq	s0,s1,.L94	#, p, p,
.L95:
# stdlib.c:49:     print_chr(c);
	lbu	a0,-1(s0)	#, MEM[(char *)p_62]
# stdlib.c:86: 		printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# stdlib.c:49:     print_chr(c);
	call	putchar		#
# stdlib.c:85: 	while (p != buffer)
	bne	s0,s1,.L95	#, p, p,
	j	.L84		#
.L94:
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	rem	a4,a5,a3	# tmp162, tmp144, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	s0,s0,1	#, p, p
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	a4,a4,48	#, tmp146, tmp144
# stdlib.c:83: 		val = val / 10;
	div	a5,a5,a3	# tmp162, val, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	sb	a4,-1(s0)	# tmp146, MEM[(char *)p_58 + 4294967295B]
	j	.L93		#
	.size	printf, .-printf
	.align	2
	.globl	malloc
	.type	malloc, @function
malloc:
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	lui	a3,%hi(heap_memory_used)	# tmp77,
	lw	a4,%lo(heap_memory_used)(a3)		# heap_memory_used.19_1, heap_memory_used
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	lui	a5,%hi(.LANCHOR0)	# tmp79,
	addi	a5,a5,%lo(.LANCHOR0)	# tmp78, tmp79,
	add	a5,a5,a4	# heap_memory_used.19_1, <retval>, tmp78
# stdlib.c:128: 	heap_memory_used += size;
	add	a4,a4,a0	# tmp83, _3, heap_memory_used.19_1
	sw	a4,%lo(heap_memory_used)(a3)	# _3, heap_memory_used
# stdlib.c:129: 	if (heap_memory_used > 1024)
	li	a3,1024		# tmp81,
	ble	a4,a3,.L104	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L104:
# stdlib.c:132: }
	mv	a0,a5	#, <retval>
	ret	
	.size	malloc, .-malloc
	.align	2
	.globl	memcpy
	.type	memcpy, @function
memcpy:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,0		# ivtmp.319,
.L107:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a5,a2,.L108	#, ivtmp.319, _16,
# stdlib.c:142: }
	ret	
.L108:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	add	a4,a1,a5	# ivtmp.319, tmp81, bb
	lbu	a3,0(a4)	# _1, MEM[(const char *)_17]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	add	a4,a0,a5	# ivtmp.319, tmp82, aa
	addi	a5,a5,1	#, ivtmp.319, ivtmp.319
	sb	a3,0(a4)	# _1, MEM[(char *)_18]
	j	.L107		#
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
.L110:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp96, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp97, tmp96
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L112	#, tmp97,,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp100,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a6,-2139062272		# tmp105,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp99, tmp100
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	addi	a6,a6,128	#, tmp104, tmp105
.L115:
# stdlib.c:157: 		uint32_t v = *(uint32_t*)src;
	lw	a4,0(a1)		# v, MEM[(uint32_t *)src_21]
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	add	a3,a4,a2	# tmp99, tmp98, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	not	a7,a4	# tmp101, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	and	a3,a3,a7	# tmp101, tmp102, tmp98
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	and	a3,a3,a6	# tmp104, tmp103, tmp102
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	beq	a3,zero,.L113	#, tmp103,,
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a4,0(a5)	# v, *dst_19
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a3,a4,255	#, tmp106, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L114	#, tmp106,,
# stdlib.c:164: 			v = v >> 8;
	srli	a3,a4,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a3,1(a5)	# v, MEM[(char *)dst_19 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp107, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L114	#, tmp107,,
# stdlib.c:169: 			v = v >> 8;
	srli	a3,a4,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a3,2(a5)	# v, MEM[(char *)dst_19 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp108, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L114	#, tmp108,,
# stdlib.c:174: 			v = v >> 8;
	srli	a4,a4,24	#, v, v
# stdlib.c:176: 			dst[3] = v & 0xff;
	sb	a4,3(a5)	# v, MEM[(char *)dst_19 + 3B]
# stdlib.c:177: 			return r;
	ret	
.L112:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	bne	a4,zero,.L110	#, c,,
.L114:
# stdlib.c:184: }
	ret	
.L113:
# stdlib.c:180: 		*(uint32_t*)dst = v;
	sw	a4,0(a5)	# v, MEM[(uint32_t *)dst_19]
# stdlib.c:181: 		src += 4;
	addi	a1,a1,4	#, src, src
# stdlib.c:182: 		dst += 4;
	addi	a5,a5,4	#, dst, dst
# stdlib.c:156: 	{
	j	.L115		#
	.size	strcpy, .-strcpy
	.align	2
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.L129:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L133	#, tmp102,,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-16842752		# tmp156,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-2139062272		# tmp158,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,-257	#, tmp157, tmp156
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,128	#, tmp159, tmp158
.L138:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_15]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_17]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	beq	a5,a4,.L134	#, v1, v2,
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a3,a2,.L135	#, c1, c2,
.L152:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L128	#, c1, c2,
.L150:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
.L133:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	beq	a5,a4,.L130	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	bltu	a5,a4,.L128	#, c1, c2,
	li	a0,1		# <retval>,
	ret	
.L130:
# stdlib.c:195: 		else if (!c1)
	bne	a5,zero,.L129	#, c1,,
.L148:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
	j	.L128		#
.L135:
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L128	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L152	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L128	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L152	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L128	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L128	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bltu	a5,a4,.L150	#, c1, c2,
.L128:
# stdlib.c:234: }
	ret	
.L134:
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	add	a4,a5,a3	# tmp157, tmp109, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	not	a5,a5	# tmp112, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a4,a5	# tmp112, tmp113, tmp109
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a5,a2	# tmp159, tmp114, tmp113
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	bne	a5,zero,.L148	#, tmp114,,
# stdlib.c:231: 		s1 += 4;
	addi	a0,a0,4	#, s1, s1
# stdlib.c:232: 		s2 += 4;
	addi	a1,a1,4	#, s2, s2
# stdlib.c:200: 	{
	j	.L138		#
	.size	strcmp, .-strcmp
	.align	2
	.globl	swap
	.type	swap, @function
swap:
# main_seeed.c:276:     *a = *b;
	lhu	a4,0(a1)	# _1, *b_5(D)
# main_seeed.c:275:     uint16_t t = *a;
	lhu	a5,0(a0)	# t, *a_3(D)
# main_seeed.c:276:     *a = *b;
	sh	a4,0(a0)	# _1, *a_3(D)
# main_seeed.c:277:     *b = t;
	sh	a5,0(a1)	# t, *b_5(D)
# main_seeed.c:278: };
	ret	
	.size	swap, .-swap
	.align	2
	.globl	SGL
	.type	SGL, @function
SGL:
# main_seeed.c:291:     _width = width;
	lui	a5,%hi(_width)	# tmp74,
	sh	a0,%lo(_width)(a5)	# tmp76, _width
# main_seeed.c:292:     _height = height;
	lui	a5,%hi(_height)	# tmp75,
	sh	a1,%lo(_height)(a5)	# tmp77, _height
# main_seeed.c:293: }
	ret	
	.size	SGL, .-SGL
	.align	2
	.globl	_sendCmd
	.type	_sendCmd, @function
_sendCmd:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp75,
	sw	a0,12(a5)	# c, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:554: }
	ret	
	.size	_sendCmd, .-_sendCmd
	.align	2
	.globl	_sendData
	.type	_sendData, @function
_sendData:
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	ori	a0,a0,256	#, _3, tmp78
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	li	a5,805306368		# tmp77,
	sw	a0,12(a5)	# _3, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:563: }
	ret	
	.size	_sendData, .-_sendData
	.align	2
	.globl	init
	.type	init, @function
init:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp73,
	li	a4,174		# tmp74,
	sw	a4,12(a5)	# tmp74, MEM[(volatile uint32_t *)805306380B]
	li	a4,129		# tmp77,
	sw	a4,12(a5)	# tmp77, MEM[(volatile uint32_t *)805306380B]
	li	a4,145		# tmp80,
	sw	a4,12(a5)	# tmp80, MEM[(volatile uint32_t *)805306380B]
	li	a4,130		# tmp83,
	sw	a4,12(a5)	# tmp83, MEM[(volatile uint32_t *)805306380B]
	li	a4,80		# tmp86,
	sw	a4,12(a5)	# tmp86, MEM[(volatile uint32_t *)805306380B]
	li	a4,131		# tmp89,
	sw	a4,12(a5)	# tmp89, MEM[(volatile uint32_t *)805306380B]
	li	a4,125		# tmp92,
	sw	a4,12(a5)	# tmp92, MEM[(volatile uint32_t *)805306380B]
	li	a4,135		# tmp95,
	sw	a4,12(a5)	# tmp95, MEM[(volatile uint32_t *)805306380B]
	li	a4,6		# tmp98,
	sw	a4,12(a5)	# tmp98, MEM[(volatile uint32_t *)805306380B]
	li	a4,138		# tmp101,
	sw	a4,12(a5)	# tmp101, MEM[(volatile uint32_t *)805306380B]
	li	a4,100		# tmp104,
	sw	a4,12(a5)	# tmp104, MEM[(volatile uint32_t *)805306380B]
	li	a3,139		# tmp107,
	sw	a3,12(a5)	# tmp107, MEM[(volatile uint32_t *)805306380B]
	li	a3,120		# tmp110,
	sw	a3,12(a5)	# tmp110, MEM[(volatile uint32_t *)805306380B]
	li	a3,140		# tmp113,
	sw	a3,12(a5)	# tmp113, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# tmp104, MEM[(volatile uint32_t *)805306380B]
	li	a4,160		# tmp119,
	sw	a4,12(a5)	# tmp119, MEM[(volatile uint32_t *)805306380B]
	li	a4,114		# tmp122,
	sw	a4,12(a5)	# tmp122, MEM[(volatile uint32_t *)805306380B]
	li	a4,161		# tmp125,
	sw	a4,12(a5)	# tmp125, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,162		# tmp130,
	sw	a4,12(a5)	# tmp130, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,164		# tmp135,
	sw	a4,12(a5)	# tmp135, MEM[(volatile uint32_t *)805306380B]
	li	a4,168		# tmp138,
	sw	a4,12(a5)	# tmp138, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp141,
	sw	a4,12(a5)	# tmp141, MEM[(volatile uint32_t *)805306380B]
	li	a4,173		# tmp144,
	sw	a4,12(a5)	# tmp144, MEM[(volatile uint32_t *)805306380B]
	li	a4,142		# tmp147,
	sw	a4,12(a5)	# tmp147, MEM[(volatile uint32_t *)805306380B]
	li	a4,176		# tmp150,
	sw	a4,12(a5)	# tmp150, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,177		# tmp155,
	sw	a4,12(a5)	# tmp155, MEM[(volatile uint32_t *)805306380B]
	li	a4,49		# tmp158,
	sw	a4,12(a5)	# tmp158, MEM[(volatile uint32_t *)805306380B]
	li	a4,179		# tmp161,
	sw	a4,12(a5)	# tmp161, MEM[(volatile uint32_t *)805306380B]
	li	a4,240		# tmp164,
	sw	a4,12(a5)	# tmp164, MEM[(volatile uint32_t *)805306380B]
	li	a4,187		# tmp167,
	sw	a4,12(a5)	# tmp167, MEM[(volatile uint32_t *)805306380B]
	li	a4,58		# tmp170,
	sw	a4,12(a5)	# tmp170, MEM[(volatile uint32_t *)805306380B]
	li	a4,190		# tmp173,
	sw	a4,12(a5)	# tmp173, MEM[(volatile uint32_t *)805306380B]
	li	a4,62		# tmp176,
	sw	a4,12(a5)	# tmp176, MEM[(volatile uint32_t *)805306380B]
	li	a4,46		# tmp179,
	sw	a4,12(a5)	# tmp179, MEM[(volatile uint32_t *)805306380B]
	li	a4,175		# tmp182,
	sw	a4,12(a5)	# tmp182, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:610: }
	ret	
	.size	init, .-init
	.align	2
	.globl	drawPixel
	.type	drawPixel, @function
drawPixel:
# main_seeed.c:614:     if ((x < 0) || (x >= RGB_OLED_WIDTH) || (y < 0)
	li	a3,95		# tmp84,
	bgtu	a0,a3,.L159	#, x, tmp84,
# main_seeed.c:615: 	|| (y >= RGB_OLED_HEIGHT))
	li	a4,63		# tmp85,
	bgtu	a1,a4,.L159	#, y, tmp85,
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp87,
	li	a6,21		# tmp88,
	sw	a6,12(a5)	# tmp88, MEM[(volatile uint32_t *)805306380B]
	sw	a0,12(a5)	# x, MEM[(volatile uint32_t *)805306380B]
	sw	a3,12(a5)	# tmp84, MEM[(volatile uint32_t *)805306380B]
	li	a3,117		# tmp96,
	sw	a3,12(a5)	# tmp96, MEM[(volatile uint32_t *)805306380B]
	sw	a1,12(a5)	# y, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# tmp85, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:630:     _sendData(color >> 8);
	srli	a4,a2,8	#, tmp102, color
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	ori	a4,a4,256	#, _14, tmp102
	andi	a2,a2,0xff	# color, color
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	sw	a4,12(a5)	# _14, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	ori	a2,a2,256	#, _18, color
# main_seeed.c:561:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	sw	a2,12(a5)	# _18, MEM[(volatile uint32_t *)805306380B]
.L159:
# main_seeed.c:633: }
	ret	
	.size	drawPixel, .-drawPixel
	.align	2
	.globl	drawLineSGL
	.type	drawLineSGL, @function
drawLineSGL:
	addi	sp,sp,-48	#,,
	sw	s1,36(sp)	#,
	mv	s1,a0	# x0, tmp109
# main_seeed.c:301:     int dx = abs(x), sx = x0 < x1 ? 1 : -1;
	sub	a0,a2,a0	#, x1, x0
# main_seeed.c:298: {
	sw	s0,40(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	s8,8(sp)	#,
	sw	ra,44(sp)	#,
	sw	s4,24(sp)	#,
	sw	s9,4(sp)	#,
	sw	s10,0(sp)	#,
# main_seeed.c:298: {
	mv	s0,a1	# y0, tmp110
	mv	s5,a2	# x1, tmp111
	mv	s6,a3	# y1, tmp112
	mv	s7,a4	# color, tmp113
# main_seeed.c:300:     int y = y1 - y0;
	sub	s2,a3,a1	# y, y1, y0
# main_seeed.c:301:     int dx = abs(x), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s3,a0	# dx, tmp114
# main_seeed.c:301:     int dx = abs(x), sx = x0 < x1 ? 1 : -1;
	li	s8,-1		# iftmp.39_13,
	bleu	s5,s1,.L162	#, x1, x0,
	li	s8,1		# iftmp.39_13,
.L162:
# main_seeed.c:302:     int dy = -abs(y), sy = y0 < y1 ? 1 : -1;
	mv	a0,s2	#, y
	call	abs		#
	mv	s4,a0	# _5, tmp115
# main_seeed.c:302:     int dy = -abs(y), sy = y0 < y1 ? 1 : -1;
	neg	s10,a0	# dy, _5
# main_seeed.c:302:     int dy = -abs(y), sy = y0 < y1 ? 1 : -1;
	li	s9,1		# iftmp.40_14,
	bgtu	s6,s0,.L163	#, y1, y0,
# main_seeed.c:302:     int dy = -abs(y), sy = y0 < y1 ? 1 : -1;
	li	s9,-1		# iftmp.40_14,
.L163:
	sub	s2,s3,s4	# err, dx, _5
.L164:
# main_seeed.c:305: 	drawPixel(x0, y0, color);
	mv	a2,s7	#, color
	mv	a1,s0	#, y0
	mv	a0,s1	#, x0
	call	drawPixel		#
# main_seeed.c:306: 	e2 = 2 * err;
	slli	a5,s2,1	#, e2, err
# main_seeed.c:307: 	if (e2 >= dy) {
	bgt	s10,a5,.L165	#, dy, e2,
# main_seeed.c:308: 	    if (x0 == x1)
	beq	s1,s5,.L161	#, x0, x1,
# main_seeed.c:311: 	    x0 += sx;
	add	s1,s1,s8	# iftmp.39_13, tmp94, x0
	slli	s1,s1,16	#, x0, tmp94
	sub	s2,s2,s4	# err, err, _5
	srli	s1,s1,16	#, x0, x0
.L165:
# main_seeed.c:313: 	if (e2 <= dx) {
	blt	s3,a5,.L164	#, dx, e2,
# main_seeed.c:314: 	    if (y0 == y1)
	beq	s0,s6,.L161	#, y0, y1,
# main_seeed.c:317: 	    y0 += sy;
	add	s0,s0,s9	# iftmp.40_14, tmp96, y0
	slli	s0,s0,16	#, y0, tmp96
# main_seeed.c:316: 	    err += dx;
	add	s2,s2,s3	# dx, err, err
# main_seeed.c:317: 	    y0 += sy;
	srli	s0,s0,16	#, y0, y0
	j	.L164		#
.L161:
# main_seeed.c:320: }
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	lw	s1,36(sp)		#,
	lw	s2,32(sp)		#,
	lw	s3,28(sp)		#,
	lw	s4,24(sp)		#,
	lw	s5,20(sp)		#,
	lw	s6,16(sp)		#,
	lw	s7,12(sp)		#,
	lw	s8,8(sp)		#,
	lw	s9,4(sp)		#,
	lw	s10,0(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	drawLineSGL, .-drawLineSGL
	.align	2
	.globl	drawTraingle
	.type	drawTraingle, @function
drawTraingle:
	addi	sp,sp,-32	#,,
	sw	s1,20(sp)	#,
	mv	s1,a4	# x2, tmp83
# main_seeed.c:403:     drawLineSGL(x0, y0, x1, y1, color);
	mv	a4,a6	#, color
# main_seeed.c:402: {
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	sw	s4,8(sp)	#,
	sw	s5,4(sp)	#,
	sw	s6,0(sp)	#,
# main_seeed.c:402: {
	mv	s2,a5	# y2, tmp84
	mv	s0,a6	# color, tmp85
	mv	s3,a0	# x0, tmp79
	mv	s4,a1	# y0, tmp80
	mv	s5,a2	# x1, tmp81
	mv	s6,a3	# y1, tmp82
# main_seeed.c:403:     drawLineSGL(x0, y0, x1, y1, color);
	call	drawLineSGL		#
# main_seeed.c:404:     drawLineSGL(x1, y1, x2, y2, color);
	mv	a4,s0	#, color
	mv	a3,s2	#, y2
	mv	a2,s1	#, x2
	mv	a1,s6	#, y1
	mv	a0,s5	#, x1
	call	drawLineSGL		#
# main_seeed.c:405:     drawLineSGL(x2, y2, x0, y0, color);
	mv	a4,s0	#, color
# main_seeed.c:406: }
	lw	s0,24(sp)		#,
	lw	ra,28(sp)		#,
	lw	s5,4(sp)		#,
	lw	s6,0(sp)		#,
# main_seeed.c:405:     drawLineSGL(x2, y2, x0, y0, color);
	mv	a3,s4	#, y0
	mv	a2,s3	#, x0
# main_seeed.c:406: }
	lw	s4,8(sp)		#,
	lw	s3,12(sp)		#,
# main_seeed.c:405:     drawLineSGL(x2, y2, x0, y0, color);
	mv	a1,s2	#, y2
	mv	a0,s1	#, x2
# main_seeed.c:406: }
	lw	s2,16(sp)		#,
	lw	s1,20(sp)		#,
	addi	sp,sp,32	#,,
# main_seeed.c:405:     drawLineSGL(x2, y2, x0, y0, color);
	tail	drawLineSGL		#
	.size	drawTraingle, .-drawTraingle
	.align	2
	.globl	drawVerticalLine
	.type	drawVerticalLine, @function
drawVerticalLine:
# main_seeed.c:325:     uint16_t y1 = min(y + height, _height - 1);
	lui	a5,%hi(_height)	# tmp88,
	lhu	a5,%lo(_height)(a5)	# _height, _height
# main_seeed.c:324: {
	addi	sp,sp,-32	#,,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s1,20(sp)	#,
# main_seeed.c:325:     uint16_t y1 = min(y + height, _height - 1);
	add	a4,a1,a2	# tmp98, tmp91, y
	addi	a5,a5,-1	#, _7, _height
# main_seeed.c:324: {
	mv	s2,a0	# x, tmp96
	mv	s3,a3	# color, tmp99
# main_seeed.c:325:     uint16_t y1 = min(y + height, _height - 1);
	ble	a5,a4,.L175	#, _7, tmp91,
	mv	a5,a4	# _7, tmp91
.L175:
# main_seeed.c:326:     for (int16_t i = y; i < y1; i++) {
	slli	a1,a1,16	#, i, y
# main_seeed.c:326:     for (int16_t i = y; i < y1; i++) {
	slli	s1,a5,16	#, tmp93, _7
# main_seeed.c:326:     for (int16_t i = y; i < y1; i++) {
	srai	a1,a1,16	#, i, i
# main_seeed.c:326:     for (int16_t i = y; i < y1; i++) {
	srli	s1,s1,16	#, tmp93, tmp93
.L176:
# main_seeed.c:326:     for (int16_t i = y; i < y1; i++) {
	blt	a1,s1,.L177	#, i, tmp93,
# main_seeed.c:329: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
.L177:
	slli	s0,a1,16	#, _22, i
	srli	s0,s0,16	#, _22, _22
# main_seeed.c:327: 	drawPixel(x, i, color);
	mv	a1,s0	#, _22
	mv	a2,s3	#, color
	mv	a0,s2	#, x
	call	drawPixel		#
	addi	a1,s0,1	#, tmp92, _22
	slli	a1,a1,16	#, i, tmp92
	srai	a1,a1,16	#, i, i
	j	.L176		#
	.size	drawVerticalLine, .-drawVerticalLine
	.align	2
	.globl	fillCircle
	.type	fillCircle, @function
fillCircle:
	addi	sp,sp,-64	#,,
	sw	s0,56(sp)	#,
# main_seeed.c:383:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	li	s0,1		# tmp93,
	sub	s0,s0,a2	# tmp94, tmp93, r
# main_seeed.c:382: {
	sw	s1,52(sp)	#,
	sw	s2,48(sp)	#,
	sw	s3,44(sp)	#,
	sw	s4,40(sp)	#,
	sw	s6,32(sp)	#,
	sw	s7,28(sp)	#,
	sw	ra,60(sp)	#,
	sw	s5,36(sp)	#,
# main_seeed.c:382: {
	mv	s3,a0	# poX, tmp109
	mv	s6,a1	# poY, tmp110
	mv	s4,a3	# color, tmp112
# main_seeed.c:383:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	neg	s1,a2	# x, r
# main_seeed.c:383:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	slli	s0,s0,1	#, e2, tmp94
# main_seeed.c:383:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	li	s2,0		# y,
# main_seeed.c:396:     while (x <= 0);
	li	s7,1		# tmp107,
.L180:
# main_seeed.c:385: 	drawVerticalLine(poX - x, poY - y, 2 * y, color);
	slli	s5,s1,16	#, _3, x
	slli	a2,s2,16	#, _5, y
	srli	s5,s5,16	#, _3, _3
	srli	a2,a2,16	#, _5, _5
	sub	a5,s6,a2	# tmp95, poY, _5
	sub	a0,s3,s5	# tmp97, poX, _3
	slli	a2,a2,1	#, tmp96, _5
	slli	a1,a5,16	#, _6, tmp95
	slli	a2,a2,16	#, _7, tmp96
	slli	a0,a0,16	#,, tmp97
	srli	a1,a1,16	#, _6, _6
	srli	a2,a2,16	#, _7, _7
	mv	a3,s4	#, color
	srli	a0,a0,16	#,,
	sw	a2,12(sp)	# _7, %sfp
	sw	a1,8(sp)	# _6, %sfp
	call	drawVerticalLine		#
# main_seeed.c:386: 	drawVerticalLine(poX + x, poY - y, 2 * y, color);
	add	a0,s5,s3	# poX, tmp99, _3
	lw	a2,12(sp)		# _7, %sfp
	lw	a1,8(sp)		# _6, %sfp
	slli	a0,a0,16	#,, tmp99
	mv	a3,s4	#, color
	srli	a0,a0,16	#,,
	call	drawVerticalLine		#
# main_seeed.c:388: 	if (e2 <= y) {
	blt	s2,s0,.L184	#, y, e2,
# main_seeed.c:389: 	    err += ++y * 2 + 1;
	addi	s2,s2,1	#, y, y
# main_seeed.c:389: 	    err += ++y * 2 + 1;
	slli	a5,s2,1	#, tmp101, y
# main_seeed.c:389: 	    err += ++y * 2 + 1;
	addi	a5,a5,1	#, tmp102, tmp101
# main_seeed.c:390: 	    if (-x == y && e2 <= x)
	neg	a4,s1	# tmp103, x
# main_seeed.c:389: 	    err += ++y * 2 + 1;
	add	a5,a5,s0	# e2, err, tmp102
# main_seeed.c:390: 	    if (-x == y && e2 <= x)
	bne	a4,s2,.L181	#, tmp103, y,
# main_seeed.c:390: 	    if (-x == y && e2 <= x)
	blt	s1,s0,.L182	#, x, e2,
# main_seeed.c:391: 		e2 = 0;
	li	s0,0		# e2,
.L181:
# main_seeed.c:393: 	if (e2 > x)
	bge	s1,s0,.L183	#, x, e2,
.L182:
# main_seeed.c:394: 	    err += ++x * 2 + 1;
	addi	s1,s1,1	#, x, x
# main_seeed.c:394: 	    err += ++x * 2 + 1;
	slli	a4,s1,1	#, tmp104, x
# main_seeed.c:394: 	    err += ++x * 2 + 1;
	addi	a4,a4,1	#, tmp105, tmp104
# main_seeed.c:394: 	    err += ++x * 2 + 1;
	add	a5,a5,a4	# tmp105, err, err
# main_seeed.c:396:     while (x <= 0);
	bne	s1,s7,.L183	#, x, tmp107,
# main_seeed.c:397: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	lw	s4,40(sp)		#,
	lw	s5,36(sp)		#,
	lw	s6,32(sp)		#,
	lw	s7,28(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
.L183:
# main_seeed.c:382: {
	mv	s0,a5	# e2, err
	j	.L180		#
.L184:
	mv	a5,s0	# err, e2
	j	.L181		#
	.size	fillCircle, .-fillCircle
	.align	2
	.globl	drawHorizontalLine
	.type	drawHorizontalLine, @function
drawHorizontalLine:
# main_seeed.c:334:     uint16_t x1 = min(x + width, _width - 1);
	lui	a5,%hi(_width)	# tmp88,
	lhu	a5,%lo(_width)(a5)	# _width, _width
# main_seeed.c:333: {
	addi	sp,sp,-32	#,,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s1,20(sp)	#,
# main_seeed.c:334:     uint16_t x1 = min(x + width, _width - 1);
	add	a4,a0,a2	# tmp98, tmp91, x
	addi	a5,a5,-1	#, _7, _width
# main_seeed.c:333: {
	mv	s2,a1	# y, tmp97
	mv	s3,a3	# color, tmp99
# main_seeed.c:334:     uint16_t x1 = min(x + width, _width - 1);
	ble	a5,a4,.L187	#, _7, tmp91,
	mv	a5,a4	# _7, tmp91
.L187:
# main_seeed.c:335:     for (int16_t i = x; i < x1; i++) {
	slli	a0,a0,16	#, i, x
# main_seeed.c:335:     for (int16_t i = x; i < x1; i++) {
	slli	s1,a5,16	#, tmp93, _7
# main_seeed.c:335:     for (int16_t i = x; i < x1; i++) {
	srai	a0,a0,16	#, i, i
# main_seeed.c:335:     for (int16_t i = x; i < x1; i++) {
	srli	s1,s1,16	#, tmp93, tmp93
.L188:
# main_seeed.c:335:     for (int16_t i = x; i < x1; i++) {
	blt	a0,s1,.L189	#, i, tmp93,
# main_seeed.c:338: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
.L189:
	slli	s0,a0,16	#, _22, i
	srli	s0,s0,16	#, _22, _22
# main_seeed.c:336: 	drawPixel(i, y, color);
	mv	a0,s0	#, _22
	mv	a2,s3	#, color
	mv	a1,s2	#, y
	call	drawPixel		#
	addi	a0,s0,1	#, tmp92, _22
	slli	a0,a0,16	#, i, tmp92
	srai	a0,a0,16	#, i, i
	j	.L188		#
	.size	drawHorizontalLine, .-drawHorizontalLine
	.align	2
	.globl	drawRectangle
	.type	drawRectangle, @function
drawRectangle:
	addi	sp,sp,-32	#,,
	sw	s3,12(sp)	#,
	mv	s3,a3	# height, tmp86
# main_seeed.c:344:     drawHorizontalLine(x, y, width, color);
	mv	a3,a4	#, color
# main_seeed.c:343: {
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s1,20(sp)	#,
	sw	s2,16(sp)	#,
	sw	s4,8(sp)	#,
# main_seeed.c:343: {
	mv	s1,a4	# color, tmp87
	mv	s0,a0	# x, tmp83
	mv	s2,a1	# y, tmp84
	mv	s4,a2	# width, tmp85
# main_seeed.c:344:     drawHorizontalLine(x, y, width, color);
	call	drawHorizontalLine		#
# main_seeed.c:345:     drawHorizontalLine(x, y + height, width, color);
	add	a1,s2,s3	# height, tmp79, y
	slli	a1,a1,16	#,, tmp79
	mv	a3,s1	#, color
	mv	a2,s4	#, width
	mv	a0,s0	#, x
	srli	a1,a1,16	#,,
	call	drawHorizontalLine		#
# main_seeed.c:346:     drawVerticalLine(x, y, height, color);
	mv	a3,s1	#, color
	mv	a2,s3	#, height
	mv	a1,s2	#, y
	mv	a0,s0	#, x
	call	drawVerticalLine		#
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	add	a0,s0,s4	# width, tmp81, x
# main_seeed.c:348: }
	lw	s0,24(sp)		#,
	lw	ra,28(sp)		#,
	lw	s4,8(sp)		#,
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	mv	a3,s1	#, color
	mv	a2,s3	#, height
# main_seeed.c:348: }
	lw	s1,20(sp)		#,
	lw	s3,12(sp)		#,
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	mv	a1,s2	#, y
# main_seeed.c:348: }
	lw	s2,16(sp)		#,
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	slli	a0,a0,16	#,, tmp81
# main_seeed.c:348: }
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	srli	a0,a0,16	#,,
# main_seeed.c:348: }
	addi	sp,sp,32	#,,
# main_seeed.c:347:     drawVerticalLine(x + width, y, height, color);
	tail	drawVerticalLine		#
	.size	drawRectangle, .-drawRectangle
	.align	2
	.globl	fillTraingle
	.type	fillTraingle, @function
fillTraingle:
	addi	sp,sp,-80	#,,
	sw	s0,72(sp)	#,
	sw	s1,68(sp)	#,
	sw	s3,60(sp)	#,
	sw	s6,48(sp)	#,
	sw	s7,44(sp)	#,
	mv	s1,a3	# y1, tmp215
	sw	ra,76(sp)	#,
	sw	s2,64(sp)	#,
	sw	s4,56(sp)	#,
	sw	s5,52(sp)	#,
	sw	s8,40(sp)	#,
	sw	s9,36(sp)	#,
	sw	s10,32(sp)	#,
	sw	s11,28(sp)	#,
# main_seeed.c:411: {
	mv	s6,a0	# x0, tmp212
	mv	s0,a1	# y0, tmp213
	mv	s3,a2	# x1, tmp214
	mv	s7,a5	# y2, tmp217
	mv	a3,a6	# color, tmp218
# main_seeed.c:414:     if (y0 > y1) {
	bleu	a1,s1,.L194	#, y0, y1,
# main_seeed.c:418:     if (y1 > y2) {
	bgtu	a1,a5,.L195	#, y0, y2,
.L208:
# main_seeed.c:422:     if (y0 > y1) {
	mv	a5,s0	# y0, y0
	mv	s0,s1	# y0, y1
	mv	s1,a5	# y1, y0
	mv	a5,s6	# x0, x0
	mv	s6,s3	# x0, x1
	mv	s3,a5	# x1, x0
.L209:
# main_seeed.c:427:     if (y0 == y2) {
	bne	s0,s7,.L196	#, y0, y2,
# main_seeed.c:428: 	x0 = min(x0, x1) < x2 ? min(x0, x1) : x2;
	mv	a0,s6	# x0, x0
	bleu	s6,s3,.L197	#, x0, x1,
	mv	a0,s3	# x0, x1
.L197:
# main_seeed.c:428: 	x0 = min(x0, x1) < x2 ? min(x0, x1) : x2;
	slli	a5,a0,16	#, x0, x0
	srli	a5,a5,16	#, x0, x0
	bleu	a5,a4,.L198	#, x0, x2,
	mv	a0,a4	# x0, x2
.L198:
	slli	a0,a0,16	#, _2, x0
	srli	a0,a0,16	#, _2, _2
# main_seeed.c:429: 	x2 = max(x0, x1) > x2 ? max(x0, x1) : x2;
	mv	a2,s3	# x1, x1
	bgeu	s3,a4,.L199	#, x1, x2,
	mv	a2,a4	# x1, x2
.L199:
	slli	a5,a2,16	#, x1, x1
	srli	a5,a5,16	#, x1, x1
	bgeu	a5,a0,.L200	#, x1, _2,
	mv	a2,a0	# x1, _2
.L200:
# main_seeed.c:430: 	drawHorizontalLine(x0, y0, x2 - x0, color);
	mv	a1,s0	#, y0
# main_seeed.c:464: }
	lw	s0,72(sp)		#,
	lw	ra,76(sp)		#,
	lw	s1,68(sp)		#,
	lw	s2,64(sp)		#,
	lw	s3,60(sp)		#,
	lw	s4,56(sp)		#,
	lw	s5,52(sp)		#,
	lw	s6,48(sp)		#,
	lw	s7,44(sp)		#,
	lw	s8,40(sp)		#,
	lw	s9,36(sp)		#,
	lw	s10,32(sp)		#,
	lw	s11,28(sp)		#,
# main_seeed.c:430: 	drawHorizontalLine(x0, y0, x2 - x0, color);
	sub	a2,a2,a0	# tmp161, x1, _2
	slli	a2,a2,16	#,, tmp161
# main_seeed.c:464: }
# main_seeed.c:430: 	drawHorizontalLine(x0, y0, x2 - x0, color);
	srli	a2,a2,16	#,,
# main_seeed.c:464: }
	addi	sp,sp,80	#,,
# main_seeed.c:430: 	drawHorizontalLine(x0, y0, x2 - x0, color);
	tail	drawHorizontalLine		#
.L211:
# main_seeed.c:422:     if (y0 > y1) {
	mv	s7,a5	# y2, y0
	mv	a5,s6	# x0, x0
	mv	s6,a4	# x0, x2
	mv	a4,a5	# x2, x0
.L196:
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	sub	s9,a4,s6	# tmp165, x2, x0
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	sub	a5,s3,s6	# tmp163, x1, x0
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	sub	a4,a4,s3	# tmp167, x2, x1
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	sub	a6,s1,s0	# tmp164, y1, y0
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	sub	s4,s7,s0	# tmp166, y2, y0
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	sub	s5,s7,s1	# tmp168, y2, y1
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	slli	s2,a4,16	#, _10, tmp167
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	slli	a5,a5,16	#, _6, tmp163
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	slli	a6,a6,16	#, dy01, tmp164
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	slli	s9,s9,16	#, _8, tmp165
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	slli	s4,s4,16	#, dy02, tmp166
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	slli	s5,s5,16	#, dy12, tmp168
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	srli	a5,a5,16	#, _6, _6
# main_seeed.c:434:     int16_t dx01 = x1 - x0, dy01 = y1 - y0,
	srai	a6,a6,16	#, dy01, dy01
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	srli	s9,s9,16	#, _8, _8
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	srai	s4,s4,16	#, dy02, dy02
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	srli	s2,s2,16	#, _10, _10
# main_seeed.c:435: 	dx02 = x2 - x0, dy02 = y2 - y0, dx12 = x2 - x1, dy12 = y2 - y1;
	srai	s5,s5,16	#, dy12, dy12
	mv	a4,s1	# last, y1
# main_seeed.c:438:     if (y1 == y2)
	beq	s1,s7,.L201	#, y1, y2,
# main_seeed.c:441: 	last = y1 - 1;
	addi	a4,s1,-1	#, tmp169, y1
	slli	a4,a4,16	#, last, tmp169
	srli	a4,a4,16	#, last, last
.L201:
# main_seeed.c:443:     for (y = y0; y <= last; y++) {
	mv	s8,s0	# y, y0
# main_seeed.c:436:     int16_t sa = 0, sb = 0;
	li	s11,0		# sb,
# main_seeed.c:436:     int16_t sa = 0, sb = 0;
	li	s10,0		# sa,
.L202:
# main_seeed.c:443:     for (y = y0; y <= last; y++) {
	bleu	s8,a4,.L204	#, y, last,
# main_seeed.c:453:     sa = dx12 * (y - y1);
	sub	s1,s8,s1	# tmp187, y, y1
# main_seeed.c:454:     sb = dx02 * (y - y0);
	sub	s0,s8,s0	# tmp190, y, y0
# main_seeed.c:453:     sa = dx12 * (y - y1);
	mul	s1,s2,s1	# tmp189, _10, tmp187
# main_seeed.c:454:     sb = dx02 * (y - y0);
	mul	s0,s9,s0	# tmp192, _8, tmp190
# main_seeed.c:453:     sa = dx12 * (y - y1);
	slli	s1,s1,16	#, sa, tmp189
	srai	s1,s1,16	#, sa, sa
# main_seeed.c:454:     sb = dx02 * (y - y0);
	slli	s0,s0,16	#, sb, tmp192
	srai	s0,s0,16	#, sb, sb
.L205:
# main_seeed.c:455:     for (; y <= y2; y++) {
	bleu	s8,s7,.L207	#, y, y2,
# main_seeed.c:464: }
	lw	ra,76(sp)		#,
	lw	s0,72(sp)		#,
	lw	s1,68(sp)		#,
	lw	s2,64(sp)		#,
	lw	s3,60(sp)		#,
	lw	s4,56(sp)		#,
	lw	s5,52(sp)		#,
	lw	s6,48(sp)		#,
	lw	s7,44(sp)		#,
	lw	s8,40(sp)		#,
	lw	s9,36(sp)		#,
	lw	s10,32(sp)		#,
	lw	s11,28(sp)		#,
	addi	sp,sp,80	#,,
	jr	ra		#
.L204:
# main_seeed.c:444: 	a = x0 + sa / dy01;
	div	a0,s10,a6	# dy01, tmp171, sa
	add	s10,a5,s10	# sa, tmp179, _6
	slli	s10,s10,16	#, sa, tmp179
	srai	s10,s10,16	#, sa, sa
# main_seeed.c:445: 	b = x0 + sb / dy02;
	div	a2,s11,s4	# dy02, tmp175, sb
# main_seeed.c:444: 	a = x0 + sa / dy01;
	add	a0,s6,a0	# tmp171, tmp173, x0
	slli	a0,a0,16	#, a, tmp173
	add	s11,s9,s11	# sb, tmp181, _8
	slli	s11,s11,16	#, sb, tmp181
	srli	a0,a0,16	#, a, a
	srai	s11,s11,16	#, sb, sb
# main_seeed.c:445: 	b = x0 + sb / dy02;
	add	a2,s6,a2	# tmp175, tmp177, x0
	slli	a2,a2,16	#, b, tmp177
	srli	a2,a2,16	#, b, b
# main_seeed.c:448: 	if (a > b)
	bleu	a0,a2,.L203	#, a, b,
	mv	a1,a0	# a, a
	mv	a0,a2	# a, b
	mv	a2,a1	# b, a
.L203:
# main_seeed.c:450: 	drawHorizontalLine(a, y, b - a + 1, color);
	addi	a2,a2,1	#, tmp182, b
	sub	a2,a2,a0	# tmp184, tmp182, a
	slli	a2,a2,16	#,, tmp184
	mv	a1,s8	#, y
	srli	a2,a2,16	#,,
# main_seeed.c:443:     for (y = y0; y <= last; y++) {
	addi	s8,s8,1	#, tmp186, y
	sw	a6,12(sp)	# dy01, %sfp
	sw	a4,8(sp)	# last, %sfp
	sw	a5,4(sp)	# _6, %sfp
# main_seeed.c:450: 	drawHorizontalLine(a, y, b - a + 1, color);
	sw	a3,0(sp)	# color, %sfp
# main_seeed.c:443:     for (y = y0; y <= last; y++) {
	slli	s8,s8,16	#, y, tmp186
# main_seeed.c:450: 	drawHorizontalLine(a, y, b - a + 1, color);
	call	drawHorizontalLine		#
# main_seeed.c:443:     for (y = y0; y <= last; y++) {
	lw	a6,12(sp)		# dy01, %sfp
	lw	a4,8(sp)		# last, %sfp
	lw	a5,4(sp)		# _6, %sfp
	lw	a3,0(sp)		# color, %sfp
	srli	s8,s8,16	#, y, y
	j	.L202		#
.L207:
# main_seeed.c:456: 	a = x1 + sa / dy12;
	div	a0,s1,s5	# dy12, tmp194, sa
	add	s1,s2,s1	# sa, tmp202, _10
	slli	s1,s1,16	#, sa, tmp202
	srai	s1,s1,16	#, sa, sa
# main_seeed.c:457: 	b = x0 + sb / dy02;
	div	a2,s0,s4	# dy02, tmp198, sb
# main_seeed.c:456: 	a = x1 + sa / dy12;
	add	a0,s3,a0	# tmp194, tmp196, x1
	slli	a0,a0,16	#, _37, tmp196
	add	s0,s9,s0	# sb, tmp204, _8
	slli	s0,s0,16	#, sb, tmp204
	srli	a0,a0,16	#, _37, _37
	srai	s0,s0,16	#, sb, sb
# main_seeed.c:457: 	b = x0 + sb / dy02;
	add	a2,s6,a2	# tmp198, tmp200, x0
	slli	a2,a2,16	#, _42, tmp200
	srli	a2,a2,16	#, _42, _42
# main_seeed.c:460: 	if (a > b)
	bleu	a0,a2,.L206	#, _37, _42,
	mv	a5,a0	# _37, _37
	mv	a0,a2	# _37, _42
	mv	a2,a5	# _42, _37
.L206:
# main_seeed.c:462: 	drawHorizontalLine(a, y, b - a + 1, color);
	addi	a2,a2,1	#, tmp205, _42
	sub	a2,a2,a0	# tmp207, tmp205, _37
	slli	a2,a2,16	#,, tmp207
	mv	a1,s8	#, y
	srli	a2,a2,16	#,,
# main_seeed.c:455:     for (; y <= y2; y++) {
	addi	s8,s8,1	#, tmp209, y
# main_seeed.c:462: 	drawHorizontalLine(a, y, b - a + 1, color);
	sw	a3,0(sp)	# color, %sfp
# main_seeed.c:455:     for (; y <= y2; y++) {
	slli	s8,s8,16	#, y, tmp209
# main_seeed.c:462: 	drawHorizontalLine(a, y, b - a + 1, color);
	call	drawHorizontalLine		#
# main_seeed.c:455:     for (; y <= y2; y++) {
	lw	a3,0(sp)		# color, %sfp
	srli	s8,s8,16	#, y, y
	j	.L205		#
.L194:
# main_seeed.c:418:     if (y1 > y2) {
	bleu	s1,a5,.L209	#, y1, y2,
	mv	a5,s0	# y0, y0
	mv	s0,s1	# y0, y1
	mv	s1,a5	# y1, y0
	mv	a5,s6	# x0, x0
	mv	s6,s3	# x0, x1
	mv	s3,a5	# x1, x0
.L195:
# main_seeed.c:422:     if (y0 > y1) {
	mv	a5,s0	# y0, y0
	mv	s0,s7	# y0, y2
	bltu	s7,s1,.L211	#, y2, y1,
	mv	s7,a5	# y2, y0
	mv	a5,s6	# x0, x0
	mv	s6,a4	# x0, x2
	mv	a4,a5	# x2, x0
	j	.L208		#
	.size	fillTraingle, .-fillTraingle
	.align	2
	.globl	fillRectangle
	.type	fillRectangle, @function
fillRectangle:
	addi	sp,sp,-32	#,,
	sw	s3,12(sp)	#,
	add	a3,a3,a1	# y, tmp80, tmp90
	add	s3,a2,a0	# x, tmp84, tmp89
	sw	s2,16(sp)	#,
	slli	s3,s3,16	#, _18, tmp84
	slli	s2,a3,16	#, _21, tmp80
	sw	s0,24(sp)	#,
	sw	s4,8(sp)	#,
	sw	s5,4(sp)	#,
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
# main_seeed.c:353: {
	mv	s4,a0	# x, tmp87
	mv	s0,a1	# y, tmp88
	mv	s5,a4	# color, tmp91
	srli	s2,s2,16	#, _21, _21
	srli	s3,s3,16	#, _18, _18
.L216:
# main_seeed.c:354:     for (uint16_t i = 0; i < height; i++) {
	beq	s0,s2,.L215	#, y, _21,
# main_seeed.c:354:     for (uint16_t i = 0; i < height; i++) {
	mv	s1,s4	# ivtmp.457, x
	j	.L219		#
.L217:
# main_seeed.c:356: 	    drawPixel(x + j, y + i, color);
	mv	a0,s1	#, ivtmp.457
	addi	s1,s1,1	#, tmp81, ivtmp.457
	mv	a2,s5	#, color
	mv	a1,s0	#, y
	slli	s1,s1,16	#, ivtmp.457, tmp81
	call	drawPixel		#
	srli	s1,s1,16	#, ivtmp.457, ivtmp.457
.L219:
# main_seeed.c:355: 	for (uint16_t j = 0; j < width; j++) {
	bne	s1,s3,.L217	#, ivtmp.457, _18,
	addi	s0,s0,1	#, tmp82, y
	slli	s0,s0,16	#, y, tmp82
	srli	s0,s0,16	#, y, y
	j	.L216		#
.L215:
# main_seeed.c:359: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	lw	s5,4(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	fillRectangle, .-fillRectangle
	.align	2
	.globl	drawChar
	.type	drawChar, @function
drawChar:
	addi	sp,sp,-48	#,,
# main_seeed.c:470:     if ((ascii < 32) || (ascii >= 127)) {
	addi	a5,a0,-32	#, tmp104, ascii
# main_seeed.c:469: {
	sw	s6,16(sp)	#,
	sw	ra,44(sp)	#,
	mv	s6,a4	# color, tmp142
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s8,8(sp)	#,
# main_seeed.c:470:     if ((ascii < 32) || (ascii >= 127)) {
	andi	a5,a5,0xff	# tmp105, tmp104
	li	a4,94		# tmp106,
	bgtu	a5,a4,.L221	#, tmp105, tmp106,
	lui	s1,%hi(.LANCHOR1)	# tmp108,
	slli	a0,a0,3	#, tmp109, ascii
	addi	s1,s1,%lo(.LANCHOR1)	# tmp107, tmp108,
	mv	s2,a1	# x, tmp139
	mv	s5,a2	# y, tmp140
	mv	s3,a3	# size, tmp141
	add	s1,s1,a0	# tmp109, ivtmp.472, tmp107
	li	s4,8		# ivtmp_3,
# main_seeed.c:493: 	    if (f == FONT_Y - 1 && inrun) {
	li	s7,7		# tmp130,
.L226:
# main_seeed.c:475: 	uint8_t temp = pgm_read_byte(&simpleFont[ascii - 0x20][i]);
	lbu	s8,-256(s1)	# temp, MEM[(unsigned char *)_71 + 4294967040B]
# main_seeed.c:477: 	int8_t runlen = 0;
	li	a5,0		# runlen,
# main_seeed.c:476: 	int8_t inrun = 0;
	li	a3,0		# inrun,
# main_seeed.c:480: 	for (int8_t f = 0; f < FONT_Y; f++) {
	li	s0,0		# f,
.L225:
# main_seeed.c:481: 	    if ((temp >> f) & 0x01) {
	sra	a4,s8,s0	# f, tmp110, temp
# main_seeed.c:481: 	    if ((temp >> f) & 0x01) {
	andi	a4,a4,1	#, tmp111, tmp110
# main_seeed.c:481: 	    if ((temp >> f) & 0x01) {
	beq	a4,zero,.L223	#, tmp111,,
# main_seeed.c:482: 		if (inrun)
	beq	a3,zero,.L229	#, inrun,,
# main_seeed.c:483: 		    runlen += 1;
	addi	a5,a5,1	#, tmp113, runlen
	slli	a5,a5,24	#, runlen, tmp113
	srai	a5,a5,24	#, runlen, runlen
.L224:
# main_seeed.c:493: 	    if (f == FONT_Y - 1 && inrun) {
	li	a3,1		# inrun,
	bne	s0,s7,.L228	#, f, tmp130,
# main_seeed.c:498: 		f += 1;
	li	s0,8		# f,
.L227:
# main_seeed.c:502: 		fillRectangle(x + i * size, y + (f - runlen) * size, size,
	mul	a3,s3,a5	# tmp115, size, runlen
# main_seeed.c:502: 		fillRectangle(x + i * size, y + (f - runlen) * size, size,
	sub	a5,s0,a5	# tmp117, f, runlen
# main_seeed.c:502: 		fillRectangle(x + i * size, y + (f - runlen) * size, size,
	mv	a4,s6	#, color
	mv	a2,s3	#, size
	mv	a0,s2	#, x
	mul	a5,s3,a5	# tmp119, size, tmp117
	slli	a3,a3,16	#,, tmp115
	srli	a3,a3,16	#,,
	add	a5,s5,a5	# tmp119, tmp121, y
	slli	a1,a5,16	#,, tmp121
	srli	a1,a1,16	#,,
	call	fillRectangle		#
# main_seeed.c:505: 		runlen = 0;
	li	a5,0		# runlen,
# main_seeed.c:504: 		inrun = 0;
	li	a3,0		# inrun,
.L228:
# main_seeed.c:480: 	for (int8_t f = 0; f < FONT_Y; f++) {
	addi	s0,s0,1	#, tmp124, f
	andi	a4,s0,0xff	# _42, tmp124
	slli	s0,s0,24	#, f, tmp124
	srai	s0,s0,24	#, f, f
# main_seeed.c:480: 	for (int8_t f = 0; f < FONT_Y; f++) {
	bleu	a4,s7,.L225	#, _42, tmp130,
# main_seeed.c:474:     for (int8_t i = 0; i < FONT_X; i++) {
	addi	s4,s4,-1	#, tmp126, ivtmp_3
	add	s2,s3,s2	# x, tmp127, size
	slli	s2,s2,16	#, x, tmp127
	andi	s4,s4,0xff	# ivtmp_3, tmp126
	addi	s1,s1,1	#, ivtmp.472, ivtmp.472
	srli	s2,s2,16	#, x, x
	bne	s4,zero,.L226	#, ivtmp_3,,
.L221:
# main_seeed.c:510: }
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	lw	s1,36(sp)		#,
	lw	s2,32(sp)		#,
	lw	s3,28(sp)		#,
	lw	s4,24(sp)		#,
	lw	s5,20(sp)		#,
	lw	s6,16(sp)		#,
	lw	s7,12(sp)		#,
	lw	s8,8(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
.L229:
# main_seeed.c:486: 		    runlen = 1;
	li	a5,1		# runlen,
	j	.L224		#
.L223:
# main_seeed.c:501: 	    if (endrun) {
	bne	a3,zero,.L227	#, inrun,,
	j	.L228		#
	.size	drawChar, .-drawChar
	.align	2
	.globl	drawString
	.type	drawString, @function
drawString:
	addi	sp,sp,-48	#,,
	sw	s3,28(sp)	#,
# main_seeed.c:519: 	x += FONT_SPACE * size;
	li	s3,6		# tmp84,
	mul	s3,a3,s3	# tmp85, size, tmp84
# main_seeed.c:515: {
	sw	s5,20(sp)	#,
# main_seeed.c:521: 	    y += FONT_Y * size;
	slli	s5,a3,3	#, tmp86, size
	slli	s5,s5,16	#, _7, tmp86
# main_seeed.c:515: {
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s4,24(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
# main_seeed.c:519: 	x += FONT_SPACE * size;
	slli	s3,s3,16	#, _2, tmp85
# main_seeed.c:515: {
	sw	ra,44(sp)	#,
# main_seeed.c:515: {
	mv	s2,a0	# string, tmp94
	mv	s0,a1	# x, tmp95
	mv	s1,a2	# y, tmp96
	mv	s4,a3	# size, tmp97
	mv	s6,a4	# color, tmp98
# main_seeed.c:519: 	x += FONT_SPACE * size;
	srli	s3,s3,16	#, _2, _2
# main_seeed.c:521: 	    y += FONT_Y * size;
	srli	s5,s5,16	#, _7, _7
# main_seeed.c:520: 	if (x >= _width - 1) {
	lui	s7,%hi(_width)	# tmp92,
.L235:
# main_seeed.c:516:     while (*string) {
	lbu	a0,0(s2)	# _8, MEM[(char *)string_9]
	bne	a0,zero,.L237	#, _8,,
# main_seeed.c:525: }
	lw	ra,44(sp)		#,
	lw	s0,40(sp)		#,
	lw	s1,36(sp)		#,
	lw	s2,32(sp)		#,
	lw	s3,28(sp)		#,
	lw	s4,24(sp)		#,
	lw	s5,20(sp)		#,
	lw	s6,16(sp)		#,
	lw	s7,12(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
.L237:
# main_seeed.c:517: 	drawChar(*string, x, y, size, color);
	mv	a1,s0	#, x
	mv	a4,s6	#, color
	mv	a3,s4	#, size
	mv	a2,s1	#, y
	call	drawChar		#
# main_seeed.c:520: 	if (x >= _width - 1) {
	lhu	a5,%lo(_width)(s7)	# _width, _width
# main_seeed.c:519: 	x += FONT_SPACE * size;
	add	s0,s3,s0	# x, tmp87, _2
	slli	s0,s0,16	#, x, tmp87
	srli	s0,s0,16	#, x, x
# main_seeed.c:520: 	if (x >= _width - 1) {
	addi	a5,a5,-1	#, tmp90, _width
# main_seeed.c:518: 	*string++;
	addi	s2,s2,1	#, string, string
# main_seeed.c:520: 	if (x >= _width - 1) {
	blt	s0,a5,.L235	#, x, tmp90,
# main_seeed.c:521: 	    y += FONT_Y * size;
	add	s1,s5,s1	# y, tmp91, _7
	slli	s1,s1,16	#, y, tmp91
	srli	s1,s1,16	#, y, y
# main_seeed.c:522: 	    x = 0;
	li	s0,0		# x,
	j	.L235		#
	.size	drawString, .-drawString
	.align	2
	.globl	fillScreen
	.type	fillScreen, @function
fillScreen:
# main_seeed.c:544:     fillRectangle(0, 0, _width, _height, color);
	lui	a5,%hi(_height)	# tmp75,
	lhu	a3,%lo(_height)(a5)	#, _height
	lui	a5,%hi(_width)	# tmp77,
	lhu	a2,%lo(_width)(a5)	#, _width
# main_seeed.c:543: {
	mv	a4,a0	# tmp79, color
# main_seeed.c:544:     fillRectangle(0, 0, _width, _height, color);
	li	a1,0		#,
	li	a0,0		#,
	tail	fillRectangle		#
	.size	fillScreen, .-fillScreen
	.align	2
	.globl	drawCircle
	.type	drawCircle, @function
drawCircle:
	addi	sp,sp,-64	#,,
	sw	s0,56(sp)	#,
# main_seeed.c:363:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	li	s0,1		# tmp93,
	sub	s0,s0,a2	# tmp94, tmp93, r
# main_seeed.c:362: {
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	s4,40(sp)	#,
	sw	s5,36(sp)	#,
	sw	s7,28(sp)	#,
	sw	s9,20(sp)	#,
	sw	ra,60(sp)	#,
	sw	s2,48(sp)	#,
	sw	s6,32(sp)	#,
	sw	s8,24(sp)	#,
# main_seeed.c:362: {
	mv	s3,a0	# poX, tmp107
	mv	s4,a1	# poY, tmp108
	mv	s5,a3	# color, tmp110
# main_seeed.c:363:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	neg	s1,a2	# x, r
# main_seeed.c:363:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	slli	s0,s0,1	#, e2, tmp94
# main_seeed.c:363:     int x = -r, y = 0, err = 2 - 2 * r, e2;
	li	s7,0		# y,
# main_seeed.c:378:     while (x <= 0);
	li	s9,1		# tmp105,
.L241:
# main_seeed.c:365: 	drawPixel(poX - x, poY + y, color);
	slli	s6,s1,16	#, _3, x
	srli	s6,s6,16	#, _3, _3
	slli	s2,s7,16	#, _5, y
	srli	s2,s2,16	#, _5, _5
	sub	s8,s3,s6	# tmp95, poX, _3
	add	a1,s2,s4	# poY, tmp96, _5
	slli	s8,s8,16	#, _4, tmp95
	srli	s8,s8,16	#, _4, _4
	slli	a1,a1,16	#, _6, tmp96
	srli	a1,a1,16	#, _6, _6
	mv	a2,s5	#, color
	mv	a0,s8	#, _4
	sw	a1,8(sp)	# _6, %sfp
	call	drawPixel		#
# main_seeed.c:366: 	drawPixel(poX + x, poY + y, color);
	lw	a1,8(sp)		# _6, %sfp
	add	a0,s6,s3	# poX, tmp97, _3
	slli	a0,a0,16	#, _7, tmp97
	srli	a0,a0,16	#, _7, _7
	mv	a2,s5	#, color
	sw	a0,12(sp)	# _7, %sfp
	call	drawPixel		#
# main_seeed.c:367: 	drawPixel(poX + x, poY - y, color);
	lw	a0,12(sp)		# _7, %sfp
	sub	s2,s4,s2	# tmp98, poY, _5
	slli	a1,s2,16	#, _8, tmp98
	srli	a1,a1,16	#, _8, _8
	mv	a2,s5	#, color
	sw	a1,8(sp)	# _8, %sfp
	call	drawPixel		#
# main_seeed.c:368: 	drawPixel(poX - x, poY - y, color);
	lw	a1,8(sp)		# _8, %sfp
	mv	a2,s5	#, color
	mv	a0,s8	#, _4
	call	drawPixel		#
# main_seeed.c:370: 	if (e2 <= y) {
	blt	s7,s0,.L245	#, y, e2,
# main_seeed.c:371: 	    err += ++y * 2 + 1;
	addi	s7,s7,1	#, y, y
# main_seeed.c:371: 	    err += ++y * 2 + 1;
	slli	a5,s7,1	#, tmp99, y
# main_seeed.c:371: 	    err += ++y * 2 + 1;
	addi	a5,a5,1	#, tmp100, tmp99
# main_seeed.c:372: 	    if (-x == y && e2 <= x)
	neg	a4,s1	# tmp101, x
# main_seeed.c:371: 	    err += ++y * 2 + 1;
	add	a5,a5,s0	# e2, err, tmp100
# main_seeed.c:372: 	    if (-x == y && e2 <= x)
	bne	a4,s7,.L242	#, tmp101, y,
# main_seeed.c:372: 	    if (-x == y && e2 <= x)
	blt	s1,s0,.L243	#, x, e2,
# main_seeed.c:373: 		e2 = 0;
	li	s0,0		# e2,
.L242:
# main_seeed.c:375: 	if (e2 > x)
	bge	s1,s0,.L244	#, x, e2,
.L243:
# main_seeed.c:376: 	    err += ++x * 2 + 1;
	addi	s1,s1,1	#, x, x
# main_seeed.c:376: 	    err += ++x * 2 + 1;
	slli	a4,s1,1	#, tmp102, x
# main_seeed.c:376: 	    err += ++x * 2 + 1;
	addi	a4,a4,1	#, tmp103, tmp102
# main_seeed.c:376: 	    err += ++x * 2 + 1;
	add	a5,a5,a4	# tmp103, err, err
# main_seeed.c:378:     while (x <= 0);
	bne	s1,s9,.L244	#, x, tmp105,
# main_seeed.c:379: }
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
	addi	sp,sp,64	#,,
	jr	ra		#
.L244:
# main_seeed.c:362: {
	mv	s0,a5	# e2, err
	j	.L241		#
.L245:
	mv	a5,s0	# err, e2
	j	.L242		#
	.size	drawCircle, .-drawCircle
	.align	2
	.globl	drawBitMap
	.type	drawBitMap, @function
drawBitMap:
	addi	sp,sp,-64	#,,
	sw	s7,28(sp)	#,
# main_seeed.c:531:     uint16_t i, j, byteWidth = (width + 7) / 8;
	addi	s7,a3,7	#, tmp100, width
# main_seeed.c:530: {
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	s5,36(sp)	#,
	sw	s6,32(sp)	#,
	sw	s8,24(sp)	#,
	sw	s9,20(sp)	#,
	sw	s10,16(sp)	#,
	sw	s11,12(sp)	#,
	sw	ra,60(sp)	#,
	sw	s0,56(sp)	#,
	sw	s2,48(sp)	#,
	sw	s4,40(sp)	#,
# main_seeed.c:530: {
	mv	s8,a0	# x, tmp124
	mv	s5,a1	# y, tmp125
	mv	s6,a2	# bitmap, tmp126
	mv	s3,a3	# width, tmp127
	mv	s9,a4	# height, tmp128
	mv	s10,a5	# color, tmp129
# main_seeed.c:531:     uint16_t i, j, byteWidth = (width + 7) / 8;
	srai	s7,s7,3	#, _3, tmp100
# main_seeed.c:532:     for (j = 0; j < height; j++) {
	li	s1,0		# j,
# main_seeed.c:535: 		(128 >> (i & 7))) {
	li	s11,128		# tmp122,
.L248:
# main_seeed.c:532:     for (j = 0; j < height; j++) {
	bge	s1,s9,.L247	#, j, height,
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	mul	s2,s7,s1	# _37, _3, j
# main_seeed.c:536: 		drawPixel(x + i, y + j, color);
	add	s4,s1,s5	# y, tmp119, j
	slli	s4,s4,16	#, tmp120, tmp119
# main_seeed.c:533: 	for (i = 0; i < width; i++) {
	li	s0,0		# i,
# main_seeed.c:536: 		drawPixel(x + i, y + j, color);
	srli	s4,s4,16	#, tmp120, tmp120
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	add	s2,s6,s2	# _37, tmp117, bitmap
	j	.L252		#
.L250:
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	srli	a5,s0,3	#, tmp102, i
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	add	a5,s2,a5	# tmp102, tmp104, tmp117
	lbu	a5,0(a5)	# *_9, *_9
# main_seeed.c:535: 		(128 >> (i & 7))) {
	andi	a4,s0,7	#, tmp107, i
# main_seeed.c:535: 		(128 >> (i & 7))) {
	sra	a4,s11,a4	# tmp107, tmp108, tmp122
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	and	a5,a5,a4	# tmp108, tmp110, *_9
# main_seeed.c:534: 	    if (pgm_read_byte(bitmap + j * byteWidth + i / 8) &
	beq	a5,zero,.L249	#, tmp110,,
# main_seeed.c:536: 		drawPixel(x + i, y + j, color);
	add	a0,s0,s8	# x, tmp113, i
	slli	a0,a0,16	#,, tmp113
	mv	a2,s10	#, color
	mv	a1,s4	#, tmp120
	srli	a0,a0,16	#,,
	call	drawPixel		#
.L249:
# main_seeed.c:533: 	for (i = 0; i < width; i++) {
	addi	s0,s0,1	#, tmp115, i
	slli	s0,s0,16	#, i, tmp115
	srli	s0,s0,16	#, i, i
.L252:
# main_seeed.c:533: 	for (i = 0; i < width; i++) {
	bne	s0,s3,.L250	#, i, width,
# main_seeed.c:532:     for (j = 0; j < height; j++) {
	addi	s1,s1,1	#, tmp116, j
	slli	s1,s1,16	#, j, tmp116
	srli	s1,s1,16	#, j, j
	j	.L248		#
.L247:
# main_seeed.c:540: }
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
	.size	drawBitMap, .-drawBitMap
	.align	2
	.globl	drawLine
	.type	drawLine, @function
drawLine:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp95,
	li	a6,33		# tmp96,
	sw	a6,12(a5)	# tmp96, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a6,95		# tmp99,
	mv	a5,a0	# x0, x0
	bleu	a0,a6,.L258	#, x0, tmp99,
	li	a5,95		# x0,
.L258:
	slli	a5,a5,16	#, _27, x0
	srli	a5,a5,16	#, _27, _27
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a0,805306368		# tmp101,
	sw	a5,12(a0)	# _27, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a0,63		# tmp104,
	mv	a5,a1	# y0, y0
	bleu	a1,a0,.L259	#, y0, tmp104,
	li	a5,63		# y0,
.L259:
	slli	a5,a5,16	#, _26, y0
	srli	a5,a5,16	#, _26, _26
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a1,805306368		# tmp106,
	sw	a5,12(a1)	# _26, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a1,95		# tmp109,
	mv	a5,a2	# x1, x1
	bleu	a2,a1,.L260	#, x1, tmp109,
	li	a5,95		# x1,
.L260:
	slli	a5,a5,16	#, _25, x1
	srli	a5,a5,16	#, _25, _25
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a2,805306368		# tmp111,
	sw	a5,12(a2)	# _25, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a2,63		# tmp114,
	mv	a5,a3	# y1, y1
	bleu	a3,a2,.L261	#, y1, tmp114,
	li	a5,63		# y1,
.L261:
	slli	a3,a5,16	#, _24, y1
	srli	a3,a3,16	#, _24, _24
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp116,
	sw	a3,12(a5)	# _24, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	srli	a3,a4,11	#, _23, color
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a3,12(a5)	# _23, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:657:     _sendCmd((uint8_t) ((color >> 5) & 0x3F));	//G
	srli	a3,a4,5	#, tmp120, color
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a3,a3,63	#, _22, tmp120
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a3,12(a5)	# _22, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a4,a4,31	#, _21, color
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a4,12(a5)	# _21, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:659: }
	ret	
	.size	drawLine, .-drawLine
	.align	2
	.globl	drawFrame
	.type	drawFrame, @function
drawFrame:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a6,805306368		# tmp105,
	li	a7,38		# tmp106,
	sw	a7,12(a6)	# tmp106, MEM[(volatile uint32_t *)805306380B]
	li	a7,1		# tmp109,
	sw	a7,12(a6)	# tmp109, MEM[(volatile uint32_t *)805306380B]
	li	a7,34		# tmp112,
	sw	a7,12(a6)	# tmp112, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a7,95		# tmp115,
	mv	a6,a0	# x0, x0
	bleu	a0,a7,.L263	#, x0, tmp115,
	li	a6,95		# x0,
.L263:
	slli	a6,a6,16	#, _37, x0
	srli	a6,a6,16	#, _37, _37
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a0,805306368		# tmp117,
	sw	a6,12(a0)	# _37, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a6,63		# tmp120,
	mv	a0,a1	# y0, y0
	bleu	a1,a6,.L264	#, y0, tmp120,
	li	a0,63		# y0,
.L264:
	slli	a0,a0,16	#, _36, y0
	srli	a0,a0,16	#, _36, _36
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a1,805306368		# tmp122,
	sw	a0,12(a1)	# _36, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a0,95		# tmp125,
	mv	a1,a2	# x1, x1
	bleu	a2,a0,.L265	#, x1, tmp125,
	li	a1,95		# x1,
.L265:
	slli	a1,a1,16	#, _35, x1
	srli	a1,a1,16	#, _35, _35
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a2,805306368		# tmp127,
	sw	a1,12(a2)	# _35, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a1,63		# tmp130,
	mv	a2,a3	# y1, y1
	bleu	a3,a1,.L266	#, y1, tmp130,
	li	a2,63		# y1,
.L266:
	slli	a2,a2,16	#, _34, y1
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a3,805306368		# tmp132,
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	srli	a2,a2,16	#, _34, _34
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a3)	# _34, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	srli	a2,a4,11	#, _33, outColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a3)	# _33, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:685:     _sendCmd((uint8_t) ((outColor >> 5) & 0x3F));	//G
	srli	a2,a4,5	#, tmp136, outColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a2,a2,63	#, _32, tmp136
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a3)	# _32, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a4,a4,31	#, _31, outColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a4,12(a3)	# _31, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	srli	a4,a5,11	#, _30, fillColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a4,12(a3)	# _30, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:688:     _sendCmd((uint8_t) ((fillColor >> 5) & 0x3F));	//G
	srli	a4,a5,5	#, tmp148, fillColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a4,a4,63	#, _29, tmp148
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a4,12(a3)	# _29, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a5,a5,31	#, _28, fillColor
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a5,12(a3)	# _28, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:690: }
	ret	
	.size	drawFrame, .-drawFrame
	.align	2
	.globl	copyWindow
	.type	copyWindow, @function
copyWindow:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a6,805306368		# tmp91,
	li	a7,35		# tmp92,
	sw	a7,12(a6)	# tmp92, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a0,a0,0xff	# _19, tmp105
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a0,12(a6)	# _19, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a1,a1,0xff	# _18, tmp106
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a1,12(a6)	# _18, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a2,a2,0xff	# _17, tmp107
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a6)	# _17, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a3,a3,0xff	# _16, tmp108
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a3,12(a6)	# _16, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a4,a4,0xff	# _15, tmp109
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a4,12(a6)	# _15, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a5,a5,0xff	# _14, tmp110
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a5,12(a6)	# _14, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:703: }
	ret	
	.size	copyWindow, .-copyWindow
	.align	2
	.globl	dimWindow
	.type	dimWindow, @function
dimWindow:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp85,
	li	a4,36		# tmp86,
	sw	a4,12(a5)	# tmp86, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a0,a0,0xff	# _13, tmp95
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a0,12(a5)	# _13, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a1,a1,0xff	# _12, tmp96
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a1,12(a5)	# _12, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a2,a2,0xff	# _11, tmp97
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a5)	# _11, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a3,a3,0xff	# _10, tmp98
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a3,12(a5)	# _10, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:712: }
	ret	
	.size	dimWindow, .-dimWindow
	.align	2
	.globl	clearWindow
	.type	clearWindow, @function
clearWindow:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp85,
	li	a4,37		# tmp86,
	sw	a4,12(a5)	# tmp86, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a0,a0,0xff	# _13, tmp95
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a0,12(a5)	# _13, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a1,a1,0xff	# _12, tmp96
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a1,12(a5)	# _12, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a2,a2,0xff	# _11, tmp97
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a2,12(a5)	# _11, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	andi	a3,a3,0xff	# _10, tmp98
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	sw	a3,12(a5)	# _10, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:721: }
	ret	
	.size	clearWindow, .-clearWindow
	.align	2
	.globl	setScolling
	.type	setScolling, @function
setScolling:
	li	a5,2		# tmp83,
	bgtu	a0,a5,.L272	#, direction, tmp83,
	lui	a5,%hi(CSWTCH.183)	# tmp84,
	addi	a5,a5,%lo(CSWTCH.183)	# tmp86, tmp84,
	add	a5,a0,a5	# tmp86, tmp85, direction
	lbu	a6,0(a5)	# scolling_horizontal, CSWTCH.183[direction_5(D)]
	lui	a5,%hi(CSWTCH.184)	# tmp87,
	addi	a5,a5,%lo(CSWTCH.184)	# tmp89, tmp87,
	add	a0,a0,a5	# tmp89, tmp88, direction
	lbu	a4,0(a0)	# scolling_vertical, CSWTCH.184[direction_5(D)]
.L271:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp91,
	li	a0,39		# tmp92,
	sw	a0,12(a5)	# tmp92, MEM[(volatile uint32_t *)805306380B]
	sw	a6,12(a5)	# scolling_horizontal, MEM[(volatile uint32_t *)805306380B]
	sw	a1,12(a5)	# rowAddr, MEM[(volatile uint32_t *)805306380B]
	sw	a2,12(a5)	# rowNum, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# scolling_vertical, MEM[(volatile uint32_t *)805306380B]
	sw	a3,12(a5)	# timeInterval, MEM[(volatile uint32_t *)805306380B]
	li	a4,47		# tmp105,
	sw	a4,12(a5)	# tmp105, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:752: }
	ret	
.L272:
# main_seeed.c:726: {
	li	a4,0		# scolling_vertical,
	li	a6,0		# scolling_horizontal,
	j	.L271		#
	.size	setScolling, .-setScolling
	.align	2
	.globl	enableScolling
	.type	enableScolling, @function
enableScolling:
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp74,
	li	a4,47		# tmp75,
# main_seeed.c:756:     if (enable)
	bne	a0,zero,.L276	#, tmp79,,
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a4,46		# tmp78,
.L276:
	sw	a4,12(a5)	# tmp78,
# main_seeed.c:760: }
	ret	
	.size	enableScolling, .-enableScolling
	.align	2
	.globl	setDisplayMode
	.type	setDisplayMode, @function
setDisplayMode:
	andi	a0,a0,0xff	# _3, tmp76
# main_seeed.c:552:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp75,
	sw	a0,12(a5)	# _3, MEM[(volatile uint32_t *)805306380B]
# main_seeed.c:765: }
	ret	
	.size	setDisplayMode, .-setDisplayMode
	.align	2
	.globl	setDisplayPower
	.type	setDisplayPower, @function
setDisplayPower:
	andi	a0,a0,0xff	# _4, tmp76
	li	a5,805306368		# tmp75,
	sw	a0,12(a5)	# _4, MEM[(volatile uint32_t *)805306380B]
	ret	
	.size	setDisplayPower, .-setDisplayPower
	.align	2
	.globl	setup
	.type	setup, @function
setup:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# main_seeed.c:780:     init();
	call	init		#
# main_seeed.c:782: }
	lw	ra,12(sp)		#,
# main_seeed.c:781:     fillScreen(COLOR_BLACK);
	li	a0,0		#,
# main_seeed.c:782: }
	addi	sp,sp,16	#,,
# main_seeed.c:781:     fillScreen(COLOR_BLACK);
	tail	fillScreen		#
	.size	setup, .-setup
	.section	.rodata.str1.4
	.align	2
.LC1:
	.string	"run..."
	.align	2
.LC2:
	.string	"Seeed"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96	#,,
# main_seeed.c:797:             drawBitMap(0, 0, SeeedLogo, 96, 64, COLOR_YELLOW);
	lui	a5,%hi(.LANCHOR1+768)	# tmp127,
# main_seeed.c:785: {
	sw	s0,88(sp)	#,
	sw	s2,80(sp)	#,
	sw	s4,72(sp)	#,
	sw	s6,64(sp)	#,
# main_seeed.c:789:         delay(450000);
	li	s0,450560		# tmp220,
# main_seeed.c:794:             delay(45000000);
	li	s2,44998656		# tmp221,
# main_seeed.c:797:             drawBitMap(0, 0, SeeedLogo, 96, 64, COLOR_YELLOW);
	addi	a5,a5,%lo(.LANCHOR1+768)	# tmp129, tmp127,
	li	s4,65536		# tmp130,
# main_seeed.c:812:             drawCircle(48, 32, i, COLOR_PURPLE);
	li	s6,40960		# tmp136,
# main_seeed.c:785: {
	sw	s1,84(sp)	#,
	sw	s3,76(sp)	#,
	sw	s5,68(sp)	#,
	sw	ra,92(sp)	#,
	sw	s7,60(sp)	#,
	sw	s8,56(sp)	#,
	sw	s9,52(sp)	#,
	sw	s10,48(sp)	#,
	sw	s11,44(sp)	#,
# main_seeed.c:789:         delay(450000);
	addi	s0,s0,-560	#, tmp220, tmp220
	li	s1,0		#,
# main_seeed.c:794:             delay(45000000);
	addi	s2,s2,1344	#, tmp221, tmp221
	li	s3,0		#,
# main_seeed.c:797:             drawBitMap(0, 0, SeeedLogo, 96, 64, COLOR_YELLOW);
	sw	a5,12(sp)	# tmp129, %sfp
	addi	s5,s4,-32	#, tmp222, tmp130
# main_seeed.c:812:             drawCircle(48, 32, i, COLOR_PURPLE);
	addi	s6,s6,286	#, tmp215, tmp136
.L291:
# main_seeed.c:787:         print_str_ln("run...");
	lui	a5,%hi(.LC1)	# tmp232,
	addi	a0,a5,%lo(.LC1)	#, tmp232,
	call	print_str_ln		#
# main_seeed.c:788:         setup();
	call	setup		#
# main_seeed.c:789:         delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:790:         drawString("Seeed", 15, 25, 2, COLOR_GREEN);
	lui	a5,%hi(.LC2)	# tmp233,
	addi	a0,a5,%lo(.LC2)	#, tmp233,
	li	a4,2016		#,
	li	a3,2		#,
	li	a2,25		#,
	li	a1,15		#,
	call	drawString		#
# main_seeed.c:791:         delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:793:             setScolling(Horizontal, 0, 64, 1);
	li	a3,1		#,
	li	a2,64		#,
	li	a1,0		#,
	li	a0,0		#,
	call	setScolling		#
# main_seeed.c:794:             delay(45000000);
	mv	a0,s2	#, tmp221
	mv	a1,s3	#,
	call	wait_cycles		#
# main_seeed.c:795:             delay(45000000);
	mv	a0,s2	#, tmp221
	mv	a1,s3	#,
	call	wait_cycles		#
# main_seeed.c:796:         setup();
	call	setup		#
# main_seeed.c:797:             drawBitMap(0, 0, SeeedLogo, 96, 64, COLOR_YELLOW);
	lw	a2,12(sp)		#, %sfp
	mv	a5,s5	#, tmp222
	li	a4,64		#,
	li	a3,96		#,
	li	a1,0		#,
	li	a0,0		#,
	call	drawBitMap		#
# main_seeed.c:798:             setScolling(Vertical, 0, 64, 0);
	li	a3,0		#,
	li	a2,64		#,
	li	a1,0		#,
	li	a0,1		#,
	call	setScolling		#
# main_seeed.c:799:             delay(45000000);
	mv	a0,s2	#, tmp221
	mv	a1,s3	#,
	call	wait_cycles		#
# main_seeed.c:800:             delay(45000000);
	mv	a0,s2	#, tmp221
	mv	a1,s3	#,
	call	wait_cycles		#
# main_seeed.c:803:         for (int i = 30; i > 0; i--) {
	li	s7,30		# i,
# main_seeed.c:801:         setup();
	call	setup		#
.L282:
# main_seeed.c:804:             drawCircle(48, 32, i, COLOR_CYAN);
	slli	a2,s7,16	#,, i
	li	a3,2047		#,
	srli	a2,a2,16	#,,
	li	a1,32		#,
	li	a0,48		#,
	call	drawCircle		#
# main_seeed.c:805:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
# main_seeed.c:803:         for (int i = 30; i > 0; i--) {
	addi	s7,s7,-1	#, i, i
# main_seeed.c:805:             delay(450000);
	call	wait_cycles		#
# main_seeed.c:803:         for (int i = 30; i > 0; i--) {
	bne	s7,zero,.L282	#, i,,
# main_seeed.c:807:         for (int i = 1; i <= 30; i++) {
	li	s7,1		# i,
# main_seeed.c:808:             drawCircle(48, 32, i, COLOR_RED);
	addi	s9,s4,-2048	#, tmp217, tmp130
# main_seeed.c:807:         for (int i = 1; i <= 30; i++) {
	li	s8,31		# tmp134,
.L283:
# main_seeed.c:808:             drawCircle(48, 32, i, COLOR_RED);
	slli	a2,s7,16	#,, i
	mv	a3,s9	#, tmp217
	srli	a2,a2,16	#,,
	li	a1,32		#,
	li	a0,48		#,
	call	drawCircle		#
# main_seeed.c:809:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
# main_seeed.c:807:         for (int i = 1; i <= 30; i++) {
	addi	s7,s7,1	#, i, i
# main_seeed.c:809:             delay(450000);
	call	wait_cycles		#
# main_seeed.c:807:         for (int i = 1; i <= 30; i++) {
	bne	s7,s8,.L283	#, i, tmp134,
# main_seeed.c:811:         for (int i = 30; i > 0; i--) {
	li	s7,30		# i,
.L284:
# main_seeed.c:812:             drawCircle(48, 32, i, COLOR_PURPLE);
	slli	a2,s7,16	#,, i
	mv	a3,s6	#, tmp215
	srli	a2,a2,16	#,,
	li	a1,32		#,
	li	a0,48		#,
	call	drawCircle		#
# main_seeed.c:813:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
# main_seeed.c:811:         for (int i = 30; i > 0; i--) {
	addi	s7,s7,-1	#, i, i
# main_seeed.c:813:             delay(450000);
	call	wait_cycles		#
# main_seeed.c:811:         for (int i = 30; i > 0; i--) {
	bne	s7,zero,.L284	#, i,,
# main_seeed.c:815:         for (int i = 1; i <= 30; i++) {
	li	s7,1		# i,
# main_seeed.c:816:             drawCircle(48, 32, i, COLOR_GOLDEN);
	addi	s9,s4,-352	#, tmp213, tmp130
# main_seeed.c:815:         for (int i = 1; i <= 30; i++) {
	li	s8,31		# tmp139,
.L285:
# main_seeed.c:816:             drawCircle(48, 32, i, COLOR_GOLDEN);
	slli	a2,s7,16	#,, i
	mv	a3,s9	#, tmp213
	srli	a2,a2,16	#,,
	li	a1,32		#,
	li	a0,48		#,
	call	drawCircle		#
# main_seeed.c:817:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
# main_seeed.c:815:         for (int i = 1; i <= 30; i++) {
	addi	s7,s7,1	#, i, i
# main_seeed.c:817:             delay(450000);
	call	wait_cycles		#
# main_seeed.c:815:         for (int i = 1; i <= 30; i++) {
	bne	s7,s8,.L285	#, i, tmp139,
# main_seeed.c:819:         setup();
	call	setup		#
	li	s9,100		# ivtmp_40,
# main_seeed.c:827:             uint8_t y2 = rand() % 64;
	li	s11,64		# tmp145,
# main_seeed.c:826:             uint8_t x2 = rand() % 96;
	li	s10,96		# tmp150,
.L286:
# main_seeed.c:822:             uint8_t x0 = rand() % 96;
	call	rand		#
	sw	a0,28(sp)	# _5, %sfp
# main_seeed.c:823:             uint8_t y0 = rand() % 64;
	call	rand		#
	sw	a0,24(sp)	# _7, %sfp
# main_seeed.c:824:             uint8_t x1 = rand() % 96;
	call	rand		#
	sw	a0,20(sp)	# _9, %sfp
# main_seeed.c:825:             uint8_t y1 = rand() % 64;
	call	rand		#
	sw	a0,16(sp)	# _11, %sfp
# main_seeed.c:826:             uint8_t x2 = rand() % 96;
	call	rand		#
	mv	s7,a0	# _13, tmp227
# main_seeed.c:827:             uint8_t y2 = rand() % 64;
	call	rand		#
	mv	s8,a0	# _15, tmp228
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	call	rand		#
# main_seeed.c:822:             uint8_t x0 = rand() % 96;
	lw	a7,28(sp)		# _5, %sfp
# main_seeed.c:825:             uint8_t y1 = rand() % 64;
	lw	a3,16(sp)		# _11, %sfp
# main_seeed.c:824:             uint8_t x1 = rand() % 96;
	lw	a2,20(sp)		# _9, %sfp
# main_seeed.c:823:             uint8_t y0 = rand() % 64;
	lw	a1,24(sp)		# _7, %sfp
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	rem	a6,a0,s4	# tmp130, tmp142, tmp229
# main_seeed.c:821:         for (int i = 0; i < 100; i++) {
	addi	s9,s9,-1	#, ivtmp_40, ivtmp_40
# main_seeed.c:822:             uint8_t x0 = rand() % 96;
	rem	a0,a7,s10	# tmp150, tmp171, _5
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	slli	a6,a6,16	#,, tmp142
	srli	a6,a6,16	#,,
# main_seeed.c:827:             uint8_t y2 = rand() % 64;
	rem	a5,s8,s11	# tmp145, tmp146, _15
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	andi	a0,a0,0xff	#, tmp171
# main_seeed.c:826:             uint8_t x2 = rand() % 96;
	rem	a4,s7,s10	# tmp150, tmp151, _13
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	andi	a5,a5,0xff	#, tmp146
# main_seeed.c:825:             uint8_t y1 = rand() % 64;
	rem	a3,a3,s11	# tmp145, tmp156, _11
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	andi	a4,a4,0xff	#, tmp151
# main_seeed.c:824:             uint8_t x1 = rand() % 96;
	rem	a2,a2,s10	# tmp150, tmp161, _9
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	andi	a3,a3,0xff	#, tmp156
# main_seeed.c:823:             uint8_t y0 = rand() % 64;
	rem	a1,a1,s11	# tmp145, tmp166, _7
# main_seeed.c:828:             drawTraingle(x0, y0, x1, y1, x2, y2, rand() % 65536);
	andi	a2,a2,0xff	#, tmp161
	andi	a1,a1,0xff	#, tmp166
	call	drawTraingle		#
# main_seeed.c:830:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:821:         for (int i = 0; i < 100; i++) {
	bne	s9,zero,.L286	#, ivtmp_40,,
# main_seeed.c:832:         setup();
	call	setup		#
	li	s7,5		# ivtmp_137,
# main_seeed.c:835:           drawRectangle(3 * i, 2 * i, 95 - 6 * i, 63 - 4 * i,
	li	s8,-4		# tmp174,
	li	s9,-6		# tmp179,
	li	s10,3		# tmp186,
# main_seeed.c:834:             for (int i = 1; i < 16; i++) {
	li	s11,16		# tmp190,
.L287:
# main_seeed.c:834:             for (int i = 1; i < 16; i++) {
	li	a5,1		# i,
.L288:
	slli	a0,a5,16	#, _130, i
	srli	a0,a0,16	#, _130, _130
# main_seeed.c:835:           drawRectangle(3 * i, 2 * i, 95 - 6 * i, 63 - 4 * i,
	mul	a3,a0,s8	# tmp175, _130, tmp174
	slli	a1,a0,1	#, tmp184, _130
	slli	a1,a1,16	#, tmp185, tmp184
	srli	a1,a1,16	#, tmp185, tmp185
	mv	a4,s5	#, tmp222
	sw	a5,16(sp)	# i, %sfp
	mul	a2,a0,s9	# tmp180, _130, tmp179
	addi	a3,a3,63	#, tmp177, tmp175
	slli	a3,a3,16	#,, tmp177
	srli	a3,a3,16	#,,
	mul	a0,a0,s10	# tmp187, _130, tmp186
	addi	a2,a2,95	#, tmp182, tmp180
	slli	a2,a2,16	#,, tmp182
	srli	a2,a2,16	#,,
	slli	a0,a0,16	#,, tmp187
	srli	a0,a0,16	#,,
	call	drawRectangle		#
# main_seeed.c:837:           delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:834:             for (int i = 1; i < 16; i++) {
	lw	a5,16(sp)		# i, %sfp
	addi	a5,a5,1	#, i, i
# main_seeed.c:834:             for (int i = 1; i < 16; i++) {
	bne	a5,s11,.L288	#, i, tmp190,
# main_seeed.c:839:             delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:840:             for (int i = 15; i > 0; i--) {
	li	a5,15		# i,
.L289:
	slli	a0,a5,16	#, _132, i
	srli	a0,a0,16	#, _132, _132
# main_seeed.c:841:           drawRectangle(3 * i, 2 * i, 95 - 6 * i, 63 - 4 * i,
	mul	a3,a0,s8	# tmp192, _132, tmp174
	slli	a1,a0,1	#, tmp201, _132
	slli	a1,a1,16	#, tmp202, tmp201
	srli	a1,a1,16	#, tmp202, tmp202
	li	a4,31		#,
	sw	a5,16(sp)	# i, %sfp
	mul	a2,a0,s9	# tmp197, _132, tmp179
	addi	a3,a3,63	#, tmp194, tmp192
	slli	a3,a3,16	#,, tmp194
	srli	a3,a3,16	#,,
	mul	a0,a0,s10	# tmp204, _132, tmp186
	addi	a2,a2,95	#, tmp199, tmp197
	slli	a2,a2,16	#,, tmp199
	srli	a2,a2,16	#,,
	slli	a0,a0,16	#,, tmp204
	srli	a0,a0,16	#,,
	call	drawRectangle		#
# main_seeed.c:843:           delay(450000);
	mv	a0,s0	#, tmp220
	mv	a1,s1	#,
	call	wait_cycles		#
# main_seeed.c:840:             for (int i = 15; i > 0; i--) {
	lw	a5,16(sp)		# i, %sfp
	addi	a5,a5,-1	#, i, i
# main_seeed.c:840:             for (int i = 15; i > 0; i--) {
	bne	a5,zero,.L289	#, i,,
# main_seeed.c:845:             delay(200000);
	li	a0,200704		#,
	addi	a0,a0,-704	#,,
	li	a1,0		#,
# main_seeed.c:833:         for (int i = 0; i < 5; i++) {
	addi	s7,s7,-1	#, ivtmp_137, ivtmp_137
# main_seeed.c:845:             delay(200000);
	call	wait_cycles		#
# main_seeed.c:833:         for (int i = 0; i < 5; i++) {
	bne	s7,zero,.L287	#, ivtmp_137,,
# main_seeed.c:848:         setup();
	call	setup		#
# main_seeed.c:849:         delay(2000);
	li	a0,2000		#,
	li	a1,0		#,
	call	wait_cycles		#
# main_seeed.c:850:             drawLine(5, 7, 65, 48, COLOR_BLUE);
	li	a4,31		#,
	li	a3,48		#,
	li	a2,65		#,
	li	a1,7		#,
	li	a0,5		#,
	call	drawLine		#
# main_seeed.c:851:             delay(4500000);
	li	a0,4501504		#,
	addi	a0,a0,-1504	#,,
	li	a1,0		#,
	call	wait_cycles		#
# main_seeed.c:852:             drawLine(5, 40, 48, 7, COLOR_RED);
	addi	a4,s4,-2048	#,, tmp130
	li	a3,7		#,
	li	a2,48		#,
	li	a1,40		#,
	li	a0,5		#,
	call	drawLine		#
# main_seeed.c:853:             delay(4500000);
	li	a0,4501504		#,
	addi	a0,a0,-1504	#,,
	li	a1,0		#,
	call	wait_cycles		#
# main_seeed.c:854:             drawLine(65, 5, 47, 50, COLOR_GREEN);
	li	a4,2016		#,
	li	a3,50		#,
	li	a2,47		#,
	li	a1,5		#,
	li	a0,65		#,
	call	drawLine		#
# main_seeed.c:855:             delay(4500000);
	li	a0,4501504		#,
	addi	a0,a0,-1504	#,,
	li	a1,0		#,
	call	wait_cycles		#
# main_seeed.c:856:             drawLine(3, 10, 80, 21, COLOR_YELLOW);
	mv	a4,s5	#, tmp222
	li	a3,21		#,
	li	a2,80		#,
	li	a1,10		#,
	li	a0,3		#,
	call	drawLine		#
# main_seeed.c:857:         delay(45000000);
	mv	a0,s2	#, tmp221
	mv	a1,s3	#,
	call	wait_cycles		#
# main_seeed.c:787:         print_str_ln("run...");
	j	.L291		#
	.size	main, .-main
	.globl	_height
	.globl	_width
	.globl	simpleFont
	.globl	SeeedLogo
	.globl	heap_memory_used
	.globl	heap_memory
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	simpleFont, @object
	.size	simpleFont, 768
simpleFont:
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"_"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\007"
	.string	"\007"
	.string	""
	.string	""
	.string	""
	.string	"\024\177\024\177\024"
	.string	""
	.string	""
	.string	"$*\177*\022"
	.string	""
	.string	""
	.string	"#\023\bdb"
	.string	""
	.string	""
	.string	"6IU\"P"
	.string	""
	.string	""
	.string	""
	.string	"\005\003"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\034\"A"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"A\"\034"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\b*\034*\b"
	.string	""
	.string	""
	.string	"\b\b>\b\b"
	.string	""
	.string	""
	.string	"\240`"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\b\b\b\b\b"
	.string	""
	.string	""
	.string	"``"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	" \020\b\004\002"
	.string	""
	.string	""
	.string	">QIE>"
	.string	""
	.string	""
	.string	""
	.string	"B\177@"
	.string	""
	.string	""
	.string	""
	.string	"bQIIF"
	.string	""
	.string	""
	.string	"\"AII6"
	.string	""
	.string	""
	.string	"\030\024\022\177\020"
	.string	""
	.string	""
	.string	"'EEE9"
	.string	""
	.string	""
	.string	"<JII0"
	.string	""
	.string	""
	.string	"\001q\t\005\003"
	.string	""
	.string	""
	.string	"6III6"
	.string	""
	.string	""
	.string	"\006II)\036"
	.string	""
	.string	""
	.string	""
	.string	"66"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\254l"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\b\024\"A"
	.string	""
	.string	""
	.string	""
	.string	"\024\024\024\024\024"
	.string	""
	.string	""
	.string	"A\"\024\b"
	.string	""
	.string	""
	.string	""
	.string	"\002\001Q\t\006"
	.string	""
	.string	""
	.string	"2IyA>"
	.string	""
	.string	""
	.string	"~\t\t\t~"
	.string	""
	.string	""
	.string	"\177III6"
	.string	""
	.string	""
	.string	">AAA\""
	.string	""
	.string	""
	.string	"\177AA\"\034"
	.string	""
	.string	""
	.string	"\177IIIA"
	.string	""
	.string	""
	.string	"\177\t\t\t\001"
	.string	""
	.string	""
	.string	">AAQr"
	.string	""
	.string	""
	.string	"\177\b\b\b\177"
	.string	""
	.string	""
	.string	"A\177A"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	" @A?\001"
	.string	""
	.string	""
	.string	"\177\b\024\"A"
	.string	""
	.string	""
	.string	"\177@@@@"
	.string	""
	.string	""
	.string	"\177\002\f\002\177"
	.string	""
	.string	""
	.string	"\177\004\b\020\177"
	.string	""
	.string	""
	.string	">AAA>"
	.string	""
	.string	""
	.string	"\177\t\t\t\006"
	.string	""
	.string	""
	.string	">AQ!^"
	.string	""
	.string	""
	.string	"\177\t\031)F"
	.string	""
	.string	""
	.string	"&III2"
	.string	""
	.string	""
	.string	"\001\001\177\001\001"
	.string	""
	.string	""
	.string	"?@@@?"
	.string	""
	.string	""
	.string	"\037 @ \037"
	.string	""
	.string	""
	.string	"?@8@?"
	.string	""
	.string	""
	.string	"c\024\b\024c"
	.string	""
	.string	""
	.string	"\003\004x\004\003"
	.string	""
	.string	""
	.string	"aQIEC"
	.string	""
	.string	""
	.string	"\177AA"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\002\004\b\020 "
	.string	""
	.string	""
	.string	"AA\177"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\004\002\001\002\004"
	.string	""
	.string	""
	.string	"\200\200\200\200\200"
	.string	""
	.string	""
	.string	"\001\002\004"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	" TTTx"
	.string	""
	.string	""
	.string	"\177HDD8"
	.string	""
	.string	""
	.string	"8DD("
	.string	""
	.string	""
	.string	""
	.string	"8DDH\177"
	.string	""
	.string	""
	.string	"8TTT\030"
	.string	""
	.string	""
	.string	"\b~\t\002"
	.string	""
	.string	""
	.string	""
	.string	"\030\244\244\244|"
	.string	""
	.string	""
	.string	"\177\b\004\004x"
	.string	""
	.string	""
	.string	""
	.string	"}"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\200\204}"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\177\020(D"
	.string	""
	.string	""
	.string	""
	.string	"A\177@"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"|\004\030\004x"
	.string	""
	.string	""
	.string	"|\b\004|"
	.string	""
	.string	""
	.string	""
	.string	"8DD8"
	.string	""
	.string	""
	.string	""
	.string	"\374$$\030"
	.string	""
	.string	""
	.string	""
	.string	"\030$$\374"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"|\b\004"
	.string	""
	.string	""
	.string	""
	.string	"HTT$"
	.string	""
	.string	""
	.string	""
	.string	"\004\177D"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"<@@|"
	.string	""
	.string	""
	.string	""
	.string	"\034 @ \034"
	.string	""
	.string	""
	.string	"<@0@<"
	.string	""
	.string	""
	.string	"D(\020(D"
	.string	""
	.string	""
	.string	"\034\240\240|"
	.string	""
	.string	""
	.string	""
	.string	"DdTLD"
	.string	""
	.string	""
	.string	"\b6A"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\177"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"A6\b"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\002\001\001\002\001"
	.string	""
	.string	""
	.string	"\002\005\005\002"
	.string	""
	.string	""
	.type	SeeedLogo, @object
	.size	SeeedLogo, 768
SeeedLogo:
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\200\004"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\200\006"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\003\200\007"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\007"
	.string	"\003\200"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\017"
	.string	"\003\300"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\036"
	.string	"\001\340"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\036"
	.string	"\001\340"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	">"
	.string	"\001\360"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	">"
	.string	"\001\370"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"|"
	.string	""
	.string	"\370"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\030"
	.string	"|"
	.string	""
	.string	"\370"
	.string	"`"
	.string	""
	.string	""
	.string	""
	.string	"\030"
	.string	"\374"
	.string	""
	.string	"\374"
	.string	"`"
	.string	""
	.string	""
	.string	""
	.string	"\030"
	.string	"\374"
	.string	""
	.string	"\374"
	.string	"`"
	.string	""
	.string	""
	.string	""
	.string	"\034"
	.string	"\374"
	.string	""
	.string	"\374"
	.string	"`"
	.string	""
	.string	""
	.string	""
	.string	"\034"
	.string	"\374"
	.string	""
	.string	"\374"
	.string	"\340"
	.string	""
	.string	""
	.string	""
	.string	"\034"
	.string	"\374"
	.string	""
	.string	"\374"
	.string	"\360"
	.string	""
	.string	""
	.string	""
	.string	"\036"
	.string	"\374"
	.string	""
	.string	"\374\001\360"
	.string	""
	.string	""
	.string	""
	.string	"\036"
	.string	"\374"
	.string	""
	.string	"\374\001\340"
	.string	""
	.string	""
	.string	""
	.string	"\036"
	.string	"\374"
	.string	""
	.string	"\374\001\340"
	.string	""
	.string	""
	.string	""
	.string	"\037"
	.string	"\374"
	.string	""
	.string	"\374\003\340"
	.string	""
	.string	""
	.string	""
	.string	"\037\200\374"
	.string	""
	.string	"\374\003\340"
	.string	""
	.string	""
	.string	""
	.string	"\037\200\376"
	.string	""
	.string	"\374\007\340"
	.string	""
	.string	""
	.string	""
	.string	"\017\300~"
	.string	"\001\374\017\340"
	.string	""
	.string	""
	.string	""
	.string	"\017\300~"
	.string	"\001\370\017\300"
	.string	""
	.string	""
	.string	""
	.string	"\017\340~"
	.string	"\001\370\037\300"
	.string	""
	.string	""
	.string	""
	.string	"\007\360?"
	.string	"\001\360?\200"
	.string	""
	.string	""
	.string	""
	.string	"\007\360?"
	.string	"\003\360?\200"
	.string	""
	.string	""
	.string	""
	.string	"\003\370\037"
	.string	"\003\340\177"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\374\037\200\007\340\376"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\376\017\200\007\301\376"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\377\007\300\007\203\374"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\177\203\300\017\007\370"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"?\301\340\016\017\360"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\037\360\340\034\037\340"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\007\370p8\177\200"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\003\37480\377"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\377"
	.string	"\003\374"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"?\200\007\360"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\017\360?\300"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\001\370~"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\b@"
	.string	""
	.string	""
	.string	"<"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"<"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"<"
	.string	""
	.string	"\003\360\017\300\017\300\017\200\037\274"
	.string	""
	.string	"\017\370?\360?\360?\340\177\374"
	.string	""
	.string	"\037\374\177\370\177\370\177\370\377\374"
	.string	""
	.string	"\037~\376\374\375\374\375\375\375\374"
	.string	""
	.string	"\036\036\360?\360=\340=\340|"
	.string	""
	.string	"\037\361\377\377\377\377\377\375\340<"
	.string	""
	.string	"\017\375\377\377\377\377\377\375\300<"
	.string	""
	.string	"\003\377\377\377\377\377\377\375\300<"
	.string	""
	.string	"<\036\3601\360!\340!\340|"
	.string	""
	.string	"?>\376\374\374\370\375\371\375\374"
	.string	""
	.string	"\037\376\177\374\177\370\177\370\377\374"
	.string	""
	.string	"\017\374?\360?\360?\340\177\374"
	.string	""
	.string	"\003\360\017\300\017\300\017\200\037\274"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	"\037d\315\366\341\311??\373\246"
	.string	""
	.string	"\037\377\357\377\377\377\277\377\377\376"
	.string	""
	.string	"\037\377\357\377\377\377\277\377\377\374"
	.string	""
	.string	"\037\377\355\377\377\377\267\377\377\374"
	.string	""
	.string	""
	.string	"\300"
	.string	" "
	.string	"\001"
	.string	""
	.string	"\b"
	.string	""
	.string	""
	.string	""
	.string	"\200"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory, @object
	.size	heap_memory, 1024
heap_memory:
	.zero	1024
	.section	.sbss,"aw",@nobits
	.align	2
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.section	.sdata,"aw"
	.align	1
	.type	_height, @object
	.size	_height, 2
_height:
	.half	64
	.type	_width, @object
	.size	_width, 2
_width:
	.half	96
	.section	.srodata,"a"
	.align	2
	.type	CSWTCH.184, @object
	.size	CSWTCH.184, 3
CSWTCH.184:
	.byte	0
	.byte	1
	.byte	1
	.zero	1
	.type	CSWTCH.183, @object
	.size	CSWTCH.183, 3
CSWTCH.183:
	.byte	1
	.byte	0
	.byte	1
	.ident	"GCC: (GNU) 11.1.0"
