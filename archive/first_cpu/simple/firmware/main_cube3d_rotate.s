	.file	"main_cube3d_rotate.c"
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
	.type	fb_draw_bresenham.constprop.0, @function
fb_draw_bresenham.constprop.0:
	addi	sp,sp,-32	#,,
	sw	s1,20(sp)	#,
	mv	s1,a0	# x0, tmp124
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sub	a0,a2,a0	#, x1, x0
# gfx_lib.h:194: void fb_draw_bresenham(uint16_t *fb, int x0, int y0, int x1, int y1, short color)
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	mv	s0,a1	# y0, tmp125
	sw	s3,12(sp)	#,
	sw	s4,8(sp)	#,
	mv	s3,a2	# x1, tmp126
	sw	s5,4(sp)	#,
# gfx_lib.h:194: void fb_draw_bresenham(uint16_t *fb, int x0, int y0, int x1, int y1, short color)
	mv	s5,a3	# y1, tmp127
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s2,a0	# tmp128,
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sub	a0,s5,s0	#, y1, y0
	call	abs		#
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sgt	s4,s3,s1	# tmp112, x1, x0
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sgt	t4,s5,s0	# tmp116, y1, y0
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	slli	s4,s4,1	#, iftmp.52_16, tmp112
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	slli	t4,t4,1	#, iftmp.53_20, tmp116
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	lui	a2,%hi(framebuffer)	# tmp121,
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	addi	s4,s4,-1	#, iftmp.52_16, iftmp.52_16
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	neg	t3,a0	# dy, _8
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	addi	t4,t4,-1	#, iftmp.53_20, iftmp.53_20
	sub	a4,s2,a0	# err, dx, _8
	addi	a6,s1,-1	#, tmp110, x0
# gfx_lib.h:189:   if  ( x <= 0 ) return;
	li	t1,94		# tmp97,
# gfx_lib.h:190:   if  ( y <= 0) return;
	li	a3,62		# tmp120,
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	addi	a2,a2,%lo(framebuffer)	# tmp122, tmp121,
	li	t5,239		# tmp123,
.L4:
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a5,s0,1	#, tmp101, y0
	add	a5,a5,s0	# y0, tmp102, tmp101
	slli	a5,a5,5	#, tmp103, tmp102
	add	a5,a5,s1	# x0, tmp104, tmp103
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a5,a5,1	#, tmp105, tmp104
# gfx_lib.h:205:     e2 = 2*err;
	slli	a1,a4,1	#, e2, err
# gfx_lib.h:190:   if  ( y <= 0) return;
	addi	a7,s0,-1	#, tmp98, y0
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	add	a5,a5,a2	# tmp122, tmp106, tmp105
# gfx_lib.h:189:   if  ( x <= 0 ) return;
	bgtu	a6,t1,.L5	#, tmp110, tmp97,
# gfx_lib.h:190:   if  ( y <= 0) return;
	bgtu	a7,a3,.L5	#, tmp98, tmp120,
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	sh	t5,0(a5)	# tmp123, *_36
.L5:
# gfx_lib.h:203:     if (x0 == x1 && y0 == y1) break;
	beq	s3,s1,.L14	#, x1, x0,
.L6:
# gfx_lib.h:206:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t3,a1,.L8	#, dy, e2,
# gfx_lib.h:206:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s4	# iftmp.52_16, x0, x0
	sub	a4,a4,a0	# err, err, _8
	addi	a6,s1,-1	#, tmp110, x0
.L8:
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L4	#, dx, e2,
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a4,a4,s2	# dx, err, err
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,t4	# iftmp.53_20, y0, y0
	j	.L4		#
.L14:
# gfx_lib.h:203:     if (x0 == x1 && y0 == y1) break;
	bne	s5,s0,.L6	#, y1, y0,
# gfx_lib.h:209: }
	lw	ra,28(sp)		#,
	lw	s0,24(sp)		#,
	lw	s1,20(sp)		#,
	lw	s2,16(sp)		#,
	lw	s3,12(sp)		#,
	lw	s4,8(sp)		#,
	lw	s5,4(sp)		#,
	addi	sp,sp,32	#,,
	jr	ra		#
	.size	fb_draw_bresenham.constprop.0, .-fb_draw_bresenham.constprop.0
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
	beq	a2,zero,.L16	#, tmp89,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a4	# _1, _5, _12
	sw	a5,0(a0)	# _5,* p
	ret	
.L16:
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
	beq	a1,zero,.L19	#, tmp95,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,28(a4)	# _8,
	ret	
.L19:
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
	beq	a1,zero,.L23	#, tmp95,,
# kianv_stdlib.h:43:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,20(a4)	# _8,
	ret	
.L23:
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
.L30:
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
	bgtu	a4,a5,.L30	#, tmp100, tmph0.0_11,
	bne	a4,a5,.L27	#, tmp100, tmph0.0_11,
	bgtu	a2,a3,.L30	#, tmp129, tmpl0.1_14,
.L27:
# kianv_stdlib.h:83: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib.h:86:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L41	#, us,,
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
.L38:
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
	bgtu	a5,a4,.L38	#, tmp112, tmph0.0_14,
	bne	a5,a4,.L32	#, tmp112, tmph0.0_14,
	bgtu	a2,a3,.L38	#, tmp141, tmpl0.1_17,
.L32:
# kianv_stdlib.h:87: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L41:
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:90:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L53	#, ms,,
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
.L50:
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
	bgtu	a5,a4,.L50	#, tmp111, tmph0.0_14,
	bne	a5,a4,.L44	#, tmp111, tmph0.0_14,
	bgtu	a2,a3,.L50	#, tmp140, tmpl0.1_17,
.L44:
# kianv_stdlib.h:91: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L53:
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:94:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L65	#, sec,,
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
.L62:
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
	bgtu	a4,a5,.L62	#, tmp107, tmph0.0_13,
	bne	a4,a5,.L56	#, tmp107, tmph0.0_13,
	bgtu	a0,a3,.L62	#, tmp136, tmpl0.1_16,
.L56:
# kianv_stdlib.h:95: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L65:
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
.L75:
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:110:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L75	#, _1,,
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
.L79:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L79	#, _4,,
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
	beq	a3,zero,.L82	#, _3,,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp76,
.L84:
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L84	#, _1,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a3,0(a4)	# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a3,zero,.L84	#, _3,,
.L82:
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
	beq	a3,zero,.L93	#, _7,,
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp77,
.L94:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:123:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L94	#, _4,,
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	addi	a0,a0,1	#, p, p
# kianv_stdlib.h:125:     *((volatile uint32_t*) UART_TX) = *(p++);
	sw	a3,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:122:   while (*p != 0) {
	lbu	a3,0(a0)	# _7, MEM[(char *)p_6]
# kianv_stdlib.h:122:   while (*p != 0) {
	bne	a3,zero,.L94	#, _7,,
.L93:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp79,
.L96:
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L96	#, _3,,
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
.L106:
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a0,zero,.L107	#, val,,
# kianv_stdlib.h:136:   while (val || p == buffer) {
	bne	a4,a2,.L114	#, p, tmp92,
.L107:
# kianv_stdlib.h:137:     *(p++) = val % 10;
	remu	a3,a0,a5	# tmp93, tmp83, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	addi	a4,a4,1	#, p, p
# kianv_stdlib.h:138:     val = val / 10;
	divu	a0,a0,a5	# tmp93, val, val
# kianv_stdlib.h:137:     *(p++) = val % 10;
	sb	a3,-1(a4)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L106		#
.L114:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp88,
.L108:
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:142:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L108	#, _3,,
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a4)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,-1	#, p, p
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:144:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a3)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:141:   while (p != buffer) {
	bne	a4,a2,.L108	#, p, tmp92,
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
	j	.L116		#
.L117:
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
.L116:
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
	bne	a3,zero,.L117	#, val,,
# kianv_stdlib.h:151:   while (val || p == buffer) {
	beq	a2,t3,.L117	#, p, tmp254,
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp202,
.L118:
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:157:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L118	#, _3,,
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a2,a2,-1	#, p, p
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:159:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:156:   while (p != buffer) {
	bne	a2,t3,.L118	#, p, tmp254,
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
	blt	a3,zero,.L124	#, i,,
	lui	a2,%hi(.LC0)	# tmp95,
	li	a1,-4		# _8,
	addi	a2,a2,%lo(.LC0)	# tmp94, tmp95,
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp87,
.L126:
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:165:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L126	#, _2,,
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
	bne	a1,a3,.L126	#, _8, i,
.L124:
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
.L135:
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
	beq	s0,s4,.L143	#, x0, x1,
.L136:
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t4,a5,.L138	#, dy, e2,
# kianv_stdlib.h:199:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s0,s0,s5	# iftmp.6_9, x0, x0
	sub	a6,a6,a0	# err, err, _3
	slli	a1,s0,8	#, tmp107, x0
.L138:
# kianv_stdlib.h:200:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a5,.L135	#, dx, e2,
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
	bne	s0,s4,.L136	#, x0, x1,
.L143:
# kianv_stdlib.h:197:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s6,.L136	#, y0, y1,
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
	beq	t1,zero,.L147	#, _14,,
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
.L168:
# stdlib.c:97: 		if (format[i] == '%') {
	beq	t1,t0,.L148	#, _14, tmp119,
.L149:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _41, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L149	#, _41,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	t1,0(a5)	# _14, MEM[(volatile uint32_t *)805306368B]
.L152:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	a3,a3,1	#, i, i
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a4,a0,a3	# i, tmp177, format
	lbu	t1,0(a4)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	t1,zero,.L168	#, _14,,
.L147:
# stdlib.c:121: }
	li	a0,0		#,
	addi	sp,sp,80	#,,
	jr	ra		#
.L167:
# stdlib.c:99: 				if (format[i] == 'c') {
	beq	a4,a7,.L194	#, _10, tmp186,
# stdlib.c:103: 				if (format[i] == 's') {
	beq	a4,t3,.L195	#, _10, tmp187,
# stdlib.c:107: 				if (format[i] == 'd') {
	beq	a4,t4,.L196	#, _10, tmp188,
# stdlib.c:111: 				if (format[i] == 'u') {
	beq	a4,t5,.L197	#, _10, tmp189,
.L148:
# stdlib.c:98: 			while (format[++i]) {
	addi	a3,a3,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a4,a0,a3	# i, tmp174, format
	lbu	a4,0(a4)	# _10, MEM[(const char *)_125]
# stdlib.c:98: 			while (format[++i]) {
	bne	a4,zero,.L167	#, _10,,
	j	.L152		#
.L194:
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a4,12(sp)		# D.2612, ap
	lw	a2,0(a4)		# _4, MEM[(int *)_109]
	addi	a4,a4,4	#, D.2613, D.2612
	sw	a4,12(sp)	# D.2613, ap
.L151:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _33, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L151	#, _33,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	andi	a4,a2,255	#, _35, _4
	sw	a4,0(a5)	# _35, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:50: }
	j	.L152		#
.L195:
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a4,12(sp)		# D.2614, ap
	lw	a6,0(a4)		# p, MEM[(char * *)_78]
	addi	a4,a4,4	#, D.2615, D.2614
	sw	a4,12(sp)	# D.2615, ap
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _39,* p
	beq	a2,zero,.L152	#, _39,,
.L155:
# stdlib.c:56:     print_chr(*(p++));
	addi	a6,a6,1	#, p, p
.L154:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _38, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L154	#, _38,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a2,0(a5)	# _39, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _39,* p
	bne	a2,zero,.L155	#, _39,,
	j	.L152		#
.L196:
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a2,12(sp)		# D.2616, ap
	lw	a4,0(a2)		# val, MEM[(int *)_110]
	addi	a2,a2,4	#, D.2617, D.2616
	sw	a2,12(sp)	# D.2617, ap
# stdlib.c:63: 	if (val < 0) {
	blt	a4,zero,.L158	#, val,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp194
.L159:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	a4,zero,.L160	#, val,,
	bne	a2,t6,.L162	#, p, tmp194,
.L160:
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
	j	.L159		#
.L158:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a2,0(a5)		# _47, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a2,zero,.L158	#, _47,,
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	t2,0(a5)	# tmp198, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:65: 		val = -val;
	neg	a4,a4	# val, val
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp194
	j	.L159		#
.L198:
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a6,0(a5)	# _58, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:71: 	while (p != buffer)
	beq	a2,t6,.L152	#, p, tmp194,
.L162:
# stdlib.c:72: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _58, MEM[(char *)p_57]
# stdlib.c:72: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L161:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _59, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L161	#, _59,,
	j	.L198		#
.L197:
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a6,12(sp)		# D.2618, ap
# stdlib.c:78: 	char *p = buffer;
	mv	a2,t6	# p, tmp194
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a4,0(a6)		# MEM[(int *)_113], MEM[(int *)_113]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a6,a6,4	#, D.2619, D.2618
	sw	a6,12(sp)	# D.2619, ap
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a6,a4,31	#, tmp153, MEM[(int *)_113]
	xor	a4,a6,a4	# MEM[(int *)_113], val, tmp153
	sub	a4,a4,a6	# val, val, tmp153
.L163:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a4,zero,.L164	#, val,,
	bne	a2,t6,.L166	#, p, tmp194,
.L164:
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
	j	.L163		#
.L199:
# kianv_stdlib.h:118:   *((volatile uint32_t*) UART_TX) = ch;
	sw	a6,0(a5)	# _73, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:85: 	while (p != buffer)
	beq	a2,t6,.L152	#, p, tmp194,
.L166:
# stdlib.c:86: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _73, MEM[(char *)p_72]
# stdlib.c:86: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L165:
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _74, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:116:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L165	#, _74,,
	j	.L199		#
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
	ble	a5,a3,.L200	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L200:
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
	beq	a2,zero,.L203	#, n,,
	addi	a4,a1,1	#, bb, bb
	sub	a5,a0,a4	# tmp111, aa, bb
	sltiu	a5,a5,3	#, tmp114, tmp111
	sltiu	a3,a7,7	#, tmp117, n
	xori	a5,a5,1	#, tmp113, tmp114
	xori	a3,a3,1	#, tmp116, tmp117
	and	a5,a5,a3	# tmp116, tmp120, tmp113
	beq	a5,zero,.L204	#, tmp120,,
	or	a5,a0,a1	# bb, tmp121, aa
	andi	a5,a5,3	#, tmp122, tmp121
	bne	a5,zero,.L204	#, tmp122,,
	andi	a6,a2,-4	#, tmp127, n
	mv	a5,a1	# ivtmp.316, bb
	mv	a4,a0	# ivtmp.319, aa
	add	a6,a6,a1	# bb, _77, tmp127
.L205:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lw	a3,0(a5)		# vect__1.302, MEM <const vector(4) char> [(const char *)_43]
	addi	a5,a5,4	#, ivtmp.316, ivtmp.316
	addi	a4,a4,4	#, ivtmp.319, ivtmp.319
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sw	a3,-4(a4)	# vect__1.302, MEM <vector(4) char> [(char *)_45]
	bne	a5,a6,.L205	#, ivtmp.316, _77,
	andi	a5,a2,-4	#, niters_vector_mult_vf.296, n
	add	a4,a0,a5	# niters_vector_mult_vf.296, tmp.297, aa
	add	a1,a1,a5	# niters_vector_mult_vf.296, tmp.298, bb
	sub	a7,a7,a5	# tmp.299, n, niters_vector_mult_vf.296
	beq	a2,a5,.L203	#, n, niters_vector_mult_vf.296,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,0(a1)	# _10, *tmp.298_55
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,0(a4)	# _10, *tmp.297_54
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,zero,.L203	#, tmp.299,,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,1(a1)	# _72, MEM[(const char *)tmp.298_55 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,1		# tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,1(a4)	# _72, MEM[(char *)tmp.297_54 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,a5,.L203	#, tmp.299, tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,2(a1)	# _48, MEM[(const char *)tmp.298_55 + 2B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,2(a4)	# _48, MEM[(char *)tmp.297_54 + 2B]
	ret	
.L204:
	add	a2,a0,a2	# n, _23, aa
# stdlib.c:138: 	char *a = (char *) aa;
	mv	a5,a0	# a, aa
.L207:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,-1(a4)	# _37, MEM[(const char *)b_35 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	addi	a5,a5,1	#, a, a
	addi	a4,a4,1	#, bb, bb
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,-1(a5)	# _37, MEM[(char *)a_36 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a2,a5,.L207	#, _23, a,
.L203:
# stdlib.c:142: }
	ret	
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
	j	.L224		#
.L226:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	beq	a4,zero,.L228	#, c,,
.L224:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp101, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp102, tmp101
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L226	#, tmp102,,
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
	bne	a4,zero,.L229	#, tmp108,,
.L227:
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
	beq	a4,zero,.L227	#, tmp120,,
.L229:
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a3,0(a5)	# v, *dst_50
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a4,a3,255	#, tmp111, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L228	#, tmp111,,
# stdlib.c:164: 			v = v >> 8;
	srli	a4,a3,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a4,1(a5)	# v, MEM[(char *)dst_50 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp112, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L228	#, tmp112,,
# stdlib.c:169: 			v = v >> 8;
	srli	a4,a3,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a4,2(a5)	# v, MEM[(char *)dst_50 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp113, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	bne	a4,zero,.L244	#, tmp113,,
.L228:
# stdlib.c:184: }
	ret	
.L244:
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
	j	.L246		#
.L250:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	bne	a5,a4,.L275	#, c1, c2,
# stdlib.c:195: 		else if (!c1)
	beq	a5,zero,.L265	#, c1,,
.L246:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L250	#, tmp102,,
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_14]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_16]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L255	#, v1, v2,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp111,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-2139062272		# tmp116,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp110, tmp111
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,128	#, tmp115, tmp116
	j	.L251		#
