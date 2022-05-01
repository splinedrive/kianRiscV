	.file	"main_raytrace.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (GCC) version 11.1.0 (riscv32-unknown-elf)
#	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=rv32im -mabi=ilp32 -mtune=rocket -march=rv32im -Os -fno-pic -fno-stack-protector -ffreestanding
	.text
	.globl	__mulsf3
	.globl	__addsf3
	.globl	__divsf3
	.align	2
	.type	vec3_normalize, @function
vec3_normalize:
	addi	sp,sp,-32	#,,
	sw	s4,8(sp)	#,
	lw	s4,0(a1)		# U$x, U.x
	sw	s3,12(sp)	#,
	lw	s3,4(a1)		# U$y, U.y
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	mv	s0,a0	# .result_ptr, tmp97
	lw	s2,8(a1)		# U$z, U.z
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s4	#, U$x
	mv	a1,s4	#, U$x
# main_raytrace.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	call	__mulsf3		#
	mv	s1,a0	# tmp87, tmp99
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s3	#, U$y
	mv	a0,s3	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp100,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s1	#, tmp87
	call	__addsf3		#
	mv	s1,a0	# tmp89, tmp101
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s2	#, U$z
	mv	a0,s2	#, U$z
	call	__mulsf3		#
	mv	a1,a0	# tmp102,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s1	#, tmp89
	call	__addsf3		#
	call	sqrtf		#
# main_raytrace.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lui	a5,%hi(.LC0)	# tmp92,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a0	# tmp103,
# main_raytrace.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	a0,%lo(.LC0)(a5)		#,
	call	__divsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s4	#, U$x
# main_raytrace.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	mv	s1,a0	# tmp93, tmp104
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,0(s0)	# tmp105, <retval>.x
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s1	#, tmp93
	mv	a0,s3	#, U$y
	call	__mulsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,4(s0)	# tmp106, <retval>.y
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s2	#, U$z
	mv	a0,s1	#, tmp93
	call	__mulsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,8(s0)	# tmp107, <retval>.z
# main_raytrace.c:56: static inline vec3 vec3_normalize(vec3 U)      { return vec3_scale(1.0f/vec3_length(U),U); }
	lw	ra,28(sp)		#,
	mv	a0,s0	#, .result_ptr
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	vec3_normalize, .-vec3_normalize
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
	beq	a2,zero,.L4	#, tmp89,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a1,a1,a5	# _1, _5, _12
.L6:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	sw	a1,0(a0)	# _18,* p
# kianv_stdlib.h:47: }
	ret	
.L4:
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	not	a1,a1	# tmp86, _12
# kianv_stdlib.h:45:       *p &= ~( 0x01 << (gpio & 0x1f));
	and	a1,a1,a5	# _13, _18, tmp86
	j	.L6		#
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
.L15:
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	call	get_cycles		#
# kianv_stdlib.h:81:   while (get_cycles() < lim)
	bgtu	s0,a1,.L15	#, tmp80, _2,
	bne	s0,a1,.L12	#, tmp80, _2,
	bgtu	s1,a0,.L15	#, tmp95, _2,
.L12:
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
	beq	a0,zero,.L17	#, us,,
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
.L17:
# kianv_stdlib.h:87: }
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L19	#, ms,,
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
.L19:
# kianv_stdlib.h:91: }
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L21	#, sec,,
# kianv_stdlib.h:76:   return *((volatile uint32_t*) CPU_FREQ);
	li	a5,805306368		# tmp77,
	lw	a5,16(a5)		# _7, MEM[(volatile uint32_t *)805306384B]
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	li	a1,0		#,
	mul	a0,a0,a5	#, sec, _7
	tail	wait_cycles		#
.L21:
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
.L30:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L30	#, _1,,
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
.L35:
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a5,0(a0)	# _3, MEM[(char *)p_4]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a5,zero,.L36	#, _3,,
# kianv_stdlib.h:127: }
	ret	
