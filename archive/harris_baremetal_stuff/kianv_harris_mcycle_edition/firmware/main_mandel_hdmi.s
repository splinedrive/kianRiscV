	.file	"main_mandel_hdmi.c"
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
# kianv_stdlib_hdmi.h:50:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp77,
	sw	a0,44(a5)	# src, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib_hdmi.h:51:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a1,48(a5)	# dst, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib_hdmi.h:52:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	sw	a2,52(a5)	# len, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib_hdmi.h:53:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	sw	a3,56(a5)	# ctrl, MEM[(volatile uint32_t *)805306424B]
# kianv_stdlib_hdmi.h:54: }
	ret	
	.size	dma_action, .-dma_action
	.align	2
	.globl	set_reg
	.type	set_reg, @function
set_reg:
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a4,0(a0)		# _1,* p
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp85,
	sll	a5,a5,a1	# tmp88, _12, tmp85
# kianv_stdlib_hdmi.h:57:     if (bit) {
	beq	a2,zero,.L4	#, tmp89,,
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a4	# _1, _5, _12
	sw	a5,0(a0)	# _5,* p
	ret	
.L4:
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp86, _12
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a4	# _13, _18, tmp86
	sw	a5,0(a0)	# _18,* p
# kianv_stdlib_hdmi.h:62: }
	ret	
	.size	set_reg, .-set_reg
	.align	2
	.globl	gpio_set_value
	.type	gpio_set_value, @function
gpio_set_value:
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,28(a4)		# _4,
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _19, tmp84
# kianv_stdlib_hdmi.h:57:     if (bit) {
	beq	a1,zero,.L7	#, tmp95,,
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,28(a4)	# _8,
	ret	
.L7:
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _19
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,28(a4)	# _17,
# kianv_stdlib_hdmi.h:66: }
	ret	
	.size	gpio_set_value, .-gpio_set_value
	.align	2
	.globl	gpio_get_input_value
	.type	gpio_get_input_value, @function
gpio_get_input_value:
# kianv_stdlib_hdmi.h:69:   uint32_t read = IO_IN(GPIO_INPUT);
	li	a5,805306368		# tmp77,
	lw	a5,32(a5)		# read, MEM[(volatile uint32_t *)805306400B]
# kianv_stdlib_hdmi.h:72:   return ((read >> gpio) & 0x01);
	srl	a0,a5,a0	# tmp80, tmp79, read
# kianv_stdlib_hdmi.h:73: }
	andi	a0,a0,1	#,, tmp79
	ret	
	.size	gpio_get_input_value, .-gpio_get_input_value
	.align	2
	.globl	gpio_set_direction
	.type	gpio_set_direction, @function
gpio_set_direction:
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,20(a4)		# _4,
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _19, tmp84
# kianv_stdlib_hdmi.h:57:     if (bit) {
	beq	a1,zero,.L11	#, tmp95,,
# kianv_stdlib_hdmi.h:58:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,20(a4)	# _8,
	ret	
.L11:
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _19
# kianv_stdlib_hdmi.h:60:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,20(a4)	# _17,
# kianv_stdlib_hdmi.h:77: }
	ret	
	.size	gpio_set_direction, .-gpio_set_direction
	.align	2
	.globl	get_cycles
	.type	get_cycles, @function
get_cycles:
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp78
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp78, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp79
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp79, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_1, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_4, tmpl0
# kianv_stdlib_hdmi.h:88: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	get_cycles, .-get_cycles
	.align	2
	.globl	wait_cycles
	.type	wait_cycles, @function
