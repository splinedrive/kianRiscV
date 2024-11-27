	.file	"main_house3d_rotate_hdmi.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (GCC) version 11.1.0 (riscv32-unknown-elf)
#	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version none
# warning: GMP header version 6.2.0 differs from library version 6.3.0.
# warning: MPFR header version 4.0.2 differs from library version 4.2.1.
# warning: MPC header version 1.1.0 differs from library version 1.3.1.
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=rv32im -mabi=ilp32 -mtune=rocket -march=rv32im -Os -fno-pic -fno-stack-protector -ffreestanding
	.text
	.align	2
	.globl	dma_action
	.type	dma_action, @function
dma_action:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp77,
	sw	a0,44(a5)	# src, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a1,48(a5)	# dst, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	a2,52(a5)	# len, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	sw	a3,56(a5)	# ctrl, MEM[(volatile uint32_t *)805306424B]
# kianv_stdlib.h:55: }
	ret	
	.size	dma_action, .-dma_action
	.align	2
	.globl	_sendCmd
	.type	_sendCmd, @function
_sendCmd:
# kianv_stdlib.h:62:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp75,
	sw	a0,12(a5)	# c, MEM[(volatile uint32_t *)805306380B]
# kianv_stdlib.h:64: }
	ret	
	.size	_sendCmd, .-_sendCmd
	.align	2
	.globl	_sendData
	.type	_sendData, @function
_sendData:
# kianv_stdlib.h:71:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	ori	a0,a0,256	#, _3, tmp78
# kianv_stdlib.h:71:     *((volatile uint32_t *) VIDEO_RAW) = ((0x01) << 8) | c;
	li	a5,805306368		# tmp77,
	sw	a0,12(a5)	# _3, MEM[(volatile uint32_t *)805306380B]
# kianv_stdlib.h:73: }
	ret	
	.size	_sendData, .-_sendData
	.align	2
	.globl	init_oled1331
	.type	init_oled1331, @function
init_oled1331:
# kianv_stdlib.h:62:     *((volatile uint32_t *) VIDEO_RAW) = ((0x00) << 8) | c;
	li	a5,805306368		# tmp73,
	li	a4,174		# tmp74,
	sw	a4,12(a5)	# tmp74, MEM[(volatile uint32_t *)805306380B]
	li	a4,129		# tmp77,
	sw	a4,12(a5)	# tmp77, MEM[(volatile uint32_t *)805306380B]
	li	a4,145		# tmp80,
	sw	a4,12(a5)	# tmp80, MEM[(volatile uint32_t *)805306380B]
	li	a4,130		# tmp83,
	sw	a4,12(a5)	# tmp83, MEM[(volatile uint32_t *)805306380B]
	li	a4,128		# tmp86,
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
# kianv_stdlib.h:120: }
	ret	
	.size	init_oled1331, .-init_oled1331
	.align	2
	.globl	set_reg
	.type	set_reg, @function
set_reg:
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp85,
	sll	a1,a5,a1	# tmp88, _12, tmp85
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a5,0(a0)		# _1,* p
# kianv_stdlib.h:124:     if (bit) {
	beq	a2,zero,.L6	#, tmp89,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a1,a1,a5	# _1, _5, _12
.L8:
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	sw	a1,0(a0)	# _18,* p
# kianv_stdlib.h:129: }
	ret	
.L6:
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a1,a1	# tmp86, _12
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a1,a1,a5	# _13, _18, tmp86
	j	.L8		#
	.size	set_reg, .-set_reg
	.align	2
	.globl	gpio_set_value
	.type	gpio_set_value, @function
gpio_set_value:
# kianv_stdlib.h:131: void gpio_set_value(int gpio, int bit) {
	mv	a2,a1	# tmp76, bit
# kianv_stdlib.h:132:     set_reg(GPIO_OUTPUT, gpio, bit);
	mv	a1,a0	#, tmp75
	li	a0,805306368		# tmp74,
	addi	a0,a0,28	#,, tmp74
	tail	set_reg		#
	.size	gpio_set_value, .-gpio_set_value
	.align	2
	.globl	gpio_get_input_value
	.type	gpio_get_input_value, @function
gpio_get_input_value:
# kianv_stdlib.h:136:   uint32_t read = IO_IN(GPIO_INPUT);
	li	a5,805306368		# tmp77,
	lw	a5,32(a5)		# read, MEM[(volatile uint32_t *)805306400B]
# kianv_stdlib.h:139:   return ((read >> gpio) & 0x01);
	srl	a0,a5,a0	# tmp80, tmp79, read
# kianv_stdlib.h:140: }
	andi	a0,a0,1	#,, tmp79
	ret	
	.size	gpio_get_input_value, .-gpio_get_input_value
	.align	2
	.globl	gpio_set_direction
	.type	gpio_set_direction, @function
gpio_set_direction:
# kianv_stdlib.h:142: void gpio_set_direction(int gpio, int bit) {
	mv	a2,a1	# tmp76, bit
# kianv_stdlib.h:143:     set_reg(GPIO_DIR, gpio, bit);
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
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp78
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp78, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp79
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp79, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_1, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_4, tmpl0
# kianv_stdlib.h:155: }
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
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	call	get_cycles		#
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	add	s1,a0,s1	# wait, tmp95, _1
	sltu	s0,s1,a0	# _1, tmp78, tmp95
	add	a1,a1,s2	# wait, tmp96, tmp100
	add	s0,s0,a1	# tmp96, tmp80, tmp78
.L17:
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	call	get_cycles		#
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	bgtu	s0,a1,.L17	#, tmp80, _2,
	bne	s0,a1,.L14	#, tmp80, _2,
	bgtu	s1,a0,.L17	#, tmp95, _2,
.L14:
# kianv_stdlib.h:165: }
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
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L19	#, us,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a4,999424		# tmp82,
	addi	a4,a4,576	#, tmp81, tmp82
	divu	a5,a5,a4	# tmp81, tmp80, _8
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	li	a1,0		#,
	mul	a0,a5,a0	#, tmp80, us
	tail	wait_cycles		#
.L19:
# kianv_stdlib.h:169: }
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L21	#, ms,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a5,16(a5)		# _8, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a4,1000		# tmp80,
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	li	a1,0		#,
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	divu	a5,a5,a4	# tmp80, tmp81, _8
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a0,a5,a0	#, tmp81, ms
	tail	wait_cycles		#
.L21:
# kianv_stdlib.h:173: }
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:176:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L23	#, sec,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp77,
	lw	a5,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:176:   if (sec) wait_cycles(sec * get_cpu_freq());
	li	a1,0		#,
	mul	a0,a0,a5	#, sec, _7
	tail	wait_cycles		#
.L23:
# kianv_stdlib.h:177: }
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:180:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	call	get_cycles		#
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:180:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	li	a5,999424		# tmp83,
	addi	a5,a5,576	#, tmp82, tmp83
	divu	a2,a2,a5	# tmp82,, _7
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:181: }
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
# kianv_stdlib.h:184:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	call	get_cycles		#
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp78,
	lw	a2,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:184:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	li	a5,1000		# tmp81,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp81,, _7
	call	__udivdi3		#