.L36:
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	lw	a3,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a3,zero,.L36	#, _1,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a5,0(a4)	# _3, MEM[(volatile uint32_t *)805306368B]
	j	.L35		#
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
.L43:
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a0,zero,.L44	#, val,,
# kianv_stdlib.h:136:   while (val || p == buffer) {
	beq	a5,a3,.L44	#, p, p,
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	li	a2,805306368		# tmp88,
.L45:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a2)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L45	#, _3,,
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a4,-1(a5)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,-1	#, p, p
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a4,0(a2)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:141:   while (p != buffer) {
	bne	a5,a3,.L45	#, p, p,
# kianv_stdlib.h:146: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L44:
# kianv_stdlib.h:137:     *(p++) = val % 10;
	remu	a2,a0,a4	# tmp93, tmp83, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	addi	a5,a5,1	#, p, p
# kianv_stdlib.h:138:     val = val / 10;
	divu	a0,a0,a4	# tmp93, val, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	sb	a2,-1(a5)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L43		#
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
.L52:
# kianv_stdlib.h:151:   while (val || p == buffer) {
	or	a5,s0,s1	# val, val, val
	bne	a5,zero,.L53	#, val,,
# kianv_stdlib.h:151:   while (val || p == buffer) {
	beq	s2,s3,.L53	#, p, p,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp93,
.L54:
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L54	#, _3,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(s2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	s2,s2,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	s2,s3,.L54	#, p, p,
# kianv_stdlib.h:161: }
	lw	ra,60(sp)		#,
	lw	s0,56(sp)		#,
	lw	s1,52(sp)		#,
	lw	s2,48(sp)		#,
	lw	s3,44(sp)		#,
	addi	sp,sp,64	#,,
	jr	ra		#
.L53:
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
	j	.L52		#
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
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	addi	a1,a1,-1	#, tmp81, tmp93
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	lui	a4,%hi(.LC1)	# tmp90,
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	slli	a1,a1,2	#, i, tmp81
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp89,
# kianv_stdlib.h:167:     *((volatile uint32_t*) UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
	addi	a4,a4,%lo(.LC1)	# tmp91, tmp90,
.L61:
# kianv_stdlib.h:164:   for (int i = (4*digits)-4; i >= 0; i -= 4) {
	bge	a1,zero,.L62	#, i,,
# kianv_stdlib.h:169: }
	ret	
.L62:
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L62	#, _2,,
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
	j	.L61		#
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
	ble	s5,s1,.L68	#, x1, x0,
	li	s10,1		# iftmp.6_9,
.L68:
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
	mv	s4,a0	# _3, tmp108
# kianv_stdlib.h:191:   int dy = -abs(y1 - y0);
	neg	s11,a0	# dy, _3
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	li	s9,1		# iftmp.7_10,
	bgt	s6,s0,.L69	#, y1, y0,
# kianv_stdlib.h:192:   int sy = y0 < y1 ? 1 : -1;
	li	s9,-1		# iftmp.7_10,
.L69:
	sub	s2,s3,s4	# err, dx, _3
.L70:
# kianv_stdlib.h:196:     setpixel(fb, x0, y0, color);
	mv	a3,s8	#, color
	mv	a2,s0	#, y0
	mv	a1,s1	#, x0
	mv	a0,s7	#, fb
	call	setpixel		#
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s5,.L71	#, x0, x1,
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	beq	s0,s6,.L67	#, y0, y1,
.L71:
# kianv_stdlib.h:198:     e2 = 2*err;
	slli	a5,s2,1	#, e2, err
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	s11,a5,.L73	#, dy, e2,
	sub	s2,s2,s4	# err, err, _3
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s10	# iftmp.6_9, x0, x0
.L73:
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s3,a5,.L70	#, dx, e2,
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s2,s2,s3	# dx, err, err
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,s9	# iftmp.7_10, y0, y0
	j	.L70		#
.L67:
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
	.globl	make_Light
	.type	make_Light, @function
make_Light:
	addi	sp,sp,-16	#,,
	sw	s1,4(sp)	#,
	mv	s1,a2	# intensity, tmp80
# main_raytrace.c:67:   L.position = position;
	li	a2,12		#,
# main_raytrace.c:65: Light make_Light(vec3 position, float intensity) {
	sw	s0,8(sp)	#,
	sw	ra,12(sp)	#,
# main_raytrace.c:65: Light make_Light(vec3 position, float intensity) {
	mv	s0,a0	# .result_ptr, tmp79
# main_raytrace.c:67:   L.position = position;
	call	memcpy		#
# main_raytrace.c:70: }
	lw	ra,12(sp)		#,
# main_raytrace.c:69:   return L;
	sw	s1,12(s0)	# intensity, <retval>.intensity
# main_raytrace.c:70: }
	mv	a0,s0	#, .result_ptr
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	make_Light, .-make_Light
	.align	2
	.globl	make_Material
	.type	make_Material, @function
make_Material:
	addi	sp,sp,-32	#,,
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	mv	s0,a0	# .result_ptr, tmp85
	mv	s2,a1	# r, tmp86
# main_raytrace.c:84:   M.albedo = a;
	addi	a0,a0,4	#,, .result_ptr
# main_raytrace.c:81: Material make_Material(float r, vec4 a, vec3 color, float spec) {
	mv	a1,a2	# tmp87,
# main_raytrace.c:84:   M.albedo = a;
	li	a2,16		#,
# main_raytrace.c:81: Material make_Material(float r, vec4 a, vec3 color, float spec) {
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
	sw	s3,12(sp)	#,
# main_raytrace.c:81: Material make_Material(float r, vec4 a, vec3 color, float spec) {
	mv	s1,a4	# spec, tmp89
	mv	s3,a3	# tmp75, tmp88
# main_raytrace.c:84:   M.albedo = a;
	call	memcpy		#
# main_raytrace.c:85:   M.diffuse_color = color;
	mv	a1,s3	#, tmp75
	addi	a0,s0,20	#,, .result_ptr
	li	a2,12		#,
	call	memcpy		#
# main_raytrace.c:88: }
	lw	ra,28(sp)		#,
# main_raytrace.c:87:   return M;
	sw	s2,0(s0)	# r, <retval>.refractive_index
	sw	s1,32(s0)	# spec, <retval>.specular_exponent
# main_raytrace.c:88: }
	mv	a0,s0	#, .result_ptr
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	make_Material, .-make_Material
	.align	2
	.globl	make_Material_default
	.type	make_Material_default, @function
make_Material_default:
# main_raytrace.c:96:   return M;
	lui	a4,%hi(.LC0)	# tmp73,
	lw	a4,%lo(.LC0)(a4)		# tmp74,
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
# main_raytrace.c:97: }
	ret	
	.size	make_Material_default, .-make_Material_default
	.align	2
	.globl	make_Sphere
	.type	make_Sphere, @function
make_Sphere:
	addi	sp,sp,-16	#,,
	sw	s1,4(sp)	#,
	mv	s1,a2	# r, tmp85
# main_raytrace.c:109:   S.center = c;
	li	a2,12		#,
# main_raytrace.c:107: Sphere make_Sphere(vec3 c, float r, Material M) {
	sw	ra,12(sp)	#,
	sw	s0,8(sp)	#,
	sw	s2,0(sp)	#,
# main_raytrace.c:107: Sphere make_Sphere(vec3 c, float r, Material M) {
	mv	s0,a0	# .result_ptr, tmp84
	mv	s2,a3	# tmp75, tmp86
# main_raytrace.c:109:   S.center = c;
	call	memcpy		#
# main_raytrace.c:111:   S.material = M;
	mv	a1,s2	#, tmp75
	addi	a0,s0,16	#,, .result_ptr
	li	a2,36		#,
	call	memcpy		#
# main_raytrace.c:113: }
	lw	ra,12(sp)		#,
# main_raytrace.c:112:   return S;
	sw	s1,12(s0)	# r, <retval>.radius
# main_raytrace.c:113: }
	mv	a0,s0	#, .result_ptr
	lw	s0,8(sp)		#,
	lw	s1,4(sp)		#,
	lw	s2,0(sp)		#,
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	make_Sphere, .-make_Sphere
	.globl	__subsf3
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
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(a0)		#, S_11(D)->center.x
	lw	a1,0(a1)		#, orig.x
# main_raytrace.c:115: BOOL Sphere_ray_intersect(Sphere* S, vec3 orig, vec3 dir, float* t0) {
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
	sw	s3,12(sp)	#,
	mv	s1,a2	# tmp106, tmp136
	mv	s3,a3	# t0, tmp137
	sw	s4,8(sp)	#,
	sw	s5,4(sp)	#,
	sw	s6,0(sp)	#,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	call	__subsf3		#
	mv	s5,a0	# tmp108, tmp138
	lw	a1,4(s2)		#, orig.y
	lw	a0,4(s0)		#, S_11(D)->center.y
	call	__subsf3		#
	mv	s4,a0	# tmp109, tmp139
	lw	a1,8(s2)		#, orig.z
	lw	a0,8(s0)		#, S_11(D)->center.z
	call	__subsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,0(s1)		#, dir.x
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	s2,a0	# tmp110, tmp140
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp108
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,4(s1)		#, dir.y
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s6,a0	# tmp111, tmp141
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp109
	call	__mulsf3		#
	mv	a1,a0	# tmp142,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s6	#, tmp111
	call	__addsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,8(s1)		#, dir.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s6,a0	# tmp113, tmp143
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp110
	call	__mulsf3		#
	mv	a1,a0	# tmp144,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s6	#, tmp113
	call	__addsf3		#
	mv	s1,a0	# tmp115, tmp145
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, tmp108
	mv	a0,s5	#, tmp11
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s4	#, tmp109
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s5,a0	# tmp116, tmp146
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp147,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s5	#, tmp116
	call	__addsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s2	#, tmp110
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s4,a0	# tmp118, tmp148
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s2	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp149,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, tmp118
	call	__addsf3		#
	mv	s2,a0	# tmp120, tmp150
# main_raytrace.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a1,s1	#, tmp115
	mv	a0,s1	#, tmp115
	call	__mulsf3		#
	mv	a1,a0	# tmp151,
# main_raytrace.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	a0,s2	#, tmp120
	call	__subsf3		#
# main_raytrace.c:119:   float r2 = S->radius*S->radius;
	lw	a1,12(s0)		# _3, S_11(D)->radius
# main_raytrace.c:118:   float d2 = vec3_dot(L,L) - tca*tca;
	mv	s2,a0	# tmp122, tmp152
# main_raytrace.c:119:   float r2 = S->radius*S->radius;
	mv	a0,a1	#,
	call	__mulsf3		#
	mv	s0,a0	# tmp123, tmp153
# main_raytrace.c:120:   if (d2 > r2) return 0;
	mv	a1,a0	#, tmp123
	mv	a0,s2	#, tmp122
	call	__gtsf2		#
	bgt	a0,zero,.L91	#, tmp154,,
# main_raytrace.c:121:   float thc = sqrtf(r2 - d2);
	mv	a1,s2	#, tmp122
	mv	a0,s0	#, tmp123
	call	__subsf3		#
	call	sqrtf		#
# main_raytrace.c:122:   *t0       = tca - thc;
	mv	a1,a0	#, thc
# main_raytrace.c:121:   float thc = sqrtf(r2 - d2);
	mv	s2,a0	# thc, tmp155
# main_raytrace.c:122:   *t0       = tca - thc;
	mv	a0,s1	#, tmp115
	call	__subsf3		#
# main_raytrace.c:124:   if (*t0 < 0) *t0 = t1;
	mv	a1,zero	#,
# main_raytrace.c:122:   *t0       = tca - thc;
	mv	s0,a0	# tmp156,
# main_raytrace.c:124:   if (*t0 < 0) *t0 = t1;
	call	__ltsf2		#
	bge	a0,zero,.L88	#, tmp157,,
# main_raytrace.c:123:   float t1 = tca + thc;
	mv	a1,s1	#, tmp115
	mv	a0,s2	#, thc
	call	__addsf3		#
	mv	s0,a0	# t1, tmp158
.L88:
	sw	s0,0(s3)	# t1, MEM <float> [(void *)t0_17(D)]
# main_raytrace.c:125:   if (*t0 < 0) return 0;
	mv	a1,zero	#,
	mv	a0,s0	#, t1
	call	__ltsf2		#
	srli	a0,a0,31	#, tmp129, tmp159
	xori	a0,a0,1	#, tmp131, tmp129
# main_raytrace.c:120:   if (d2 > r2) return 0;
	andi	a0,a0,0xff	# <retval>, tmp131
.L86:
# main_raytrace.c:127: }
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
.L91:
# main_raytrace.c:120:   if (d2 > r2) return 0;
	li	a0,0		# <retval>,
	j	.L86		#
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
	sw	s0,40(sp)	#,
	sw	s2,32(sp)	#,
	mv	s0,a0	# .result_ptr, tmp105
	lw	s2,8(a1)		# U$z, I.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s7	#, V$x
	mv	a1,s6	#, U$x
# main_raytrace.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s3,28(sp)	#,
	lw	s3,8(a2)		# V$z, N.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s1,a0	# tmp93, tmp108
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s5	#, V$y
	mv	a0,s4	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp109,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp93
	call	__addsf3		#
	mv	s1,a0	# tmp95, tmp110
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s3	#, V$z
	mv	a0,s2	#, U$z
	call	__mulsf3		#
	mv	a1,a0	# tmp111,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp95
	call	__addsf3		#
	mv	a1,a0	# tmp112,
# main_raytrace.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s7	#, V$x
# main_raytrace.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
	mv	s1,a0	# tmp98, tmp113
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	mv	a1,a0	# tmp114,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s6	#, U$x
	call	__subsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,0(s0)	# tmp115, <retval>.x
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, V$y
	mv	a0,s1	#, tmp98
	call	__mulsf3		#
	mv	a1,a0	# tmp116,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s4	#, U$y
	call	__subsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,4(s0)	# tmp117, <retval>.y
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s3	#, V$z
	mv	a0,s1	#, tmp98
	call	__mulsf3		#
	mv	a1,a0	# tmp118,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s2	#, U$z
	call	__subsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,8(s0)	# tmp119, <retval>.z
# main_raytrace.c:129: vec3 reflect(vec3 I, vec3 N) { return vec3_sub(I, vec3_scale(2.f*vec3_dot(I,N),N)); }
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
	.align	2
	.globl	refract
	.type	refract, @function
refract:
	addi	sp,sp,-112	#,,
	sw	s4,88(sp)	#,
	sw	s10,64(sp)	#,
	lw	s4,0(a2)		# V$x, N.x
	lw	s10,0(a1)		# U$x, I.x
	sw	s3,92(sp)	#,
	sw	s9,68(sp)	#,
	lw	s3,4(a2)		# V$y, N.y
	lw	s9,4(a1)		# U$y, I.y
	sw	s0,104(sp)	#,
	sw	s2,96(sp)	#,
	sw	s8,72(sp)	#,
	mv	s0,a0	# .result_ptr, tmp164
	lw	s8,8(a1)		# U$z, I.z
	mv	s2,a1	# tmp106, tmp165
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s4	#, V$x
	mv	a1,s10	#, U$x
# main_raytrace.c:131: vec3 refract(vec3 I, vec3 N, float eta_t, float eta_i /* =1.f */) { // Snell's law
	sw	ra,108(sp)	#,
	sw	s1,100(sp)	#,
	sw	s5,84(sp)	#,
	sw	s6,80(sp)	#,
	sw	s7,76(sp)	#,
	mv	s6,a4	# eta_i, tmp168
	lw	s7,8(a2)		# V$z, N.z
	sw	s11,60(sp)	#,
# main_raytrace.c:131: vec3 refract(vec3 I, vec3 N, float eta_t, float eta_i /* =1.f */) { // Snell's law
	mv	s11,a3	# eta_t, tmp167
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s1,a0	# tmp111, tmp169
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s3	#, V$y
	mv	a0,s9	#, U$y
	call	__mulsf3		#
	mv	a1,a0	# tmp170,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp111
	call	__addsf3		#
	mv	s1,a0	# tmp113, tmp171
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,s8	#, U$z
	mv	a0,s7	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp172,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp113
	call	__addsf3		#
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	s5,%hi(.LC0)	# tmp117,
	lw	a1,%lo(.LC0)(s5)		#,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# _31, tmp173
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	call	__gtsf2		#
	bgt	a0,zero,.L97	#, tmp174,,
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	lui	a5,%hi(.LC2)	# tmp120,
	lw	a1,%lo(.LC2)(a5)		# tmp119,
	mv	a0,s1	#, _31
	call	__ltsf2		#
	lui	a5,%hi(.LC2)	# tmp200,
	lw	a1,%lo(.LC2)(a5)		# tmp119,
	blt	a0,zero,.L103	#, tmp175,,
# main_raytrace.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	mv	a1,zero	#,
	mv	a0,s1	#, _31
	call	__gtsf2		#
	ble	a0,zero,.L98	#, tmp176,,
.L97:
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	li	a5,-2147483648		# tmp123,
	xor	s4,a5,s4	# V$x, tmp124, tmp123
	xor	s3,a5,s3	# V$y, tmp126, tmp123
# main_raytrace.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	li	a2,12		#,
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	a5,a5,s7	# V$z, tmp128, tmp123
# main_raytrace.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	mv	a1,s2	#, tmp106
	addi	a0,sp,16	#, tmp194,
# main_raytrace.c:41:   return V;
	sw	a5,44(sp)	# tmp128, D.2054.z
	sw	s4,36(sp)	# tmp124, D.2054.x
	sw	s3,40(sp)	# tmp126, D.2054.y
# main_raytrace.c:133:   if (cosi<0) return refract(I, vec3_neg(N), eta_i, eta_t); // if the ray comes from the inside the object, swap the air and the media
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,36	#,,
	mv	a0,sp	#,
	call	memcpy		#
	mv	a4,s11	#, eta_t
	mv	a3,s6	#, eta_i
	mv	a2,sp	#,
	addi	a1,sp,16	#, tmp195,
	mv	a0,s0	#, .result_ptr
	call	refract		#
.L96:
# main_raytrace.c:138: }
	lw	ra,108(sp)		#,
	mv	a0,s0	#, .result_ptr
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
	addi	sp,sp,112	#,,
	jr	ra		#
.L103:
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s1,a1	# _31, tmp119
.L98:
# main_raytrace.c:134:   float eta = eta_i / eta_t;
	mv	a1,s11	#, eta_t
	mv	a0,s6	#, eta_i
	call	__divsf3		#
	mv	s2,a0	# tmp139, tmp177
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a1,s1	#, _31
	mv	a0,s1	#, _31
	call	__mulsf3		#
	mv	a1,a0	# tmp178,
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	lw	a0,%lo(.LC0)(s5)		#,
	call	__subsf3		#
	mv	s6,a0	# tmp142, tmp179
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a1,s2	#, tmp139
	mv	a0,s2	#, tmp139
	call	__mulsf3		#
	mv	a1,a0	# tmp180,
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	a0,s6	#, tmp142
	call	__mulsf3		#
	mv	a1,a0	# tmp181,
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	lw	a0,%lo(.LC0)(s5)		#,
	call	__subsf3		#
# main_raytrace.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a1,zero	#,
# main_raytrace.c:135:   float k = 1 - eta*eta*(1 - cosi*cosi);
	mv	s6,a0	# tmp146, tmp182
# main_raytrace.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	call	__ltsf2		#
	bge	a0,zero,.L105	#, tmp183,,
# main_raytrace.c:41:   return V;
	lw	a5,%lo(.LC0)(s5)		# tmp149,
	sw	a5,0(s0)	# tmp149, <retval>.x
	mv	a5,zero	# tmp196,
	sw	a5,4(s0)	# tmp196, <retval>.y
	sw	a5,8(s0)	# tmp197, <retval>.z
	j	.L96		#
.L105:
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s10	#, U$x
	mv	a0,s2	#, tmp139
	call	__mulsf3		#
	mv	s10,a0	# tmp150, tmp184
	mv	a1,s2	#, tmp139
	mv	a0,s9	#, U$y
	call	__mulsf3		#
	mv	s9,a0	# tmp151, tmp185
	mv	a1,s8	#, U$z
	mv	a0,s2	#, tmp139
	call	__mulsf3		#
	mv	s5,a0	# tmp152, tmp186
# main_raytrace.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	li	a0,-2147483648		# tmp154,
	mv	a1,s2	#, tmp139
	xor	a0,a0,s1	# _31,, tmp154
	call	__mulsf3		#
	mv	s1,a0	# tmp155, tmp187
# main_raytrace.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a0,s6	#, tmp146
	call	sqrtf		#
	mv	a1,a0	# tmp188,
# main_raytrace.c:136:   return k<0 ? make_vec3(1,0,0) : vec3_add(vec3_scale(eta,I),vec3_scale((eta*cosi - sqrtf(k)),N));
	mv	a0,s1	#, tmp155
	call	__subsf3		#
	mv	s1,a0	# tmp156, tmp189
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,a0	#, tmp156
	mv	a0,s4	#, V$x
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s10	#, tmp150
	call	__addsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,0(s0)	# tmp190, <retval>.x
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s3	#, V$y
	mv	a0,s1	#, tmp156
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s9	#, tmp151
	call	__addsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,4(s0)	# tmp191, <retval>.y
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s1	#, tmp156
	mv	a0,s7	#, V$z
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s5	#, tmp152
	call	__addsf3		#
# main_raytrace.c:41:   return V;
	sw	a0,8(s0)	# tmp192, <retval>.z
	j	.L96		#
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
	addi	sp,sp,-144	#,,
	sw	s4,120(sp)	#,
	mv	s4,a5	# N, tmp236
	lw	a5,8(a0)		# orig$z, orig.z
	sw	s3,124(sp)	#,
	sw	s5,116(sp)	#,
	sw	a5,16(sp)	# orig$z, %sfp
	lw	a5,8(a1)		# dir$z, dir.z
	sw	s7,108(sp)	#,
	sw	s10,96(sp)	#,
	sw	a5,12(sp)	# dir$z, %sfp
# main_raytrace.c:142:   float spheres_dist = 1e30;
	lui	a5,%hi(.LC3)	# tmp264,
# main_raytrace.c:141: BOOL scene_intersect(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, vec3* hit, vec3* N, Material* material) {
	sw	s11,92(sp)	#,
	lw	s10,0(a0)		# orig$x, orig.x
	lw	s7,4(a0)		# orig$y, orig.y
	lw	s11,0(a1)		# dir$x, dir.x
	lw	s5,4(a1)		# dir$y, dir.y
# main_raytrace.c:142:   float spheres_dist = 1e30;
	lw	s3,%lo(.LC3)(a5)		# spheres_dist,
# main_raytrace.c:141: BOOL scene_intersect(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, vec3* hit, vec3* N, Material* material) {
	sw	s0,136(sp)	#,
	sw	s1,132(sp)	#,
	sw	s2,128(sp)	#,
	sw	s8,104(sp)	#,
	sw	s9,100(sp)	#,
	sw	ra,140(sp)	#,
	sw	s6,112(sp)	#,
# main_raytrace.c:141: BOOL scene_intersect(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, vec3* hit, vec3* N, Material* material) {
	mv	s8,a0	# tmp122, tmp231
	mv	s9,a1	# tmp123, tmp232
	sw	a3,20(sp)	# tmp234, %sfp
	mv	s0,a4	# hit, tmp235
	mv	s1,a6	# material, tmp237
	mv	s2,a2	# ivtmp.559, tmp233
# main_raytrace.c:143:   for(int i=0; i<nb_spheres; ++i) {
	sw	zero,8(sp)	#, %sfp
.L108:
# main_raytrace.c:143:   for(int i=0; i<nb_spheres; ++i) {
	lw	a5,8(sp)		# i, %sfp
	lw	a4,20(sp)		# nb_spheres, %sfp
	blt	a5,a4,.L111	#, i, nb_spheres,
# main_raytrace.c:153:   if (fabs(dir.y)>1e-3)  {
	mv	a0,s5	#, dir$y
	call	__extendsfdf2		#
	call	fabs		#
# main_raytrace.c:153:   if (fabs(dir.y)>1e-3)  {
	lui	a5,%hi(.LC4)	# tmp168,
	lw	a2,%lo(.LC4)(a5)		#,
	lw	a3,%lo(.LC4+4)(a5)		#,
	call	__gtdf2		#
	bgt	a0,zero,.L112	#, tmp246,,
.L114:
# main_raytrace.c:152:   float checkerboard_dist = 1e30;
	lui	a5,%hi(.LC3)	# tmp277,
	lw	s2,%lo(.LC3)(a5)		# d,
.L113:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s2	#, d
	mv	a0,s3	#, spheres_dist
	call	__ltsf2		#
	blt	a0,zero,.L121	#, tmp259,,
	mv	s3,s2	# spheres_dist, d
.L121:
# main_raytrace.c:163:   return min(spheres_dist, checkerboard_dist)<1000;
	lui	a5,%hi(.LC14)	# tmp223,
	lw	a1,%lo(.LC14)(a5)		#,
	mv	a0,s3	#, spheres_dist
	call	__ltsf2		#
# main_raytrace.c:164: }
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
	slti	a0,a0,0	#,, tmp260
	addi	sp,sp,144	#,,
	jr	ra		#
.L111:
# main_raytrace.c:145:     if(Sphere_ray_intersect(&spheres[i], orig, dir, &dist_i) && (dist_i < spheres_dist)) {
	lw	a5,16(sp)		# orig$z, %sfp
	li	a2,12		#,
	mv	a1,s8	#, tmp122
	sw	a5,8(s8)	# orig$z, orig.z
	lw	a5,12(sp)		# dir$z, %sfp
	addi	a0,sp,48	#, tmp267,
	sw	s10,0(s8)	# orig$x, orig.x
	sw	a5,8(s9)	# dir$z, dir.z
	sw	s7,4(s8)	# orig$y, orig.y
	sw	s11,0(s9)	# dir$x, dir.x
	sw	s5,4(s9)	# dir$y, dir.y
	call	memcpy		#
	li	a2,12		#,
	mv	a1,s9	#, tmp123
	addi	a0,sp,32	#,,
	call	memcpy		#
	addi	a3,sp,64	#, tmp268,
	addi	a2,sp,32	#,,
	addi	a1,sp,48	#, tmp269,
	mv	a0,s2	#, ivtmp.559
	call	Sphere_ray_intersect		#
# main_raytrace.c:145:     if(Sphere_ray_intersect(&spheres[i], orig, dir, &dist_i) && (dist_i < spheres_dist)) {
	beq	a0,zero,.L109	#, tmp238,,
# main_raytrace.c:145:     if(Sphere_ray_intersect(&spheres[i], orig, dir, &dist_i) && (dist_i < spheres_dist)) {
	lw	s6,64(sp)		# dist_i.11_5, dist_i
# main_raytrace.c:145:     if(Sphere_ray_intersect(&spheres[i], orig, dir, &dist_i) && (dist_i < spheres_dist)) {
	mv	a1,s3	#, spheres_dist
	mv	a0,s6	#, dist_i.11_5
	call	__ltsf2		#
	bge	a0,zero,.L109	#, tmp239,,
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s11	#, dir$x
	mv	a0,s6	#, dist_i.11_5
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s10	#, orig$x
	call	__addsf3		#
	mv	s3,a0	# tmp144, tmp240
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, dir$y
	mv	a0,s6	#, dist_i.11_5
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s7	#, orig$y
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,12(sp)		#, %sfp
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	sw	a0,24(sp)	# tmp146, %sfp
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s6	#, dist_i.11_5
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a1,16(sp)		#, %sfp
	call	__addsf3		#
# main_raytrace.c:147:       *hit = vec3_add(orig,vec3_scale(dist_i,dir));
	lw	a4,24(sp)		# tmp146, %sfp
	sw	s3,0(s0)	# tmp144, hit_42(D)->x
	sw	a0,8(s0)	# tmp148, hit_42(D)->z
	sw	a4,4(s0)	# tmp146, hit_42(D)->y
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,4(s2)		#, MEM[(float *)_3 + 4B]
# main_raytrace.c:147:       *hit = vec3_add(orig,vec3_scale(dist_i,dir));
	sw	a0,24(sp)	# tmp148, %sfp
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,a4	#, tmp146
	call	__subsf3		#
	lw	a5,24(sp)		# tmp148, %sfp
	lw	a1,8(s2)		#, MEM[(float *)_3 + 8B]
	sw	a0,28(sp)	# tmp149, %sfp
	mv	a0,a5	#, tmp148
	call	__subsf3		#
	lw	a1,0(s2)		#, MEM[(float *)_3]
	sw	a0,24(sp)	# tmp150, %sfp
	mv	a0,s3	#, tmp144
	call	__subsf3		#
# main_raytrace.c:41:   return V;
	lw	a4,28(sp)		# tmp149, %sfp
	lw	a5,24(sp)		# tmp150, %sfp
# main_raytrace.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a0,68(sp)	# tmp245, D.2082.x
# main_raytrace.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	addi	a1,sp,68	#, tmp270,
	addi	a0,sp,32	#,,
# main_raytrace.c:41:   return V;
	sw	a4,72(sp)	# tmp149, D.2082.y
	sw	a5,76(sp)	# tmp150, D.2082.z
# main_raytrace.c:148:       *N = vec3_normalize(vec3_sub(*hit, spheres[i].center));
	call	memcpy		#
	addi	a1,sp,32	#,,
	addi	a0,sp,48	#, tmp271,
	call	vec3_normalize		#
	li	a2,12		#,
	addi	a1,sp,48	#, tmp272,
	mv	a0,s4	#, N
	call	memcpy		#
# main_raytrace.c:149:       *material = spheres[i].material;
	li	a2,36		#,
	addi	a1,s2,16	#,, ivtmp.559
	mv	a0,s1	#, material
	call	memcpy		#
# main_raytrace.c:146:       spheres_dist = dist_i;
	mv	s3,s6	# spheres_dist, dist_i.11_5
.L109:
# main_raytrace.c:143:   for(int i=0; i<nb_spheres; ++i) {
	lw	a5,8(sp)		# i, %sfp
	addi	s2,s2,52	#, ivtmp.559, ivtmp.559
	addi	a5,a5,1	#, i, i
	sw	a5,8(sp)	# i, %sfp
	j	.L108		#
.L112:
# main_raytrace.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	lui	a5,%hi(.LC5)	# tmp170,
	lw	a1,%lo(.LC5)(a5)		#,
	mv	a0,s7	#, orig$y
	call	__addsf3		#
# main_raytrace.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	li	a5,-2147483648		# tmp173,
	mv	a1,s5	#, dir$y
	xor	a0,a5,a0	# tmp247,, tmp173
	call	__divsf3		#
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	mv	a1,zero	#,
# main_raytrace.c:154:     float d = -(orig.y+4)/dir.y; // the checkerboard plane has equation y = -4
	mv	s2,a0	# d, tmp248
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__gtsf2		#
	ble	a0,zero,.L114	#, tmp249,,
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s11	#, dir$x
	mv	a0,s2	#, d
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s10	#, orig$x
	call	__addsf3		#
	mv	s10,a0	# tmp177, tmp250
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__extendsfdf2		#
	call	fabs		#
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC6)	# tmp180,
	lw	a2,%lo(.LC6)(a5)		#,
	lw	a3,%lo(.LC6+4)(a5)		#,
	call	__ltdf2		#
	bge	a0,zero,.L114	#, tmp251,,
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,12(sp)		#, %sfp
	mv	a0,s2	#, d
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a1,16(sp)		#, %sfp
	call	__addsf3		#
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC7)	# tmp185,
	lw	a1,%lo(.LC7)(a5)		#,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s6,a0	# tmp183, tmp252
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	call	__ltsf2		#
	bge	a0,zero,.L114	#, tmp253,,
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	lui	a5,%hi(.LC8)	# tmp188,
	lw	a1,%lo(.LC8)(a5)		#,
	mv	a0,s6	#, tmp183
	call	__gtsf2		#
	ble	a0,zero,.L114	#, tmp254,,