.L276:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_29]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_30]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L255	#, v1, v2,
.L251:
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
	beq	a5,zero,.L276	#, tmp114,,
.L265:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
.L245:
# stdlib.c:234: }
	ret	
.L275:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	sltu	a0,a5,a4	# c2, tmp119, c1
	neg	a0,a0	# tmp120, tmp119
	ori	a0,a0,1	#, <retval>, tmp120
	ret	
.L255:
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L273	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L245	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L273	#, c1, c2,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L245	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L273	#, c1, c2,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L245	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L245	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a5,a4,.L245	#, c1, c2,
	j	.L271		#
.L273:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L245	#, c1, c2,
.L271:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
	.size	strcmp, .-strcmp
	.align	2
	.globl	sin1
	.type	sin1, @function
sin1:
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L278	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp96,
	add	a0,a0,a5	# tmp96, tmp98, angle
	slli	a0,a0,16	#, angle, tmp98
	srai	a0,a0,16	#, angle, angle
.L278:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a0,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_4, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp102, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_4, v0.41_4
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L279	#, tmp102,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp104, v0
	slli	a5,a5,16	#, v0, tmp104
	srai	a5,a5,16	#, v0, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a0,a0	# angle, angle
.L279:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _6, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a2,a5,1	#, tmp114, _6
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a4,%hi(.LANCHOR1)	# tmp109,
	addi	a4,a4,%lo(.LANCHOR1)	# tmp108, tmp109,
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp115, tmp114
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp110, _6
	add	a5,a4,a5	# tmp110, tmp111, tmp108
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a4,a2	# tmp115, tmp116, tmp108
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a5)		# _7, sin90[_6]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a4)		# sin90[_9], sin90[_9]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a0,0xff	# tmp121, angle
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a3,64	#, tmp129, v0.41_4
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a5,a2	# tmp118, sin90[_9], _7
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a4	# tmp122, tmp118, tmp121
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp123, tmp122
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a2	# _7, tmp126, tmp123
	slli	a0,a0,16	#, _5, tmp126
	srli	a0,a0,16	#, _5, _5
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L280	#, tmp129,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp131, _5
	slli	a0,a0,16	#, _5, tmp131
	srli	a0,a0,16	#, _5, _5
.L280:
# gfx_lib.h:94: }
	slli	a0,a0,16	#,, _5
	srai	a0,a0,16	#,,
	ret	
	.size	sin1, .-sin1
	.align	2
	.globl	cos1
	.type	cos1, @function
cos1:
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a2,a0,16	#, prephitmp_78, angle
	srli	a2,a2,16	#, prephitmp_78, prephitmp_78
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L288	#, angle,,
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp98,
	xor	a2,a2,a5	# tmp98, prephitmp_78, prephitmp_78
.L288:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp101,
	addi	a5,a5,1	#, tmp100, tmp101
	add	a5,a2,a5	# tmp100, tmp99, prephitmp_78
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp99
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _4, tmp99
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _4, _4
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L289	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp104,
	addi	a5,a5,1	#, tmp103, tmp104
	add	a2,a2,a5	# tmp103, tmp102, prephitmp_78
	slli	a4,a2,16	#, _4, tmp102
	slli	a3,a2,16	#, angle, tmp102
	srli	a4,a4,16	#, _4, _4
	srai	a3,a3,16	#, angle, angle
.L289:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_16, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp108, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_16, v0.41_16
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L290	#, tmp108,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp112, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _4, tmp112
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _4, _4
.L290:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _22, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a1,a5,1	#, tmp120, _22
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a3,%hi(.LANCHOR1)	# tmp115,
	addi	a3,a3,%lo(.LANCHOR1)	# tmp114, tmp115,
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a1,a1,1	#, tmp121, tmp120
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp116, _22
	add	a5,a3,a5	# tmp116, tmp117, tmp114
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,a1	# tmp121, tmp122, tmp114
	lh	a0,0(a3)		# sin90[_25], sin90[_25]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _23, sin90[_22]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a4,0xff	# tmp126, _4
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a4,a2,64	#, tmp134, v0.41_16
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp124, sin90[_25], _23
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a5	# tmp127, tmp124, tmp126
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp128, tmp127
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _23, tmp131, tmp128
	slli	a0,a0,16	#, _37, tmp131
	srli	a0,a0,16	#, _37, _37
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a4,zero,.L291	#, tmp134,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp136, _37
	slli	a0,a0,16	#, _37, tmp136
	srli	a0,a0,16	#, _37, _37
.L291:
# gfx_lib.h:110: }
	slli	a0,a0,16	#,, _37
	srai	a0,a0,16	#,,
	ret	
	.size	cos1, .-cos1
	.align	2
	.globl	oled_spi_tx
	.type	oled_spi_tx, @function
oled_spi_tx:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	slli	a1,a1,8	#, tmp80, tmp85
	andi	a1,a1,256	#, tmp81, tmp80
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	or	a1,a1,a0	# tmp84, _6, tmp81
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp83,
	sw	a1,12(a5)	# _6, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:115: }
	ret	
	.size	oled_spi_tx, .-oled_spi_tx
	.align	2
	.globl	oled_max_window
	.type	oled_max_window, @function
oled_max_window:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
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
# gfx_lib.h:120: }
	ret	
	.size	oled_max_window, .-oled_max_window
	.align	2
	.globl	oled_show_fb_8or16
	.type	oled_show_fb_8or16, @function
oled_show_fb_8or16:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp94,
	li	a3,21		# tmp95,
	sw	a3,12(a5)	# tmp95, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,117		# tmp102,
	sw	a4,12(a5)	# tmp102, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	a3,12(a5)	# tmp95, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a3,95		# tmp114,
	sw	a3,12(a5)	# tmp114, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# tmp102, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp122,
	sw	a4,12(a5)	# tmp122, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:122: void oled_show_fb_8or16(uint16_t *framebuffer, int _8bit) {
	mv	a5,a0	# framebuffer, tmp154
	beq	a1,zero,.L301	#, tmp155,,
	li	a3,12288		# tmp123,
	add	a3,a0,a3	# tmp123, _27, ivtmp.374
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a2,805306368		# tmp128,
.L302:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# MEM[(uint16_t *)_46], MEM[(uint16_t *)_46]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	addi	a5,a5,2	#, ivtmp.374, ivtmp.374
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	ori	a4,a4,256	#, _23, MEM[(uint16_t *)_46]
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a2)	# _23, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	bne	a5,a3,.L302	#, ivtmp.374, _27,
.L303:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp139,
	li	a4,21		# tmp140,
	sw	a4,12(a5)	# tmp140, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,95		# tmp145,
	sw	a4,12(a5)	# tmp145, MEM[(volatile uint32_t *)805306380B]
	li	a4,117		# tmp148,
	sw	a4,12(a5)	# tmp148, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp153,
	sw	a4,12(a5)	# tmp153, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:144: }
	ret	
.L301:
	li	a1,12288		# tmp129,
	add	a1,a0,a1	# tmp129, _19, ivtmp.380
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a2,805306368		# tmp135,
.L304:
# gfx_lib.h:133:       buf[0] = (framebuffer[i] >> 8) & 0xff;
	lhu	a4,0(a5)	# pretmp_64, MEM[(uint16_t *)_4]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	addi	a5,a5,2	#, ivtmp.380, ivtmp.380
# gfx_lib.h:133:       buf[0] = (framebuffer[i] >> 8) & 0xff;
	srli	a3,a4,8	#, tmp131, pretmp_64
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	ori	a3,a3,256	#, _24, tmp131
	andi	a4,a4,0xff	# pretmp_64, pretmp_64
	ori	a4,a4,256	#, _68, pretmp_64
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a3,12(a2)	# _24, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a2)	# _68, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	bne	a5,a1,.L304	#, ivtmp.380, _19,
	j	.L303		#
	.size	oled_show_fb_8or16, .-oled_show_fb_8or16
	.align	2
	.globl	oled_show_fb
	.type	oled_show_fb, @function
oled_show_fb:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp85,
	li	a3,21		# tmp86,
	sw	a3,12(a5)	# tmp86, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,117		# tmp93,
	sw	a4,12(a5)	# tmp93, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	a3,12(a5)	# tmp86, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a3,95		# tmp105,
	sw	a3,12(a5)	# tmp105, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# tmp93, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp113,
	li	a1,12288		# tmp114,
	sw	a4,12(a5)	# tmp113, MEM[(volatile uint32_t *)805306380B]
	add	a1,a0,a1	# tmp114, _54, ivtmp.389
	li	a3,805306368		# tmp119,
.L308:
# gfx_lib.h:133:       buf[0] = (framebuffer[i] >> 8) & 0xff;
	lhu	a5,0(a0)	# _8, MEM[(uint16_t *)_56]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	addi	a0,a0,2	#, ivtmp.389, ivtmp.389
# gfx_lib.h:133:       buf[0] = (framebuffer[i] >> 8) & 0xff;
	srli	a4,a5,8	#, tmp115, _8
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	ori	a4,a4,256	#, _13, tmp115
	andi	a5,a5,0xff	# _8, _8
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _13, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	ori	a5,a5,256	#, _16, _8
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a5,12(a3)	# _16, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	bne	a1,a0,.L308	#, _54, ivtmp.389,
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,21		# tmp125,
	sw	a5,12(a3)	# tmp125, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a3)	#, MEM[(volatile uint32_t *)805306380B]
	li	a5,95		# tmp130,
	sw	a5,12(a3)	# tmp130, MEM[(volatile uint32_t *)805306380B]
	li	a5,117		# tmp133,
	sw	a5,12(a3)	# tmp133, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a3)	#, MEM[(volatile uint32_t *)805306380B]
	li	a5,63		# tmp138,
	sw	a5,12(a3)	# tmp138, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:149: }
	ret	
	.size	oled_show_fb, .-oled_show_fb
	.align	2
	.globl	init_oled8bit_colors
	.type	init_oled8bit_colors, @function
init_oled8bit_colors:
	lui	a5,%hi(.LANCHOR2)	# tmp78,
	addi	a5,a5,%lo(.LANCHOR2)	# ivtmp.399, tmp78,
	addi	a2,a5,37	#, _15, ivtmp.399
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a3,805306368		# tmp80,
.L311:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# _7, MEM[(char *)_13]
# gfx_lib.h:177:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	addi	a5,a5,1	#, ivtmp.399, ivtmp.399
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _7, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:177:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	bne	a5,a2,.L311	#, ivtmp.399, _15,
# gfx_lib.h:183: }
	ret	
	.size	init_oled8bit_colors, .-init_oled8bit_colors
	.align	2
	.globl	fb_setpixel
	.type	fb_setpixel, @function
fb_setpixel:
# gfx_lib.h:189:   if  ( x <= 0 ) return;
	addi	a4,a1,-1	#, tmp86, x
	li	a5,94		# tmp87,
	bgtu	a4,a5,.L313	#, tmp86, tmp87,
# gfx_lib.h:190:   if  ( y <= 0) return;
	addi	a5,a2,-1	#, tmp88, y
	li	a4,62		# tmp89,
	bgtu	a5,a4,.L313	#, tmp88, tmp89,
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a5,a2,1	#, tmp91, y
	add	a5,a5,a2	# y, tmp92, tmp91
	slli	a5,a5,5	#, tmp93, tmp92
	add	a5,a5,a1	# x, tmp94, tmp93
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a5,a5,1	#, tmp95, tmp94
	add	a0,a0,a5	# tmp95, tmp96, fb
	sh	a3,0(a0)	# color, *_12
.L313:
# gfx_lib.h:192: }
	ret	
	.size	fb_setpixel, .-fb_setpixel
	.align	2
	.globl	fb_draw_bresenham
	.type	fb_draw_bresenham, @function
fb_draw_bresenham:
	addi	sp,sp,-48	#,,
	sw	s4,24(sp)	#,
	mv	s4,a0	# tmp121, fb
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sub	a0,a3,a1	#, x1, x0
# gfx_lib.h:195: {
	sw	ra,44(sp)	#,
	sw	s0,40(sp)	#,
	sw	s1,36(sp)	#,
	mv	s0,a2	# y0, tmp123
	mv	s1,a1	# x0, tmp122
	sw	s2,32(sp)	#,
	sw	s3,28(sp)	#,
	sw	s5,20(sp)	#,
	mv	s3,a3	# x1, tmp124
	sw	s6,16(sp)	#,
	sw	s7,12(sp)	#,
# gfx_lib.h:195: {
	mv	s6,a4	# y1, tmp125
	mv	s7,a5	# color, tmp126
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s2,a0	# tmp127,
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sub	a0,s6,s0	#, y1, y0
	call	abs		#
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sgt	s5,s3,s1	# tmp112, x1, x0
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sgt	t4,s6,s0	# tmp116, y1, y0
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	slli	s5,s5,1	#, iftmp.52_9, tmp112
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	slli	t4,t4,1	#, iftmp.53_10, tmp116
# gfx_lib.h:197:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	addi	s5,s5,-1	#, iftmp.52_9, iftmp.52_9
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	neg	t3,a0	# dy, _3
# gfx_lib.h:198:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	addi	t4,t4,-1	#, iftmp.53_10, iftmp.53_10
	sub	a2,s2,a0	# err, dx, _3
	addi	a7,s1,-1	#, tmp110, x0
# gfx_lib.h:189:   if  ( x <= 0 ) return;
	li	a3,94		# tmp100,
# gfx_lib.h:190:   if  ( y <= 0) return;
	li	a5,62		# tmp120,
.L318:
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a6,s0,1	#, tmp104, y0
	add	a6,a6,s0	# y0, tmp105, tmp104
	slli	a6,a6,5	#, tmp106, tmp105
	add	a6,a6,s1	# x0, tmp107, tmp106
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	slli	a6,a6,1	#, tmp108, tmp107
# gfx_lib.h:205:     e2 = 2*err;
	slli	a1,a2,1	#, e2, err
# gfx_lib.h:190:   if  ( y <= 0) return;
	addi	t1,s0,-1	#, tmp101, y0
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	add	a6,s4,a6	# tmp108, tmp109, fb
# gfx_lib.h:189:   if  ( x <= 0 ) return;
	bgtu	a7,a3,.L319	#, tmp110, tmp100,
# gfx_lib.h:190:   if  ( y <= 0) return;
	bgtu	t1,a5,.L319	#, tmp101, tmp120,
# gfx_lib.h:191:   fb[x + y*HRES] = color;
	sh	s7,0(a6)	# color, *_38
.L319:
# gfx_lib.h:203:     if (x0 == x1 && y0 == y1) break;
	beq	s1,s3,.L327	#, x0, x1,
.L320:
# gfx_lib.h:206:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t3,a1,.L322	#, dy, e2,
# gfx_lib.h:206:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s5	# iftmp.52_9, x0, x0
	sub	a2,a2,a0	# err, err, _3
	addi	a7,s1,-1	#, tmp110, x0
.L322:
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L318	#, dx, e2,
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a2,a2,s2	# dx, err, err
# gfx_lib.h:207:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,t4	# iftmp.53_10, y0, y0
	j	.L318		#
.L327:
# gfx_lib.h:203:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s6,.L320	#, y0, y1,
# gfx_lib.h:209: }
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
	srli	a5,a0,1	#, tmp95, framebuffer
# gfx_lib.h:213:     framebuffer[i] = rgb;
	slli	a3,a1,16	#, _14, tmp116
	andi	a5,a5,1	#, prolog_loop_niters.410, tmp95
	srli	a3,a3,16	#, _14, _14