# kianv_stdlib.h:185: }
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
# kianv_stdlib.h:188:   return get_cycles() / (uint64_t) (get_cpu_freq());
	call	get_cycles		#
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp77,
	lw	a2,16(a5)		# _6, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:188:   return get_cycles() / (uint64_t) (get_cpu_freq());
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:189: }
	lw	ra,12(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp75,
.L32:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L32	#, _1,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a5)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	li	a4,13		# tmp77,
	bne	a0,a4,.L31	#, c, tmp77,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a4,10		# tmp79,
	sw	a4,0(a5)	# tmp79, MEM[(volatile uint32_t *)805306368B]
.L31:
# kianv_stdlib.h:198: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
# kianv_stdlib.h:201:   putchar(ch);
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
# kianv_stdlib.h:208: void print_str(char *p) {
	mv	s0,a0	# p, tmp77
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	li	s1,805306368		# tmp76,
.L39:
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a0,0(s0)	# _2, MEM[(char *)p_3]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a0,zero,.L40	#, _2,,
# kianv_stdlib.h:214: }
	lw	ra,12(sp)		#,
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
.L40:
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(s1)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L40	#, _1,,
# kianv_stdlib.h:212:     putchar(*(p++));
	addi	s0,s0,1	#, p, p
# kianv_stdlib.h:212:     putchar(*(p++));
	call	putchar		#
	j	.L39		#
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
	addi	sp,sp,-16	#,,
	sw	ra,12(sp)	#,
# kianv_stdlib.h:217:   print_str(p);
	call	print_str		#
# kianv_stdlib.h:219: }
	lw	ra,12(sp)		#,
# kianv_stdlib.h:201:   putchar(ch);
	li	a0,13		#,
# kianv_stdlib.h:219: }
	addi	sp,sp,16	#,,
# kianv_stdlib.h:201:   putchar(ch);
	tail	putchar		#
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:223:   char *p = buffer;
	addi	a5,sp,4	#, p,
	mv	a3,a5	# p, p
# kianv_stdlib.h:225:     *(p++) = val % 10;
	li	a4,10		# tmp93,
.L48:
# kianv_stdlib.h:224:   while (val || p == buffer) {
	bne	a0,zero,.L49	#, val,,
# kianv_stdlib.h:224:   while (val || p == buffer) {
	beq	a5,a3,.L49	#, p, p,
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	li	a2,805306368		# tmp88,
.L50:
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a2)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L50	#, _3,,
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a4,-1(a5)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,-1	#, p, p
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a4,0(a2)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:229:   while (p != buffer) {
	bne	a5,a3,.L50	#, p, p,
# kianv_stdlib.h:234: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L49:
# kianv_stdlib.h:225:     *(p++) = val % 10;
	remu	a2,a0,a4	# tmp93, tmp83, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	addi	a5,a5,1	#, p, p
# kianv_stdlib.h:226:     val = val / 10;
	divu	a0,a0,a4	# tmp93, val, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	sb	a2,-1(a5)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L48		#
	.size	print_dec, .-print_dec
	.globl	__umoddi3
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-64	#,,
	sw	s2,48(sp)	#,
# kianv_stdlib.h:238:   char *p = buffer;
	addi	s2,sp,12	#, p,
# kianv_stdlib.h:236: void print_dec64(uint64_t val) {
	sw	s0,56(sp)	#,
	sw	s1,52(sp)	#,
	sw	s3,44(sp)	#,
	sw	ra,60(sp)	#,
# kianv_stdlib.h:236: void print_dec64(uint64_t val) {
	mv	s0,a0	# val, tmp102
	mv	s1,a1	# val, tmp103
	mv	s3,s2	# p, p
.L57:
# kianv_stdlib.h:239:   while (val || p == buffer) {
	or	a5,s0,s1	# val, val, val
	bne	a5,zero,.L58	#, val,,
# kianv_stdlib.h:239:   while (val || p == buffer) {
	beq	s2,s3,.L58	#, p, p,
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp93,
.L59:
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L59	#, _3,,
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(s2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	s2,s2,-1	#, p, p
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:244:   while (p != buffer) {
	bne	s2,s3,.L59	#, p, p,
# kianv_stdlib.h:249: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
.L58:
# kianv_stdlib.h:240:     *(p++) = val % 10;
	li	a2,10		#,
	li	a3,0		#,
	mv	a0,s0	#, val
	mv	a1,s1	#, val
	call	__umoddi3		#
# kianv_stdlib.h:241:     val = val / 10;
	mv	a1,s1	#, val
# kianv_stdlib.h:240:     *(p++) = val % 10;
	sb	a0,0(s2)	# tmp104, MEM[(char *)p_18 + 4294967295B]
# kianv_stdlib.h:241:     val = val / 10;
	li	a2,10		#,
	mv	a0,s0	#, val
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:240:     *(p++) = val % 10;
	addi	s2,s2,1	#, p, p
# kianv_stdlib.h:241:     val = val / 10;
	mv	s0,a0	# val, tmp106
	mv	s1,a1	# val, tmp107
	j	.L57		#
	.size	print_dec64, .-print_dec64
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC1:
	.string	"0123456789ABCDEF"
	.text
	.align	2
	.globl	print_hex
	.type	print_hex, @function
print_hex:
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-1	#, tmp81, tmp93
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	lui	a4,%hi(.LC1)	# tmp90,
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a1,a1,2	#, i, tmp81
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp89,
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	addi	a4,a4,%lo(.LC1)	# tmp91, tmp90,
.L66:
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bge	a1,zero,.L67	#, i,,
# kianv_stdlib.h:257: }
	ret	
.L67:
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L67	#, _2,,
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a1	# i, tmp85, val
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp86, tmp85
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a4,a5	# tmp86, tmp87, tmp91
	lbu	a5,0(a5)	# _6, "0123456789ABCDEF"[_4]
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-4	#, i, i
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a3)	# _6, MEM[(volatile uint32_t *)805306368B]
	j	.L66		#
	.size	print_hex, .-print_hex
	.align	2
	.globl	setpixel
	.type	setpixel, @function
setpixel:
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a5,65536		# tmp88,
	addi	a5,a5,-1	#, tmp87, tmp88
	slli	a1,a1,8	#, tmp85, tmp94
	and	a1,a1,a5	# tmp87, tmp86, tmp85
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	a3,a3,16	#, tmp89, tmp96
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a1,a1,a3	# tmp89, tmp90, tmp86
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	andi	a2,a2,0xff	# tmp91, tmp95
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a1,a1,a2	# tmp91, _9, tmp90
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a5,805306368		# tmp93,
	sw	a1,8(a5)	# _9, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:272: }
	ret	
	.size	setpixel, .-setpixel
	.align	2
	.globl	draw_bresenham
	.type	draw_bresenham, @function
draw_bresenham:
	addi	sp,sp,-64	#,,
	sw	s7,28(sp)	#,
	mv	s7,a0	# fb, tmp101
# kianv_stdlib.h:277:   int dx =  abs(x1 - x0);
	sub	a0,a3,a1	#, x1, x0
# kianv_stdlib.h:275: {
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
# kianv_stdlib.h:275: {
	mv	s1,a1	# x0, tmp102
	mv	s0,a2	# y0, tmp103
	mv	s5,a3	# x1, tmp104
	mv	s6,a4	# y1, tmp105
	mv	s8,a5	# color, tmp106
# kianv_stdlib.h:277:   int dx =  abs(x1 - x0);
	call	abs		#
	mv	s3,a0	# dx, tmp107
# kianv_stdlib.h:278:   int sx = x0 < x1 ? 1 : -1;
	li	s10,-1		# iftmp.6_9,
	ble	s5,s1,.L73	#, x1, x0,
	li	s10,1		# iftmp.6_9,
.L73:
# kianv_stdlib.h:279:   int dy = -abs(y1 - y0);
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
	mv	s4,a0	# _3, tmp108
# kianv_stdlib.h:279:   int dy = -abs(y1 - y0);
	neg	s11,a0	# dy, _3
# kianv_stdlib.h:280:   int sy = y0 < y1 ? 1 : -1;
	li	s9,1		# iftmp.7_10,
	bgt	s6,s0,.L74	#, y1, y0,
# kianv_stdlib.h:280:   int sy = y0 < y1 ? 1 : -1;
	li	s9,-1		# iftmp.7_10,
.L74:
	sub	s2,s3,s4	# err, dx, _3
.L75:
# kianv_stdlib.h:284:     setpixel(fb, x0, y0, color);
	mv	a3,s8	#, color
	mv	a2,s0	#, y0
	mv	a1,s1	#, x0
	mv	a0,s7	#, fb
	call	setpixel		#
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s5,.L76	#, x0, x1,
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s6,.L72	#, y0, y1,
.L76:
# kianv_stdlib.h:286:     e2 = 2*err;
	slli	a5,s2,1	#, e2, err
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	s11,a5,.L78	#, dy, e2,
	sub	s2,s2,s4	# err, err, _3
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s10	# iftmp.6_9, x0, x0
.L78:
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s3,a5,.L75	#, dx, e2,
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s2,s2,s3	# dx, err, err
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,s9	# iftmp.7_10, y0, y0
	j	.L75		#
.L72:
# kianv_stdlib.h:290: }
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
.L87:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a5,s3,s2	# i, tmp157, format
	lbu	a0,0(a5)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	a0,zero,.L104	#, _14,,
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
.L104:
# stdlib.c:97: 		if (format[i] == '%') {
	li	a5,37		# tmp108,
	bne	a0,a5,.L109	#, _14, tmp108,
.L88:
# stdlib.c:98: 			while (format[++i]) {
	addi	s2,s2,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a5,s3,s2	# i, tmp156, format
	lbu	a5,0(a5)	# _10, MEM[(const char *)_27]
# stdlib.c:98: 			while (format[++i]) {
	beq	a5,zero,.L91	#, _10,,
# stdlib.c:99: 				if (format[i] == 'c') {
	bne	a5,s4,.L90	#, _10, tmp167,
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a5,12(sp)		# D.2544, ap
# kianv_stdlib.h:201:   putchar(ch);
	lbu	a0,0(a5)	#, MEM[(int *)_98]
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	addi	a4,a5,4	#, D.2545, D.2544
	sw	a4,12(sp)	# D.2545, ap
.L109:
# kianv_stdlib.h:201:   putchar(ch);
	call	putchar		#
# stdlib.c:50: }
	j	.L91		#
.L90:
# stdlib.c:103: 				if (format[i] == 's') {
	bne	a5,s5,.L92	#, _10, tmp168,
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a5,12(sp)		# D.2546, ap
	lw	s0,0(a5)		# p, MEM[(char * *)_67]
	addi	a4,a5,4	#, D.2547, D.2546
	sw	a4,12(sp)	# D.2547, ap
.L93:
# stdlib.c:54: 	while (*p)
	lbu	a0,0(s0)	# _39, MEM[(char *)p_37]
	bne	a0,zero,.L94	#, _39,,
.L91:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	s2,s2,1	#, i, i
	j	.L87		#
.L94:
# stdlib.c:56:     print_chr(*(p++));
	addi	s0,s0,1	#, p, p
# kianv_stdlib.h:201:   putchar(ch);
	call	putchar		#
# kianv_stdlib.h:202: }
	j	.L93		#
.L92:
# stdlib.c:107: 				if (format[i] == 'd') {
	bne	a5,s6,.L95	#, _10, tmp169,
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a5,12(sp)		# D.2548, ap
	lw	s1,0(a5)		# val, MEM[(int *)_99]
	addi	a4,a5,4	#, D.2549, D.2548
	sw	a4,12(sp)	# D.2549, ap
# stdlib.c:63: 	if (val < 0) {
	bge	s1,zero,.L96	#, val,,
# kianv_stdlib.h:201:   putchar(ch);
	li	a0,45		#,
	call	putchar		#
# stdlib.c:65: 		val = -val;
	neg	s1,s1	# val, val
.L96:
# stdlib.c:90: {
	addi	s0,sp,16	#, p,
	mv	s8,s0	# p, p
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	li	a4,10		# tmp161,
.L97:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	s1,zero,.L98	#, val,,
	beq	s0,s8,.L98	#, p, p,
.L99:
# kianv_stdlib.h:201:   putchar(ch);
	lbu	a0,-1(s0)	#, MEM[(char *)p_49]
# stdlib.c:72: 		printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# kianv_stdlib.h:201:   putchar(ch);
	call	putchar		#
# stdlib.c:71: 	while (p != buffer)
	bne	s0,s8,.L99	#, p, p,
	j	.L91		#
.L98:
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
	j	.L97		#
.L95:
# stdlib.c:111: 				if (format[i] == 'u') {
	bne	a5,s7,.L88	#, _10, tmp170,
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a5,12(sp)		# D.2550, ap
# stdlib.c:78: 	char *p = buffer;
	addi	s0,sp,16	#, p,
	mv	s1,s0	# p, p
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a4,a5,4	#, D.2551, D.2550
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a5,0(a5)		# MEM[(int *)_102], MEM[(int *)_102]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	sw	a4,12(sp)	# D.2551, ap
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	li	a3,10		# tmp162,
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a4,a5,31	#, tmp136, MEM[(int *)_102]
	xor	a5,a4,a5	# MEM[(int *)_102], val, tmp136
	sub	a5,a5,a4	# val, val, tmp136
.L100:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a5,zero,.L101	#, val,,
	beq	s0,s1,.L101	#, p, p,
.L102:
# kianv_stdlib.h:201:   putchar(ch);
	lbu	a0,-1(s0)	#, MEM[(char *)p_62]
# stdlib.c:86: 		printf_c(*(--p));
	addi	s0,s0,-1	#, p, p
# kianv_stdlib.h:201:   putchar(ch);
	call	putchar		#
# stdlib.c:85: 	while (p != buffer)
	bne	s0,s1,.L102	#, p, p,
	j	.L91		#
.L101:
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
	j	.L100		#
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
	ble	a4,a3,.L111	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L111:
# stdlib.c:132: }
	mv	a0,a5	#, <retval>
	ret	
	.size	malloc, .-malloc
	.align	2
	.globl	memcpy
	.type	memcpy, @function
memcpy:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,0		# ivtmp.299,
.L114:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a5,a2,.L115	#, ivtmp.299, _16,
# stdlib.c:142: }
	ret	
.L115:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	add	a4,a1,a5	# ivtmp.299, tmp81, bb
	lbu	a3,0(a4)	# _1, MEM[(const char *)_17]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	add	a4,a0,a5	# ivtmp.299, tmp82, aa
	addi	a5,a5,1	#, ivtmp.299, ivtmp.299
	sb	a3,0(a4)	# _1, MEM[(char *)_18]
	j	.L114		#
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
.L117:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp96, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp97, tmp96
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L119	#, tmp97,,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp100,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a6,-2139062272		# tmp105,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp99, tmp100
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	addi	a6,a6,128	#, tmp104, tmp105
.L122:
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
	beq	a3,zero,.L120	#, tmp103,,
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a4,0(a5)	# v, *dst_19
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a3,a4,255	#, tmp106, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L121	#, tmp106,,
# stdlib.c:164: 			v = v >> 8;
	srli	a3,a4,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a3,1(a5)	# v, MEM[(char *)dst_19 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp107, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L121	#, tmp107,,
# stdlib.c:169: 			v = v >> 8;
	srli	a3,a4,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a3,2(a5)	# v, MEM[(char *)dst_19 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a3,a3,255	#, tmp108, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	beq	a3,zero,.L121	#, tmp108,,
# stdlib.c:174: 			v = v >> 8;
	srli	a4,a4,24	#, v, v
# stdlib.c:176: 			dst[3] = v & 0xff;
	sb	a4,3(a5)	# v, MEM[(char *)dst_19 + 3B]
# stdlib.c:177: 			return r;
	ret	
.L119:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	bne	a4,zero,.L117	#, c,,
.L121:
# stdlib.c:184: }
	ret	
.L120:
# stdlib.c:180: 		*(uint32_t*)dst = v;
	sw	a4,0(a5)	# v, MEM[(uint32_t *)dst_19]
# stdlib.c:181: 		src += 4;
	addi	a1,a1,4	#, src, src
# stdlib.c:182: 		dst += 4;
	addi	a5,a5,4	#, dst, dst
# stdlib.c:156: 	{
	j	.L122		#
	.size	strcpy, .-strcpy
	.align	2
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.L136:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L140	#, tmp102,,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-16842752		# tmp156,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-2139062272		# tmp158,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,-257	#, tmp157, tmp156
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,128	#, tmp159, tmp158
.L145:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_15]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_17]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	beq	a5,a4,.L141	#, v1, v2,
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a3,a2,.L142	#, c1, c2,
.L159:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L135	#, c1, c2,
.L157:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
.L140:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	beq	a5,a4,.L137	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	bltu	a5,a4,.L135	#, c1, c2,
	li	a0,1		# <retval>,
	ret	