# main_raytrace.c:156:     if (d>0 && fabs(pt.x)<10 && pt.z<-10 && pt.z>-30 && d<spheres_dist) {
	mv	a1,s2	#, d
	mv	a0,s3	#, spheres_dist
	call	__gtsf2		#
	ble	a0,zero,.L114	#, tmp255,,
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,s5	#, dir$y
# main_raytrace.c:158:       *hit = pt;
	sw	s10,0(s0)	# tmp177, hit_42(D)->x
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s2	#, d
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s7	#, orig$y
	call	__addsf3		#
# main_raytrace.c:159:       *N = make_vec3(0,1,0);
	mv	a4,zero	# tmp278,
# main_raytrace.c:158:       *hit = pt;
	sw	a0,4(s0)	# tmp256, hit_42(D)->y
	sw	s6,8(s0)	# tmp183, hit_42(D)->z
# main_raytrace.c:159:       *N = make_vec3(0,1,0);
	lui	a5,%hi(.LC0)	# tmp193,
	sw	a4,0(s4)	# tmp278, N_43(D)->x
	lw	a5,%lo(.LC0)(a5)		# tmp194,
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a0,0(s0)		#, hit_42(D)->x
# main_raytrace.c:159:       *N = make_vec3(0,1,0);
	sw	a4,8(s4)	# tmp279, N_43(D)->z
	sw	a5,4(s4)	# tmp194, N_43(D)->y
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__extendsfdf2		#
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	s5,%hi(.LC9)	# tmp196,
	lw	a2,%lo(.LC9)(s5)		#,
	lw	a3,%lo(.LC9+4)(s5)		#,
	call	__muldf3		#
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lui	a5,%hi(.LC10)	# tmp198,
	lw	a2,%lo(.LC10)(a5)		#,
	lw	a3,%lo(.LC10+4)(a5)		#,
	call	__adddf3		#
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__fixdfsi		#
	mv	s4,a0	# tmp200, tmp257
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a0,8(s0)		#, hit_42(D)->z
	call	__extendsfdf2		#
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a2,%lo(.LC9)(s5)		#,
	lw	a3,%lo(.LC9+4)(s5)		#,
	call	__muldf3		#
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	call	__fixdfsi		#
	lui	a5,%hi(.LC11)	# tmp226,
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	lw	a5,%lo(.LC11)(a5)		# tmp208,
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	add	s4,s4,a0	# tmp258, tmp205, tmp200
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	andi	s4,s4,1	#, tmp206, tmp205
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	sw	a5,20(s1)	# tmp208, material_44(D)->diffuse_color.x
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	beq	s4,zero,.L120	#, tmp206,,
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	sw	a5,24(s1)	# tmp208, material_44(D)->diffuse_color.y
.L133:
# main_raytrace.c:160:       material->diffuse_color = (((int)(.5*hit->x+1000) + (int)(.5*hit->z)) & 1) ? make_vec3(.3, .3, .3) : make_vec3(.3, .2, .1);
	sw	a5,28(s1)	# tmp218, material_44(D)->diffuse_color.z
	j	.L113		#
.L120:
	lui	a5,%hi(.LC12)	# tmp215,
	lw	a5,%lo(.LC12)(a5)		# tmp216,
	sw	a5,24(s1)	# tmp216, material_44(D)->diffuse_color.y
	lui	a5,%hi(.LC13)	# tmp217,
	lw	a5,%lo(.LC13)(a5)		# tmp218,
	j	.L133		#
	.size	scene_intersect, .-scene_intersect
	.globl	__fixsfsi
	.align	2
	.globl	my_pow
	.type	my_pow, @function
my_pow:
	addi	sp,sp,-48	#,,
	sw	s6,16(sp)	#,
	mv	s6,a0	# x, tmp93
# main_raytrace.c:170:   int Y = (int)y;
	mv	a0,a1	#, tmp94
# main_raytrace.c:168: float my_pow(float x, float y) {
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s8,8(sp)	#,
	sw	ra,44(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# main_raytrace.c:170:   int Y = (int)y;
	call	__fixsfsi		#
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC15)	# tmp89,
	lw	s2,%lo(.LC15)(a5)		# tmp90,
	lw	s3,%lo(.LC15+4)(a5)		#,
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	lui	a5,%hi(.LC16)	# tmp91,
	lw	s4,%lo(.LC16)(a5)		# tmp92,
	lw	s5,%lo(.LC16+4)(a5)		#,
# main_raytrace.c:170:   int Y = (int)y;
	mv	s1,a0	# Y, tmp95
# main_raytrace.c:169:   float alu_rslt = x;
	mv	s0,s6	# <retval>, x
# main_raytrace.c:171:   while(Y > 2) {
	li	s8,2		# tmp85,
.L135:
	bgt	s1,s8,.L137	#, Y, tmp85,
# main_raytrace.c:177:   while(Y > 1) {
	bne	s1,s8,.L134	#, Y, tmp85,
# main_raytrace.c:178:     Y--; alu_rslt *= x;
	mv	a0,s0	#, <retval>
	mv	a1,s6	#, x
	call	__mulsf3		#
	mv	s0,a0	# <retval>, tmp100
	j	.L134		#
.L137:
# main_raytrace.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	mv	a1,s0	#, <retval>
	mv	a0,s0	#, tmp11
	call	__mulsf3		#
	mv	s0,a0	# <retval>, tmp96
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__extendsfdf2		#
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	a2,s2	#, tmp90
	mv	a3,s3	#,
# main_raytrace.c:172:     Y /= 2; alu_rslt *= alu_rslt;
	srai	s1,s1,1	#, Y, Y
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	s9,a0	# _1, tmp103
	mv	s7,a1	# _1, tmp104
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	call	__ltdf2		#
	blt	a0,zero,.L134	#, tmp98,,
# main_raytrace.c:173:     if(alu_rslt < 1e-100 || alu_rslt > 1e100) {
	mv	a2,s4	#, tmp92
	mv	a3,s5	#,
	mv	a0,s9	# tmp105, _1
	mv	a1,s7	#, _1
	call	__gtdf2		#
	ble	a0,zero,.L135	#, tmp99,,
.L134:
# main_raytrace.c:184: }
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
	sw	s0,440(sp)	#,
	mv	s0,a5	# lights, tmp505
	lw	a5,4(a2)		# dir$y, dir.y
	sw	s1,436(sp)	#,
	sw	ra,444(sp)	#,
	sw	a5,48(sp)	# dir$y, %sfp
# main_raytrace.c:96:   return M;
	lui	a5,%hi(.LC0)	# tmp239,
	lw	s1,%lo(.LC0)(a5)		# tmp240,
	mv	a5,zero	# tmp614,
	sw	a5,320(sp)	# tmp614, material.albedo.y
	sw	a5,324(sp)	# tmp615, material.albedo.z
	sw	a5,328(sp)	# tmp616, material.albedo.w
	sw	a5,332(sp)	# tmp617, material.diffuse_color.x
	sw	a5,336(sp)	# tmp618, material.diffuse_color.y
	sw	a5,340(sp)	# tmp619, material.diffuse_color.z
	sw	a5,344(sp)	# tmp620, material.specular_exponent
# main_raytrace.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	s2,432(sp)	#,
	sw	s3,428(sp)	#,
	sw	s4,424(sp)	#,
	sw	s5,420(sp)	#,
	sw	s6,416(sp)	#,
	sw	s7,412(sp)	#,
	sw	s8,408(sp)	#,
	sw	s9,404(sp)	#,
	sw	s10,400(sp)	#,
	sw	s11,396(sp)	#,
# main_raytrace.c:187: vec3 cast_ray(vec3 orig, vec3 dir, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights, int depth /* =0 */) {
	sw	a0,16(sp)	# tmp501, %sfp
	sw	a3,20(sp)	# tmp503, %sfp
	sw	a4,24(sp)	# tmp504, %sfp
	sw	a6,44(sp)	# tmp506, %sfp
# main_raytrace.c:96:   return M;
	sw	s1,312(sp)	# tmp240, material.refractive_index
	sw	s1,316(sp)	# tmp240, material.albedo.x