# gfx_lib.h:212:   for (int i = 0; i < (VRES*HRES); i++) {
	li	a4,0		# i,
	beq	a5,zero,.L329	#, prolog_loop_niters.410,,
# gfx_lib.h:213:     framebuffer[i] = rgb;
	sh	a3,0(a0)	# _14, *framebuffer_8(D)
# gfx_lib.h:212:   for (int i = 0; i < (VRES*HRES); i++) {
	li	a4,1		# i,
.L329:
	li	a6,8192		# tmp98,
	addi	a6,a6,-2048	#, tmp97, tmp98
	sub	a6,a6,a5	# niters.411, tmp97, prolog_loop_niters.410
	srli	a2,a6,1	#, bnd.412, niters.411
	slli	a5,a5,1	#, tmp108, prolog_loop_niters.410
	slli	a1,a3,16	#, tmp103, _14
	add	a5,a0,a5	# tmp108, ivtmp.420, framebuffer
	slli	a2,a2,2	#, tmp110, bnd.412
	or	a1,a3,a1	# tmp103, tmp107, _14
	add	a2,a2,a5	# ivtmp.420, _26, tmp110
.L330:
# gfx_lib.h:213:     framebuffer[i] = rgb;
	sw	a1,0(a5)	# tmp107, MEM <vector(2) short unsigned int> [(uint16_t *)_22]
	addi	a5,a5,4	#, ivtmp.420, ivtmp.420
	bne	a5,a2,.L330	#, ivtmp.420, _26,
	andi	a2,a6,-2	#, niters_vector_mult_vf.413, niters.411
	add	a5,a2,a4	# i, tmp.414, niters_vector_mult_vf.413
	beq	a6,a2,.L328	#, niters.411, niters_vector_mult_vf.413,
# gfx_lib.h:213:     framebuffer[i] = rgb;
	slli	a5,a5,1	#, tmp111, tmp.414
	add	a0,a0,a5	# tmp111, tmp112, framebuffer
	sh	a3,0(a0)	# _14, *_42
.L328:
# gfx_lib.h:215: }
	ret	
	.size	fill_oled, .-fill_oled
	.align	2
	.globl	mirror_x_axis
	.type	mirror_x_axis, @function
mirror_x_axis:
# gfx_lib.h:218:   point transformed = {p->x, 1.0 * p->y};
	lw	a4,4(a1)		# vect__1.430, MEM[(int *)p_4(D) + 4B]
# gfx_lib.h:219:   return transformed;
	lw	a3,0(a1)		# MEM[(int *)p_4(D)], MEM[(int *)p_4(D)]
	sw	zero,8(a0)	#, <retval>.z
	sw	a4,4(a0)	# vect__1.430, MEM[(int *)&<retval> + 4B]
	sw	a3,0(a0)	# MEM[(int *)p_4(D)], MEM[(int *)&<retval>]
# gfx_lib.h:220: }
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
# gfx_lib.h:223:   point transformed = {-1.0 * p->x, p->y};
	lw	a0,0(a1)		#, p_7(D)->x
# gfx_lib.h:222: point mirror_y_axis(point *p) {
	sw	ra,12(sp)	#,
	sw	s1,4(sp)	#,
# gfx_lib.h:223:   point transformed = {-1.0 * p->x, p->y};
	lw	s1,4(a1)		# _5, p_7(D)->y
# gfx_lib.h:223:   point transformed = {-1.0 * p->x, p->y};
	call	__floatsidf		#
# gfx_lib.h:223:   point transformed = {-1.0 * p->x, p->y};
	li	a5,-2147483648		# tmp81,
	mv	a4,a0	# tmp93, tmp90
	xor	a5,a5,a1	# tmp91, tmp94, tmp81
	mv	a0,a4	# tmp95, tmp93
	mv	a1,a5	#, tmp94
	call	__fixdfsi		#
	sw	a0,0(s0)	# tmp92, <retval>.x
# gfx_lib.h:224:   return transformed;
	sw	s1,4(s0)	# _5, <retval>.y
# gfx_lib.h:225: }
	lw	ra,12(sp)		#,
# gfx_lib.h:224:   return transformed;
	sw	zero,8(s0)	#, <retval>.z
# gfx_lib.h:225: }
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
# gfx_lib.h:228:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	a0,8(a1)		#, p_8(D)->z
# gfx_lib.h:227: point mirror_z_axis(point *p) {
	sw	ra,12(sp)	#,
	sw	s1,4(sp)	#,
	sw	s2,0(sp)	#,
# gfx_lib.h:227: point mirror_z_axis(point *p) {
	mv	s1,a1	# p, tmp90
# gfx_lib.h:228:   point transformed = {p->x, p->y, -1.0 * p->z};
	lw	s2,4(a1)		# vect__1.442, MEM[(int *)p_8(D) + 4B]
# gfx_lib.h:228:   point transformed = {p->x, p->y, -1.0 * p->z};
	call	__floatsidf		#
# gfx_lib.h:228:   point transformed = {p->x, p->y, -1.0 * p->z};
	li	a5,-2147483648		# tmp82,
	xor	a5,a5,a1	# tmp92, tmp95, tmp82
	mv	a4,a0	# tmp94, tmp91
	mv	a1,a5	#, tmp95
	mv	a0,a4	# tmp96, tmp94
	call	__fixdfsi		#
# gfx_lib.h:229:   return transformed;
	lw	a5,0(s1)		# MEM[(int *)p_8(D)], MEM[(int *)p_8(D)]
	sw	s2,4(s0)	# vect__1.442, MEM[(int *)&<retval> + 4B]
	sw	a0,8(s0)	# tmp93, <retval>.z
# gfx_lib.h:230: }
	lw	ra,12(sp)		#,
# gfx_lib.h:229:   return transformed;
	sw	a5,0(s0)	# MEM[(int *)p_8(D)], MEM[(int *)&<retval>]
# gfx_lib.h:230: }
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
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(a1)		#, p_14(D)->y
# gfx_lib.h:232: point scale(point *p, float sx, float sy, float sz) {
	sw	ra,28(sp)	#,
	sw	s1,20(sp)	#,
	sw	s2,16(sp)	#,
	sw	s3,12(sp)	#,
	mv	s2,a3	# sy, tmp99
	mv	s3,a2	# sx, tmp98
	sw	s4,8(sp)	#,
# gfx_lib.h:232: point scale(point *p, float sx, float sy, float sz) {
	mv	s1,a1	# p, tmp97
	mv	s4,a4	# sz, tmp100
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, sy
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s2,a0	# tmp101,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,8(s1)		#, p_14(D)->z
	call	__floatsisf		#
	mv	a1,s4	#, sz
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	a5,a0	# tmp102,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,0(s1)		#, p_14(D)->x
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s1,a5	# _12, tmp102
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s3	#, sx
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	sw	a0,0(s0)	# tmp103, <retval>.x
# gfx_lib.h:234:   return transformed;
	sw	s2,4(s0)	# _8, <retval>.y
	sw	s1,8(s0)	# _12, <retval>.z
# gfx_lib.h:235: }
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
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a7,4(a1)		# p_8(D)->y, p_8(D)->y
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a6,8(a1)		# p_8(D)->z, p_8(D)->z
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,0(a1)		# p_8(D)->x, p_8(D)->x
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a3,a3,a7	# p_8(D)->y, _4, tmp90
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a4,a4,a6	# p_8(D)->z, _6, tmp91
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a1,a1,a2	# tmp89, tmp85, p_8(D)->x
# gfx_lib.h:239:   return transformed;
	sw	a1,0(a0)	# tmp85, <retval>.x
	sw	a3,4(a0)	# _4, <retval>.y
	sw	a4,8(a0)	# _6, <retval>.z
# gfx_lib.h:240: }
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
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib.h:243: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,8(a1)		# p_32(D)->z, p_32(D)->z
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,4(a1)		# p_32(D)->y, p_32(D)->y
# gfx_lib.h:243: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,8(a2)		# _6, pivot_33(D)->z
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,4(a2)		# _3, pivot_33(D)->y
# gfx_lib.h:243: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,0(a1)		# _1, p_32(D)->x
# gfx_lib.h:243: point rotateX_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _4, p_32(D)->y, _3
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _7, p_32(D)->z, _6
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L344	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L344:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L345	#, tmp167,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L345:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L346	#, tmp193,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L346:
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L347	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L347:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L348	#, tmp210,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L348:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L349	#, tmp236,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L349:
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp265,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s2	#, _4
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	mv	s2,a5	# tmp243, tmp265
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s5,a0	# tmp266,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, _7
	call	__floatsisf		#
	mv	s1,a0	# tmp267,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s2	#, tmp243
# gfx_lib.h:255:   return transformed;
	sw	s6,0(s0)	# _1, <retval>.x
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s6,a0	# tmp244, tmp268
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s6	#, tmp244
	call	__subsf3		#
	mv	s6,a0	# tmp246, tmp270
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _3
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s6	#, tmp246
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, sin_theta
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,4(s0)	# tmp272, <retval>.y
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s4,a0	# tmp250, tmp273
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s4	#, tmp250
	call	__addsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp277, <retval>.z
# gfx_lib.h:256: }
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
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib.h:258: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,8(a1)		# p_32(D)->z, p_32(D)->z
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,0(a1)		# p_32(D)->x, p_32(D)->x
# gfx_lib.h:258: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,8(a2)		# _6, pivot_33(D)->z
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,0(a2)		# _2, pivot_33(D)->x
# gfx_lib.h:258: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,4(a1)		# _4, p_32(D)->y
# gfx_lib.h:258: point rotateY_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _3, p_32(D)->x, _2
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _7, p_32(D)->z, _6
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L363	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L363:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L364	#, tmp167,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L364:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L365	#, tmp193,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L365:
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L366	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L366:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L367	#, tmp210,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L367:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L368	#, tmp236,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L368:
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s5,a0	# tmp265,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s2	#, _3
	call	__floatsisf		#
	mv	a5,a0	# tmp266,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s1	#, _7
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s1,a5	# _18, tmp266
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s2,a0	# tmp267,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s5	#, tmp243
	mv	a0,s1	#, _18
	call	__mulsf3		#
	mv	s7,a0	# tmp244, tmp268
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s2	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, tmp244
	call	__addsf3		#
	mv	s7,a0	# tmp246, tmp270
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s4	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s7	#, tmp246
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s5	#, tmp243
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a0,0(s0)	# tmp272, <retval>.x
# gfx_lib.h:270:   return transformed;
	sw	s6,4(s0)	# _4, <retval>.y
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s2	#, _20
	call	__mulsf3		#
	mv	s2,a0	# tmp250, tmp273
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _18
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s2	#, tmp250
	call	__subsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	mv	a0,s3	#, _6
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib.h:268:   transformed.z = pivot->z + (shifted_point.z*cos_theta - shifted_point.x*sin_theta);
	call	__fixsfsi		#
	sw	a0,8(s0)	# tmp277, <retval>.z
# gfx_lib.h:271: }
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
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	a0,a3	#, tmp262
# gfx_lib.h:273: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	ra,44(sp)	#,
	sw	s1,36(sp)	#,
	sw	s2,32(sp)	#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s1,4(a1)		# p_32(D)->y, p_32(D)->y
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s2,0(a1)		# p_32(D)->x, p_32(D)->x
# gfx_lib.h:273: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s3,28(sp)	#,
	sw	s4,24(sp)	#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s3,4(a2)		# _5, pivot_33(D)->y
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s4,0(a2)		# _2, pivot_33(D)->x
# gfx_lib.h:273: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s6,16(sp)	#,
	sw	s8,8(sp)	#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	lw	s6,8(a1)		# _7, p_32(D)->z
# gfx_lib.h:273: point rotateZ_pivot(point *p, point *pivot, int angle) {
	sw	s5,20(sp)	#,
	sw	s7,12(sp)	#,
	sw	s9,4(sp)	#,
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC1)	# tmp156,
	lw	a2,%lo(.LC1)(a5)		#,
	lw	a3,%lo(.LC1+4)(a5)		#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s2,s2,s4	# _3, p_32(D)->x, _2
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	sub	s1,s1,s3	# _6, p_32(D)->y, _5
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
	lui	a5,%hi(.LC2)	# tmp158,
	lw	a2,%lo(.LC2)(a5)		#,
	lw	a3,%lo(.LC2+4)(a5)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a4,a0,16	#, angle, tmp263
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	s8,a0,16	#, prephitmp_203, tmp263
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, angle, angle
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	srli	s8,s8,16	#, prephitmp_203, prephitmp_203
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L382	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L382:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_53, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp167, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_53, v0.41_53
	mv	a3,s8	# _235, prephitmp_203
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L383	#, tmp167,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L383:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _59, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp179, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	s7,%hi(.LANCHOR1)	# tmp256,
	addi	s7,s7,%lo(.LANCHOR1)	# tmp258, tmp256,
	slli	a5,a5,1	#, tmp175, _59
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp180, tmp179
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,s7,a5	# tmp175, tmp176, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,s7,a4	# tmp180, tmp181, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _60, sin90[_59]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a4)		# sin90[_62], sin90[_62]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp185, _235
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp193, v0.41_53
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp183, sin90[_62], _60
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp186, tmp183, tmp185
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp187, tmp186
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _60, tmp190, tmp187
	slli	a0,a0,16	#, _74, tmp190
	srli	a0,a0,16	#, _74, _74
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L384	#, tmp193,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L384:
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _74
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s5,%hi(.LC3)	# tmp257,
	lw	a3,%lo(.LC3+4)(s5)		#,
	lw	a2,%lo(.LC3)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp203,
	addi	a5,a5,1	#, tmp202, tmp203
	add	a5,s8,a5	# tmp202, tmp201, prephitmp_203
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a5,16	#, angle, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _42, tmp201
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srai	a3,a3,16	#, angle, angle
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# sin_theta, tmp264
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	srli	a4,a4,16	#, _42, _42
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a3,zero,.L385	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L385:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L386	#, tmp210,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L386:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _90, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp222, _90
	slli	a3,a3,1	#, tmp223, tmp222
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp218, _90
	add	a5,s7,a5	# tmp218, tmp219, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a3	# tmp223, tmp224, tmp258
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _91, sin90[_90]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(s7)		# sin90[_93], sin90[_93]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp228, _42
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp236, v0.41_84
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp226, sin90[_93], _91
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp229, tmp226, tmp228
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp230, tmp229
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _91, tmp233, tmp230
	slli	a5,a5,16	#, _105, tmp233
	srli	a5,a5,16	#, _105, _105
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L387	#, tmp236,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L387:
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _105
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s5)		#,
	lw	a3,%lo(.LC3+4)(s5)		#,
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp265,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s2	#, _3
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	s2,a5	# tmp243, tmp265
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	s5,a0	# tmp266,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s1	#, _6
	call	__floatsisf		#
	mv	s1,a0	# tmp267,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s7,a0	# tmp244, tmp268
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp269,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, tmp244
	call	__subsf3		#
	mv	s7,a0	# tmp246, tmp270
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, _2
	call	__floatsisf		#
	mv	a1,a0	# tmp271,
	mv	a0,s7	#, tmp246
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, sin_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a0,0(s0)	# tmp272, <retval>.x
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s5	#, _18
	call	__mulsf3		#
	mv	s4,a0	# tmp250, tmp273
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s2	#, tmp243
	mv	a0,s1	#, _20
	call	__mulsf3		#
	mv	a1,a0	# tmp274,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s4	#, tmp250
	call	__addsf3		#
	mv	s1,a0	# tmp252, tmp275
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, _5
	call	__floatsisf		#
	mv	a1,a0	# tmp276,
	mv	a0,s1	#, tmp252
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	sw	a0,4(s0)	# tmp277, <retval>.y
# gfx_lib.h:285:   return transformed;
	sw	s6,8(s0)	# _7, <retval>.z