.L137:
# stdlib.c:195: 		else if (!c1)
	bne	a5,zero,.L136	#, c1,,
.L155:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
	j	.L135		#
.L142:
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L135	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L159	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L135	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L159	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L135	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L135	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bltu	a5,a4,.L157	#, c1, c2,
.L135:
# stdlib.c:234: }
	ret	
.L141:
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	add	a4,a5,a3	# tmp157, tmp109, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	not	a5,a5	# tmp112, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a4,a5	# tmp112, tmp113, tmp109
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a5,a2	# tmp159, tmp114, tmp113
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	bne	a5,zero,.L155	#, tmp114,,
# stdlib.c:231: 		s1 += 4;
	addi	a0,a0,4	#, s1, s1
# stdlib.c:232: 		s2 += 4;
	addi	a1,a1,4	#, s2, s2
# stdlib.c:200: 	{
	j	.L145		#
	.size	strcmp, .-strcmp
	.align	2
	.globl	sin1
	.type	sin1, @function
sin1:
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L162	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp96,
	add	a0,a0,a5	# tmp96, tmp98, angle
	slli	a0,a0,16	#, angle, tmp98
	srai	a0,a0,16	#, angle, angle
.L162:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a0,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_4, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp102, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_4, v0.41_4
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L163	#, tmp102,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp104, v0
	slli	a5,a5,16	#, v0, tmp104
	srai	a5,a5,16	#, v0, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a0,a0	# angle, angle
.L163:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _6, v0
	slli	a2,a5,1	#, tmp110, _6
	lui	a4,%hi(.LANCHOR1)	# tmp109,
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a5,a5,1	#, tmp114, _6
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a4,%lo(.LANCHOR1)	# tmp108, tmp109,
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp115, tmp114
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a2,a4,a2	# tmp110, tmp111, tmp108
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a4,a5	# tmp115, tmp116, tmp108
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a2)		# _7, sin90[_6]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a4)		# sin90[_9], sin90[_9]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a0,a0,0xff	# tmp121, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a2	# tmp118, sin90[_9], _7
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a5,a0	# tmp122, tmp118, tmp121
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a3,64	#, tmp129, v0.41_4
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp123, tmp122
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a2	# _7, tmp126, tmp123
	slli	a0,a0,16	#, _5, tmp126
	srli	a0,a0,16	#, _5, _5
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L164	#, tmp129,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp131, _5
	slli	a0,a0,16	#, _5, tmp131
	srli	a0,a0,16	#, _5, _5
.L164:
# gfx_lib_hdmi.h:94: }
	slli	a0,a0,16	#,, _5
	srai	a0,a0,16	#,,
	ret	
	.size	sin1, .-sin1
	.align	2
	.globl	cos1
	.type	cos1, @function
cos1:
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L172	#, angle,,
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp79,
	add	a0,a0,a5	# tmp79, tmp81, angle
	slli	a0,a0,16	#, angle, tmp81
	srai	a0,a0,16	#, angle, angle
.L172:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp85,
	addi	a5,a5,1	#, tmp84, tmp85
	add	a0,a0,a5	# tmp84, tmp83, angle
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a0,a0,16	#,, tmp83
	srai	a0,a0,16	#,,
	tail	sin1		#
	.size	cos1, .-cos1
	.align	2
	.globl	oled_spi_tx
	.type	oled_spi_tx, @function
oled_spi_tx:
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	slli	a1,a1,8	#, tmp80, tmp85
	andi	a1,a1,256	#, tmp81, tmp80
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	or	a1,a1,a0	# tmp84, _6, tmp81
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp83,
	sw	a1,12(a5)	# _6, MEM[(volatile uint32_t *)805306380B]
# gfx_lib_hdmi.h:115: }
	ret	
	.size	oled_spi_tx, .-oled_spi_tx
	.align	2
	.globl	oled_max_window
	.type	oled_max_window, @function