# main_raytrace.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	li	a5,2		# tmp243,
	ble	a7,a5,.L143	#, depth, tmp243,
.L145:
# main_raytrace.c:191:     float s = 0.5*(dir.y + 1.0);
	lw	a0,48(sp)		#, %sfp
	call	__extendsfdf2		#
# main_raytrace.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC17)	# tmp245,
	lw	a2,%lo(.LC17)(a5)		#,
	lw	a3,%lo(.LC17+4)(a5)		#,
	call	__adddf3		#
# main_raytrace.c:191:     float s = 0.5*(dir.y + 1.0);
	lui	a5,%hi(.LC9)	# tmp247,
	lw	a2,%lo(.LC9)(a5)		#,
	lw	a3,%lo(.LC9+4)(a5)		#,
	call	__muldf3		#
# main_raytrace.c:191:     float s = 0.5*(dir.y + 1.0);
	call	__truncdfsf2		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a1,zero	#,
# main_raytrace.c:191:     float s = 0.5*(dir.y + 1.0);
	mv	s2,a0	# tmp249, tmp508
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	lui	a5,%hi(.LC12)	# tmp251,
	lw	a1,%lo(.LC12)(a5)		#,
	mv	s0,a0	# tmp250, tmp509
	mv	a0,s2	#, tmp249
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp250
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC18)	# tmp254,
	lw	a1,%lo(.LC18)(a5)		#,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# _397, tmp510
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s2	#, tmp249
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s0	#, tmp250
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lui	a5,%hi(.LC19)	# tmp257,
	lw	a1,%lo(.LC19)(a5)		#,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# _399, tmp511
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s2	#, tmp249
	call	__mulsf3		#
	lui	a5,%hi(.LC20)	# tmp259,
	lw	a1,%lo(.LC20)(a5)		#,
	mv	s3,a0	# tmp258, tmp512
	mv	a0,s2	#, tmp249
	call	__mulsf3		#
	mv	a1,a0	# tmp513,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s3	#, tmp258
.L180:
	call	__addsf3		#
# main_raytrace.c:41:   return V;
	lw	a5,16(sp)		# .result_ptr, %sfp
# main_raytrace.c:229: }
	lw	ra,444(sp)		#,
	lw	s2,432(sp)		#,
# main_raytrace.c:41:   return V;
	sw	s0,4(a5)	# _399, <retval>.y
# main_raytrace.c:229: }
	lw	s0,440(sp)		#,
# main_raytrace.c:41:   return V;
	sw	s1,0(a5)	# _397, <retval>.x
	sw	a0,8(a5)	# _35, <retval>.z
# main_raytrace.c:229: }
	lw	s1,436(sp)		#,
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
.L143:
	mv	s5,a2	# tmp233, tmp502
# main_raytrace.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	addi	a0,sp,80	#, tmp621,
	li	a2,12		#,
	mv	s6,a7	# depth, tmp507
	call	memcpy		#
	li	a2,12		#,
	mv	a1,s5	#, tmp233
	addi	a0,sp,64	#,,
	call	memcpy		#
	lw	a3,24(sp)		#, %sfp
	lw	a2,20(sp)		#, %sfp
	addi	a6,sp,312	#,,
	addi	a5,sp,120	#, tmp622,
	addi	a4,sp,108	#,,
	addi	a1,sp,64	#,,
	addi	a0,sp,80	#, tmp623,
	call	scene_intersect		#
# main_raytrace.c:190:   if (depth>2 || !scene_intersect(orig, dir, spheres, nb_spheres, &point, &N, &material)) {
	beq	a0,zero,.L145	#, tmp515,,
# main_raytrace.c:195:   vec3 reflect_dir = vec3_normalize(reflect(dir, N));
	li	a2,12		#,
	mv	a1,s5	#, tmp233
	addi	a0,sp,80	#, tmp624,
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,120	#, tmp625,
	addi	a0,sp,64	#,,
	call	memcpy		#
	addi	a2,sp,64	#,,
	addi	a1,sp,80	#, tmp626,
	addi	a0,sp,252	#, tmp627,
	call	reflect		#
	li	a2,12		#,
	addi	a1,sp,252	#, tmp628,
	addi	a0,sp,80	#, tmp629,
	call	memcpy		#
	addi	a1,sp,80	#, tmp630,
	addi	a0,sp,132	#,,
	call	vec3_normalize		#
# main_raytrace.c:196:   vec3 refract_dir = vec3_normalize(refract(dir, N, material.refractive_index, 1));
	li	a2,12		#,
	mv	a1,s5	#, tmp233
	addi	a0,sp,80	#, tmp631,
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,120	#, tmp632,
	addi	a0,sp,64	#,,
	call	memcpy		#
	lw	a3,312(sp)		#, material.refractive_index
	mv	a4,s1	#, tmp240
	addi	a2,sp,64	#,,
	addi	a1,sp,80	#, tmp633,
	addi	a0,sp,264	#, tmp634,
	call	refract		#
	li	a2,12		#,
	addi	a1,sp,264	#, tmp635,
	addi	a0,sp,80	#, tmp636,
	call	memcpy		#
	addi	a1,sp,80	#, tmp637,
	addi	a0,sp,144	#,,
	call	vec3_normalize		#
	lw	s7,120(sp)		# V$x, N.x
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,132(sp)		#, reflect_dir.x
	lw	s9,124(sp)		# V$y, N.y
	mv	a0,s7	#, V$x
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,136(sp)		#, reflect_dir.y
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# tmp312, tmp516
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, V$y
	call	__mulsf3		#
	mv	a1,a0	# tmp517,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp312
	call	__addsf3		#
	lw	s8,128(sp)		# V$z, N.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,140(sp)		#, reflect_dir.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# tmp314, tmp518
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp519,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp314
	call	__addsf3		#