# gfx_lib.h:286: }
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
	addi	sp,sp,-144	#,,
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	a1,a1,-1	#, _82, tmp863
# main_cube3d_rotate.c:70: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	ra,140(sp)	#,
	sw	s0,136(sp)	#,
	sw	s1,132(sp)	#,
	sw	s2,128(sp)	#,
	sw	s3,124(sp)	#,
	sw	s4,120(sp)	#,
	sw	s5,116(sp)	#,
	sw	s6,112(sp)	#,
	sw	s7,108(sp)	#,
	sw	s8,104(sp)	#,
	sw	s9,100(sp)	#,
	sw	s10,96(sp)	#,
	sw	s11,92(sp)	#,
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	sw	a1,40(sp)	# _82, %sfp
# main_cube3d_rotate.c:70: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	a0,16(sp)	# tmp862, %sfp
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	beq	a1,zero,.L400	#, _82,,
	mv	s1,a5	# scalef, tmp867
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC4)	# tmp418,
	lw	a1,%lo(.LC4)(a5)		#,
	mv	a0,s1	#, scalef
	mv	s4,a2	# angle_x, tmp864
	mv	s0,a3	# angle_y, tmp865
	mv	s3,a4	# angle_z, tmp866
	call	__mulsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC5)	# tmp956,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	s2,a0	# tmp868,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC5)(a5)		#,
	mv	a1,s2	#, tmp419
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	li	s5,-2147483648		# tmp427,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__subsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a4,%hi(.LC6)	# tmp422,
	lw	a1,%lo(.LC6)(a4)		#,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a5,a0	# tmp869,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a0,s1	#, scalef
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a5,12(sp)	# tmp869, %sfp
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__mulsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC7)	# tmp957,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,a0	# tmp870,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC7)(a5)		#,
	call	__subsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
	mv	s8,a0	# tmp871,
	xor	a0,s5,s2	# tmp419,, tmp427
	sw	s8,44(sp)	# tmp871, %sfp
	call	__fixsfsi		#
	mv	s9,a0	# tmp872,
# main_cube3d_rotate.c:84:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	xor	a0,s5,s4	# angle_x,, tmp427
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	s9,48(sp)	# tmp872, %sfp
# main_cube3d_rotate.c:84:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	call	__fixsfsi		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lui	s5,%hi(.LC1)	# tmp812,
	lw	a2,%lo(.LC1)(s5)		#,
	lw	a3,%lo(.LC1+4)(s5)		#,
	lui	s4,%hi(.LC2)	# tmp813,
	call	__muldf3		#
	lw	a2,%lo(.LC2)(s4)		#,
	lw	a3,%lo(.LC2+4)(s4)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _296, tmp873
	srai	a0,a0,16	#, _296, _296
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp438,
	add	a5,a0,a5	# tmp438, _296, _296
	blt	a0,zero,.L403	#, _296,,
	mv	a5,a0	# _296, _296
.L403:
	slli	s6,a5,16	#, angle, _296
	srai	s6,s6,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s6,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp447, _296
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_331, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp447
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_331, v0.41_331
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	andi	s7,a4,32	#, _332, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,20(sp)	# v0.41_331, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,24(sp)	# v1, %sfp
	not	s2,a4	# v0, v0
	beq	s7,zero,.L458	#, _332,,
.L405:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,s6,16	#, angle.46_305, angle
	li	a4,-24576		# tmp452,
	srli	a5,a5,16	#, angle.46_305, angle.46_305
	addi	a4,a4,1	#, tmp451, tmp452
	add	a4,a5,a4	# tmp451, tmp450, angle.46_305
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _307, tmp450
	li	a3,8192		# tmp455,
	addi	a3,a3,1	#, tmp454, tmp455
	srai	a4,a4,16	#, _307, _307
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s2,s2,31	#, _337, v0
	add	a5,a5,a3	# tmp454, _307, angle.46_305
	blt	a4,zero,.L407	#, _307,,
	mv	a5,a4	# _307, _307
.L407:
	slli	s11,a5,16	#, angle, _307
	srai	s11,s11,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s11,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp462, _307
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_362, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp462
	srai	a5,a5,16	#, v1, v1
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_362, v0.41_362
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,32(sp)	# v1, %sfp
	andi	s10,a4,32	#, _363, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,28(sp)	# v0.41_362, %sfp
	not	a5,a4	# v0, v0
	beq	s10,zero,.L459	#, _363,,
.L409:
# main_cube3d_rotate.c:86:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	li	a0,-2147483648		# tmp466,
# main_cube3d_rotate.c:86:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	xor	a0,a0,s0	# angle_y,, tmp466
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s0,a5,31	#, _368, v0
# main_cube3d_rotate.c:86:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	call	__fixsfsi		#
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC1)(s5)		#,
	lw	a3,%lo(.LC1+4)(s5)		#,
	call	__muldf3		#
	lw	a2,%lo(.LC2)(s4)		#,
	lw	a3,%lo(.LC2+4)(s4)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _216, tmp874
	srai	a0,a0,16	#, _216, _216
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp475,
	add	a5,a0,a5	# tmp475, _216, _216
	blt	a0,zero,.L411	#, _216,,
	mv	a5,a0	# _216, _216
.L411:
	slli	a6,a5,16	#, angle, _216
	srai	a6,a6,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,a6,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp484, _216
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_455, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp484
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_455, v0.41_455
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	andi	t1,a4,32	#, _456, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,36(sp)	# v0.41_455, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,52(sp)	# v1, %sfp
	not	t3,a4	# v0, v0
	beq	t1,zero,.L460	#, _456,,
.L413:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,a6,16	#, angle.46_225, angle
	li	a4,-24576		# tmp489,
	srli	a5,a5,16	#, angle.46_225, angle.46_225
	addi	a4,a4,1	#, tmp488, tmp489
	add	a4,a5,a4	# tmp488, tmp487, angle.46_225
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _227, tmp487
	li	a3,8192		# tmp492,
	addi	a3,a3,1	#, tmp491, tmp492
	srai	a4,a4,16	#, _227, _227
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	t3,t3,31	#, _461, v0
	add	a5,a5,a3	# tmp491, _227, angle.46_225
	blt	a4,zero,.L415	#, _227,,
	mv	a5,a4	# _227, _227
.L415:
	slli	s8,a5,16	#, angle, _227
	srai	s8,s8,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s8,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp499, _227
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_486, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp499
	srai	a5,a5,16	#, v1, v1
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_486, v0.41_486
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,60(sp)	# v1, %sfp
	andi	a7,a4,32	#, _487, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,56(sp)	# v0.41_486, %sfp
	not	a5,a4	# v0, v0
	beq	a7,zero,.L461	#, _487,,
.L417:
# main_cube3d_rotate.c:88:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s3	#, angle_z
	sw	a7,76(sp)	# _487, %sfp
	sw	t3,72(sp)	# _461, %sfp
	sw	t1,68(sp)	# _456, %sfp
	sw	a6,64(sp)	# angle, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s3,a5,31	#, _492, v0
# main_cube3d_rotate.c:88:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	call	__fixsfsi		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC1)(s5)		#,
	lw	a3,%lo(.LC1+4)(s5)		#,
	call	__muldf3		#
	lw	a2,%lo(.LC2)(s4)		#,
	lw	a3,%lo(.LC2+4)(s4)		#,
	call	__divdf3		#
	call	__fixdfsi		#
	slli	a0,a0,16	#, _136, tmp875
	srai	a0,a0,16	#, _136, _136
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp510,
	lw	a6,64(sp)		# angle, %sfp
	lw	t1,68(sp)		# _456, %sfp
	lw	t3,72(sp)		# _461, %sfp
	lw	a7,76(sp)		# _487, %sfp
	add	a5,a0,a5	# tmp510, _136, _136
	blt	a0,zero,.L419	#, _136,,
	mv	a5,a0	# _136, _136
.L419:
	slli	a0,a5,16	#, angle, _136
	srai	a0,a0,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,a0,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_579, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp519, _136
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_579, v0.41_579
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s4,a5,16	#, v1, tmp519
	andi	t5,a4,32	#, _580, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,64(sp)	# v0.41_579, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s4,s4,16	#, v1, v1
	not	a1,a4	# v0, v0
	beq	t5,zero,.L462	#, _580,,
.L421:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,a0,16	#, angle.46_145, angle
	li	a4,-24576		# tmp524,
	srli	a5,a5,16	#, angle.46_145, angle.46_145
	addi	a4,a4,1	#, tmp523, tmp524
	add	a4,a5,a4	# tmp523, tmp522, angle.46_145
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _147, tmp522
	li	a3,8192		# tmp527,
	addi	a3,a3,1	#, tmp526, tmp527
	srai	a4,a4,16	#, _147, _147
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a1,a1,31	#, _585, v0
	add	a5,a5,a3	# tmp526, _147, angle.46_145
	blt	a4,zero,.L423	#, _147,,
	mv	a5,a4	# _147, _147
.L423:
	slli	t6,a5,16	#, angle, _147
	srai	t6,t6,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,t6,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp534, _147
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s9,a4,16	#, v0.41_610, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp534
	andi	t4,a4,32	#, _611, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s9,s9,16	#, v0.41_610, v0.41_610
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	not	a2,a4	# v0, v0
	beq	t4,zero,.L463	#, _611,,
.L425:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,s2,1	#, tmp543, _337
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a4,%hi(.LANCHOR1)	# tmp817,
	addi	a4,a4,%lo(.LANCHOR1)	# tmp811, tmp817,
	slli	s2,s2,1	#, tmp539, _337
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a3,1	#, tmp544, tmp543
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,a4,s2	# tmp539, tmp540, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a4,a3	# tmp544, tmp545, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t2,0(s2)		# pretmp_412, sin90[_337]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a3,0(a3)		# sin90[_340], sin90[_340]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t0,24(sp)	#, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a2,a2,31	#, _616, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a3,a3,t2	# tmp547, sin90[_340], pretmp_412
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s7,zero,.L464	#, _332,,
.L427:
	andi	t0,t0,0xff	# tmp550, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a3,a3,t0	# tmp551, tmp547, tmp550
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	t0,s0,1	#, tmp562, _368
	slli	t0,t0,1	#, tmp563, tmp562
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s0,s0,1	#, tmp558, _368
	add	s0,a4,s0	# tmp558, tmp559, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t0,a4,t0	# tmp563, tmp564, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s0,0(s0)		# pretmp_178, sin90[_368]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t0,0(t0)		# sin90[_371], sin90[_371]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	s2,32(sp)	#, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a3,a3,8	#, tmp552, tmp551
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,t2	# pretmp_412, tmp555, tmp552
	slli	a3,a3,16	#, _542, tmp555
	srli	a3,a3,16	#, _542, _542
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	t0,t0,s0	# tmp566, sin90[_371], pretmp_178
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s10,zero,.L465	#, _363,,
.L429:
	andi	s2,s2,0xff	# tmp569, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s2,t0,s2	# tmp570, tmp566, tmp569
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	t2,t3,1	#, tmp581, _461
	slli	t2,t2,1	#, tmp582, tmp581
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	t3,t3,1	#, tmp577, _461
	add	t3,a4,t3	# tmp577, tmp578, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t2,a4,t2	# tmp582, tmp583, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t0,0(t3)		# pretmp_562, sin90[_461]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t3,0(t2)		# sin90[_464], sin90[_464]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t2,52(sp)	#, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s2,s2,8	#, tmp571, tmp570
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,s2,s0	# pretmp_178, tmp574, tmp571
	slli	s5,s2,16	#, _552, tmp574
	srli	s5,s5,16	#, _552, _552
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	t3,t3,t0	# tmp585, sin90[_464], pretmp_562
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t1,zero,.L466	#, _456,,
.L431:
	andi	t2,t2,0xff	# tmp588, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	t2,t3,t2	# tmp589, tmp585, tmp588
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a6,s3,1	#, tmp600, _492
	slli	a6,a6,1	#, tmp601, tmp600
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s3,s3,1	#, tmp596, _492
	add	s3,a4,s3	# tmp596, tmp597, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a6,a4,a6	# tmp601, tmp602, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t1,0(s3)		# pretmp_565, sin90[_492]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a6,0(a6)		# sin90[_495], sin90[_495]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t3,60(sp)	#, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	t2,t2,8	#, tmp590, tmp589
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t2,t2,t0	# pretmp_562, tmp593, tmp590
	slli	s10,t2,16	#, _564, tmp593
	srli	s10,s10,16	#, _564, _564
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a6,a6,t1	# tmp604, sin90[_495], pretmp_565
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	a7,zero,.L467	#, _487,,
.L433:
	andi	t3,t3,0xff	# tmp607, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a6,a6,t3	# tmp608, tmp604, tmp607
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a7,a1,1	#, tmp619, _585
	slli	a7,a7,1	#, tmp620, tmp619
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a1,a1,1	#, tmp615, _585
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a7,a4,a7	# tmp620, tmp621, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a1,a4,a1	# tmp615, tmp616, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s3,0(a7)		# sin90[_588], sin90[_588]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a1)		# pretmp_200, sin90[_585]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	a7,s4	# v1, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s7,a6,8	#, tmp609, tmp608
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,t1	# pretmp_565, tmp612, tmp609
	slli	s7,s7,16	#, _192, tmp612
	srli	s7,s7,16	#, _192, _192
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s3,s3,a1	# tmp623, sin90[_588], pretmp_200
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t5,zero,.L468	#, _580,,
.L435:
	andi	a7,a7,0xff	# tmp626, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s3,s3,a7	# tmp627, tmp623, tmp626
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a0,a2,1	#, tmp638, _616
	slli	a0,a0,1	#, tmp639, tmp638
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp634, _616
	add	a2,a4,a2	# tmp634, tmp635, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a4,a0	# tmp639, tmp640, tmp811
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a2)		# pretmp_90, sin90[_616]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s2,0(a4)		# sin90[_619], sin90[_619]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s3,s3,8	#, tmp628, tmp627
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,s3,a1	# pretmp_200, tmp631, tmp628
	slli	s3,s3,16	#, _89, tmp631
	srli	s3,s3,16	#, _89, _89
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s2,s2,a2	# tmp642, sin90[_619], pretmp_90
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t4,zero,.L469	#, _611,,
.L437:
	andi	a5,a5,0xff	# tmp645, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s2,s2,a5	# tmp646, tmp642, tmp645
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	lw	a5,20(sp)		# v0.41_331, %sfp
	lw	s0,16(sp)		# ivtmp.473, %sfp
	mv	a0,a3	# v1, _542
	andi	a5,a5,64	#, tmp654, v0.41_331
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s2,s2,8	#, tmp647, tmp646
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,s2,a2	# pretmp_90, tmp650, tmp647
	slli	s2,s2,16	#, _655, tmp650
	srli	s2,s2,16	#, _655, _655
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	bne	a5,zero,.L470	#, tmp654,,
.L439:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s6,%hi(.LC3)	# tmp814,
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	lw	a5,28(sp)		# v0.41_362, %sfp
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	mv	s4,a0	# sin_theta, tmp876
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	mv	a0,s5	# v1, _552
	andi	a5,a5,64	#, tmp665, v0.41_362
	bne	a5,zero,.L471	#, tmp665,,
.L441:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	lw	a5,36(sp)		# v0.41_455, %sfp
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	mv	s5,a0	# cos_theta, tmp877
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	mv	a0,s10	# v1, _564
	andi	a5,a5,64	#, tmp676, v0.41_455
	bne	a5,zero,.L472	#, tmp676,,
.L443:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	lw	a5,56(sp)		# v0.41_486, %sfp
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	sw	a0,16(sp)	# tmp878, %sfp
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	neg	a0,s7	# v1, _192
	andi	a5,a5,64	#, tmp687, v0.41_486
	beq	a5,zero,.L473	#, tmp687,,
.L445:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	lw	a5,64(sp)		# v0.41_579, %sfp
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	sw	a0,20(sp)	# tmp879, %sfp
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	neg	a0,s3	# v1, _89
	andi	a5,a5,64	#, tmp698, v0.41_579
	beq	a5,zero,.L474	#, tmp698,,
.L447:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	andi	a5,s9,64	#, tmp709, v0.41_610
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	s3,a0	# sin_theta, tmp880
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	a0,s2	# v1, _655
	bne	a5,zero,.L475	#, tmp709,,
.L449:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	li	a5,0		# i,
	sw	a5,24(sp)	# i, %sfp
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp972,
	lw	s7,%lo(.LC5)(a5)		# tmp854,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp973,
	lw	s6,%lo(.LC7)(a5)		# tmp855,
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	s2,a0	# cos_theta, tmp881
	li	a5,0		# i,
