	.file	"main_raytrace_termio.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (GCC) version 11.1.0 (riscv32-unknown-elf)
#	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=rv32im -mabi=ilp32 -mtune=rocket -march=rv32im -O3 -fno-pic -fno-stack-protector -ffreestanding
	.text
	.align	2
	.globl	set_reg
	.type	set_reg, @function
set_reg:
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a4,0(a0)		# _1,* p
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp85,
	sll	a5,a5,a1	# tmp88, _12, tmp85
# kianv_stdlib.h:42:     if (bit) {
	beq	a2,zero,.L2	#, tmp89,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a4	# _1, _5, _12
	sw	a5,0(a0)	# _5,* p
	ret	
.L2:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp86, _12
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a4	# _13, _18, tmp86
	sw	a5,0(a0)	# _18,* p
# kianv_stdlib.h:47: }
	ret	
	.size	set_reg, .-set_reg
	.align	2
	.globl	gpio_set_value
	.type	gpio_set_value, @function
gpio_set_value:
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,28(a4)		# _4,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _19, tmp84
# kianv_stdlib.h:42:     if (bit) {
	beq	a1,zero,.L6	#, tmp95,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,28(a4)	# _8,
	ret	
.L6:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _19
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,28(a4)	# _17,
# kianv_stdlib.h:51: }
	ret	
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
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,805306368		# tmp86,
	lw	a3,20(a4)		# _4,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	li	a5,1		# tmp84,
	sll	a5,a5,a0	# tmp94, _19, tmp84
# kianv_stdlib.h:42:     if (bit) {
	beq	a1,zero,.L10	#, tmp95,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,20(a4)	# _8,
	ret	
.L10:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a5,a5	# tmp91, _19
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a5,a5,a3	# _12, _17, tmp91
	sw	a5,20(a4)	# _17,
# kianv_stdlib.h:62: }
	ret	
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
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp86
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp86, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp87
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp87, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_5, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,4(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	add	a5,a5,a1	# wait, tmp126, tmph0.0_5
	add	a2,a0,a2	# tmpl0.1_8, tmp129, wait
	sltu	a0,a2,a0	# wait, tmp98, tmp129
	add	a4,a0,a5	# tmp126, tmp100, tmp98
.L17:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp101
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp101, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp102
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp102, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_11, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,12(sp)		# tmpl0.1_14, tmpl0
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	a4,a5,.L17	#, tmp100, tmph0.0_11,
	bne	a4,a5,.L14	#, tmp100, tmph0.0_11,
	bgtu	a2,a3,.L17	#, tmp129, tmpl0.1_14,
.L14:
# kianv_stdlib.h:83: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L28	#, us,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib.h:85: void usleep(uint32_t us) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a3	# tmp93
# 0 "" 2
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
 #NO_APP
	li	a4,999424		# tmp97,
	addi	a4,a4,576	#, tmp96, tmp97
	divu	a5,a5,a4	# tmp96, tmp95, _20
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a3,12(sp)	# tmp93, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	mul	a5,a5,a0	# tmp98, tmp95, us
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp141, tmp98
	sltu	a5,a2,a5	# tmp98, tmp110, tmp141
	add	a5,a5,a4	# tmph0.0_7, tmp112, tmp110
.L25:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp113, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp114
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp114, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	a5,a4,.L25	#, tmp112, tmph0.0_14,
	bne	a5,a4,.L19	#, tmp112, tmph0.0_14,
	bgtu	a2,a3,.L25	#, tmp141, tmpl0.1_17,
.L19:
# kianv_stdlib.h:87: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L28:
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L40	#, ms,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp91,
# kianv_stdlib.h:89: void msleep(uint32_t ms) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a5,16(a5)		# _20, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp92
# 0 "" 2
 #NO_APP
	sw	a4,8(sp)	# tmp92, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp93
# 0 "" 2
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
 #NO_APP
	li	a3,1000		# tmp95,
	divu	a5,a5,a3	# tmp95, tmp96, _20
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a4,12(sp)	# tmp93, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,8(sp)		# tmph0.0_7, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,12(sp)		# tmpl0.1_10, tmpl0
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	mul	a5,a5,a0	# tmp97, tmp96, ms
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	add	a2,a5,a2	# tmpl0.1_10, tmp140, tmp97
	sltu	a5,a2,a5	# tmp97, tmp109, tmp140
	add	a5,a5,a4	# tmph0.0_7, tmp111, tmp109
.L37:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a4	# tmp112
# 0 "" 2
 #NO_APP
	sw	a4,0(sp)	# tmp112, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a4	# tmp113
# 0 "" 2
 #NO_APP
	sw	a4,4(sp)	# tmp113, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,0(sp)		# tmph0.0_14, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_17, tmpl0
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	a5,a4,.L37	#, tmp111, tmph0.0_14,
	bne	a5,a4,.L31	#, tmp111, tmph0.0_14,
	bgtu	a2,a3,.L37	#, tmp140, tmpl0.1_17,
.L31:
# kianv_stdlib.h:91: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L40:
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L52	#, sec,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp90,
# kianv_stdlib.h:93: void sleep(uint32_t sec) {
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a4,16(a5)		# _19, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp91
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp91, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp92
# 0 "" 2
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
 #NO_APP
	mul	a0,a0,a4	# tmp101, sec, _19
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
	sw	a5,12(sp)	# tmp92, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	add	a0,a4,a0	# tmp101, tmp136, tmpl0.1_9
	sltu	a4,a0,a4	# tmpl0.1_9, tmp105, tmp136
	add	a4,a4,a5	# tmph0.0_6, tmp107, tmp105
.L49:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp108
# 0 "" 2
 #NO_APP
	sw	a5,0(sp)	# tmp108, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp109
# 0 "" 2
 #NO_APP
	sw	a5,4(sp)	# tmp109, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a5,0(sp)		# tmph0.0_13, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,4(sp)		# tmpl0.1_16, tmpl0
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	a4,a5,.L49	#, tmp107, tmph0.0_13,
	bne	a4,a5,.L43	#, tmp107, tmph0.0_13,
	bgtu	a0,a3,.L49	#, tmp136, tmpl0.1_16,
.L43:
# kianv_stdlib.h:95: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L52:
	ret	
	.size	sleep, .-sleep
	.globl	__udivdi3
	.align	2
	.globl	nanoseconds
	.type	nanoseconds, @function
nanoseconds:
	addi	sp,sp,-32	#,,
	sw	ra,28(sp)	#,
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:98:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	li	a5,999424		# tmp98,
	addi	a5,a5,576	#, tmp97, tmp98
# kianv_stdlib.h:98:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000000);
	divu	a2,a2,a5	# tmp97,, _5
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:99: }
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
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp82, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp83
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp83, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp85,
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_6, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_9, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _5, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:102:   return get_cycles() / (uint64_t) (get_cpu_freq() / 1000);
	li	a5,1000		# tmp96,
	li	a3,0		#,
	divu	a2,a2,a5	# tmp96,, _5
	call	__udivdi3		#
# kianv_stdlib.h:103: }
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
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp81
# 0 "" 2
 #NO_APP
	sw	a5,8(sp)	# tmp81, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp82
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp82, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp84,
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,8(sp)		# tmph0.0_5, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,12(sp)		# tmpl0.1_8, tmpl0
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	lw	a2,16(a5)		# _4, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:106:   return get_cycles() / (uint64_t) (get_cpu_freq());
	li	a3,0		#,
	call	__udivdi3		#
# kianv_stdlib.h:107: }
	lw	ra,28(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	seconds, .-seconds
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp75,
.L62:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L62	#, _1,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a4)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:113: }
	ret	
	.size	putchar, .-putchar
	.align	2
	.globl	print_chr
	.type	print_chr, @function
print_chr:
	li	a4,805306368		# tmp75,
.L66:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L66	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	ret	
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_str
	.type	print_str, @function
print_str:
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, *p_6(D)
# kianv_stdlib.h:122:   while (*p != 0) {
	beq	a3,zero,.L69	#, _3,,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp76,
.L71:
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L71	#, _1,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a3,0(a4)	# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a3,zero,.L71	#, _3,,
.L69:
# kianv_stdlib.h:127: }
	ret	
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _7, *p_2(D)
# kianv_stdlib.h:122:   while (*p != 0) {
	beq	a3,zero,.L80	#, _7,,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp77,
.L81:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L81	#, _4,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a3,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _7, MEM[(char *)p_6]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a3,zero,.L81	#, _7,,
.L80:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp79,
.L83:
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L83	#, _3,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	li	a5,10		# tmp81,
	sw	a5,0(a4)	# tmp81, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:131: }
	ret	
	.size	print_str_ln, .-print_str_ln
	.align	2
	.globl	print_dec
	.type	print_dec, @function
print_dec:
	addi	sp,sp,-16	#,,
# kianv_stdlib.h:135:   char *p = buffer;
	addi	a2,sp,4	#, tmp92,
	mv	a4,a2	# p, tmp92
# kianv_stdlib.h:137:     *(p++) = val % 10;
	li	a5,10		# tmp93,
.L93:
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a0,zero,.L94	#, val,,
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a4,a2,.L101	#, p, tmp92,
.L94:
# kianv_stdlib.h:137:     *(p++) = val % 10;
	remu	a3,a0,a5	# tmp93, tmp83, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	addi	a4,a4,1	#, p, p
# kianv_stdlib.h:138:     val = val / 10;
	divu	a0,a0,a5	# tmp93, val, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	sb	a3,-1(a4)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L93		#
.L101:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp88,
.L95:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L95	#, _3,,
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a4)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,-1	#, p, p
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a3)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:141:   while (p != buffer) {
	bne	a4,a2,.L95	#, p, tmp92,
# kianv_stdlib.h:146: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	print_dec, .-print_dec
	.align	2
	.globl	print_dec64
	.type	print_dec64, @function
print_dec64:
	addi	sp,sp,-32	#,,
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	t4,-858992640		# tmp258,
# kianv_stdlib.h:150:   char *p = buffer;
	addi	t3,sp,12	#, tmp254,
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	t1,268435456		# tmp255,
	addi	a7,t4,-819	#, tmp259, tmp258
# kianv_stdlib.h:148: void print_dec64(uint64_t val) {
	mv	a4,a0	# val, tmp261
	mv	a6,a1	# val, tmp262
# kianv_stdlib.h:150:   char *p = buffer;
	mv	a2,t3	# p, tmp254
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	t1,t1,-1	#, tmp256, tmp255
	li	t5,5		# tmp257,
	addi	t4,t4,-820	#, tmp260, tmp258
# kianv_stdlib.h:151:   while (val || p == buffer) {
	j	.L103		#
.L104:
# kianv_stdlib.h:152:     *(p++) = val % 10;
	remu	a5,a5,t5	# tmp257, tmp97, tmp94
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	a2,a2,1	#, p, p
# kianv_stdlib.h:152:     *(p++) = val % 10;
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
# kianv_stdlib.h:153:     val = val / 10;
	srli	a6,a1,1	#, val, tmp115
# kianv_stdlib.h:152:     *(p++) = val % 10;
	srli	a5,a5,1	#, tmp224, tmp114
	or	a5,a3,a5	# tmp224, tmp224, tmp133
	slli	a0,a5,2	#, tmp228, tmp224
	add	a0,a0,a5	# tmp224, tmp230, tmp228
	slli	a0,a0,1	#, tmp232, tmp230
	sub	a0,a4,a0	# tmp234, val, tmp232
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sb	a0,-1(a2)	# tmp234, MEM[(char *)p_18 + 4294967295B]
# kianv_stdlib.h:153:     val = val / 10;
	mv	a4,a5	# val, tmp224
.L103:
# kianv_stdlib.h:152:     *(p++) = val % 10;
	slli	a5,a6,4	#, tmp88, val
	srli	a3,a4,28	#, tmp208, val
	or	a3,a5,a3	# tmp208, tmp208, tmp88
	and	a3,a3,t1	# tmp256, tmp89, tmp208
	and	a5,a4,t1	# tmp256, tmp84, val
	add	a5,a5,a3	# tmp89, tmp92, tmp84
	srli	a1,a6,24	#, tmp210, val
# kianv_stdlib.h:151:   while (val || p == buffer) {
	or	a3,a4,a6	# val, val, val
# kianv_stdlib.h:152:     *(p++) = val % 10;
	add	a5,a5,a1	# tmp210, tmp94, tmp92
# kianv_stdlib.h:151:   while (val || p == buffer) {
	bne	a3,zero,.L104	#, val,,
# kianv_stdlib.h:151:   while (val || p == buffer) {
	beq	a2,t3,.L104	#, p, tmp254,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp202,
.L105:
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L105	#, _3,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a2,a2,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	a2,t3,.L105	#, p, tmp254,
# kianv_stdlib.h:161: }
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
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a3,a1,-1	#, tmp85, tmp98
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a3,a3,2	#, i, tmp85
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	blt	a3,zero,.L111	#, i,,
	lui	a2,%hi(.LC0)	# tmp95,
	li	a1,-4		# _8,
	addi	a2,a2,%lo(.LC0)	# tmp94, tmp95,
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp87,
.L113:
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L113	#, _2,,
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	srl	a5,a0,a3	# i, tmp90, val
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	andi	a5,a5,15	#, tmp91, tmp90
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	add	a5,a2,a5	# tmp91, tmp92, tmp94
	lbu	a5,0(a5)	# _6, "0123456789ABCDEF"[_4]
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a3,a3,-4	#, i, i
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	sw	a5,0(a4)	# _6, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bne	a1,a3,.L113	#, _8, i,
.L111:
# kianv_stdlib.h:169: }
	ret	
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
	addi	sp,sp,-32	#,,
# kianv_stdlib.h:189:   int dx =  abs(x1 - x0);
	sub	a0,a3,a1	#, x1, x0
# kianv_stdlib.h:187: {
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
# kianv_stdlib.h:187: {
	mv	s6,a4	# y1, tmp117
# kianv_stdlib.h:189:   int dx =  abs(x1 - x0);
	call	abs		#
	mv	s2,a0	# tmp119,
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	sub	a0,s6,s1	#, y1, y0
	call	abs		#
# kianv_stdlib.h:190:   int sx = x0 < x1 ? 1 : -1;
	sgt	s5,s4,s0	# tmp109, x1, x0
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	sgt	t5,s6,s1	# tmp112, y1, y0
# kianv_stdlib.h:190:   int sx = x0 < x1 ? 1 : -1;
	slli	s5,s5,1	#, iftmp.6_9, tmp109
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	slli	t5,t5,1	#, iftmp.7_10, tmp112
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a3,65536		# tmp103,
# kianv_stdlib.h:190:   int sx = x0 < x1 ? 1 : -1;
	addi	s5,s5,-1	#, iftmp.6_9, iftmp.6_9
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	neg	t4,a0	# dy, _3
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	addi	t5,t5,-1	#, iftmp.7_10, iftmp.7_10
	sub	a6,s2,a0	# err, dx, _3
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	t1,s3,16	#, _33, color
	andi	a7,s1,255	#, tmp106, y0
	slli	a1,s0,8	#, tmp107, x0
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	addi	a3,a3,-1	#, tmp102, tmp103
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	t3,805306368		# tmp105,
.L122:
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a7,t1	# _33, tmp99, tmp106
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	and	a2,a1,a3	# tmp102, tmp101, tmp107
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a5,a2	# tmp101, _40, tmp99
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a5,8(t3)	# _40, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:198:     e2 = 2*err;
	slli	a5,a6,1	#, e2, err
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s4,.L130	#, x0, x1,
.L123:
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t4,a5,.L125	#, dy, e2,
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s0,s0,s5	# iftmp.6_9, x0, x0
	sub	a6,a6,a0	# err, err, _3
	slli	a1,s0,8	#, tmp107, x0
.L125:
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a5,.L122	#, dx, e2,
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s1,s1,t5	# iftmp.7_10, y0, y0
	andi	a7,s1,255	#, tmp106, y0
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a7,t1	# _33, tmp99, tmp106
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	and	a2,a1,a3	# tmp102, tmp101, tmp107
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a5,a5,a2	# tmp101, _40, tmp99
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a6,a6,s2	# dx, err, err
# kianv_stdlib.h:183: *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a5,8(t3)	# _40, MEM[(volatile uint32_t *)805306376B]
# kianv_stdlib.h:198:     e2 = 2*err;
	slli	a5,a6,1	#, e2, err
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s4,.L123	#, x0, x1,
.L130:
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s6,.L123	#, y0, y1,
# kianv_stdlib.h:202: }
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
	addi	sp,sp,-80	#,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	lbu	t1,0(a0)	# _14, *format_22(D)
# stdlib.c:90: {
	sw	a5,68(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	addi	a5,sp,52	#, tmp118,
# stdlib.c:90: {
	sw	a1,52(sp)	#,
	sw	a2,56(sp)	#,
	sw	a3,60(sp)	#,
	sw	a4,64(sp)	#,
	sw	a6,72(sp)	#,
	sw	a7,76(sp)	#,
# stdlib.c:94: 	va_start(ap, format);
	sw	a5,12(sp)	# tmp118, MEM[(void * *)&ap]
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	beq	t1,zero,.L134	#, _14,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	li	a3,0		# i,
# stdlib.c:97: 		if (format[i] == '%') {
	li	t0,37		# tmp119,
# stdlib.c:99: 				if (format[i] == 'c') {
	li	a7,99		# tmp186,
# stdlib.c:103: 				if (format[i] == 's') {
	li	t3,115		# tmp187,
# stdlib.c:107: 				if (format[i] == 'd') {
	li	t4,100		# tmp188,
# stdlib.c:111: 				if (format[i] == 'u') {
	li	t5,117		# tmp189,
# stdlib.c:78: 	char *p = buffer;
	addi	t6,sp,16	#, tmp194,
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	li	a1,10		# tmp195,
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp196,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	li	t2,45		# tmp198,
.L155:
# stdlib.c:97: 		if (format[i] == '%') {
	beq	t1,t0,.L135	#, _14, tmp119,
.L136:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _41, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L136	#, _41,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	t1,0(a5)	# _14, MEM[(volatile uint32_t *)805306368B]
.L139:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	a3,a3,1	#, i, i
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a4,a0,a3	# i, tmp177, format
	lbu	t1,0(a4)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	t1,zero,.L155	#, _14,,
.L134:
# stdlib.c:121: }
	li	a0,0		#,
	addi	sp,sp,80	#,,
	jr	ra		#
.L154:
# stdlib.c:99: 				if (format[i] == 'c') {
	beq	a4,a7,.L181	#, _10, tmp186,
# stdlib.c:103: 				if (format[i] == 's') {
	beq	a4,t3,.L182	#, _10, tmp187,
# stdlib.c:107: 				if (format[i] == 'd') {
	beq	a4,t4,.L183	#, _10, tmp188,
# stdlib.c:111: 				if (format[i] == 'u') {
	beq	a4,t5,.L184	#, _10, tmp189,
.L135:
# stdlib.c:98: 			while (format[++i]) {
	addi	a3,a3,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a4,a0,a3	# i, tmp174, format
	lbu	a4,0(a4)	# _10, MEM[(const char *)_125]
# stdlib.c:98: 			while (format[++i]) {
	bne	a4,zero,.L154	#, _10,,
	j	.L139		#
.L181:
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a4,12(sp)		# D.3839, ap
	lw	a2,0(a4)		# _4, MEM[(int *)_109]
	addi	a4,a4,4	#, D.3840, D.3839
	sw	a4,12(sp)	# D.3840, ap
.L138:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _33, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L138	#, _33,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	andi	a4,a2,255	#, _35, _4
	sw	a4,0(a5)	# _35, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:50: }
	j	.L139		#
.L182:
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a4,12(sp)		# D.3841, ap
	lw	a6,0(a4)		# p, MEM[(char * *)_78]
	addi	a4,a4,4	#, D.3842, D.3841
	sw	a4,12(sp)	# D.3842, ap
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _39,* p
	beq	a2,zero,.L139	#, _39,,
.L142:
# stdlib.c:56:     print_chr(*(p++));
	addi	a6,a6,1	#, p, p
.L141:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _38, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L141	#, _38,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a2,0(a5)	# _39, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _39,* p
	bne	a2,zero,.L142	#, _39,,
	j	.L139		#
.L183:
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a2,12(sp)		# D.3843, ap
	lw	a4,0(a2)		# val, MEM[(int *)_110]
	addi	a2,a2,4	#, D.3844, D.3843
	sw	a2,12(sp)	# D.3844, ap
# stdlib.c:63: 	if (val < 0) {
	blt	a4,zero,.L145	#, val,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp194
.L146:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	a4,zero,.L147	#, val,,
	bne	a2,t6,.L149	#, p, tmp194,
.L147:
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	rem	a6,a4,a1	# tmp195, tmp138, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	a2,a2,1	#, p, p
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	addi	a6,a6,48	#, tmp140, tmp138
# stdlib.c:69: 		val = val / 10;
	div	a4,a4,a1	# tmp195, val, val
# stdlib.c:68: 		*(p++) = '0' + val % 10;
	sb	a6,-1(a2)	# tmp140, MEM[(char *)p_53 + 4294967295B]
	j	.L146		#
.L145:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a2,0(a5)		# _47, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a2,zero,.L145	#, _47,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	t2,0(a5)	# tmp198, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:65: 		val = -val;
	neg	a4,a4	# val, val
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp194
	j	.L146		#
.L185:
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a6,0(a5)	# _58, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:71: 	while (p != buffer)
	beq	a2,t6,.L139	#, p, tmp194,
.L149:
# stdlib.c:72: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _58, MEM[(char *)p_57]
# stdlib.c:72: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L148:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _59, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L148	#, _59,,
	j	.L185		#
.L184:
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a6,12(sp)		# D.3845, ap
# stdlib.c:78: 	char *p = buffer;
	mv	a2,t6	# p, tmp194
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a4,0(a6)		# MEM[(int *)_113], MEM[(int *)_113]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a6,a6,4	#, D.3846, D.3845
	sw	a6,12(sp)	# D.3846, ap
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a6,a4,31	#, tmp153, MEM[(int *)_113]
	xor	a4,a6,a4	# MEM[(int *)_113], val, tmp153
	sub	a4,a4,a6	# val, val, tmp153
.L150:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a4,zero,.L151	#, val,,
	bne	a2,t6,.L153	#, p, tmp194,
.L151:
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	rem	a6,a4,a1	# tmp195, tmp161, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	a2,a2,1	#, p, p
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	addi	a6,a6,48	#, tmp163, tmp161
# stdlib.c:83: 		val = val / 10;
	div	a4,a4,a1	# tmp195, val, val
# stdlib.c:82: 		*(p++) = '0' + val % 10;
	sb	a6,-1(a2)	# tmp163, MEM[(char *)p_68 + 4294967295B]
	j	.L150		#
.L186:
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a6,0(a5)	# _73, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:85: 	while (p != buffer)
	beq	a2,t6,.L139	#, p, tmp194,
.L153:
# stdlib.c:86: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _73, MEM[(char *)p_72]
# stdlib.c:86: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L152:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _74, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L152	#, _74,,
	j	.L186		#
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
	ble	a5,a3,.L187	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L187:
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
	beq	a2,zero,.L190	#, n,,
	addi	a4,a1,1	#, bb, bb
	sub	a5,a0,a4	# tmp111, aa, bb
	sltiu	a5,a5,3	#, tmp114, tmp111
	sltiu	a3,a7,7	#, tmp117, n
	xori	a5,a5,1	#, tmp113, tmp114
	xori	a3,a3,1	#, tmp116, tmp117
	and	a5,a5,a3	# tmp116, tmp120, tmp113
	beq	a5,zero,.L191	#, tmp120,,
	or	a5,a0,a1	# bb, tmp121, aa
	andi	a5,a5,3	#, tmp122, tmp121
	bne	a5,zero,.L191	#, tmp122,,
	andi	a6,a2,-4	#, tmp127, n
	mv	a5,a1	# ivtmp.1024, bb
	mv	a4,a0	# ivtmp.1027, aa
	add	a6,a6,a1	# bb, _77, tmp127
.L192:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lw	a3,0(a5)		# vect__1.1010, MEM <const vector(4) char> [(const char *)_43]
	addi	a5,a5,4	#, ivtmp.1024, ivtmp.1024
	addi	a4,a4,4	#, ivtmp.1027, ivtmp.1027
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sw	a3,-4(a4)	# vect__1.1010, MEM <vector(4) char> [(char *)_45]
	bne	a5,a6,.L192	#, ivtmp.1024, _77,
	andi	a5,a2,-4	#, niters_vector_mult_vf.1004, n
	add	a4,a0,a5	# niters_vector_mult_vf.1004, tmp.1005, aa
	add	a1,a1,a5	# niters_vector_mult_vf.1004, tmp.1006, bb
	sub	a7,a7,a5	# tmp.1007, n, niters_vector_mult_vf.1004
	beq	a2,a5,.L190	#, n, niters_vector_mult_vf.1004,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,0(a1)	# _10, *tmp.1006_55
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,0(a4)	# _10, *tmp.1005_54
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,zero,.L190	#, tmp.1007,,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,1(a1)	# _72, MEM[(const char *)tmp.1006_55 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,1		# tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,1(a4)	# _72, MEM[(char *)tmp.1005_54 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,a5,.L190	#, tmp.1007, tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,2(a1)	# _48, MEM[(const char *)tmp.1006_55 + 2B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,2(a4)	# _48, MEM[(char *)tmp.1005_54 + 2B]
	ret	
.L191:
	add	a2,a0,a2	# n, _23, aa
# stdlib.c:138: 	char *a = (char *) aa;
	mv	a5,a0	# a, aa
.L194:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,-1(a4)	# _37, MEM[(const char *)b_35 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	addi	a5,a5,1	#, a, a
	addi	a4,a4,1	#, bb, bb
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,-1(a5)	# _37, MEM[(char *)a_36 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a2,a5,.L194	#, _23, a,
.L190:
# stdlib.c:142: }
	ret	
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
	j	.L211		#
.L213:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	beq	a4,zero,.L215	#, c,,
.L211:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp101, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp102, tmp101
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L213	#, tmp102,,
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
	bne	a4,zero,.L216	#, tmp108,,
.L214:
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
	beq	a4,zero,.L214	#, tmp120,,
.L216:
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a3,0(a5)	# v, *dst_50
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a4,a3,255	#, tmp111, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L215	#, tmp111,,
# stdlib.c:164: 			v = v >> 8;
	srli	a4,a3,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a4,1(a5)	# v, MEM[(char *)dst_50 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp112, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L215	#, tmp112,,
# stdlib.c:169: 			v = v >> 8;
	srli	a4,a3,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a4,2(a5)	# v, MEM[(char *)dst_50 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp113, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	bne	a4,zero,.L231	#, tmp113,,
.L215:
# stdlib.c:184: }
	ret	
.L231:
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
	j	.L233		#
.L237:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	bne	a5,a4,.L262	#, c1, c2,
# stdlib.c:195: 		else if (!c1)
	beq	a5,zero,.L252	#, c1,,
.L233:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L237	#, tmp102,,
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_14]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_16]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L242	#, v1, v2,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp111,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-2139062272		# tmp116,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp110, tmp111
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,128	#, tmp115, tmp116
	j	.L238		#