oled_max_window:
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp73,
	li	a4,21		# tmp74,
	sw	a4,12(a5)	# tmp74, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,95		# tmp79,
	sw	a4,12(a5)	# tmp79, MEM[(volatile uint32_t *)805306380B]
	li	a4,117		# tmp82,
	sw	a4,12(a5)	# tmp82, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp87,
	sw	a4,12(a5)	# tmp87, MEM[(volatile uint32_t *)805306380B]
# gfx_lib_hdmi.h:120: }
	ret	
	.size	oled_max_window, .-oled_max_window
	.align	2
	.globl	oled_show_fb_8or16
	.type	oled_show_fb_8or16, @function
oled_show_fb_8or16:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp78,
	sw	a0,44(a5)	# framebuffer, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp84,
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a1,48(a5)	# target_fb, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	a4,a4,704	#, tmp83, tmp84
	sw	a4,52(a5)	# tmp83, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a4,1		# tmp87,
	sw	a4,56(a5)	# tmp87, MEM[(volatile uint32_t *)805306424B]
# gfx_lib_hdmi.h:132: }
	ret	
	.size	oled_show_fb_8or16, .-oled_show_fb_8or16
	.align	2
	.globl	init_oled8bit_colors
	.type	init_oled8bit_colors, @function
init_oled8bit_colors:
# gfx_lib_hdmi.h:195:     char p = oled_8bit_init_seq[i];
	lui	a4,%hi(.LANCHOR2)	# tmp78,
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	li	a5,0		# i,
# gfx_lib_hdmi.h:195:     char p = oled_8bit_init_seq[i];
	addi	a4,a4,%lo(.LANCHOR2)	# tmp77, tmp78,
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a2,805306368		# tmp81,
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	li	a3,37		# tmp82,
.L177:
# gfx_lib_hdmi.h:195:     char p = oled_8bit_init_seq[i];
	add	a1,a4,a5	# i, tmp79, tmp77
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a1,0(a1)	# _7, MEM[(char *)_1]
# gfx_lib_hdmi.h:193:       sizeof(oled_8bit_init_seq[0]); i++) {
	addi	a5,a5,1	#, i, i
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a1,12(a2)	# _7, MEM[(volatile uint32_t *)805306380B]
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	bne	a5,a3,.L177	#, i, tmp82,
# gfx_lib_hdmi.h:198: }
	ret	
	.size	init_oled8bit_colors, .-init_oled8bit_colors
	.align	2
	.globl	fb_setpixel
	.type	fb_setpixel, @function
fb_setpixel:
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a5,79		# tmp84,
	bgtu	a1,a5,.L179	#, x, tmp84,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	a5,59		# tmp85,
	bgtu	a2,a5,.L179	#, y, tmp85,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	li	a5,80		# tmp86,
	mul	a2,a2,a5	# tmp87, y, tmp86
	add	a1,a2,a1	# x, tmp88, tmp87
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a1,a1,2	#, tmp89, tmp88
	add	a0,a0,a1	# tmp89, tmp90, fb
	sw	a3,0(a0)	# color, *_12
.L179:
# gfx_lib_hdmi.h:207: }
	ret	
	.size	fb_setpixel, .-fb_setpixel
	.align	2
	.globl	fb_draw_bresenham
	.type	fb_draw_bresenham, @function
fb_draw_bresenham:
	addi	sp,sp,-64	#,,
	sw	s7,28(sp)	#,
	mv	s7,a0	# fb, tmp101
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sub	a0,a3,a1	#, x1, x0
# gfx_lib_hdmi.h:210: {
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
# gfx_lib_hdmi.h:210: {
	mv	s1,a1	# x0, tmp102
	mv	s0,a2	# y0, tmp103
	mv	s5,a3	# x1, tmp104
	mv	s6,a4	# y1, tmp105
	mv	s8,a5	# color, tmp106
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s3,a0	# dx, tmp107
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	li	s10,-1		# iftmp.50_9,
	ble	s5,s1,.L182	#, x1, x0,
	li	s10,1		# iftmp.50_9,
.L182:
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
	mv	s4,a0	# _3, tmp108
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	neg	s11,a0	# dy, _3
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	li	s9,1		# iftmp.51_10,
	bgt	s6,s0,.L183	#, y1, y0,
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	li	s9,-1		# iftmp.51_10,
.L183:
	sub	s2,s3,s4	# err, dx, _3
.L184:
# gfx_lib_hdmi.h:217:     fb_setpixel(fb, x0, y0, color);
	mv	a3,s8	#, color
	mv	a2,s0	#, y0
	mv	a1,s1	#, x0
	mv	a0,s7	#, fb
	call	fb_setpixel		#
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s5,.L185	#, x0, x1,
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s6,.L181	#, y0, y1,
.L185:
# gfx_lib_hdmi.h:220:     e2 = 2*err;
	slli	a5,s2,1	#, e2, err
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	s11,a5,.L187	#, dy, e2,
	sub	s2,s2,s4	# err, err, _3
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s10	# iftmp.50_9, x0, x0
.L187:
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s3,a5,.L184	#, dx, e2,
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s2,s2,s3	# dx, err, err
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,s9	# iftmp.51_10, y0, y0
	j	.L184		#
.L181:
# gfx_lib_hdmi.h:224: }
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
	.size	fb_draw_bresenham, .-fb_draw_bresenham
	.align	2
	.globl	fill_oled
	.type	fill_oled, @function
fill_oled:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp77,
	sw	a0,44(a5)	# framebuffer, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp83,
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a1,48(a5)	# rgb, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	a4,a4,704	#, tmp82, tmp83
	sw	a4,52(a5)	# tmp82, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a4,2		# tmp86,
	sw	a4,56(a5)	# tmp86, MEM[(volatile uint32_t *)805306424B]
# gfx_lib_hdmi.h:233: }
	ret	
	.size	fill_oled, .-fill_oled
	.align	2
	.globl	mirror_x_axis
	.type	mirror_x_axis, @function
mirror_x_axis:
# gfx_lib_hdmi.h:236:   point transformed = {p->x, 1.0 * p->y};
	lw	a4,4(a1)		# _2, p_4(D)->y
# gfx_lib_hdmi.h:237:   return transformed;
	lw	a3,0(a1)		# p_4(D)->x, p_4(D)->x
	sw	zero,8(a0)	#, <retval>.z
	sw	a4,4(a0)	# _2, <retval>.y
	sw	a3,0(a0)	# p_4(D)->x, <retval>.x
# gfx_lib_hdmi.h:238: }
	ret	
	.size	mirror_x_axis, .-mirror_x_axis
	.globl	__floatsidf
	.globl	__fixdfsi
	.align	2
	.globl	mirror_y_axis
	.type	mirror_y_axis, @function
mirror_y_axis:
	addi	sp,sp,-16	#,,
	sw	s0,8(sp)	#,
	mv	s0,a0	# .result_ptr, tmp88
# gfx_lib_hdmi.h:241:   point transformed = {-1.0 * p->x, p->y};
	lw	a0,0(a1)		#, p_7(D)->x
# gfx_lib_hdmi.h:240: point mirror_y_axis(point *p) {
	sw	ra,12(sp)	#,
	sw	s1,4(sp)	#,
# gfx_lib_hdmi.h:241:   point transformed = {-1.0 * p->x, p->y};
	lw	s1,4(a1)		# _5, p_7(D)->y
# gfx_lib_hdmi.h:241:   point transformed = {-1.0 * p->x, p->y};
	call	__floatsidf		#
# gfx_lib_hdmi.h:241:   point transformed = {-1.0 * p->x, p->y};
	li	a5,-2147483648		# tmp81,
	mv	a4,a0	# tmp93, tmp90
	xor	a5,a5,a1	# tmp91, tmp94, tmp81
	mv	a0,a4	# tmp95, tmp93
	mv	a1,a5	#, tmp94
	call	__fixdfsi		#
	sw	a0,0(s0)	# tmp92, <retval>.x
# gfx_lib_hdmi.h:242:   return transformed;
	sw	s1,4(s0)	# _5, <retval>.y
# gfx_lib_hdmi.h:243: }
	lw	ra,12(sp)		#,
# gfx_lib_hdmi.h:242:   return transformed;
	sw	zero,8(s0)	#, <retval>.z
# gfx_lib_hdmi.h:243: }
	mv	a0,s0	#, .result_ptr
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	mirror_y_axis, .-mirror_y_axis
	.align	2
	.globl	mirror_z_axis
	.type	mirror_z_axis, @function
mirror_z_axis:
	addi	sp,sp,-16	#,,
	sw	s0,8(sp)	#,
	mv	s0,a0	# .result_ptr, tmp89
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	a0,8(a1)		#, p_8(D)->z
# gfx_lib_hdmi.h:245: point mirror_z_axis(point *p) {
	sw	ra,12(sp)	#,
	sw	s1,4(sp)	#,
	sw	s2,0(sp)	#,
# gfx_lib_hdmi.h:245: point mirror_z_axis(point *p) {
	mv	s1,a1	# p, tmp90
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	s2,4(a1)		# _2, p_8(D)->y
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	call	__floatsidf		#
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	li	a5,-2147483648		# tmp82,
	xor	a5,a5,a1	# tmp92, tmp95, tmp82
	mv	a4,a0	# tmp94, tmp91
	mv	a1,a5	#, tmp95
	mv	a0,a4	# tmp96, tmp94
	call	__fixdfsi		#