.L450:
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_736 + 4B]
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	a5,a5,2	#, i, i
	sw	a5,36(sp)	# i, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s8,44(sp)		# _11, %sfp
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s0,s0,24	#, ivtmp.473, ivtmp.473
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _11, tmp720, tmp882
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp720
	call	__floatsisf		#
	mv	s10,a0	# tmp883,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s0)		#, MEM[(int *)_736 + 8B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	s11,48(sp)		# _12, %sfp
	add	a0,a0,s11	# _12,, tmp884
	call	__floatsisf		#
	mv	s9,a0	# tmp885,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s0)		#, MEM[(int *)_736 + 16B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _11, tmp729, tmp886
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp729
	call	__floatsisf		#
	mv	s8,a0	# tmp887,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s0)		#, MEM[(int *)_736 + 20B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s11	# _12,, tmp888
	call	__floatsisf		#
	mv	s11,a0	# tmp889,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s0)		#, MEM[(int *)_736]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _8, %sfp
	add	a0,a0,a5	# _8, tmp738, tmp890
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp738
	call	__floatsisf		#
	lw	a1,20(sp)		#, %sfp
	call	__mulsf3		#
	mv	a6,a0	# tmp891,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _313
	mv	a0,s4	#, sin_theta
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a6,28(sp)	# tmp741, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, _315
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,24(sp)	# tmp742, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	t1,24(sp)		# tmp742, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp893,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,t1	#, tmp742
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,16(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a6,28(sp)		# tmp741, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp894,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a6	#, tmp741
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp895
	call	__floatsisf		#
	mv	a4,a0	# tmp896,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _313
	mv	a0,s5	#, cos_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s10,a4	# _153, tmp896
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _315
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,24(sp)	# tmp754, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,24(sp)		# tmp754, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp898,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp754
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp899
	call	__floatsisf		#
	mv	s9,a0	# tmp900,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s0)		#, MEM[(int *)_736 + 12B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _8, %sfp
	add	a0,a0,a5	# _8, tmp764, tmp901
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp764
	call	__floatsisf		#
	lw	a1,20(sp)		#, %sfp
	call	__mulsf3		#
	mv	a7,a0	# tmp902,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s4	#, sin_theta
	mv	a0,s8	#, _273
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a7,28(sp)	# tmp767, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp768, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s11	#, _275
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	t1,24(sp)		# tmp768, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp904,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,t1	#, tmp768
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,16(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a7,28(sp)		# tmp767, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp905,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a7	#, tmp767
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp906
	call	__floatsisf		#
	mv	a4,a0	# tmp907,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s8	#, _273
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s8,a4	# _113, tmp907
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp780, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, sin_theta
	mv	a0,s11	#, _275
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,24(sp)		# tmp780, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp909,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp780
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp910
	call	__floatsisf		#
	mv	s11,a0	# tmp911,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s3	#, sin_theta
	mv	a0,s8	#, _113
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp787, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s2	#, cos_theta
	mv	a0,s11	#, _115
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,24(sp)		# tmp787, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp913,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp787
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp914,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s2	#, cos_theta
	mv	a0,s8	#, _113
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,32(sp)	# tmp792, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp793, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s3	#, sin_theta
	mv	a0,s11	#, _115
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a7,24(sp)		# tmp793, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp916,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a7	#, tmp793
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	a2,a0	# tmp917,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _153
	mv	a0,s3	#, sin_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,28(sp)	# tmp798, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp799, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, _155
	mv	a0,s2	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a7,24(sp)		# tmp799, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp919,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a7	#, tmp799
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a7,a0	# tmp920,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _153
	mv	a0,s2	#, cos_theta
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s8,a7	# tmp804, tmp920
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp805, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, _155
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a7,24(sp)		# tmp805, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp922,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a7	#, tmp805
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a3,32(sp)		# tmp792, %sfp
	lw	a2,28(sp)		# tmp798, %sfp
	mv	a1,s8	#, tmp804
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	lw	a4,40(sp)		# _82, %sfp
	lw	a5,36(sp)		# i, %sfp
	bgtu	a4,a5,.L450	#, _82, i,
.L400:
# main_cube3d_rotate.c:95: }
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
.L475:
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	neg	a0,s2	# v1, _655
	j	.L449		#
.L474:
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	a0,s3	# v1, _89
	j	.L447		#
.L473:
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	mv	a0,s7	# v1, _192
	j	.L445		#
.L472:
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	neg	a0,s10	# v1, _564
	j	.L443		#
.L471:
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	neg	a0,s5	# v1, _552
	j	.L441		#
.L470:
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	neg	a0,a3	# v1, _542
	j	.L439		#
.L469:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	a5,t6	# v1, angle
	j	.L437		#
.L468:
	mv	a7,a0	# v1, angle
	j	.L435		#
.L467:
	mv	t3,s8	# v1, angle
	j	.L433		#
.L466:
	mv	t2,a6	# v1, angle
	j	.L431		#
.L465:
	mv	s2,s11	# v1, angle
	j	.L429		#
.L464:
	mv	t0,s6	# v1, angle
	j	.L427		#
.L463:
	mv	a2,a4	# v0, v0
	j	.L425		#
.L462:
	mv	a1,a4	# v0, v0
	j	.L421		#
.L461:
	mv	a5,a4	# v0, v0
	j	.L417		#
.L460:
	mv	t3,a4	# v0, v0
	j	.L413		#
.L459:
	mv	a5,a4	# v0, v0
	j	.L409		#
.L458:
	mv	s2,a4	# v0, v0
	j	.L405		#
	.size	render_lines, .-render_lines
	.globl	__gesf2
	.globl	__lesf2
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	lui	a4,%hi(.LANCHOR2)	# tmp2433,
	addi	sp,sp,-192	#,,
	lui	a5,%hi(.LANCHOR2)	# tmp2045,
	addi	a4,a4,%lo(.LANCHOR2)	# tmp2432, tmp2433,
	sw	ra,188(sp)	#,
	sw	s0,184(sp)	#,
	sw	s1,180(sp)	#,
	sw	s2,176(sp)	#,
	sw	s3,172(sp)	#,
	sw	s4,168(sp)	#,
	sw	s5,164(sp)	#,
	sw	s6,160(sp)	#,
	sw	s7,156(sp)	#,
	sw	s8,152(sp)	#,
	sw	s9,148(sp)	#,
	sw	s10,144(sp)	#,
	sw	s11,140(sp)	#,
	addi	a5,a5,%lo(.LANCHOR2)	# ivtmp.561, tmp2045,
	addi	a2,a4,37	#, _3458, tmp2432
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a3,805306368		# tmp990,
.L477:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# _27, MEM[(char *)_3462]
# gfx_lib.h:177:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	addi	a5,a5,1	#, ivtmp.561, ivtmp.561
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _27, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:177:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	bne	a2,a5,.L477	#, _3458, ivtmp.561,
	lui	a5,%hi(framebuffer)	# tmp991,
	addi	a3,a5,%lo(framebuffer)	# tmp2434, tmp2435,
	li	a4,12288		# tmp992,
	add	t2,a3,a4	# tmp992, _3469, tmp2434
	addi	a5,a5,%lo(framebuffer)	# ivtmp.552, tmp991,
.L478:
# gfx_lib.h:213:     framebuffer[i] = rgb;
	sw	zero,0(a5)	#, MEM <vector(2) short unsigned int> [(uint16_t *)_3471]
	addi	a5,a5,4	#, ivtmp.552, ivtmp.552
	bne	t2,a5,.L478	#, _3469, ivtmp.552,
# main_cube3d_rotate.c:107:   float delta_scale = 0.1;//0.8; /* speedup scale */
	lui	a5,%hi(.LC8)	# tmp985,
	lw	a5,%lo(.LC8)(a5)		# delta_scale,
# main_cube3d_rotate.c:103:   int angle = 0;
	sw	zero,88(sp)	#, %sfp
# main_cube3d_rotate.c:107:   float delta_scale = 0.1;//0.8; /* speedup scale */
	sw	a5,112(sp)	# delta_scale, %sfp
# main_cube3d_rotate.c:106:   float s = 4;
	lui	a5,%hi(.LC9)	# tmp986,
	lw	s2,%lo(.LC9)(a5)		# s,
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	lui	a5,%hi(.LC1)	# tmp2048,
	lw	a6,%lo(.LC1+4)(a5)		#,
	lw	a5,%lo(.LC1)(a5)		# tmp2098,
	sw	a6,100(sp)	#, %sfp
	sw	a5,96(sp)	# tmp2098, %sfp
	lui	a5,%hi(.LC2)	# tmp2049,
	lw	a6,%lo(.LC2+4)(a5)		#,
	lw	a5,%lo(.LC2)(a5)		# tmp2099,
	sw	a6,108(sp)	#, %sfp
	sw	a5,104(sp)	# tmp2099, %sfp
	lui	a5,%hi(.LANCHOR1)	# tmp2044,
	addi	a5,a5,%lo(.LANCHOR1)	# tmp2042, tmp2044,
	sw	a5,20(sp)	# tmp2042, %sfp
	lui	a5,%hi(.LANCHOR2+40)	# tmp2056,
	addi	a5,a5,%lo(.LANCHOR2+40)	# ivtmp.547, tmp2056,
	sw	a5,124(sp)	# ivtmp.547, %sfp
	lui	a5,%hi(.LANCHOR2+136)	# tmp2057,
	addi	a5,a5,%lo(.LANCHOR2+136)	# ivtmp.540, tmp2057,
	sw	a5,80(sp)	# ivtmp.540, %sfp
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp1026,
	addi	a5,a5,1	#, tmp1025, tmp1026
	sw	a5,32(sp)	# tmp1025, %sfp
.L531:
# main_cube3d_rotate.c:110:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	lw	a0,88(sp)		#, %sfp
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	li	s3,-2147483648		# tmp1002,
# main_cube3d_rotate.c:110:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	call	__floatsisf		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC4)	# tmp2443,
	lw	a1,%lo(.LC4)(a5)		#,
# main_cube3d_rotate.c:110:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	mv	s0,a0	# tmp2108,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a0,s2	#, s
	call	__mulsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC5)	# tmp2444,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	s1,a0	# tmp2109,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC5)(a5)		#,
	mv	a1,s1	#, tmp994
	call	__subsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a4,%hi(.LC6)	# tmp2445,
	lw	a1,%lo(.LC6)(a4)		#,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a5,a0	# tmp2110,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a0,s2	#, s
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a5,12(sp)	# tmp2110, %sfp
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__mulsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC7)	# tmp2446,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,a0	# tmp2111,
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC7)(a5)		#,
	call	__subsf3		#
# main_cube3d_rotate.c:79:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2112,
	xor	a0,s3,s1	# tmp994,, tmp1002
	sw	a5,16(sp)	# tmp2112, %sfp
	call	__fixsfsi		#
	mv	s6,a0	# tmp2113,
# main_cube3d_rotate.c:84:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	xor	a0,s3,s0	# _1,, tmp1002
	call	__fixsfsi		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,96(sp)		#, %sfp
	lw	a3,100(sp)		#, %sfp
	call	__muldf3		#
	lw	a2,104(sp)		#, %sfp
	lw	a3,108(sp)		#, %sfp
	call	__divdf3		#
	call	__fixdfsi		#
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,a0,16	#, angle.39_638, tmp2114
	srli	a5,a5,16	#, angle.39_638, angle.39_638
	mv	a4,a5	# angle.39_638, angle.39_638
	sw	a5,120(sp)	# angle.39_638, %sfp
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp1014,
	xor	a5,a4,a5	# tmp1014, _639, angle.39_638
	sw	a5,28(sp)	# _639, %sfp
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	slli	a4,a0,16	#, _608, tmp2114
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,a5,16	#, angle, _639
	srai	a5,a5,16	#, angle, angle
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, _608, _608
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	sw	a5,72(sp)	# angle, %sfp
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	sw	a4,92(sp)	# _608, %sfp
	blt	a4,zero,.L480	#, _608,,
	mv	a5,a4	# _608, _608
.L480:
	slli	s10,a5,16	#, angle, _608
	srai	s10,s10,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s10,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1021, _608
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	t0,a4,16	#, v0.41_643, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s1,a5,16	#, v1, tmp1021
	andi	a6,a4,32	#, _644, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	t0,t0,16	#, v0.41_643, v0.41_643
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s1,s1,16	#, v1, v1
	not	s7,a4	# v0, v0
	bne	a6,zero,.L482	#, _644,,
	mv	s7,a4	# v0, v0
.L482:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a4,32(sp)		# tmp1025, %sfp
	slli	a5,s10,16	#, angle.46_617, angle
	srli	a5,a5,16	#, angle.46_617, angle.46_617
	add	a0,a5,a4	# tmp1025, tmp1024, angle.46_617
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a0,a0,16	#, _619, tmp1024
	li	a4,8192		# tmp1029,
	addi	a4,a4,1	#, tmp1028, tmp1029
	srai	a0,a0,16	#, _619, _619
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s7,s7,31	#, _649, v0
	add	a5,a5,a4	# tmp1028, _619, angle.46_617
	blt	a0,zero,.L484	#, _619,,
	mv	a5,a0	# _619, _619
.L484:
	slli	a7,a5,16	#, angle, _619
	srai	a7,a7,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,a7,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_674, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1036, _619
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_674, v0.41_674
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s3,a5,16	#, v1, tmp1036
	andi	s11,a4,32	#, _675, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,36(sp)	# v0.41_674, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s3,s3,16	#, v1, v1
	not	s5,a4	# v0, v0
	bne	s11,zero,.L486	#, _675,,
	mv	s5,a4	# v0, v0
.L486:
	sw	a7,48(sp)	# angle, %sfp
	sw	a6,44(sp)	# _644, %sfp
	sw	t0,40(sp)	# v0.41_643, %sfp
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	call	sin1		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lui	s8,%hi(.LC3)	# tmp2455,
	lw	a2,%lo(.LC3)(s8)		#,
	lw	a3,%lo(.LC3+4)(s8)		#,
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s5,s5,31	#, _680, v0
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s4,a0	# tmp2115,
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	lw	a0,92(sp)		#, %sfp
	call	sin1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s8)		#,
	lw	a3,%lo(.LC3+4)(s8)		#,
	call	__muldf3		#
# gfx_lib.h:263:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	mv	s9,a0	# tmp2116,
# main_cube3d_rotate.c:88:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s0	#, _1
	call	__fixsfsi		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,96(sp)		#, %sfp
	lw	a3,100(sp)		#, %sfp
	call	__muldf3		#
	lw	a2,104(sp)		#, %sfp
	lw	a3,108(sp)		#, %sfp
	call	__divdf3		#
	call	__fixdfsi		#
	slli	s0,a0,16	#, _448, tmp2117
	srai	s0,s0,16	#, _448, _448
	mv	a0,s0	#, _448
	sw	s0,76(sp)	# _448, %sfp
	call	sin1		#
	call	__floatsidf		#
	lw	a3,%lo(.LC3+4)(s8)		#,
	lw	a2,%lo(.LC3)(s8)		#,
	call	__muldf3		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,s0,16	#, angle.44_453, _448
	srli	a5,a5,16	#, angle.44_453, angle.44_453
	mv	a3,a5	# angle.44_453, angle.44_453
	sw	a5,84(sp)	# angle.44_453, %sfp
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp1063,
	xor	a5,a3,a5	# tmp1063, prephitmp_1170, angle.44_453
	sw	a5,24(sp)	# prephitmp_1170, %sfp
	slli	a5,a5,16	#, angle, prephitmp_1170
	srai	a5,a5,16	#, angle, angle
	lw	t0,40(sp)		# v0.41_643, %sfp
	sw	a5,64(sp)	# angle, %sfp
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	s8,a0	# sin_theta, tmp2118
	lw	a6,44(sp)		# _644, %sfp
	mv	a3,a5	# _448, angle
	lw	a7,48(sp)		# angle, %sfp
	blt	s0,zero,.L488	#, _448,,
	mv	a3,s0	# _448, _448
.L488:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a5,32(sp)		# tmp1025, %sfp
	slli	a4,a3,16	#, angle.46_457, _448
	srli	a4,a4,16	#, angle.46_457, angle.46_457
	add	a5,a4,a5	# tmp1025, tmp1065, angle.46_457
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a2,a5,16	#, _459, tmp1065
	srai	a2,a2,16	#, _459, _459
	li	a5,8192		# tmp1070,
	slli	a3,a3,16	#, angle, _448
	addi	a5,a5,1	#, tmp1069, tmp1070
	sw	a2,116(sp)	# _459, %sfp
	srai	a3,a3,16	#, angle, angle
	add	a4,a4,a5	# tmp1069, _459, angle.46_457
	blt	a2,zero,.L490	#, _459,,
	mv	a4,a2	# _459, _459
.L490:
	slli	t1,a4,16	#, angle, _459
	srai	t1,t1,16	#, angle, angle
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,t1,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_767, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp1077, _459
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_767, v0.41_767
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	t4,a4,16	#, v1, tmp1077
	andi	a0,a5,32	#, _768, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a2,40(sp)	# v0.41_767, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	t4,t4,16	#, v1, v1
	not	a4,a5	# v0, v0
	bne	a0,zero,.L492	#, _768,,
	mv	a4,a5	# v0, v0