wait_cycles:
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp86
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp86, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp87
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp87, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_5, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,4(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib_hdmi.h:95:   uint64_t lim = get_cycles() + wait;
	add	a5,a5,a1	# wait, tmp126, tmph0.0_5
	add	a2,a0,a2	# tmpl0.1_8, tmp129, wait
	sltu	a0,a2,a0	# wait, tmp98, tmp129
	add	a4,a0,a5	# tmp126, tmp100, tmp98
.L18:
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp101
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp101, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp102
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp102, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_11, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,12(sp)		# tmpl0.1_14, tmpl0
# kianv_stdlib_hdmi.h:96:   while (get_cycles() < lim)
	bgtu	a4,a5,.L18	#, tmp100, tmph0.0_11,
	bne	a4,a5,.L15	#, tmp100, tmph0.0_11,
	bgtu	a2,a3,.L18	#, tmp129, tmpl0.1_14,
.L15:
# kianv_stdlib_hdmi.h:98: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib_hdmi.h:101:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L29	#, us,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib_hdmi.h:100: void usleep(uint32_t us) {
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a3	# tmp93
# 0 "" 2
# kianv_stdlib_hdmi.h:101:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
 #NO_APP
	li	a4,999424		# tmp97,
	addi	a4,a4,576	#, tmp96, tmp97
	divu	a5,a5,a4	# tmp96, tmp95, _20
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a3,12(sp)	# tmp93, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib_hdmi.h:101:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	mul	a5,a5,a0	# tmp98, tmp95, us
# kianv_stdlib_hdmi.h:95:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp141, tmp98
	sltu	a5,a2,a5	# tmp98, tmp110, tmp141
	add	a5,a5,a4	# tmph0.0_7, tmp112, tmp110
.L26:
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp113, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a4	# tmp114
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp114, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib_hdmi.h:96:   while (get_cycles() < lim)
	bgtu	a5,a4,.L26	#, tmp112, tmph0.0_14,
	bne	a5,a4,.L20	#, tmp112, tmph0.0_14,
	bgtu	a2,a3,.L26	#, tmp141, tmpl0.1_17,
.L20:
# kianv_stdlib_hdmi.h:102: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L29:
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib_hdmi.h:105:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L41	#, ms,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib_hdmi.h:104: void msleep(uint32_t ms) {
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a4	# tmp93
# 0 "" 2
# kianv_stdlib_hdmi.h:105:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
 #NO_APP
	li	a3,1000		# tmp95,
	divu	a5,a5,a3	# tmp95, tmp96, _20
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a4,12(sp)	# tmp93, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib_hdmi.h:105:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a5,a5,a0	# tmp97, tmp96, ms
# kianv_stdlib_hdmi.h:95:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp140, tmp97
	sltu	a5,a2,a5	# tmp97, tmp109, tmp140
	add	a5,a5,a4	# tmph0.0_7, tmp111, tmp109
.L38:
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a4	# tmp112
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp112, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp113, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib_hdmi.h:96:   while (get_cycles() < lim)
	bgtu	a5,a4,.L38	#, tmp111, tmph0.0_14,
	bne	a5,a4,.L32	#, tmp111, tmph0.0_14,
	bgtu	a2,a3,.L38	#, tmp140, tmpl0.1_17,
.L32:
# kianv_stdlib_hdmi.h:106: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L41:
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib_hdmi.h:109:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L53	#, sec,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp90,
# kianv_stdlib_hdmi.h:108: void sleep(uint32_t sec) {
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a4,16(a5)		# _19, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp91
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp91, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp92
# 0 "" 2
# kianv_stdlib_hdmi.h:109:   if (sec) wait_cycles(sec * get_cpu_freq());
 #NO_APP
	mul	a0,a0,a4	# tmp101, sec, _19
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a5,12(sp)	# tmp92, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib_hdmi.h:95:   uint64_t lim = get_cycles() + wait;
	add	a0,a4,a0	# tmp101, tmp136, tmpl0.1_9
	sltu	a4,a0,a4	# tmpl0.1_9, tmp105, tmp136
	add	a4,a4,a5	# tmph0.0_6, tmp107, tmp105
.L50:
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp108
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp108, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp109
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp109, tmpl0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_13, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_16, tmpl0
# kianv_stdlib_hdmi.h:96:   while (get_cycles() < lim)
	bgtu	a4,a5,.L50	#, tmp107, tmph0.0_13,
	bne	a4,a5,.L44	#, tmp107, tmph0.0_13,
	bgtu	a0,a3,.L50	#, tmp136, tmpl0.1_16,
.L44:
# kianv_stdlib_hdmi.h:110: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L53:
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:113:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	li	a5,999424		# tmp98,
	addi	a5,a5,576	#, tmp97, tmp98
# kianv_stdlib_hdmi.h:113:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	divu	a2,a2,a5	# tmp97,, _5
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib_hdmi.h:114: }
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
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:117:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	li	a5,1000		# tmp96,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp96,, _5
	call	__udivdi3		#
