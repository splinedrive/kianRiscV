	.file	"main_sphere3d_hdmi.c"
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
# options passed: -march=rv32im -mabi=ilp32 -mtune=rocket -march=rv32im -O3 -fno-pic -fno-stack-protector -ffreestanding
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
	lw	a4,0(a0)		# _1,* p
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp85,
	sll	a5,a5,a1	# tmp88, _12, tmp85
# kianv_stdlib.h:124:     if (bit) {
	beq	a2,zero,.L7	#, tmp89,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a4	# _1, _5, _12
	sw	a5,0(a0)	# _5,* p
	ret	
.L7:
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp86, _12
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a4	# _13, _18, tmp86
	sw	a5,0(a0)	# _18,* p
# kianv_stdlib.h:129: }
	ret	
	.size	set_reg, .-set_reg
	.align	2
	.globl	gpio_set_value
	.type	gpio_set_value, @function
gpio_set_value:
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,28(a4)		# _7,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _6, tmp84
# kianv_stdlib.h:124:     if (bit) {
	beq	a1,zero,.L10	#, tmp95,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _7, _11, _6
	sw	a5,28(a4)	# _11,
# kianv_stdlib.h:133: }
	ret	
.L10:
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _6
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,28(a4)	# _17,
# kianv_stdlib.h:133: }
	ret	
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
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,20(a4)		# _4,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _19, tmp84
# kianv_stdlib.h:124:     if (bit) {
	beq	a1,zero,.L14	#, tmp95,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,20(a4)	# _8,
	ret	
.L14:
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _19
# kianv_stdlib.h:127:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,20(a4)	# _17,
# kianv_stdlib.h:144: }
	ret	
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
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp86
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp86, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp87
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp87, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_5, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,4(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	add	a5,a5,a1	# wait, tmp126, tmph0.0_5
	add	a2,a0,a2	# tmpl0.1_8, tmp129, wait
	sltu	a0,a2,a0	# wait, tmp98, tmp129
	add	a4,a0,a5	# tmp126, tmp100, tmp98
.L21:
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp101
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp101, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp102
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp102, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_11, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,12(sp)		# tmpl0.1_14, tmpl0
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	bgtu	a4,a5,.L21	#, tmp100, tmph0.0_11,
	bne	a4,a5,.L18	#, tmp100, tmph0.0_11,
	bgtu	a2,a3,.L21	#, tmp129, tmpl0.1_14,
.L18:
# kianv_stdlib.h:165: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L32	#, us,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib.h:167: void usleep(uint32_t us) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a3	# tmp93
# 0 "" 2
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
 #NO_APP
	li	a4,999424		# tmp97,
	addi	a4,a4,576	#, tmp96, tmp97
	divu	a5,a5,a4	# tmp96, tmp95, _20
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a3,12(sp)	# tmp93, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	mul	a5,a5,a0	# tmp98, tmp95, us
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp141, tmp98
	sltu	a5,a2,a5	# tmp98, tmp110, tmp141
	add	a5,a5,a4	# tmph0.0_7, tmp112, tmp110
.L29:
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp113, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp114
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp114, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	bgtu	a5,a4,.L29	#, tmp112, tmph0.0_14,
	bne	a5,a4,.L23	#, tmp112, tmph0.0_14,
	bgtu	a2,a3,.L29	#, tmp141, tmpl0.1_17,
.L23:
# kianv_stdlib.h:169: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L32:
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L44	#, ms,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib.h:171: void msleep(uint32_t ms) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp93
# 0 "" 2
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
 #NO_APP
	li	a3,1000		# tmp95,
	divu	a5,a5,a3	# tmp95, tmp96, _20
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a4,12(sp)	# tmp93, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a5,a5,a0	# tmp97, tmp96, ms
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp140, tmp97
	sltu	a5,a2,a5	# tmp97, tmp109, tmp140
	add	a5,a5,a4	# tmph0.0_7, tmp111, tmp109
.L41:
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp112
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp112, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp113, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	bgtu	a5,a4,.L41	#, tmp111, tmph0.0_14,
	bne	a5,a4,.L35	#, tmp111, tmph0.0_14,
	bgtu	a2,a3,.L41	#, tmp140, tmpl0.1_17,
.L35:
# kianv_stdlib.h:173: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L44:
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:176:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L56	#, sec,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp90,
# kianv_stdlib.h:175: void sleep(uint32_t sec) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a4,16(a5)		# _19, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp91
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp91, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp92
# 0 "" 2
# kianv_stdlib.h:176:   if (sec) wait_cycles(sec * get_cpu_freq());
 #NO_APP
	mul	a0,a0,a4	# tmp101, sec, _19
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a5,12(sp)	# tmp92, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:162:   uint64_t lim = get_cycles() + wait;
	add	a0,a4,a0	# tmp101, tmp136, tmpl0.1_9
	sltu	a4,a0,a4	# tmpl0.1_9, tmp105, tmp136
	add	a4,a4,a5	# tmph0.0_6, tmp107, tmp105
.L53:
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp108
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp108, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp109
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp109, tmpl0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_13, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_16, tmpl0
# kianv_stdlib.h:163:   while (get_cycles() < lim)
	bgtu	a4,a5,.L53	#, tmp107, tmph0.0_13,
	bne	a4,a5,.L47	#, tmp107, tmph0.0_13,
	bgtu	a0,a3,.L53	#, tmp136, tmpl0.1_16,
.L47:
# kianv_stdlib.h:177: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L56:
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:180:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	li	a5,999424		# tmp98,
	addi	a5,a5,576	#, tmp97, tmp98
# kianv_stdlib.h:180:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	divu	a2,a2,a5	# tmp97,, _5
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:181: }
	lw	ra,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	nanoseconds, .-nanoseconds
	.align	2
	.globl	milliseconds
	.type	milliseconds, @function
milliseconds:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:184:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	li	a5,1000		# tmp96,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp96,, _5
	call	__udivdi3		#
# kianv_stdlib.h:185: }
	lw	ra,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	milliseconds, .-milliseconds
	.align	2
	.globl	seconds
	.type	seconds, @function
seconds:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
# kianv_stdlib.h:150:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 150 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp81
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp81, tmph0
# kianv_stdlib.h:151:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 151 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp82, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp84,
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_5, tmph0
# kianv_stdlib.h:153:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib.h:158:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _4, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:188:   return get_cycles() / (uint64_t) (get_cpu_freq());
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:189: }
	lw	ra,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp75,
.L66:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L66	#, _1,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a4)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	li	a5,13		# tmp77,
	beq	a0,a5,.L70	#, c, tmp77,
# kianv_stdlib.h:198: }
	ret	
.L70:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp79,
	sw	a5,0(a4)	# tmp79, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:198: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
	li	a4,805306368		# tmp75,
.L72:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L72	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	li	a5,13		# tmp77,
	beq	a0,a5,.L76	#, ch, tmp77,
	ret	
.L76:
	li	a5,10		# tmp79,
	sw	a5,0(a4)	# tmp79, MEM[(volatile uint32_t *)805306368B]
	ret	
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_char
	.type	print_char, @function
print_char:
	li	a4,805306368		# tmp75,
.L78:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L78	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	li	a5,13		# tmp77,
	beq	a0,a5,.L82	#, ch, tmp77,
	ret	
.L82:
	li	a5,10		# tmp79,
	sw	a5,0(a4)	# tmp79, MEM[(volatile uint32_t *)805306368B]
	ret	
	.size	print_char, .-print_char
	.align	2
	.globl	print_str
	.type	print_str, @function
print_str:
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, *p_6(D)
# kianv_stdlib.h:209:   while (*p != 0) {
	beq	a3,zero,.L83	#, _3,,
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp77,
# kianv_stdlib.h:195:    if (c == 13) {
	li	a2,13		# tmp80,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp83,
.L85:
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L85	#, _1,,
# kianv_stdlib.h:212:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L86:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _9, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L86	#, _9,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a3,a2,.L100	#, _3, tmp80,
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L85	#, _3,,
.L83:
# kianv_stdlib.h:214: }
	ret	
.L100:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp83, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L85	#, _3,,
	ret	
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, *p_2(D)
# kianv_stdlib.h:209:   while (*p != 0) {
	beq	a3,zero,.L102	#, _9,,
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp78,
# kianv_stdlib.h:195:    if (c == 13) {
	li	a2,13		# tmp81,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp89,
.L103:
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _5, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L103	#, _5,,
# kianv_stdlib.h:212:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L104:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _8, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L104	#, _8,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _9, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a3,a2,.L121	#, _9, tmp81,
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, MEM[(char *)p_7]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L103	#, _9,,
.L102:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp84,
.L108:
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L108	#, _3,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,13		# tmp86,
	sw	a5,0(a4)	# tmp86, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp88,
	sw	a5,0(a4)	# tmp88, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:219: }
	ret	
.L121:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp89, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, MEM[(char *)p_7]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L103	#, _9,,
	j	.L102		#
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:223:   char *p = buffer;
	addi	a2,sp,4	#, tmp92,
	mv	a4,a2	# p, tmp92
# kianv_stdlib.h:225:     *(p++) = val % 10;
	li	a5,10		# tmp93,
.L123:
# kianv_stdlib.h:224:   while (val || p == buffer) {
	bne	a0,zero,.L124	#, val,,
# kianv_stdlib.h:224:   while (val || p == buffer) {
	bne	a4,a2,.L131	#, p, tmp92,
.L124:
# kianv_stdlib.h:225:     *(p++) = val % 10;
	remu	a3,a0,a5	# tmp93, tmp83, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	addi	a4,a4,1	#, p, p
# kianv_stdlib.h:226:     val = val / 10;
	divu	a0,a0,a5	# tmp93, val, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	sb	a3,-1(a4)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L123		#