.L263:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_29]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_30]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L242	#, v1, v2,
.L238:
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
	beq	a5,zero,.L263	#, tmp114,,
.L252:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
.L232:
# stdlib.c:234: }
	ret	
.L262:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	sltu	a0,a5,a4	# c2, tmp119, c1
	neg	a0,a0	# tmp120, tmp119
	ori	a0,a0,1	#, <retval>, tmp120
	ret	
.L242:
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L260	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L232	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L260	#, c1, c2,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L232	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L260	#, c1, c2,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L232	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L232	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a5,a4,.L232	#, c1, c2,
	j	.L258		#
.L260:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L232	#, c1, c2,
.L258:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
	.size	strcmp, .-strcmp
	.align	2
	.globl	make_Light
	.type	make_Light, @function
make_Light:
# main_raytrace_termio.c:67:   L.position = position;
	lw	a3,4(a1)		# L$position$y, position.y
	lw	a4,8(a1)		# L$position$z, position.z
# main_raytrace_termio.c:69:   return L;
	lw	a1,0(a1)		# position.x, position.x
	sw	a3,4(a0)	# L$position$y, <retval>.position.y
	sw	a4,8(a0)	# L$position$z, <retval>.position.z
	sw	a1,0(a0)	# position.x, <retval>.position.x
	sw	a2,12(a0)	# tmp81, <retval>.intensity
# main_raytrace_termio.c:70: }
	ret	
	.size	make_Light, .-make_Light
	.align	2
	.globl	make_Material
	.type	make_Material, @function
make_Material:
# main_raytrace_termio.c:84:   M.albedo = a;
	lw	t4,0(a2)		# a, a
	lw	t3,4(a2)		# a, a
	lw	t1,8(a2)		# a, a
	lw	a7,12(a2)		# a, a
# main_raytrace_termio.c:85:   M.diffuse_color = color;
	lw	a6,0(a3)		# color, color
	lw	a2,4(a3)		# color, color
	lw	a3,8(a3)		# color, color
# main_raytrace_termio.c:84:   M.albedo = a;
	sw	t4,4(a0)	# a, <retval>.albedo
	sw	t3,8(a0)	# a, <retval>.albedo
	sw	t1,12(a0)	# a, <retval>.albedo
	sw	a7,16(a0)	# a, <retval>.albedo
# main_raytrace_termio.c:85:   M.diffuse_color = color;
	sw	a6,20(a0)	# color, <retval>.diffuse_color
	sw	a2,24(a0)	# color, <retval>.diffuse_color
	sw	a3,28(a0)	# color, <retval>.diffuse_color
# main_raytrace_termio.c:87:   return M;
	sw	a1,0(a0)	# tmp85, <retval>.refractive_index
	sw	a4,32(a0)	# tmp88, <retval>.specular_exponent
# main_raytrace_termio.c:88: }
	ret	
	.size	make_Material, .-make_Material
	.align	2
	.globl	make_Material_default
	.type	make_Material_default, @function
make_Material_default:
# main_raytrace_termio.c:96:   return M;
	lui	a5,%hi(.LC1)	# tmp73,
	lw	a4,%lo(.LC1)(a5)		# tmp74,
	sw	a4,0(a0)	# tmp74, <retval>.refractive_index
	sw	a4,4(a0)	# tmp74, <retval>.albedo.x
	mv	a4,zero	# tmp79,
	sw	a4,8(a0)	# tmp79, <retval>.albedo.y
	sw	a4,12(a0)	# tmp80, <retval>.albedo.z
	sw	a4,16(a0)	# tmp81, <retval>.albedo.w
	sw	a4,20(a0)	# tmp82, <retval>.diffuse_color.x
	sw	a4,24(a0)	# tmp83, <retval>.diffuse_color.y
	sw	a4,28(a0)	# tmp84, <retval>.diffuse_color.z
	sw	a4,32(a0)	# tmp85, <retval>.specular_exponent
# main_raytrace_termio.c:97: }
	ret	
	.size	make_Material_default, .-make_Material_default
	.align	2
	.globl	make_Sphere
	.type	make_Sphere, @function
make_Sphere:
	addi	sp,sp,-16	#,,
	sw	s0,12(sp)	#,
# main_raytrace_termio.c:109:   S.center = c;
	lw	s0,0(a1)		# c, c
	lw	t2,4(a1)		# c, c
	lw	t0,8(a1)		# c, c
# main_raytrace_termio.c:111:   S.material = M;
	lw	t6,0(a3)		# M, M
	lw	t5,4(a3)		# M, M
	lw	t4,8(a3)		# M, M
	lw	t3,12(a3)		# M, M
	lw	t1,16(a3)		# M, M
	lw	a7,20(a3)		# M, M
	lw	a6,24(a3)		# M, M
	lw	a1,28(a3)		# M, M
	lw	a4,32(a3)		# M, M
# main_raytrace_termio.c:109:   S.center = c;
	sw	s0,0(a0)	# c, <retval>.center
# main_raytrace_termio.c:113: }
	lw	s0,12(sp)		#,
# main_raytrace_termio.c:109:   S.center = c;
	sw	t2,4(a0)	# c, <retval>.center
	sw	t0,8(a0)	# c, <retval>.center
# main_raytrace_termio.c:111:   S.material = M;
	sw	t6,16(a0)	# M, <retval>.material
	sw	t5,20(a0)	# M, <retval>.material
	sw	t4,24(a0)	# M, <retval>.material
	sw	t3,28(a0)	# M, <retval>.material
	sw	t1,32(a0)	# M, <retval>.material
	sw	a7,36(a0)	# M, <retval>.material
	sw	a6,40(a0)	# M, <retval>.material
	sw	a1,44(a0)	# M, <retval>.material
	sw	a4,48(a0)	# M, <retval>.material
# main_raytrace_termio.c:112:   return S;
	sw	a2,12(a0)	# tmp90, <retval>.radius
# main_raytrace_termio.c:113: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	make_Sphere, .-make_Sphere
	.globl	__subsf3
	.globl	__mulsf3
	.globl	__addsf3
	.globl	__gtsf2
	.globl	__ltsf2
	.align	2
	.globl	Sphere_ray_intersect
	.type	Sphere_ray_intersect, @function
Sphere_ray_intersect:
	addi	sp,sp,-32	#,,
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	mv	s0,a0	# S, tmp134
	mv	s2,a1	# tmp105, tmp135
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(a0)		#, S_11(D)->center.x
	lw	a1,0(a1)		#, orig.x
# main_raytrace_termio.c:115: BOOL Sphere_ray_intersect(Sphere* S, vec3 orig, vec3 dir, float* t0) {
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
	sw	s3,12(sp)	#,
	mv	s1,a2	# tmp106, tmp136
	sw	s4,8(sp)	#,
	sw	s5,4(sp)	#,
	sw	s6,0(sp)	#,
# main_raytrace_termio.c:115: BOOL Sphere_ray_intersect(Sphere* S, vec3 orig, vec3 dir, float* t0) {
	mv	s5,a3	# t0, tmp137
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	call	__subsf3		#
	mv	s4,a0	# tmp138,
	lw	a1,4(s2)		#, orig.y
	lw	a0,4(s0)		#, S_11(D)->center.y
	call	__subsf3		#
	mv	s3,a0	# tmp139,
	lw	a1,8(s2)		#, orig.z
	lw	a0,8(s0)		#, S_11(D)->center.z
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,0(s1)		#, dir.x
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	s2,a0	# tmp140,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp108
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,4(s1)		#, dir.y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s6,a0	# tmp111, tmp141
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, tmp109
	call	__mulsf3		#
	mv	a1,a0	# tmp142,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s6	#, tmp111
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,8(s1)		#, dir.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# tmp113, tmp143
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp110
	call	__mulsf3		#
	mv	a1,a0	# tmp144,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp113
	call	__addsf3		#
	mv	s1,a0	# tmp145,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s4	#, tmp108
	mv	a0,s4	#, tmp11
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s3	#, tmp109
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s4,a0	# tmp116, tmp146
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp147,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp116
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s2	#, tmp110
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s3,a0	# tmp118, tmp148
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp149,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, tmp118
	call	__addsf3		#
	mv	s2,a0	# tmp120, tmp150
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a1,s1	#, tmp115
	mv	a0,s1	#, tmp115
	call	__mulsf3		#
	mv	a1,a0	# tmp151,
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a0,s2	#, tmp120
	call	__subsf3		#
# main_raytrace_termio.c:119:   float r2 = S->radius*S->radius;
	lw	a1,12(s0)		# _3, S_11(D)->radius
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	s2,a0	# tmp122, tmp152
# main_raytrace_termio.c:119:   float r2 = S->radius*S->radius;
	mv	a0,a1	#,
	call	__mulsf3		#
	mv	s0,a0	# tmp123, tmp153
# main_raytrace_termio.c:120:   if (d2 > r2) return 0;
	mv	a1,a0	#, tmp123
	mv	a0,s2	#, tmp122
	call	__gtsf2		#
	ble	a0,zero,.L277	#, tmp154,,
# main_raytrace_termio.c:120:   if (d2 > r2) return 0;
	li	a0,0		# <retval>,
.L269:
# main_raytrace_termio.c:127: }
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
.L277:
# main_raytrace_termio.c:121:   float thc = sqrtf(r2 - d2);
	mv	a1,s2	#, tmp122
	mv	a0,s0	#, tmp123
	call	__subsf3		#
	call	sqrtf		#
# main_raytrace_termio.c:122:   *t0       = tca - thc;
	mv	a1,a0	#, thc
# main_raytrace_termio.c:121:   float thc = sqrtf(r2 - d2);
	mv	s2,a0	# thc, tmp155
# main_raytrace_termio.c:122:   *t0       = tca - thc;
	mv	a0,s1	#, tmp115
	call	__subsf3		#
# main_raytrace_termio.c:124:   if (*t0 < 0) *t0 = t1;
	mv	a1,zero	#,
# main_raytrace_termio.c:122:   *t0       = tca - thc;
	mv	s0,a0	# t1, tmp156
# main_raytrace_termio.c:124:   if (*t0 < 0) *t0 = t1;
	call	__ltsf2		#
	bge	a0,zero,.L271	#, tmp157,,
# main_raytrace_termio.c:123:   float t1 = tca + thc;
	mv	a1,s1	#, tmp115
	mv	a0,s2	#, thc
	call	__addsf3		#
	mv	s0,a0	# t1, tmp158
.L271:
	sw	s0,0(s5)	# t1, MEM <float> [(void *)t0_17(D)]
# main_raytrace_termio.c:125:   if (*t0 < 0) return 0;
	mv	a1,zero	#,
	mv	a0,s0	#, t1
	call	__ltsf2		#
	srli	a0,a0,31	#, tmp129, tmp159
	xori	a0,a0,1	#, tmp131, tmp129
# main_raytrace_termio.c:120:   if (d2 > r2) return 0;
	andi	a0,a0,0xff	# <retval>, tmp131
	j	.L269		#
	.size	Sphere_ray_intersect, .-Sphere_ray_intersect
	.align	2
	.globl	reflect
	.type	reflect, @function
reflect:
	addi	sp,sp,-48	#,,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	lw	s6,0(a1)		# U$x, I.x
	lw	s7,0(a2)		# V$x, N.x
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	lw	s4,4(a1)		# U$y, I.y
	lw	s5,4(a2)		# V$y, N.y
	mv	a5,a1	# tmp91, tmp106
	sw	s0,40(sp)	#,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s6	#, U$x
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s0,a0	# tmp105, .result_ptr
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s7	#, V$x
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	lw	s2,8(a5)		# U$z, I.z
	lw	s3,8(a2)		# V$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s1,a0	# tmp93, tmp108
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, V$y
	mv	a0,s4	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp109,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp93
	call	__addsf3		#
	mv	s1,a0	# tmp95, tmp110
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s3	#, V$z
	mv	a0,s2	#, U$z
	call	__mulsf3		#
	mv	a1,a0	# tmp111,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp95
	call	__addsf3		#
	mv	a1,a0	# tmp112,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s7	#, V$x
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s1,a0	# tmp98, tmp113
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a1,a0	# tmp114,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s6	#, U$x
	call	__subsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,0(s0)	# tmp115, <retval>.x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, V$y
	mv	a0,s1	#, tmp98
	call	__mulsf3		#
	mv	a1,a0	# tmp116,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s4	#, U$y
	call	__subsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,4(s0)	# tmp117, <retval>.y
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s3	#, V$z
	mv	a0,s1	#, tmp98
	call	__mulsf3		#
	mv	a1,a0	# tmp118,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s2	#, U$z
	call	__subsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,8(s0)	# tmp119, <retval>.z
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
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
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	reflect, .-reflect
	.globl	__divsf3
	.align	2
	.globl	refract
	.type	refract, @function
refract:
	addi	sp,sp,-128	#,,
	sw	s6,96(sp)	#,
	sw	s11,76(sp)	#,
	lw	s6,0(a2)		# V$x, N.x
	lw	s11,0(a1)		# U$x, I.x
	sw	s5,100(sp)	#,
	sw	s10,80(sp)	#,
	lw	s5,4(a2)		# V$y, N.y
	lw	s10,4(a1)		# U$y, I.y
	sw	s0,120(sp)	#,
	sw	s1,116(sp)	#,
	mv	s0,a1	# tmp106, tmp162
	mv	s1,a0	# tmp161, .result_ptr
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s11	#, U$x
	mv	a0,s6	#, V$x
# main_raytrace_termio.c:131: vec3 refract(vec3 I, vec3 N, float eta_t, float eta_i /* =1.f */) { // Snell's law
	sw	ra,124(sp)	#,
	sw	a4,4(sp)	# tmp165, %sfp
	sw	s2,112(sp)	#,
	sw	s3,108(sp)	#,
	sw	s4,104(sp)	#,
	mv	s3,a3	# eta_t, tmp164
	sw	s7,92(sp)	#,
	sw	s8,88(sp)	#,
	sw	s9,84(sp)	#,
	lw	s8,8(a2)		# V$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s4,a0	# tmp111, tmp166
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, V$y
	mv	a0,s10	#, U$y
	call	__mulsf3		#
	lw	s9,8(s0)		# U$z, I.z
	mv	a1,a0	# tmp167,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp111
	call	__addsf3		#
	mv	s4,a0	# tmp113, tmp168
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s9	#, U$z
	mv	a0,s8	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp169,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp113
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	s4,%hi(.LC1)	# tmp160,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__addsf3		#
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s7,%lo(.LC1)(s4)		# tmp116,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s2,a0	# tmp115, tmp170
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s7	#, tmp116
	call	__gtsf2		#
	ble	a0,zero,.L290	#, tmp171,,
.L281:
# main_raytrace_termio.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	lw	t1,0(s0)		# I, I
	lw	a7,4(s0)		# I, I
	lw	a6,8(s0)		# I, I
	lw	a3,4(sp)		#, %sfp
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	li	a5,-2147483648		# tmp127,
	xor	s6,a5,s6	# V$x, tmp128, tmp127
	xor	s5,a5,s5	# V$y, tmp130, tmp127
# main_raytrace_termio.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	mv	a4,s3	#, eta_t
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	a5,a5,s8	# V$z, tmp132, tmp127
# main_raytrace_termio.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	addi	a2,sp,16	#,,
	addi	a1,sp,32	#,,
	mv	a0,s1	#, .result_ptr
	sw	t1,32(sp)	# I,
	sw	a7,36(sp)	# I,
	sw	a6,40(sp)	# I,
	sw	s6,16(sp)	# tmp128,
	sw	s5,20(sp)	# tmp130,
	sw	a5,24(sp)	# tmp132,
	call	refract		#
.L280:
# main_raytrace_termio.c:138: }
	lw	ra,124(sp)		#,
	lw	s0,120(sp)		#,
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
	mv	a0,s1	#, .result_ptr
	lw	s1,116(sp)		#,
	addi	sp,sp,128	#,,
	jr	ra		#
.L290:
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lui	a5,%hi(.LC2)	# tmp120,
	lw	a1,%lo(.LC2)(a5)		#,
	mv	a0,s2	#, tmp115
	mv	a5,zero	# _63,
	sw	a5,8(sp)	# _63, %sfp
	call	__ltsf2		#
# main_raytrace_termio.c:132:   float cosi = -max(-1.f, min(1.f, vec3_dot(I,N)));
	sw	s7,12(sp)	# tmp116, %sfp
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	bge	a0,zero,.L291	#, tmp172,,
.L282:
# main_raytrace_termio.c:134:   float eta = eta_i / eta_t;
	lw	a0,4(sp)		#, %sfp
	mv	a1,s3	#, eta_t
	call	__divsf3		#
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a1,a0	#, tmp141
# main_raytrace_termio.c:134:   float eta = eta_i / eta_t;
	mv	s0,a0	# tmp141, tmp176
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	call	__mulsf3		#
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	lw	a1,8(sp)		#, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp177,
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	lw	a0,%lo(.LC1)(s4)		#,
	call	__subsf3		#
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a1,zero	#,
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	s2,a0	# tmp145, tmp178
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	call	__ltsf2		#
	bge	a0,zero,.L288	#, tmp179,,
# main_raytrace_termio.c:41:   return V;
	lw	a5,%lo(.LC1)(s4)		# tmp148,
	mv	a4,zero	# tmp192,
	sw	a4,4(s1)	# tmp192, <retval>.y
	sw	a4,8(s1)	# tmp193, <retval>.z
	sw	a5,0(s1)	# tmp148, <retval>.x
	j	.L280		#
.L288:
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s11	#, U$x
	mv	a0,s0	#, tmp141
	call	__mulsf3		#
	mv	a1,s0	#, tmp141
	mv	s7,a0	# tmp180,
	mv	a0,s10	#, U$y
	call	__mulsf3		#
	mv	s4,a0	# tmp181,
	mv	a1,s9	#, U$z
	mv	a0,s0	#, tmp141
	call	__mulsf3		#
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	lw	a1,12(sp)		#, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	s3,a0	# tmp182,
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a0,s0	#, tmp141
	call	__mulsf3		#
	mv	s0,a0	# tmp152, tmp183
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a0,s2	#, tmp145
	call	sqrtf		#
	mv	a1,a0	# tmp184,
# main_raytrace_termio.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a0,s0	#, tmp152
	call	__subsf3		#
	mv	s0,a0	# tmp153, tmp185
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp153
	mv	a0,s6	#, V$x
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s7	#, tmp149
	call	__addsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,0(s1)	# tmp186, <retval>.x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, V$y
	mv	a0,s0	#, tmp153
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s4	#, tmp150
	call	__addsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,4(s1)	# tmp187, <retval>.y
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s0	#, tmp153
	mv	a0,s8	#, V$z
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s3	#, tmp151
	call	__addsf3		#
# main_raytrace_termio.c:41:   return V;
	sw	a0,8(s1)	# tmp188, <retval>.z
	j	.L280		#
.L291:
# main_raytrace_termio.c:132:   float cosi = -max(-1.f, min(1.f, vec3_dot(I,N)));
	li	a5,-2147483648		# tmp122,
	xor	a5,a5,s2	# tmp115, tmp191, tmp122
# main_raytrace_termio.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	mv	a1,zero	#,
	mv	a0,s2	#, tmp115
# main_raytrace_termio.c:132:   float cosi = -max(-1.f, min(1.f, vec3_dot(I,N)));
	sw	a5,12(sp)	# tmp191, %sfp
# main_raytrace_termio.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	call	__gtsf2		#
	bgt	a0,zero,.L281	#, tmp173,,
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a1,s2	#, tmp115
	mv	a0,s2	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp174,
# main_raytrace_termio.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a0,s7	#, tmp116
	call	__subsf3		#
	sw	a0,8(sp)	# tmp175, %sfp
	j	.L282		#
	.size	refract, .-refract
	.globl	__extendsfdf2
	.globl	__gtdf2
	.globl	__ltdf2
	.globl	__muldf3
	.globl	__adddf3
	.globl	__fixdfsi
	.align	2
	.globl	scene_intersect
	.type	scene_intersect, @function