# kianv_stdlib_hdmi.h:118: }
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
# kianv_stdlib_hdmi.h:83:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 83 "kianv_stdlib_hdmi.h" 1
	rdcycleh a5	# tmp81
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp81, tmph0
# kianv_stdlib_hdmi.h:84:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 84 "kianv_stdlib_hdmi.h" 1
	rdcycle  a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp82, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp84,
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_5, tmph0
# kianv_stdlib_hdmi.h:86:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib_hdmi.h:91:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _4, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib_hdmi.h:121:   return get_cycles() / (uint64_t) (get_cpu_freq());
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib_hdmi.h:122: }
	lw	ra,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp76,
.L63:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L63	#, _2,,
# kianv_stdlib_hdmi.h:127:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a4)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	li	a5,13		# tmp78,
	beq	a0,a5,.L70	#, c, tmp78,
# kianv_stdlib_hdmi.h:133: }
	ret	
.L70:
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp79,
.L65:
	lw	a5,0(a4)		# _8, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L65	#, _8,,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp81,
	sw	a5,0(a4)	# tmp81, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:133: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp76,
.L72:
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L72	#, _3,,
# kianv_stdlib_hdmi.h:127:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	li	a5,13		# tmp78,
	beq	a0,a5,.L79	#, ch, tmp78,
# kianv_stdlib_hdmi.h:137: }
	ret	
.L79:
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp79,
.L74:
	lw	a5,0(a4)		# _8, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L74	#, _8,,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp81,
	sw	a5,0(a4)	# tmp81, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:137: }
	ret	
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_char
	.type	print_char, @function
print_char:
	li	a4,805306368		# tmp76,
.L81:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L81	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	li	a5,13		# tmp78,
	beq	a0,a5,.L88	#, ch, tmp78,
	ret	
.L88:
	li	a4,805306368		# tmp79,
.L83:
	lw	a5,0(a4)		# _6, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L83	#, _6,,
	li	a5,10		# tmp81,
	sw	a5,0(a4)	# tmp81, MEM[(volatile uint32_t *)805306368B]
	ret	
	.size	print_char, .-print_char
	.align	2
	.globl	print_str
	.type	print_str, @function
print_str:
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, *p_6(D)
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	beq	a3,zero,.L89	#, _3,,
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp78,
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	li	a2,13		# tmp81,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp85,
.L91:
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L91	#, _1,,
# kianv_stdlib_hdmi.h:147:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L92:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _9, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L92	#, _9,,
# kianv_stdlib_hdmi.h:127:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	beq	a3,a2,.L94	#, _3, tmp81,
.L93:
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	bne	a3,zero,.L91	#, _3,,
.L89:
# kianv_stdlib_hdmi.h:149: }
	ret	
.L94:
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _14, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L94	#, _14,,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp85, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:133: }
	j	.L93		#
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	lbu	a3,0(a0)	# _11, *p_2(D)
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	beq	a3,zero,.L107	#, _11,,
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp80,
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	li	a2,13		# tmp83,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp93,
.L108:
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:145:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L108	#, _7,,
# kianv_stdlib_hdmi.h:147:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L109:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _10, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L109	#, _10,,
# kianv_stdlib_hdmi.h:127:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _11, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:128:    if (c == 13) {
	beq	a3,a2,.L111	#, _11, tmp83,
.L110:
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	lbu	a3,0(a0)	# _11, MEM[(char *)p_9]
# kianv_stdlib_hdmi.h:144:   while (*p != 0) {
	bne	a3,zero,.L108	#, _11,,
.L107:
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp87,
.L113:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:125:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L113	#, _4,,
# kianv_stdlib_hdmi.h:127:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,13		# tmp89,
	sw	a5,0(a4)	# tmp89, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp90,