.L131:
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp88,
.L125:
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L125	#, _3,,
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a4)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,-1	#, p, p
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a3)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:229:   while (p != buffer) {
	bne	a4,a2,.L125	#, p, tmp92,
# kianv_stdlib.h:234: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	print_dec, .-print_dec
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-32	#,,
# kianv_stdlib.h:240:     *(p++) = val % 10;
	li	t4,-858992640		# tmp258,
# kianv_stdlib.h:238:   char *p = buffer;
	addi	t3,sp,12	#, tmp254,
# kianv_stdlib.h:240:     *(p++) = val % 10;
	li	t1,268435456		# tmp255,
	addi	a7,t4,-819	#, tmp259, tmp258
# kianv_stdlib.h:236: void print_dec64(uint64_t val) {
	mv	a4,a0	# val, tmp261
	mv	a6,a1	# val, tmp262
# kianv_stdlib.h:238:   char *p = buffer;
	mv	a2,t3	# p, tmp254
# kianv_stdlib.h:240:     *(p++) = val % 10;
	addi	t1,t1,-1	#, tmp256, tmp255
	li	t5,5		# tmp257,
	addi	t4,t4,-820	#, tmp260, tmp258
# kianv_stdlib.h:239:   while (val || p == buffer) {
	j	.L133		#
.L134:
# kianv_stdlib.h:240:     *(p++) = val % 10;
	remu	a5,a5,t5	# tmp257, tmp97, tmp94
# kianv_stdlib.h:240:     *(p++) = val % 10;
	addi	a2,a2,1	#, p, p
# kianv_stdlib.h:240:     *(p++) = val % 10;
	sub	a5,a4,a5	# tmp214, val, tmp97
	sgtu	a1,a5,a4	# tmp101, tmp214, val
	sub	a1,a6,a1	# tmp103, val, tmp101
	mul	a0,a5,t4	# tmp107, tmp214, tmp260
	mul	a1,a1,a7	# tmp104, tmp103, tmp259
	mulhu	a3,a5,a7	# tmp217, tmp214, tmp259
	add	a1,a1,a0	# tmp107, tmp110, tmp104
	mul	a5,a5,a7	# tmp114, tmp214, tmp259
	add	a1,a1,a3	# tmp217, tmp115, tmp110
	slli	a3,a1,31	#, tmp133, tmp115
# kianv_stdlib.h:241:     val = val / 10;
	srli	a6,a1,1	#, val, tmp115
# kianv_stdlib.h:240:     *(p++) = val % 10;
	srli	a5,a5,1	#, tmp224, tmp114
	or	a5,a3,a5	# tmp224, tmp224, tmp133
	slli	a0,a5,2	#, tmp228, tmp224
	add	a0,a0,a5	# tmp224, tmp230, tmp228
	slli	a0,a0,1	#, tmp232, tmp230
	sub	a0,a4,a0	# tmp234, val, tmp232
# kianv_stdlib.h:240:     *(p++) = val % 10;
	sb	a0,-1(a2)	# tmp234, MEM[(char *)p_18 + 4294967295B]
# kianv_stdlib.h:241:     val = val / 10;
	mv	a4,a5	# val, tmp224
.L133:
# kianv_stdlib.h:240:     *(p++) = val % 10;
	slli	a5,a6,4	#, tmp88, val
	srli	a3,a4,28	#, tmp208, val
	or	a3,a5,a3	# tmp208, tmp208, tmp88
	and	a3,a3,t1	# tmp256, tmp89, tmp208
	and	a5,a4,t1	# tmp256, tmp84, val
	add	a5,a5,a3	# tmp89, tmp92, tmp84
	srli	a1,a6,24	#, tmp210, val
# kianv_stdlib.h:239:   while (val || p == buffer) {
	or	a3,a4,a6	# val, val, val
# kianv_stdlib.h:240:     *(p++) = val % 10;
	add	a5,a5,a1	# tmp210, tmp94, tmp92
# kianv_stdlib.h:239:   while (val || p == buffer) {
	bne	a3,zero,.L134	#, val,,
# kianv_stdlib.h:239:   while (val || p == buffer) {
	beq	a2,t3,.L134	#, p, tmp254,
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp202,
.L135:
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L135	#, _3,,
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a2,a2,-1	#, p, p
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:244:   while (p != buffer) {
	bne	a2,t3,.L135	#, p, tmp254,
# kianv_stdlib.h:249: }
	addi	sp,sp,32	#,,
	jr	ra		#
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
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a3,a1,-1	#, tmp85, tmp98
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a3,a3,2	#, i, tmp85
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	blt	a3,zero,.L141	#, i,,
	lui	a2,%hi(.LC0)	# tmp95,
	li	a1,-4		# _8,
	addi	a2,a2,%lo(.LC0)	# tmp94, tmp95,
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp87,
.L143:
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L143	#, _2,,
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a3	# i, tmp90, val
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp91, tmp90
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a2,a5	# tmp91, tmp92, tmp94
	lbu	a5,0(a5)	# _6, "0123456789ABCDEF"[_4]
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a3,a3,-4	#, i, i
# kianv_stdlib.h:255:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a4)	# _6, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:252:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bne	a1,a3,.L143	#, _8, i,
.L141:
# kianv_stdlib.h:257: }
	ret	
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
	addi	sp,sp,-32	#,,
# kianv_stdlib.h:277:   int dx =  abs(x1 - x0);
	sub	a0,a3,a1	#, x1, x0
# kianv_stdlib.h:275: {
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s1,20(sp)	#,
	mv	s0,a1	# x0, tmp114
	mv	s1,a2	# y0, tmp115
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	sw	s4,8(sp)	#,
	mv	s3,a5	# color, tmp118
	mv	s4,a3	# x1, tmp116
	sw	s5,4(sp)	#,
	sw	s6,0(sp)	#,
# kianv_stdlib.h:275: {
	mv	s6,a4	# y1, tmp117
# kianv_stdlib.h:277:   int dx =  abs(x1 - x0);
	call	abs		#
	mv	s2,a0	# tmp119,
# kianv_stdlib.h:279:   int dy = -abs(y1 - y0);
	sub	a0,s6,s1	#, y1, y0
	call	abs		#
# kianv_stdlib.h:278:   int sx = x0 < x1 ? 1 : -1;
	sgt	s5,s4,s0	# tmp109, x1, x0
# kianv_stdlib.h:280:   int sy = y0 < y1 ? 1 : -1;
	sgt	t5,s6,s1	# tmp112, y1, y0
# kianv_stdlib.h:278:   int sx = x0 < x1 ? 1 : -1;
	slli	s5,s5,1	#, iftmp.6_9, tmp109
# kianv_stdlib.h:280:   int sy = y0 < y1 ? 1 : -1;
	slli	t5,t5,1	#, iftmp.7_10, tmp112
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a3,65536		# tmp103,
# kianv_stdlib.h:278:   int sx = x0 < x1 ? 1 : -1;
	addi	s5,s5,-1	#, iftmp.6_9, iftmp.6_9
# kianv_stdlib.h:279:   int dy = -abs(y1 - y0);
	neg	t4,a0	# dy, _3
# kianv_stdlib.h:280:   int sy = y0 < y1 ? 1 : -1;
	addi	t5,t5,-1	#, iftmp.7_10, iftmp.7_10
	sub	a6,s2,a0	# err, dx, _3
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	t1,s3,16	#, _33, color
	andi	a7,s1,255	#, tmp106, y0
	slli	a1,s0,8	#, tmp107, x0
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	addi	a3,a3,-1	#, tmp102, tmp103
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	t3,805306368		# tmp105,
.L152:
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a7,t1	# _33, tmp99, tmp106
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	and	a2,a1,a3	# tmp102, tmp101, tmp107
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a5,a2	# tmp101, _40, tmp99
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a5,8(t3)	# _40, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:286:     e2 = 2*err;
	slli	a5,a6,1	#, e2, err
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s4,.L160	#, x0, x1,
.L153:
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t4,a5,.L155	#, dy, e2,
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s0,s0,s5	# iftmp.6_9, x0, x0
	sub	a6,a6,a0	# err, err, _3
	slli	a1,s0,8	#, tmp107, x0
.L155:
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a5,.L152	#, dx, e2,
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s1,s1,t5	# iftmp.7_10, y0, y0
	andi	a7,s1,255	#, tmp106, y0
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a7,t1	# _33, tmp99, tmp106
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	and	a2,a1,a3	# tmp102, tmp101, tmp107
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a5,a2	# tmp101, _40, tmp99
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a6,a6,s2	# dx, err, err
# kianv_stdlib.h:271: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a5,8(t3)	# _40, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:286:     e2 = 2*err;
	slli	a5,a6,1	#, e2, err
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s4,.L153	#, x0, x1,
.L160:
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s6,.L153	#, y0, y1,
# kianv_stdlib.h:290: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	lw	s5,4(sp)		#,
	lw	s6,0(sp)		#,
	addi	sp,sp,32	#,,
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
	addi	sp,sp,-96	#,,
	sw	s0,60(sp)	#,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	lbu	t1,0(a0)	# _14, *format_22(D)
# stdlib.c:90: {
	sw	a5,84(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	addi	a5,sp,68	#, tmp119,
# stdlib.c:90: {
	sw	a1,68(sp)	#,
	sw	a2,72(sp)	#,
	sw	a3,76(sp)	#,
	sw	a4,80(sp)	#,
	sw	a6,88(sp)	#,
	sw	a7,92(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	sw	a5,12(sp)	# tmp119, MEM[(void * *)&ap]
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	beq	t1,zero,.L164	#, _14,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	li	a3,0		# i,
# stdlib.c:97: 		if (format[i] == '%') {
	li	t2,37		# tmp120,
# stdlib.c:99: 				if (format[i] == 'c') {
	li	a7,99		# tmp205,
# stdlib.c:103: 				if (format[i] == 's') {
	li	t3,115		# tmp206,
# stdlib.c:107: 				if (format[i] == 'd') {
	li	t4,100		# tmp207,
# stdlib.c:111: 				if (format[i] == 'u') {
	li	t5,117		# tmp208,
# stdlib.c:78: 	char *p = buffer;
	addi	t6,sp,16	#, tmp213,
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	li	a1,10		# tmp214,
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp215,
# kianv_stdlib.h:195:    if (c == 13) {
	li	t0,13		# tmp216,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	li	s0,45		# tmp218,
.L189:
# stdlib.c:97: 		if (format[i] == '%') {
	beq	t1,t2,.L165	#, _14, tmp120,
.L166:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _42, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L166	#, _42,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	t1,0(a5)	# _14, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	t1,t0,.L218	#, _14, tmp216,
.L169:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	a3,a3,1	#, i, i
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a4,a0,a3	# i, tmp193, format
	lbu	t1,0(a4)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	t1,zero,.L189	#, _14,,
.L164:
# stdlib.c:121: }
	lw	s0,60(sp)		#,
	li	a0,0		#,
	addi	sp,sp,96	#,,
	jr	ra		#
.L188:
# stdlib.c:99: 				if (format[i] == 'c') {
	beq	a4,a7,.L219	#, _10, tmp205,
# stdlib.c:103: 				if (format[i] == 's') {
	beq	a4,t3,.L220	#, _10, tmp206,
# stdlib.c:107: 				if (format[i] == 'd') {
	beq	a4,t4,.L221	#, _10, tmp207,
# stdlib.c:111: 				if (format[i] == 'u') {
	beq	a4,t5,.L222	#, _10, tmp208,
.L165:
# stdlib.c:98: 			while (format[++i]) {
	addi	a3,a3,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a4,a0,a3	# i, tmp187, format
	lbu	a4,0(a4)	# _10, MEM[(const char *)_131]
# stdlib.c:98: 			while (format[++i]) {
	bne	a4,zero,.L188	#, _10,,
	j	.L169		#
.L219:
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a4,12(sp)		# D.2659, ap
	lw	a2,0(a4)		# _4, MEM[(int *)_121]
	addi	a4,a4,4	#, D.2660, D.2659
	sw	a4,12(sp)	# D.2660, ap
# stdlib.c:49:     print_chr(c);
	andi	a6,a2,0xff	# _33, _4
.L168:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _34, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L168	#, _34,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	andi	a2,a2,255	#, _36, _4
	sw	a2,0(a5)	# _36, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	bne	a6,t0,.L169	#, _33, tmp216,
.L218:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214,
	j	.L169		#
.L220:
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a4,12(sp)		# D.2661, ap
	lw	a6,0(a4)		# p, MEM[(char * *)_87]
	addi	a4,a4,4	#, D.2662, D.2661
	sw	a4,12(sp)	# D.2662, ap
.L217:
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _40,* p
	beq	a2,zero,.L169	#, _40,,
.L174:
# stdlib.c:56:     print_chr(*(p++));
	addi	a6,a6,1	#, p, p
.L171:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _39, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L171	#, _39,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a2,0(a5)	# _40, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	bne	a2,t0,.L217	#, _40, tmp216,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _40,* p
	bne	a2,zero,.L174	#, _40,,
	j	.L169		#
.L221:
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a2,12(sp)		# D.2663, ap
	lw	a4,0(a2)		# val, MEM[(int *)_122]
	addi	a2,a2,4	#, D.2664, D.2663
	sw	a2,12(sp)	# D.2664, ap
# stdlib.c:63: 	if (val < 0) {
	blt	a4,zero,.L177	#, val,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp213
.L178:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	a4,zero,.L179	#, val,,
	bne	a2,t6,.L182	#, p, tmp213,
.L179:
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	rem	a6,a4,a1	# tmp214, tmp145, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	a2,a2,1	#, p, p
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	a6,a6,48	#, tmp147, tmp145
# stdlib.c:69: 		val = val / 10;
	div	a4,a4,a1	# tmp214, val, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	sb	a6,-1(a2)	# tmp147, MEM[(char *)p_59 + 4294967295B]
	j	.L178		#
.L177:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a2,0(a5)		# _53, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a2,zero,.L177	#, _53,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	s0,0(a5)	# tmp218, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:65: 		val = -val;
	neg	a4,a4	# val, val
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp213
	j	.L178		#
.L224:
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a6,0(a5)	# _64, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a6,t0,.L223	#, _64, tmp216,
# stdlib.c:71: 	while (p != buffer)
	beq	a2,t6,.L169	#, p, tmp213,
.L182:
# stdlib.c:72: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _64, MEM[(char *)p_63]
# stdlib.c:72: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L180:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _65, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L180	#, _65,,
	j	.L224		#
.L223:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:71: 	while (p != buffer)
	bne	a2,t6,.L182	#, p, tmp213,
	j	.L169		#
.L222:
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a6,12(sp)		# D.2665, ap
# stdlib.c:78: 	char *p = buffer;
	mv	a2,t6	# p, tmp213
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a4,0(a6)		# MEM[(int *)_125], MEM[(int *)_125]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a6,a6,4	#, D.2666, D.2665
	sw	a6,12(sp)	# D.2666, ap
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a6,a4,31	#, tmp163, MEM[(int *)_125]
	xor	a4,a6,a4	# MEM[(int *)_125], val, tmp163
	sub	a4,a4,a6	# val, val, tmp163
.L183:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a4,zero,.L184	#, val,,
	bne	a2,t6,.L187	#, p, tmp213,
.L184:
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	rem	a6,a4,a1	# tmp214, tmp171, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	a2,a2,1	#, p, p
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	a6,a6,48	#, tmp173, tmp171
# stdlib.c:83: 		val = val / 10;
	div	a4,a4,a1	# tmp214, val, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	sb	a6,-1(a2)	# tmp173, MEM[(char *)p_75 + 4294967295B]
	j	.L183		#
.L226:
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a6,0(a5)	# _80, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a6,t0,.L225	#, _80, tmp216,
# stdlib.c:85: 	while (p != buffer)
	beq	a2,t6,.L169	#, p, tmp213,
.L187:
# stdlib.c:86: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _80, MEM[(char *)p_79]
# stdlib.c:86: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L185:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _81, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L185	#, _81,,
	j	.L226		#
.L225:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:85: 	while (p != buffer)
	bne	a2,t6,.L187	#, p, tmp213,
	j	.L169		#
	.size	printf, .-printf
	.align	2
	.globl	malloc
	.type	malloc, @function
malloc:
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	lui	a3,%hi(heap_memory_used)	# tmp77,
	lw	a4,%lo(heap_memory_used)(a3)		# heap_memory_used.19_1, heap_memory_used
# stdlib.c:128: 	heap_memory_used += size;
	add	a5,a4,a0	# tmp83, _3, heap_memory_used.19_1
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	lui	a0,%hi(.LANCHOR0)	# tmp79,
# stdlib.c:128: 	heap_memory_used += size;
	sw	a5,%lo(heap_memory_used)(a3)	# _3, heap_memory_used
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	addi	a0,a0,%lo(.LANCHOR0)	# tmp78, tmp79,
# stdlib.c:129: 	if (heap_memory_used > 1024)
	li	a3,1024		# tmp81,
# stdlib.c:126: 	char *p = heap_memory + heap_memory_used;
	add	a0,a0,a4	# heap_memory_used.19_1, <retval>, tmp78
# stdlib.c:129: 	if (heap_memory_used > 1024)
	ble	a5,a3,.L227	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L227:
# stdlib.c:132: }
	ret	
	.size	malloc, .-malloc
	.align	2
	.globl	memcpy
	.type	memcpy, @function
memcpy:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	addi	a7,a2,-1	#, n, n
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a2,zero,.L230	#, n,,
	addi	a4,a1,1	#, bb, bb
	sub	a5,a0,a4	# tmp111, aa, bb
	sltiu	a5,a5,3	#, tmp114, tmp111
	sltiu	a3,a7,7	#, tmp117, n
	xori	a5,a5,1	#, tmp113, tmp114
	xori	a3,a3,1	#, tmp116, tmp117
	and	a5,a5,a3	# tmp116, tmp120, tmp113
	beq	a5,zero,.L231	#, tmp120,,
	or	a5,a0,a1	# bb, tmp121, aa
	andi	a5,a5,3	#, tmp122, tmp121
	bne	a5,zero,.L231	#, tmp122,,
	andi	a6,a2,-4	#, tmp127, n
	mv	a5,a1	# ivtmp.330, bb
	mv	a4,a0	# ivtmp.333, aa
	add	a6,a6,a1	# bb, _77, tmp127
.L232:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lw	a3,0(a5)		# vect__1.316, MEM <const vector(4) char> [(const char *)_43]
	addi	a5,a5,4	#, ivtmp.330, ivtmp.330
	addi	a4,a4,4	#, ivtmp.333, ivtmp.333
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sw	a3,-4(a4)	# vect__1.316, MEM <vector(4) char> [(char *)_45]
	bne	a5,a6,.L232	#, ivtmp.330, _77,
	andi	a5,a2,-4	#, niters_vector_mult_vf.310, n
	add	a4,a0,a5	# niters_vector_mult_vf.310, tmp.311, aa
	add	a1,a1,a5	# niters_vector_mult_vf.310, tmp.312, bb
	sub	a7,a7,a5	# tmp.313, n, niters_vector_mult_vf.310
	beq	a2,a5,.L230	#, n, niters_vector_mult_vf.310,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,0(a1)	# _10, *tmp.312_55
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,0(a4)	# _10, *tmp.311_54
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,zero,.L230	#, tmp.313,,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,1(a1)	# _72, MEM[(const char *)tmp.312_55 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,1		# tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,1(a4)	# _72, MEM[(char *)tmp.311_54 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,a5,.L230	#, tmp.313, tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,2(a1)	# _48, MEM[(const char *)tmp.312_55 + 2B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,2(a4)	# _48, MEM[(char *)tmp.311_54 + 2B]
	ret	
.L231:
	add	a2,a0,a2	# n, _23, aa
# stdlib.c:138: 	char *a = (char *) aa;
	mv	a5,a0	# a, aa
.L234:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,-1(a4)	# _37, MEM[(const char *)b_35 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	addi	a5,a5,1	#, a, a
	addi	a4,a4,1	#, bb, bb
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,-1(a5)	# _37, MEM[(char *)a_36 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a2,a5,.L234	#, _23, a,
.L230:
# stdlib.c:142: }
	ret	
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
	j	.L251		#
.L253:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	beq	a4,zero,.L255	#, c,,
.L251:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp101, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp102, tmp101
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L253	#, tmp102,,
# stdlib.c:157: 		uint32_t v = *(uint32_t*)src;
	lw	a3,0(a1)		# v, MEM[(uint32_t *)src_20]
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a7,-16842752		# tmp105,
	addi	a7,a7,-257	#, tmp104, tmp105
	add	a4,a3,a7	# tmp104, tmp103, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	not	a2,a3	# tmp106, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	li	a6,-2139062272		# tmp110,
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	and	a4,a4,a2	# tmp106, tmp107, tmp103
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	addi	a6,a6,128	#, tmp109, tmp110
	and	a4,a4,a6	# tmp109, tmp108, tmp107
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	bne	a4,zero,.L256	#, tmp108,,
.L254:
# stdlib.c:180: 		*(uint32_t*)dst = v;
	sw	a3,0(a5)	# v, MEM[(uint32_t *)dst_51]
# stdlib.c:157: 		uint32_t v = *(uint32_t*)src;
	lw	a3,4(a1)		# v, MEM[(uint32_t *)src_31]
# stdlib.c:182: 		dst += 4;
	addi	a5,a5,4	#, dst, dst
# stdlib.c:181: 		src += 4;
	addi	a1,a1,4	#, src, src
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	add	a4,a3,a7	# tmp104, tmp115, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	not	a2,a3	# tmp118, v
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	and	a4,a4,a2	# tmp118, tmp119, tmp115
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	and	a4,a4,a6	# tmp109, tmp120, tmp119
# stdlib.c:159: 		if (__builtin_expect((((v) - 0x01010101UL) & ~(v) & 0x80808080UL), 0))
	beq	a4,zero,.L254	#, tmp120,,
.L256:
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a3,0(a5)	# v, *dst_50
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a4,a3,255	#, tmp111, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L255	#, tmp111,,
# stdlib.c:164: 			v = v >> 8;
	srli	a4,a3,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a4,1(a5)	# v, MEM[(char *)dst_50 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp112, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L255	#, tmp112,,
# stdlib.c:169: 			v = v >> 8;
	srli	a4,a3,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a4,2(a5)	# v, MEM[(char *)dst_50 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp113, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	bne	a4,zero,.L271	#, tmp113,,
.L255:
# stdlib.c:184: }
	ret	
.L271:
# stdlib.c:174: 			v = v >> 8;
	srli	a3,a3,24	#, v, v
# stdlib.c:176: 			dst[3] = v & 0xff;
	sb	a3,3(a5)	# v, MEM[(char *)dst_50 + 3B]
# stdlib.c:177: 			return r;
	ret	
	.size	strcpy, .-strcpy
	.align	2
	.globl	strcmp
	.type	strcmp, @function
strcmp:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	j	.L273		#
.L277:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	bne	a5,a4,.L302	#, c1, c2,
# stdlib.c:195: 		else if (!c1)
	beq	a5,zero,.L292	#, c1,,
.L273:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L277	#, tmp102,,
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_14]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_16]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L282	#, v1, v2,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp111,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-2139062272		# tmp116,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp110, tmp111
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,128	#, tmp115, tmp116
	j	.L278		#
.L303:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_29]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_30]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L282	#, v1, v2,
.L278:
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	add	a4,a5,a2	# tmp110, tmp109, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	not	a5,a5	# tmp112, v1
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a4,a5	# tmp112, tmp113, tmp109
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	and	a5,a5,a3	# tmp115, tmp114, tmp113
# stdlib.c:231: 		s1 += 4;
	addi	a0,a0,4	#, s1, s1