# gfx_lib_hdmi.h:247:   return transformed;
	lw	a5,0(s1)		# p_8(D)->x, p_8(D)->x
	sw	s2,4(s0)	# _2, <retval>.y
	sw	a0,8(s0)	# tmp93, <retval>.z
# gfx_lib_hdmi.h:248: }
	lw	ra,12(sp)		#,
# gfx_lib_hdmi.h:247:   return transformed;
	sw	a5,0(s0)	# p_8(D)->x, <retval>.x
# gfx_lib_hdmi.h:248: }
	mv	a0,s0	#, .result_ptr
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	lw	s2,0(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	mirror_z_axis, .-mirror_z_axis
	.globl	__floatsisf
	.globl	__mulsf3
	.globl	__fixsfsi
	.align	2
	.globl	scale
	.type	scale, @function
scale:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# .result_ptr, tmp96
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(a1)		#, p_14(D)->y
# gfx_lib_hdmi.h:250: point scale(point *p, float sx, float sy, float sz) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	mv	s2,a4	# sz, tmp100
	sw	s4,24(sp)	#,
# gfx_lib_hdmi.h:250: point scale(point *p, float sx, float sy, float sz) {
	sw	a3,12(sp)	# sy, %sfp
	mv	s4,a2	# sx, tmp98
	mv	s1,a1	# p, tmp97
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	lw	a1,12(sp)		# sy, %sfp
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s3,a0	# _8, tmp101
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,8(s1)		#, p_14(D)->z
	call	__floatsisf		#
	mv	a1,s2	#, sz
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s2,a0	# _12, tmp102
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,0(s1)		#, p_14(D)->x
	call	__floatsisf		#
	mv	a1,s4	#, sx
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	sw	a0,0(s0)	# tmp103, <retval>.x
# gfx_lib_hdmi.h:252:   return transformed;
	sw	s3,4(s0)	# _8, <retval>.y
	sw	s2,8(s0)	# _12, <retval>.z
# gfx_lib_hdmi.h:253: }
	lw	ra,44(sp)		#,
	mv	a0,s0	#, .result_ptr
	lw	s0,40(sp)		#,
	lw	s1,36(sp)		#,
	lw	s2,32(sp)		#,
	lw	s3,28(sp)		#,
	lw	s4,24(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	scale, .-scale
	.align	2
	.globl	translate
	.type	translate, @function
translate:
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a6,4(a1)		# p_8(D)->y, p_8(D)->y
	add	a3,a3,a6	# p_8(D)->y, _4, tmp90
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a6,8(a1)		# p_8(D)->z, p_8(D)->z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,0(a1)		# p_8(D)->x, p_8(D)->x
# gfx_lib_hdmi.h:257:   return transformed;
	sw	a3,4(a0)	# _4, <retval>.y
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a4,a4,a6	# p_8(D)->z, _6, tmp91
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a1,a1,a2	# tmp89, tmp85, p_8(D)->x
# gfx_lib_hdmi.h:257:   return transformed;
	sw	a1,0(a0)	# tmp85, <retval>.x
	sw	a4,8(a0)	# _6, <retval>.z
# gfx_lib_hdmi.h:258: }
	ret	
	.size	translate, .-translate
	.globl	__muldf3
	.globl	__divdf3
	.globl	__truncdfsf2
	.globl	__subsf3
	.globl	__addsf3
	.align	2
	.globl	rotateX_pivot
	.type	rotateX_pivot, @function
rotateX_pivot:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# .result_ptr, tmp141
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp144
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s7,8(a2)		# _6, pivot_34(D)->z
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s8,4(a2)		# _3, pivot_34(D)->y
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,4(a1)		# p_33(D)->y, p_33(D)->y
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,8(a1)		# p_33(D)->z, p_33(D)->z
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	mv	s1,a1	# p, tmp142
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC2)	# tmp112,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	lui	s3,%hi(.LC4)	# tmp120,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s4,s4,s8	# _4, p_33(D)->y, _3
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC3)	# tmp114,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s6,s6,s7	# _7, p_33(D)->z, _6
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__divdf3		#
	call	__fixdfsi		#
	slli	s2,a0,16	#, _11, tmp145
	srai	s2,s2,16	#, _11, _11
	mv	a0,s2	#, _11
	call	sin1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s3)		#,
	lw	a3,%lo(.LC4+4)(s3)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	mv	s5,a0	# tmp122, tmp146
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	mv	a0,s2	#, _11
	call	cos1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s3)		#,
	lw	a3,%lo(.LC4+4)(s3)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s3,a0	# tmp127, tmp147
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _4
	call	__floatsisf		#
	mv	s4,a0	# _19, tmp148
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s6	#, _7
	call	__floatsisf		#
# gfx_lib_hdmi.h:273:   return transformed;
	lw	a5,0(s1)		# p_33(D)->x, p_33(D)->x
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s2,a0	# _21, tmp149
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s3	#, tmp127
# gfx_lib_hdmi.h:273:   return transformed;
	sw	a5,0(s0)	# p_33(D)->x, <retval>.x
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _19
	call	__mulsf3		#
	mv	s1,a0	# tmp129, tmp150
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, tmp122
	mv	a0,s2	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp151,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, tmp129
	call	__subsf3		#
	mv	s1,a0	# tmp131, tmp152
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s8	#, _3
	call	__floatsisf		#
	mv	a1,a0	# tmp153,
	mv	a0,s1	#, tmp131
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
	sw	a0,4(s0)	# tmp154, <retval>.y
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, tmp122
	mv	a0,s4	#, _19
	call	__mulsf3		#
	mv	s1,a0	# tmp135, tmp155
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s3	#, tmp127
	mv	a0,s2	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp156,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s1	#, tmp135
	call	__addsf3		#
	mv	s1,a0	# tmp137, tmp157
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s7	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp158,
	mv	a0,s1	#, tmp137
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp159, <retval>.z
# gfx_lib_hdmi.h:274: }
	lw	ra,44(sp)		#,
	mv	a0,s0	#, .result_ptr
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
	.size	rotateX_pivot, .-rotateX_pivot
	.align	2
	.globl	rotateY_pivot
	.type	rotateY_pivot, @function
rotateY_pivot:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# .result_ptr, tmp140
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp143
# gfx_lib_hdmi.h:276: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s7,0(a2)		# _2, pivot_34(D)->x
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,8(a2)		# _6, pivot_34(D)->z
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s8,4(a1)		# _4, p_33(D)->y
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s5,0(a1)		# p_33(D)->x, p_33(D)->x
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,8(a1)		# p_33(D)->z, p_33(D)->z
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC2)	# tmp112,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	lui	s4,%hi(.LC4)	# tmp120,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s5,s5,s7	# _3, p_33(D)->x, _2
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC3)	# tmp114,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s3,s3,s6	# _7, p_33(D)->z, _6
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__divdf3		#
	call	__fixdfsi		#
	slli	s1,a0,16	#, _11, tmp144
	srai	s1,s1,16	#, _11, _11
	mv	a0,s1	#, _11
	call	sin1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s4)		#,
	lw	a3,%lo(.LC4+4)(s4)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	mv	s2,a0	# tmp122, tmp145
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	mv	a0,s1	#, _11
	call	cos1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s4)		#,
	lw	a3,%lo(.LC4+4)(s4)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s4,a0	# tmp127, tmp146
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s5	#, _3
	call	__floatsisf		#
	mv	s1,a0	# _19, tmp147
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s3	#, _7
	call	__floatsisf		#
	mv	s3,a0	# _21, tmp148
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s4	#, tmp127
	mv	a0,s1	#, _19
	call	__mulsf3		#
	mv	s5,a0	# tmp128, tmp149
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s2	#, tmp122
	mv	a0,s3	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp150,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s5	#, tmp128
	call	__addsf3		#
	mv	s5,a0	# tmp130, tmp151
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp152,
	mv	a0,s5	#, tmp130
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
	sw	a0,0(s0)	# tmp153, <retval>.x
# gfx_lib_hdmi.h:288:   return transformed;
	sw	s8,4(s0)	# _4, <retval>.y
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s4	#, tmp127
	mv	a0,s3	#, _21
	call	__mulsf3		#
	mv	s3,a0	# tmp134, tmp154
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s2	#, tmp122
	mv	a0,s1	#, _19
	call	__mulsf3		#
	mv	a1,a0	# tmp155,
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s3	#, tmp134
	call	__subsf3		#
	mv	s1,a0	# tmp136, tmp156
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s6	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp157,
	mv	a0,s1	#, tmp136
	call	__addsf3		#
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp158, <retval>.z
# gfx_lib_hdmi.h:289: }
	lw	ra,44(sp)		#,
	mv	a0,s0	#, .result_ptr
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
	.size	rotateY_pivot, .-rotateY_pivot
	.align	2
	.globl	rotateZ_pivot
	.type	rotateZ_pivot, @function