.L114:
	lw	a5,0(a4)		# _15, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L114	#, _15,,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp92,
	sw	a5,0(a4)	# tmp92, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:154: }
	ret	
.L111:
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _14, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:129:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L111	#, _14,,
# kianv_stdlib_hdmi.h:131:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp93, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:133: }
	j	.L110		#
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib_hdmi.h:160:   char *p = buffer;
	addi	a2,sp,4	#, tmp90,
	mv	a5,a2	# p, tmp90
# kianv_stdlib_hdmi.h:162:     *(p++) = val % 10;
	li	a4,10		# tmp91,
.L130:
# kianv_stdlib_hdmi.h:161:   while (val || p == buffer) {
	bne	a0,zero,.L131	#, val,,
# kianv_stdlib_hdmi.h:161:   while (val || p == buffer) {
	bne	a5,a2,.L135	#, p, tmp90,
.L131:
# kianv_stdlib_hdmi.h:162:     *(p++) = val % 10;
	remu	a3,a0,a4	# tmp91, tmp82, val
# kianv_stdlib_hdmi.h:162:     *(p++) = val % 10;
	addi	a5,a5,1	#, p, p
# kianv_stdlib_hdmi.h:163:     val = val / 10;
	divu	a0,a0,a4	# tmp91, val, val
# kianv_stdlib_hdmi.h:162:     *(p++) = val % 10;
	sb	a3,-1(a5)	# tmp82, MEM[(char *)p_17 + 4294967295B]
	j	.L130		#
.L135:
# kianv_stdlib_hdmi.h:167:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	li	a3,805306368		# tmp88,
.L132:
# kianv_stdlib_hdmi.h:167:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a4,-1(a5)	# MEM[(char *)p_15], MEM[(char *)p_15]
# kianv_stdlib_hdmi.h:167:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,-1	#, p, p
# kianv_stdlib_hdmi.h:167:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,48	#, _6, MEM[(char *)p_15]
# kianv_stdlib_hdmi.h:167:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a4,0(a3)	# _6, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:166:   while (p != buffer) {
	bne	a5,a2,.L132	#, p, tmp90,
# kianv_stdlib_hdmi.h:169: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	print_dec, .-print_dec
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-32	#,,
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	li	t3,-858992640		# tmp256,
# kianv_stdlib_hdmi.h:173:   char *p = buffer;
	addi	t4,sp,12	#, tmp252,
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	li	t1,268435456		# tmp253,
	addi	a7,t3,-819	#, tmp257, tmp256
# kianv_stdlib_hdmi.h:171: void print_dec64(uint64_t val) {
	mv	a4,a0	# val, tmp259
	mv	a6,a1	# val, tmp260
# kianv_stdlib_hdmi.h:173:   char *p = buffer;
	mv	a2,t4	# p, tmp252
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	addi	t1,t1,-1	#, tmp254, tmp253
	li	t5,5		# tmp255,
	addi	t3,t3,-820	#, tmp258, tmp256
# kianv_stdlib_hdmi.h:174:   while (val || p == buffer) {
	j	.L137		#
.L138:
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	remu	a5,a5,t5	# tmp255, tmp96, tmp93
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	addi	a2,a2,1	#, p, p
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	sub	a5,a4,a5	# tmp212, val, tmp96
	sgtu	a1,a5,a4	# tmp100, tmp212, val
	sub	a1,a6,a1	# tmp102, val, tmp100
	mul	a0,a5,t3	# tmp106, tmp212, tmp258
	mul	a1,a1,a7	# tmp103, tmp102, tmp257
	mulhu	a3,a5,a7	# tmp215, tmp212, tmp257
	add	a1,a1,a0	# tmp106, tmp109, tmp103
	mul	a5,a5,a7	# tmp113, tmp212, tmp257
	add	a1,a1,a3	# tmp215, tmp114, tmp109
	slli	a3,a1,31	#, tmp132, tmp114