# stdlib.c:232: 		s2 += 4;
	addi	a1,a1,4	#, s2, s2
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	beq	a5,zero,.L303	#, tmp114,,
.L292:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
.L272:
# stdlib.c:234: }
	ret	
.L302:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	sltu	a0,a5,a4	# c2, tmp119, c1
	neg	a0,a0	# tmp120, tmp119
	ori	a0,a0,1	#, <retval>, tmp120
	ret	
.L282:
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L300	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L272	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L300	#, c1, c2,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L272	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L300	#, c1, c2,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L272	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L272	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a5,a4,.L272	#, c1, c2,
	j	.L298		#
.L300:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L272	#, c1, c2,
.L298:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
	.size	strcmp, .-strcmp
	.align	2
	.globl	sin1
	.type	sin1, @function
sin1:
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L305	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp96,
	add	a0,a0,a5	# tmp96, tmp98, angle
	slli	a0,a0,16	#, angle, tmp98
	srai	a0,a0,16	#, angle, angle
.L305:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a0,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_4, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp102, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_4, v0.41_4
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L306	#, tmp102,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp104, v0
	slli	a5,a5,16	#, v0, tmp104
	srai	a5,a5,16	#, v0, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a0,a0	# angle, angle
.L306:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _6, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a2,a5,1	#, tmp114, _6
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a4,%hi(.LANCHOR1)	# tmp109,
	addi	a4,a4,%lo(.LANCHOR1)	# tmp108, tmp109,
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp115, tmp114
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp110, _6
	add	a5,a4,a5	# tmp110, tmp111, tmp108
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a4,a2	# tmp115, tmp116, tmp108
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a5)		# _7, sin90[_6]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a4)		# sin90[_9], sin90[_9]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a0,0xff	# tmp121, angle
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a3,64	#, tmp129, v0.41_4
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a5,a2	# tmp118, sin90[_9], _7
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a4	# tmp122, tmp118, tmp121
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp123, tmp122
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a2	# _7, tmp126, tmp123
	slli	a0,a0,16	#, _5, tmp126
	srli	a0,a0,16	#, _5, _5
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L307	#, tmp129,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp131, _5
	slli	a0,a0,16	#, _5, tmp131
	srli	a0,a0,16	#, _5, _5