rotateZ_pivot:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# .result_ptr, tmp140
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp143
# gfx_lib_hdmi.h:291: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s7,0(a2)		# _2, pivot_34(D)->x
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,4(a2)		# _5, pivot_34(D)->y
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s8,8(a1)		# _7, p_33(D)->z
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,0(a1)		# p_33(D)->x, p_33(D)->x
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s5,4(a1)		# p_33(D)->y, p_33(D)->y
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC2)	# tmp112,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	lui	s2,%hi(.LC4)	# tmp120,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s3,s3,s7	# _3, p_33(D)->x, _2
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC3)	# tmp114,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s5,s5,s6	# _6, p_33(D)->y, _5
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__divdf3		#
	call	__fixdfsi		#
	slli	s1,a0,16	#, _11, tmp144
	srai	s1,s1,16	#, _11, _11
	mv	a0,s1	#, _11
	call	sin1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s2)		#,
	lw	a3,%lo(.LC4+4)(s2)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	mv	s4,a0	# tmp122, tmp145
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	a0,s1	#, _11
	call	cos1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC4)(s2)		#,
	lw	a3,%lo(.LC4+4)(s2)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s2,a0	# tmp127, tmp146
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s3	#, _3
	call	__floatsisf		#
	mv	s3,a0	# _19, tmp147
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s5	#, _6
	call	__floatsisf		#
	mv	s1,a0	# _21, tmp148
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s2	#, tmp127
	mv	a0,s3	#, _19
	call	__mulsf3		#
	mv	s5,a0	# tmp128, tmp149
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, tmp122
	mv	a0,s1	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp150,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s5	#, tmp128
	call	__subsf3		#
	mv	s5,a0	# tmp130, tmp151
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp152,
	mv	a0,s5	#, tmp130
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	sw	a0,0(s0)	# tmp153, <retval>.x
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, tmp122
	mv	a0,s3	#, _19
	call	__mulsf3		#
	mv	s3,a0	# tmp134, tmp154
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s2	#, tmp127
	mv	a0,s1	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp155,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, tmp134
	call	__addsf3		#
	mv	s1,a0	# tmp136, tmp156
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s6	#, _5
	call	__floatsisf		#
	mv	a1,a0	# tmp157,
	mv	a0,s1	#, tmp136
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	sw	a0,4(s0)	# tmp158, <retval>.y
# gfx_lib_hdmi.h:303:   return transformed;
	sw	s8,8(s0)	# _7, <retval>.z
# gfx_lib_hdmi.h:304: }
	lw	ra,44(sp)		#,
	mv	a0,s0	#, .result_ptr
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
	.size	rotateZ_pivot, .-rotateZ_pivot
	.align	2
	.globl	render_lines
	.type	render_lines, @function
render_lines:
	addi	sp,sp,-144	#,,
	sw	s0,136(sp)	#,
	mv	s0,a5	# scalef, tmp217
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC5)	# tmp204,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	s5,116(sp)	#,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	s5,%lo(.LC5)(a5)		# tmp205,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC6)	# tmp206,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	s6,112(sp)	#,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	s6,%lo(.LC6)(a5)		# tmp207,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC7)	# tmp208,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	s7,108(sp)	#,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	s7,%lo(.LC7)(a5)		# tmp209,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC8)	# tmp210,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	s8,104(sp)	#,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	s8,%lo(.LC8)(a5)		# tmp211,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	s1,132(sp)	#,
	sw	s3,124(sp)	#,
	sw	s4,120(sp)	#,
	sw	s10,96(sp)	#,
	sw	s11,92(sp)	#,
	sw	ra,140(sp)	#,
	sw	s2,128(sp)	#,
	sw	s9,100(sp)	#,
# main_house3d_rotate_hdmi.c:65: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	mv	s11,a1	# s, tmp213
	sw	a2,4(sp)	# tmp214, %sfp
	mv	s3,a3	# angle_y, tmp215
	mv	s4,a4	# angle_z, tmp216
	mv	s1,a0	# ivtmp.421, tmp212
# main_house3d_rotate_hdmi.c:66:   for (int i = 0; i < s - 1; i = i + 2) {
	li	s10,0		# i,
.L209:
# main_house3d_rotate_hdmi.c:66:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	a5,s11,-1	#, tmp203, s
# main_house3d_rotate_hdmi.c:66:   for (int i = 0; i < s - 1; i = i + 2) {
	bgtu	a5,s10,.L210	#, tmp203, i,
# main_house3d_rotate_hdmi.c:91: }
	lw	ra,140(sp)		#,
	lw	s0,136(sp)		#,
	lw	s1,132(sp)		#,
	lw	s2,128(sp)		#,
	lw	s3,124(sp)		#,
	lw	s4,120(sp)		#,
	lw	s5,116(sp)		#,
	lw	s6,112(sp)		#,
	lw	s7,108(sp)		#,
	lw	s8,104(sp)		#,
	lw	s9,100(sp)		#,
	lw	s10,96(sp)		#,
	lw	s11,92(sp)		#,
	addi	sp,sp,144	#,,
	jr	ra		#
.L210:
# main_house3d_rotate_hdmi.c:67:     point p0 = points[i];
	mv	a1,s1	#, ivtmp.421
	li	a2,12		#,
	addi	a0,sp,44	#, tmp227,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:68:     point p1 = points[i + 1];
	addi	a1,s1,12	#,, ivtmp.421
	li	a2,12		#,
	addi	a0,sp,56	#, tmp228,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:71:     p0 = scale(&p0, scalef, scalef, scalef);
	mv	a4,s0	#, scalef
	mv	a3,s0	#, scalef
	mv	a2,s0	#, scalef
	addi	a1,sp,44	#, tmp229,
	addi	a0,sp,16	#,,
	call	scale		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,44	#, tmp230,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:72:     p1 = scale(&p1, scalef, scalef, scalef);
	mv	a4,s0	#, scalef
	mv	a3,s0	#, scalef
	mv	a2,s0	#, scalef
	addi	a1,sp,56	#, tmp231,
	addi	a0,sp,16	#,,
	call	scale		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,56	#, tmp232,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,s5	#, tmp205
	mv	a0,s0	#, scalef
	call	__mulsf3		#
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,a0	#, tmp133
	sw	a0,12(sp)	# tmp133, %sfp
	mv	a0,s6	#, tmp207
	call	__subsf3		#
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
	sw	a0,8(sp)	# _8, %sfp
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,s7	#, tmp209
	mv	a0,s0	#, scalef
	call	__mulsf3		#
	mv	a1,a0	# tmp220,
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a0,s8	#, tmp211
	call	__subsf3		#
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
	lw	a5,12(sp)		# tmp133, %sfp
	li	s2,-2147483648		# tmp141,
	mv	s9,a0	# _11, tmp221
	xor	a0,s2,a5	# tmp133,, tmp141
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a3,52(sp)		# p0.z, p0.z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a2,48(sp)		# p0.y, p0.y
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a4,8(sp)		# _8, %sfp
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a3,a0,a3	# p0.z, _59, _12
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a3,52(sp)	# _59, p0.z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a3,60(sp)		# p1.y, p1.y
	add	a2,s9,a2	# p0.y, _57, _11
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,44(sp)		# p0.x, p0.x
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s9,s9,a3	# p1.y, _51, _11
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a3,64(sp)		# p1.z, p1.z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a1,a1,a4	# _8, tmp144, p0.x
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a1,44(sp)	# tmp144, p0.x
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a5,a0,a3	# p1.z, _53, _12
# main_house3d_rotate_hdmi.c:75:     p1 = translate(&p1, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a5,64(sp)	# _53, p1.z
# main_house3d_rotate_hdmi.c:77:     point pivot = {HRES/2, VRES/2, 0};
	li	a5,40		# tmp150,
	sw	a5,68(sp)	# tmp150, pivot.x
	li	a5,30		# tmp151,
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a3,56(sp)		# p1.x, p1.x
# main_house3d_rotate_hdmi.c:77:     point pivot = {HRES/2, VRES/2, 0};
	sw	a5,72(sp)	# tmp151, pivot.y
# main_house3d_rotate_hdmi.c:79:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	lw	a5,4(sp)		# tmp233, %sfp
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a4,a3,a4	# _8, tmp148, p1.x
# main_house3d_rotate_hdmi.c:75:     p1 = translate(&p1, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a4,56(sp)	# tmp148, p1.x
# main_house3d_rotate_hdmi.c:79:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	xor	a0,s2,a5	# tmp233,, tmp141
# main_house3d_rotate_hdmi.c:74:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a2,48(sp)	# _57, p0.y
# main_house3d_rotate_hdmi.c:75:     p1 = translate(&p1, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	s9,60(sp)	# _51, p1.y
# main_house3d_rotate_hdmi.c:77:     point pivot = {HRES/2, VRES/2, 0};
	sw	zero,76(sp)	#, pivot.z