# kianv_stdlib_hdmi.h:176:     val = val / 10;
	srli	a6,a1,1	#, val, tmp114
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	srli	a5,a5,1	#, tmp222, tmp113
	or	a5,a3,a5	# tmp222, tmp222, tmp132
	slli	a0,a5,2	#, tmp226, tmp222
	add	a0,a0,a5	# tmp222, tmp228, tmp226
	slli	a0,a0,1	#, tmp230, tmp228
	sub	a0,a4,a0	# tmp232, val, tmp230
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	sb	a0,-1(a2)	# tmp232, MEM[(char *)p_17 + 4294967295B]
# kianv_stdlib_hdmi.h:176:     val = val / 10;
	mv	a4,a5	# val, tmp222
.L137:
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	slli	a5,a6,4	#, tmp87, val
	srli	a3,a4,28	#, tmp206, val
	or	a3,a5,a3	# tmp206, tmp206, tmp87
	and	a3,a3,t1	# tmp254, tmp88, tmp206
	and	a5,a4,t1	# tmp254, tmp83, val
	add	a5,a5,a3	# tmp88, tmp91, tmp83
	srli	a1,a6,24	#, tmp208, val
# kianv_stdlib_hdmi.h:174:   while (val || p == buffer) {
	or	a3,a4,a6	# val, val, val
# kianv_stdlib_hdmi.h:175:     *(p++) = val % 10;
	add	a5,a5,a1	# tmp208, tmp93, tmp91
# kianv_stdlib_hdmi.h:174:   while (val || p == buffer) {
	bne	a3,zero,.L138	#, val,,
# kianv_stdlib_hdmi.h:174:   while (val || p == buffer) {
	beq	a2,t4,.L138	#, p, tmp252,
# kianv_stdlib_hdmi.h:180:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	li	a4,805306368		# tmp202,
.L139:
# kianv_stdlib_hdmi.h:180:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a2)	# MEM[(char *)p_15], MEM[(char *)p_15]
# kianv_stdlib_hdmi.h:180:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a2,a2,-1	#, p, p
# kianv_stdlib_hdmi.h:180:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _6, MEM[(char *)p_15]
# kianv_stdlib_hdmi.h:180:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _6, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:179:   while (p != buffer) {
	bne	a2,t4,.L139	#, p, tmp252,
# kianv_stdlib_hdmi.h:182: }
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
# kianv_stdlib_hdmi.h:185:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-1	#, tmp84, tmp96
# kianv_stdlib_hdmi.h:185:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a1,a1,2	#, i, tmp84
# kianv_stdlib_hdmi.h:185:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	blt	a1,zero,.L142	#, i,,
	lui	a4,%hi(.LC0)	# tmp93,
	li	a2,-4		# _7,
	addi	a4,a4,%lo(.LC0)	# tmp92, tmp93,
# kianv_stdlib_hdmi.h:186:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	li	a3,805306368		# tmp91,
.L144:
# kianv_stdlib_hdmi.h:186:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a1	# i, tmp88, val
# kianv_stdlib_hdmi.h:186:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp89, tmp88
# kianv_stdlib_hdmi.h:186:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a4,a5	# tmp89, tmp90, tmp92
	lbu	a5,0(a5)	# _5, "0123456789ABCDEF"[_3]
# kianv_stdlib_hdmi.h:185:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-4	#, i, i
# kianv_stdlib_hdmi.h:186:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a3)	# _5, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib_hdmi.h:185:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bne	a2,a1,.L144	#, _7, i,
.L142:
# kianv_stdlib_hdmi.h:188: }
	ret	
	.size	print_hex, .-print_hex
	.align	2
	.globl	setpixel
	.type	setpixel, @function
setpixel:
# kianv_stdlib_hdmi.h:197:   const int y_offset = y*80;
	slli	a5,a2,2	#, tmp82, tmp89
	add	a2,a5,a2	# tmp89, y_offset, tmp82
	slli	a2,a2,4	#, tmp84, y_offset
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	add	a2,a2,a1	# tmp88, tmp85, tmp84
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	slli	a2,a2,2	#, tmp86, tmp85
	add	a0,a0,a2	# tmp86, _4, tmp87
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	sw	a3,0(a0)	# color, *_4
# kianv_stdlib_hdmi.h:200: }
	ret	
	.size	setpixel, .-setpixel
	.align	2
	.globl	draw_bresenham
	.type	draw_bresenham, @function