.L307:
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
	slli	a2,a0,16	#, prephitmp_78, angle
	srli	a2,a2,16	#, prephitmp_78, prephitmp_78
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L315	#, angle,,
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp98,
	xor	a2,a2,a5	# tmp98, prephitmp_78, prephitmp_78
.L315:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp101,
	addi	a5,a5,1	#, tmp100, tmp101
	add	a5,a2,a5	# tmp100, tmp99, prephitmp_78
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp99
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _4, tmp99
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _4, _4
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L316	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp104,
	addi	a5,a5,1	#, tmp103, tmp104
	add	a2,a2,a5	# tmp103, tmp102, prephitmp_78
	slli	a4,a2,16	#, _4, tmp102
	slli	a3,a2,16	#, angle, tmp102
	srli	a4,a4,16	#, _4, _4
	srai	a3,a3,16	#, angle, angle
.L316:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_16, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp108, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_16, v0.41_16
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L317	#, tmp108,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp112, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _4, tmp112
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _4, _4
.L317:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _22, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a1,a5,1	#, tmp120, _22
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a3,%hi(.LANCHOR1)	# tmp115,
	addi	a3,a3,%lo(.LANCHOR1)	# tmp114, tmp115,
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a1,a1,1	#, tmp121, tmp120
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp116, _22
	add	a5,a3,a5	# tmp116, tmp117, tmp114
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,a1	# tmp121, tmp122, tmp114
	lh	a0,0(a3)		# sin90[_25], sin90[_25]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _23, sin90[_22]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a4,0xff	# tmp126, _4
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a4,a2,64	#, tmp134, v0.41_16
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp124, sin90[_25], _23
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a5	# tmp127, tmp124, tmp126
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp128, tmp127
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _23, tmp131, tmp128
	slli	a0,a0,16	#, _37, tmp131
	srli	a0,a0,16	#, _37, _37
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a4,zero,.L318	#, tmp134,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp136, _37
	slli	a0,a0,16	#, _37, tmp136
	srli	a0,a0,16	#, _37, _37
.L318:
# gfx_lib_hdmi.h:110: }
	slli	a0,a0,16	#,, _37
	srai	a0,a0,16	#,,
	ret	
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
	lui	a5,%hi(.LANCHOR2)	# tmp78,
	addi	a5,a5,%lo(.LANCHOR2)	# ivtmp.392, tmp78,
	addi	a2,a5,37	#, _15, ivtmp.392
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a3,805306368		# tmp80,
.L329:
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# _7, MEM[(char *)_13]
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	addi	a5,a5,1	#, ivtmp.392, ivtmp.392
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _7, MEM[(volatile uint32_t *)805306380B]
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	bne	a5,a2,.L329	#, ivtmp.392, _15,
# gfx_lib_hdmi.h:198: }
	ret	
	.size	init_oled8bit_colors, .-init_oled8bit_colors
	.align	2
	.globl	fb_setpixel
	.type	fb_setpixel, @function
fb_setpixel:
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a5,79		# tmp84,
	bgtu	a1,a5,.L331	#, x, tmp84,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	a5,59		# tmp85,
	bgtu	a2,a5,.L331	#, y, tmp85,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a2,2	#, tmp87, y
	add	a5,a5,a2	# y, tmp88, tmp87
	slli	a5,a5,4	#, tmp89, tmp88
	add	a5,a5,a1	# x, tmp90, tmp89
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,2	#, tmp91, tmp90
	add	a0,a0,a5	# tmp91, tmp92, fb
	sw	a3,0(a0)	# color, *_12
.L331:
# gfx_lib_hdmi.h:207: }
	ret	
	.size	fb_setpixel, .-fb_setpixel
	.align	2
	.globl	fb_draw_bresenham
	.type	fb_draw_bresenham, @function
fb_draw_bresenham:
	addi	sp,sp,-48	#,,
	sw	s4,24(sp)	#,
	mv	s4,a0	# tmp116, fb
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sub	a0,a3,a1	#, x1, x0
# gfx_lib_hdmi.h:210: {
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	mv	s0,a2	# y0, tmp118
	mv	s1,a1	# x0, tmp117
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s5,20(sp)	#,
	mv	s3,a3	# x1, tmp119
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
# gfx_lib_hdmi.h:210: {
	mv	s6,a4	# y1, tmp120
	mv	s7,a5	# color, tmp121
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s2,a0	# tmp122,
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sgt	s5,s3,s1	# tmp107, x1, x0
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sgt	t3,s6,s0	# tmp111, y1, y0
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	slli	s5,s5,1	#, iftmp.50_9, tmp107
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	slli	t3,t3,1	#, iftmp.51_10, tmp111
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	addi	s5,s5,-1	#, iftmp.50_9, iftmp.50_9
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	neg	a7,a0	# dy, _3
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	addi	t3,t3,-1	#, iftmp.51_10, iftmp.51_10
	sub	a2,s2,a0	# err, dx, _3
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a3,79		# tmp97,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	t1,59		# tmp115,
.L336:
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a6,s0,2	#, tmp100, y0
	add	a6,a6,s0	# y0, tmp101, tmp100
	slli	a6,a6,4	#, tmp102, tmp101
	add	a6,a6,s1	# x0, tmp103, tmp102
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a6,a6,2	#, tmp104, tmp103
# gfx_lib_hdmi.h:220:     e2 = 2*err;
	slli	a1,a2,1	#, e2, err
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	add	a6,s4,a6	# tmp104, tmp105, fb
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	bgtu	s1,a3,.L337	#, x0, tmp97,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	bgtu	s0,t1,.L337	#, y0, tmp115,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	sw	s7,0(a6)	# color, *_38
.L337:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	beq	s1,s3,.L345	#, x0, x1,
.L338:
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	a7,a1,.L340	#, dy, e2,
	sub	a2,a2,a0	# err, err, _3
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s5	# iftmp.50_9, x0, x0
.L340:
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L336	#, dx, e2,
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a2,a2,s2	# dx, err, err
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,t3	# iftmp.51_10, y0, y0
	j	.L336		#
.L345:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s6,.L338	#, y0, y1,
# gfx_lib_hdmi.h:224: }
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
	lw	a4,4(a1)		# vect__1.408, MEM[(int *)p_4(D) + 4B]
# gfx_lib_hdmi.h:237:   return transformed;
	lw	a3,0(a1)		# MEM[(int *)p_4(D)], MEM[(int *)p_4(D)]
	sw	zero,8(a0)	#, <retval>.z
	sw	a4,4(a0)	# vect__1.408, MEM[(int *)&<retval> + 4B]
	sw	a3,0(a0)	# MEM[(int *)p_4(D)], MEM[(int *)&<retval>]
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
	mv	s0,a0	# tmp88, .result_ptr
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
	mv	s0,a0	# tmp89, .result_ptr
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	a0,8(a1)		#, p_8(D)->z
# gfx_lib_hdmi.h:245: point mirror_z_axis(point *p) {
	sw	ra,12(sp)	#,
	sw	s1,4(sp)	#,
	sw	s2,0(sp)	#,
# gfx_lib_hdmi.h:245: point mirror_z_axis(point *p) {
	mv	s1,a1	# p, tmp90
# gfx_lib_hdmi.h:246:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	s2,4(a1)		# vect__1.420, MEM[(int *)p_8(D) + 4B]
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
	lw	a5,0(s1)		# MEM[(int *)p_8(D)], MEM[(int *)p_8(D)]
	sw	s2,4(s0)	# vect__1.420, MEM[(int *)&<retval> + 4B]
	sw	a0,8(s0)	# tmp93, <retval>.z
# gfx_lib_hdmi.h:248: }
	lw	ra,12(sp)		#,
# gfx_lib_hdmi.h:247:   return transformed;
	sw	a5,0(s0)	# MEM[(int *)p_8(D)], MEM[(int *)&<retval>]
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
	addi	sp,sp,-32	#,,
	sw	s0,24(sp)	#,
	mv	s0,a0	# tmp96, .result_ptr
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(a1)		#, p_14(D)->y
# gfx_lib_hdmi.h:250: point scale(point *p, float sx, float sy, float sz) {
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	mv	s2,a3	# sy, tmp99
	mv	s3,a2	# sx, tmp98
	sw	s4,8(sp)	#,
# gfx_lib_hdmi.h:250: point scale(point *p, float sx, float sy, float sz) {
	mv	s1,a1	# p, tmp97
	mv	s4,a4	# sz, tmp100
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, sy
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s2,a0	# tmp101,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,8(s1)		#, p_14(D)->z
	call	__floatsisf		#
	mv	a1,s4	#, sz
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	a5,a0	# tmp102,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,0(s1)		#, p_14(D)->x
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s1,a5	# _12, tmp102
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s3	#, sx
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	sw	a0,0(s0)	# tmp103, <retval>.x
# gfx_lib_hdmi.h:252:   return transformed;
	sw	s2,4(s0)	# _8, <retval>.y
	sw	s1,8(s0)	# _12, <retval>.z
# gfx_lib_hdmi.h:253: }
	lw	ra,28(sp)		#,
	mv	a0,s0	#, .result_ptr
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	scale, .-scale
	.align	2
	.globl	translate
	.type	translate, @function
translate:
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a7,4(a1)		# p_8(D)->y, p_8(D)->y
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a6,8(a1)		# p_8(D)->z, p_8(D)->z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,0(a1)		# p_8(D)->x, p_8(D)->x
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a3,a3,a7	# p_8(D)->y, _4, tmp90
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a4,a4,a6	# p_8(D)->z, _6, tmp91
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a1,a1,a2	# tmp89, tmp85, p_8(D)->x
# gfx_lib_hdmi.h:257:   return transformed;
	sw	a1,0(a0)	# tmp85, <retval>.x
	sw	a3,4(a0)	# _4, <retval>.y
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
	mv	s0,a0	# tmp259, .result_ptr
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,8(a1)		# p_32(D)->z, p_32(D)->z
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,4(a1)		# p_32(D)->y, p_32(D)->y
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,8(a2)		# _6, pivot_33(D)->z
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,4(a2)		# _3, pivot_33(D)->y
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,0(a1)		# _1, p_32(D)->x
# gfx_lib_hdmi.h:261: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _4, p_32(D)->y, _3
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _7, p_32(D)->z, _6
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L356	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L356:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L357	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L357:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L358	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L358:
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L359	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L359:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L360	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L360:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L361	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L361:
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp265,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s2	#, _4
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	mv	s2,a5	# tmp243, tmp265
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s5,a0	# tmp266,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, _7
	call	__floatsisf		#
	mv	s1,a0	# tmp267,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s2	#, tmp243