# main_raytrace.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	lui	s1,%hi(.LC21)	# tmp492,
	lw	s2,108(sp)		# pretmp_406, point.x
	lw	s3,112(sp)		# pretmp_407, point.y
	lw	s4,116(sp)		# pretmp_408, point.z
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:198:   vec3 reflect_orig = vec3_dot(reflect_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	bge	a0,zero,.L175	#, tmp520,,
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s7	#, V$x
	call	__mulsf3		#
	mv	a1,a0	# tmp521,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s2	#, pretmp_406
	call	__subsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	s11,a0	# _381, tmp522
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s9	#, V$y
	call	__mulsf3		#
	mv	a1,a0	# tmp523,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s3	#, pretmp_407
	call	__subsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	s10,a0	# _383, tmp524
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s8	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp525,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	mv	a0,s4	#, pretmp_408
	call	__subsf3		#
.L148:
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:41:   return V;
	sw	a0,164(sp)	# _385, reflect_orig.z
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s7	#, V$x
# main_raytrace.c:41:   return V;
	sw	s11,156(sp)	# _381, reflect_orig.x
	sw	s10,160(sp)	# _383, reflect_orig.y
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	call	__mulsf3		#
	lw	a1,%lo(.LC21)(s1)		#,
	sw	a0,4(sp)	# tmp530, %sfp
	mv	a0,s9	#, V$y
	call	__mulsf3		#
	lw	a1,%lo(.LC21)(s1)		#,
	sw	a0,8(sp)	# tmp531, %sfp
	mv	a0,s8	#, V$z
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,144(sp)		#, refract_dir.x
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	sw	a0,12(sp)	# tmp532, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s7	#, V$x
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,148(sp)		#, refract_dir.y
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# tmp342, tmp533
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, V$y
	call	__mulsf3		#
	mv	a1,a0	# tmp534,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp342
	call	__addsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,152(sp)		#, refract_dir.z
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s1,a0	# tmp344, tmp535
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp536,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s1	#, tmp344
	call	__addsf3		#
# main_raytrace.c:199:   vec3 refract_orig = vec3_dot(refract_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	bge	a0,zero,.L176	#, tmp537,,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,4(sp)		#, %sfp
	mv	a0,s2	#, pretmp_406
	call	__subsf3		#
	lw	a1,8(sp)		#, %sfp
	mv	s10,a0	# _387, tmp538
	mv	a0,s3	#, pretmp_407
	call	__subsf3		#
	lw	a1,12(sp)		#, %sfp
	mv	s1,a0	# _389, tmp539
	mv	a0,s4	#, pretmp_408
	call	__subsf3		#
.L151:
# main_raytrace.c:41:   return V;
	sw	a0,176(sp)	# _391, refract_orig.z
# main_raytrace.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	li	a2,12		#,
	addi	a1,sp,156	#,,
	addi	a0,sp,80	#, tmp638,
# main_raytrace.c:41:   return V;
	sw	s1,172(sp)	# _389, refract_orig.y
	sw	s10,168(sp)	# _387, refract_orig.x
# main_raytrace.c:200:   vec3 reflect_color = cast_ray(reflect_orig, reflect_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,132	#,,
	addi	a0,sp,64	#,,
	call	memcpy		#
	lw	a6,44(sp)		#, %sfp
	lw	a4,24(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	addi	s6,s6,1	#, _8, depth
	mv	a7,s6	#, _8
	mv	a5,s0	#, lights
	addi	a2,sp,64	#,,
	addi	a1,sp,80	#, tmp639,
	addi	a0,sp,180	#,,
	call	cast_ray		#
# main_raytrace.c:201:   vec3 refract_color = cast_ray(refract_orig, refract_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	li	a2,12		#,
	addi	a1,sp,168	#,,
	addi	a0,sp,80	#, tmp640,
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,144	#,,
	addi	a0,sp,64	#,,
	call	memcpy		#
	lw	a6,44(sp)		#, %sfp
	lw	a4,24(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	mv	a7,s6	#, _8
	mv	a5,s0	#, lights
	addi	a2,sp,64	#,,
	addi	a1,sp,80	#, tmp641,
	addi	a0,sp,192	#,,
# main_raytrace.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	s1,zero	# specular_light_intensity,
# main_raytrace.c:201:   vec3 refract_color = cast_ray(refract_orig, refract_dir, spheres, nb_spheres, lights, nb_lights, depth + 1);
	call	cast_ray		#
# main_raytrace.c:203:   float diffuse_light_intensity = 0, specular_light_intensity = 0;
	mv	s6,s1	# diffuse_light_intensity,
# main_raytrace.c:204:   for (int i=0; i<nb_lights; i++) {
	sw	zero,28(sp)	#, %sfp
.L152:
# main_raytrace.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,28(sp)		# i, %sfp
	lw	a4,44(sp)		# nb_lights, %sfp
	blt	a5,a4,.L162	#, i, nb_lights,
# main_raytrace.c:224:   vec3 alu_rslt = vec3_scale(diffuse_light_intensity * material.albedo.x, material.diffuse_color);
	lw	a1,316(sp)		#, material.albedo.x
	mv	a0,s6	#, diffuse_light_intensity
	call	__mulsf3		#
# main_raytrace.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	lw	a1,320(sp)		#, material.albedo.y
# main_raytrace.c:224:   vec3 alu_rslt = vec3_scale(diffuse_light_intensity * material.albedo.x, material.diffuse_color);
	mv	s3,a0	# tmp471, tmp595
# main_raytrace.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	mv	a0,s1	#, specular_light_intensity
	call	__mulsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,332(sp)		#, material.diffuse_color.x
# main_raytrace.c:225:   alu_rslt = vec3_add(alu_rslt, vec3_scale(specular_light_intensity * material.albedo.y, make_vec3(1,1,1)));
	mv	s2,a0	# tmp472, tmp596
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp471
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s2	#, tmp472
	call	__addsf3		#
# main_raytrace.c:226:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.z, reflect_color));
	lw	s5,324(sp)		# _24, material.albedo.z
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,180(sp)		#, reflect_color.x
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp474, tmp597
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _24
	call	__mulsf3		#
	mv	a1,a0	# tmp598,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp474
	call	__addsf3		#
# main_raytrace.c:227:   alu_rslt = vec3_add(alu_rslt, vec3_scale(material.albedo.w, refract_color));
	lw	s4,328(sp)		# _25, material.albedo.w
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,192(sp)		#, refract_color.x
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp476, tmp599
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _25
	call	__mulsf3		#
	mv	a1,a0	# tmp600,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp476
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,336(sp)		#, material.diffuse_color.y
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s1,a0	# _397, tmp601
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp471
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s2	#, tmp472
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,184(sp)		#, reflect_color.y
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp480, tmp602
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _24
	call	__mulsf3		#
	mv	a1,a0	# tmp603,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp480
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,196(sp)		#, refract_color.y
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# tmp482, tmp604
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _25
	call	__mulsf3		#
	mv	a1,a0	# tmp605,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s0	#, tmp482
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,340(sp)		#, material.diffuse_color.z
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s0,a0	# _399, tmp606
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s3	#, tmp471
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s2	#, tmp472
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,188(sp)		#, reflect_color.z
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp486, tmp607
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s5	#, _24
	call	__mulsf3		#
	mv	a1,a0	# tmp608,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s2	#, tmp486
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,200(sp)		#, refract_color.z
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s2,a0	# tmp488, tmp609
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s4	#, _25
	call	__mulsf3		#
	mv	a1,a0	# tmp610,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a0,s2	#, tmp488
	j	.L180		#
.L175:
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s7	#, V$x
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s2	#, pretmp_406
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s11,a0	# _381, tmp527
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s9	#, V$y
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s3	#, pretmp_407
	call	__addsf3		#
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	lw	a1,%lo(.LC21)(s1)		#,
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	s10,a0	# _383, tmp528
# main_raytrace.c:54: static inline vec3 vec3_scale(float s, vec3 U) { return make_vec3(s*U.x, s*U.y, s*U.z); }
	mv	a0,s8	#, V$z
	call	__mulsf3		#
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	mv	a1,s4	#, pretmp_408
	call	__addsf3		#
	j	.L148		#
.L176:
	lw	a0,4(sp)		#, %sfp
	mv	a1,s2	#, pretmp_406
	call	__addsf3		#
	mv	s10,a0	# _387, tmp541
	lw	a0,8(sp)		#, %sfp
	mv	a1,s3	#, pretmp_407
	call	__addsf3		#
	mv	s1,a0	# _389, tmp542
	lw	a0,12(sp)		#, %sfp
	mv	a1,s4	#, pretmp_408
	call	__addsf3		#
	j	.L151		#
.L162:
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,4(s0)		#, MEM[(float *)_211 + 4B]
	mv	a1,s3	#, pretmp_407
	call	__subsf3		#
	mv	s11,a0	# tmp376, tmp544
	lw	a0,8(s0)		#, MEM[(float *)_211 + 8B]
	mv	a1,s4	#, pretmp_408
	call	__subsf3		#
	mv	s10,a0	# tmp377, tmp545
	lw	a0,0(s0)		#, MEM[(float *)_211]
	mv	a1,s2	#, pretmp_406
	call	__subsf3		#
# main_raytrace.c:205:     vec3  light_dir = vec3_normalize(vec3_sub(lights[i].position,point));
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a0,276(sp)	# tmp546, D.2133.x
# main_raytrace.c:205:     vec3  light_dir = vec3_normalize(vec3_sub(lights[i].position,point));
	addi	a1,sp,276	#, tmp642,
	addi	a0,sp,80	#, tmp643,
# main_raytrace.c:41:   return V;
	sw	s11,280(sp)	# tmp376, D.2133.y
	sw	s10,284(sp)	# tmp377, D.2133.z
# main_raytrace.c:205:     vec3  light_dir = vec3_normalize(vec3_sub(lights[i].position,point));
	call	memcpy		#
	addi	a1,sp,80	#, tmp644,
	addi	a0,sp,204	#, tmp645,
	call	vec3_normalize		#
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,0(s0)		#, MEM[(float *)_211]
	mv	a1,s2	#, pretmp_406
	call	__subsf3		#
	mv	s10,a0	# tmp385, tmp547
	lw	a0,4(s0)		#, MEM[(float *)_211 + 4B]
	mv	a1,s3	#, pretmp_407
	call	__subsf3		#
	sw	a0,32(sp)	# tmp386, %sfp
	lw	a0,8(s0)		#, MEM[(float *)_211 + 8B]
	mv	a1,s4	#, pretmp_408
	call	__subsf3		#
	mv	s11,a0	# tmp387, tmp549
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s10	#, tmp385
	mv	a0,s10	#, tmp11
	call	__mulsf3		#
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	lw	a5,32(sp)		# tmp386, %sfp
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	s10,a0	# tmp388, tmp550
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a5	#, tmp386
	mv	a0,a5	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp551,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s10	#, tmp388
	call	__addsf3		#
	mv	s10,a0	# tmp390, tmp552
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s11	#, tmp387
	mv	a0,s11	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp553,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s10	#, tmp390
	call	__addsf3		#
	call	sqrtf		#
	lw	a5,204(sp)		# U$x, light_dir.x
	sw	a0,52(sp)	# tmp554, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s7	#, V$x
	sw	a5,32(sp)	# U$x, %sfp
	lw	a5,208(sp)		# U$y, light_dir.y
	lw	a1,32(sp)		#, %sfp
	sw	a5,36(sp)	# U$y, %sfp
	lw	a5,212(sp)		# U$z, light_dir.z
	sw	a5,40(sp)	# U$z, %sfp
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,36(sp)		#, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s10,a0	# tmp393, tmp555
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s9	#, V$y
	call	__mulsf3		#
	mv	a1,a0	# tmp556,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp393
	call	__addsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,40(sp)		#, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s10,a0	# tmp395, tmp557
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s8	#, V$z
	call	__mulsf3		#
	mv	a1,a0	# tmp558,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp395
	call	__addsf3		#
# main_raytrace.c:208:     vec3 shadow_orig = vec3_dot(light_dir,N) < 0 ? vec3_sub(point,vec3_scale(1e-3,N)) : vec3_add(point,vec3_scale(1e-3,N));
	mv	a1,zero	#,
	call	__ltsf2		#
	bge	a0,zero,.L177	#, tmp559,,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a1,4(sp)		#, %sfp
	mv	a0,s2	#, pretmp_406
	call	__subsf3		#
	lw	a1,8(sp)		#, %sfp
	mv	s10,a0	# shadow_orig$x, tmp560
	mv	a0,s3	#, pretmp_407
	call	__subsf3		#
	lw	a1,12(sp)		#, %sfp
	mv	s11,a0	# shadow_orig$y, tmp561
	mv	a0,s4	#, pretmp_408
	call	__subsf3		#
.L179:
# main_raytrace.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	sw	a0,224(sp)	# shadow_orig$z, shadow_orig.z
	sw	a0,56(sp)	# shadow_orig$z, %sfp
	li	a2,12		#,
	addi	a1,sp,216	#, tmp649,
	addi	a0,sp,80	#, tmp650,
	sw	s10,216(sp)	# shadow_orig$x, shadow_orig.x
	sw	s11,220(sp)	# shadow_orig$y, shadow_orig.y
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,204	#, tmp651,
	addi	a0,sp,64	#,,
	call	memcpy		#
	lw	a3,24(sp)		#, %sfp
	lw	a2,20(sp)		#, %sfp
	addi	a6,sp,348	#, tmp652,
	addi	a5,sp,240	#, tmp653,
	addi	a4,sp,228	#, tmp654,
	addi	a1,sp,64	#,,
	addi	a0,sp,80	#, tmp655,
	call	scene_intersect		#
# main_raytrace.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	lw	a7,56(sp)		# shadow_orig$z, %sfp
	beq	a0,zero,.L156	#, tmp566,,
# main_raytrace.c:52: static inline vec3 vec3_sub(vec3 U, vec3 V)    { return make_vec3(U.x-V.x, U.y-V.y, U.z-V.z); }
	lw	a0,228(sp)		#, shadow_pt.x
	mv	a1,s10	#, shadow_orig$x
	sw	a7,60(sp)	# shadow_orig$z, %sfp
	call	__subsf3		#
	mv	s10,a0	# tmp418, tmp567
	lw	a0,232(sp)		#, shadow_pt.y
	mv	a1,s11	#, shadow_orig$y
	call	__subsf3		#
	lw	a7,60(sp)		# shadow_orig$z, %sfp
	sw	a0,56(sp)	# tmp419, %sfp
	lw	a0,236(sp)		#, shadow_pt.z
	mv	a1,a7	#, shadow_orig$z
	call	__subsf3		#
	mv	s11,a0	# tmp420, tmp569
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s10	#, tmp418
	mv	a0,s10	#, tmp11
	call	__mulsf3		#
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	lw	a5,56(sp)		# tmp419, %sfp
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	s10,a0	# tmp421, tmp570
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,a5	#, tmp419
	mv	a0,a5	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp571,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s10	#, tmp421
	call	__addsf3		#
	mv	s10,a0	# tmp423, tmp572
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a1,s11	#, tmp420
	mv	a0,s11	#, tmp11
	call	__mulsf3		#
	mv	a1,a0	# tmp573,
# main_raytrace.c:55: static inline float vec3_length(vec3 U)        { return sqrtf(U.x*U.x+U.y*U.y+U.z*U.z); }
	mv	a0,s10	#, tmp423
	call	__addsf3		#
	call	sqrtf		#
	mv	a1,a0	# tmp574,
# main_raytrace.c:212:     if (scene_intersect(shadow_orig, light_dir, spheres, nb_spheres, &shadow_pt, &shadow_N, &tmpmaterial) &&
	lw	a0,52(sp)		#, %sfp
	call	__gtsf2		#
	bgt	a0,zero,.L157	#, tmp575,,
.L156:
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,120(sp)		#, N.x
	lw	a0,32(sp)		#, %sfp
# main_raytrace.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	lw	s11,12(s0)		# _15, MEM[(float *)_211 + 12B]
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	call	__mulsf3		#
	mv	s10,a0	# tmp427, tmp576
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,124(sp)		#, N.y
	lw	a0,36(sp)		#, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp577,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp427
	call	__addsf3		#
	mv	s10,a0	# tmp429, tmp578
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a1,128(sp)		#, N.z
	lw	a0,40(sp)		#, %sfp
	call	__mulsf3		#
	mv	a1,a0	# tmp579,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,s10	#, tmp429
	call	__addsf3		#
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s10,a0	# iftmp.9_173, tmp580
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
	bge	a0,zero,.L158	#, tmp581,,
	mv	s10,zero	# iftmp.9_173,
.L158:
# main_raytrace.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	mv	a1,s10	#, iftmp.9_173
	mv	a0,s11	#, _15
	call	__mulsf3		#
	mv	a1,a0	# tmp582,
# main_raytrace.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	mv	a0,s6	#, diffuse_light_intensity
	call	__addsf3		#
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	lw	a5,32(sp)		# tmp656, %sfp
	li	s10,-2147483648		# tmp435,
# main_raytrace.c:218:     float abc = max(0.f, vec3_dot(vec3_neg(reflect(vec3_neg(light_dir), N)),dir));
	li	a2,12		#,
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	a5,s10,a5	# tmp656, tmp436, tmp435
# main_raytrace.c:41:   return V;
	sw	a5,288(sp)	# tmp436, D.2146.x
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	lw	a5,36(sp)		# tmp657, %sfp
# main_raytrace.c:218:     float abc = max(0.f, vec3_dot(vec3_neg(reflect(vec3_neg(light_dir), N)),dir));
	addi	a1,sp,288	#,,
# main_raytrace.c:216:     diffuse_light_intensity  += lights[i].intensity * max(0.f, vec3_dot(light_dir,N));
	mv	s6,a0	# diffuse_light_intensity, tmp583
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	a5,s10,a5	# tmp657, tmp438, tmp435
# main_raytrace.c:41:   return V;
	sw	a5,292(sp)	# tmp438, D.2146.y
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	lw	a5,40(sp)		# tmp658, %sfp
# main_raytrace.c:218:     float abc = max(0.f, vec3_dot(vec3_neg(reflect(vec3_neg(light_dir), N)),dir));
	addi	a0,sp,80	#, tmp659,
# main_raytrace.c:50: static inline vec3 vec3_neg(vec3 V)            { return make_vec3(-V.x, -V.y, -V.z); }
	xor	a5,s10,a5	# tmp658, tmp440, tmp435
# main_raytrace.c:41:   return V;
	sw	a5,296(sp)	# tmp440, D.2146.z
# main_raytrace.c:218:     float abc = max(0.f, vec3_dot(vec3_neg(reflect(vec3_neg(light_dir), N)),dir));
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,120	#,,
	addi	a0,sp,64	#,,
	call	memcpy		#
	addi	a2,sp,64	#,,
	addi	a1,sp,80	#, tmp660,
	addi	a0,sp,300	#,,
	call	reflect		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,300(sp)		# D.2147.x, D.2147.x
	lw	a1,0(s5)		#, dir.x
	xor	a0,a0,s10	# tmp435,, D.2147.x
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp455, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,304(sp)		# D.2147.y, D.2147.y
	lw	a1,48(sp)		#, %sfp
	xor	a0,a0,s10	# tmp435,, D.2147.y
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a5,32(sp)		# tmp455, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,a0	# tmp585,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,a5	#, tmp455
	call	__addsf3		#
	sw	a0,32(sp)	# tmp460, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a0,308(sp)		# D.2147.z, D.2147.z
	lw	a1,8(s5)		#, dir.z
	xor	a0,a0,s10	# tmp435,, D.2147.z
	call	__mulsf3		#
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	lw	a5,32(sp)		# tmp460, %sfp
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a1,a0	# tmp587,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	a0,a5	#, tmp460
	call	__addsf3		#
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
# main_raytrace.c:53: static inline float vec3_dot(vec3 U, vec3 V)   { return U.x*V.x+U.y*V.y+U.z*V.z; }
	mv	s10,a0	# tmp465, tmp588
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	call	__ltsf2		#
	blt	a0,zero,.L157	#, tmp589,,
# main_raytrace.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,s10	#, tmp465
	call	__gtsf2		#
	ble	a0,zero,.L157	#, tmp590,,
# main_raytrace.c:219:     float def = material.specular_exponent;
	lw	a5,344(sp)		# def, material.specular_exponent
# main_raytrace.c:220:     if(abc > 0.0f && def > 0.0f) {
	mv	a1,zero	#,
	mv	a0,a5	#, def
	sw	a5,32(sp)	# def, %sfp
	call	__gtsf2		#
	ble	a0,zero,.L157	#, tmp591,,
# main_raytrace.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	lw	a5,32(sp)		# def, %sfp
	mv	a0,s10	#, tmp465
	mv	a1,a5	#, def
	call	my_pow		#
	mv	a1,a0	# tmp592,
# main_raytrace.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	mv	a0,s11	#, _15
	call	__mulsf3		#
	mv	a1,a0	# tmp593,
# main_raytrace.c:221:        specular_light_intensity += my_pow(abc,def)*lights[i].intensity;
	mv	a0,s1	#, specular_light_intensity
	call	__addsf3		#
	mv	s1,a0	# specular_light_intensity, tmp594
.L157:
# main_raytrace.c:204:   for (int i=0; i<nb_lights; i++) {
	lw	a5,28(sp)		# i, %sfp
	addi	s0,s0,16	#, ivtmp.569, ivtmp.569
	addi	a5,a5,1	#, i, i
	sw	a5,28(sp)	# i, %sfp
	j	.L152		#
.L177:
# main_raytrace.c:51: static inline vec3 vec3_add(vec3 U, vec3 V)    { return make_vec3(U.x+V.x, U.y+V.y, U.z+V.z); }
	lw	a0,4(sp)		#, %sfp
	mv	a1,s2	#, pretmp_406
	call	__addsf3		#
	mv	s10,a0	# shadow_orig$x, tmp563
	lw	a0,8(sp)		#, %sfp
	mv	a1,s3	#, pretmp_407
	call	__addsf3		#
	mv	s11,a0	# shadow_orig$y, tmp564
	lw	a0,12(sp)		#, %sfp
	mv	a1,s4	#, pretmp_408
	call	__addsf3		#
	j	.L179		#
	.size	cast_ray, .-cast_ray
	.globl	__fixunssfsi
	.globl	__floatsisf
	.align	2
	.globl	set_pixel
	.type	set_pixel, @function
set_pixel:
	addi	sp,sp,-48	#,,
	sw	s6,16(sp)	#,
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	s6,%hi(.LC0)	# tmp127,
# main_raytrace.c:239: void set_pixel(volatile Pixel *fb, int x, int y, float r, float g, float b) {
	sw	s7,12(sp)	#,
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s7,%lo(.LC0)(s6)		# tmp126,
# main_raytrace.c:239: void set_pixel(volatile Pixel *fb, int x, int y, float r, float g, float b) {
	sw	s1,36(sp)	#,
	sw	s3,28(sp)	#,
	mv	s1,a1	# x, tmp205
	mv	s3,a0	# fb, tmp204
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s7	#, tmp126
	mv	a0,a3	#, r
# main_raytrace.c:239: void set_pixel(volatile Pixel *fb, int x, int y, float r, float g, float b) {
	sw	s0,40(sp)	#,
	sw	s2,32(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	ra,44(sp)	#,
	sw	s8,8(sp)	#,
	sw	s9,4(sp)	#,
# main_raytrace.c:239: void set_pixel(volatile Pixel *fb, int x, int y, float r, float g, float b) {
	mv	s2,a2	# y, tmp206
	mv	s5,a3	# r, tmp207
	mv	s4,a4	# g, tmp208
	mv	s0,a5	# b, tmp209
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	call	__gtsf2		#
	bgt	a0,zero,.L188	#, tmp210,,
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s5	#, r
	call	__ltsf2		#
	blt	a0,zero,.L189	#, tmp211,,
.L182:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s7,%lo(.LC0)(s6)		# tmp130,
	mv	a0,s4	#, g
	mv	a1,s7	#, tmp130
	call	__gtsf2		#
	bgt	a0,zero,.L190	#, tmp212,,
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s4	#, g
	call	__ltsf2		#
	blt	a0,zero,.L191	#, tmp213,,
.L183:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s6,%lo(.LC0)(s6)		# tmp134,
	mv	a0,s0	#, b
	mv	a1,s6	#, tmp134
	call	__gtsf2		#
	bgt	a0,zero,.L192	#, tmp214,,
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	a1,zero	#,
	mv	a0,s0	#, b
	call	__ltsf2		#
	blt	a0,zero,.L193	#, tmp215,,
.L184:
# main_raytrace.c:243:      uint8_t R = (uint8_t)(255.0f * r);
	lui	s7,%hi(.LC23)	# tmp138,
	lw	a1,%lo(.LC23)(s7)		#,
	mv	a0,s5	#, r
	call	__mulsf3		#
# main_raytrace.c:243:      uint8_t R = (uint8_t)(255.0f * r);
	call	__fixunssfsi		#
# main_raytrace.c:244:      uint8_t G = (uint8_t)(255.0f * g);
	lw	a1,%lo(.LC23)(s7)		#,
# main_raytrace.c:243:      uint8_t R = (uint8_t)(255.0f * r);
	andi	s6,a0,0xff	# R, tmp216
# main_raytrace.c:244:      uint8_t G = (uint8_t)(255.0f * g);
	mv	a0,s4	#, g
	call	__mulsf3		#
# main_raytrace.c:244:      uint8_t G = (uint8_t)(255.0f * g);
	call	__fixunssfsi		#
# main_raytrace.c:245:      uint8_t B = (uint8_t)(255.0f * b);
	lw	a1,%lo(.LC23)(s7)		#,
# main_raytrace.c:244:      uint8_t G = (uint8_t)(255.0f * g);
	andi	s5,a0,0xff	# G, tmp217
# main_raytrace.c:245:      uint8_t B = (uint8_t)(255.0f * b);
	mv	a0,s0	#, b
	call	__mulsf3		#
# main_raytrace.c:245:      uint8_t B = (uint8_t)(255.0f * b);
	call	__fixunssfsi		#
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	andi	a4,s1,3	#, tmp152, x
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	lui	a5,%hi(.LANCHOR0)	# tmp151,
	slli	a4,a4,2	#, tmp154, tmp152
	addi	a5,a5,%lo(.LANCHOR0)	# tmp150, tmp151,
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	andi	a3,s2,3	#, tmp153, y
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	add	a5,a5,a4	# tmp154, tmp155, tmp150
	add	a5,a5,a3	# tmp153, tmp156, tmp155
	lbu	a5,0(a5)	# _7, dither[_5][_6]
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	andi	a4,s6,15	#, tmp167, R
# main_raytrace.c:245:      uint8_t B = (uint8_t)(255.0f * b);
	andi	s7,a0,0xff	# B, tmp218
# main_raytrace.c:247:      uint8_t GOFF = (G & 15) > dither[x&3][y&3];
	andi	s8,s5,15	#, tmp159, G
# main_raytrace.c:248:      uint8_t BOFF = (B & 15) > dither[x&3][y&3];
	andi	a0,a0,15	#, tmp163, tmp218
	sltu	s4,a5,a0	# tmp163, _10, _7
# main_raytrace.c:247:      uint8_t GOFF = (G & 15) > dither[x&3][y&3];
	sgtu	s8,s8,a5	# _9, tmp159, _7
# main_raytrace.c:249:      R = min((R>>4) + ROFF, 15);
	srli	a0,s6,4	#, tmp170, R
# main_raytrace.c:246:      uint8_t ROFF = (R & 15) > dither[x&3][y&3];
	sltu	a5,a5,a4	# tmp167, tmp168, _7
# main_raytrace.c:249:      R = min((R>>4) + ROFF, 15);
	add	a0,a5,a0	# tmp170,, tmp168
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lui	s6,%hi(.LC22)	# tmp173,
# main_raytrace.c:249:      R = min((R>>4) + ROFF, 15);
	call	__floatsisf		#
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s9,%lo(.LC22)(s6)		# tmp172,
# main_raytrace.c:249:      R = min((R>>4) + ROFF, 15);
	mv	s0,a0	# _15, tmp219
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s9	#, tmp172
	call	__ltsf2		#
	blt	a0,zero,.L185	#, tmp220,,
	mv	s0,s9	# _15, tmp172
.L185:
# main_raytrace.c:249:      R = min((R>>4) + ROFF, 15);
	mv	a0,s0	#, _15
	call	__fixunssfsi		#
	andi	s0,a0,0xff	# R, tmp221
# main_raytrace.c:250:      G = min((G>>4) + GOFF, 15);
	srli	a0,s5,4	#, tmp178, G
# main_raytrace.c:250:      G = min((G>>4) + GOFF, 15);
	add	a0,a0,s8	# _9,, tmp178
	call	__floatsisf		#
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s8,%lo(.LC22)(s6)		# tmp180,
# main_raytrace.c:250:      G = min((G>>4) + GOFF, 15);
	mv	s5,a0	# _20, tmp222
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s8	#, tmp180
	call	__ltsf2		#
	blt	a0,zero,.L186	#, tmp223,,
	mv	s5,s8	# _20, tmp180
.L186:
# main_raytrace.c:250:      G = min((G>>4) + GOFF, 15);
	mv	a0,s5	#, _20
	call	__fixunssfsi		#
	andi	s5,a0,0xff	# G, tmp224
# main_raytrace.c:251:      B = min((B>>4) + BOFF, 15);
	srli	a0,s7,4	#, tmp186, B
# main_raytrace.c:251:      B = min((B>>4) + BOFF, 15);
	add	a0,a0,s4	# _10,, tmp186
	call	__floatsisf		#
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	lw	s6,%lo(.LC22)(s6)		# tmp188,
# main_raytrace.c:251:      B = min((B>>4) + BOFF, 15);
	mv	s4,a0	# _25, tmp225
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	a1,s6	#, tmp188
	call	__ltsf2		#
	blt	a0,zero,.L187	#, tmp226,,
	mv	s4,s6	# _25, tmp188
.L187:
# main_raytrace.c:251:      B = min((B>>4) + BOFF, 15);
	mv	a0,s4	#, _25
	call	__fixunssfsi		#
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	slli	s5,s5,6	#, tmp192, G
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	slli	s0,s0,11	#, tmp191, R
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	or	s0,s0,s5	# tmp192, tmp195, tmp191
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	andi	a0,a0,0xff	# B, tmp227
	or	s0,s0,a0	# B, tmp200, tmp195
	slli	a3,s0,16	#,, tmp200
# main_raytrace.c:287: }
	lw	s0,40(sp)		#,
	lw	ra,44(sp)		#,
	lw	s4,24(sp)		#,
	lw	s5,20(sp)		#,
	lw	s6,16(sp)		#,
	lw	s7,12(sp)		#,
	lw	s8,8(sp)		#,
	lw	s9,4(sp)		#,
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	mv	a2,s2	#, y
	mv	a1,s1	#, x
# main_raytrace.c:287: }
	lw	s2,32(sp)		#,
	lw	s1,36(sp)		#,
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	mv	a0,s3	#, fb
# main_raytrace.c:287: }
	lw	s3,28(sp)		#,
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	srai	a3,a3,16	#,,
# main_raytrace.c:287: }
	addi	sp,sp,48	#,,
# main_raytrace.c:253:      setpixel(fb, x, y, (R<<11) | (G<<6) | B );
	tail	setpixel		#
.L188:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	s5,s7	# r, tmp126
	j	.L182		#
.L189:
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s5,zero	# r,
	j	.L182		#
.L190:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	s4,s7	# g, tmp130
	j	.L183		#
.L191:
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s4,zero	# g,
	j	.L183		#
.L192:
# main_raytrace.c:33: static inline float min(float x, float y) { return x<y?x:y; }
	mv	s0,s6	# b, tmp134
	j	.L184		#
.L193:
# main_raytrace.c:32: static inline float max(float x, float y) { return x>y?x:y; }
	mv	s0,zero	# b,
	j	.L184		#
	.size	set_pixel, .-set_pixel
	.section	.rodata.str1.4
	.align	2
.LC24:
	.string	"rdcycle       :"
	.align	2
.LC25:
	.string	"rdinstret     :"
	.text
	.align	2
	.globl	show_csr_timer_cnt
	.type	show_csr_timer_cnt, @function
show_csr_timer_cnt:
	addi	sp,sp,-48	#,,
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# main_raytrace.c:295:   asm volatile ("rdcycleh %0" : "=r"(tmph0));
 #APP
# 295 "main_raytrace.c" 1
	rdcycleh a5	# tmp84
# 0 "" 2
 #NO_APP
	sw	a5,16(sp)	# tmp84, tmph0
# main_raytrace.c:296:   asm volatile ("rdcycle  %0" : "=r"(tmpl0));
 #APP
# 296 "main_raytrace.c" 1
	rdcycle  a5	# tmp85
# 0 "" 2
 #NO_APP
	sw	a5,20(sp)	# tmp85, tmpl0
# main_raytrace.c:298:   asm volatile ("rdinstreth %0" : "=r"(tmph1));
 #APP
# 298 "main_raytrace.c" 1
	rdinstreth a5	# tmp86
# 0 "" 2
 #NO_APP
	sw	a5,24(sp)	# tmp86, tmph1
# main_raytrace.c:299:   asm volatile ("rdinstret %0"  : "=r"(tmpl1));
 #APP
# 299 "main_raytrace.c" 1
	rdinstret a5	# tmp87
# 0 "" 2
 #NO_APP
	sw	a5,28(sp)	# tmp87, tmpl1
# main_raytrace.c:301:   uint64_t rdcycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	a1,16(sp)		# tmph0.19_1, tmph0
# main_raytrace.c:304:   putchar(10);
	li	a0,10		#,
# main_raytrace.c:301:   uint64_t rdcycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
	lw	s2,20(sp)		# tmpl0.20_4, tmpl0
# main_raytrace.c:301:   uint64_t rdcycles    = ((uint64_t)(tmph0)<<32) + tmpl0;
	sw	a1,12(sp)	# tmph0.19_1, %sfp
# main_raytrace.c:302:   uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;
	lw	s0,24(sp)		# tmph1.21_6, tmph1
# main_raytrace.c:302:   uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;
	lw	s1,28(sp)		# tmpl1.22_9, tmpl1
# main_raytrace.c:304:   putchar(10);
	call	putchar		#
# main_raytrace.c:305:   print_str("rdcycle       :");
	lui	a0,%hi(.LC24)	# tmp104,
	addi	a0,a0,%lo(.LC24)	#, tmp104,
	call	print_str		#
# main_raytrace.c:306:   print_dec64(rdcycles);
	lw	a1,12(sp)		# tmph0.19_1, %sfp
	mv	a0,s2	#, tmpl0.20_4
	call	print_dec64		#
# main_raytrace.c:307:   putchar(10);
	li	a0,10		#,
	call	putchar		#
# main_raytrace.c:308:   print_str("rdinstret     :");
	lui	a0,%hi(.LC25)	# tmp105,
	addi	a0,a0,%lo(.LC25)	#, tmp105,
	call	print_str		#
# main_raytrace.c:309:   print_dec64(rdinstret);
	mv	a0,s1	#, tmpl1.22_9
	mv	a1,s0	#, tmph1.21_6
	call	print_dec64		#
# main_raytrace.c:310:   putchar(10);
	li	a0,10		#,
	call	putchar		#
# main_raytrace.c:312: }
	lw	s0,40(sp)		#,
	lw	ra,44(sp)		#,
	lw	s1,36(sp)		#,
	lw	s2,32(sp)		#,
# main_raytrace.c:311:   putchar(10);
	li	a0,10		#,
# main_raytrace.c:312: }
	addi	sp,sp,48	#,,
# main_raytrace.c:311:   putchar(10);
	tail	putchar		#
	.size	show_csr_timer_cnt, .-show_csr_timer_cnt
	.section	.rodata.str1.4
	.align	2
.LC26:
	.string	"Y:"
	.globl	__floatsidf
	.globl	__subdf3
	.globl	__divdf3
	.text
	.align	2
	.globl	render
	.type	render, @function
render:
	addi	sp,sp,-176	#,,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC27)	# tmp97,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s8,136(sp)	#,
	sw	s9,132(sp)	#,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	s8,%lo(.LC27)(a5)		# tmp96,
	lw	s9,%lo(.LC27+4)(a5)		#,
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lui	a5,%hi(.LC9)	# tmp99,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s0,168(sp)	#,
	sw	s1,164(sp)	#,
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lw	s0,%lo(.LC9)(a5)		# tmp136,
	lw	s1,%lo(.LC9+4)(a5)		#,
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lui	a5,%hi(.LC28)	# tmp101,
	lw	a6,%lo(.LC28+4)(a5)		#,
	lw	a5,%lo(.LC28)(a5)		# tmp137,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s4,152(sp)	#,
	sw	s5,148(sp)	#,
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	sw	a5,16(sp)	# tmp137, %sfp
# main_raytrace.c:336:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	lui	a5,%hi(.LC29)	# tmp107,
	lw	s4,%lo(.LC29)(a5)		# tmp139,
	lw	s5,%lo(.LC29+4)(a5)		#,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lui	a5,%hi(.LC30)	# tmp111,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s6,144(sp)	#,
	sw	s7,140(sp)	#,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	s6,%lo(.LC30)(a5)		# tmp140,
	lw	s7,%lo(.LC30+4)(a5)		#,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	s10,128(sp)	#,
	sw	s11,124(sp)	#,
	sw	ra,172(sp)	#,
	sw	s2,160(sp)	#,
	sw	s3,156(sp)	#,
# main_raytrace.c:315: void render(volatile Pixel *fb, Sphere* spheres, int nb_spheres, Light* lights, int nb_lights) {
	sw	a0,0(sp)	# tmp141, %sfp
	sw	a1,4(sp)	# tmp142, %sfp
	sw	a2,8(sp)	# tmp143, %sfp
	sw	a3,12(sp)	# tmp144, %sfp
	sw	a4,24(sp)	# tmp145, %sfp
# main_raytrace.c:322:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	li	s10,0		# j,
# main_raytrace.c:323:     print_str("Y:");
	lui	s11,%hi(.LC26)	# tmp95,
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	sw	a6,20(sp)	#, %sfp
.L199:
# main_raytrace.c:323:     print_str("Y:");
	addi	a0,s11,%lo(.LC26)	#, tmp95,
	call	print_str		#
# main_raytrace.c:324:     print_dec(j);
	mv	a0,s10	#, j
	call	print_dec		#
# main_raytrace.c:325:     putchar(10);
	li	a0,10		#,
	call	putchar		#
# main_raytrace.c:334:     for (int i = 0; i<HRENDER; i++) {
	li	s2,0		# i,
# main_raytrace.c:326:     show_csr_timer_cnt();
	call	show_csr_timer_cnt		#
.L198:
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	a0,s8	#, tmp96
	mv	a1,s9	#,
	call	tan		#
# main_raytrace.c:41:   return V;
	mv	a5,zero	# tmp160,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a0,28(sp)	# _8, %sfp
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	mv	a0,s2	#, i
# main_raytrace.c:41:   return V;
	sw	a5,76(sp)	# tmp160, D.2162.x
	sw	a5,80(sp)	# tmp161, D.2162.y
	sw	a5,84(sp)	# tmp162, D.2162.z
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	s3,a1	# _8, tmp155
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	call	__floatsidf		#
	mv	a2,s0	#, tmp136
	mv	a3,s1	#,
	call	__adddf3		#
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	lw	a2,16(sp)		#, %sfp
	lw	a3,20(sp)		#, %sfp
	call	__subdf3		#
# main_raytrace.c:335:       float dir_x =  (i + 0.5) - HRENDER/2.;
	call	__truncdfsf2		#
	sw	a0,88(sp)	# tmp147, D.2163.x
# main_raytrace.c:336:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	mv	a0,s10	#, j
	call	__floatsidf		#
	mv	a2,s0	#, tmp136
	mv	a3,s1	#,
	call	__adddf3		#
	mv	a2,a0	# tmp148,
	mv	a3,a1	#,
# main_raytrace.c:336:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	mv	a0,s4	#, tmp139
	mv	a1,s5	#,
	call	__subdf3		#
# main_raytrace.c:336:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	call	__truncdfsf2		#
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	lw	a4,28(sp)		# _8, %sfp
# main_raytrace.c:336:       float dir_y = -(j + 0.5) + VRENDER/2.;    // this flips the image at the same time
	sw	a0,92(sp)	# tmp149, D.2163.y
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	a3,s3	#, _8
	mv	a2,a4	# tmp156, _8
	mv	a0,a4	# tmp157, _8
	mv	a1,s3	#, _8
	call	__adddf3		#
	mv	a3,a1	#,
	mv	a2,a0	# tmp150,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	mv	a1,s7	#,
	mv	a0,s6	#, tmp140
	call	__divdf3		#
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	call	__truncdfsf2		#
# main_raytrace.c:338:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	li	a2,12		#,
# main_raytrace.c:337:       float dir_z = -VRENDER/(2.*tan(fov/2.));
	sw	a0,96(sp)	# tmp151, D.2163.z
# main_raytrace.c:338:       vec3 C = cast_ray(make_vec3(0,0,0), vec3_normalize(make_vec3(dir_x, dir_y, dir_z)), spheres, nb_spheres, lights, nb_lights, 0);
	addi	a1,sp,88	#,,
	addi	a0,sp,48	#, tmp163,
	call	memcpy		#
	addi	a1,sp,48	#, tmp164,
	addi	a0,sp,100	#, tmp165,
	call	vec3_normalize		#
	li	a2,12		#,
	addi	a1,sp,76	#,,
	addi	a0,sp,48	#, tmp166,
	call	memcpy		#
	li	a2,12		#,
	addi	a1,sp,100	#, tmp167,
	addi	a0,sp,32	#,,
	call	memcpy		#
	lw	a6,24(sp)		#, %sfp
	lw	a5,12(sp)		#, %sfp
	lw	a4,8(sp)		#, %sfp
	lw	a3,4(sp)		#, %sfp
	li	a7,0		#,
	addi	a2,sp,32	#,,
	addi	a1,sp,48	#, tmp168,
	addi	a0,sp,64	#,,
	call	cast_ray		#
# main_raytrace.c:339:       set_pixel(fb, i,j,C.x,C.y,C.z);
	lw	a5,72(sp)		#, C.z
	lw	a4,68(sp)		#, C.y
	lw	a3,64(sp)		#, C.x
	lw	a0,0(sp)		#, %sfp
	mv	a1,s2	#, i
	mv	a2,s10	#, j
	call	set_pixel		#
# main_raytrace.c:334:     for (int i = 0; i<HRENDER; i++) {
	addi	s2,s2,1	#, i, i
# main_raytrace.c:334:     for (int i = 0; i<HRENDER; i++) {
	li	a5,96		# tmp134,
	bne	s2,a5,.L198	#, i, tmp134,
# main_raytrace.c:322:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	addi	s10,s10,1	#, j, j
# main_raytrace.c:322:   for (int j = 0; j<VRENDER; j++) { // actual rendering loop
	li	a5,64		# tmp135,
	bne	s10,a5,.L199	#, j, tmp135,
# main_raytrace.c:357: }
	lw	ra,172(sp)		#,
	lw	s0,168(sp)		#,
	lw	s1,164(sp)		#,
	lw	s2,160(sp)		#,
	lw	s3,156(sp)		#,
	lw	s4,152(sp)		#,
	lw	s5,148(sp)		#,
	lw	s6,144(sp)		#,
	lw	s7,140(sp)		#,
	lw	s8,136(sp)		#,
	lw	s9,132(sp)		#,
	lw	s10,128(sp)		#,
	lw	s11,124(sp)		#,
	addi	sp,sp,176	#,,
	jr	ra		#
	.size	render, .-render
	.align	2
	.globl	init_scene
	.type	init_scene, @function
init_scene:
	addi	sp,sp,-464	#,,
# main_raytrace.c:47:   return V;
	lui	a5,%hi(.LC31)	# tmp72,
# main_raytrace.c:365: void init_scene() {
	sw	s3,444(sp)	#,
# main_raytrace.c:47:   return V;
	lw	s3,%lo(.LC31)(a5)		# tmp73,
	lui	a5,%hi(.LC11)	# tmp74,
# main_raytrace.c:365: void init_scene() {
	sw	s4,440(sp)	#,
# main_raytrace.c:47:   return V;
	lw	s4,%lo(.LC11)(a5)		# tmp75,
	lui	a5,%hi(.LC13)	# tmp76,
# main_raytrace.c:365: void init_scene() {
	sw	s1,452(sp)	#,
# main_raytrace.c:47:   return V;
	lw	s1,%lo(.LC13)(a5)		# tmp77,
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC32)	# tmp78,
	lw	a5,%lo(.LC32)(a5)		# tmp79,
# main_raytrace.c:365: void init_scene() {
	sw	s6,432(sp)	#,
# main_raytrace.c:366:     Material      ivory = make_Material(1.0, make_vec4(0.6,  0.3, 0.1, 0.0), make_vec3(0.4, 0.4, 0.3),   50.);
	addi	a1,sp,224	#,,
# main_raytrace.c:47:   return V;
	mv	s6,zero	# tmp306,
# main_raytrace.c:366:     Material      ivory = make_Material(1.0, make_vec4(0.6,  0.3, 0.1, 0.0), make_vec3(0.4, 0.4, 0.3),   50.);
	li	a2,16		#,
	addi	a0,sp,64	#, tmp307,
# main_raytrace.c:365: void init_scene() {
	sw	ra,460(sp)	#,
	sw	s0,456(sp)	#,
	sw	s2,448(sp)	#,
	sw	s5,436(sp)	#,
# main_raytrace.c:41:   return V;
	sw	a5,92(sp)	# tmp79, D.2166.x
	sw	a5,96(sp)	# tmp79, D.2166.y
# main_raytrace.c:47:   return V;
	sw	s3,224(sp)	# tmp73, D.2165.x
	sw	s4,228(sp)	# tmp75, D.2165.y
	sw	s1,232(sp)	# tmp77, D.2165.z
	sw	s6,236(sp)	# tmp306, D.2165.w
# main_raytrace.c:41:   return V;
	sw	s4,100(sp)	# tmp75, D.2166.z
# main_raytrace.c:366:     Material      ivory = make_Material(1.0, make_vec4(0.6,  0.3, 0.1, 0.0), make_vec3(0.4, 0.4, 0.3),   50.);
	call	memcpy		#
	addi	a1,sp,92	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp308,
	call	memcpy		#
	lui	a5,%hi(.LC33)	# tmp94,
	lw	s5,%lo(.LC33)(a5)		# tmp93,
	lui	a5,%hi(.LC0)	# tmp98,
	lw	s0,%lo(.LC0)(a5)		# tmp97,
	mv	a4,s5	#, tmp93
	addi	a3,sp,48	#, tmp309,
	addi	a2,sp,64	#, tmp310,
	mv	a1,s0	#, tmp97
	addi	a0,sp,288	#, tmp311,
	call	make_Material		#
# main_raytrace.c:47:   return V;
	lui	a5,%hi(.LC19)	# tmp99,
	lw	a5,%lo(.LC19)(a5)		# tmp100,
# main_raytrace.c:367:     Material      glass = make_Material(1.5, make_vec4(0.0,  0.5, 0.1, 0.8), make_vec3(0.6, 0.7, 0.8),  125.);
	addi	a1,sp,240	#,,
	li	a2,16		#,
# main_raytrace.c:47:   return V;
	sw	a5,244(sp)	# tmp100, D.2167.y
	lui	a5,%hi(.LC20)	# tmp103,
	lw	s2,%lo(.LC20)(a5)		# tmp104,
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC18)	# tmp107,
	lw	a5,%lo(.LC18)(a5)		# tmp108,
# main_raytrace.c:367:     Material      glass = make_Material(1.5, make_vec4(0.0,  0.5, 0.1, 0.8), make_vec3(0.6, 0.7, 0.8),  125.);
	addi	a0,sp,64	#, tmp313,
# main_raytrace.c:47:   return V;
	sw	s6,240(sp)	# tmp312, D.2167.x
# main_raytrace.c:41:   return V;
	sw	a5,108(sp)	# tmp108, D.2168.y
# main_raytrace.c:47:   return V;
	sw	s1,248(sp)	# tmp77, D.2167.z
	sw	s2,252(sp)	# tmp104, D.2167.w
# main_raytrace.c:41:   return V;
	sw	s3,104(sp)	# tmp73, D.2168.x
	sw	s2,112(sp)	# tmp104, D.2168.z
# main_raytrace.c:367:     Material      glass = make_Material(1.5, make_vec4(0.0,  0.5, 0.1, 0.8), make_vec3(0.6, 0.7, 0.8),  125.);
	call	memcpy		#
	addi	a1,sp,104	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp314,
	call	memcpy		#
	lui	a5,%hi(.LC35)	# tmp125,
	lw	s3,%lo(.LC35)(a5)		# tmp124,
	lui	a5,%hi(.LC34)	# tmp121,
	lw	a4,%lo(.LC34)(a5)		#,
	addi	a3,sp,48	#, tmp315,
	addi	a2,sp,64	#, tmp316,
	mv	a1,s3	#, tmp124
	addi	a0,sp,324	#, tmp317,
	call	make_Material		#
# main_raytrace.c:47:   return V;
	lui	a5,%hi(.LC36)	# tmp126,
	lw	a5,%lo(.LC36)(a5)		# tmp127,
# main_raytrace.c:368:     Material red_rubber = make_Material(1.0, make_vec4(0.9,  0.1, 0.0, 0.0), make_vec3(0.3, 0.1, 0.1),   10.);
	addi	a1,sp,256	#,,
	li	a2,16		#,
	addi	a0,sp,64	#, tmp320,
# main_raytrace.c:47:   return V;
	sw	a5,256(sp)	# tmp127, D.2169.x
	sw	s1,260(sp)	# tmp77, D.2169.y
	sw	s6,264(sp)	# tmp318, D.2169.z
	sw	s6,268(sp)	# tmp319, D.2169.w
# main_raytrace.c:41:   return V;
	sw	s4,116(sp)	# tmp75, D.2170.x
	sw	s1,120(sp)	# tmp77, D.2170.y
	sw	s1,124(sp)	# tmp77, D.2170.z
# main_raytrace.c:368:     Material red_rubber = make_Material(1.0, make_vec4(0.9,  0.1, 0.0, 0.0), make_vec3(0.3, 0.1, 0.1),   10.);
	call	memcpy		#
	addi	a1,sp,116	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp321,
	call	memcpy		#
	lui	a5,%hi(.LC37)	# tmp146,
	lw	s1,%lo(.LC37)(a5)		# tmp145,
	addi	a3,sp,48	#, tmp322,
	addi	a2,sp,64	#, tmp323,
	mv	a4,s1	#, tmp145
	mv	a1,s0	#, tmp97
	addi	a0,sp,360	#, tmp324,
	call	make_Material		#
# main_raytrace.c:369:     Material     mirror = make_Material(1.0, make_vec4(0.0, 10.0, 0.8, 0.0), make_vec3(1.0, 1.0, 1.0),  142.);
	addi	a1,sp,272	#,,
	li	a2,16		#,
	addi	a0,sp,64	#, tmp327,
# main_raytrace.c:47:   return V;
	sw	s6,272(sp)	# tmp325, D.2171.x
	sw	s1,276(sp)	# tmp145, D.2171.y
	sw	s2,280(sp)	# tmp104, D.2171.z
	sw	s6,284(sp)	# tmp326, D.2171.w
# main_raytrace.c:41:   return V;
	sw	s0,128(sp)	# tmp97, D.2172.x
	sw	s0,132(sp)	# tmp97, D.2172.y
	sw	s0,136(sp)	# tmp97, D.2172.z
# main_raytrace.c:369:     Material     mirror = make_Material(1.0, make_vec4(0.0, 10.0, 0.8, 0.0), make_vec3(1.0, 1.0, 1.0),  142.);
	call	memcpy		#
	addi	a1,sp,128	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp328,
	call	memcpy		#
	lui	a5,%hi(.LC38)	# tmp171,
	lw	a4,%lo(.LC38)(a5)		#,
	addi	a3,sp,48	#, tmp329,
	addi	a2,sp,64	#, tmp330,
	mv	a1,s0	#, tmp97
	addi	a0,sp,396	#, tmp331,
	call	make_Material		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC39)	# tmp176,
	lw	a5,%lo(.LC39)(a5)		# tmp177,
# main_raytrace.c:371:     spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	addi	a1,sp,140	#,,
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a5,140(sp)	# tmp177, D.2173.x
	lui	a5,%hi(.LC40)	# tmp178,
	lw	a5,%lo(.LC40)(a5)		# tmp179,
# main_raytrace.c:371:     spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	addi	a0,sp,48	#, tmp333,
# main_raytrace.c:41:   return V;
	sw	s6,144(sp)	# tmp332, D.2173.y
	sw	a5,148(sp)	# tmp179, D.2173.z
# main_raytrace.c:371:     spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	call	memcpy		#
	addi	a1,sp,288	#, tmp334,
	li	a2,36		#,
	mv	a0,sp	#,
	call	memcpy		#
	lui	a5,%hi(.LC41)	# tmp192,
	lw	s1,%lo(.LC41)(a5)		# tmp191,
	lui	s2,%hi(.LANCHOR1)	# tmp181,
	mv	a3,sp	#,
	mv	a2,s1	#, tmp191
	addi	a1,sp,48	#, tmp335,
	addi	a0,s2,%lo(.LANCHOR1)	#, tmp181,
	call	make_Sphere		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC2)	# tmp194,
	lw	a5,%lo(.LC2)(a5)		# tmp195,