draw_bresenham:
	addi	sp,sp,-48	#,,
	sw	s5,20(sp)	#,
	mv	s5,a0	# tmp107, fb
# kianv_stdlib_hdmi.h:205:   int dx =  abs(x1 - x0);
	sub	a0,a3,a1	#, x1, x0
# kianv_stdlib_hdmi.h:203: {
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	mv	s0,a1	# x0, tmp108
	mv	s1,a2	# y0, tmp109
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	mv	s3,a3	# x1, tmp110
	mv	s4,a5	# color, tmp112
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
# kianv_stdlib_hdmi.h:203: {
	mv	s7,a4	# y1, tmp111
# kianv_stdlib_hdmi.h:205:   int dx =  abs(x1 - x0);
	call	abs		#
	mv	s2,a0	# tmp113,
# kianv_stdlib_hdmi.h:207:   int dy = -abs(y1 - y0);
	sub	a0,s7,s1	#, y1, y0
	call	abs		#
# kianv_stdlib_hdmi.h:206:   int sx = x0 < x1 ? 1 : -1;
	sgt	s6,s3,s0	# tmp102, x1, x0
# kianv_stdlib_hdmi.h:208:   int sy = y0 < y1 ? 1 : -1;
	sgt	a3,s7,s1	# tmp105, y1, y0
# kianv_stdlib_hdmi.h:206:   int sx = x0 < x1 ? 1 : -1;
	slli	s6,s6,1	#, iftmp.5_9, tmp102
# kianv_stdlib_hdmi.h:208:   int sy = y0 < y1 ? 1 : -1;
	slli	a3,a3,1	#, iftmp.6_10, tmp105
# kianv_stdlib_hdmi.h:206:   int sx = x0 < x1 ? 1 : -1;
	addi	s6,s6,-1	#, iftmp.5_9, iftmp.5_9
# kianv_stdlib_hdmi.h:207:   int dy = -abs(y1 - y0);
	neg	a5,a0	# dy, _3
# kianv_stdlib_hdmi.h:208:   int sy = y0 < y1 ? 1 : -1;
	addi	a3,a3,-1	#, iftmp.6_10, iftmp.6_10
	sub	a2,s2,a0	# err, dx, _3
	slli	a7,s1,2	#, tmp100, y0
.L150:
# kianv_stdlib_hdmi.h:197:   const int y_offset = y*80;
	add	a6,a7,s1	# y0, y_offset, tmp100
	slli	a6,a6,4	#, tmp97, y_offset
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	add	a6,a6,s0	# x0, tmp98, tmp97
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	slli	a6,a6,2	#, tmp99, tmp98
	add	a6,s5,a6	# tmp99, _36, fb
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	sw	s4,0(a6)	# color, *_36
# kianv_stdlib_hdmi.h:214:     e2 = 2*err;
	slli	a1,a2,1	#, e2, err
# kianv_stdlib_hdmi.h:213:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s3,.L158	#, x0, x1,
.L151:
# kianv_stdlib_hdmi.h:215:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	a5,a1,.L153	#, dy, e2,
	sub	a2,a2,a0	# err, err, _3
# kianv_stdlib_hdmi.h:215:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s0,s0,s6	# iftmp.5_9, x0, x0
.L153:
# kianv_stdlib_hdmi.h:216:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L150	#, dx, e2,
# kianv_stdlib_hdmi.h:216:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s1,s1,a3	# iftmp.6_10, y0, y0
	slli	a7,s1,2	#, tmp100, y0
# kianv_stdlib_hdmi.h:197:   const int y_offset = y*80;
	add	a6,a7,s1	# y0, y_offset, tmp100
	slli	a6,a6,4	#, tmp97, y_offset
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	add	a6,a6,s0	# x0, tmp98, tmp97
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	slli	a6,a6,2	#, tmp99, tmp98
	add	a6,s5,a6	# tmp99, _36, fb