# gfx_lib_hdmi.h:273:   return transformed;
	sw	s6,0(s0)	# _1, <retval>.x
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s6,a0	# tmp244, tmp268
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s6	#, tmp244
	call	__subsf3		#
	mv	s6,a0	# tmp246, tmp270
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _3
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s6	#, tmp246
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, sin_theta
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,4(s0)	# tmp272, <retval>.y
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s4,a0	# tmp250, tmp273
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s4	#, tmp250
	call	__addsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp277, <retval>.z
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
	lw	s9,4(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	rotateX_pivot, .-rotateX_pivot
	.align	2
	.globl	rotateY_pivot
	.type	rotateY_pivot, @function
rotateY_pivot:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# tmp259, .result_ptr
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib_hdmi.h:276: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,8(a1)		# p_32(D)->z, p_32(D)->z
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,0(a1)		# p_32(D)->x, p_32(D)->x
# gfx_lib_hdmi.h:276: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,8(a2)		# _6, pivot_33(D)->z
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,0(a2)		# _2, pivot_33(D)->x
# gfx_lib_hdmi.h:276: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,4(a1)		# _4, p_32(D)->y
# gfx_lib_hdmi.h:276: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _3, p_32(D)->x, _2
# gfx_lib_hdmi.h:277:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _7, p_32(D)->z, _6
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L375	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L375:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L376	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L376:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L377	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L377:
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L378	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L378:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L379	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L379:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L380	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L380:
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s5,a0	# tmp265,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s2	#, _3
	call	__floatsisf		#
	mv	a5,a0	# tmp266,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s1	#, _7
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s1,a5	# _18, tmp266
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s2,a0	# tmp267,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s5	#, tmp243
	mv	a0,s1	#, _18
	call	__mulsf3		#
	mv	s7,a0	# tmp244, tmp268
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s2	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, tmp244
	call	__addsf3		#
	mv	s7,a0	# tmp246, tmp270
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s4	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s7	#, tmp246
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s5	#, tmp243
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a0,0(s0)	# tmp272, <retval>.x
# gfx_lib_hdmi.h:288:   return transformed;
	sw	s6,4(s0)	# _4, <retval>.y
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s2	#, _20
	call	__mulsf3		#
	mv	s2,a0	# tmp250, tmp273
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _18
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s2	#, tmp250
	call	__subsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s3	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib_hdmi.h:286:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp277, <retval>.z
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
	lw	s9,4(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	rotateY_pivot, .-rotateY_pivot
	.align	2
	.globl	rotateZ_pivot
	.type	rotateZ_pivot, @function
rotateZ_pivot:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
	mv	s0,a0	# tmp259, .result_ptr
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib_hdmi.h:291: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,4(a1)		# p_32(D)->y, p_32(D)->y
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,0(a1)		# p_32(D)->x, p_32(D)->x
# gfx_lib_hdmi.h:291: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,4(a2)		# _5, pivot_33(D)->y
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,0(a2)		# _2, pivot_33(D)->x
# gfx_lib_hdmi.h:291: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,8(a1)		# _7, p_32(D)->z
# gfx_lib_hdmi.h:291: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _3, p_32(D)->x, _2
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _6, p_32(D)->y, _5
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L394	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L394:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L395	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L395:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L396	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L396:
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L397	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L397:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L398	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L398:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L399	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L399:
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp265,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s2	#, _3
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	s2,a5	# tmp243, tmp265
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	s5,a0	# tmp266,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s1	#, _6
	call	__floatsisf		#
	mv	s1,a0	# tmp267,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s7,a0	# tmp244, tmp268
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, tmp244
	call	__subsf3		#
	mv	s7,a0	# tmp246, tmp270
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s7	#, tmp246
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, sin_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a0,0(s0)	# tmp272, <retval>.x
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s4,a0	# tmp250, tmp273
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s4	#, tmp250
	call	__addsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, _5
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	sw	a0,4(s0)	# tmp277, <retval>.y
# gfx_lib_hdmi.h:303:   return transformed;
	sw	s6,8(s0)	# _7, <retval>.z
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
	lw	s9,4(sp)		#,
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	rotateZ_pivot, .-rotateZ_pivot
	.align	2
	.globl	render_lines
	.type	render_lines, @function
render_lines:
	addi	sp,sp,-128	#,,
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	addi	a2,a1,-1	#, _50, s
# main_sphere3d_hdmi.c:18: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	ra,124(sp)	#,
	sw	s0,120(sp)	#,
	sw	s1,116(sp)	#,
	sw	s2,112(sp)	#,
	sw	s3,108(sp)	#,
	sw	s4,104(sp)	#,
	sw	s5,100(sp)	#,
	sw	s6,96(sp)	#,
	sw	s7,92(sp)	#,
	sw	s8,88(sp)	#,
	sw	s9,84(sp)	#,
	sw	s10,80(sp)	#,
	sw	s11,76(sp)	#,
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	sw	a2,12(sp)	# _50, %sfp
# main_sphere3d_hdmi.c:18: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	a0,8(sp)	# tmp573, %sfp
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	beq	a2,zero,.L412	#, _50,,
	mv	s2,a5	# scalef, tmp577
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lui	a5,%hi(.LC4)	# tmp286,
	mv	s4,a1	# s, tmp574
	lw	a1,%lo(.LC4)(a5)		#,
	mv	a0,s2	#, scalef
	mv	s0,a3	# angle_y, tmp575
	mv	s1,a4	# angle_z, tmp576
	call	__mulsf3		#
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lui	a5,%hi(.LC5)	# tmp288,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	mv	a1,a0	# tmp578,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lw	a0,%lo(.LC5)(a5)		#,
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	lui	s9,%hi(.LC1)	# tmp534,
	lui	s8,%hi(.LC2)	# tmp535,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	call	__subsf3		#
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	call	__fixsfsi		#
	mv	s11,a0	# tmp579,
# main_sphere3d_hdmi.c:33:     p0 = rotateY_pivot(&p0, &pivot, angle_y);
	mv	a0,s0	#, angle_y
	call	__fixsfsi		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC1)(s9)		#,
	lw	a3,%lo(.LC1+4)(s9)		#,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	s0,-32768		# tmp298,
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lw	a2,%lo(.LC2)(s8)		#,
	lw	a3,%lo(.LC2+4)(s8)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _101, tmp580
	srai	a0,a0,16	#, _101, _101
	add	s0,a0,s0	# tmp298, _101, _101
	blt	a0,zero,.L415	#, _101,,
	mv	s0,a0	# _101, _101
.L415:
	slli	s5,s0,16	#, angle, _101
	srai	s5,s5,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,s5,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a4,a5,16	#, v0.41_136, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	s0,s0	# tmp307, _101
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a4,a4,16	#, v0.41_136, v0.41_136
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s0,s0,16	#, v1, tmp307
	andi	s7,a5,32	#, _137, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a4,16(sp)	# v0.41_136, %sfp
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s0,s0,16	#, v1, v1
	not	s3,a5	# v0, v0
	beq	s7,zero,.L462	#, _137,,
.L417:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,s5,16	#, angle.46_110, angle
	li	a3,-24576		# tmp312,
	srli	a5,a5,16	#, angle.46_110, angle.46_110
	addi	a3,a3,1	#, tmp311, tmp312
	add	a3,a5,a3	# tmp311, tmp310, angle.46_110
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a3,16	#, _112, tmp310
	li	a4,8192		# tmp315,
	addi	a4,a4,1	#, tmp314, tmp315
	srai	a3,a3,16	#, _112, _112
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s3,s3,31	#, _142, v0
	add	a5,a5,a4	# tmp314, _112, angle.46_110
	blt	a3,zero,.L419	#, _112,,
	mv	a5,a3	# _112, _112
.L419:
	slli	s10,a5,16	#, angle, _112
	srai	s10,s10,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s10,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp322, _112
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_167, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp322
	srai	a5,a5,16	#, v1, v1
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_167, v0.41_167
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,24(sp)	# v1, %sfp
	andi	s6,a4,32	#, _168, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,20(sp)	# v0.41_167, %sfp
	not	a5,a4	# v0, v0
	beq	s6,zero,.L463	#, _168,,
.L421:
# main_sphere3d_hdmi.c:35:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s1	#, angle_z
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s1,a5,31	#, _173, v0
# main_sphere3d_hdmi.c:35:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC1)(s9)		#,
	lw	a3,%lo(.LC1+4)(s9)		#,
	call	__muldf3		#
	lw	a2,%lo(.LC2)(s8)		#,
	lw	a3,%lo(.LC2+4)(s8)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _61, tmp581
	srai	a0,a0,16	#, _61, _61
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a4,-32768		# tmp333,
	add	a4,a0,a4	# tmp333, _61, _61
	blt	a0,zero,.L423	#, _61,,
	mv	a4,a0	# _61, _61
.L423:
	slli	a1,a4,16	#, angle, _61
	srai	a1,a1,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a1,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp342, _61
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s9,a5,16	#, v0.41_198, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a4,a4,16	#, v1, tmp342
	andi	a6,a5,32	#, _199, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s9,s9,16	#, v0.41_198, v0.41_198
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a4,a4,16	#, v1, v1
	not	t3,a5	# v0, v0
	beq	a6,zero,.L464	#, _199,,
.L425:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,a1,16	#, angle.46_70, angle
	li	a3,-24576		# tmp347,
	srli	a5,a5,16	#, angle.46_70, angle.46_70
	addi	a3,a3,1	#, tmp346, tmp347
	add	a3,a5,a3	# tmp346, tmp345, angle.46_70
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a3,16	#, _72, tmp345
	li	a2,8192		# tmp350,
	addi	a2,a2,1	#, tmp349, tmp350
	srai	a3,a3,16	#, _72, _72
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	t3,t3,31	#, _204, v0
	add	a5,a5,a2	# tmp349, _72, angle.46_70
	blt	a3,zero,.L427	#, _72,,
	mv	a5,a3	# _72, _72
.L427:
	slli	a7,a5,16	#, angle, _72
	srai	a7,a7,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a3,a7,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a3,16	#, v0.41_229, v0
	srli	a2,a2,16	#, v0.41_229, v0.41_229
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp357, _72
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a2,28(sp)	# v0.41_229, %sfp
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s8,a5,16	#, v1, tmp357
	andi	t1,a3,32	#, _230, v0
	srai	s8,s8,16	#, v1, v1
	not	a2,a3	# v0, v0
	beq	t1,zero,.L465	#, _230,,
.L429:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a2,a2,31	#, _235, v0
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, _5
	sw	t1,60(sp)	# _230, %sfp
	sw	a7,56(sp)	# angle, %sfp
	sw	t3,52(sp)	# _204, %sfp
	sw	a4,48(sp)	# v1, %sfp
	sw	a6,44(sp)	# _199, %sfp
	sw	a1,40(sp)	# angle, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sw	a2,36(sp)	# _235, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__floatsisf		#
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,s3,1	#, tmp367, _142
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a5,%hi(.LANCHOR1)	# tmp538,
	addi	a5,a5,%lo(.LANCHOR1)	# tmp539, tmp538,
	slli	s3,s3,1	#, tmp363, _142
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a3,1	#, tmp368, tmp367
# main_sphere3d_hdmi.c:39:   col++;
	lui	a4,%hi(col.0)	# tmp630,
	lhu	a4,%lo(col.0)(a4)	# pretmp_314, col
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,a5,s3	# tmp363, tmp364, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a5,a3	# tmp368, tmp369, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t5,0(s3)		# pretmp_316, sin90[_142]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a3,0(a3)		# sin90[_145], sin90[_145]
# main_sphere3d_hdmi.c:39:   col++;
	sw	a4,32(sp)	# pretmp_314, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a0,4(sp)	# tmp582, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a2,36(sp)		# _235, %sfp
	lw	a1,40(sp)		# angle, %sfp
	lw	a6,44(sp)		# _199, %sfp
	lw	a4,48(sp)		# v1, %sfp
	lw	t3,52(sp)		# _204, %sfp
	lw	a7,56(sp)		# angle, %sfp
	lw	t1,60(sp)		# _230, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a3,a3,t5	# tmp371, sin90[_145], pretmp_316
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s7,zero,.L466	#, _137,,
.L431:
	andi	s0,s0,0xff	# tmp374, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a3,a3,s0	# tmp375, tmp371, tmp374
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a0,s1,1	#, tmp386, _173
	slli	a0,a0,1	#, tmp387, tmp386
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s1,s1,1	#, tmp382, _173
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a5,a0	# tmp387, tmp388, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s1,a5,s1	# tmp382, tmp383, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s5,0(a0)		# sin90[_176], sin90[_176]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t4,0(s1)		# pretmp_328, sin90[_173]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	a0,24(sp)	#, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a3,a3,8	#, tmp376, tmp375
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,t5	# pretmp_316, tmp379, tmp376
	slli	a3,a3,16	#, _327, tmp379
	srli	a3,a3,16	#, _327, _327
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s5,s5,t4	# tmp390, sin90[_176], pretmp_328
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s6,zero,.L467	#, _168,,
.L433:
	andi	a0,a0,0xff	# tmp393, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s5,s5,a0	# tmp394, tmp390, tmp393
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	t5,t3,1	#, tmp405, _204
	slli	t5,t5,1	#, tmp406, tmp405
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	t3,t3,1	#, tmp401, _204
	add	t3,a5,t3	# tmp401, tmp402, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t5,a5,t5	# tmp406, tmp407, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(t3)		# pretmp_340, sin90[_204]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s3,0(t5)		# sin90[_207], sin90[_207]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s5,s5,8	#, tmp395, tmp394
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s5,s5,t4	# pretmp_328, tmp398, tmp395
	slli	s5,s5,16	#, _339, tmp398
	srli	s5,s5,16	#, _339, _339
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s3,s3,a0	# tmp409, sin90[_207], pretmp_340
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	a6,zero,.L468	#, _199,,
.L435:
	andi	a4,a4,0xff	# tmp412, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s3,s3,a4	# tmp413, tmp409, tmp412
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a2,1	#, tmp424, _235
	slli	a4,a4,1	#, tmp425, tmp424
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp420, _235
	add	a2,a5,a2	# tmp420, tmp421, tmp539
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a4	# tmp425, tmp426, tmp539
	lh	s1,0(a5)		# sin90[_238], sin90[_238]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a4,0(a2)		# pretmp_352, sin90[_235]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s3,s3,8	#, tmp414, tmp413
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,s3,a0	# pretmp_340, tmp417, tmp414
	slli	s3,s3,16	#, _351, tmp417
	srli	s3,s3,16	#, _351, _351
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s1,s1,a4	# tmp428, sin90[_238], pretmp_352
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t1,zero,.L469	#, _230,,
.L437:
	andi	s8,s8,0xff	# tmp431, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s1,s1,s8	# tmp432, tmp428, tmp431
	lw	s0,8(sp)		# ivtmp.452, %sfp
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	lw	a2,16(sp)		# v0.41_136, %sfp
	slli	a5,s4,1	#, tmp439, s
	add	a5,a5,s4	# s, tmp440, tmp439
	addi	s6,s0,-12	#, tmp437, ivtmp.452
	slli	a5,a5,2	#, tmp441, tmp440
	andi	a2,a2,64	#, tmp445, v0.41_136
	add	s6,s6,a5	# tmp441, _35, tmp437
	mv	a0,a3	# v1, _327
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s1,s1,8	#, tmp433, tmp432
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s1,s1,a4	# pretmp_352, tmp436, tmp433
	slli	s1,s1,16	#, _363, tmp436
	srli	s1,s1,16	#, _363, _363
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	bne	a2,zero,.L470	#, tmp445,,
.L439:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s4,%hi(.LC3)	# tmp536,
	lw	a2,%lo(.LC3)(s4)		#,
	lw	a3,%lo(.LC3+4)(s4)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	lw	a5,20(sp)		# v0.41_167, %sfp
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	mv	s7,a0	# sin_theta, tmp583
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	mv	a0,s5	# v1, _339
	andi	a5,a5,64	#, tmp456, v0.41_167
	bne	a5,zero,.L471	#, tmp456,,
.L441:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s4)		#,
	lw	a3,%lo(.LC3+4)(s4)		#,
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	andi	s9,s9,64	#, tmp467, v0.41_198
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s8,a0	# cos_theta, tmp584
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	a0,s3	# v1, _351
	bne	s9,zero,.L472	#, tmp467,,