.L492:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a2,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a2,16	#, v0.41_798, v0
	srli	a5,a5,16	#, v0.41_798, v0.41_798
	sw	a5,44(sp)	# v0.41_798, %sfp
	andi	a1,a2,32	#, _799, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,31	#, _773, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	t5,a3	# v1, angle
	not	a5,a2	# v0, v0
	bne	a1,zero,.L494	#, _799,,
	mv	a5,a2	# v0, v0
.L494:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	t3,20(sp)		# tmp2042, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a2,s7,1	#, tmp1094, _649
	slli	a2,a2,1	#, tmp1095, tmp1094
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s7,s7,1	#, tmp1090, _649
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a2,t3,a2	# tmp1095, tmp1096, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,t3,s7	# tmp1090, tmp1091, tmp2042
	lh	t3,0(s7)		# pretmp_2942, sin90[_649]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a2)		# sin90[_652], sin90[_652]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a5,31	#, _804, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a2,a2,t3	# tmp1098, sin90[_652], pretmp_2942
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a6,zero,.L496	#, _644,,
	mv	s1,s10	# v1, angle
.L496:
	andi	s1,s1,0xff	# tmp1101, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a2,a2,s1	# tmp1102, tmp1098, tmp1101
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	t6,20(sp)		# tmp2042, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a6,s5,1	#, tmp1113, _680
	slli	a6,a6,1	#, tmp1114, tmp1113
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s5,s5,1	#, tmp1109, _680
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a6,t6,a6	# tmp1114, tmp1115, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s5,t6,s5	# tmp1109, tmp1110, tmp2042
	lh	t6,0(s5)		# pretmp_2937, sin90[_680]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a6,0(a6)		# sin90[_683], sin90[_683]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a2,a2,8	#, tmp1103, tmp1102
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a2,a2,t3	# pretmp_2942, tmp1106, tmp1103
	slli	a2,a2,16	#, _2824, tmp1106
	srli	a2,a2,16	#, _2824, _2824
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a6,a6,t6	# tmp1117, sin90[_683], pretmp_2937
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	s11,zero,.L498	#, _675,,
	mv	s3,a7	# v1, angle
.L498:
	andi	s3,s3,0xff	# tmp1120, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a6,a6,s3	# tmp1121, tmp1117, tmp1120
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	t3,20(sp)		# tmp2042, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a7,a4,1	#, tmp1132, _773
	slli	a7,a7,1	#, tmp1133, tmp1132
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp1128, _773
	add	a4,t3,a4	# tmp1128, tmp1129, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a7,t3,a7	# tmp1133, tmp1134, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a4,0(a4)		# pretmp_2988, sin90[_773]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a7,0(a7)		# sin90[_776], sin90[_776]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	t3,t4	# v1, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s3,a6,8	#, tmp1122, tmp1121
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,s3,t6	# pretmp_2937, tmp1125, tmp1122
	slli	s3,s3,16	#, _108, tmp1125
	srli	s3,s3,16	#, _108, _108
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s7,a7,a4	# tmp1136, sin90[_776], pretmp_2988
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a0,zero,.L500	#, _768,,
	mv	t3,t1	# v1, angle
.L500:
	andi	t3,t3,0xff	# tmp1139, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s7,s7,t3	# tmp1140, tmp1136, tmp1139
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a6,20(sp)		# tmp2042, %sfp
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a0,a5,1	#, tmp1151, _804
	slli	a0,a0,1	#, tmp1152, tmp1151
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1147, _804
	add	a5,a6,a5	# tmp1147, tmp1148, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a6,a0	# tmp1152, tmp1153, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a5)		# pretmp_2832, sin90[_804]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s5,0(a0)		# sin90[_807], sin90[_807]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s7,s7,8	#, tmp1141, tmp1140
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a4	# pretmp_2988, tmp1144, tmp1141
	slli	s7,s7,16	#, _2953, tmp1144
	srli	s7,s7,16	#, _2953, _2953
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s5,s5,a5	# tmp1155, sin90[_807], pretmp_2832
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a1,zero,.L502	#, _799,,
	mv	t5,a3	# v1, angle
.L502:
	andi	t5,t5,0xff	# tmp1158, v1
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s5,s5,t5	# tmp1159, tmp1155, tmp1158
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	andi	t0,t0,64	#, tmp1169, v0.41_643
	lw	s0,124(sp)		# ivtmp.547, %sfp
	mv	a0,a2	# v1, _2824
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s5,s5,8	#, tmp1160, tmp1159
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s5,s5,a5	# pretmp_2832, tmp1163, tmp1160
	slli	s5,s5,16	#, _2820, tmp1163
	srli	s5,s5,16	#, _2820, _2820
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	beq	t0,zero,.L504	#, tmp1169,,
	neg	a0,a2	# v1, _2824
.L504:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2477,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	lw	a5,36(sp)		# v0.41_674, %sfp
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	mv	s1,a0	# sin_theta, tmp2119
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	neg	a0,s3	# v1, _108
	andi	a5,a5,64	#, tmp1180, v0.41_674
	bne	a5,zero,.L506	#, tmp1180,,
	mv	a0,s3	# v1, _108
.L506:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2479,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	lw	a5,40(sp)		# v0.41_767, %sfp
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	mv	s3,a0	# cos_theta, tmp2120
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	a0,s7	# v1, _2953
	andi	a5,a5,64	#, tmp1191, v0.41_767
	beq	a5,zero,.L508	#, tmp1191,,
	neg	a0,s7	# v1, _2953
.L508:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2481,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	lw	a5,44(sp)		# v0.41_798, %sfp
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	s7,a0	# cos_theta, tmp2121
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	a0,s5	# v1, _2820
	andi	a5,a5,64	#, tmp1202, v0.41_798
	beq	a5,zero,.L510	#, tmp1202,,
	neg	a0,s5	# v1, _2820
.L510:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2483,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2484,
	lw	s11,%lo(.LC5)(a5)		# tmp2090,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2485,
	lw	s10,%lo(.LC7)(a5)		# tmp2091,
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	sw	s6,36(sp)	# _379, %sfp
	sw	a0,40(sp)	# sin_theta, %sfp
	sw	s8,68(sp)	# sin_theta, %sfp
	sw	s9,44(sp)	# sin_theta, %sfp