scene_intersect:
	addi	sp,sp,-112	#,,
	sw	a5,36(sp)	# tmp281, %sfp
# main_raytrace_termio.c:142:   float spheres_dist = 1e30;
	lui	a5,%hi(.LC3)	# tmp273,
	sw	a5,44(sp)	# tmp273, %sfp
	lw	a5,%lo(.LC3)(a5)		# spheres_dist,
# main_raytrace_termio.c:141: BOOL scene_intersect(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, vec3* hit, vec3* N, Material* material) {
	sw	s5,84(sp)	#,
	sw	s6,80(sp)	#,
	sw	s7,76(sp)	#,
	sw	s8,72(sp)	#,
	sw	s9,68(sp)	#,
	sw	s10,64(sp)	#,
	sw	ra,108(sp)	#,
	sw	s0,104(sp)	#,
	sw	s1,100(sp)	#,
	sw	s2,96(sp)	#,
	sw	s3,92(sp)	#,
	sw	s4,88(sp)	#,
	sw	s11,60(sp)	#,
# main_raytrace_termio.c:141: BOOL scene_intersect(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, vec3* hit, vec3* N, Material* material) {
	sw	a3,12(sp)	# nb_spheres, %sfp
	sw	a4,32(sp)	# tmp280, %sfp
	sw	a6,28(sp)	# tmp282, %sfp
# main_raytrace_termio.c:142:   float spheres_dist = 1e30;
	sw	a5,16(sp)	# spheres_dist, %sfp
	lw	s7,0(a0)		# orig$x, orig.x
	lw	s6,4(a0)		# orig$y, orig.y
	lw	s9,8(a0)		# orig$z, orig.z
	lw	s8,0(a1)		# dir$x, dir.x
	lw	s5,4(a1)		# dir$y, dir.y
	lw	s10,8(a1)		# dir$z, dir.z
# main_raytrace_termio.c:143:   for(int i=0; i<nb_spheres; ++i) {
	ble	a3,zero,.L293	#, nb_spheres,,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lui	a5,%hi(.LC1)	# tmp274,
	lw	a5,%lo(.LC1)(a5)		# tmp275,
	mv	s0,a2	# ivtmp.1102, spheres
# main_raytrace_termio.c:143:   for(int i=0; i<nb_spheres; ++i) {
	li	s3,0		# i,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	sw	a5,40(sp)	# tmp275, %sfp
.L302:
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_205]
	mv	a1,s7	#, orig$x
	call	__subsf3		#
	mv	s1,a0	# tmp283,
	lw	a0,4(s0)		#, MEM[(float *)_205 + 4B]
	mv	a1,s6	#, orig$y
	call	__subsf3		#
	mv	s4,a0	# tmp284,
	lw	a0,8(s0)		#, MEM[(float *)_205 + 8B]
	mv	a1,s9	#, orig$z
	call	__subsf3		#
	mv	s2,a0	# tmp285,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s8	#, dir$x
	mv	a0,s1	#, tmp163
	call	__mulsf3		#
	mv	s11,a0	# tmp166, tmp286
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, dir$y
	mv	a0,s4	#, tmp164
	call	__mulsf3		#
	mv	a1,a0	# tmp287,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s11	#, tmp166
	call	__addsf3		#
	mv	s11,a0	# tmp168, tmp288
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s10	#, dir$z
	mv	a0,s2	#, tmp165
	call	__mulsf3		#
	mv	a1,a0	# tmp289,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s11	#, tmp168
	call	__addsf3		#
	mv	a4,a0	# tmp290,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s1	#, tmp163
	mv	a0,s1	#, tmp11
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a4	# tmp170, tmp290
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s11,a0	# tmp171, tmp291
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s4	#, tmp164
	mv	a0,s4	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp292,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s11	#, tmp171
	call	__addsf3		#
	mv	s11,a0	# tmp173, tmp293
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s2	#, tmp165
	mv	a0,s2	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp294,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s11	#, tmp173
	call	__addsf3		#
	mv	s2,a0	# tmp175, tmp295
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a1,s1	#, tmp170
	mv	a0,s1	#, tmp170
	call	__mulsf3		#
	mv	a1,a0	# tmp296,
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a0,s2	#, tmp175
	call	__subsf3		#
# main_raytrace_termio.c:119:   float r2 = S->radius*S->radius;
	lw	a1,12(s0)		#, MEM[(float *)_205 + 12B]
# main_raytrace_termio.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	s2,a0	# tmp177, tmp297
# main_raytrace_termio.c:119:   float r2 = S->radius*S->radius;
	mv	a0,a1	#,
	call	__mulsf3		#
	mv	s11,a0	# tmp178, tmp298
# main_raytrace_termio.c:120:   if (d2 > r2) return 0;
	mv	a1,a0	#, tmp178
	mv	a0,s2	#, tmp177
	call	__gtsf2		#
	bgt	a0,zero,.L296	#, tmp299,,
# main_raytrace_termio.c:121:   float thc = sqrtf(r2 - d2);
	mv	a1,s2	#, tmp177
	mv	a0,s11	#, tmp178
	call	__subsf3		#
	call	sqrtf		#
# main_raytrace_termio.c:122:   *t0       = tca - thc;
	mv	a1,a0	#, thc
	sw	a0,20(sp)	# thc, %sfp
	mv	a0,s1	#, tmp170
	call	__subsf3		#
# main_raytrace_termio.c:124:   if (*t0 < 0) *t0 = t1;
	mv	a1,zero	#,
# main_raytrace_termio.c:122:   *t0       = tca - thc;
	mv	s2,a0	# dist_i, tmp301
# main_raytrace_termio.c:124:   if (*t0 < 0) *t0 = t1;
	call	__ltsf2		#
	bge	a0,zero,.L297	#, tmp302,,
# main_raytrace_termio.c:123:   float t1 = tca + thc;
	lw	a5,20(sp)		# thc, %sfp
	mv	a0,s1	#, tmp170
	mv	a1,a5	#, thc
	call	__addsf3		#
	mv	s2,a0	# dist_i, tmp303
.L297:
# main_raytrace_termio.c:125:   if (*t0 < 0) return 0;
	mv	a1,zero	#,
	mv	a0,s2	#, dist_i
	call	__ltsf2		#
	blt	a0,zero,.L296	#, tmp304,,
# main_raytrace_termio.c:145:     if(Sphere_ray_intersect(&spheres[i], orig, dir, &dist_i) && (dist_i < spheres_dist)) {
	lw	a0,16(sp)		#, %sfp
	mv	a1,s2	#, dist_i
	call	__gtsf2		#
	ble	a0,zero,.L296	#, tmp305,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s8	#, dir$x
	mv	a0,s2	#, dist_i
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s7	#, orig$x
	call	__addsf3		#
	mv	s11,a0	# tmp306,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, dir$y
	mv	a0,s2	#, dist_i
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s6	#, orig$y
	call	__addsf3		#
	mv	s1,a0	# tmp307,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s2	#, dist_i
	mv	a0,s10	#, dir$z
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s9	#, orig$z
	call	__addsf3		#
# main_raytrace_termio.c:147:       *hit = vec3_add(orig,vec3_scale(dist_i,dir));
	lw	a5,32(sp)		# hit, %sfp
	sw	a0,24(sp)	# tmp191, %sfp
# main_raytrace_termio.c:149:       *material = spheres[i].material;
	sw	s2,16(sp)	# dist_i, %sfp
# main_raytrace_termio.c:147:       *hit = vec3_add(orig,vec3_scale(dist_i,dir));
	sw	s1,4(a5)	# tmp189, hit_42(D)->y
	sw	a0,8(a5)	# tmp191, hit_42(D)->z
	sw	s11,0(a5)	# tmp187, hit_42(D)->x
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,0(s0)		#, MEM[(float *)_205]
	mv	a0,s11	#, tmp187
	call	__subsf3		#
	lw	a1,4(s0)		#, MEM[(float *)_205 + 4B]
	mv	a5,a0	# tmp309,
	mv	a0,s1	#, tmp189
	sw	a5,20(sp)	# tmp192, %sfp
	call	__subsf3		#
	lw	a4,24(sp)		# tmp191, %sfp
	lw	a1,8(s0)		#, MEM[(float *)_205 + 8B]
	mv	s2,a0	# tmp310,
	mv	a0,a4	#, tmp191
	call	__subsf3		#
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	lw	a5,20(sp)		# tmp192, %sfp
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	s1,a0	# tmp311,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a5	#, tmp192
	mv	a0,a5	#, tmp192
	sw	a5,24(sp)	# tmp192, %sfp
	call	__mulsf3		#
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s2	#, tmp193
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	sw	a0,20(sp)	# tmp195, %sfp
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s2	#, tmp193
	call	__mulsf3		#
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	lw	a4,20(sp)		# tmp195, %sfp
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a0	# tmp313,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,a4	#, tmp195
	call	__addsf3		#
	sw	a0,20(sp)	# tmp197, %sfp
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s1	#, tmp194
	mv	a0,s1	#, tmp194
	call	__mulsf3		#
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	lw	a4,20(sp)		# tmp197, %sfp
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a0	# tmp315,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,a4	#, tmp197
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp316,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a0,40(sp)		#, %sfp
	call	__divsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a5,24(sp)		# tmp192, %sfp
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	sw	a0,20(sp)	# tmp201, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a5	#, tmp192
	call	__mulsf3		#
	lw	a5,20(sp)		# tmp201, %sfp
	mv	a1,s2	#, tmp193
# main_raytrace_termio.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	lw	s2,36(sp)		# N, %sfp
	sw	a0,0(s2)	# tmp318, N_43(D)->x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,a5	#, tmp201
	call	__mulsf3		#
	lw	a5,20(sp)		# tmp201, %sfp
# main_raytrace_termio.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	sw	a0,4(s2)	# tmp319, N_43(D)->y
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s1	#, tmp194
	mv	a0,a5	#, tmp201
	call	__mulsf3		#