.L443:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s4)		#,
	lw	a3,%lo(.LC3+4)(s4)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	lw	a5,28(sp)		# v0.41_229, %sfp
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	s3,a0	# sin_theta, tmp585
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	a0,s1	# v1, _363
	andi	a5,a5,64	#, tmp478, v0.41_229
	bne	a5,zero,.L473	#, tmp478,,
.L445:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s4)		#,
	lw	a3,%lo(.LC3+4)(s4)		#,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	lui	s10,%hi(framebuffer)	# tmp570,
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	lui	a5,%hi(.LC6)	# tmp537,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	s4,%lo(.LC6)(a5)		# tmp567,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	addi	a5,s10,%lo(framebuffer)	# tmp571, tmp570,
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	s5,a0	# cos_theta, tmp586
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	sw	a5,8(sp)	# tmp571, %sfp
.L447:
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,0(s0)		#, MEM[(int *)_47]
	call	__floatsisf		#
	mv	a1,s2	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-30	#,, tmp587
	call	__floatsisf		#
	mv	a1,s8	#, cos_theta
	call	__mulsf3		#
	mv	s9,a0	# tmp588,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,8(s0)		#, MEM[(int *)_47 + 8B]
	call	__floatsisf		#
	mv	a1,s2	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s7	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp589,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s9	#, tmp491
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s4	#, tmp567
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp590
	call	__floatsisf		#
	mv	s9,a0	# tmp591,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_47 + 4B]
	call	__floatsisf		#
	mv	a1,s2	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	addi	a0,a0,30	#, tmp505, tmp592
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sub	a0,a0,s11	#, tmp505, _5
	call	__floatsisf		#
	mv	s10,a0	# tmp593,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s9	#, _306
	call	__mulsf3		#
	mv	s1,a0	# tmp507, tmp594
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _304
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp595,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s1	#, tmp507
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, tmp567
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp596,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, _306
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s9,a5	# _300, tmp596
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a5,79		# tmp636,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, sin_theta
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	bgtu	s9,a5,.L449	#, _300, tmp636,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	mv	s1,a0	# tmp523, tmp597
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s10	#, _304
	call	__mulsf3		#
	mv	a1,a0	# tmp598,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s1	#, tmp523
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a1,4(sp)		#, %sfp
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a0,2	#, tmp514, _261
	add	a5,a5,a0	# _261, tmp515, tmp514
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	lw	a4,8(sp)		# tmp571, %sfp
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,4	#, tmp516, tmp515
	add	a5,a5,s9	# _300, tmp517, tmp516
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,2	#, tmp518, tmp517
	add	a5,a5,a4	# tmp571, tmp519, tmp518
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	a4,59		# tmp639,
	bgtu	a0,a4,.L449	#, _261, tmp639,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	li	a4,-1		# tmp637,
	sw	a4,0(a5)	# tmp637, *_313
.L449:
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	addi	s0,s0,12	#, ivtmp.452, ivtmp.452
	bne	s6,s0,.L447	#, _35, ivtmp.452,
	lw	a4,32(sp)		# pretmp_314, %sfp
	lw	a2,12(sp)		# _50, %sfp
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	li	a5,0		# i,
	addi	a3,a4,1	#, tmp540, pretmp_314
.L451:
	add	a4,a3,a5	# i, tmp531, tmp540
	slli	a4,a4,16	#, _256, tmp531
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	addi	a5,a5,1	#, i, i
	srli	a4,a4,16	#, _256, _256
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	bne	a5,a2,.L451	#, i, _50,
	lui	a5,%hi(col.0)	# tmp641,
	sh	a4,%lo(col.0)(a5)	# _256, col
.L412:
# main_sphere3d_hdmi.c:41: }
	lw	ra,124(sp)		#,
	lw	s0,120(sp)		#,
	lw	s1,116(sp)		#,
	lw	s2,112(sp)		#,
	lw	s3,108(sp)		#,
	lw	s4,104(sp)		#,
	lw	s5,100(sp)		#,
	lw	s6,96(sp)		#,
	lw	s7,92(sp)		#,
	lw	s8,88(sp)		#,
	lw	s9,84(sp)		#,
	lw	s10,80(sp)		#,
	lw	s11,76(sp)		#,
	addi	sp,sp,128	#,,
	jr	ra		#
.L473:
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	neg	a0,s1	# v1, _363
	j	.L445		#
.L472:
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	neg	a0,s3	# v1, _351
	j	.L443		#
.L471:
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	neg	a0,s5	# v1, _339
	j	.L441		#
.L470:
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	neg	a0,a3	# v1, _327
	j	.L439		#
.L469:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	s8,a7	# v1, angle
	j	.L437		#
.L468:
	mv	a4,a1	# v1, angle
	j	.L435		#
.L467:
	mv	a0,s10	# v1, angle
	j	.L433		#
.L466:
	mv	s0,s5	# v1, angle
	j	.L431		#
.L465:
	mv	a2,a3	# v0, v0
	j	.L429		#
.L464:
	mv	t3,a5	# v0, v0
	j	.L425		#
.L463:
	mv	a5,a4	# v0, v0
	j	.L421		#
.L462:
	mv	s3,a5	# v0, v0
	j	.L417		#
	.size	render_lines, .-render_lines
	.section	.rodata.str1.4
	.align	2
.LC9:
	.string	"yo\n"
	.globl	__gesf2
	.globl	__lesf2
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-176	#,,
	sw	s11,124(sp)	#,
# gfx_lib_hdmi.h:231:   dma_action((uint32_t) framebuffer, rgb, VRES*HRES, DMA_MEMSET);
	lui	s11,%hi(framebuffer)	# tmp494,
	addi	a4,s11,%lo(framebuffer)	# tmp500, tmp494,
# main_sphere3d_hdmi.c:45: void main() {
	sw	s0,168(sp)	#,
	sw	s1,164(sp)	#,
	sw	s2,160(sp)	#,
	sw	s3,156(sp)	#,
	sw	s6,144(sp)	#,
	sw	s8,136(sp)	#,
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp251,
# gfx_lib_hdmi.h:231:   dma_action((uint32_t) framebuffer, rgb, VRES*HRES, DMA_MEMSET);
	sw	a4,8(sp)	# tmp500, %sfp
# main_sphere3d_hdmi.c:45: void main() {
	sw	ra,172(sp)	#,
	sw	s4,152(sp)	#,
	sw	s5,148(sp)	#,
	sw	s7,140(sp)	#,
	sw	s9,132(sp)	#,
	sw	s10,128(sp)	#,
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	sw	a4,44(a5)	# tmp500, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp257,
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	zero,48(a5)	#, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	a4,a4,704	#, tmp256, tmp257
	sw	a4,52(a5)	# tmp256, MEM[(volatile uint32_t *)805306420B]
# main_sphere3d_hdmi.c:55:     printf("yo\n");
	lui	a0,%hi(.LC9)	# tmp261,
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a4,2		# tmp260,
	sw	a4,56(a5)	# tmp260, MEM[(volatile uint32_t *)805306424B]
# main_sphere3d_hdmi.c:55:     printf("yo\n");
	addi	a0,a0,%lo(.LC9)	#, tmp261,
	call	printf		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	lui	a5,%hi(.LC10)	# tmp495,
	lw	s2,%lo(.LC10)(a5)		# tmp545,
	lw	s3,%lo(.LC10+4)(a5)		#,
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	lui	a5,%hi(.LC11)	# tmp496,
	lw	s0,%lo(.LC11)(a5)		# tmp546,
	lw	s1,%lo(.LC11+4)(a5)		#,
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	lui	a5,%hi(.LC12)	# tmp497,
	lw	s6,%lo(.LC12)(a5)		# tmp549,
	lui	a5,%hi(stars)	# tmp502,
	addi	a5,a5,%lo(stars)	# ivtmp.473, tmp502,
# main_sphere3d_hdmi.c:63:   int index = 0;
	li	s8,0		# index,
	sw	a5,72(sp)	# ivtmp.473, %sfp
# main_sphere3d_hdmi.c:45: void main() {
	sw	zero,28(sp)	#, %sfp
# main_sphere3d_hdmi.c:70:       if (index >= N) break;
	li	s11,359		# tmp283,
	mv	a5,s8	# index, index
.L475:
	lw	a4,72(sp)		# ivtmp.473, %sfp
	slli	s4,a5,1	#, tmp287, index
	add	s4,s4,a5	# index, tmp288, tmp287
	slli	s4,s4,2	#, tmp289, tmp288
	add	s4,s4,a4	# ivtmp.473, ivtmp.488, tmp289
# main_sphere3d_hdmi.c:65:     for (int u = 0; u < 360/2; u += STEP) {
	li	s9,0		# u,