.L511:
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_2955 + 4B]
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s0,s0,24	#, ivtmp.547, ivtmp.547
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s8,16(sp)		# _377, %sfp
	add	a0,a0,s8	# _377, tmp1213, tmp2123
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1213
	call	__floatsisf		#
	mv	s5,a0	# tmp2124,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s0)		#, MEM[(int *)_2955 + 8B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,36(sp)		# _379, %sfp
	add	a0,a0,a5	# _379,, tmp2125
	call	__floatsisf		#
	mv	s6,a0	# tmp2126,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s0)		#, MEM[(int *)_2955 + 16B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _377, tmp1222, tmp2127
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1222
	call	__floatsisf		#
	mv	s9,a0	# tmp2128,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s0)		#, MEM[(int *)_2955 + 20B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,36(sp)		# _379, %sfp
	add	a0,a0,a5	# _379,, tmp2129
	call	__floatsisf		#
	mv	s8,a0	# tmp2130,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s0)		#, MEM[(int *)_2955]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _374, %sfp
	add	a0,a0,a5	# _374, tmp1231, tmp2131
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1231
	call	__floatsisf		#
	mv	a1,s4	#, cos_theta
	call	__mulsf3		#
	mv	a4,a0	# tmp2132,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, _625
	mv	a0,s1	#, sin_theta
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a4,52(sp)	# tmp1234, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s6	#, _627
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,48(sp)	# tmp1235, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,48(sp)		# tmp1235, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2134,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1235
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,44(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a4,52(sp)		# tmp1234, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2135,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp1234
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s11	#, tmp2090
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2136
	call	__floatsisf		#
	mv	a5,a0	# tmp2137,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, _625
	mv	a0,s3	#, cos_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s5,a5	# _465, tmp2137
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, _627
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,48(sp)	# tmp1247, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,48(sp)		# tmp1247, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2139,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1247
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, tmp2091
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2140
	call	__floatsisf		#
	mv	s6,a0	# tmp2141,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s0)		#, MEM[(int *)_2955 + 12B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _374, %sfp
	add	a0,a0,a5	# _374, tmp1257, tmp2142
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1257
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	a6,a0	# tmp2143,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s1	#, sin_theta
	mv	a0,s9	#, _585
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a6,52(sp)	# tmp1260, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _587
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,48(sp)	# tmp1261, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s4	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,48(sp)		# tmp1261, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2145,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1261
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,44(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a6,52(sp)		# tmp1260, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2146,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a6	#, tmp1260
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s11	#, tmp2090
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2147
	call	__floatsisf		#
	mv	a5,a0	# tmp2148,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _585
	mv	a0,s4	#, cos_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s9,a5	# _425, tmp2148
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1273, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s1	#, sin_theta
	mv	a0,s8	#, _587
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,48(sp)		# tmp1273, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2150,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1273
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, tmp2091
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2151
	call	__floatsisf		#
	mv	s8,a0	# tmp2152,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a0,40(sp)		#, %sfp
	mv	a1,s9	#, _425
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1280, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s8	#, _427
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,48(sp)		# tmp1280, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2154,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp1280
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, tmp2091
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2155,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s9	#, _425
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,60(sp)	# tmp1285, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1286, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a0,40(sp)		#, %sfp
	mv	a1,s8	#, _427
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,48(sp)		# tmp1286, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2157,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1286
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, tmp2090
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s8,68(sp)		# sin_theta, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2158,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s5	#, _465
	mv	a0,s8	#, sin_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,56(sp)	# tmp1291, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1292, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _467
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a6,48(sp)		# tmp1292, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2160,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a6	#, tmp1292
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, tmp2091
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a6,a0	# tmp2161,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s5	#, _465
	mv	a0,s7	#, cos_theta
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a6,52(sp)	# tmp1297, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1298, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s6	#, _467
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,48(sp)		# tmp1298, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2163,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1298
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, tmp2090
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a4,52(sp)		# tmp1297, %sfp
	lw	a3,60(sp)		# tmp1285, %sfp
	lw	a2,56(sp)		# tmp1291, %sfp
	mv	a1,a4	#, tmp1297
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	lw	a5,80(sp)		# ivtmp.540, %sfp
	bne	s0,a5,.L511	#, ivtmp.547, ivtmp.540,
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a0,116(sp)		#, %sfp
	mv	s0,a5	# ivtmp.540, ivtmp.540
	lw	s5,40(sp)		# sin_theta, %sfp
	call	sin1		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2493,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	s8,68(sp)		# sin_theta, %sfp
	lw	s9,44(sp)		# sin_theta, %sfp
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2494,
	lw	s11,%lo(.LC5)(a5)		# tmp2082,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2495,
	lw	s10,%lo(.LC7)(a5)		# tmp2083,
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	s7,a0	# cos_theta, tmp2164
	sw	s5,68(sp)	# sin_theta, %sfp
	sw	s8,40(sp)	# sin_theta, %sfp
	sw	s4,44(sp)	# cos_theta, %sfp
.L512:
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_37 + 4B]
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s0,s0,24	#, ivtmp.540, ivtmp.540
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s5,16(sp)		# _377, %sfp
	add	a0,a0,s5	# _377, tmp1314, tmp2165
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1314
	call	__floatsisf		#
	mv	s4,a0	# tmp2166,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s0)		#, MEM[(int *)_37 + 8B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,36(sp)		# _379, %sfp
	add	a0,a0,a5	# _379,, tmp2167
	call	__floatsisf		#
	mv	s6,a0	# tmp2168,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s0)		#, MEM[(int *)_37 + 16B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s5	# _377, tmp1323, tmp2169
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1323
	call	__floatsisf		#
	mv	s8,a0	# tmp2170,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s0)		#, MEM[(int *)_37 + 20B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,36(sp)		# _379, %sfp
	add	a0,a0,a5	# _379,, tmp2171
	call	__floatsisf		#
	mv	s5,a0	# tmp2172,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s0)		#, MEM[(int *)_37]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _374, %sfp
	add	a0,a0,a5	# _374, tmp1332, tmp2173
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1332
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	a4,a0	# tmp2174,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s4	#, _1082
	mv	a0,s1	#, sin_theta
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a4,52(sp)	# tmp1335, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1336, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a0,44(sp)		#, %sfp
	mv	a1,s6	#, _1084
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,48(sp)		# tmp1336, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2176,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1336
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a4,52(sp)		# tmp1335, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2177,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp1335
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s11	#, tmp2082
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2178
	call	__floatsisf		#
	mv	a5,a0	# tmp2179,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a0,44(sp)		#, %sfp
	mv	a1,s4	#, _1082
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s4,a5	# _922, tmp2179
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, _1084
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,48(sp)	# tmp1348, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,48(sp)		# tmp1348, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2181,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1348
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, tmp2083
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2182
	call	__floatsisf		#
	mv	s6,a0	# tmp2183,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s0)		#, MEM[(int *)_37 + 12B]
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _374, %sfp
	add	a0,a0,a5	# _374, tmp1358, tmp2184
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1358
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	a6,a0	# tmp2185,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _1042
	mv	a0,s9	#, sin_theta
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a6,52(sp)	# tmp1361, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, _1044
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,48(sp)	# tmp1362, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,48(sp)		# tmp1362, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2187,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1362
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a6,52(sp)		# tmp1361, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2188,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a6	#, tmp1361
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s11	#, tmp2082
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2189
	call	__floatsisf		#
	mv	a5,a0	# tmp2190,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s8	#, _1042
	mv	a0,s3	#, cos_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s8,a5	# _882, tmp2190
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, _1044
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,48(sp)	# tmp1374, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,48(sp)		# tmp1374, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2192,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1374
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, tmp2083
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2193
	call	__floatsisf		#
	mv	s5,a0	# tmp2194,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a0,40(sp)		#, %sfp
	mv	a1,s8	#, _882
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1381, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s5	#, _884
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,48(sp)		# tmp1381, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2196,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp1381
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, tmp2083
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2197,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s8	#, _882
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,60(sp)	# tmp1386, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1387, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a0,40(sp)		#, %sfp
	mv	a1,s5	#, _884
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,48(sp)		# tmp1387, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2199,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1387
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, tmp2082
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s5,68(sp)		# sin_theta, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2200,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, _922
	mv	a0,s5	#, sin_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,56(sp)	# tmp1392, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1393, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _924
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a6,48(sp)		# tmp1393, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2202,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a6	#, tmp1393
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, tmp2083
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a6,a0	# tmp2203,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _922
	mv	a0,s7	#, cos_theta
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a6,52(sp)	# tmp1398, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,48(sp)	# tmp1399, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s6	#, _924
	mv	a0,s5	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,48(sp)		# tmp1399, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2205,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1399
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, tmp2082
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a4,52(sp)		# tmp1398, %sfp
	lw	a3,60(sp)		# tmp1386, %sfp
	lw	a2,56(sp)		# tmp1392, %sfp
	mv	a1,a4	#, tmp1398
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate.c:71:   for (int i = 0; i < s - 1; i = i + 2) {
	lui	a5,%hi(.LANCHOR2+232)	# tmp2503,
	addi	a5,a5,%lo(.LANCHOR2+232)	# tmp2502, tmp2503,
	bne	s0,a5,.L512	#, ivtmp.540, tmp2502,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s0,%hi(.LANCHOR2)	# tmp2505,
	addi	a5,s0,%lo(.LANCHOR2)	# tmp2504, tmp2505,
	lw	a0,232(a5)		#, MEM[(struct point *)&left_bottom].x
	lw	s6,36(sp)		# _379, %sfp
	lw	s8,40(sp)		# sin_theta, %sfp
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s0,%lo(.LANCHOR2)	# tmp2506, tmp2507,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s11,a0	# tmp2206,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,240(a5)		#, MEM[(struct point *)&left_bottom].z
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s1,12(sp)		# _374, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s0,%lo(.LANCHOR2)	# tmp2509, tmp2510,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s3,a0	# tmp2207,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,244(a5)		#, MEM[(struct point *)&left_bottom + 12B].x
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s11,s11,s1	# _374, _268, tmp2206
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s3,s3,s6	# _379, _270, tmp2207
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a4,s0,%lo(.LANCHOR2)	# tmp2511, tmp2512,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	a5,a0	# tmp2208,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,248(a4)		#, MEM[(struct point *)&left_bottom + 12B].y
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a5,a5,s1	# _374, _271, tmp2208
	sw	a5,44(sp)	# _271, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s0,%lo(.LANCHOR2)	# tmp2515, tmp2516,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s5,a0	# tmp2209,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,252(a5)		#, MEM[(struct point *)&left_bottom + 12B].z
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s1,16(sp)		# _377, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s0,%lo(.LANCHOR2)	# tmp2518, tmp2519,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	mv	s4,a0	# tmp2210,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,236(a5)		#, MEM[(struct point *)&left_bottom].y
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s5,s5,s1	# _377, _272, tmp2209
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s4,s4,s6	# _379, _273, tmp2210
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a5,92(sp)		# _608, %sfp
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	s7,a0,s1	# _377, tmp1435, tmp2211
# gfx_lib.h:244:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s7,s7,-32	#, _1515, tmp1435
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	blt	a5,zero,.L513	#, _608,,
	lw	a4,120(sp)		# angle.39_638, %sfp
	sw	a5,72(sp)	# _608, %sfp
	sw	a4,28(sp)	# angle.39_638, %sfp
.L513:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	lw	a1,72(sp)		# angle, %sfp
	lw	a3,28(sp)		# _1538, %sfp
	srai	a5,a1,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_1557, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp1439, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_1557, v0.41_1557
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L514	#, tmp1439,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a1	# tmp1443, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _1538, tmp1443
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _1538, _1538
.L514:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a1,20(sp)		# tmp2042, %sfp
	andi	a5,a5,31	#, _1563, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp1451, _1563
	slli	a4,a4,1	#, tmp1452, tmp1451
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1447, _1563
	add	a5,a1,a5	# tmp1447, tmp1448, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a1,a4	# tmp1452, tmp1453, tmp2042
	lh	a0,0(a4)		# sin90[_1566], sin90[_1566]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _1564, sin90[_1563]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp1457, _1538
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp1465, v0.41_1557
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp1455, sin90[_1566], _1564
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp1458, tmp1455, tmp1457
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp1459, tmp1458
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _1564, tmp1462, tmp1459
	slli	a0,a0,16	#, _1578, tmp1462
	srli	a0,a0,16	#, _1578, _1578
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L515	#, tmp1465,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp1467, _1578
	slli	a0,a0,16	#, _1578, tmp1467
	srli	a0,a0,16	#, _1578, _1578
.L515:
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _1578
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s1,%hi(.LC3)	# tmp2528,
	lw	a2,%lo(.LC3)(s1)		#,
	lw	a3,%lo(.LC3+4)(s1)		#,
# gfx_lib.h:259:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s11,s11,-48	#, _1434, _268
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a5,28(sp)		# _639, %sfp
	lw	a3,32(sp)		# tmp1025, %sfp
# gfx_lib.h:248:   float sin_theta = SIN_FAST(angle);
	mv	s0,a0	# tmp2212,
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	add	a4,a5,a3	# tmp1025, tmp1473, _639
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a6,a4,16	#, angle, tmp1473
	srai	a6,a6,16	#, angle, angle
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _1532, tmp1473
	srli	a4,a4,16	#, _1532, _1532
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	mv	a0,a6	#, angle
	sw	a6,40(sp)	# angle, %sfp
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	sw	a4,36(sp)	# _1532, %sfp
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	call	sin1		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s1)		#,
	lw	a3,%lo(.LC3+4)(s1)		#,
	call	__muldf3		#
# gfx_lib.h:249:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s1,a0	# tmp2213,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s7	#, _1515
	call	__floatsisf		#
	mv	s10,a0	# tmp2214,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s3	#, _270
	call	__floatsisf		#
	mv	s7,a0	# tmp2215,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _1539
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
	mv	s3,a0	# tmp1481, tmp2216
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s7	#, _1541
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2217,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s3	#, tmp1481
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2532,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _1539
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s3,a0	# tmp2218,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp1486, tmp2219
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s7	#, _1541
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2220,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s10	#, tmp1486
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
	mv	s7,a0	# tmp2221,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,s5,-32	#,, _272
	call	__floatsisf		#
	mv	s5,a0	# tmp2222,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _273
	call	__floatsisf		#
	mv	s4,a0	# tmp2223,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s1	#, cos_theta
	mv	a0,s5	#, _1499
	call	__mulsf3		#
	mv	s10,a0	# tmp1491, tmp2224
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, _1501
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2225,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s10	#, tmp1491
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2533,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, _1499
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s10,a0	# tmp2226,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	s5,a0	# tmp1496, tmp2227
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s1	#, cos_theta
	mv	a0,s4	#, _1501
	call	__mulsf3		#
	mv	a1,a0	# tmp2228,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, tmp1496
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a6,40(sp)		# angle, %sfp
	lw	a4,36(sp)		# _1532, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	s4,a0	# _1511, tmp2229
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a6,zero,.L516	#, angle,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a4,28(sp)		# _639, %sfp
	li	a5,8192		# tmp1502,
	addi	a5,a5,1	#, tmp1501, tmp1502
	add	a5,a4,a5	# tmp1501, tmp1500, _639
	slli	a4,a5,16	#, _1532, tmp1500
	slli	a6,a5,16	#, angle, tmp1500
	srli	a4,a4,16	#, _1532, _1532
	srai	a6,a6,16	#, angle, angle
.L516:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a6,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_1588, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a3,a5,32	#, tmp1506, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_1588, v0.41_1588
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a3,zero,.L517	#, tmp1506,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1508, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a6,a6	# tmp1510, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v0, tmp1508
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a6,16	#, _1532, tmp1510
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _1532, _1532
.L517:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a1,20(sp)		# tmp2042, %sfp
	andi	a5,a5,31	#, _1594, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp1518, _1594
	slli	a3,a3,1	#, tmp1519, tmp1518
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1514, _1594
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a1,a3	# tmp1519, tmp1520, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a1,a5	# tmp1514, tmp1515, tmp2042
	lh	a1,0(a5)		# _1595, sin90[_1594]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a3)		# sin90[_1597], sin90[_1597]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,0xff	# tmp1524, _1532
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a2,64	#, tmp1532, v0.41_1588
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp1522, sin90[_1597], _1595
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a4	# tmp1525, tmp1522, tmp1524
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp1526, tmp1525
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _1595, tmp1529, tmp1526
	slli	a5,a5,16	#, _1609, tmp1529
	srli	a5,a5,16	#, _1609, _1609
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L518	#, tmp1532,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp1534, _1609
	slli	a5,a5,16	#, _1609, tmp1534
	srli	a5,a5,16	#, _1609, _1609
.L518:
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _1609
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2537,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s3,s3,-32	#, _1357, _1545
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,44(sp)		# _271, %sfp
# gfx_lib.h:264:   float cos_theta = COS_FAST(angle);
	mv	s5,a0	# tmp2230,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a5,-48	#,, _271
	call	__floatsisf		#
	mv	a1,s1	#, cos_theta
	call	__mulsf3		#
	mv	a5,a0	# tmp2231,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s4	#, _1511
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s4,a5	# tmp1542, tmp2231
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2232,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s4	#, tmp1542
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2539,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
	mv	s4,a0	# tmp2233,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s11	#, _1434
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a5,a0	# tmp2234,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, _1551
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s7,a5	# tmp1549, tmp2234
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2235,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, tmp1549
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2540,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a5,76(sp)		# _448, %sfp
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s11,a0,-48	#, _1354, tmp2236
# gfx_lib.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	blt	a5,zero,.L519	#, _448,,
	lw	a4,84(sp)		# angle.44_453, %sfp
	sw	a5,64(sp)	# _448, %sfp
	sw	a4,24(sp)	# angle.44_453, %sfp
.L519:
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a2,24(sp)		# prephitmp_1170, %sfp
	lw	a5,32(sp)		# tmp1025, %sfp
	add	a5,a2,a5	# tmp1025, tmp1556, prephitmp_1170
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a5,16	#, _1373, tmp1556
	srai	a4,a4,16	#, _1373, _1373
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a6,a5,16	#, prephitmp_1020, tmp1556
	srli	a6,a6,16	#, prephitmp_1020, prephitmp_1020
	mv	a3,a4	# angle, _1373
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L520	#, _1373,,
# gfx_lib.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a3,8192		# tmp1561,
	addi	a3,a3,1	#, tmp1560, tmp1561
	add	a3,a2,a3	# tmp1560, tmp1559, prephitmp_1170
	slli	a6,a3,16	#, prephitmp_1020, tmp1559
	slli	a3,a3,16	#, angle, tmp1559
	srli	a6,a6,16	#, prephitmp_1020, prephitmp_1020
	srai	a3,a3,16	#, angle, angle
.L520:
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a1,a5,16	#, v0.41_1650, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a2,a5,32	#, tmp1565, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a1,a1,16	#, v0.41_1650, v0.41_1650
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a2,zero,.L521	#, tmp1565,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp1569, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a6,a3,16	#, prephitmp_1020, tmp1569
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a6,a6,16	#, prephitmp_1020, prephitmp_1020
.L521:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a2,20(sp)		# tmp2042, %sfp
	andi	a5,a5,31	#, _1656, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp1577, _1656
	slli	a3,a3,1	#, tmp1578, tmp1577
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1573, _1656
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a2,a3	# tmp1578, tmp1579, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a2,a5	# tmp1573, tmp1574, tmp2042
	lh	a2,0(a5)		# _1657, sin90[_1656]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a0,0(a3)		# sin90[_1659], sin90[_1659]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a5,a6,0xff	# tmp1583, prephitmp_1020
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a3,a1,64	#, tmp1591, v0.41_1650
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a2	# tmp1581, sin90[_1659], _1657
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a5	# tmp1584, tmp1581, tmp1583
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp1585, tmp1584
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a2	# _1657, tmp1588, tmp1585
	slli	a0,a0,16	#, _1671, tmp1588
	srli	a0,a0,16	#, _1671, _1671
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a3,zero,.L522	#, tmp1591,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp1593, _1671
	slli	a0,a0,16	#, _1671, tmp1593
	srli	a0,a0,16	#, _1671, _1671
.L522:
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	slli	a0,a0,16	#,, _1671
	srai	a0,a0,16	#,,
	sw	a4,36(sp)	# _1373, %sfp
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2549,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s4,s4,-48	#, _1314, _1425
# gfx_lib.h:274:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s10,s10,-32	#, _1317, _1505
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s7,a0	# tmp2237,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, _1354
	call	__floatsisf		#
	mv	s11,a0	# tmp2238,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s3	#, _1357
	call	__floatsisf		#
	mv	s3,a0	# tmp2239,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _1379
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	sw	a0,28(sp)	# tmp1599, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s3	#, _1381
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a5,28(sp)		# tmp1599, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2241,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a5	#, tmp1599
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2550,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2242,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _1379
	mv	a0,s8	#, sin_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a5,28(sp)	# tmp2242, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1604, tmp2243
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s3	#, _1381
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2244,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp1604
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2551,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	lw	a1,64(sp)		# angle, %sfp
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	lw	a4,36(sp)		# _1373, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a6,a0	# _1391, tmp2245
# gfx_lib.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a1,8	#, v0, angle
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_1681, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a3,a5,32	#, tmp1612, v0
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_1681, v0.41_1681
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a3,zero,.L523	#, tmp1612,,
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a1	# tmp1616, angle
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a3,16	#, prephitmp_1170, tmp1616
	srli	a3,a3,16	#, prephitmp_1170, prephitmp_1170
# gfx_lib.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sw	a3,24(sp)	# prephitmp_1170, %sfp
.L523:
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a1,20(sp)		# tmp2042, %sfp
	andi	a5,a5,31	#, _1687, v0
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,a5,1	#, tmp1624, _1687
	slli	a3,a3,1	#, tmp1625, tmp1624
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1620, _1687
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a1,a3	# tmp1625, tmp1626, tmp2042
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a1,a5	# tmp1620, tmp1621, tmp2042
	lh	a1,0(a5)		# _1688, sin90[_1687]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a3)		# sin90[_1690], sin90[_1690]
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lbu	a3,24(sp)	# tmp1630, %sfp
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a2,a2,64	#, tmp1638, v0.41_1681
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a1	# tmp1628, sin90[_1690], _1688
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,a3	# tmp1631, tmp1628, tmp1630
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp1632, tmp1631
# gfx_lib.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a1	# _1688, tmp1635, tmp1632
	slli	a5,a5,16	#, _1702, tmp1635
	srli	a5,a5,16	#, _1702, _1702
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a2,zero,.L524	#, tmp1638,,
# gfx_lib.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp1640, _1702
	slli	a5,a5,16	#, _1702, tmp1640
	srli	a5,a5,16	#, _1702, _1702
.L524:
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	slli	a0,a5,16	#,, _1702
	srai	a0,a0,16	#,,
	sw	a6,40(sp)	# _1391, %sfp
	lui	s11,%hi(.LC3)	# tmp2557,
	sw	a4,24(sp)	# _1373, %sfp
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s11)		#,
	lw	a3,%lo(.LC3+4)(s11)		#,
	call	__muldf3		#
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a4,24(sp)		# _1373, %sfp
# gfx_lib.h:278:   float sin_theta = SIN_FAST(angle);
	mv	s3,a0	# tmp2246,