# main_raytrace.c:372:     spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	addi	a1,sp,152	#,,
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a5,152(sp)	# tmp195, D.2174.x
	lui	a5,%hi(.LC42)	# tmp196,
	lw	a5,%lo(.LC42)(a5)		# tmp197,
# main_raytrace.c:372:     spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	addi	a0,sp,48	#, tmp336,
# main_raytrace.c:371:     spheres[0] = make_Sphere(make_vec3(-3,    0,   -16), 2,      ivory);
	addi	s0,s2,%lo(.LANCHOR1)	# tmp180, tmp181,
# main_raytrace.c:41:   return V;
	sw	a5,156(sp)	# tmp197, D.2174.y
	lui	a5,%hi(.LC43)	# tmp198,
	lw	a5,%lo(.LC43)(a5)		# tmp199,
# main_raytrace.c:372:     spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	addi	s2,s0,52	#, tmp202, tmp180
# main_raytrace.c:41:   return V;
	sw	a5,160(sp)	# tmp199, D.2174.z
# main_raytrace.c:372:     spheres[1] = make_Sphere(make_vec3(-1.0, -1.5, -12), 2,      glass);
	call	memcpy		#
	addi	a1,sp,324	#, tmp337,
	li	a2,36		#,
	mv	a0,sp	#,
	call	memcpy		#
	mv	a3,sp	#,
	mv	a2,s1	#, tmp191
	addi	a1,sp,48	#, tmp338,
	mv	a0,s2	#, tmp202
	call	make_Sphere		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC44)	# tmp217,
	lw	a5,%lo(.LC44)(a5)		# tmp218,