.L477:
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a0,s9	#, u
	sw	a5,12(sp)	# index, %sfp
	call	__floatsidf		#
	mv	a2,s2	#, tmp545
	mv	a3,s3	#,
	call	__muldf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a2,s0	#, tmp546
	mv	a3,s1	#,
	call	__divdf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	call	__truncdfsf2		#
	mv	s5,a0	# _4, tmp552
	call	sinf		#
	mv	s10,a0	# tmp553,
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a0,s8	#, t
	call	__floatsidf		#
	mv	a2,s2	#, tmp545
	mv	a3,s3	#,
	call	__muldf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a2,s0	#, tmp546
	mv	a3,s1	#,
	call	__divdf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	call	__truncdfsf2		#
	mv	s7,a0	# tmp554,
	call	cosf		#
	mv	a1,a0	# tmp555,
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a0,s10	#, _5
	call	__mulsf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	mv	a1,s6	#, tmp549
	call	__mulsf3		#
# main_sphere3d_hdmi.c:66:       stars[index].x = sinf(u*M_PI/180.0)*cosf(t*M_PI/180.0) * 35;
	call	__fixsfsi		#
	mv	a4,a0	# tmp556,
	sw	a4,0(s4)	# tmp556, MEM[(int *)_150]
# main_sphere3d_hdmi.c:67:       stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
	mv	a0,s5	#, _4
	call	sinf		#
	mv	s10,a0	# _14, tmp557
# main_sphere3d_hdmi.c:67:       stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
	mv	a0,s7	#, _9
	call	sinf		#
	mv	a1,a0	# tmp558,
# main_sphere3d_hdmi.c:67:       stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
	mv	a0,s10	#, _14
	call	__mulsf3		#
# main_sphere3d_hdmi.c:67:       stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
	mv	a1,s6	#, tmp549
	call	__mulsf3		#
# main_sphere3d_hdmi.c:67:       stars[index].y = sinf(u*M_PI/180.0)*sinf(t*M_PI/180.0) * 35;
	call	__fixsfsi		#
	mv	a4,a0	# tmp559,
	sw	a4,4(s4)	# tmp559, MEM[(int *)_150 + 4B]
# main_sphere3d_hdmi.c:68:       stars[index].z = cosf(u*M_PI/180.0) * 35;
	mv	a0,s5	#, _4
	call	cosf		#
# main_sphere3d_hdmi.c:68:       stars[index].z = cosf(u*M_PI/180.0) * 35;
	mv	a1,s6	#, tmp549
	call	__mulsf3		#
# main_sphere3d_hdmi.c:68:       stars[index].z = cosf(u*M_PI/180.0) * 35;
	call	__fixsfsi		#
# main_sphere3d_hdmi.c:69:       index++;
	lw	a5,12(sp)		# index, %sfp
# main_sphere3d_hdmi.c:68:       stars[index].z = cosf(u*M_PI/180.0) * 35;
	sw	a0,8(s4)	# tmp560, MEM[(int *)_150 + 8B]
# main_sphere3d_hdmi.c:65:     for (int u = 0; u < 360/2; u += STEP) {
	addi	s9,s9,20	#, u, u
# main_sphere3d_hdmi.c:69:       index++;
	addi	a5,a5,1	#, index, index
# main_sphere3d_hdmi.c:65:     for (int u = 0; u < 360/2; u += STEP) {
	li	a4,180		# tmp284,
# main_sphere3d_hdmi.c:70:       if (index >= N) break;
	bgt	a5,s11,.L476	#, index, tmp283,
# main_sphere3d_hdmi.c:65:     for (int u = 0; u < 360/2; u += STEP) {
	addi	s4,s4,12	#, ivtmp.488, ivtmp.488
	bne	s9,a4,.L477	#, u, tmp284,
.L476:
# main_sphere3d_hdmi.c:64:   for (int t = 0; t < 360; t += STEP) {
	addi	s8,s8,20	#, t, t
# main_sphere3d_hdmi.c:64:   for (int t = 0; t < 360; t += STEP) {
	li	a4,360		# tmp285,
	bne	s8,a4,.L475	#, t, tmp285,
# main_sphere3d_hdmi.c:74:   *fb_ctrl = 0;
	lui	a5,%hi(fb_ctrl)	# tmp292,
	lw	a4,%lo(fb_ctrl)(a5)		# fb_ctrl.58_22, fb_ctrl
# main_sphere3d_hdmi.c:53:   float delta_scale = 0.06;//0.8; /* speedup scale */
	lui	a5,%hi(.LC7)	# tmp247,
	lw	a5,%lo(.LC7)(a5)		# delta_scale,
# main_sphere3d_hdmi.c:74:   *fb_ctrl = 0;
	sw	a4,24(sp)	# fb_ctrl.58_22, %sfp
# main_sphere3d_hdmi.c:74:   *fb_ctrl = 0;
	sw	zero,0(a4)	#, *fb_ctrl.58_22
# main_sphere3d_hdmi.c:53:   float delta_scale = 0.06;//0.8; /* speedup scale */
	sw	a5,20(sp)	# delta_scale, %sfp
# main_sphere3d_hdmi.c:52:   float s = 1;
	lui	a5,%hi(.LC8)	# tmp248,
	lw	s2,%lo(.LC8)(a5)		# s,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lui	a5,%hi(.LC4)	# tmp491,
	lw	a5,%lo(.LC4)(a5)		# tmp534,
# main_sphere3d_hdmi.c:76:   IO_OUT(GPIO_DIR, ~0);
	li	a4,-1		# tmp295,
	lui	s9,%hi(stars+4308)	# tmp507,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	sw	a5,88(sp)	# tmp534, %sfp
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lui	a5,%hi(.LC5)	# tmp492,
	lw	a5,%lo(.LC5)(a5)		# tmp535,
	addi	s9,s9,%lo(stars+4308)	# _159, tmp507,
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	s7,805306368		# tmp444,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	sw	a5,92(sp)	# tmp535, %sfp
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	lui	a5,%hi(.LC1)	# tmp488,
	lw	a6,%lo(.LC1+4)(a5)		#,
	lw	a5,%lo(.LC1)(a5)		# tmp536,
	sw	a6,100(sp)	#, %sfp
	sw	a5,96(sp)	# tmp536, %sfp
	lui	a5,%hi(.LC2)	# tmp489,
	lw	a6,%lo(.LC2+4)(a5)		#,
	lw	a5,%lo(.LC2)(a5)		# tmp537,
	sw	a6,108(sp)	#, %sfp
	sw	a5,104(sp)	# tmp537, %sfp
	lui	a5,%hi(.LC3)	# tmp490,
	lw	a6,%lo(.LC3+4)(a5)		#,
	lw	a5,%lo(.LC3)(a5)		# tmp538,
	sw	a6,44(sp)	#, %sfp
	sw	a5,40(sp)	# tmp538, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC6)	# tmp493,
	lw	s5,%lo(.LC6)(a5)		# tmp530,
# main_sphere3d_hdmi.c:87:     if (s >= 2) delta_scale = -delta_scale;
	lui	a5,%hi(.LC13)	# tmp498,
	lw	a5,%lo(.LC13)(a5)		# tmp456,
	sw	a5,84(sp)	# tmp456, %sfp
# main_sphere3d_hdmi.c:76:   IO_OUT(GPIO_DIR, ~0);
	li	a5,805306368		# tmp294,
	sw	a4,20(a5)	# tmp295, MEM[(volatile uint32_t *)805306388B]
# main_sphere3d_hdmi.c:50:   int delta_angle = 2; /* speedup rotation, - for left rotation */
	li	a5,2		# delta_angle,
	sw	a5,16(sp)	# delta_angle, %sfp
	lui	a5,%hi(.LANCHOR1)	# tmp499,
	addi	a5,a5,%lo(.LANCHOR1)	# tmp503, tmp499,
	sw	a5,36(sp)	# tmp503, %sfp
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp323,
	addi	a5,a5,1	#, tmp322, tmp323
	sw	a5,76(sp)	# tmp322, %sfp
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp326,
	addi	a5,a5,1	#, tmp325, tmp326
	sw	a5,80(sp)	# tmp325, %sfp
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a5,4096		# tmp450,
	addi	a5,a5,704	#, tmp449, tmp450
# main_sphere3d_hdmi.c:49:   int angle = 0;
	sw	zero,12(sp)	#, %sfp
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	a5,32(sp)	# tmp449, %sfp
.L505:
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lw	a1,88(sp)		#, %sfp
	mv	a0,s2	#, s
	call	__mulsf3		#
	mv	a1,a0	# tmp561,
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	lw	a0,92(sp)		#, %sfp
	call	__subsf3		#
# main_sphere3d_hdmi.c:31:     point pivot = {HRES/2, VRES/2 -15*scalef, 0};
	call	__fixsfsi		#
	mv	s6,a0	# tmp562,
# main_sphere3d_hdmi.c:79:     render_lines(stars, SIZEOF(stars), angle, angle, angle, s);
	lw	a0,12(sp)		#, %sfp
	call	__floatsisf		#
# main_sphere3d_hdmi.c:33:     p0 = rotateY_pivot(&p0, &pivot, angle_y);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,96(sp)		#, %sfp
	lw	a3,100(sp)		#, %sfp
	call	__muldf3		#
	lw	a2,104(sp)		#, %sfp
	lw	a3,108(sp)		#, %sfp
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _170, tmp563
	srai	a0,a0,16	#, _170, _170
	li	a5,-32768		# tmp632,
	add	s0,a0,a5	# tmp632, _170, _170
	blt	a0,zero,.L480	#, _170,,
	mv	s0,a0	# _170, _170
.L480:
	slli	a6,s0,16	#, angle, _170
	srai	a6,a6,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a6,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	s0,s0	# tmp318, _170
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a4,a5,16	#, v0.41_205, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s0,s0,16	#, v1, tmp318
	andi	a7,a5,32	#, _206, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a4,a4,16	#, v0.41_205, v0.41_205
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s0,s0,16	#, v1, v1
	not	s4,a5	# v0, v0
	bne	a7,zero,.L482	#, _206,,
	mv	s4,a5	# v0, v0
.L482:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a3,76(sp)		# tmp322, %sfp
	slli	a5,a6,16	#, angle.46_179, angle
	srli	a5,a5,16	#, angle.46_179, angle.46_179
	add	a3,a5,a3	# tmp322, tmp321, angle.46_179
	lw	a2,80(sp)		# tmp325, %sfp
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a3,16	#, _181, tmp321
	srai	a3,a3,16	#, _181, _181
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s4,s4,31	#, _211, v0
	add	a5,a5,a2	# tmp325, _181, angle.46_179
	blt	a3,zero,.L484	#, _181,,
	mv	a5,a3	# _181, _181
.L484:
	slli	a3,a5,16	#, angle, _181
	srai	a3,a3,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a0,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp333, _181
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s1,a0,16	#, v0.41_236, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a1,a5,16	#, v1, tmp333
	andi	a2,a0,32	#, _237, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s1,s1,16	#, v0.41_236, v0.41_236
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a1,a1,16	#, v1, v1
	not	s3,a0	# v0, v0
	bne	a2,zero,.L486	#, _237,,
	mv	s3,a0	# v0, v0
.L486:
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s6	#, _110
	sw	a1,64(sp)	# v1, %sfp
	sw	a2,60(sp)	# _237, %sfp
	sw	a3,56(sp)	# angle, %sfp
	sw	a7,52(sp)	# _206, %sfp
	sw	a4,48(sp)	# v0.41_205, %sfp
	sw	a6,68(sp)	# angle, %sfp
	call	__floatsisf		#
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a4,36(sp)		# tmp503, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a5,s4,1	#, tmp342, _211
	slli	a5,a5,1	#, tmp343, tmp342
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s4,s4,1	#, tmp338, _211
	add	s4,a4,s4	# tmp338, tmp339, tmp503
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a4,a5	# tmp343, tmp344, tmp503
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t1,0(s4)		# pretmp_127, sin90[_211]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a5)		# sin90[_214], sin90[_214]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a7,52(sp)		# _206, %sfp
	lw	a4,48(sp)		# v0.41_205, %sfp
	lw	a3,56(sp)		# angle, %sfp
	lw	a2,60(sp)		# _237, %sfp
	lw	a1,64(sp)		# v1, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s3,s3,31	#, _242, v0
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s8,a0	# _154, tmp564
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,t1	# tmp346, sin90[_214], pretmp_127
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a7,zero,.L488	#, _206,,
	lw	a6,68(sp)		# angle, %sfp
	mv	s0,a6	# v1, angle