# gfx_lib.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	mv	a0,a4	#, _1373
	call	sin1		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s11)		#,
	lw	a3,%lo(.LC3+4)(s11)		#,
	call	__muldf3		#
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp2247,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, _1314
# gfx_lib.h:279:   float cos_theta = COS_FAST(angle);
	mv	s4,a5	# tmp1650, tmp2247
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	s11,a0	# tmp2248,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, _1317
	call	__floatsisf		#
	mv	s10,a0	# tmp2249,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _1339
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _1341
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a0,24(sp)	# tmp1651, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a4,24(sp)		# tmp1651, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2251,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a4	#, tmp1651
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2559,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2252,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _1339
	mv	a0,s4	#, tmp1650
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,36(sp)	# tmp1656, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _1341
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a0,24(sp)	# tmp1657, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a5,24(sp)		# tmp1657, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2254,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s10,%hi(.LANCHOR2)	# tmp2562,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a5	#, tmp1657
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2560,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a6,40(sp)		# _1391, %sfp
	lw	a3,36(sp)		# tmp1656, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2255,
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a0,28(sp)		#, %sfp
	mv	a1,a6	#, _1391
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a2,s10,%lo(.LANCHOR2)	# tmp2561, tmp2562,
	lw	a0,260(a2)		#, MEM[(struct point *)&left_top].y
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a2,16(sp)		# _377, %sfp
	add	a0,a0,a2	# _377, tmp1668, tmp2256
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1668
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a1,s10,%lo(.LANCHOR2)	# tmp2564, tmp2565,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a2,a0	# tmp2257,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,264(a1)		#, MEM[(struct point *)&left_top].z
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a2,24(sp)	# _1934, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2258
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a1,s10,%lo(.LANCHOR2)	# tmp2566, tmp2567,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s11,a0	# tmp2259,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,272(a1)		#, MEM[(struct point *)&left_top + 12B].y
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a2,16(sp)		# _377, %sfp
	add	a0,a0,a2	# _377, tmp1681, tmp2260
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1681
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a1,s10,%lo(.LANCHOR2)	# tmp2569, tmp2570,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a4,a0	# tmp2261,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,276(a1)		#, MEM[(struct point *)&left_top + 12B].z
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a4,44(sp)	# _1894, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2262
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LANCHOR2)	# tmp2572,
	addi	a1,a5,%lo(.LANCHOR2)	# tmp2571, tmp2572,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s10,a0	# tmp2263,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,256(a1)		#, MEM[(struct point *)&left_top].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1694, tmp2264
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1694
	call	__floatsisf		#
	mv	a1,s1	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a2,24(sp)		# _1934, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a5,a0	# tmp2265,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s0	#, sin_theta
	mv	a1,a2	#, _1934
	sw	a2,36(sp)	# _1934, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a5,28(sp)	# tmp1697, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _1936
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,24(sp)	# tmp1698, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a3,24(sp)		# tmp1698, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2267,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a3	#, tmp1698
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,28(sp)		# tmp1697, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2268,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1697
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2574,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2269
	call	__floatsisf		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a2,36(sp)		# _1934, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a5,a0	# tmp2270,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, cos_theta
	mv	a1,a2	#, _1934
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a5,40(sp)	# _1774, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _1936
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,24(sp)	# tmp1710, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a3,24(sp)		# tmp1710, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2272,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a3	#, tmp1710
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2575,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2273
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LANCHOR2)	# tmp2577,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s11,a0	# tmp2274,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a0,a5,%lo(.LANCHOR2)	# tmp2576, tmp2577,
	lw	a0,268(a0)		#, MEM[(struct point *)&left_top + 12B].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1722, tmp2275
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1722
	call	__floatsisf		#
	mv	a1,s1	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a4,44(sp)		# _1894, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a3,a0	# tmp2276,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s0	#, sin_theta
	mv	a1,a4	#, _1894
	sw	a4,36(sp)	# _1894, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a3,28(sp)	# tmp1725, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _1896
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,24(sp)	# tmp1726, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a2,24(sp)		# tmp1726, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2278,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a2	#, tmp1726
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a3,28(sp)		# tmp1725, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2279,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a3	#, tmp1725
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2579,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2280
	call	__floatsisf		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,36(sp)		# _1894, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2281,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, cos_theta
	mv	a1,a4	#, _1894
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,28(sp)	# _1734, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _1896
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,24(sp)	# tmp1738, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,24(sp)		# tmp1738, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2283,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp1738
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2580,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2284
	call	__floatsisf		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a2,28(sp)		# _1734, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s10,a0	# tmp2285,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, tmp1645
	mv	a1,a2	#, _1734
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _1736
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a0,24(sp)	# tmp1745, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a4,24(sp)		# tmp1745, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2287,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a4	#, tmp1745
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2581,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a2,28(sp)		# _1734, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a3,a0	# tmp2288,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, cos_theta
	mv	a1,a2	#, _1734
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,36(sp)	# tmp1750, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _1736
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a0,24(sp)	# tmp1751, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a4,24(sp)		# tmp1751, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2290,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a4	#, tmp1751
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2582,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a5,40(sp)		# _1774, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2291,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, tmp1645
	mv	a1,a5	#, _1774
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,24(sp)	# tmp1756, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a5,28(sp)	# _1774, %sfp
	call	__mulsf3		#
	mv	s10,a0	# tmp1757, tmp2292
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _1776
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2293,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s10	#, tmp1757
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2583,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a5,28(sp)		# _1774, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a4,a0	# tmp2294,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, cos_theta
	mv	a1,a5	#, _1774
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s7,a4	# tmp1762, tmp2294
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	mv	s10,a0	# tmp1763, tmp2295
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _1776
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	a1,a0	# tmp2296,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, tmp1763
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2584,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a2,24(sp)		# tmp1756, %sfp
	lw	a3,36(sp)		# tmp1750, %sfp
	mv	a1,s7	#, tmp1762
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s7,%hi(.LANCHOR2)	# tmp2586,
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2585, tmp2586,
	lw	a0,284(a5)		#, MEM[(struct point *)&right_bottom].y
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s10,16(sp)		# _377, %sfp
	add	a0,a0,s10	# _377, tmp1774, tmp2297
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1774
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2588, tmp2589,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a3,a0	# tmp2298,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,288(a5)		#, MEM[(struct point *)&right_bottom].z
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a3,28(sp)	# _2453, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2299
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a2,s7,%lo(.LANCHOR2)	# tmp2590, tmp2591,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a5,a0	# tmp2300,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,296(a2)		#, MEM[(struct point *)&right_bottom + 12B].y
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a5,24(sp)	# _2455, %sfp
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s10	# _377, tmp1787, tmp2301
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1787
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2593, tmp2594,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s11,a0	# tmp2302,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,300(a5)		#, MEM[(struct point *)&right_bottom + 12B].z
	mv	s10,s7	# tmp2594, tmp2594
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2303
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a2,s10,%lo(.LANCHOR2)	# tmp2595, tmp2596,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s7,a0	# tmp2304,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,280(a2)		#, MEM[(struct point *)&right_bottom].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1800, tmp2305
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1800
	call	__floatsisf		#
	mv	a1,s1	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a3,28(sp)		# _2453, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s10,a0	# tmp2306,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s0	#, sin_theta
	mv	a1,a3	#, _2453
	sw	a3,36(sp)	# _2453, %sfp
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a5,24(sp)		# _2455, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,28(sp)	# tmp1804, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	mv	a1,a5	#, _2455
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a4,28(sp)		# tmp1804, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2308,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a4	#, tmp1804
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2309,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s10	#, tmp1803
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2598,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2310
	call	__floatsisf		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a3,36(sp)		# _2453, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s10,a0	# tmp2311,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, cos_theta
	mv	a1,a3	#, _2453
	call	__mulsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,24(sp)		# _2455, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s9,a0	# tmp1816, tmp2312
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s0	#, sin_theta
	mv	a1,a5	#, _2455
	call	__mulsf3		#
	mv	a1,a0	# tmp2313,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s9	#, tmp1816
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2599,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2314
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LANCHOR2)	# tmp2601,
	addi	a2,a5,%lo(.LANCHOR2)	# tmp2600, tmp2601,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s9,a0	# tmp2315,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,292(a2)		#, MEM[(struct point *)&right_bottom + 12B].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1828, tmp2316
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1828
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a5,a0	# tmp2317,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _2413
	mv	a0,s0	#, sin_theta
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a5,28(sp)	# tmp1831, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s7	#, _2415
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,24(sp)	# tmp1832, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a4,24(sp)		# tmp1832, %sfp
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2319,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a4	#, tmp1832
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,28(sp)		# tmp1831, %sfp
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2320,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1831
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2603,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2321
	call	__floatsisf		#
	mv	a5,a0	# tmp2322,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _2413
	mv	a0,s1	#, cos_theta
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a5,24(sp)	# _2253, %sfp
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1844, tmp2323
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s7	#, _2415
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2324,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s11	#, tmp1844
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2604,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2325
	call	__floatsisf		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a5,24(sp)		# _2253, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s7,a0	# tmp2326,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s3	#, tmp1645
	mv	a1,a5	#, _2253
	call	__mulsf3		#
	mv	s11,a0	# tmp1851, tmp2327
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s7	#, _2255
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	a1,a0	# tmp2328,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp1851
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2605,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a5,24(sp)		# _2253, %sfp
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a3,a0	# tmp2329,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, tmp1650
	mv	a1,a5	#, _2253
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,24(sp)	# tmp1856, %sfp
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1857, tmp2330
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, _2255
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	a1,a0	# tmp2331,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, tmp1857
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2606,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	s11,a0	# tmp2332,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _2293
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
	mv	s7,a0	# tmp1863, tmp2333
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, _2295
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	a1,a0	# tmp2334,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s7	#, tmp1863
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2607,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	s7,a0	# tmp2335,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _2293
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	s10,a0	# tmp1869, tmp2336
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, _2295
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2337,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, tmp1869
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2608,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	lw	a3,24(sp)		# tmp1856, %sfp
	mv	a2,s11	#, tmp1862
	mv	a1,s7	#, tmp1868
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s7,%hi(.LANCHOR2)	# tmp2610,
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2609, tmp2610,
	lw	a0,308(a5)		#, MEM[(struct point *)&right_top].y
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s8,16(sp)		# _377, %sfp
	add	a0,a0,s8	# _377, tmp1880, tmp2338
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1880
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2612, tmp2613,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s11,a0	# tmp2339,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,312(a5)		#, MEM[(struct point *)&right_top].z
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2340
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2614, tmp2615,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s10,a0	# tmp2341,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,320(a5)		#, MEM[(struct point *)&right_top + 12B].y
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _377, tmp1893, tmp2342
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-32	#,, tmp1893
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a5,s7,%lo(.LANCHOR2)	# tmp2617, tmp2618,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s9,a0	# tmp2343,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,324(a5)		#, MEM[(struct point *)&right_top + 12B].z
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s6	# _379,, tmp2344
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	addi	a2,s7,%lo(.LANCHOR2)	# tmp2619, tmp2620,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s8,a0	# tmp2345,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,304(a2)		#, MEM[(struct point *)&right_top].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1906, tmp2346
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1906
	call	__floatsisf		#
	mv	a1,s1	#, cos_theta
	call	__mulsf3		#
	mv	s6,a0	# tmp2347,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _2879
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	s7,a0	# tmp1910, tmp2348
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _2881
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2349,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s7	#, tmp1910
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2350,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s6	#, tmp1909
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a3,%hi(.LC5)	# tmp2622,
	lw	a1,%lo(.LC5)(a3)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2351
	call	__floatsisf		#
	mv	s7,a0	# tmp2352,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _2879
	mv	a0,s1	#, cos_theta
	call	__mulsf3		#
	mv	s1,a0	# tmp1922, tmp2353
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _2881
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2354,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, tmp1922
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	s11,%hi(.LC7)	# tmp2623,
	lw	a1,%lo(.LC7)(s11)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2355
	call	__floatsisf		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LANCHOR2)	# tmp2625,
	addi	a5,a5,%lo(.LANCHOR2)	# tmp2624, tmp2625,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s6,a0	# tmp2356,
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,316(a5)		#, MEM[(struct point *)&right_top + 12B].x
	call	__floatsisf		#
	mv	a1,s2	#, s
	call	__mulsf3		#
# gfx_lib.h:233:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib.h:238:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a1,12(sp)		# _374, %sfp
	add	a0,a0,a1	# _374, tmp1934, tmp2357
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-48	#,, tmp1934
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	s1,a0	# tmp2358,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, _2839
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp1938, tmp2359
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _2841
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2360,
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s10	#, tmp1938
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib.h:253:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2361,
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s1	#, tmp1937
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	s10,%hi(.LC5)	# tmp2627,
	lw	a1,%lo(.LC5)(s10)		#,
	call	__addsf3		#
# gfx_lib.h:266:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-48	#,, tmp2362
	call	__floatsisf		#
	mv	s1,a0	# tmp2363,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _2839
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s5,a0	# tmp1950, tmp2364
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s8	#, _2841
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2365,
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, tmp1950
	call	__subsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a1,%lo(.LC7)(s11)		#,
	call	__addsf3		#
# gfx_lib.h:252:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-32	#,, tmp2366
	call	__floatsisf		#
	mv	s0,a0	# tmp2367,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s1	#, _2679
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	s5,a0	# tmp1957, tmp2368
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s0	#, _2681
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	a1,a0	# tmp2369,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s5	#, tmp1957
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a1,%lo(.LC7)(s11)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s1	#, _2679
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s5,a0	# tmp2370,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	s1,a0	# tmp1963, tmp2371
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s0	#, _2681
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	a1,a0	# tmp2372,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s1	#, tmp1963
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s10)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	s1,a0	# tmp2373,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s7	#, _2719
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	s0,a0	# tmp1969, tmp2374
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _2721
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	a1,a0	# tmp2375,
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s0	#, tmp1969
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a1,%lo(.LC7)(s11)		#,
	call	__addsf3		#
# gfx_lib.h:282:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	s0,a0	# tmp2376,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, _2719
	mv	a0,s4	#, tmp1650
	call	__mulsf3		#
	mv	s4,a0	# tmp1975, tmp2377
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s6	#, _2721
	mv	a0,s3	#, tmp1645
	call	__mulsf3		#
	mv	a1,a0	# tmp2378,
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, tmp1975
	call	__subsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s10)		#,
	call	__addsf3		#
# gfx_lib.h:281:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate.c:92:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, RGB256(0x07, 0x03, 0x3));
	mv	a3,s5	#, tmp1962
	mv	a2,s1	#, tmp1968
	mv	a1,s0	#, tmp1974
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,805306368		# tmp1982,
	li	a3,21		# tmp1983,
	sw	a3,12(a5)	# tmp1983, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,117		# tmp1990,
	sw	a4,12(a5)	# tmp1990, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	sw	a3,12(a5)	# tmp1983, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a3,95		# tmp2002,
	sw	a3,12(a5)	# tmp2002, MEM[(volatile uint32_t *)805306380B]
	sw	a4,12(a5)	# tmp1990, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a5)	#, MEM[(volatile uint32_t *)805306380B]
	li	a4,63		# tmp2010,
	sw	a4,12(a5)	# tmp2010, MEM[(volatile uint32_t *)805306380B]
	lui	a5,%hi(framebuffer)	# tmp2634,
	lui	a4,%hi(framebuffer+12288)	# tmp2838,
	addi	a5,a5,%lo(framebuffer)	# tmp2633, tmp2634,
	li	a3,805306368		# tmp2015,
	addi	t2,a4,%lo(framebuffer+12288)	# tmp2837, tmp2838,
.L525:
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# MEM[(uint16_t *)_30], MEM[(uint16_t *)_30]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	addi	a5,a5,2	#, ivtmp.533, ivtmp.533
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	ori	a4,a4,256	#, _60, MEM[(uint16_t *)_30]
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _60, MEM[(volatile uint32_t *)805306380B]
# gfx_lib.h:129:   for (int i = 0; i < (VRES*HRES); i++) {
	bne	a5,t2,.L525	#, ivtmp.533, _3469,
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a5,21		# tmp2018,
	sw	a5,12(a3)	# tmp2018, MEM[(volatile uint32_t *)805306380B]
	sw	zero,12(a3)	#, MEM[(volatile uint32_t *)805306380B]
	li	a5,95		# tmp2023,
	sw	a5,12(a3)	# tmp2023, MEM[(volatile uint32_t *)805306380B]
	li	a5,117		# tmp2026,
	sw	a5,12(a3)	# tmp2026, MEM[(volatile uint32_t *)805306380B]
# main_cube3d_rotate.c:122:     if (s >= 10) delta_scale = -delta_scale;
	lui	a5,%hi(.LC10)	# tmp2635,
	lw	a1,%lo(.LC10)(a5)		#,
# gfx_lib.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	zero,12(a3)	#, MEM[(volatile uint32_t *)805306380B]
	li	a5,63		# tmp2031,
	sw	a5,12(a3)	# tmp2031, MEM[(volatile uint32_t *)805306380B]
# main_cube3d_rotate.c:122:     if (s >= 10) delta_scale = -delta_scale;
	mv	a0,s2	#, s
	call	__gesf2		#
# main_cube3d_rotate.c:119:     angle += delta_angle;
	lw	a5,88(sp)		# angle, %sfp
	addi	a5,a5,-4	#, angle, angle
	sw	a5,88(sp)	# angle, %sfp
# main_cube3d_rotate.c:122:     if (s >= 10) delta_scale = -delta_scale;
	blt	a0,zero,.L526	#, tmp2379,,
# main_cube3d_rotate.c:122:     if (s >= 10) delta_scale = -delta_scale;
	lw	a4,112(sp)		# tmp2639, %sfp
	li	a5,-2147483648		# tmp2036,
	xor	a5,a5,a4	# tmp2639, tmp2638, tmp2036
	sw	a5,112(sp)	# tmp2638, %sfp
.L526:
# main_cube3d_rotate.c:123:     if (s <= 0) delta_scale = -delta_scale;
	mv	a1,zero	#,
	mv	a0,s2	#, s
	call	__lesf2		#
	bgt	a0,zero,.L528	#, tmp2380,,
# main_cube3d_rotate.c:123:     if (s <= 0) delta_scale = -delta_scale;
	lw	a4,112(sp)		# tmp2641, %sfp
	li	a5,-2147483648		# tmp2039,
	xor	a5,a5,a4	# tmp2641, tmp2640, tmp2039
	sw	a5,112(sp)	# tmp2640, %sfp
.L528:
# main_cube3d_rotate.c:124:     s += delta_scale;
	lw	a1,112(sp)		#, %sfp
	mv	a0,s2	#, s
	call	__addsf3		#
	lui	a5,%hi(framebuffer)	# tmp2643,
	lui	a4,%hi(framebuffer+12288)	# tmp2832,
	mv	s2,a0	# s, tmp2381
	addi	a5,a5,%lo(framebuffer)	# tmp2642, tmp2643,
	addi	t2,a4,%lo(framebuffer+12288)	# tmp2831, tmp2832,
.L530:
# gfx_lib.h:213:     framebuffer[i] = rgb;
	sw	zero,0(a5)	#, MEM <vector(2) short unsigned int> [(uint16_t *)_22]
	addi	a5,a5,4	#, ivtmp.524, ivtmp.524
	bne	a5,t2,.L530	#, ivtmp.524, _3469,
	j	.L531		#
	.size	main, .-main
	.globl	roof
	.globl	right_bottom
	.globl	right_top
	.globl	left_bottom
	.globl	left_top
	.globl	back
	.globl	front
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
	.word	1084227584
	.align	2
.LC5:
	.word	1111490560
	.align	2
.LC6:
	.word	1097859072
	.align	2
.LC7:
	.word	1107296256
	.align	2
.LC8:
	.word	1036831949
	.align	2
.LC9:
	.word	1082130432
	.align	2
.LC10:
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
	.size	front, 96
front:
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
	.type	back, @object
	.size	back, 96
back:
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
	.size	framebuffer, 12288
framebuffer:
	.zero	12288
	.section	.sbss,"aw",@nobits
	.align	2
	.type	heap_memory_used, @object
	.size	heap_memory_used, 4
heap_memory_used:
	.zero	4
	.ident	"GCC: (GNU) 11.1.0"