# main_raytrace_termio.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	sw	a0,8(s2)	# tmp320, N_43(D)->z
# main_raytrace_termio.c:149:       *material = spheres[i].material;
	lw	t1,16(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a7,20(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a6,24(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a0,28(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a1,32(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a2,36(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a3,40(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a4,44(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	a5,48(s0)		# MEM[(struct  *)_205 + 16B], MEM[(struct  *)_205 + 16B]
	lw	t3,28(sp)		# material, %sfp
	sw	t1,0(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a7,4(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a6,8(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a0,12(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a1,16(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a2,20(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a3,24(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a4,28(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
	sw	a5,32(t3)	# MEM[(struct  *)_205 + 16B], *material_44(D)
.L296:
# main_raytrace_termio.c:143:   for(int i=0; i<nb_spheres; ++i) {
	lw	a5,12(sp)		# nb_spheres, %sfp
# main_raytrace_termio.c:143:   for(int i=0; i<nb_spheres; ++i) {
	addi	s3,s3,1	#, i, i
# main_raytrace_termio.c:143:   for(int i=0; i<nb_spheres; ++i) {
	addi	s0,s0,52	#, ivtmp.1102, ivtmp.1102
	bne	a5,s3,.L302	#, nb_spheres, i,
.L293:
# main_raytrace_termio.c:153:   if (fabs(dir.y)>1e-3)  {
	mv	a0,s5	#, dir$y
	call	__extendsfdf2		#
	call	fabs		#
# main_raytrace_termio.c:153:   if (fabs(dir.y)>1e-3)  {
	lui	a5,%hi(.LC4)	# tmp216,
	lw	a2,%lo(.LC4)(a5)		#,
	lw	a3,%lo(.LC4+4)(a5)		#,
	call	__gtdf2		#
	ble	a0,zero,.L305	#, tmp321,,
# main_raytrace_termio.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	lui	a5,%hi(.LC5)	# tmp218,
	lw	a1,%lo(.LC5)(a5)		#,
	mv	a0,s6	#, orig$y
	call	__addsf3		#
# main_raytrace_termio.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	li	a5,-2147483648		# tmp221,
	mv	a1,s5	#, dir$y
	xor	a0,a5,a0	# tmp322,, tmp221
	call	__divsf3		#
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	mv	a1,zero	#,
# main_raytrace_termio.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	mv	s0,a0	# d, tmp323
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__gtsf2		#
	bgt	a0,zero,.L324	#, tmp324,,
.L305:
# main_raytrace_termio.c:152:   float checkerboard_dist = 1e30;
	lw	a5,44(sp)		# tmp273, %sfp
	lw	s0,%lo(.LC3)(a5)		# d,
.L304:
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	a1,16(sp)		#, %sfp
	mv	a0,s0	#, d
	call	__gtsf2		#
	bgt	a0,zero,.L312	#, tmp334,,
	sw	s0,16(sp)	# d, %sfp
.L312:
# main_raytrace_termio.c:163:   return min(spheres_dist, checkerboard_dist)<1000;
	lui	a5,%hi(.LC14)	# tmp271,
	lw	a0,16(sp)		#, %sfp
	lw	a1,%lo(.LC14)(a5)		#,
	call	__ltsf2		#
# main_raytrace_termio.c:164: }
	lw	ra,108(sp)		#,
	lw	s0,104(sp)		#,
	lw	s1,100(sp)		#,
	lw	s2,96(sp)		#,
	lw	s3,92(sp)		#,
	lw	s4,88(sp)		#,
	lw	s5,84(sp)		#,
	lw	s6,80(sp)		#,
	lw	s7,76(sp)		#,
	lw	s8,72(sp)		#,
	lw	s9,68(sp)		#,
	lw	s10,64(sp)		#,
	lw	s11,60(sp)		#,
	slti	a0,a0,0	#,, tmp335
	addi	sp,sp,112	#,,
	jr	ra		#
.L324:
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s8	#, dir$x
	mv	a0,s0	#, d
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s7	#, orig$x
	call	__addsf3		#
	mv	s1,a0	# tmp225, tmp325
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__extendsfdf2		#
	call	fabs		#
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC6)	# tmp228,
	lw	a2,%lo(.LC6)(a5)		#,
	lw	a3,%lo(.LC6+4)(a5)		#,
	call	__ltdf2		#
	bge	a0,zero,.L305	#, tmp326,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s10	#, dir$z
	mv	a0,s0	#, d
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s9	#, orig$z
	call	__addsf3		#
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC7)	# tmp233,
	lw	a1,%lo(.LC7)(a5)		#,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp231, tmp327
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__ltsf2		#
	bge	a0,zero,.L305	#, tmp328,,
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC8)	# tmp236,
	lw	a1,%lo(.LC8)(a5)		#,
	mv	a0,s2	#, tmp231
	call	__gtsf2		#
	ble	a0,zero,.L305	#, tmp329,,
# main_raytrace_termio.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lw	a1,16(sp)		#, %sfp
	mv	a0,s0	#, d
	call	__ltsf2		#
	bge	a0,zero,.L305	#, tmp330,,
# main_raytrace_termio.c:158:       *hit = pt;
	lw	s3,32(sp)		# hit, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, dir$y
	mv	a0,s0	#, d
# main_raytrace_termio.c:158:       *hit = pt;
	sw	s1,0(s3)	# tmp225, hit_42(D)->x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s6	#, orig$y
	call	__addsf3		#
# main_raytrace_termio.c:159:       *N = make_vec3(0,1,0);
	lw	a4,36(sp)		# N, %sfp
# main_raytrace_termio.c:158:       *hit = pt;
	sw	a0,4(s3)	# tmp331, hit_42(D)->y
	sw	s2,8(s3)	# tmp231, hit_42(D)->z
# main_raytrace_termio.c:159:       *N = make_vec3(0,1,0);
	mv	a3,zero	# tmp366,
	lui	a5,%hi(.LC1)	# tmp241,
	sw	a3,0(a4)	# tmp366, N_43(D)->x
	lw	a5,%lo(.LC1)(a5)		# tmp242,
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a0,0(s3)		#, hit_42(D)->x
# main_raytrace_termio.c:159:       *N = make_vec3(0,1,0);
	sw	a3,8(a4)	# tmp370, N_43(D)->z
	sw	a5,4(a4)	# tmp242, N_43(D)->y
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__extendsfdf2		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	s2,%hi(.LC9)	# tmp244,
	lw	a2,%lo(.LC9)(s2)		#,
	lw	a3,%lo(.LC9+4)(s2)		#,
	call	__muldf3		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	a5,%hi(.LC10)	# tmp246,
	lw	a2,%lo(.LC10)(a5)		#,
	lw	a3,%lo(.LC10+4)(a5)		#,
	call	__adddf3		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__fixdfsi		#
	mv	s1,a0	# tmp332,
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a0,8(s3)		#, hit_42(D)->z
	call	__extendsfdf2		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a2,%lo(.LC9)(s2)		#,
	lw	a3,%lo(.LC9+4)(s2)		#,
	call	__muldf3		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__fixdfsi		#
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	add	a5,s1,a0	# tmp333, tmp253, tmp248
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	andi	a5,a5,1	#, tmp254, tmp253
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	beq	a5,zero,.L311	#, tmp254,,
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	a5,%hi(.LC11)	# tmp255,
	lw	a5,%lo(.LC11)(a5)		# tmp256,
	lw	a4,28(sp)		# material, %sfp
	sw	a5,20(a4)	# tmp256, material_44(D)->diffuse_color.x
	sw	a5,24(a4)	# tmp256, material_44(D)->diffuse_color.y
	sw	a5,28(a4)	# tmp256, material_44(D)->diffuse_color.z
	j	.L304		#
.L311:
# main_raytrace_termio.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	a3,%hi(.LC11)	# tmp261,
	lui	a4,%hi(.LC12)	# tmp263,
	lui	a5,%hi(.LC13)	# tmp265,
	lw	a2,28(sp)		# material, %sfp
	lw	a3,%lo(.LC11)(a3)		# tmp262,
	lw	a4,%lo(.LC12)(a4)		# tmp264,
	lw	a5,%lo(.LC13)(a5)		# tmp266,
	sw	a3,20(a2)	# tmp262, material_44(D)->diffuse_color.x
	sw	a4,24(a2)	# tmp264, material_44(D)->diffuse_color.y
	sw	a5,28(a2)	# tmp266, material_44(D)->diffuse_color.z
	j	.L304		#
	.size	scene_intersect, .-scene_intersect
	.globl	__fixsfsi
	.align	2
	.globl	my_pow
	.type	my_pow, @function
my_pow:
	addi	sp,sp,-48	#,,
	sw	s8,8(sp)	#,
	mv	s8,a0	# tmp93, x
# main_raytrace_termio.c:170:   int Y = (int)y;
	mv	a0,a1	#, tmp94
# main_raytrace_termio.c:168: float my_pow(float x, float y) {
	sw	s0,40(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s9,4(sp)	#,
# main_raytrace_termio.c:170:   int Y = (int)y;
	call	__fixsfsi		#
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC15)	# tmp89,
	lw	s4,%lo(.LC15)(a5)		# tmp90,
	lw	s5,%lo(.LC15+4)(a5)		#,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC16)	# tmp91,
	lw	s2,%lo(.LC16)(a5)		# tmp92,
	lw	s3,%lo(.LC16+4)(a5)		#,
# main_raytrace_termio.c:170:   int Y = (int)y;
	mv	s6,a0	# Y, tmp95
# main_raytrace_termio.c:169:   float alu_rslt = x;
	mv	s0,s8	# <retval>, x
# main_raytrace_termio.c:171:   while(Y > 2) {
	li	s7,2		# tmp85,
# main_raytrace_termio.c:171:   while(Y > 2) {
	j	.L326		#
.L328:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	call	__mulsf3		#
	mv	s0,a0	# <retval>, tmp96
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__extendsfdf2		#
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	a2,s4	#, tmp90
	mv	a3,s5	#,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	s9,a0	# _1, tmp103
	mv	s1,a1	# _1, tmp104
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__ltdf2		#
	mv	a5,a0	# tmp98,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	a1,s1	#, _1
	mv	a0,s9	# tmp105, _1
	mv	a2,s2	#, tmp92
	mv	a3,s3	#,
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	srai	s6,s6,1	#, Y, Y
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	blt	a5,zero,.L325	#, tmp98,,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__gtdf2		#
	bgt	a0,zero,.L325	#, tmp99,,
.L326:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	mv	a1,s0	#, <retval>
	mv	a0,s0	#, tmp11
# main_raytrace_termio.c:171:   while(Y > 2) {
	bgt	s6,s7,.L328	#, Y, tmp85,
# main_raytrace_termio.c:177:   while(Y > 1) {
	bne	s6,s7,.L325	#, Y, tmp85,
# main_raytrace_termio.c:178:     Y--; alu_rslt *= x;
	mv	a0,s0	#, <retval>
	mv	a1,s8	#, x
	call	__mulsf3		#
	mv	s0,a0	# <retval>, tmp100
.L325:
# main_raytrace_termio.c:184: }
	lw	ra,44(sp)		#,
	mv	a0,s0	#, <retval>
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
	.size	my_pow, .-my_pow
	.globl	__truncdfsf2
	.align	2
	.globl	cast_ray
	.type	cast_ray, @function
cast_ray:
	addi	sp,sp,-448	#,,
	sw	s3,428(sp)	#,
	mv	s3,a2	# tmp272, tmp567
	sw	s1,436(sp)	#,
	mv	s1,a7	# depth, tmp572
	lw	a7,0(s3)		# dir$x, dir.x
	sw	s2,432(sp)	#,
# main_raytrace_termio.c:96:   return M;
	lui	s2,%hi(.LC1)	# tmp538,
	sw	a7,72(sp)	# dir$x, %sfp
	lw	a7,8(s3)		# dir$z, dir.z
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	s4,424(sp)	#,
# main_raytrace_termio.c:96:   return M;
	lw	s4,%lo(.LC1)(s2)		# tmp279,
	sw	a7,68(sp)	# dir$z, %sfp
	lw	a7,4(s3)		# dir$y, dir.y
	mv	a2,zero	# tmp745,
	sw	a2,320(sp)	# tmp745, material.albedo.y
	sw	a2,324(sp)	# tmp746, material.albedo.z
	sw	a2,328(sp)	# tmp747, material.albedo.w
	sw	a2,332(sp)	# tmp748, material.diffuse_color.x
	sw	a2,336(sp)	# tmp749, material.diffuse_color.y
	sw	a2,340(sp)	# tmp750, material.diffuse_color.z
	sw	a2,344(sp)	# tmp751, material.specular_exponent
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	ra,444(sp)	#,
	sw	s0,440(sp)	#,
	sw	s5,420(sp)	#,
	sw	s6,416(sp)	#,
	sw	s7,412(sp)	#,
	sw	s8,408(sp)	#,
	sw	s9,404(sp)	#,
	sw	s10,400(sp)	#,
	sw	s11,396(sp)	#,
# main_raytrace_termio.c:96:   return M;
	sw	s4,312(sp)	# tmp279, material.refractive_index
	sw	s4,316(sp)	# tmp279, material.albedo.x
	sw	a7,32(sp)	# dir$y, %sfp
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	a0,104(sp)	# tmp565, %sfp
	sw	a3,20(sp)	# tmp568, %sfp
	sw	a4,24(sp)	# tmp569, %sfp
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	li	a2,2		# tmp282,
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	a6,64(sp)	# tmp571, %sfp
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	ble	s1,a2,.L334	#, depth, tmp282,
.L336:
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	lw	a0,32(sp)		#, %sfp
	call	__extendsfdf2		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC17)	# tmp284,
	lw	a2,%lo(.LC17)(a5)		#,
	lw	a3,%lo(.LC17+4)(a5)		#,
	call	__adddf3		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC9)	# tmp286,
	lw	a2,%lo(.LC9)(a5)		#,
	lw	a3,%lo(.LC9+4)(a5)		#,
	call	__muldf3		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	call	__truncdfsf2		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,zero	#,
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	mv	s0,a0	# tmp288, tmp573
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	lui	a5,%hi(.LC12)	# tmp290,
	lw	a1,%lo(.LC12)(a5)		#,
	mv	s1,a0	# tmp289, tmp574
	mv	a0,s0	#, tmp288
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s1	#, tmp289
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC18)	# tmp293,
	lw	a1,%lo(.LC18)(a5)		#,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp575,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s0	#, tmp288
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s1	#, tmp289
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC19)	# tmp296,
	lw	a1,%lo(.LC19)(a5)		#,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp576,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s0	#, tmp288
	call	__mulsf3		#
	lui	a5,%hi(.LC20)	# tmp298,
	lw	a1,%lo(.LC20)(a5)		#,
	mv	s3,a0	# tmp297, tmp577
	mv	a0,s0	#, tmp288
	call	__mulsf3		#
	mv	a1,a0	# tmp578,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s3	#, tmp297
	call	__addsf3		#
.L335:
# main_raytrace_termio.c:41:   return V;
	lw	a5,104(sp)		# .result_ptr, %sfp
# main_raytrace_termio.c:229: }
	lw	ra,444(sp)		#,
	lw	s0,440(sp)		#,
# main_raytrace_termio.c:41:   return V;
	sw	s2,0(a5)	# _61, <retval>.x
	sw	s1,4(a5)	# _50, <retval>.y
	sw	a0,8(a5)	# _31, <retval>.z
# main_raytrace_termio.c:229: }
	lw	s1,436(sp)		#,
	lw	s2,432(sp)		#,
	lw	s3,428(sp)		#,
	lw	s4,424(sp)		#,
	lw	s5,420(sp)		#,
	lw	s6,416(sp)		#,
	lw	s7,412(sp)		#,
	lw	s8,408(sp)		#,
	lw	s9,404(sp)		#,
	lw	s10,400(sp)		#,
	lw	s11,396(sp)		#,
	mv	a0,a5	#, .result_ptr
	addi	sp,sp,448	#,,
	jr	ra		#
.L334:
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	lw	t6,0(a1)		# orig, orig
	lw	t5,4(a1)		# orig, orig
	lw	t4,8(a1)		# orig, orig
	lw	t3,0(s3)		# dir, dir
	lw	t1,4(s3)		# dir, dir
	lw	a7,8(s3)		# dir, dir
	lw	a2,20(sp)		#, %sfp
	mv	s0,a5	# lights, tmp570
	mv	a3,a4	#, tmp569
	addi	a6,sp,312	#,,
	addi	a5,sp,168	#,,
	addi	a4,sp,156	#,,
	addi	a1,sp,112	#,,
	addi	a0,sp,128	#, tmp755,
	sw	t6,128(sp)	# orig,
	sw	t5,132(sp)	# orig,
	sw	t4,136(sp)	# orig,
	sw	t3,112(sp)	# dir,
	sw	t1,116(sp)	# dir,
	sw	a7,120(sp)	# dir,
	call	scene_intersect		#
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	beq	a0,zero,.L336	#, tmp580,,
	lw	s11,168(sp)		# N$x, N.x
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s7,72(sp)		# dir$x, %sfp
	lw	s6,172(sp)		# N$y, N.y
	mv	a1,s11	#, N$x
	mv	a0,s7	#, dir$x
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s10,32(sp)		# dir$y, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s5,a0	# tmp312, tmp581
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s6	#, N$y
	mv	a0,s10	#, dir$y
	call	__mulsf3		#
	mv	a1,a0	# tmp582,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp312
	call	__addsf3		#
	lw	s8,176(sp)		# N$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s9,68(sp)		# dir$z, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s5,a0	# tmp314, tmp583
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s8	#, N$z
	mv	a0,s9	#, dir$z
	call	__mulsf3		#
	mv	a1,a0	# tmp584,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp314
	call	__addsf3		#
	mv	a1,a0	# tmp585,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s11	#, N$x
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s5,a0	# tmp317, tmp586
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a1,a0	# tmp587,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s7	#, dir$x
	call	__subsf3		#
	mv	s7,a0	# tmp588,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, tmp317
	mv	a0,s6	#, N$y
	sw	s6,76(sp)	# N$y, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp589,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s10	#, dir$y
	call	__subsf3		#
	mv	s6,a0	# tmp590,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s8	#, N$z
	mv	a0,s5	#, tmp317
	sw	s8,80(sp)	# N$z, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp591,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s9	#, dir$z
	call	__subsf3		#
	mv	s5,a0	# tmp592,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s7	#, tmp319
	mv	a0,s7	#, tmp319
	call	__mulsf3		#
	mv	s8,a0	# tmp324, tmp593
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp321
	mv	a0,s6	#, tmp321
	call	__mulsf3		#
	mv	a1,a0	# tmp594,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s8	#, tmp324
	call	__addsf3		#
	mv	s8,a0	# tmp326, tmp595
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp323
	mv	a0,s5	#, tmp323
	call	__mulsf3		#
	mv	a1,a0	# tmp596,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s8	#, tmp326
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp597,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s4	#, tmp279
	call	__divsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s7	#, tmp319
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	s8,a0	# tmp330, tmp598
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a1,s6	#, tmp321
	mv	s9,a0	# tmp599,
	mv	a0,s8	#, tmp330
	call	__mulsf3		#
	mv	a1,s5	#, tmp323
	mv	s7,a0	# tmp600,
	mv	a0,s8	#, tmp330
	call	__mulsf3		#
# main_raytrace_termio.c:196:   vec3 refract_dir = vec3_normalize(refract(dir, N, material.refractive_index, 1));
	lw	a5,8(s3)		# dir, dir
	lw	a7,0(s3)		# dir, dir
	lw	a6,4(s3)		# dir, dir
	sw	a5,136(sp)	# dir,
	lw	a5,168(sp)		# N, N
	lw	a3,312(sp)		#, material.refractive_index
	mv	a4,s4	#, tmp279
	sw	a5,112(sp)	# N,
	lw	a5,172(sp)		# N, N
	addi	a2,sp,112	#,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	s6,a0	# tmp601,
# main_raytrace_termio.c:196:   vec3 refract_dir = vec3_normalize(refract(dir, N, material.refractive_index, 1));
	sw	a5,116(sp)	# N,
	lw	a5,176(sp)		# N, N
	addi	a1,sp,128	#, tmp759,
	addi	a0,sp,300	#,,
	sw	a5,120(sp)	# N,
	sw	a7,128(sp)	# dir,
	sw	a6,132(sp)	# dir,
	call	refract		#
	lw	s5,300(sp)		# U$x, D.2307.x
	lw	s10,304(sp)		# U$y, D.2307.y
	lw	s8,308(sp)		# U$z, D.2307.z
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, U$x
	mv	a0,s5	#, U$x
	call	__mulsf3		#
	mv	s3,a0	# tmp346, tmp602
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s10	#, U$y
	mv	a0,s10	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp603,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s3	#, tmp346
	call	__addsf3		#
	mv	s3,a0	# tmp348, tmp604
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s8	#, U$z
	mv	a0,s8	#, U$z
	call	__mulsf3		#
	mv	a1,a0	# tmp605,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s3	#, tmp348
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp606,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s4	#, tmp279
	call	__divsf3		#
	mv	s3,a0	# tmp352, tmp607
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp352
	mv	a0,s5	#, U$x
	call	__mulsf3		#
	mv	a1,s3	#, tmp352
	mv	s5,a0	# tmp608,
	mv	a0,s10	#, U$y
	call	__mulsf3		#
	mv	a1,s3	#, tmp352
	mv	s4,a0	# tmp609,
	mv	a0,s8	#, U$z
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s11	#, N$x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	s3,a0	# tmp610,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, _107
	sw	s11,84(sp)	# N$x, %sfp
	call	__mulsf3		#
	mv	s8,a0	# tmp356, tmp611
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s7	#, _108
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	s10,%hi(.LC21)	# tmp362,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	a1,a0	# tmp612,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, tmp356
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,80(sp)		#, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s8,a0	# tmp358, tmp613
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s6	#, _109
	call	__mulsf3		#
	mv	a1,a0	# tmp614,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, tmp358
	call	__addsf3		#
# main_raytrace_termio.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	lw	a5,156(sp)		# pretmp_548, point.x
	lw	s11,160(sp)		# pretmp_547, point.y
	lw	s8,164(sp)		# pretmp_549, point.z
	sw	a5,28(sp)	# pretmp_548, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s10)		#,
# main_raytrace_termio.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	blt	a0,zero,.L381	#, tmp615,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a0,84(sp)		#, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp622,
	lw	a1,%lo(.LC21)(s10)		#,
	lw	a0,76(sp)		#, %sfp
	sw	a5,88(sp)	# tmp622, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp623,
	lw	a1,%lo(.LC21)(s10)		#,
	lw	a0,80(sp)		#, %sfp
	mv	s10,a5	# _132, tmp623
	sw	a5,96(sp)	# _132, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp624,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a1,28(sp)		#, %sfp
	lw	a0,88(sp)		#, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	sw	a5,92(sp)	# tmp624, %sfp
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	call	__addsf3		#
	mv	a5,a0	# tmp625,
	mv	a1,s11	#, pretmp_547
	mv	a0,s10	#, _132
	sw	a5,12(sp)	# _128, %sfp
	call	__addsf3		#
	mv	s10,a0	# tmp626,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_549
	call	__addsf3		#
	lw	a4,12(sp)		# _128, %sfp
	mv	a5,a0	# _130, tmp627
.L339:
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,84(sp)		#, %sfp
	mv	a0,s5	#, _97
# main_raytrace_termio.c:41:   return V;
	sw	a4,204(sp)	# _128, reflect_orig.x
	sw	a5,212(sp)	# _130, reflect_orig.z
	sw	s10,208(sp)	# _129, reflect_orig.y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s10,a0	# tmp380, tmp628
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s4	#, _98
	call	__mulsf3		#
	mv	a1,a0	# tmp629,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp380
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,80(sp)		#, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s10,a0	# tmp382, tmp630
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, _99
	call	__mulsf3		#
	mv	a1,a0	# tmp631,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp382
	call	__addsf3		#
# main_raytrace_termio.c:199:   vec3 refract_orig = vec3_dot(refract_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	blt	a0,zero,.L382	#, tmp632,,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a1,28(sp)		#, %sfp
	lw	a0,88(sp)		#, %sfp
	call	__addsf3		#
	mv	a5,a0	# tmp636,
	lw	a0,96(sp)		#, %sfp
	mv	a1,s11	#, pretmp_547
	sw	a5,12(sp)	# _145, %sfp
	call	__addsf3		#
	mv	s10,a0	# tmp637,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_549
	call	__addsf3		#
	lw	t3,12(sp)		# _145, %sfp
	mv	t1,a0	# _147, tmp638
.L342:
# main_raytrace_termio.c:41:   return V;
	sw	t1,224(sp)	# _147, refract_orig.z
# main_raytrace_termio.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	lw	t1,204(sp)		# reflect_orig, reflect_orig
	lw	a6,64(sp)		#, %sfp
	lw	a4,24(sp)		#, %sfp
	sw	t1,128(sp)	# reflect_orig,
	lw	t1,208(sp)		# reflect_orig, reflect_orig
	lw	a3,20(sp)		#, %sfp
	addi	s1,s1,1	#, _8, depth
	sw	t1,132(sp)	# reflect_orig,
	lw	t1,212(sp)		# reflect_orig, reflect_orig
	mv	a7,s1	#, _8
	mv	a5,s0	#, lights
	addi	a2,sp,112	#,,
	addi	a1,sp,128	#, tmp761,
	addi	a0,sp,228	#,,
	sw	t1,136(sp)	# reflect_orig,
# main_raytrace_termio.c:41:   return V;
	sw	t3,216(sp)	# _145, refract_orig.x
	sw	s10,220(sp)	# _146, refract_orig.y
# main_raytrace_termio.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	sw	s9,180(sp)	# _107, reflect_dir.x
	sw	s7,184(sp)	# _108, reflect_dir.y
	sw	s6,188(sp)	# _109, reflect_dir.z
	sw	s9,112(sp)	# _107,
	sw	s7,116(sp)	# _108,
	sw	s6,120(sp)	# _109,
	call	cast_ray		#
# main_raytrace_termio.c:201:   vec3 refract_color = cast_ray(refract_orig, refract_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	lw	t1,216(sp)		# refract_orig, refract_orig
	mv	a7,s1	#, _8
	lw	s1,64(sp)		# nb_lights, %sfp
	sw	t1,128(sp)	# refract_orig,
	lw	t1,220(sp)		# refract_orig, refract_orig
	lw	a4,24(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	sw	t1,132(sp)	# refract_orig,
	lw	t1,224(sp)		# refract_orig, refract_orig
	mv	a6,s1	#, nb_lights
	mv	a5,s0	#, lights
	addi	a2,sp,112	#,,
	addi	a1,sp,128	#, tmp762,
	addi	a0,sp,240	#,,
	sw	s5,192(sp)	# _97, refract_dir.x
	sw	s4,196(sp)	# _98, refract_dir.y
	sw	s3,200(sp)	# _99, refract_dir.z
	sw	t1,136(sp)	# refract_orig,
	sw	s5,112(sp)	# _97,
	sw	s4,116(sp)	# _98,
	sw	s3,120(sp)	# _99,
	call	cast_ray		#
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	ble	s1,zero,.L359	#, nb_lights,,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a5,%lo(.LC1)(s2)		# tmp545,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	lw	s10,28(sp)		# pretmp_548, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	sw	zero,12(sp)	#, %sfp
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	sw	a5,100(sp)	# tmp545, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC15)	# tmp547,
	lw	a6,%lo(.LC15+4)(a5)		#,
	lw	a5,%lo(.LC15)(a5)		# tmp548,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	li	s4,-2147483648		# tmp546,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	sw	a6,52(sp)	#, %sfp
	sw	a5,48(sp)	# tmp548, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC16)	# tmp549,
	lw	a6,%lo(.LC16+4)(a5)		#,
	lw	a5,%lo(.LC16)(a5)		# tmp550,
	sw	a6,60(sp)	#, %sfp
	sw	a5,56(sp)	# tmp550, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	a5,zero	# specular_light_intensity,
	sw	a5,108(sp)	# specular_light_intensity, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	sw	a5,16(sp)	# diffuse_light_intensity, %sfp
	j	.L358		#
.L375:
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a0,88(sp)		#, %sfp
	mv	a1,s10	#, pretmp_548
	call	__addsf3		#
	mv	s6,a0	# tmp667,
	lw	a0,96(sp)		#, %sfp
	mv	a1,s11	#, pretmp_547
	call	__addsf3		#
	mv	s5,a0	# tmp668,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_549
	call	__addsf3		#
	mv	s9,a0	# shadow_orig$z, tmp669
.L346:
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	lw	a3,24(sp)		#, %sfp
	lw	a2,20(sp)		#, %sfp
	addi	a6,sp,348	#, tmp769,
	addi	a5,sp,288	#, tmp770,
	addi	a4,sp,276	#, tmp771,
	addi	a1,sp,112	#,,
	addi	a0,sp,128	#, tmp772,
	sw	s6,264(sp)	# shadow_orig$x, shadow_orig.x
	sw	s5,268(sp)	# shadow_orig$y, shadow_orig.y
	sw	s9,272(sp)	# shadow_orig$z, shadow_orig.z
	sw	s3,252(sp)	# _172, light_dir.x
	sw	s2,256(sp)	# _173, light_dir.y
	sw	s1,260(sp)	# _174, light_dir.z
	sw	s6,128(sp)	# shadow_orig$x,
	sw	s5,132(sp)	# shadow_orig$y,
	sw	s9,136(sp)	# shadow_orig$z,
	sw	s3,112(sp)	# _172,
	sw	s2,116(sp)	# _173,
	sw	s1,120(sp)	# _174,
	call	scene_intersect		#
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	bne	a0,zero,.L383	#, tmp670,,
.L347:
	lw	a4,168(sp)		# V$x, N.x
	lw	s5,172(sp)		# V$y, N.y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, _172
	mv	a1,a4	#, V$x
	sw	a4,44(sp)	# V$x, %sfp
	sw	s5,36(sp)	# V$y, %sfp
	call	__mulsf3		#
	lw	s9,176(sp)		# V$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, V$y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s7,a0	# tmp680,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, _173
	call	__mulsf3		#
	mv	s6,a0	# tmp681,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s9	#, V$z
	mv	a0,s1	#, _174
	call	__mulsf3		#
	mv	s5,a0	# _224, tmp682
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s6	#, _222
	mv	a0,s7	#, _221
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, _224
	call	__addsf3		#
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	sw	a0,40(sp)	# iftmp.40_220, %sfp
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a5,12(s0)		# _14, MEM[(float *)_270 + 12B]
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lw	a4,44(sp)		# V$x, %sfp
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	sw	a5,28(sp)	# _14, %sfp
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lw	a5,40(sp)		# iftmp.40_220, %sfp
	bge	a0,zero,.L349	#, tmp684,,
	mv	a5,zero	# iftmp.40_220,
.L349:
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a0,28(sp)		#, %sfp
	mv	a1,a5	#, iftmp.40_220
	sw	a4,40(sp)	# V$x, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp685,
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a0,16(sp)		#, %sfp
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	s3,s4,s3	# _172, tmp476, tmp546
	xor	s2,s4,s2	# _173, tmp483, tmp546
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	call	__addsf3		#
	mv	a5,a0	# tmp686,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	a1,s7	#, _221
	xor	a0,s4,s6	# _222,, tmp546
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	sw	a5,16(sp)	# tmp686, %sfp
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__subsf3		#
	mv	a1,s5	#, _224
	call	__subsf3		#
	mv	a1,a0	# tmp687,
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a4,40(sp)		# V$x, %sfp
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s5,a0	# tmp475, tmp688
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	s1,s4,s1	# _174, tmp491, tmp546
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a4	#, V$x
	call	__mulsf3		#
	mv	a1,a0	# tmp689,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s3	#, tmp476
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,72(sp)		#, %sfp
	xor	a0,s4,a0	# tmp690,, tmp546
	call	__mulsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,36(sp)		#, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s3,a0	# tmp691,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, tmp475
	call	__mulsf3		#
	mv	a1,a0	# tmp692,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s2	#, tmp483
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,32(sp)		#, %sfp
	xor	a0,s4,a0	# tmp693,, tmp546
	call	__mulsf3		#
	mv	a1,a0	# tmp694,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, tmp482
	call	__addsf3		#
	mv	s2,a0	# tmp695,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s9	#, V$z
	mv	a0,s5	#, tmp475
	call	__mulsf3		#
	mv	a1,a0	# tmp696,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s1	#, tmp491
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,68(sp)		#, %sfp
	xor	a0,s4,a0	# tmp697,, tmp546
	call	__mulsf3		#
	mv	a1,a0	# tmp698,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp490
	call	__addsf3		#
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s3,a0	# _204, tmp699
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
	blt	a0,zero,.L348	#, tmp700,,
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,s3	#, _204
	call	__gtsf2		#
# main_raytrace_termio.c:219:     float def = material.specular_exponent;
	lw	s1,344(sp)		# def, material.specular_exponent
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	ble	a0,zero,.L348	#, tmp701,,
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,s1	#, def
	call	__gtsf2		#
	bgt	a0,zero,.L384	#, tmp702,,
.L348:
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,12(sp)		# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a4,64(sp)		# nb_lights, %sfp
	addi	s0,s0,16	#, ivtmp.1114, ivtmp.1114
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	addi	a5,a5,1	#, i, i
	sw	a5,12(sp)	# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	beq	a4,a5,.L343	#, nb_lights, i,
.L358:
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_270]
	mv	a1,s10	#, pretmp_548
	call	__subsf3		#
	mv	s3,a0	# tmp639,
	lw	a0,4(s0)		#, MEM[(float *)_270 + 4B]
	mv	a1,s11	#, pretmp_547
	call	__subsf3		#
	mv	s2,a0	# tmp640,
	lw	a0,8(s0)		#, MEM[(float *)_270 + 8B]
	mv	a1,s8	#, pretmp_549
	call	__subsf3		#
	mv	s1,a0	# tmp641,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s3	#, tmp410
	mv	a0,s3	#, tmp410
	call	__mulsf3		#
	mv	s5,a0	# tmp413, tmp642
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s2	#, tmp411
	mv	a0,s2	#, tmp411
	call	__mulsf3		#
	mv	a1,a0	# tmp643,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp413
	call	__addsf3		#
	mv	s5,a0	# tmp415, tmp644
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s1	#, tmp412
	mv	a0,s1	#, tmp412
	call	__mulsf3		#
	mv	a1,a0	# tmp645,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp415
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp646,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a0,100(sp)		#, %sfp
	call	__divsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s3	#, tmp410
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	s5,a0	# tmp419, tmp647
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a1,s2	#, tmp411
	mv	s3,a0	# tmp648,
	mv	a0,s5	#, tmp419
	call	__mulsf3		#
	mv	a1,s1	#, tmp412
	mv	s2,a0	# tmp649,
	mv	a0,s5	#, tmp419
	call	__mulsf3		#
	mv	s1,a0	# tmp650,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_270]
	mv	a1,s10	#, pretmp_548
	call	__subsf3		#
	mv	s5,a0	# tmp651,
	lw	a0,4(s0)		#, MEM[(float *)_270 + 4B]
	mv	a1,s11	#, pretmp_547
	call	__subsf3		#
	mv	s7,a0	# tmp652,
	lw	a0,8(s0)		#, MEM[(float *)_270 + 8B]
	mv	a1,s8	#, pretmp_549
	call	__subsf3		#
	mv	s6,a0	# tmp653,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp423
	mv	a0,s5	#, tmp11
	call	__mulsf3		#
	mv	s5,a0	# tmp426, tmp654
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s7	#, tmp424
	mv	a0,s7	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp655,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp426
	call	__addsf3		#
	mv	s5,a0	# tmp428, tmp656
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp425
	mv	a0,s6	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp657,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp428
	call	__addsf3		#
	call	sqrtf		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,84(sp)		#, %sfp
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	s7,a0	# tmp658,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, _172
	call	__mulsf3		#
	mv	s5,a0	# tmp431, tmp659
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s2	#, _173
	call	__mulsf3		#
	mv	a1,a0	# tmp660,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp431
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,80(sp)		#, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s5,a0	# tmp433, tmp661
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, _174
	call	__mulsf3		#
	mv	a1,a0	# tmp662,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp433
	call	__addsf3		#
# main_raytrace_termio.c:208:     vec3 shadow_orig = vec3_dot(light_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	bge	a0,zero,.L375	#, tmp663,,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
	mv	a0,s10	#, pretmp_548
	call	__subsf3		#
	lw	a1,96(sp)		#, %sfp
	mv	s6,a0	# tmp664,
	mv	a0,s11	#, pretmp_547
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s5,a0	# tmp665,
	mv	a0,s8	#, pretmp_549
	call	__subsf3		#
	mv	s9,a0	# shadow_orig$z, tmp666
	j	.L346		#
.L381:
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a0,84(sp)		#, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp616,
	lw	a1,%lo(.LC21)(s10)		#,
	lw	a0,76(sp)		#, %sfp
	sw	a5,88(sp)	# tmp616, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp617,
	lw	a1,%lo(.LC21)(s10)		#,
	lw	a0,80(sp)		#, %sfp
	mv	s10,a5	# _132, tmp617
	sw	a5,96(sp)	# _132, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp618,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
	lw	a0,28(sp)		#, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	sw	a5,92(sp)	# tmp618, %sfp
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	call	__subsf3		#
	mv	a5,a0	# tmp619,
	mv	a1,s10	#, _132
	mv	a0,s11	#, pretmp_547
	sw	a5,12(sp)	# _128, %sfp
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s10,a0	# tmp620,
	mv	a0,s8	#, pretmp_549
	call	__subsf3		#
	lw	a4,12(sp)		# _128, %sfp
	mv	a5,a0	# _130, tmp621
	j	.L339		#
.L383:
	lw	a0,276(sp)		#, shadow_pt.x
	mv	a1,s6	#, shadow_orig$x
	call	__subsf3		#
	mv	a5,a0	# tmp671,
	lw	a0,280(sp)		#, shadow_pt.y
	mv	a1,s5	#, shadow_orig$y
	mv	s5,a5	# tmp454, tmp671
	call	__subsf3		#
	mv	a5,a0	# tmp672,
	lw	a0,284(sp)		#, shadow_pt.z
	mv	a1,s9	#, shadow_orig$z
	mv	s9,a5	# tmp455, tmp672
	call	__subsf3		#
	mv	s6,a0	# tmp673,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp454
	mv	a0,s5	#, tmp11
	call	__mulsf3		#
	mv	s5,a0	# tmp457, tmp674
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s9	#, tmp455
	mv	a0,s9	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp675,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp457
	call	__addsf3		#
	mv	s5,a0	# tmp459, tmp676
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp456
	mv	a0,s6	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp677,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp459
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp678,
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	mv	a0,s7	#, _161
	call	__gtsf2		#
	ble	a0,zero,.L347	#, tmp679,,
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,12(sp)		# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a4,64(sp)		# nb_lights, %sfp
	addi	s0,s0,16	#, ivtmp.1114, ivtmp.1114
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	addi	a5,a5,1	#, i, i
	sw	a5,12(sp)	# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	bne	a4,a5,.L358	#, nb_lights, i,
.L343:
# main_raytrace_termio.c:224:   vec3 alu_rslt = vec3_scale(diffuse_light_intensity * material.albedo.x, material.diffuse_color);
	lw	a1,316(sp)		#, material.albedo.x
	lw	a0,16(sp)		#, %sfp
	call	__mulsf3		#
	mv	s3,a0	# tmp711,
# main_raytrace_termio.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	lw	a1,320(sp)		#, material.albedo.y
	lw	a0,108(sp)		#, %sfp
	call	__mulsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,332(sp)		#, material.diffuse_color.x
# main_raytrace_termio.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	mv	s0,a0	# tmp516, tmp712
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp515
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp516
	call	__addsf3		#
# main_raytrace_termio.c:226:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.z, reflect_color));
	lw	s5,324(sp)		# _20, material.albedo.z
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,228(sp)		#, reflect_color.x
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp518, tmp713
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp714,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp518
	call	__addsf3		#
# main_raytrace_termio.c:227:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.w, refract_color));
	lw	s4,328(sp)		# _21, material.albedo.w
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,240(sp)		#, refract_color.x
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp520, tmp715
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp716,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp520
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,336(sp)		#, material.diffuse_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp717,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp515
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp516
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,232(sp)		#, reflect_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp524, tmp718
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp719,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp524
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,244(sp)		#, refract_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp526, tmp720
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp721,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp526
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,340(sp)		#, material.diffuse_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp722,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp515
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp516
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,236(sp)		#, reflect_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp530, tmp723
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp724,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp530
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,248(sp)		#, refract_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp532, tmp725
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _21
	call	__mulsf3		#
	mv	a1,a0	# tmp726,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp532
	call	__addsf3		#
# main_raytrace_termio.c:228:   return alu_rslt;
	j	.L335		#
.L384:
# main_raytrace_termio.c:170:   int Y = (int)y;
	mv	a0,s1	#, def
	call	__fixsfsi		#
	mv	s2,a0	# Y, tmp703
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s1,s3	# alu_rslt, _204
# main_raytrace_termio.c:171:   while(Y > 2) {
	li	s5,2		# tmp510,
# main_raytrace_termio.c:171:   while(Y > 2) {
	j	.L353		#
.L355:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	call	__mulsf3		#
	mv	s1,a0	# alu_rslt, tmp704
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__extendsfdf2		#
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lw	a2,48(sp)		#, %sfp
	lw	a3,52(sp)		#, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	s7,a0	# _231, tmp730
	mv	s6,a1	# _231, tmp731
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__ltdf2		#
	mv	a5,a0	# tmp706,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lw	a2,56(sp)		#, %sfp
	lw	a3,60(sp)		#, %sfp
	mv	a0,s7	# tmp732, _231
	mv	a1,s6	#, _231
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	srai	s2,s2,1	#, Y, Y
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	blt	a5,zero,.L354	#, tmp706,,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__gtdf2		#
	bgt	a0,zero,.L354	#, tmp707,,
.L353:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	mv	a1,s1	#, alu_rslt
	mv	a0,s1	#, tmp11
# main_raytrace_termio.c:171:   while(Y > 2) {
	bgt	s2,s5,.L355	#, Y, tmp510,
# main_raytrace_termio.c:177:   while(Y > 1) {
	bne	s2,s5,.L354	#, Y, tmp510,
# main_raytrace_termio.c:178:     Y--; alu_rslt *= x;
	mv	a0,s1	#, alu_rslt
	mv	a1,s3	#, _204
	call	__mulsf3		#
	mv	s1,a0	# alu_rslt, tmp708
.L354:
# main_raytrace_termio.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	lw	a0,28(sp)		#, %sfp
	mv	a1,s1	#, alu_rslt
	call	__mulsf3		#
	mv	a1,a0	# tmp709,
# main_raytrace_termio.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	lw	a0,108(sp)		#, %sfp
	call	__addsf3		#
	sw	a0,108(sp)	# tmp710, %sfp
	j	.L348		#
.L382:
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
	lw	a0,28(sp)		#, %sfp
	call	__subsf3		#
	lw	a1,96(sp)		#, %sfp
	mv	a5,a0	# tmp633,
	mv	a0,s11	#, pretmp_547
	sw	a5,12(sp)	# _145, %sfp
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s10,a0	# tmp634,
	mv	a0,s8	#, pretmp_549
	call	__subsf3		#
	lw	t3,12(sp)		# _145, %sfp
	mv	t1,a0	# _147, tmp635
	j	.L342		#
.L359:
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	a5,zero	# specular_light_intensity,
	sw	a5,108(sp)	# specular_light_intensity, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	sw	a5,16(sp)	# diffuse_light_intensity, %sfp
	j	.L343		#
	.size	cast_ray, .-cast_ray
	.align	2
	.type	cast_ray.constprop.0, @function
cast_ray.constprop.0:
	addi	sp,sp,-448	#,,
	sw	s2,432(sp)	#,
	mv	s2,a2	# tmp271, tmp564
	sw	ra,444(sp)	#,
	lw	ra,0(s2)		# dir$x, dir.x
	sw	s1,436(sp)	#,
# main_raytrace_termio.c:96:   return M;
	lui	s1,%hi(.LC1)	# tmp534,
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	s3,428(sp)	#,
	sw	s4,424(sp)	#,
# main_raytrace_termio.c:96:   return M;
	lw	s3,%lo(.LC1)(s1)		# tmp277,
	lw	s4,4(s2)		# dir$y, dir.y
	sw	ra,72(sp)	# dir$x, %sfp
	lw	ra,8(s2)		# dir$z, dir.z
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	lw	t6,0(a1)		# orig, orig
	lw	t5,4(a1)		# orig, orig
	lw	t4,8(a1)		# orig, orig
	lw	t3,0(a2)		# dir, dir
	lw	t1,4(a2)		# dir, dir
	lw	a7,8(a2)		# dir, dir
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	mv	t0,a6	# tmp568, nb_lights
	mv	t2,a0	# tmp562, .result_ptr
	sw	s0,440(sp)	#,
	sw	s5,420(sp)	#,
	sw	s6,416(sp)	#,
	sw	s7,412(sp)	#,
	sw	s8,408(sp)	#,
	sw	s9,404(sp)	#,
	sw	s10,400(sp)	#,
	sw	s11,396(sp)	#,
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	a3,52(sp)	# spheres, %sfp
	sw	a4,56(sp)	# nb_spheres, %sfp
	sw	t0,60(sp)	# tmp568, %sfp
	mv	a2,a3	# spheres, tmp565
# main_raytrace_termio.c:96:   return M;
	mv	t0,zero	# tmp745,
# main_raytrace_termio.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	mv	a3,a4	# nb_spheres, tmp566
	mv	s0,a5	# tmp567, lights
	sw	ra,68(sp)	# dir$z, %sfp
	sw	s4,64(sp)	# dir$y, %sfp
	sw	t2,104(sp)	# tmp562, %sfp
# main_raytrace_termio.c:96:   return M;
	sw	s3,312(sp)	# tmp277, material.refractive_index
	sw	s3,316(sp)	# tmp277, material.albedo.x
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	addi	a5,sp,168	#,,
	addi	a6,sp,312	#,,
	addi	a4,sp,156	#,,
	addi	a1,sp,112	#,,
	addi	a0,sp,128	#, tmp741,
# main_raytrace_termio.c:96:   return M;
	sw	t0,320(sp)	# tmp745, material.albedo.y
	sw	t0,324(sp)	# tmp746, material.albedo.z
	sw	t0,328(sp)	# tmp747, material.albedo.w
	sw	t0,332(sp)	# tmp748, material.diffuse_color.x
	sw	t0,336(sp)	# tmp749, material.diffuse_color.y
	sw	t0,340(sp)	# tmp750, material.diffuse_color.z
	sw	t0,344(sp)	# tmp751, material.specular_exponent
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	sw	t6,128(sp)	# orig,
	sw	t5,132(sp)	# orig,
	sw	t4,136(sp)	# orig,
	sw	t3,112(sp)	# dir,
	sw	t1,116(sp)	# dir,
	sw	a7,120(sp)	# dir,
	call	scene_intersect		#
# main_raytrace_termio.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	bne	a0,zero,.L386	#, tmp569,,
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	mv	a0,s4	#, dir$y
	call	__extendsfdf2		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC17)	# tmp292,
	lw	a2,%lo(.LC17)(a5)		#,
	lw	a3,%lo(.LC17+4)(a5)		#,
	call	__adddf3		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC9)	# tmp294,
	lw	a2,%lo(.LC9)(a5)		#,
	lw	a3,%lo(.LC9+4)(a5)		#,
	call	__muldf3		#
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	call	__truncdfsf2		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,zero	#,
# main_raytrace_termio.c:191:     float s = 0.5*(dir.y + 1.0);
	mv	s0,a0	# tmp296, tmp570
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	lui	a5,%hi(.LC12)	# tmp298,
	lw	a1,%lo(.LC12)(a5)		#,
	mv	s1,a0	# tmp297, tmp571
	mv	a0,s0	#, tmp296
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s1	#, tmp297
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC18)	# tmp301,
	lw	a1,%lo(.LC18)(a5)		#,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp572,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s0	#, tmp296
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s1	#, tmp297
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC20)	# tmp304,
	lw	a1,%lo(.LC20)(a5)		#,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp573,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s0	#, tmp296
	call	__mulsf3		#
	lui	a5,%hi(.LC19)	# tmp306,
	lw	a1,%lo(.LC19)(a5)		#,
	mv	s3,a0	# tmp305, tmp574
	mv	a0,s0	#, tmp296
	call	__mulsf3		#
	mv	a1,a0	# tmp575,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s3	#, tmp305
	call	__addsf3		#
.L387:
# main_raytrace_termio.c:41:   return V;
	lw	a5,104(sp)		# .result_ptr, %sfp
# main_raytrace_termio.c:229: }
	lw	ra,444(sp)		#,
	lw	s0,440(sp)		#,
# main_raytrace_termio.c:41:   return V;
	sw	s2,0(a5)	# _14, <retval>.x
	sw	s1,4(a5)	# _15, <retval>.y
	sw	a0,8(a5)	# _16, <retval>.z
# main_raytrace_termio.c:229: }
	lw	s1,436(sp)		#,
	lw	s2,432(sp)		#,
	lw	s3,428(sp)		#,
	lw	s4,424(sp)		#,
	lw	s5,420(sp)		#,
	lw	s6,416(sp)		#,
	lw	s7,412(sp)		#,
	lw	s8,408(sp)		#,
	lw	s9,404(sp)		#,
	lw	s10,400(sp)		#,
	lw	s11,396(sp)		#,
	mv	a0,a5	#, .result_ptr
	addi	sp,sp,448	#,,
	jr	ra		#
.L386:
	lw	s10,168(sp)		# N$x, N.x
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s7,72(sp)		# dir$x, %sfp
	lw	s11,172(sp)		# N$y, N.y
	mv	a0,s10	#, N$x
	mv	a1,s7	#, dir$x
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s6,64(sp)		# dir$y, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s4,a0	# tmp309, tmp577
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s11	#, N$y
	mv	a0,s6	#, dir$y
	call	__mulsf3		#
	mv	a1,a0	# tmp578,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp309
	call	__addsf3		#
	lw	s5,176(sp)		# N$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	s8,68(sp)		# dir$z, %sfp
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s4,a0	# tmp311, tmp579
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, N$z
	mv	a1,s8	#, dir$z
	call	__mulsf3		#
	mv	a1,a0	# tmp580,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp311
	call	__addsf3		#
	mv	a1,a0	# tmp581,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__addsf3		#
	mv	s4,a0	# tmp314, tmp582
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp314
	mv	a0,s10	#, N$x
	call	__mulsf3		#
	mv	a1,a0	# tmp583,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s7	#, dir$x
	call	__subsf3		#
	mv	s7,a0	# tmp584,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s4	#, tmp314
	mv	a0,s11	#, N$y
	call	__mulsf3		#
	mv	a1,a0	# tmp585,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s6	#, dir$y
	call	__subsf3		#
	mv	s6,a0	# tmp586,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s4	#, tmp314
	mv	a0,s5	#, N$z
	sw	s5,76(sp)	# N$z, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp587,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s8	#, dir$z
	call	__subsf3		#
	mv	s4,a0	# tmp588,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s7	#, tmp316
	mv	a0,s7	#, tmp316
	call	__mulsf3		#
	mv	s5,a0	# tmp321, tmp589
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp318
	mv	a0,s6	#, tmp318
	call	__mulsf3		#
	mv	a1,a0	# tmp590,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp321
	call	__addsf3		#
	mv	s5,a0	# tmp323, tmp591
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s4	#, tmp320
	mv	a0,s4	#, tmp320
	call	__mulsf3		#
	mv	a1,a0	# tmp592,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp323
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp593,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s3	#, tmp277
	call	__divsf3		#
	mv	s5,a0	# tmp327, tmp594
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp327
	mv	a0,s7	#, tmp316
	call	__mulsf3		#
	mv	a1,s5	#, tmp327
	mv	s7,a0	# tmp595,
	mv	a0,s6	#, tmp318
	call	__mulsf3		#
	mv	a1,s5	#, tmp327
	mv	s6,a0	# tmp596,
	mv	a0,s4	#, tmp320
	call	__mulsf3		#
# main_raytrace_termio.c:196:   vec3 refract_dir = vec3_normalize(refract(dir, N, material.refractive_index, 1));
	lw	a5,8(s2)		# dir, dir
	lw	a7,0(s2)		# dir, dir
	lw	a6,4(s2)		# dir, dir
	sw	a5,136(sp)	# dir,
	lw	a5,168(sp)		# N, N
	lw	a3,312(sp)		#, material.refractive_index
	mv	a4,s3	#, tmp277
	sw	a5,112(sp)	# N,
	lw	a5,172(sp)		# N, N
	addi	a2,sp,112	#,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	s5,a0	# tmp597,
# main_raytrace_termio.c:196:   vec3 refract_dir = vec3_normalize(refract(dir, N, material.refractive_index, 1));
	sw	a5,116(sp)	# N,
	lw	a5,176(sp)		# N, N
	addi	a1,sp,128	#, tmp755,
	addi	a0,sp,300	#,,
	sw	a7,128(sp)	# dir,
	sw	a6,132(sp)	# dir,
	sw	a5,120(sp)	# N,
	call	refract		#
	lw	s4,300(sp)		# U$x, D.4151.x
	lw	s9,304(sp)		# U$y, D.4151.y
	lw	s8,308(sp)		# U$z, D.4151.z
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s4	#, U$x
	mv	a0,s4	#, U$x
	call	__mulsf3		#
	mv	s2,a0	# tmp343, tmp598
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s9	#, U$y
	mv	a0,s9	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp599,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s2	#, tmp343
	call	__addsf3		#
	mv	s2,a0	# tmp345, tmp600
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s8	#, U$z
	mv	a0,s8	#, U$z
	call	__mulsf3		#
	mv	a1,a0	# tmp601,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s2	#, tmp345
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp602,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s3	#, tmp277
	call	__divsf3		#
	mv	s2,a0	# tmp349, tmp603
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp349
	mv	a0,s4	#, U$x
	call	__mulsf3		#
	mv	a1,s2	#, tmp349
	mv	s4,a0	# tmp604,
	mv	a0,s9	#, U$y
	call	__mulsf3		#
	mv	a1,s2	#, tmp349
	mv	s3,a0	# tmp605,
	mv	a0,s8	#, U$z
	call	__mulsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s7	#, _41
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	s2,a0	# tmp606,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, N$x
	sw	s10,80(sp)	# N$x, %sfp
	call	__mulsf3		#
	mv	s8,a0	# tmp353, tmp607
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s6	#, _42
	mv	a0,s11	#, N$y
	sw	s11,84(sp)	# N$y, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp608,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, tmp353
	call	__addsf3		#
	mv	s8,a0	# tmp355, tmp609
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s5	#, _43
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	s9,%hi(.LC21)	# tmp359,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	a1,a0	# tmp610,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, tmp355
	call	__addsf3		#
# main_raytrace_termio.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s9)		#,
	lw	s11,156(sp)		# pretmp_498, point.x
	lw	s10,160(sp)		# pretmp_499, point.y
	lw	s8,164(sp)		# pretmp_500, point.z
# main_raytrace_termio.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	blt	a0,zero,.L429	#, tmp611,,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a0,80(sp)		#, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp618,
	lw	a1,%lo(.LC21)(s9)		#,
	lw	a0,84(sp)		#, %sfp
	sw	a5,88(sp)	# tmp618, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp619,
	lw	a1,%lo(.LC21)(s9)		#,
	lw	a0,76(sp)		#, %sfp
	mv	s9,a5	# _73, tmp619
	sw	a5,96(sp)	# _73, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp620,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a0,88(sp)		#, %sfp
	mv	a1,s11	#, pretmp_498
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	sw	a5,92(sp)	# tmp620, %sfp
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	call	__addsf3		#
	mv	a5,a0	# tmp621,
	mv	a1,s10	#, pretmp_499
	mv	a0,s9	#, _73
	sw	a5,12(sp)	# _78, %sfp
	call	__addsf3		#
	mv	s9,a0	# tmp622,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_500
	call	__addsf3		#
	lw	a4,12(sp)		# _78, %sfp
	mv	a5,a0	# _80, tmp623
.L390:
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,80(sp)		#, %sfp
	mv	a1,s4	#, _55
# main_raytrace_termio.c:41:   return V;
	sw	a4,204(sp)	# _78, reflect_orig.x
	sw	a5,212(sp)	# _80, reflect_orig.z
	sw	s9,208(sp)	# _79, reflect_orig.y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s9,a0	# tmp377, tmp624
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,84(sp)		#, %sfp
	mv	a1,s3	#, _56
	call	__mulsf3		#
	mv	a1,a0	# tmp625,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, tmp377
	call	__addsf3		#
	mv	s9,a0	# tmp379, tmp626
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s2	#, _57
	call	__mulsf3		#
	mv	a1,a0	# tmp627,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, tmp379
	call	__addsf3		#
# main_raytrace_termio.c:199:   vec3 refract_orig = vec3_dot(refract_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	blt	a0,zero,.L430	#, tmp628,,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a0,88(sp)		#, %sfp
	mv	a1,s11	#, pretmp_498
	call	__addsf3		#
	mv	a5,a0	# tmp632,
	lw	a0,96(sp)		#, %sfp
	mv	a1,s10	#, pretmp_499
	sw	a5,12(sp)	# _101, %sfp
	call	__addsf3		#
	mv	s9,a0	# tmp633,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_500
	call	__addsf3		#
	lw	t3,12(sp)		# _101, %sfp
	mv	t1,a0	# _103, tmp634
.L393:
# main_raytrace_termio.c:41:   return V;
	sw	t1,224(sp)	# _103, refract_orig.z
# main_raytrace_termio.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	lw	t1,204(sp)		# reflect_orig, reflect_orig
	lw	a6,60(sp)		#, %sfp
	lw	a4,56(sp)		#, %sfp
	sw	t1,128(sp)	# reflect_orig,
	lw	t1,208(sp)		# reflect_orig, reflect_orig
	lw	a3,52(sp)		#, %sfp
	li	a7,1		#,
	sw	t1,132(sp)	# reflect_orig,
	lw	t1,212(sp)		# reflect_orig, reflect_orig
	mv	a5,s0	#, lights
	addi	a2,sp,112	#,,
	addi	a1,sp,128	#, tmp756,
	addi	a0,sp,228	#,,
	sw	s5,188(sp)	# _43, reflect_dir.z
	sw	t1,136(sp)	# reflect_orig,
	sw	s5,120(sp)	# _43,
# main_raytrace_termio.c:41:   return V;
	sw	t3,216(sp)	# _101, refract_orig.x
	sw	s9,220(sp)	# _102, refract_orig.y
# main_raytrace_termio.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	sw	s7,180(sp)	# _41, reflect_dir.x
	sw	s6,184(sp)	# _42, reflect_dir.y
	sw	s7,112(sp)	# _41,
	sw	s6,116(sp)	# _42,
	call	cast_ray		#
# main_raytrace_termio.c:201:   vec3 refract_color = cast_ray(refract_orig, refract_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	lw	t1,216(sp)		# refract_orig, refract_orig
	lw	s5,60(sp)		# nb_lights, %sfp
	lw	a4,56(sp)		#, %sfp
	sw	t1,128(sp)	# refract_orig,
	lw	t1,220(sp)		# refract_orig, refract_orig
	lw	a3,52(sp)		#, %sfp
	li	a7,1		#,
	sw	t1,132(sp)	# refract_orig,
	lw	t1,224(sp)		# refract_orig, refract_orig
	mv	a6,s5	#, nb_lights
	mv	a5,s0	#, lights
	addi	a2,sp,112	#,,
	addi	a1,sp,128	#, tmp757,
	addi	a0,sp,240	#,,
	sw	s4,192(sp)	# _55, refract_dir.x
	sw	s3,196(sp)	# _56, refract_dir.y
	sw	s2,200(sp)	# _57, refract_dir.z
	sw	t1,136(sp)	# refract_orig,
	sw	s4,112(sp)	# _55,
	sw	s3,116(sp)	# _56,
	sw	s2,120(sp)	# _57,
	call	cast_ray		#
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	ble	s5,zero,.L410	#, nb_lights,,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a5,%lo(.LC1)(s1)		# tmp542,
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	sw	zero,12(sp)	#, %sfp
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	li	s4,-2147483648		# tmp543,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	sw	a5,100(sp)	# tmp542, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC15)	# tmp544,
	lw	a6,%lo(.LC15+4)(a5)		#,
	lw	a5,%lo(.LC15)(a5)		# tmp545,
	sw	a6,36(sp)	#, %sfp
	sw	a5,32(sp)	# tmp545, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC16)	# tmp546,
	lw	a6,%lo(.LC16+4)(a5)		#,
	lw	a5,%lo(.LC16)(a5)		# tmp547,
	sw	a6,44(sp)	#, %sfp
	sw	a5,40(sp)	# tmp547, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	a5,zero	# specular_light_intensity,
	sw	a5,108(sp)	# specular_light_intensity, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	sw	a5,16(sp)	# diffuse_light_intensity, %sfp
	j	.L409		#
.L423:
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a0,88(sp)		#, %sfp
	mv	a1,s11	#, pretmp_498
	call	__addsf3		#
	mv	s6,a0	# tmp663,
	lw	a0,96(sp)		#, %sfp
	mv	a1,s10	#, pretmp_499
	call	__addsf3		#
	mv	s5,a0	# tmp664,
	lw	a0,92(sp)		#, %sfp
	mv	a1,s8	#, pretmp_500
	call	__addsf3		#
	mv	s9,a0	# shadow_orig$z, tmp665
.L397:
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	lw	a3,56(sp)		#, %sfp
	lw	a2,52(sp)		#, %sfp
	addi	a6,sp,348	#, tmp764,
	addi	a5,sp,288	#, tmp765,
	addi	a4,sp,276	#, tmp766,
	addi	a1,sp,112	#,,
	addi	a0,sp,128	#, tmp767,
	sw	s6,264(sp)	# shadow_orig$x, shadow_orig.x
	sw	s5,268(sp)	# shadow_orig$y, shadow_orig.y
	sw	s9,272(sp)	# shadow_orig$z, shadow_orig.z
	sw	s3,252(sp)	# _127, light_dir.x
	sw	s2,256(sp)	# _128, light_dir.y
	sw	s1,260(sp)	# _129, light_dir.z
	sw	s6,128(sp)	# shadow_orig$x,
	sw	s5,132(sp)	# shadow_orig$y,
	sw	s9,136(sp)	# shadow_orig$z,
	sw	s3,112(sp)	# _127,
	sw	s2,116(sp)	# _128,
	sw	s1,120(sp)	# _129,
	call	scene_intersect		#
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	bne	a0,zero,.L431	#, tmp666,,
.L398:
	lw	a4,168(sp)		# V$x, N.x
	lw	s5,172(sp)		# V$y, N.y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, _127
	mv	a1,a4	#, V$x
	sw	a4,48(sp)	# V$x, %sfp
	sw	s5,24(sp)	# V$y, %sfp
	call	__mulsf3		#
	lw	s9,176(sp)		# V$z, N.z
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, V$y
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s6,a0	# tmp676,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, _128
	call	__mulsf3		#
	mv	s7,a0	# tmp677,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s9	#, V$z
	mv	a0,s1	#, _129
	call	__mulsf3		#
	mv	s5,a0	# _182, tmp678
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s7	#, _180
	mv	a0,s6	#, _179
	call	__addsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, _182
	call	__addsf3		#
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	sw	a0,28(sp)	# _183, %sfp
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a5,12(s0)		# _175, MEM[(float *)_292 + 12B]
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lw	a4,48(sp)		# V$x, %sfp
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	sw	a5,20(sp)	# _175, %sfp
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lw	a5,28(sp)		# _183, %sfp
	bge	a0,zero,.L400	#, tmp680,,
	mv	a5,zero	# _183,
.L400:
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a0,20(sp)		#, %sfp
	mv	a1,a5	#, _183
	sw	a4,28(sp)	# V$x, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp681,
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	a0,16(sp)		#, %sfp
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	s3,s4,s3	# _127, tmp473, tmp543
	xor	s2,s4,s2	# _128, tmp480, tmp543
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	call	__addsf3		#
	mv	a5,a0	# tmp682,
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	a1,s7	#, _180
	xor	a0,s4,s6	# _179,, tmp543
# main_raytrace_termio.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	sw	a5,16(sp)	# tmp682, %sfp
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__subsf3		#
	mv	a1,s5	#, _182
	call	__subsf3		#
	mv	a1,a0	# tmp683,
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a4,28(sp)		# V$x, %sfp
# main_raytrace_termio.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s5,a0	# tmp472, tmp684
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp472
	mv	a0,a4	#, V$x
	call	__mulsf3		#
	mv	a1,a0	# tmp685,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s3	#, tmp473
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,72(sp)		#, %sfp
	xor	a0,s4,a0	# tmp686,, tmp543
# main_raytrace_termio.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	s1,s4,s1	# _129, tmp488, tmp543
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s3,a0	# tmp687,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a0,24(sp)		#, %sfp
	mv	a1,s5	#, tmp472
	call	__mulsf3		#
	mv	a1,a0	# tmp688,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s2	#, tmp480
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,64(sp)		#, %sfp
	xor	a0,s4,a0	# tmp689,, tmp543
	call	__mulsf3		#
	mv	a1,a0	# tmp690,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s3	#, tmp479
	call	__addsf3		#
	mv	s2,a0	# tmp691,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, tmp472
	mv	a0,s9	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp692,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s1	#, tmp488
	call	__subsf3		#
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,68(sp)		#, %sfp
	xor	a0,s4,a0	# tmp693,, tmp543
	call	__mulsf3		#
	mv	a1,a0	# tmp694,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp487
	call	__addsf3		#
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s3,a0	# _212, tmp695
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
	blt	a0,zero,.L399	#, tmp696,,
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,s3	#, _212
	call	__gtsf2		#
# main_raytrace_termio.c:219:     float def = material.specular_exponent;
	lw	s1,344(sp)		# def, material.specular_exponent
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	ble	a0,zero,.L399	#, tmp697,,
# main_raytrace_termio.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,s1	#, def
	call	__gtsf2		#
	bgt	a0,zero,.L432	#, tmp698,,
.L399:
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,12(sp)		# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a4,60(sp)		# nb_lights, %sfp
	addi	s0,s0,16	#, ivtmp.1123, ivtmp.1123
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	addi	a5,a5,1	#, i, i
	sw	a5,12(sp)	# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	beq	a4,a5,.L394	#, nb_lights, i,
.L409:
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_292]
	mv	a1,s11	#, pretmp_498
	call	__subsf3		#
	mv	s3,a0	# tmp635,
	lw	a0,4(s0)		#, MEM[(float *)_292 + 4B]
	mv	a1,s10	#, pretmp_499
	call	__subsf3		#
	mv	s2,a0	# tmp636,
	lw	a0,8(s0)		#, MEM[(float *)_292 + 8B]
	mv	a1,s8	#, pretmp_500
	call	__subsf3		#
	mv	s1,a0	# tmp637,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s3	#, tmp407
	mv	a0,s3	#, tmp407
	call	__mulsf3		#
	mv	s5,a0	# tmp410, tmp638
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s2	#, tmp408
	mv	a0,s2	#, tmp408
	call	__mulsf3		#
	mv	a1,a0	# tmp639,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp410
	call	__addsf3		#
	mv	s5,a0	# tmp412, tmp640
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s1	#, tmp409
	mv	a0,s1	#, tmp409
	call	__mulsf3		#
	mv	a1,a0	# tmp641,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp412
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp642,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a0,100(sp)		#, %sfp
	call	__divsf3		#
	mv	s5,a0	# tmp416, tmp643
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp416
	mv	a0,s3	#, tmp407
	call	__mulsf3		#
	mv	a1,s5	#, tmp416
	mv	s3,a0	# tmp644,
	mv	a0,s2	#, tmp408
	call	__mulsf3		#
	mv	a1,s5	#, tmp416
	mv	s2,a0	# tmp645,
	mv	a0,s1	#, tmp409
	call	__mulsf3		#
	mv	s1,a0	# tmp646,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_292]
	mv	a1,s11	#, pretmp_498
	call	__subsf3		#
	mv	s5,a0	# tmp647,
	lw	a0,4(s0)		#, MEM[(float *)_292 + 4B]
	mv	a1,s10	#, pretmp_499
	call	__subsf3		#
	mv	s7,a0	# tmp648,
	lw	a0,8(s0)		#, MEM[(float *)_292 + 8B]
	mv	a1,s8	#, pretmp_500
	call	__subsf3		#
	mv	s6,a0	# tmp649,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp420
	mv	a0,s5	#, tmp11
	call	__mulsf3		#
	mv	s5,a0	# tmp423, tmp650
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s7	#, tmp421
	mv	a0,s7	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp651,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp423
	call	__addsf3		#
	mv	s5,a0	# tmp425, tmp652
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp422
	mv	a0,s6	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp653,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp425
	call	__addsf3		#
	call	sqrtf		#
	mv	s7,a0	# tmp654,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,80(sp)		#, %sfp
	mv	a1,s3	#, _127
	call	__mulsf3		#
	mv	s5,a0	# tmp428, tmp655
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,84(sp)		#, %sfp
	mv	a1,s2	#, _128
	call	__mulsf3		#
	mv	a1,a0	# tmp656,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp428
	call	__addsf3		#
	mv	s5,a0	# tmp430, tmp657
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,76(sp)		#, %sfp
	mv	a1,s1	#, _129
	call	__mulsf3		#
	mv	a1,a0	# tmp658,
# main_raytrace_termio.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp430
	call	__addsf3		#
# main_raytrace_termio.c:208:     vec3 shadow_orig = vec3_dot(light_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	bge	a0,zero,.L423	#, tmp659,,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
	mv	a0,s11	#, pretmp_498
	call	__subsf3		#
	lw	a1,96(sp)		#, %sfp
	mv	s6,a0	# tmp660,
	mv	a0,s10	#, pretmp_499
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s5,a0	# tmp661,
	mv	a0,s8	#, pretmp_500
	call	__subsf3		#
	mv	s9,a0	# shadow_orig$z, tmp662
	j	.L397		#
.L429:
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a0,80(sp)		#, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp612,
	lw	a1,%lo(.LC21)(s9)		#,
	lw	a0,84(sp)		#, %sfp
	sw	a5,88(sp)	# tmp612, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp613,
	lw	a1,%lo(.LC21)(s9)		#,
	lw	a0,76(sp)		#, %sfp
	mv	s9,a5	# _73, tmp613
	sw	a5,96(sp)	# _73, %sfp
	call	__mulsf3		#
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a5,a0	# tmp614,
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s11	#, pretmp_498
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	sw	a5,92(sp)	# tmp614, %sfp
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	call	__subsf3		#
	mv	a5,a0	# tmp615,
	mv	a1,s9	#, _73
	mv	a0,s10	#, pretmp_499
	sw	a5,12(sp)	# _78, %sfp
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s9,a0	# tmp616,
	mv	a0,s8	#, pretmp_500
	call	__subsf3		#
	lw	a4,12(sp)		# _78, %sfp
	mv	a5,a0	# _80, tmp617
	j	.L390		#
.L431:
	lw	a0,276(sp)		#, shadow_pt.x
	mv	a1,s6	#, shadow_orig$x
	call	__subsf3		#
	mv	a5,a0	# tmp667,
	lw	a0,280(sp)		#, shadow_pt.y
	mv	a1,s5	#, shadow_orig$y
	mv	s5,a5	# tmp451, tmp667
	call	__subsf3		#
	mv	a5,a0	# tmp668,
	lw	a0,284(sp)		#, shadow_pt.z
	mv	a1,s9	#, shadow_orig$z
	mv	s9,a5	# tmp452, tmp668
	call	__subsf3		#
	mv	s6,a0	# tmp669,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp451
	mv	a0,s5	#, tmp11
	call	__mulsf3		#
	mv	s5,a0	# tmp454, tmp670
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s9	#, tmp452
	mv	a0,s9	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp671,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp454
	call	__addsf3		#
	mv	s5,a0	# tmp456, tmp672
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s6	#, tmp453
	mv	a0,s6	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp673,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s5	#, tmp456
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp674,
# main_raytrace_termio.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	mv	a0,s7	#, _141
	call	__gtsf2		#
	ble	a0,zero,.L398	#, tmp675,,
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,12(sp)		# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a4,60(sp)		# nb_lights, %sfp
	addi	s0,s0,16	#, ivtmp.1123, ivtmp.1123
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	addi	a5,a5,1	#, i, i
	sw	a5,12(sp)	# i, %sfp
# main_raytrace_termio.c:204:   for (int i=0; i<nb_lights; i++) {
	bne	a4,a5,.L409	#, nb_lights, i,
.L394:
# main_raytrace_termio.c:224:   vec3 alu_rslt = vec3_scale(diffuse_light_intensity * material.albedo.x, material.diffuse_color);
	lw	a1,316(sp)		#, material.albedo.x
	lw	a0,16(sp)		#, %sfp
	call	__mulsf3		#
	mv	s3,a0	# tmp707,
# main_raytrace_termio.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	lw	a1,320(sp)		#, material.albedo.y
	lw	a0,108(sp)		#, %sfp
	call	__mulsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,332(sp)		#, material.diffuse_color.x
# main_raytrace_termio.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	mv	s0,a0	# tmp513, tmp708
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp512
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp513
	call	__addsf3		#
# main_raytrace_termio.c:226:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.z, reflect_color));
	lw	s5,324(sp)		# _246, material.albedo.z
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,228(sp)		#, reflect_color.x
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp515, tmp709
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _246
	call	__mulsf3		#
	mv	a1,a0	# tmp710,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp515
	call	__addsf3		#
# main_raytrace_termio.c:227:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.w, refract_color));
	lw	s4,328(sp)		# _256, material.albedo.w
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,240(sp)		#, refract_color.x
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp517, tmp711
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _256
	call	__mulsf3		#
	mv	a1,a0	# tmp712,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp517
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,336(sp)		#, material.diffuse_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp713,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp512
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp513
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,232(sp)		#, reflect_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp521, tmp714
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _246
	call	__mulsf3		#
	mv	a1,a0	# tmp715,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp521
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,244(sp)		#, refract_color.y
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp523, tmp716
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _256
	call	__mulsf3		#
	mv	a1,a0	# tmp717,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s1	#, tmp523
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,340(sp)		#, material.diffuse_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# tmp718,
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp512
	call	__mulsf3		#
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp513
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,236(sp)		#, reflect_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp527, tmp719
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _246
	call	__mulsf3		#
	mv	a1,a0	# tmp720,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp527
	call	__addsf3		#
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,248(sp)		#, refract_color.z
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp529, tmp721
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _256
	call	__mulsf3		#
	mv	a1,a0	# tmp722,
# main_raytrace_termio.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp529
	call	__addsf3		#
# main_raytrace_termio.c:228:   return alu_rslt;
	j	.L387		#
.L432:
# main_raytrace_termio.c:170:   int Y = (int)y;
	mv	a0,s1	#, def
	call	__fixsfsi		#
	mv	s2,a0	# Y, tmp699
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s1,s3	# alu_rslt, _212
# main_raytrace_termio.c:171:   while(Y > 2) {
	li	s5,2		# tmp507,
# main_raytrace_termio.c:171:   while(Y > 2) {
	j	.L404		#
.L406:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	call	__mulsf3		#
	mv	s1,a0	# alu_rslt, tmp700
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__extendsfdf2		#
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lw	a2,32(sp)		#, %sfp
	lw	a3,36(sp)		#, %sfp
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	s7,a0	# _220, tmp726
	mv	s6,a1	# _220, tmp727
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__ltdf2		#
	mv	a5,a0	# tmp702,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lw	a2,40(sp)		#, %sfp
	lw	a3,44(sp)		#, %sfp
	mv	a0,s7	# tmp728, _220
	mv	a1,s6	#, _220
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	srai	s2,s2,1	#, Y, Y
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	blt	a5,zero,.L405	#, tmp702,,
# main_raytrace_termio.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__gtdf2		#
	bgt	a0,zero,.L405	#, tmp703,,
.L404:
# main_raytrace_termio.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	mv	a1,s1	#, alu_rslt
	mv	a0,s1	#, tmp11
# main_raytrace_termio.c:171:   while(Y > 2) {
	bgt	s2,s5,.L406	#, Y, tmp507,
# main_raytrace_termio.c:177:   while(Y > 1) {
	bne	s2,s5,.L405	#, Y, tmp507,
# main_raytrace_termio.c:178:     Y--; alu_rslt *= x;
	mv	a0,s1	#, alu_rslt
	mv	a1,s3	#, _212
	call	__mulsf3		#
	mv	s1,a0	# alu_rslt, tmp704
.L405:
# main_raytrace_termio.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	lw	a0,20(sp)		#, %sfp
	mv	a1,s1	#, alu_rslt
	call	__mulsf3		#
	mv	a1,a0	# tmp705,
# main_raytrace_termio.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	lw	a0,108(sp)		#, %sfp
	call	__addsf3		#
	sw	a0,108(sp)	# tmp706, %sfp
	j	.L399		#
.L430:
# main_raytrace_termio.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,88(sp)		#, %sfp
	mv	a0,s11	#, pretmp_498
	call	__subsf3		#
	lw	a1,96(sp)		#, %sfp
	mv	a5,a0	# tmp629,
	mv	a0,s10	#, pretmp_499
	sw	a5,12(sp)	# _101, %sfp
	call	__subsf3		#
	lw	a1,92(sp)		#, %sfp
	mv	s9,a0	# tmp630,
	mv	a0,s8	#, pretmp_500
	call	__subsf3		#
	lw	t3,12(sp)		# _101, %sfp
	mv	t1,a0	# _103, tmp631
	j	.L393		#
.L410:
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	a5,zero	# specular_light_intensity,
	sw	a5,108(sp)	# specular_light_intensity, %sfp
# main_raytrace_termio.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	sw	a5,16(sp)	# diffuse_light_intensity, %sfp
	j	.L394		#
	.size	cast_ray.constprop.0, .-cast_ray.constprop.0
	.section	.rodata.str1.4
	.align	2
.LC22:
	.string	"rdcycle       :"
	.align	2
.LC23:
	.string	"rdinstret     :"
	.text
	.align	2
	.globl	show_csr_timer_cnt
	.type	show_csr_timer_cnt, @function
show_csr_timer_cnt:
	addi	sp,sp,-48	#,,
# main_raytrace_termio.c:267:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 267 "main_raytrace_termio.c" 1
	rdcycleh a5	# tmp114
# 0 "" 2
 #NO_APP
	sw	a5,12(sp)	# tmp114, tmph0
# main_raytrace_termio.c:268:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 268 "main_raytrace_termio.c" 1
	rdcycle  a5	# tmp115
# 0 "" 2
 #NO_APP
	sw	a5,16(sp)	# tmp115, tmpl0
# main_raytrace_termio.c:270:   asm volatile ("rdinstreth %0" : "=r"(tmph1));
 #APP
# 270 "main_raytrace_termio.c" 1
	rdinstreth a5	# tmp116
# 0 "" 2
 #NO_APP
	sw	a5,20(sp)	# tmp116, tmph1
# main_raytrace_termio.c:271:   asm volatile ("rdinstret %0"  : "=r"(tmpl1));
 #APP
# 271 "main_raytrace_termio.c" 1
	rdinstret a5	# tmp117
# 0 "" 2
 #NO_APP
	sw	a5,24(sp)	# tmp117, tmpl1
# main_raytrace_termio.c:273:   uint64_t rdcycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	t5,12(sp)		# tmph0.50_1, tmph0
# main_raytrace_termio.c:273:   uint64_t rdcycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a0,16(sp)		# rdcycles, tmpl0
# main_raytrace_termio.c:274:   uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;
	lw	a1,20(sp)		# tmph1.52_6, tmph1
# main_raytrace_termio.c:274:   uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;
	lw	a3,24(sp)		# rdinstret, tmpl1
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp134,
.L434:
	lw	a5,0(a4)		# _57, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L434	#, _57,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,10		# tmp136,
	lui	a2,%hi(.LC22)	# tmp112,
	sw	a5,0(a4)	# tmp136, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	li	a6,114		# _46,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	addi	a2,a2,%lo(.LC22)	# p, tmp112,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp137,
.L435:
	lw	a5,0(a4)		# _52, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L435	#, _52,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a2,a2,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a6,0(a4)	# _46, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a6,0(a2)	# _46, MEM[(char *)p_54]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a6,zero,.L435	#, _46,,
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	t3,-858992640		# tmp522,
# kianv_stdlib.h:150:   char *p = buffer;
	addi	a2,sp,28	#, tmp512,
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	t1,268435456		# tmp519,
	addi	a7,t3,-819	#, tmp523, tmp522
# kianv_stdlib.h:150:   char *p = buffer;
	mv	a6,a2	# p, tmp512
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	t1,t1,-1	#, tmp520, tmp519
	li	t4,5		# tmp521,
	addi	t3,t3,-820	#, tmp524, tmp522
	j	.L437		#
.L438:
	remu	a5,a5,t4	# tmp521, tmp155, tmp152
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	a6,a6,1	#, p, p
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sub	a5,a0,a5	# tmp426, rdcycles, tmp155
	sgtu	a4,a5,a0	# tmp159, tmp426, rdcycles
	sub	a4,t5,a4	# tmp161, rdcycles, tmp159
	mul	t6,a5,t3	# tmp165, tmp426, tmp524
	mul	a4,a4,a7	# tmp162, tmp161, tmp523
	mulhu	t5,a5,a7	# tmp429, tmp426, tmp523
	add	a4,a4,t6	# tmp165, tmp168, tmp162
	mul	a5,a5,a7	# tmp172, tmp426, tmp523
	add	a4,a4,t5	# tmp429, tmp173, tmp168
	slli	t6,a4,31	#, tmp191, tmp173
# kianv_stdlib.h:153:     val = val / 10;
	srli	t5,a4,1	#, rdcycles, tmp173
# kianv_stdlib.h:152:     *(p++) = val % 10;
	srli	a5,a5,1	#, tmp436, tmp172
	or	a5,t6,a5	# tmp436, tmp436, tmp191
	slli	a4,a5,2	#, tmp440, tmp436
	add	a4,a4,a5	# tmp436, tmp442, tmp440
	slli	a4,a4,1	#, tmp444, tmp442
	sub	a4,a0,a4	# tmp446, rdcycles, tmp444
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sb	a4,-1(a6)	# tmp446, MEM[(char *)p_42 + 4294967295B]
# kianv_stdlib.h:153:     val = val / 10;
	mv	a0,a5	# rdcycles, tmp436
.L437:
# kianv_stdlib.h:152:     *(p++) = val % 10;
	slli	a5,t5,4	#, tmp146, rdcycles
	srli	a4,a0,28	#, tmp420, rdcycles
	or	a4,a5,a4	# tmp420, tmp420, tmp146
	and	a4,a4,t1	# tmp520, tmp147, tmp420
	and	a5,a0,t1	# tmp520, tmp142, rdcycles
	add	a5,a5,a4	# tmp147, tmp150, tmp142
	srli	t6,t5,24	#, tmp422, rdcycles
# kianv_stdlib.h:151:   while (val || p == buffer) {
	or	a4,a0,t5	# rdcycles, rdcycles, rdcycles
# kianv_stdlib.h:152:     *(p++) = val % 10;
	add	a5,a5,t6	# tmp422, tmp152, tmp150
# kianv_stdlib.h:151:   while (val || p == buffer) {
	bne	a4,zero,.L438	#, rdcycles,,
	beq	a6,a2,.L438	#, p, tmp512,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp260,
.L439:
	lw	a5,0(a4)		# _45, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L439	#, _45,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a6)	# MEM[(char *)p_47], MEM[(char *)p_47]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a6,a6,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _51, MEM[(char *)p_47]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _51, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	a6,a2,.L439	#, p, tmp512,
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp264,
.L441:
	lw	a5,0(a4)		# _38, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L441	#, _38,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,10		# tmp266,
	lui	a0,%hi(.LC23)	# tmp113,
	sw	a5,0(a4)	# tmp266, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	li	a6,114		# _27,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	addi	a0,a0,%lo(.LC23)	# p, tmp113,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp267,
.L442:
	lw	a5,0(a4)		# _33, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L442	#, _33,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a6,0(a4)	# _27, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a6,0(a0)	# _27, MEM[(char *)p_35]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a6,zero,.L442	#, _27,,
# kianv_stdlib.h:152:     *(p++) = val % 10;
	li	t1,-858992640		# tmp516,
	li	a7,268435456		# tmp513,
	addi	a6,t1,-819	#, tmp517, tmp516
# kianv_stdlib.h:150:   char *p = buffer;
	mv	a0,a2	# p, tmp512
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	a7,a7,-1	#, tmp514, tmp513
	li	t3,5		# tmp515,
	addi	t1,t1,-820	#, tmp518, tmp516
	j	.L444		#
.L445:
	remu	a5,a5,t3	# tmp515, tmp285, tmp282
# kianv_stdlib.h:152:     *(p++) = val % 10;
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sub	a5,a3,a5	# tmp472, rdinstret, tmp285
	sgtu	a4,a5,a3	# tmp289, tmp472, rdinstret
	sub	a4,a1,a4	# tmp291, rdinstret, tmp289
	mul	t4,a5,t1	# tmp295, tmp472, tmp518
	mul	a4,a4,a6	# tmp292, tmp291, tmp517
	mulhu	a1,a5,a6	# tmp475, tmp472, tmp517
	add	a4,a4,t4	# tmp295, tmp298, tmp292
	mul	a5,a5,a6	# tmp302, tmp472, tmp517
	add	a4,a4,a1	# tmp475, tmp303, tmp298
	slli	t4,a4,31	#, tmp321, tmp303
# kianv_stdlib.h:153:     val = val / 10;
	srli	a1,a4,1	#, rdinstret, tmp303
# kianv_stdlib.h:152:     *(p++) = val % 10;
	srli	a5,a5,1	#, tmp482, tmp302
	or	a5,t4,a5	# tmp482, tmp482, tmp321
	slli	a4,a5,2	#, tmp486, tmp482
	add	a4,a4,a5	# tmp482, tmp488, tmp486
	slli	a4,a4,1	#, tmp490, tmp488
	sub	a4,a3,a4	# tmp492, rdinstret, tmp490
# kianv_stdlib.h:152:     *(p++) = val % 10;
	sb	a4,-1(a0)	# tmp492, MEM[(char *)p_23 + 4294967295B]
# kianv_stdlib.h:153:     val = val / 10;
	mv	a3,a5	# rdinstret, tmp482
.L444:
# kianv_stdlib.h:152:     *(p++) = val % 10;
	slli	a5,a1,4	#, tmp276, rdinstret
	srli	a4,a3,28	#, tmp466, rdinstret
	or	a4,a5,a4	# tmp466, tmp466, tmp276
	and	a4,a4,a7	# tmp514, tmp277, tmp466
	and	a5,a3,a7	# tmp514, tmp272, rdinstret
	add	a5,a5,a4	# tmp277, tmp280, tmp272
	srli	t4,a1,24	#, tmp468, rdinstret
# kianv_stdlib.h:151:   while (val || p == buffer) {
	or	a4,a3,a1	# rdinstret, rdinstret, rdinstret
# kianv_stdlib.h:152:     *(p++) = val % 10;
	add	a5,a5,t4	# tmp468, tmp282, tmp280
# kianv_stdlib.h:151:   while (val || p == buffer) {
	bne	a4,zero,.L445	#, rdinstret,,
	beq	a0,a2,.L445	#, p, tmp512,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp390,
.L446:
	lw	a5,0(a4)		# _26, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L446	#, _26,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a0)	# MEM[(char *)p_28], MEM[(char *)p_28]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a0,a0,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _32, MEM[(char *)p_28]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _32, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	a0,a2,.L446	#, p, tmp512,
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp394,
.L448:
	lw	a5,0(a4)		# _19, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L448	#, _19,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,10		# tmp396,
	sw	a5,0(a4)	# tmp396, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp397,
.L449:
	lw	a5,0(a4)		# _18, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L449	#, _18,,
# kianv_stdlib.h:112:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,10		# tmp399,
	sw	a5,0(a4)	# tmp399, MEM[(volatile uint32_t *)805306368B]
# main_raytrace_termio.c:284: }
	addi	sp,sp,48	#,,
	jr	ra		#
	.size	show_csr_timer_cnt, .-show_csr_timer_cnt
	.globl	__floatsidf
	.globl	__subdf3
	.globl	__divdf3
	.globl	__fixunssfsi
	.section	.rodata.str1.4
	.align	2
.LC28:
	.string	"\033[48;2;0;0;0m"
	.align	2
.LC29:
	.string	"\n"
	.align	2
.LC31:
	.string	"\033[48;2;%d;%d;%dm "
	.text
	.align	2
	.globl	render
	.type	render, @function
render:
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lui	a5,%hi(.LC9)	# tmp179,
	lw	a6,%lo(.LC9+4)(a5)		#,
	lw	a5,%lo(.LC9)(a5)		# tmp197,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	addi	sp,sp,-192	#,,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	sw	a6,4(sp)	#, %sfp
	sw	a5,0(sp)	# tmp197, %sfp
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lui	a5,%hi(.LC30)	# tmp182,
	lw	a6,%lo(.LC30+4)(a5)		#,
	lw	a5,%lo(.LC30)(a5)		# tmp198,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s2,176(sp)	#,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	sw	a6,44(sp)	#, %sfp
	sw	a5,40(sp)	# tmp198, %sfp
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lui	a5,%hi(.LC24)	# tmp186,
	lw	a6,%lo(.LC24+4)(a5)		#,
	lw	a5,%lo(.LC24)(a5)		# tmp191,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s7,156(sp)	#,
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	sw	a6,20(sp)	#, %sfp
	sw	a5,16(sp)	# tmp191, %sfp
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC25)	# tmp187,
	lw	a6,%lo(.LC25+4)(a5)		#,
	lw	a5,%lo(.LC25)(a5)		# tmp119,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s8,152(sp)	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a6,12(sp)	#, %sfp
	sw	a5,8(sp)	# tmp119, %sfp
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC26)	# tmp188,
	lw	a6,%lo(.LC26+4)(a5)		#,
	lw	a5,%lo(.LC26)(a5)		# tmp192,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s9,148(sp)	#,
	sw	s10,144(sp)	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a5,24(sp)	# tmp192, %sfp
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	ra,188(sp)	#,
	sw	s0,184(sp)	#,
	sw	s1,180(sp)	#,
	sw	s3,172(sp)	#,
	sw	s4,168(sp)	#,
	sw	s5,164(sp)	#,
	sw	s6,160(sp)	#,
	sw	s11,140(sp)	#,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lui	a5,%hi(.LC1)	# tmp246,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a6,28(sp)	#, %sfp
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	s2,%lo(.LC1)(a5)		# tmp193,
# main_raytrace_termio.c:287: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	mv	s10,a1	# spheres, tmp202
	mv	s9,a2	# nb_spheres, tmp203
	mv	s8,a3	# lights, tmp204
	mv	s7,a4	# nb_lights, tmp205
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	sw	zero,36(sp)	#, %sfp
.L472:
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lw	a0,36(sp)		#, %sfp
# main_raytrace_termio.c:306:     for (int i = 0; i<HRENDER; i++) {
	li	s0,0		# i,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	call	__floatsidf		#
	lw	a2,0(sp)		#, %sfp
	lw	a3,4(sp)		#, %sfp
	call	__adddf3		#
	mv	a2,a0	# tmp228,
	mv	a3,a1	#,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lw	a0,40(sp)		#, %sfp
	lw	a1,44(sp)		#, %sfp
	call	__subdf3		#
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	call	__truncdfsf2		#
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	a5,%hi(.LC1)	# tmp260,
	lw	s6,%lo(.LC1)(a5)		# tmp160,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	mv	s1,a0	# _70, tmp229
.L477:
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	mv	a0,s0	#, i
	call	__floatsidf		#
	lw	a2,0(sp)		#, %sfp
	lw	a3,4(sp)		#, %sfp
	call	__adddf3		#
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lw	a2,16(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	call	__subdf3		#
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	call	__truncdfsf2		#
	mv	s5,a0	# tmp206,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	a1,12(sp)		#, %sfp
	lw	a0,8(sp)		#, %sfp
	call	tan		#
	mv	a2,a0	# tmp207,
	mv	a3,a1	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	call	__adddf3		#
	mv	a2,a0	# tmp208,
	mv	a3,a1	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	a0,24(sp)		#, %sfp
	lw	a1,28(sp)		#, %sfp
	call	__divdf3		#
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	call	__truncdfsf2		#
# main_raytrace_termio.c:41:   return V;
	mv	a5,zero	# tmp247,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	s3,a0	# tmp209,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, tmp118
	mv	a0,s5	#, tmp118
# main_raytrace_termio.c:41:   return V;
	sw	a5,104(sp)	# tmp247, D.2347.x
	sw	a5,108(sp)	# tmp248, D.2347.y
	sw	a5,112(sp)	# tmp249, D.2347.z
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	call	__mulsf3		#
	mv	s4,a0	# tmp125, tmp210
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s1	#, _70
	mv	a0,s1	#, _70
	call	__mulsf3		#
	mv	a1,a0	# tmp211,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s4	#, tmp125
	call	__addsf3		#
	mv	s4,a0	# tmp127, tmp212
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s3	#, tmp124
	mv	a0,s3	#, tmp124
	call	__mulsf3		#
	mv	a1,a0	# tmp213,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s4	#, tmp127
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp214,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s2	#, tmp193
	call	__divsf3		#
	mv	s4,a0	# tmp131, tmp215
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp131
	mv	a0,s5	#, tmp118
	call	__mulsf3		#
	mv	s5,a0	# tmp216,
	mv	a1,s1	#, _70
	mv	a0,s4	#, tmp131
	call	__mulsf3		#
	mv	a5,a0	# tmp217,
	mv	a1,s4	#, tmp131
	mv	a0,s3	#, tmp124
# main_raytrace_termio.c:41:   return V;
	mv	s3,a5	# tmp200, tmp217
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
# main_raytrace_termio.c:310:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	lw	t1,104(sp)		# D.2347, D.2347
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a7,a0	# tmp218,
# main_raytrace_termio.c:310:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	mv	a6,s7	#, nb_lights
	sw	t1,64(sp)	# D.2347,
	lw	t1,108(sp)		# D.2347, D.2347
	mv	a5,s8	#, lights
	mv	a4,s9	#, nb_spheres
	sw	t1,68(sp)	# D.2347,
	lw	t1,112(sp)		# D.2347, D.2347
	mv	a3,s10	#, spheres
	addi	a2,sp,48	#,,
	addi	a1,sp,64	#, tmp250,
	addi	a0,sp,92	#, tmp251,
	sw	t1,72(sp)	# D.2347,
	sw	s5,48(sp)	# tmp199,
	sw	s3,52(sp)	# tmp200,
	sw	a7,56(sp)	# tmp218,
	call	cast_ray.constprop.0		#
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s4,92(sp)		# _10, C.x
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s2	#, tmp193
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s11,96(sp)		# _11, C.y
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a0,s4	#, _10
	call	__gtsf2		#
	li	s3,255		# prephitmp_86,
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s5,100(sp)		# _12, C.z
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	bgt	a0,zero,.L473	#, tmp219,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s4	#, _10
	call	__ltsf2		#
	li	s3,0		# prephitmp_86,
	bge	a0,zero,.L488	#, tmp220,,
.L473:
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s2	#, tmp193
	mv	a0,s11	#, _11
	call	__gtsf2		#
	li	s4,255		# prephitmp_92,
	bgt	a0,zero,.L474	#, tmp222,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s11	#, _11
	call	__ltsf2		#
	li	s4,0		# prephitmp_92,
	bge	a0,zero,.L489	#, tmp223,,
.L474:
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s6	#, tmp160
	mv	a0,s5	#, _12
	call	__gtsf2		#
	li	a3,255		# prephitmp_74,
	bgt	a0,zero,.L475	#, tmp225,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s5	#, _12
	call	__ltsf2		#
	li	a3,0		# prephitmp_74,
	bge	a0,zero,.L490	#, tmp226,,
.L475:
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	lui	a5,%hi(.LC31)	# tmp261,
	addi	a0,a5,%lo(.LC31)	#, tmp261,
	mv	a2,s4	#, prephitmp_92
	mv	a1,s3	#, prephitmp_86
	call	printf		#
# main_raytrace_termio.c:254:     if(x == HRENDER-1) {
	li	a5,95		# tmp177,
	beq	s0,a5,.L491	#, i, tmp177,
# main_raytrace_termio.c:306:     for (int i = 0; i<HRENDER; i++) {
	addi	s0,s0,1	#, i, i
	j	.L477		#
.L491:
# main_raytrace_termio.c:255:       printf("\033[48;2;0;0;0m");
	lui	a5,%hi(.LC28)	# tmp255,
	addi	a0,a5,%lo(.LC28)	#, tmp255,
	call	printf		#
# main_raytrace_termio.c:256:       printf("\n");
	lui	a5,%hi(.LC29)	# tmp256,
	addi	a0,a5,%lo(.LC29)	#, tmp256,
	call	printf		#
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	lw	a5,36(sp)		# j, %sfp
	addi	a5,a5,1	#, j, j
	mv	a4,a5	# j, j
	sw	a5,36(sp)	# j, %sfp
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	li	a5,64		# tmp170,
	bne	a4,a5,.L472	#, j, tmp170,
# main_raytrace_termio.c:329: }
	lw	ra,188(sp)		#,
	lw	s0,184(sp)		#,
	lw	s1,180(sp)		#,
	lw	s2,176(sp)		#,
	lw	s3,172(sp)		#,
	lw	s4,168(sp)		#,
	lw	s5,164(sp)		#,
	lw	s6,160(sp)		#,
	lw	s7,156(sp)		#,
	lw	s8,152(sp)		#,
	lw	s9,148(sp)		#,
	lw	s10,144(sp)		#,
	lw	s11,140(sp)		#,
	addi	sp,sp,192	#,,
	jr	ra		#
.L488:
# main_raytrace_termio.c:244:   uint8_t R = (uint8_t)(255.0f * r);
	lui	a5,%hi(.LC27)	# tmp252,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s4	#, _10
	call	__mulsf3		#
# main_raytrace_termio.c:244:   uint8_t R = (uint8_t)(255.0f * r);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	s3,a0,0xff	# prephitmp_86, tmp221
	j	.L473		#
.L490:
# main_raytrace_termio.c:246:   uint8_t B = (uint8_t)(255.0f * b);
	lui	a5,%hi(.LC27)	# tmp254,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s5	#, _12
	call	__mulsf3		#
# main_raytrace_termio.c:246:   uint8_t B = (uint8_t)(255.0f * b);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	a3,a0,0xff	# prephitmp_74, tmp227
	j	.L475		#
.L489:
# main_raytrace_termio.c:245:   uint8_t G = (uint8_t)(255.0f * g);
	lui	a5,%hi(.LC27)	# tmp253,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s11	#, _11
	call	__mulsf3		#
# main_raytrace_termio.c:245:   uint8_t G = (uint8_t)(255.0f * g);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	s4,a0,0xff	# prephitmp_92, tmp224
	j	.L474		#
	.size	render, .-render
	.align	2
	.globl	init_scene
	.type	init_scene, @function
init_scene:
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	lui	a5,%hi(.LC1)	# tmp88,
	lw	a4,%lo(.LC1)(a5)		# tmp89,
	lui	a5,%hi(.LC13)	# tmp100,
	lw	a3,%lo(.LC13)(a5)		# tmp101,
	lui	a5,%hi(.LC11)	# tmp96,
	lw	a2,%lo(.LC11)(a5)		# tmp97,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lui	a5,%hi(.LC40)	# tmp138,
	lw	a1,%lo(.LC40)(a5)		# tmp139,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	lui	a5,%hi(.LC34)	# tmp84,
	lw	a0,%lo(.LC34)(a5)		# tmp85,
	lui	a5,%hi(.LC35)	# tmp92,
	lw	t3,%lo(.LC35)(a5)		# tmp93,
	lui	a5,%hi(.LC36)	# tmp106,
	lw	a7,%lo(.LC36)(a5)		# tmp107,
	lui	a5,%hi(.LC37)	# tmp118,
# main_raytrace_termio.c:337: void init_scene() {
	addi	sp,sp,-16	#,,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	lw	a6,%lo(.LC37)(a5)		# tmp119,
	lui	a5,%hi(.LANCHOR0)	# tmp73,
	addi	a5,a5,%lo(.LANCHOR0)	# tmp72, tmp73,
# main_raytrace_termio.c:337: void init_scene() {
	sw	s0,12(sp)	#,
	sw	s1,8(sp)	#,
	sw	s2,4(sp)	#,
	sw	s3,0(sp)	#,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lui	t5,%hi(.LC2)	# tmp122,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	sw	a7,1060(a5)	# tmp107, MEM <float> [(struct  *)&spheres + 36B]
	sw	a7,1064(a5)	# tmp107, MEM <float> [(struct  *)&spheres + 40B]
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lw	a7,%lo(.LC2)(t5)		# tmp123,
	lui	t4,%hi(.LC38)	# tmp126,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	lui	t0,%hi(.LC32)	# tmp74,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	a7,1076(a5)	# tmp123, MEM <float> [(struct  *)&spheres + 52B]
	lw	a7,%lo(.LC38)(t4)		# tmp127,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	lui	t6,%hi(.LC33)	# tmp80,
	lw	t0,%lo(.LC32)(t0)		# tmp75,
	lw	t6,%lo(.LC33)(t6)		# tmp81,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lui	t1,%hi(.LC39)	# tmp130,
	sw	a7,1080(a5)	# tmp127, MEM <float> [(struct  *)&spheres + 56B]
	lw	a7,%lo(.LC39)(t1)		# tmp131,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	mv	s3,zero	# tmp315,
	sw	t0,1024(a5)	# tmp75, MEM <float> [(struct  *)&spheres]
	sw	s3,1028(a5)	# tmp315, MEM <float> [(struct  *)&spheres + 4B]
	sw	t6,1032(a5)	# tmp81, MEM <float> [(struct  *)&spheres + 8B]
	sw	a0,1036(a5)	# tmp85, MEM <float> [(struct  *)&spheres + 12B]
	sw	a4,1040(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 16B]
	sw	t3,1044(a5)	# tmp93, MEM <float> [(struct  *)&spheres + 20B]
	sw	a2,1048(a5)	# tmp97, MEM <float> [(struct  *)&spheres + 24B]
	sw	a3,1052(a5)	# tmp101, MEM <float> [(struct  *)&spheres + 28B]
	sw	s3,1056(a5)	# tmp316, MEM <float> [(struct  *)&spheres + 32B]
	sw	a2,1068(a5)	# tmp97, MEM <float> [(struct  *)&spheres + 44B]
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lui	s1,%hi(.LC18)	# tmp160,
# main_raytrace_termio.c:343:   spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	sw	a6,1072(a5)	# tmp119, MEM <float> [(struct  *)&spheres + 48B]
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	a7,1084(a5)	# tmp131, MEM <float> [(struct  *)&spheres + 60B]
	sw	t3,1112(a5)	# tmp93, MEM <float> [(struct  *)&spheres + 88B]
	lw	t3,%lo(.LC18)(s1)		# tmp161,
	lui	s0,%hi(.LC41)	# tmp168,
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	lui	t2,%hi(.LC42)	# tmp176,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	t3,1116(a5)	# tmp161, MEM <float> [(struct  *)&spheres + 92B]
	lw	t3,%lo(.LC41)(s0)		# tmp169,
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	lui	t0,%hi(.LC44)	# tmp184,
	lui	a7,%hi(.LC43)	# tmp180,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	t3,1124(a5)	# tmp169, MEM <float> [(struct  *)&spheres + 100B]
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	lw	t3,%lo(.LC42)(t2)		# tmp177,
	lw	t1,%lo(.LC43)(a7)		# tmp181,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	a0,1088(a5)	# tmp85, MEM <float> [(struct  *)&spheres + 64B]
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	sw	t3,1132(a5)	# tmp177, MEM <float> [(struct  *)&spheres + 108B]
	lw	t3,%lo(.LC44)(t0)		# tmp185,
	lui	t6,%hi(.LC45)	# tmp192,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lui	s2,%hi(.LC19)	# tmp144,
	lui	a0,%hi(.LC20)	# tmp152,
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	lui	a7,%hi(.LC46)	# tmp216,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lw	a0,%lo(.LC20)(a0)		# tmp153,
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	lw	a7,%lo(.LC46)(a7)		# tmp217,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	lw	s2,%lo(.LC19)(s2)		# tmp145,
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	sw	t3,1140(a5)	# tmp185, MEM <float> [(struct  *)&spheres + 116B]
	lw	t3,%lo(.LC45)(t6)		# tmp193,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	lui	t5,%hi(.LC47)	# tmp220,
	lui	t0,%hi(.LC49)	# tmp264,
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	s3,1096(a5)	# tmp317, MEM <float> [(struct  *)&spheres + 72B]
	sw	s2,1100(a5)	# tmp145, MEM <float> [(struct  *)&spheres + 76B]
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	sw	t1,1136(a5)	# tmp181, MEM <float> [(struct  *)&spheres + 112B]
	sw	a4,1144(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 120B]
	sw	t3,1148(a5)	# tmp193, MEM <float> [(struct  *)&spheres + 124B]
	sw	s3,1156(a5)	# tmp318, MEM <float> [(struct  *)&spheres + 132B]
	sw	s3,1160(a5)	# tmp319, MEM <float> [(struct  *)&spheres + 136B]
	sw	a2,1164(a5)	# tmp97, MEM <float> [(struct  *)&spheres + 140B]
# main_raytrace_termio.c:344:   spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	sw	a1,1092(a5)	# tmp139, MEM <float> [(struct  *)&spheres + 68B]
	sw	a3,1104(a5)	# tmp101, MEM <float> [(struct  *)&spheres + 80B]
	sw	a0,1108(a5)	# tmp153, MEM <float> [(struct  *)&spheres + 84B]
	sw	a0,1120(a5)	# tmp153, MEM <float> [(struct  *)&spheres + 96B]
# main_raytrace_termio.c:345:   spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	sw	a1,1128(a5)	# tmp139, MEM <float> [(struct  *)&spheres + 104B]
	sw	a3,1152(a5)	# tmp101, MEM <float> [(struct  *)&spheres + 128B]
	sw	a3,1168(a5)	# tmp101, MEM <float> [(struct  *)&spheres + 144B]
	sw	a3,1172(a5)	# tmp101, MEM <float> [(struct  *)&spheres + 148B]
	sw	a7,1176(a5)	# tmp217, MEM <float> [(struct  *)&spheres + 152B]
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	lw	a3,%lo(.LC47)(t5)		# tmp221,
	sw	a4,1196(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 172B]
	sw	a4,1216(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 192B]
	sw	a4,1220(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 196B]
	sw	a4,1224(a5)	# tmp89, MEM <float> [(struct  *)&spheres + 200B]
	lw	a4,%lo(.LC49)(t0)		# tmp265,
# main_raytrace_termio.c:348:   lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	lui	t6,%hi(.LC50)	# tmp268,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	lui	t4,%hi(.LC48)	# tmp224,
	sw	a4,1228(a5)	# tmp265, MEM <float> [(struct  *)&spheres + 204B]
# main_raytrace_termio.c:348:   lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	lw	a4,%lo(.LC50)(t6)		# tmp269,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	sw	a3,1180(a5)	# tmp221, MEM <float> [(struct  *)&spheres + 156B]
	lw	a3,%lo(.LC48)(t4)		# tmp225,
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	lui	t5,%hi(.LC53)	# tmp292,
# main_raytrace_termio.c:348:   lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	sw	a4,1232(a5)	# tmp269, lights[0].position.x
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	lw	a4,%lo(.LC53)(t5)		# tmp293,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	sw	a3,1184(a5)	# tmp225, MEM <float> [(struct  *)&spheres + 160B]
# main_raytrace_termio.c:348:   lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	lui	a3,%hi(.LC51)	# tmp272,
	lw	a2,%lo(.LC51)(a3)		# tmp273,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	lui	t2,%hi(.LC5)	# tmp232,
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	lui	a3,%hi(.LC52)	# tmp284,
	lui	t4,%hi(.LC54)	# tmp296,
	lw	a3,%lo(.LC52)(a3)		# tmp285,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	sw	t1,1188(a5)	# tmp181, MEM <float> [(struct  *)&spheres + 164B]
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	sw	a4,1256(a5)	# tmp293, lights[1].position.z
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	lw	t1,%lo(.LC5)(t2)		# tmp233,
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	lw	a4,%lo(.LC54)(t4)		# tmp297,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	sw	s3,1200(a5)	# tmp320, MEM <float> [(struct  *)&spheres + 176B]
	sw	s3,1212(a5)	# tmp321, MEM <float> [(struct  *)&spheres + 188B]
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	sw	a4,1260(a5)	# tmp297, lights[1].intensity
# main_raytrace_termio.c:350:   lights[2] = make_Light(make_vec3( 30, 20,  30), 1.7);
	lui	t3,%hi(.LC55)	# tmp312,
# main_raytrace_termio.c:346:   spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	sw	t1,1192(a5)	# tmp233, MEM <float> [(struct  *)&spheres + 168B]
	sw	a7,1204(a5)	# tmp217, MEM <float> [(struct  *)&spheres + 180B]
	sw	a0,1208(a5)	# tmp153, MEM <float> [(struct  *)&spheres + 184B]
# main_raytrace_termio.c:348:   lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	sw	a2,1236(a5)	# tmp273, lights[0].position.y
	sw	a2,1240(a5)	# tmp273, lights[0].position.z
	sw	a1,1244(a5)	# tmp139, lights[0].intensity
# main_raytrace_termio.c:349:   lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	sw	a3,1248(a5)	# tmp285, lights[1].position.x
	sw	a6,1252(a5)	# tmp119, lights[1].position.y
# main_raytrace_termio.c:350:   lights[2] = make_Light(make_vec3( 30, 20,  30), 1.7);
	sw	a3,1264(a5)	# tmp285, lights[2].position.x
	sw	a2,1268(a5)	# tmp273, lights[2].position.y
	sw	a3,1272(a5)	# tmp285, lights[2].position.z
	lw	a4,%lo(.LC55)(t3)		# tmp313,
# main_raytrace_termio.c:351: }
	lw	s0,12(sp)		#,
	lw	s1,8(sp)		#,
# main_raytrace_termio.c:350:   lights[2] = make_Light(make_vec3( 30, 20,  30), 1.7);
	sw	a4,1276(a5)	# tmp313, lights[2].intensity
# main_raytrace_termio.c:351: }
	lw	s2,4(sp)		#,
	lw	s3,0(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	init_scene, .-init_scene
	.align	2
	.globl	fill_oled
	.type	fill_oled, @function
fill_oled:
# main_raytrace_termio.c:356:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	a6,a0,16	#, _2, tmp84
# main_raytrace_termio.c:356:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a1,805306368		# tmp81,
# main_raytrace_termio.c:354:   for (int y = 0; y < 64; y++) {
	li	a0,0		# y,
# main_raytrace_termio.c:355:     for (int x = 0; x < 96; x++) {
	li	a2,24576		# tmp82,
# main_raytrace_termio.c:354:   for (int y = 0; y < 64; y++) {
	li	a7,64		# tmp83,
.L495:
	or	a3,a0,a6	# _2, _20, y
# main_raytrace_termio.c:353: void fill_oled(int rgb) {
	li	a5,0		# ivtmp.1175,
.L496:
# main_raytrace_termio.c:356:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a4,a5,a3	# _20, _9, ivtmp.1175
# main_raytrace_termio.c:356:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a4,8(a1)	# _9, MEM[(volatile uint32_t *)805306376B]
# main_raytrace_termio.c:355:     for (int x = 0; x < 96; x++) {
	addi	a5,a5,256	#, ivtmp.1175, ivtmp.1175
	bne	a5,a2,.L496	#, ivtmp.1175, tmp82,
# main_raytrace_termio.c:354:   for (int y = 0; y < 64; y++) {
	addi	a0,a0,1	#, y, y
# main_raytrace_termio.c:354:   for (int y = 0; y < 64; y++) {
	bne	a0,a7,.L495	#, y, tmp83,
# main_raytrace_termio.c:359: }
	ret	
	.size	fill_oled, .-fill_oled
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lui	a5,%hi(.LC9)	# tmp263,
	lw	a6,%lo(.LC9+4)(a5)		#,
	lw	a5,%lo(.LC9)(a5)		# tmp280,
# main_raytrace_termio.c:363: void main() {
	addi	sp,sp,-208	#,,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	sw	a6,4(sp)	#, %sfp
	sw	a5,0(sp)	# tmp280, %sfp
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lui	a5,%hi(.LC30)	# tmp251,
	lw	a6,%lo(.LC30+4)(a5)		#,
	lw	a5,%lo(.LC30)(a5)		# tmp281,
# main_raytrace_termio.c:363: void main() {
	sw	s6,176(sp)	#,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	sw	a6,44(sp)	#, %sfp
	sw	a5,40(sp)	# tmp281, %sfp
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lui	a5,%hi(.LC24)	# tmp259,
	lw	a6,%lo(.LC24+4)(a5)		#,
	lw	a5,%lo(.LC24)(a5)		# tmp274,
# main_raytrace_termio.c:363: void main() {
	sw	s10,160(sp)	#,
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	sw	a6,20(sp)	#, %sfp
	sw	a5,16(sp)	# tmp274, %sfp
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC25)	# tmp260,
	lw	a6,%lo(.LC25+4)(a5)		#,
	lw	a5,%lo(.LC25)(a5)		# tmp131,
# main_raytrace_termio.c:363: void main() {
	sw	s11,156(sp)	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a6,12(sp)	#, %sfp
	sw	a5,8(sp)	# tmp131, %sfp
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC26)	# tmp261,
	lw	a6,%lo(.LC26+4)(a5)		#,
	lw	a5,%lo(.LC26)(a5)		# tmp275,
# main_raytrace_termio.c:363: void main() {
	sw	ra,204(sp)	#,
	sw	s0,200(sp)	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a5,24(sp)	# tmp275, %sfp
# main_raytrace_termio.c:363: void main() {
	sw	s1,196(sp)	#,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lui	a5,%hi(.LC1)	# tmp323,
# main_raytrace_termio.c:363: void main() {
	sw	s2,192(sp)	#,
	sw	s3,188(sp)	#,
	sw	s4,184(sp)	#,
	sw	s5,180(sp)	#,
	sw	s7,172(sp)	#,
	sw	s8,168(sp)	#,
	sw	s9,164(sp)	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a6,28(sp)	#, %sfp
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	s6,%lo(.LC1)(a5)		# tmp276,
	lui	a5,%hi(.LANCHOR0+1232)	# tmp271,
	addi	s11,a5,%lo(.LANCHOR0+1232)	# tmp255, tmp271,
	lui	a5,%hi(.LANCHOR0+1024)	# tmp272,
	addi	s10,a5,%lo(.LANCHOR0+1024)	# tmp253, tmp272,
.L508:
# main_raytrace_termio.c:377:     init_scene();
	call	init_scene		#
# main_raytrace_termio.c:378:     render(fb, spheres, nb_spheres, lights, nb_lights);
	lui	a5,%hi(nb_spheres)	# tmp324,
	lw	s8,%lo(nb_spheres)(a5)		# nb_spheres.57_2, nb_spheres
	lui	a5,%hi(nb_lights)	# tmp325,
	lw	s9,%lo(nb_lights)(a5)		# nb_lights.58_3, nb_lights
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	sw	zero,36(sp)	#, %sfp
	j	.L500		#
.L509:
# main_raytrace_termio.c:255:       printf("\033[48;2;0;0;0m");
	lui	a5,%hi(.LC28)	# tmp334,
	addi	a0,a5,%lo(.LC28)	#, tmp334,
	call	printf		#
# main_raytrace_termio.c:256:       printf("\n");
	lui	a5,%hi(.LC29)	# tmp335,
	addi	a0,a5,%lo(.LC29)	#, tmp335,
	call	printf		#
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	lw	a5,36(sp)		# j, %sfp
	addi	a5,a5,1	#, j, j
	mv	a4,a5	# j, j
	sw	a5,36(sp)	# j, %sfp
# main_raytrace_termio.c:294:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	li	a5,64		# tmp188,
	beq	a4,a5,.L504	#, j, tmp188,
.L500:
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lw	a0,36(sp)		#, %sfp
# main_raytrace_termio.c:306:     for (int i = 0; i<HRENDER; i++) {
	li	s4,0		# i,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	call	__floatsidf		#
	lw	a2,0(sp)		#, %sfp
	lw	a3,4(sp)		#, %sfp
	call	__adddf3		#
	mv	a2,a0	# tmp307,
	mv	a3,a1	#,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lw	a0,40(sp)		#, %sfp
	lw	a1,44(sp)		#, %sfp
	call	__subdf3		#
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	call	__truncdfsf2		#
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	a5,%hi(.LC1)	# tmp339,
	lw	s7,%lo(.LC1)(a5)		# tmp178,
# main_raytrace_termio.c:308:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	mv	s5,a0	# _7, tmp308
.L505:
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	mv	a0,s4	#, i
	call	__floatsidf		#
	lw	a2,0(sp)		#, %sfp
	lw	a3,4(sp)		#, %sfp
	call	__adddf3		#
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lw	a2,16(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	call	__subdf3		#
# main_raytrace_termio.c:307:       float dir_x =  (i + 0.5) - HRENDER/2.;
	call	__truncdfsf2		#
	mv	s2,a0	# tmp285,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	a1,12(sp)		#, %sfp
	lw	a0,8(sp)		#, %sfp
	call	tan		#
	mv	a2,a0	# tmp286,
	mv	a3,a1	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	call	__adddf3		#
	mv	a2,a0	# tmp287,
	mv	a3,a1	#,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	a0,24(sp)		#, %sfp
	lw	a1,28(sp)		#, %sfp
	call	__divdf3		#
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	call	__truncdfsf2		#
# main_raytrace_termio.c:41:   return V;
	mv	a5,zero	# tmp326,
# main_raytrace_termio.c:309:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	s0,a0	# tmp288,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s2	#, tmp130
	mv	a0,s2	#, tmp130
# main_raytrace_termio.c:41:   return V;
	sw	a5,132(sp)	# tmp326, D.4336.x
	sw	a5,136(sp)	# tmp327, D.4336.y
	sw	a5,140(sp)	# tmp328, D.4336.z
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	call	__mulsf3		#
	mv	s1,a0	# tmp137, tmp289
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s5	#, _7
	mv	a0,s5	#, _7
	call	__mulsf3		#
	mv	a1,a0	# tmp290,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s1	#, tmp137
	call	__addsf3		#
	mv	s1,a0	# tmp139, tmp291
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s0	#, tmp136
	mv	a0,s0	#, tmp136
	call	__mulsf3		#
	mv	a1,a0	# tmp292,
# main_raytrace_termio.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s1	#, tmp139
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp293,
# main_raytrace_termio.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	a0,s6	#, tmp276
	call	__divsf3		#
	mv	s1,a0	# tmp143, tmp294
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp143
	mv	a0,s2	#, tmp130
	call	__mulsf3		#
	mv	a5,a0	# tmp144, tmp295
	mv	a1,s1	#, tmp143
	mv	a0,s5	#, _7
# main_raytrace_termio.c:41:   return V;
	mv	s2,a5	# tmp282, tmp144
	sw	a5,120(sp)	# tmp144, D.4335.x
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a5,a0	# tmp145, tmp296
	mv	a1,s1	#, tmp143
	mv	a0,s0	#, tmp136
# main_raytrace_termio.c:41:   return V;
	sw	a5,124(sp)	# tmp145, D.4335.y
	mv	s0,a5	# tmp283, tmp145
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
# main_raytrace_termio.c:310:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	lw	t1,132(sp)		# D.4336, D.4336
# main_raytrace_termio.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a7,a0	# tmp146, tmp297
# main_raytrace_termio.c:310:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	mv	a6,s9	#, nb_lights.58_3
	sw	t1,64(sp)	# D.4336,
	lw	t1,136(sp)		# D.4336, D.4336
	mv	a5,s11	#, tmp255
	mv	a4,s8	#, nb_spheres.57_2
	sw	t1,68(sp)	# D.4336,
	lw	t1,140(sp)		# D.4336, D.4336
	mv	a3,s10	#, tmp253
	addi	a2,sp,48	#,,
	addi	a1,sp,64	#, tmp329,
	addi	a0,sp,108	#, tmp330,
# main_raytrace_termio.c:41:   return V;
	sw	a7,128(sp)	# tmp146, D.4335.z
# main_raytrace_termio.c:310:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	sw	t1,72(sp)	# D.4336,
	sw	s2,48(sp)	# tmp282,
	sw	s0,52(sp)	# tmp283,
	sw	a7,56(sp)	# tmp146,
	call	cast_ray.constprop.0		#
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s1,108(sp)		# _50, C.x
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s6	#, tmp276
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s3,112(sp)		# _51, C.y
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a0,s1	#, _50
	call	__gtsf2		#
	li	s0,255		# prephitmp_103,
# main_raytrace_termio.c:311:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	s2,116(sp)		# _52, C.z
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	bgt	a0,zero,.L501	#, tmp298,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s1	#, _50
	call	__ltsf2		#
	li	s0,0		# prephitmp_103,
	bge	a0,zero,.L521	#, tmp299,,
.L501:
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s6	#, tmp276
	mv	a0,s3	#, _51
	call	__gtsf2		#
	li	s1,255		# prephitmp_109,
	bgt	a0,zero,.L502	#, tmp301,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s3	#, _51
	call	__ltsf2		#
	li	s1,0		# prephitmp_109,
	bge	a0,zero,.L522	#, tmp302,,
.L502:
# main_raytrace_termio.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s7	#, tmp178
	mv	a0,s2	#, _52
	call	__gtsf2		#
	li	a3,255		# prephitmp_91,
	bgt	a0,zero,.L503	#, tmp304,,
# main_raytrace_termio.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s2	#, _52
	call	__ltsf2		#
	li	a3,0		# prephitmp_91,
	bge	a0,zero,.L523	#, tmp305,,
.L503:
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	lui	a5,%hi(.LC31)	# tmp340,
	addi	a0,a5,%lo(.LC31)	#, tmp340,
	mv	a2,s1	#, prephitmp_109
	mv	a1,s0	#, prephitmp_103
	call	printf		#
# main_raytrace_termio.c:254:     if(x == HRENDER-1) {
	li	a5,95		# tmp227,
	beq	s4,a5,.L509	#, i, tmp227,
# main_raytrace_termio.c:306:     for (int i = 0; i<HRENDER; i++) {
	addi	s4,s4,1	#, i, i
	j	.L505		#
.L504:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a5	# tmp194
# 0 "" 2
 #NO_APP
	sw	a5,100(sp)	# tmp194, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a5	# tmp195
# 0 "" 2
 #NO_APP
	sw	a5,104(sp)	# tmp195, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a4,100(sp)		# tmph0.0_8, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,104(sp)		# tmpl0.1_11, tmpl0
# kianv_stdlib.h:80:   uint64_t lim = get_cycles() + wait;
	li	a5,199999488		# tmp250,
	addi	a5,a5,512	#, tmp236, tmp250
	add	a5,a3,a5	# tmp236, tmp238, tmpl0.1_11
	sltu	a3,a5,a3	# tmpl0.1_11, tmp202, tmp238
	add	a4,a4,a3	# tmp202, tmp241, tmph0.0_8
.L518:
# kianv_stdlib.h:68:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 68 "kianv_stdlib.h" 1
	rdcycleh a3	# tmp210
# 0 "" 2
 #NO_APP
	sw	a3,92(sp)	# tmp210, tmph0
# kianv_stdlib.h:69:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 69 "kianv_stdlib.h" 1
	rdcycle  a3	# tmp211
# 0 "" 2
 #NO_APP
	sw	a3,96(sp)	# tmp211, tmpl0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a3,92(sp)		# tmph0.0_15, tmph0
# kianv_stdlib.h:71:   return ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a2,96(sp)		# tmpl0.1_18, tmpl0
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	a4,a3,.L518	#, tmp241, tmph0.0_15,
	bne	a4,a3,.L508	#, tmp241, tmph0.0_15,
	bgtu	a5,a2,.L518	#, tmp238, tmpl0.1_18,
	j	.L508		#
.L521:
# main_raytrace_termio.c:244:   uint8_t R = (uint8_t)(255.0f * r);
	lui	a5,%hi(.LC27)	# tmp331,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s1	#, _50
	call	__mulsf3		#
# main_raytrace_termio.c:244:   uint8_t R = (uint8_t)(255.0f * r);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	s0,a0,0xff	# prephitmp_103, tmp300
	j	.L501		#
.L523:
# main_raytrace_termio.c:246:   uint8_t B = (uint8_t)(255.0f * b);
	lui	a5,%hi(.LC27)	# tmp333,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s2	#, _52
	call	__mulsf3		#
# main_raytrace_termio.c:246:   uint8_t B = (uint8_t)(255.0f * b);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	a3,a0,0xff	# prephitmp_91, tmp306
	j	.L503		#
.L522:
# main_raytrace_termio.c:245:   uint8_t G = (uint8_t)(255.0f * g);
	lui	a5,%hi(.LC27)	# tmp332,
	lw	a1,%lo(.LC27)(a5)		#,
	mv	a0,s3	#, _51
	call	__mulsf3		#
# main_raytrace_termio.c:245:   uint8_t G = (uint8_t)(255.0f * g);
	call	__fixunssfsi		#
# main_raytrace_termio.c:253:     printf("\033[48;2;%d;%d;%dm ",R,G,B);
	andi	s1,a0,0xff	# prephitmp_109, tmp303
	j	.L502		#
	.size	main, .-main
	.globl	fb
	.globl	lights
	.globl	nb_lights
	.globl	spheres
	.globl	nb_spheres
	.globl	dither
	.globl	__errno
	.globl	VRENDER
	.globl	HRENDER
	.globl	VRES
	.globl	HRES
	.globl	heap_memory_used
	.globl	heap_memory
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC1:
	.word	1065353216
	.align	2
.LC2:
	.word	-1082130432
	.align	2
.LC3:
	.word	1900671690
	.section	.srodata.cst8,"aM",@progbits,8
	.align	3
.LC4:
	.word	-755914244
	.word	1062232653
	.section	.srodata.cst4
	.align	2
.LC5:
	.word	1082130432
	.section	.srodata.cst8
	.align	3
.LC6:
	.word	0
	.word	1076101120
	.section	.srodata.cst4
	.align	2
.LC7:
	.word	-1054867456
	.align	2
.LC8:
	.word	-1041235968
	.section	.srodata.cst8
	.align	3
.LC9:
	.word	0
	.word	1071644672
	.align	3
.LC10:
	.word	0
	.word	1083129856
	.section	.srodata.cst4
	.align	2
.LC11:
	.word	1050253722
	.align	2
.LC12:
	.word	1045220557
	.align	2
.LC13:
	.word	1036831949
	.align	2
.LC14:
	.word	1148846080
	.section	.srodata.cst8
	.align	3
.LC15:
	.word	-460454608
	.word	724303662
	.align	3
.LC16:
	.word	630506365
	.word	1420970413
	.align	3
.LC17:
	.word	0
	.word	1072693248
	.section	.srodata.cst4
	.align	2
.LC18:
	.word	1060320051
	.align	2
.LC19:
	.word	1056964608
	.align	2
.LC20:
	.word	1061997773
	.align	2
.LC21:
	.word	981668463
	.section	.srodata.cst8
	.align	3
.LC24:
	.word	0
	.word	1078460416
	.align	3
.LC25:
	.word	1073741824
	.word	1071694162
	.align	3
.LC26:
	.word	0
	.word	-1068498944
	.section	.srodata.cst4
	.align	2
.LC27:
	.word	1132396544
	.section	.srodata.cst8
	.align	3
.LC30:
	.word	0
	.word	1077936128
	.section	.srodata.cst4
	.align	2
.LC32:
	.word	-1069547520
	.align	2
.LC33:
	.word	-1048576000
	.set	.LC34,.LC25
	.align	2
.LC35:
	.word	1058642330
	.align	2
.LC36:
	.word	1053609165
	.align	2
.LC37:
	.word	1112014848
	.align	2
.LC38:
	.word	-1077936128
	.align	2
.LC39:
	.word	-1052770304
	.align	2
.LC40:
	.word	1069547520
	.align	2
.LC41:
	.word	1123680256
	.align	2
.LC42:
	.word	-1090519040
	.align	2
.LC43:
	.word	-1047527424
	.set	.LC44,.LC30+4
	.align	2
.LC45:
	.word	1063675494
	.align	2
.LC46:
	.word	1092616192
	.align	2
.LC47:
	.word	1088421888
	.align	2
.LC48:
	.word	1084227584
	.align	2
.LC49:
	.word	1124990976
	.align	2
.LC50:
	.word	-1046478848
	.align	2
.LC51:
	.word	1101004800
	.align	2
.LC52:
	.word	1106247680
	.align	2
.LC53:
	.word	-1043857408
	.align	2
.LC54:
	.word	1072064102
	.align	2
.LC55:
	.word	1071225242
	.section	.rodata
	.align	2
	.type	dither, @object
	.size	dither, 16
dither:
	.string	""
	.ascii	"\b\002\n"
	.ascii	"\f\004\016\006"
	.ascii	"\003\013\001\t"
	.ascii	"\017\007\r\005"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	heap_memory, @object
	.size	heap_memory, 1024
heap_memory:
	.zero	1024
	.type	spheres, @object
	.size	spheres, 208
spheres:
	.zero	208
	.type	lights, @object
	.size	lights, 48
lights:
	.zero	48
	.section	.sbss,"aw",@nobits
	.align	2
	.type	__errno, @object
	.size	__errno, 4
__errno:
	.zero	4
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.section	.sdata,"aw"
	.align	2
	.type	fb, @object
	.size	fb, 4
fb:
	.word	268435456
	.type	nb_lights, @object
	.size	nb_lights, 4
nb_lights:
	.word	3
	.type	nb_spheres, @object
	.size	nb_spheres, 4
nb_spheres:
	.word	4
	.section	.srodata,"a"
	.align	2
	.type	VRENDER, @object
	.size	VRENDER, 4
VRENDER:
	.word	64
	.type	HRENDER, @object
	.size	HRENDER, 4
HRENDER:
	.word	96
	.type	VRES, @object
	.size	VRES, 4
VRES:
	.word	128
	.type	HRES, @object
	.size	HRES, 4
HRES:
	.word	128
	.ident	"GCC: (GNU) 11.1.0"