# main_house3d_rotate_hdmi.c:79:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	call	__fixsfsi		#
	mv	a3,a0	# _14, tmp223
	sw	a0,8(sp)	# _14, %sfp
	addi	a2,sp,68	#, tmp234,
	addi	a1,sp,44	#, tmp235,
	addi	a0,sp,16	#,,
	call	rotateX_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,44	#, tmp236,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:80:     p1 = rotateX_pivot(&p1, &pivot, -angle_x);
	lw	a3,8(sp)		# _14, %sfp
	addi	a2,sp,68	#, tmp237,
	addi	a1,sp,56	#, tmp238,
	addi	a0,sp,16	#,,
	call	rotateX_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,56	#, tmp239,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:81:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	xor	a0,s2,s3	# angle_y,, tmp141
	call	__fixsfsi		#
	mv	a3,a0	# _16, tmp224
	sw	a0,8(sp)	# _16, %sfp
	addi	a2,sp,68	#, tmp240,
	addi	a1,sp,44	#, tmp241,
	addi	a0,sp,16	#,,
	call	rotateY_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,44	#, tmp242,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:82:     p1 = rotateY_pivot(&p1, &pivot, -angle_y);
	lw	a3,8(sp)		# _16, %sfp
	addi	a2,sp,68	#, tmp243,
	addi	a1,sp,56	#, tmp244,
	addi	a0,sp,16	#,,
	call	rotateY_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,56	#, tmp245,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:83:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s4	#, angle_z
	call	__fixsfsi		#
	mv	a3,a0	# _17, tmp225
	sw	a0,8(sp)	# _17, %sfp
	addi	a2,sp,68	#, tmp246,
	addi	a1,sp,44	#, tmp247,
	addi	a0,sp,16	#,,
	call	rotateZ_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,44	#, tmp248,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:84:     p1 = rotateZ_pivot(&p1, &pivot, angle_z);
	lw	a3,8(sp)		# _17, %sfp
	addi	a2,sp,68	#, tmp249,
	addi	a1,sp,56	#, tmp250,
	addi	a0,sp,16	#,,
	call	rotateZ_pivot		#
	li	a2,12		#,
	addi	a1,sp,16	#,,
	addi	a0,sp,56	#, tmp251,
	call	memcpy		#
# main_house3d_rotate_hdmi.c:88:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	lw	a4,60(sp)		#, p1.y
	lw	a3,56(sp)		#, p1.x
	lw	a2,48(sp)		#, p0.y
	lw	a1,44(sp)		#, p0.x
	lui	a0,%hi(framebuffer)	# tmp202,
	li	a5,-1		#,
	addi	a0,a0,%lo(framebuffer)	#, tmp202,
	call	fb_draw_bresenham		#
# main_house3d_rotate_hdmi.c:66:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s10,s10,2	#, i, i
	addi	s1,s1,24	#, ivtmp.421, ivtmp.421
	j	.L209		#
	.size	render_lines, .-render_lines
	.globl	__gesf2
	.globl	__lesf2
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-64	#,,
	sw	s4,40(sp)	#,
# main_house3d_rotate_hdmi.c:99:   fill_oled(framebuffer, 0x0000);
	lui	s4,%hi(framebuffer)	# tmp88,
	li	a1,0		#,
	addi	a0,s4,%lo(framebuffer)	#, tmp88,
# main_house3d_rotate_hdmi.c:97: void main() {
	sw	s0,56(sp)	#,
	sw	s1,52(sp)	#,
	sw	s2,48(sp)	#,
	sw	s3,44(sp)	#,
	sw	s5,36(sp)	#,
	sw	s6,32(sp)	#,
	sw	s7,28(sp)	#,
	sw	s9,20(sp)	#,
	sw	s10,16(sp)	#,
	sw	s11,12(sp)	#,
	sw	ra,60(sp)	#,
	sw	s8,24(sp)	#,
# main_house3d_rotate_hdmi.c:99:   fill_oled(framebuffer, 0x0000);
	call	fill_oled		#
# main_house3d_rotate_hdmi.c:107:   *fb_ctrl = 0;
	li	a5,805306368		# tmp90,
# main_house3d_rotate_hdmi.c:109:   IO_OUT(GPIO_DIR, ~0);
	li	a4,-1		# tmp93,
# main_house3d_rotate_hdmi.c:107:   *fb_ctrl = 0;
	sw	zero,36(a5)	#, MEM[(uint32_t *)805306404B]
# main_house3d_rotate_hdmi.c:109:   IO_OUT(GPIO_DIR, ~0);
	sw	a4,20(a5)	# tmp93, MEM[(volatile uint32_t *)805306388B]
# main_house3d_rotate_hdmi.c:105:   float delta_scale = 0.1;//0.8; /* speedup scale */
	lui	a5,%hi(.LC9)	# tmp86,
	lw	s2,%lo(.LC9)(a5)		# delta_scale,
# main_house3d_rotate_hdmi.c:104:   float s = 4;
	lui	a5,%hi(.LC10)	# tmp87,
	lw	s0,%lo(.LC10)(a5)		# s,
# main_house3d_rotate_hdmi.c:128:     if (s >= 10) delta_scale = -delta_scale;
	lui	a5,%hi(.LC11)	# tmp138,
# main_house3d_rotate_hdmi.c:112:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	lui	s1,%hi(.LANCHOR2)	# tmp95,
# main_house3d_rotate_hdmi.c:128:     if (s >= 10) delta_scale = -delta_scale;
	lw	s11,%lo(.LC11)(a5)		# tmp137,
# main_house3d_rotate_hdmi.c:112:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	addi	s1,s1,%lo(.LANCHOR2)	# tmp94, tmp95,
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	s5,4096		# tmp127,
# main_house3d_rotate_hdmi.c:110:   uint8_t led = 0x01;
	li	s6,1		# led,
# main_house3d_rotate_hdmi.c:101:   int angle = 0;
	li	s3,0		# angle,
# main_house3d_rotate_hdmi.c:114:     render_lines(left_bottom, SIZEOF(left_bottom), angle,angle, angle,  s);
	addi	s9,s1,496	#, tmp102, tmp94
# main_house3d_rotate_hdmi.c:115:     render_lines(left_top, SIZEOF(left_top), angle,angle, angle,  s);
	addi	s10,s1,520	#, tmp105, tmp94
# main_house3d_rotate_hdmi.c:120:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	li	s7,805306368		# tmp116,
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	s5,s5,704	#, tmp126, tmp127
.L219:
# main_house3d_rotate_hdmi.c:112:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	mv	a0,s3	#, angle
	call	__floatsisf		#
	mv	s8,a0	# _1, tmp160
	mv	a4,a0	#, _1
	mv	a3,a0	#, _1
	mv	a2,a0	#, _1
	lui	a0,%hi(.LANCHOR2+40)	# tmp172,
	mv	a5,s0	#, s
	li	a1,26		#,
	addi	a0,a0,%lo(.LANCHOR2+40)	# tmp171, tmp172,
	call	render_lines		#
# main_house3d_rotate_hdmi.c:113:     render_lines(back, SIZEOF(back), angle,angle, angle,  s);
	lui	a0,%hi(.LANCHOR2+352)	# tmp174,
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, _1
	mv	a2,s8	#, _1
	li	a1,12		#,
	addi	a0,a0,%lo(.LANCHOR2+352)	# tmp173, tmp174,
	call	render_lines		#
# main_house3d_rotate_hdmi.c:114:     render_lines(left_bottom, SIZEOF(left_bottom), angle,angle, angle,  s);
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, _1
	mv	a2,s8	#, _1
	li	a1,2		#,
	mv	a0,s9	#, tmp102
	call	render_lines		#
# main_house3d_rotate_hdmi.c:115:     render_lines(left_top, SIZEOF(left_top), angle,angle, angle,  s);
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, _1
	mv	a2,s8	#, _1
	li	a1,2		#,
	mv	a0,s10	#, tmp105
	call	render_lines		#
# main_house3d_rotate_hdmi.c:116:     render_lines(right_bottom, SIZEOF(left_bottom), angle,angle, angle,  s);
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, _1
	mv	a2,s8	#, _1
	li	a1,2		#,
	addi	a0,s1,544	#,, tmp94
	call	render_lines		#
# main_house3d_rotate_hdmi.c:117:     render_lines(right_top, SIZEOF(left_top), angle,angle, angle,  s);
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, _1
	mv	a2,s8	#, _1
	li	a1,2		#,
	addi	a0,s1,568	#,, tmp94
	call	render_lines		#
# main_house3d_rotate_hdmi.c:118:     render_lines(roof, SIZEOF(roof), angle,angle, angle,  s);
	mv	a5,s0	#, s
	mv	a4,s8	#, _1
	mv	a3,s8	#, tmp14
	mv	a2,s8	#, tmp14
	li	a1,2		#,
	addi	a0,s1,592	#,, tmp94
	call	render_lines		#
# main_house3d_rotate_hdmi.c:120:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	lw	a5,36(s7)		# MEM[(uint32_t *)805306404B], MEM[(uint32_t *)805306404B]
# main_house3d_rotate_hdmi.c:120:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	li	a4,268435456		# iftmp.57_14,
# main_house3d_rotate_hdmi.c:120:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	andi	a5,a5,1	#, tmp117, MEM[(uint32_t *)805306404B]
# main_house3d_rotate_hdmi.c:120:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	bne	a5,zero,.L213	#, tmp117,,
	li	a4,268468224		# iftmp.57_14,
.L213:
# gfx_lib_hdmi.h:130:   dma_action((uint32_t) framebuffer, target_fb, VRES*HRES, DMA_MEMCPY);
	addi	a5,s4,%lo(framebuffer)	# framebuffer.47_37, tmp88,
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	sw	a5,44(s7)	# framebuffer.47_37, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a4,48(s7)	# iftmp.57_14, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a5,1		# tmp130,
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	s5,52(s7)	# tmp126, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	sw	a5,56(s7)	# tmp130, MEM[(volatile uint32_t *)805306424B]
# main_house3d_rotate_hdmi.c:121:     *fb_ctrl ^= 1;
	lw	a5,36(s7)		# MEM[(uint32_t *)805306404B], MEM[(uint32_t *)805306404B]