# kianv_stdlib_hdmi.h:216:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a2,a2,s2	# dx, err, err
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	sw	s4,0(a6)	# color, *_36
# kianv_stdlib_hdmi.h:214:     e2 = 2*err;
	slli	a1,a2,1	#, e2, err
# kianv_stdlib_hdmi.h:213:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s3,.L151	#, x0, x1,
.L158:
# kianv_stdlib_hdmi.h:213:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s7,.L151	#, y0, y1,
# kianv_stdlib_hdmi.h:218: }
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
	.size	draw_bresenham, .-draw_bresenham
	.align	2
	.globl	mandel
	.type	mandel, @function
mandel:
# main_mandel_hdmi.c:47:       if(indexed) {
	lui	a5,%hi(indexed)	# tmp102,
	lw	t4,%lo(indexed)(a5)		# indexed.7_64, indexed
# main_mandel_hdmi.c:27: void mandel(volatile Pixel *framebuffer, uint32_t shift) {
	mv	t5,a1	# shift, tmp127
	mv	t0,a0	# ivtmp.163, tmp126
# main_mandel_hdmi.c:29:   int Ci = ymin;
	li	a6,-2048		# Ci,
# main_mandel_hdmi.c:42:         if(Zrr + Zii > norm_max) {
	li	a7,4096		# tmp109,
# main_mandel_hdmi.c:49:                   setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
	li	t6,15		# tmp122,
# main_mandel_hdmi.c:32:     for(int X = 0; X< HRES; ++X) {
	li	t3,2032		# tmp119,
.L160:
# main_mandel_hdmi.c:47:       if(indexed) {
	mv	t1,t0	# ivtmp.151, ivtmp.163
# main_mandel_hdmi.c:31:     int Cr = xmin;
	li	a0,-2048		# Cr,
.L167:
# main_mandel_hdmi.c:27: void mandel(volatile Pixel *framebuffer, uint32_t shift) {
	mv	a5,a6	# Zi, Ci
	mv	a3,a0	# Zr, Cr
# main_mandel_hdmi.c:35:       int iter = 255;
	li	a1,255		# iter,
	j	.L162		#
.L176:
# main_mandel_hdmi.c:45:         --iter;
	addi	a1,a1,-1	#, iter, iter
# main_mandel_hdmi.c:36:       while(iter > 0) {
	beq	a1,zero,.L175	#, iter,,
.L162:
# main_mandel_hdmi.c:37:         int Zrr = (Zr * Zr) >> mandel_shift;
	mul	a4,a3,a3	# tmp103, Zr, Zr
# main_mandel_hdmi.c:38:         int Zii = (Zi * Zi) >> mandel_shift;
	mul	a2,a5,a5	# tmp104, Zi, Zi
# main_mandel_hdmi.c:37:         int Zrr = (Zr * Zr) >> mandel_shift;
	srai	a4,a4,10	#, Zrr, tmp103
# main_mandel_hdmi.c:39:         int Zri = (Zr * Zi) >> (mandel_shift - 1);
	mul	a5,a3,a5	# tmp105, Zr, Zi
# main_mandel_hdmi.c:38:         int Zii = (Zi * Zi) >> mandel_shift;
	srai	a2,a2,10	#, Zii, tmp104
# main_mandel_hdmi.c:40:         Zr = Zrr - Zii + Cr;
	sub	a3,a4,a2	# tmp106, Zrr, Zii
# main_mandel_hdmi.c:42:         if(Zrr + Zii > norm_max) {
	add	a4,a4,a2	# Zii, tmp107, Zrr
# main_mandel_hdmi.c:40:         Zr = Zrr - Zii + Cr;
	add	a3,a3,a0	# Cr, Zr, tmp106
# main_mandel_hdmi.c:39:         int Zri = (Zr * Zi) >> (mandel_shift - 1);
	srai	a5,a5,9	#, Zri, tmp105
# main_mandel_hdmi.c:41:         Zi = Zri + Ci;
	add	a5,a5,a6	# Ci, Zi, Zri
# main_mandel_hdmi.c:42:         if(Zrr + Zii > norm_max) {
	ble	a4,a7,.L176	#, tmp107, tmp109,