# main_raytrace.c:373:     spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	addi	a1,sp,164	#,,
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a5,168(sp)	# tmp218, D.2175.y
	lui	a5,%hi(.LC45)	# tmp219,
	lw	s1,%lo(.LC45)(a5)		# tmp220,
# main_raytrace.c:373:     spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	addi	a0,sp,48	#, tmp339,
# main_raytrace.c:41:   return V;
	sw	s3,164(sp)	# tmp124, D.2175.x
	sw	s1,172(sp)	# tmp220, D.2175.z
# main_raytrace.c:373:     spheres[2] = make_Sphere(make_vec3( 1.5, -0.5, -18), 3, red_rubber);
	call	memcpy		#
	addi	a1,sp,360	#, tmp340,
	li	a2,36		#,
	mv	a0,sp	#,
	call	memcpy		#
	lui	a5,%hi(.LC46)	# tmp234,
	lw	a2,%lo(.LC46)(a5)		#,
	addi	s2,s0,104	#, tmp223, tmp180
	mv	a3,sp	#,
	addi	a1,sp,48	#, tmp341,
	mv	a0,s2	#, tmp223
	call	make_Sphere		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC47)	# tmp236,
	lw	a5,%lo(.LC47)(a5)		# tmp237,
# main_raytrace.c:374:     spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	addi	a1,sp,176	#,,
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a5,176(sp)	# tmp237, D.2176.x
	lui	a5,%hi(.LC48)	# tmp238,
	lw	a5,%lo(.LC48)(a5)		# tmp239,