# main_house3d_rotate_hdmi.c:124:     angle += delta_angle;
	addi	s3,s3,-2	#, angle, angle
# main_house3d_rotate_hdmi.c:121:     *fb_ctrl ^= 1;
	xori	a5,a5,1	#, tmp135, MEM[(uint32_t *)805306404B]
	sw	a5,36(s7)	# tmp135, MEM[(uint32_t *)805306404B]
# main_house3d_rotate_hdmi.c:127:     if (angle < 0) angle = 359;
	bge	s3,zero,.L214	#, angle,,
# main_house3d_rotate_hdmi.c:127:     if (angle < 0) angle = 359;
	li	s3,359		# angle,
.L214:
# main_house3d_rotate_hdmi.c:128:     if (s >= 10) delta_scale = -delta_scale;
	mv	a1,s11	#, tmp137
	mv	a0,s0	#, s
	call	__gesf2		#
	blt	a0,zero,.L215	#, tmp161,,
# main_house3d_rotate_hdmi.c:128:     if (s >= 10) delta_scale = -delta_scale;
	li	a5,-2147483648		# tmp141,
	xor	s2,a5,s2	# delta_scale, delta_scale, tmp141
.L215:
# main_house3d_rotate_hdmi.c:129:     if (s <= 0) delta_scale = -delta_scale;
	mv	a1,zero	#,
	mv	a0,s0	#, s
	call	__lesf2		#
	bgt	a0,zero,.L217	#, tmp162,,
# main_house3d_rotate_hdmi.c:129:     if (s <= 0) delta_scale = -delta_scale;
	li	a5,-2147483648		# tmp144,
	xor	s2,a5,s2	# delta_scale, delta_scale, tmp144
.L217:
# main_house3d_rotate_hdmi.c:130:     s += delta_scale;
	mv	a1,s2	#, delta_scale
	mv	a0,s0	#, s
	call	__addsf3		#
	mv	s0,a0	# s, tmp163
# main_house3d_rotate_hdmi.c:132:     fill_oled(framebuffer, 0x000000);
	li	a1,0		#,
	addi	a0,s4,%lo(framebuffer)	#, tmp88,
	call	fill_oled		#
# main_house3d_rotate_hdmi.c:134:     led &= 7;
	andi	a0,s6,7	#, led, led
# main_house3d_rotate_hdmi.c:133:     IO_OUT(GPIO_OUTPUT, 0);
	sw	zero,28(s7)	#, MEM[(volatile uint32_t *)805306396B]
# main_house3d_rotate_hdmi.c:136:     gpio_set_value(led++, 1);
	li	a1,1		#,
# main_house3d_rotate_hdmi.c:136:     gpio_set_value(led++, 1);
	addi	s6,a0,1	#, led, led
# main_house3d_rotate_hdmi.c:136:     gpio_set_value(led++, 1);
	call	gpio_set_value		#
# main_house3d_rotate_hdmi.c:112:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	j	.L219		#
	.size	main, .-main
	.globl	roof
	.globl	right_bottom
	.globl	right_top
	.globl	left_bottom
	.globl	left_top
	.globl	back
	.globl	oled_8bit_init_seq
	.globl	framebuffer
	.globl	heap_memory_used
	.globl	heap_memory
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC2:
	.word	0
	.word	1088421888
	.align	3
.LC3:
	.word	0
	.word	1081507840
	.align	3
.LC4:
	.word	4194432
	.word	1056964640
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC5:
	.word	1084227584
	.align	2
.LC6:
	.word	1109393408
	.align	2
.LC7:
	.word	1097859072
	.align	2
.LC8:
	.word	1106247680
	.align	2
.LC9:
	.word	1036831949
	.align	2
.LC10:
	.word	1082130432
	.align	2
.LC11:
	.word	1092616192
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	sin90, @object
	.size	sin90, 66
sin90:
	.half	0
	.half	1607
	.half	3211
	.half	4807
	.half	6392
	.half	7961
	.half	9511
	.half	11038
	.half	12539
	.half	14009
	.half	15446
	.half	16845
	.half	18204
	.half	19519
	.half	20787
	.half	22004
	.half	23169
	.half	24278
	.half	25329
	.half	26318
	.half	27244
	.half	28105
	.half	28897
	.half	29621
	.half	30272
	.half	30851
	.half	31356
	.half	31785
	.half	32137
	.half	32412
	.half	32609
	.half	32727
	.half	32767
	.data
	.align	2
	.set	.LANCHOR2,. + 0
	.type	oled_8bit_init_seq, @object
	.size	oled_8bit_init_seq, 37
oled_8bit_init_seq:
	.string	"\256\2402\241"
	.string	"\242"
	.ascii	"\244\250?\255\216\260\013\2611\263\360\212d\213x\214d\273:\276"
	.ascii	">\207\006\201\221\202P\203}\257"
	.zero	3
	.type	front, @object
	.size	front, 312
front:
# x:
	.word	0
# y:
	.word	10
# z:
	.word	0
# x:
	.word	5
# y:
	.word	5
# z:
	.word	0
# x:
	.word	5
# y:
	.word	5
# z:
	.word	0
# x:
	.word	10
# y:
	.word	10
# z:
	.word	0
# x:
	.word	0
# y:
	.word	10
# z:
	.word	0
# x:
	.word	10
# y:
	.word	10
# z:
	.word	0
# x:
	.word	10
# y:
	.word	10
# z:
	.word	0
# x:
	.word	10
# y:
	.word	20
# z:
	.word	0
# x:
	.word	10
# y:
	.word	20
# z:
	.word	0
# x:
	.word	0
# y:
	.word	20
# z:
	.word	0
# x:
	.word	0
# y:
	.word	20
# z:
	.word	0
# x:
	.word	0
# y:
	.word	10
# z:
	.word	0
# x:
	.word	8
# y:
	.word	20
# z:
	.word	0
# x:
	.word	8
# y:
	.word	17
# z:
	.word	0
# x:
	.word	8
# y:
	.word	17
# z:
	.word	0
# x:
	.word	6
# y:
	.word	17
# z:
	.word	0
# x:
	.word	6
# y:
	.word	17
# z:
	.word	0
# x:
	.word	6
# y:
	.word	20
# z:
	.word	0
# x:
	.word	1
# y:
	.word	13
# z:
	.word	0
# x:
	.word	4
# y:
	.word	13
# z:
	.word	0
# x:
	.word	4
# y:
	.word	13
# z:
	.word	0
# x:
	.word	4
# y:
	.word	16
# z:
	.word	0
# x:
	.word	4
# y:
	.word	16
# z:
	.word	0
# x:
	.word	1
# y:
	.word	16
# z:
	.word	0
# x:
	.word	1
# y:
	.word	16
# z:
	.word	0
# x:
	.word	1
# y:
	.word	13
# z:
	.word	0
	.type	back, @object
	.size	back, 144
back:
# x:
	.word	0
# y:
	.word	10
# z:
	.word	10
# x:
	.word	5
# y:
	.word	5
# z:
	.word	10
# x:
	.word	5
# y:
	.word	5
# z:
	.word	10
# x:
	.word	10
# y:
	.word	10
# z:
	.word	10
# x:
	.word	0
# y:
	.word	10
# z:
	.word	10
# x:
	.word	10
# y:
	.word	10
# z:
	.word	10
# x:
	.word	10
# y:
	.word	10
# z:
	.word	10
# x:
	.word	10
# y:
	.word	20
# z:
	.word	10
# x:
	.word	10
# y:
	.word	20
# z:
	.word	10
# x:
	.word	0
# y:
	.word	20
# z:
	.word	10
# x:
	.word	0
# y:
	.word	20
# z:
	.word	10
# x:
	.word	0
# y:
	.word	10
# z:
	.word	10
	.type	left_bottom, @object
	.size	left_bottom, 24
left_bottom:
# x:
	.word	0
# y:
	.word	20
# z:
	.word	0
# x:
	.word	0
# y:
	.word	20
# z:
	.word	10
	.type	left_top, @object
	.size	left_top, 24
left_top:
# x:
	.word	0
# y:
	.word	10
# z:
	.word	0
# x:
	.word	0
# y:
	.word	10
# z:
	.word	10
	.type	right_bottom, @object
	.size	right_bottom, 24
right_bottom:
# x:
	.word	10
# y:
	.word	20
# z:
	.word	0
# x:
	.word	10
# y:
	.word	20
# z:
	.word	10
	.type	right_top, @object
	.size	right_top, 24
right_top:
# x:
	.word	10
# y:
	.word	10
# z:
	.word	0
# x:
	.word	10
# y:
	.word	10
# z:
	.word	10
	.type	roof, @object
	.size	roof, 24
roof:
# x:
	.word	5
# y:
	.word	5
# z:
	.word	0
# x:
	.word	5
# y:
	.word	5
# z:
	.word	10
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory, @object
	.size	heap_memory, 1024
heap_memory:
	.zero	1024
	.type	framebuffer, @object
	.size	framebuffer, 19200
framebuffer:
	.zero	19200
	.section	.sbss,"aw",@nobits
	.align	2
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.ident	"GCC: (GNU) 11.1.0"