# main_mandel_hdmi.c:47:       if(indexed) {
	bne	t4,zero,.L177	#, indexed.7_64,,
.L169:
# main_mandel_hdmi.c:53:                  setpixel(framebuffer, X, Y, ((iter << 19) | (iter << 2)) << shift);
	slli	a5,a1,19	#, tmp116, iter
# main_mandel_hdmi.c:53:                  setpixel(framebuffer, X, Y, ((iter << 19) | (iter << 2)) << shift);
	slli	a4,a1,2	#, tmp117, iter
# main_mandel_hdmi.c:53:                  setpixel(framebuffer, X, Y, ((iter << 19) | (iter << 2)) << shift);
	or	a5,a5,a4	# tmp117, tmp118, tmp116
# main_mandel_hdmi.c:52:         setpixel(framebuffer, X, Y, (iter << 8));
	slli	a1,a1,8	#, _10, iter
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	sw	a1,0(t1)	# _10, *_51
# main_mandel_hdmi.c:53:                  setpixel(framebuffer, X, Y, ((iter << 19) | (iter << 2)) << shift);
	sll	a5,a5,t5	# shift, _15, tmp118
.L174:
# kianv_stdlib_hdmi.h:199:   fb[x_offset + y_offset] = color;
	sw	a5,0(t1)	# _15,* ivtmp.151
# main_mandel_hdmi.c:57:       Cr += dx;
	addi	a0,a0,51	#, Cr, Cr
# main_mandel_hdmi.c:32:     for(int X = 0; X< HRES; ++X) {
	addi	t1,t1,4	#, ivtmp.151, ivtmp.151
	bne	a0,t3,.L167	#, Cr, tmp119,
# main_mandel_hdmi.c:59:     Ci += dy;
	addi	a6,a6,68	#, Ci, Ci
# main_mandel_hdmi.c:30:   for(int Y = 0; Y < VRES; ++Y) {
	addi	t0,t0,320	#, ivtmp.163, ivtmp.163
	bne	a6,a0,.L160	#, Ci, Cr,
# main_mandel_hdmi.c:61: }
	ret	
.L177:
# main_mandel_hdmi.c:49:                   setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
	rem	a1,a1,t6	# tmp122, tmp115, iter
# main_mandel_hdmi.c:49:                   setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
	addi	a5,a1,1	#, iftmp.8_23, tmp115
	j	.L174		#
.L175:
# main_mandel_hdmi.c:49:                   setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
	li	a5,0		# iftmp.8_23,
# main_mandel_hdmi.c:47:       if(indexed) {
	bne	t4,zero,.L174	#, indexed.7_64,,
	j	.L169		#
	.size	mandel, .-mandel
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16	#,,
# main_mandel_hdmi.c:70:     mandel(fb, shift++);
	lui	a5,%hi(fb)	# tmp74,
# main_mandel_hdmi.c:66: void main() {
	sw	s1,4(sp)	#,
# main_mandel_hdmi.c:70:     mandel(fb, shift++);
	lw	s1,%lo(fb)(a5)		# pretmp_8, fb
# main_mandel_hdmi.c:66: void main() {
	sw	s0,8(sp)	#,
	sw	ra,12(sp)	#,
# main_mandel_hdmi.c:70:     mandel(fb, shift++);
	li	s0,0		# ivtmp.167,
.L179:
# main_mandel_hdmi.c:70:     mandel(fb, shift++);
	mv	a1,s0	#, ivtmp.167
	mv	a0,s1	#, pretmp_8
	call	mandel		#
	addi	s0,s0,1	#, ivtmp.167, ivtmp.167
	j	.L179		#
	.size	main, .-main
	.globl	fb
	.globl	indexed
	.section	.sbss,"aw",@nobits
	.align	2
	.type	indexed, @object
	.size	indexed, 4
indexed:
	.zero	4
	.section	.sdata,"aw"
	.align	2
	.type	fb, @object
	.size	fb, 4
fb:
	.word	268435456
	.ident	"GCC: (GNU) 11.1.0"