.L488:
	andi	s0,s0,0xff	# tmp349, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,s0	# tmp350, tmp346, tmp349
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a6,36(sp)		# tmp503, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a0,s3,1	#, tmp361, _242
	slli	a0,a0,1	#, tmp362, tmp361
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s3,s3,1	#, tmp357, _242
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a6,a0	# tmp362, tmp363, tmp503
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,a6,s3	# tmp357, tmp358, tmp503
	lh	a6,0(s3)		# pretmp_317, sin90[_242]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s4,0(a0)		# sin90[_245], sin90[_245]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp351, tmp350
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,t1	# pretmp_127, tmp354, tmp351
	slli	a5,a5,16	#, _316, tmp354
	srli	a5,a5,16	#, _316, _316
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s4,s4,a6	# tmp365, sin90[_245], pretmp_317
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a2,zero,.L490	#, _237,,
	mv	a1,a3	# v1, angle
.L490:
	andi	a1,a1,0xff	# tmp368, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s4,s4,a1	# tmp369, tmp365, tmp368
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	andi	a4,a4,64	#, tmp380, v0.41_205
	lw	s0,72(sp)		# ivtmp.473, %sfp
	mv	a0,a5	# v1, _316
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s4,s4,8	#, tmp370, tmp369
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s4,s4,a6	# pretmp_317, tmp373, tmp370
	slli	s4,s4,16	#, _114, tmp373
	srli	s4,s4,16	#, _114, _114
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	beq	a4,zero,.L492	#, tmp380,,
	neg	a0,a5	# v1, _316
.L492:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,40(sp)		#, %sfp
	lw	a3,44(sp)		#, %sfp
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	andi	s1,s1,64	#, tmp391, v0.41_236
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	mv	s3,a0	# sin_theta, tmp565
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	neg	a0,s4	# v1, _114
	bne	s1,zero,.L494	#, tmp391,,
	mv	a0,s4	# v1, _114
.L494:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,40(sp)		#, %sfp
	lw	a3,44(sp)		#, %sfp
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s4,a0	# cos_theta, tmp566
.L496:
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,0(s0)		#, MEM[(int *)_91]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-30	#,, tmp567
	call	__floatsisf		#
	mv	a1,s4	#, cos_theta
	call	__mulsf3		#
	mv	s1,a0	# tmp568,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,8(s0)		#, MEM[(int *)_91 + 8B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s3	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp569,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s1	#, tmp404
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s5	#, tmp530
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp570
	call	__floatsisf		#
	mv	s1,a0	# tmp571,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_91 + 4B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	addi	a0,a0,30	#, tmp418, tmp572
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sub	a0,a0,s6	#, tmp418, _110
	call	__floatsisf		#
	mv	s10,a0	# tmp573,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, cos_theta
	mv	a0,s1	#, _295
	call	__mulsf3		#
	mv	s11,a0	# tmp420, tmp574
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _293
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp575,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, tmp420
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s5	#, tmp530
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp576,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s1	#, _295
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s1,a5	# _289, tmp576
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a5,79		# tmp639,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, sin_theta
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	bgtu	s1,a5,.L498	#, _289, tmp639,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp426, tmp577
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, cos_theta
	mv	a0,s10	#, _293
	call	__mulsf3		#
	mv	a1,a0	# tmp578,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp426
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s8	#, _154
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a0,2	#, tmp432, _350
	add	a5,a5,a0	# _350, tmp433, tmp432
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	lw	a4,8(sp)		# tmp500, %sfp
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,4	#, tmp434, tmp433
	add	a5,a5,s1	# _289, tmp435, tmp434
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,2	#, tmp436, tmp435
	add	a5,a4,a5	# tmp436, tmp437, tmp500
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	a4,59		# tmp641,
	bgtu	a0,a4,.L498	#, _350, tmp641,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	li	a4,-1		# tmp642,
	sw	a4,0(a5)	# tmp642, *_344
.L498:
# main_sphere3d_hdmi.c:20:   for (int i = 0; i < s - 1; i = i + 1) {
	addi	s0,s0,12	#, ivtmp.473, ivtmp.473
	bne	s9,s0,.L496	#, _159, ivtmp.473,
# main_sphere3d_hdmi.c:81:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	lw	a5,24(sp)		# fb_ctrl.58_22, %sfp
	li	a4,268435456		# prephitmp_381,
	lw	a5,0(a5)		# *fb_ctrl.58_22, *fb_ctrl.58_22
	andi	a5,a5,1	#, tmp441, *fb_ctrl.58_22
# main_sphere3d_hdmi.c:81:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	bne	a5,zero,.L499	#, tmp441,,
	li	a4,268468224		# prephitmp_381,
.L499:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	lw	a5,8(sp)		# tmp500, %sfp
# main_sphere3d_hdmi.c:87:     if (s >= 2) delta_scale = -delta_scale;
	lw	a1,84(sp)		#, %sfp
	mv	a0,s2	#, s
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	sw	a5,44(s7)	# tmp500, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	lw	a5,32(sp)		# tmp449, %sfp
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a4,48(s7)	# prephitmp_381, MEM[(volatile uint32_t *)805306416B]
# main_sphere3d_hdmi.c:82:     *fb_ctrl ^= 1;
	lw	a4,24(sp)		# fb_ctrl.58_22, %sfp
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	a5,52(s7)	# tmp449, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a5,1		# tmp646,
	sw	a5,56(s7)	# tmp646, MEM[(volatile uint32_t *)805306424B]
# main_sphere3d_hdmi.c:82:     *fb_ctrl ^= 1;
	lw	a5,0(a4)		# *fb_ctrl.58_22, *fb_ctrl.58_22
	xori	a5,a5,1	#, tmp454, *fb_ctrl.58_22
	sw	a5,0(a4)	# tmp454, *fb_ctrl.58_22
# main_sphere3d_hdmi.c:87:     if (s >= 2) delta_scale = -delta_scale;
	call	__gesf2		#
# main_sphere3d_hdmi.c:85:     angle += delta_angle;
	lw	a5,12(sp)		# angle, %sfp
	lw	a4,16(sp)		# delta_angle, %sfp
	add	a5,a5,a4	# delta_angle, angle, angle
	sw	a5,12(sp)	# angle, %sfp
# main_sphere3d_hdmi.c:87:     if (s >= 2) delta_scale = -delta_scale;
	blt	a0,zero,.L500	#, tmp580,,
# main_sphere3d_hdmi.c:87:     if (s >= 2) delta_scale = -delta_scale;
	lw	a4,20(sp)		# tmp654, %sfp
	li	a5,-2147483648		# tmp653,
	xor	a5,a5,a4	# tmp654, tmp652, tmp653
	sw	a5,20(sp)	# tmp652, %sfp
.L500:
# main_sphere3d_hdmi.c:88:     if (s <= 0) delta_scale = -delta_scale;
	mv	a1,zero	#,
	mv	a0,s2	#, s
	call	__lesf2		#
	bgt	a0,zero,.L502	#, tmp581,,
# main_sphere3d_hdmi.c:88:     if (s <= 0) delta_scale = -delta_scale;
	lw	a4,20(sp)		# tmp657, %sfp
	li	a5,-2147483648		# tmp656,
	xor	a5,a5,a4	# tmp657, tmp655, tmp656
	sw	a5,20(sp)	# tmp655, %sfp
.L502:
# main_sphere3d_hdmi.c:90:     if (angle <= 0) delta_angle = -delta_angle;
	lw	a5,12(sp)		# angle, %sfp
# main_sphere3d_hdmi.c:89:     if (angle >= 359) delta_angle = -delta_angle;
	lw	a3,16(sp)		# delta_angle, %sfp
# main_sphere3d_hdmi.c:90:     if (angle <= 0) delta_angle = -delta_angle;
	li	a4,357		# tmp465,
	addi	a5,a5,-1	#, tmp464, angle
# main_sphere3d_hdmi.c:89:     if (angle >= 359) delta_angle = -delta_angle;
	neg	s0,a3	# delta_angle, delta_angle
# main_sphere3d_hdmi.c:90:     if (angle <= 0) delta_angle = -delta_angle;
	bleu	a5,a4,.L514	#, tmp464, tmp465,
.L504:
# main_sphere3d_hdmi.c:91:     s += delta_scale;
	lw	a1,20(sp)		#, %sfp
	mv	a0,s2	#, s
	call	__addsf3		#
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	lw	a5,8(sp)		# tmp500, %sfp
# main_sphere3d_hdmi.c:91:     s += delta_scale;
	mv	s2,a0	# s, tmp582
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	sw	a5,44(s7)	# tmp500, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	lw	a5,32(sp)		# tmp449, %sfp
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	zero,48(s7)	#, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	a5,52(s7)	# tmp449, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a5,2		# tmp477,
	sw	a5,56(s7)	# tmp477, MEM[(volatile uint32_t *)805306424B]
# main_sphere3d_hdmi.c:96:     led &= 7;
	lw	a5,28(sp)		# led, %sfp
# main_sphere3d_hdmi.c:95:     IO_OUT(GPIO_OUTPUT, 0);
	sw	zero,28(s7)	#, MEM[(volatile uint32_t *)805306396B]
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a3,28(s7)		# _330, MEM[(volatile uint32_t *)805306396B]
# main_sphere3d_hdmi.c:96:     led &= 7;
	andi	a4,a5,7	#, led, led
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp663,
	sll	a5,a5,a4	# led, tmp484, tmp663
# main_sphere3d_hdmi.c:97:     gpio_set_value(led++, 1);
	addi	a4,a4,1	#, led, led
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _330, _334, tmp484
# main_sphere3d_hdmi.c:97:     gpio_set_value(led++, 1);
	sw	a4,28(sp)	# led, %sfp
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	sw	a5,28(s7)	# _334, MEM[(volatile uint32_t *)805306396B]
	sw	s0,16(sp)	# delta_angle, %sfp
	j	.L505		#
.L514:
# main_sphere3d_hdmi.c:90:     if (angle <= 0) delta_angle = -delta_angle;
	mv	s0,a3	# delta_angle, delta_angle
	j	.L504		#
	.size	main, .-main
	.globl	fb_ctrl
	.globl	stars
	.globl	oled_8bit_init_seq
	.globl	framebuffer
	.globl	heap_memory_used
	.globl	heap_memory
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC1:
	.word	0
	.word	1088421888
	.align	3
.LC2:
	.word	0
	.word	1081507840
	.align	3
.LC3:
	.word	4194432
	.word	1056964640
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC4:
	.word	1097859072
	.align	2
.LC5:
	.word	1106247680
	.align	2
.LC6:
	.word	1109393408
	.align	2
.LC7:
	.word	1031127695
	.align	2
.LC8:
	.word	1065353216
	.section	.srodata.cst8
	.align	3
.LC10:
	.word	1413754136
	.word	1074340347
	.align	3
.LC11:
	.word	0
	.word	1080459264
	.section	.srodata.cst4
	.align	2
.LC12:
	.word	1108082688
	.align	2
.LC13:
	.word	1073741824
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
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory, @object
	.size	heap_memory, 1024
heap_memory:
	.zero	1024
	.type	stars, @object
	.size	stars, 4320
stars:
	.zero	4320
	.type	framebuffer, @object
	.size	framebuffer, 19200
framebuffer:
	.zero	19200
	.section	.sbss,"aw",@nobits
	.align	2
	.type	col.0, @object
	.size	col.0, 2
col.0:
	.zero	2
	.zero	2
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.section	.sdata,"aw"
	.align	2
	.type	fb_ctrl, @object
	.size	fb_ctrl, 4
fb_ctrl:
	.word	805306404
	.ident	"GCC: (GNU) 11.1.0"