# main_raytrace.c:374:     spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	addi	a0,sp,48	#, tmp342,
# main_raytrace.c:41:   return V;
	sw	s1,184(sp)	# tmp220, D.2176.z
	sw	a5,180(sp)	# tmp239, D.2176.y
# main_raytrace.c:374:     spheres[3] = make_Sphere(make_vec3( 7,    5,   -18), 4,     mirror);
	call	memcpy		#
	addi	a1,sp,396	#, tmp343,
	li	a2,36		#,
	mv	a0,sp	#,
	call	memcpy		#
	lui	a5,%hi(.LC5)	# tmp255,
	lw	a2,%lo(.LC5)(a5)		#,
	addi	s1,s0,156	#, tmp244, tmp180
	mv	a3,sp	#,
	addi	a1,sp,48	#, tmp344,
	mv	a0,s1	#, tmp244
	call	make_Sphere		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC49)	# tmp257,
	lw	a5,%lo(.LC49)(a5)		# tmp258,
# main_raytrace.c:376:     lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	addi	a1,sp,188	#,,
	li	a2,12		#,
# main_raytrace.c:41:   return V;
	sw	a5,188(sp)	# tmp258, D.2177.x
	lui	a5,%hi(.LC50)	# tmp259,
	lw	s2,%lo(.LC50)(a5)		# tmp260,
# main_raytrace.c:376:     lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	addi	a0,sp,48	#, tmp345,
	addi	s1,s0,208	#, tmp265, tmp180
# main_raytrace.c:41:   return V;
	sw	s2,192(sp)	# tmp260, D.2177.y
	sw	s2,196(sp)	# tmp260, D.2177.z
# main_raytrace.c:376:     lights[0] = make_Light(make_vec3(-20, 20,  20), 1.5);
	call	memcpy		#
	mv	a2,s3	#, tmp124
	addi	a1,sp,48	#, tmp346,
	mv	a0,s1	#, tmp265
	call	make_Light		#
# main_raytrace.c:41:   return V;
	lui	a5,%hi(.LC51)	# tmp273,
	lw	s1,%lo(.LC51)(a5)		# tmp274,
	lui	a5,%hi(.LC52)	# tmp277,
	lw	a5,%lo(.LC52)(a5)		# tmp278,
# main_raytrace.c:377:     lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	addi	a1,sp,200	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp347,
# main_raytrace.c:41:   return V;
	sw	s1,200(sp)	# tmp274, D.2178.x
	sw	s5,204(sp)	# tmp93, D.2178.y
	sw	a5,208(sp)	# tmp278, D.2178.z
# main_raytrace.c:377:     lights[1] = make_Light(make_vec3( 30, 50, -25), 1.8);
	call	memcpy		#
	lui	a5,%hi(.LC53)	# tmp287,
	lw	a2,%lo(.LC53)(a5)		#,
	addi	s3,s0,224	#, tmp281, tmp180
	addi	a1,sp,48	#, tmp348,
	mv	a0,s3	#, tmp281
	call	make_Light		#
# main_raytrace.c:378:     lights[2] = make_Light(make_vec3( 30, 20,  30), 1.7);
	addi	a1,sp,212	#,,
	li	a2,12		#,
	addi	a0,sp,48	#, tmp349,
# main_raytrace.c:41:   return V;
	sw	s1,212(sp)	# tmp274, D.2179.x
	sw	s2,216(sp)	# tmp260, D.2179.y
	sw	s1,220(sp)	# tmp274, D.2179.z
# main_raytrace.c:378:     lights[2] = make_Light(make_vec3( 30, 20,  30), 1.7);
	call	memcpy		#
	lui	a5,%hi(.LC54)	# tmp303,
	lw	a2,%lo(.LC54)(a5)		#,
	addi	s0,s0,240	#, tmp297, tmp180
	addi	a1,sp,48	#, tmp350,
	mv	a0,s0	#, tmp297
	call	make_Light		#
# main_raytrace.c:379: }
	lw	ra,460(sp)		#,
	lw	s0,456(sp)		#,
	lw	s1,452(sp)		#,
	lw	s2,448(sp)		#,
	lw	s3,444(sp)		#,
	lw	s4,440(sp)		#,
	lw	s5,436(sp)		#,
	lw	s6,432(sp)		#,
	addi	sp,sp,464	#,,
	jr	ra		#
	.size	init_scene, .-init_scene
	.align	2
	.globl	fill_oled
	.type	fill_oled, @function
fill_oled:
# main_raytrace.c:384:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	slli	a0,a0,16	#, _2, tmp84
# main_raytrace.c:382:   for (int y = 0; y < 64; y++) {
	li	a4,0		# y,
# main_raytrace.c:384:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	li	a2,805306368		# tmp81,
# main_raytrace.c:383:     for (int x = 0; x < 96; x++) {
	li	a1,24576		# tmp82,
# main_raytrace.c:382:   for (int y = 0; y < 64; y++) {
	li	a6,64		# tmp83,
.L206:
	or	a3,a4,a0	# _2, _20, y
# main_raytrace.c:381: void fill_oled(int rgb) {
	li	a5,0		# ivtmp.600,
.L207:
# main_raytrace.c:384:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	or	a7,a5,a3	# _20, _9, ivtmp.600
# main_raytrace.c:384:       *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
	sw	a7,8(a2)	# _9, MEM[(volatile uint32_t *)805306376B]
# main_raytrace.c:383:     for (int x = 0; x < 96; x++) {
	addi	a5,a5,256	#, ivtmp.600, ivtmp.600
	bne	a5,a1,.L207	#, ivtmp.600, tmp82,
# main_raytrace.c:382:   for (int y = 0; y < 64; y++) {
	addi	a4,a4,1	#, y, y
# main_raytrace.c:382:   for (int y = 0; y < 64; y++) {
	bne	a4,a6,.L206	#, y, tmp83,
# main_raytrace.c:387: }
	ret	
	.size	fill_oled, .-fill_oled
	.section	.rodata.str1.4
	.align	2
.LC55:
	.string	"done======================="
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48	#,,
	sw	s0,40(sp)	#,
# main_raytrace.c:406:     render(fb, spheres, nb_spheres, lights, nb_lights);
	lui	s0,%hi(.LANCHOR1)	# tmp78,
# main_raytrace.c:391: void main() {
	sw	s2,32(sp)	#,
# main_raytrace.c:406:     render(fb, spheres, nb_spheres, lights, nb_lights);
	addi	s0,s0,%lo(.LANCHOR1)	# tmp77, tmp78,
# main_raytrace.c:410:     wait_cycles(40000000*5);
	li	s2,199999488		# tmp87,
# main_raytrace.c:391: void main() {
	sw	s1,36(sp)	#,
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
	sw	s5,20(sp)	#,
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
	sw	ra,44(sp)	#,
# main_raytrace.c:406:     render(fb, spheres, nb_spheres, lights, nb_lights);
	lui	s7,%hi(nb_lights)	# tmp75,
	addi	s6,s0,208	#, tmp79, tmp77
	lui	s5,%hi(nb_spheres)	# tmp80,
	lui	s4,%hi(fb)	# tmp84,
# main_raytrace.c:407:     print_str("done=======================");
	lui	s1,%hi(.LC55)	# tmp86,
# main_raytrace.c:410:     wait_cycles(40000000*5);
	addi	s2,s2,512	#, tmp87, tmp87
	li	s3,0		#,
.L211:
# main_raytrace.c:404:     fill_oled(0);
	li	a0,0		#,
	call	fill_oled		#
# main_raytrace.c:405:     init_scene();
	call	init_scene		#
# main_raytrace.c:406:     render(fb, spheres, nb_spheres, lights, nb_lights);
	lw	a4,%lo(nb_lights)(s7)		#, nb_lights
	lw	a2,%lo(nb_spheres)(s5)		#, nb_spheres
	lw	a0,%lo(fb)(s4)		#, fb
	mv	a1,s0	#, tmp77
	mv	a3,s6	#, tmp79
	call	render		#
# main_raytrace.c:407:     print_str("done=======================");
	addi	a0,s1,%lo(.LC55)	#, tmp86,
	call	print_str		#
# main_raytrace.c:408:     putchar(10);
	li	a0,10		#,
	call	putchar		#
# main_raytrace.c:409:     show_csr_timer_cnt();
	call	show_csr_timer_cnt		#
# main_raytrace.c:410:     wait_cycles(40000000*5);
	mv	a0,s2	#, tmp87
	mv	a1,s3	#,
	call	wait_cycles		#
	j	.L211		#
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
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC0:
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
	.align	2
.LC22:
	.word	1097859072
	.align	2
.LC23:
	.word	1132396544
	.section	.srodata.cst8
	.align	3
.LC27:
	.word	1073741824
	.word	1071694162
	.align	3
.LC28:
	.word	0
	.word	1078460416
	.align	3
.LC29:
	.word	0
	.word	1077936128
	.align	3
.LC30:
	.word	0
	.word	-1068498944
	.section	.srodata.cst4
	.align	2
.LC31:
	.word	1058642330
	.align	2
.LC32:
	.word	1053609165
	.align	2
.LC33:
	.word	1112014848
	.align	2
.LC34:
	.word	1123680256
	.align	2
.LC35:
	.word	1069547520
	.align	2
.LC36:
	.word	1063675494
	.align	2
.LC37:
	.word	1092616192
	.align	2
.LC38:
	.word	1124990976
	.align	2
.LC39:
	.word	-1069547520
	.align	2
.LC40:
	.word	-1048576000
	.set	.LC41,.LC27
	.align	2
.LC42:
	.word	-1077936128
	.align	2
.LC43:
	.word	-1052770304
	.align	2
.LC44:
	.word	-1090519040
	.align	2
.LC45:
	.word	-1047527424
	.set	.LC46,.LC29+4
	.align	2
.LC47:
	.word	1088421888
	.align	2
.LC48:
	.word	1084227584
	.align	2
.LC49:
	.word	-1046478848
	.align	2
.LC50:
	.word	1101004800
	.align	2
.LC51:
	.word	1106247680
	.align	2
.LC52:
	.word	-1043857408
	.align	2
.LC53:
	.word	1072064102
	.align	2
.LC54:
	.word	1071225242
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
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
	.set	.LANCHOR1,. + 0
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
	.word	64
	.type	HRES, @object
	.size	HRES, 4
HRES:
	.word	96
	.ident	"GCC: (GNU) 11.1.0"
