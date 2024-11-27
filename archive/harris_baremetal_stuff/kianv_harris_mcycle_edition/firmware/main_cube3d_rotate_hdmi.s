	.file	"main_cube3d_rotate_hdmi.c"
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
	.type	fb_draw_bresenham.constprop.0, @function
fb_draw_bresenham.constprop.0:
	addi	sp,sp,-32	#,,
	sw	s1,20(sp)	#,
	mv	s1,a0	# x0, tmp119
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sub	a0,a2,a0	#, x1, x0
# gfx_lib_hdmi.h:209: void fb_draw_bresenham(uint32_t *fb, int x0, int y0, int x1, int y1, short color)
	sw	ra,28(sp)	#,
	sw	s0,24(sp)	#,
	sw	s2,16(sp)	#,
	mv	s0,a1	# y0, tmp120
	sw	s3,12(sp)	#,
	sw	s4,8(sp)	#,
	mv	s3,a2	# x1, tmp121
	sw	s5,4(sp)	#,
# gfx_lib_hdmi.h:209: void fb_draw_bresenham(uint32_t *fb, int x0, int y0, int x1, int y1, short color)
	mv	s5,a3	# y1, tmp122
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	call	abs		#
	mv	s2,a0	# tmp123,
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sub	a0,s5,s0	#, y1, y0
	call	abs		#
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	sgt	s4,s3,s1	# tmp107, x1, x0
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	sgt	t3,s5,s0	# tmp111, y1, y0
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	slli	s4,s4,1	#, iftmp.50_16, tmp107
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	slli	t3,t3,1	#, iftmp.51_20, tmp111
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	lui	a2,%hi(framebuffer)	# tmp116,
# gfx_lib_hdmi.h:212:   int dx =  abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	addi	s4,s4,-1	#, iftmp.50_16, iftmp.50_16
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	neg	a7,a0	# dy, _8
# gfx_lib_hdmi.h:213:   int dy = -abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	addi	t3,t3,-1	#, iftmp.51_20, iftmp.51_20
	sub	a4,s2,a0	# err, dx, _8
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a6,79		# tmp94,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	t1,59		# tmp115,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	addi	a2,a2,%lo(framebuffer)	# tmp117, tmp116,
	li	a3,-1		# tmp118,
.L4:
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,s0,2	#, tmp97, y0
	add	a5,a5,s0	# y0, tmp98, tmp97
	slli	a5,a5,4	#, tmp99, tmp98
	add	a5,a5,s1	# x0, tmp100, tmp99
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,2	#, tmp101, tmp100
# gfx_lib_hdmi.h:220:     e2 = 2*err;
	slli	a1,a4,1	#, e2, err
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	add	a5,a5,a2	# tmp117, tmp102, tmp101
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	bgtu	s1,a6,.L5	#, x0, tmp94,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	bgtu	s0,t1,.L5	#, y0, tmp115,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	sw	a3,0(a5)	# tmp118, *_36
.L5:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	beq	s3,s1,.L14	#, x1, x0,
.L6:
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	a7,a1,.L8	#, dy, e2,
	sub	a4,a4,a0	# err, err, _8
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s4	# iftmp.50_16, x0, x0
.L8:
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L4	#, dx, e2,
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a4,a4,s2	# dx, err, err
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,t3	# iftmp.51_20, y0, y0
	j	.L4		#
.L14:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	bne	s5,s0,.L6	#, y1, y0,
# gfx_lib_hdmi.h:224: }
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
	beq	a2,zero,.L20	#, tmp89,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a4	# _1, _5, _12
	sw	a5,0(a0)	# _5,* p
	ret	
.L20:
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
	beq	a1,zero,.L23	#, tmp95,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _7, _11, _6
	sw	a5,28(a4)	# _11,
# kianv_stdlib.h:133: }
	ret	
.L23:
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
	beq	a1,zero,.L27	#, tmp95,,
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a5,a5,a3	# _4, _8, _19
	sw	a5,20(a4)	# _8,
	ret	
.L27:
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
.L34:
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
	bgtu	a4,a5,.L34	#, tmp100, tmph0.0_11,
	bne	a4,a5,.L31	#, tmp100, tmph0.0_11,
	bgtu	a2,a3,.L34	#, tmp129, tmpl0.1_14,
.L31:
# kianv_stdlib.h:165: }
	addi	sp,sp,16	#,,
	jr	ra		#
	.size	wait_cycles, .-wait_cycles
	.align	2
	.globl	usleep
	.type	usleep, @function
usleep:
# kianv_stdlib.h:168:   if (us) wait_cycles(us * (get_cpu_freq() / 1000000));
	beq	a0,zero,.L45	#, us,,
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
.L42:
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
	bgtu	a5,a4,.L42	#, tmp112, tmph0.0_14,
	bne	a5,a4,.L36	#, tmp112, tmph0.0_14,
	bgtu	a2,a3,.L42	#, tmp141, tmpl0.1_17,
.L36:
# kianv_stdlib.h:169: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L45:
	ret	
	.size	usleep, .-usleep
	.align	2
	.globl	msleep
	.type	msleep, @function
msleep:
# kianv_stdlib.h:172:   if (ms) wait_cycles(ms * (get_cpu_freq() / 1000));
	beq	a0,zero,.L57	#, ms,,
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
.L54:
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
	bgtu	a5,a4,.L54	#, tmp111, tmph0.0_14,
	bne	a5,a4,.L48	#, tmp111, tmph0.0_14,
	bgtu	a2,a3,.L54	#, tmp140, tmpl0.1_17,
.L48:
# kianv_stdlib.h:173: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L57:
	ret	
	.size	msleep, .-msleep
	.align	2
	.globl	sleep
	.type	sleep, @function
sleep:
# kianv_stdlib.h:176:   if (sec) wait_cycles(sec * get_cpu_freq());
	beq	a0,zero,.L69	#, sec,,
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
.L66:
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
	bgtu	a4,a5,.L66	#, tmp107, tmph0.0_13,
	bne	a4,a5,.L60	#, tmp107, tmph0.0_13,
	bgtu	a0,a3,.L66	#, tmp136, tmpl0.1_16,
.L60:
# kianv_stdlib.h:177: }
	addi	sp,sp,16	#,,
	jr	ra		#
.L69:
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
.L79:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L79	#, _1,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a0,0(a4)	# c, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	li	a5,13		# tmp77,
	beq	a0,a5,.L83	#, c, tmp77,
# kianv_stdlib.h:198: }
	ret	
.L83:
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
.L85:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L85	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	li	a5,13		# tmp77,
	beq	a0,a5,.L89	#, ch, tmp77,
	ret	
.L89:
	li	a5,10		# tmp79,
	sw	a5,0(a4)	# tmp79, MEM[(volatile uint32_t *)805306368B]
	ret	
	.size	print_chr, .-print_chr
	.align	2
	.globl	print_char
	.type	print_char, @function
print_char:
	li	a4,805306368		# tmp75,
.L91:
	lw	a5,0(a4)		# _4, MEM[(volatile uint32_t *)805306368B]
	beq	a5,zero,.L91	#, _4,,
	sw	a0,0(a4)	# ch, MEM[(volatile uint32_t *)805306368B]
	li	a5,13		# tmp77,
	beq	a0,a5,.L95	#, ch, tmp77,
	ret	
.L95:
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
	beq	a3,zero,.L96	#, _3,,
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp77,
# kianv_stdlib.h:195:    if (c == 13) {
	li	a2,13		# tmp80,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp83,
.L98:
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _1, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L98	#, _1,,
# kianv_stdlib.h:212:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L99:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _9, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L99	#, _9,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a3,a2,.L113	#, _3, tmp80,
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L98	#, _3,,
.L96:
# kianv_stdlib.h:214: }
	ret	
.L113:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp83, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _3, MEM[(char *)p_8]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L98	#, _3,,
	ret	
	.size	print_str, .-print_str
	.align	2
	.globl	print_str_ln
	.type	print_str_ln, @function
print_str_ln:
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, *p_2(D)
# kianv_stdlib.h:209:   while (*p != 0) {
	beq	a3,zero,.L115	#, _9,,
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	li	a5,805306368		# tmp78,
# kianv_stdlib.h:195:    if (c == 13) {
	li	a2,13		# tmp81,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a1,10		# tmp89,
.L116:
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _5, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:210:     while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L116	#, _5,,
# kianv_stdlib.h:212:     putchar(*(p++));
	addi	a0,a0,1	#, p, p
.L117:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _8, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L117	#, _8,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a3,0(a5)	# _9, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a3,a2,.L134	#, _9, tmp81,
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, MEM[(char *)p_7]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L116	#, _9,,
.L115:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp84,
.L121:
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L121	#, _3,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	li	a5,13		# tmp86,
	sw	a5,0(a4)	# tmp86, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	li	a5,10		# tmp88,
	sw	a5,0(a4)	# tmp88, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:219: }
	ret	
.L134:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp89, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:209:   while (*p != 0) {
	lbu	a3,0(a0)	# _9, MEM[(char *)p_7]
# kianv_stdlib.h:209:   while (*p != 0) {
	bne	a3,zero,.L116	#, _9,,
	j	.L115		#
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
.L136:
# kianv_stdlib.h:224:   while (val || p == buffer) {
	bne	a0,zero,.L137	#, val,,
# kianv_stdlib.h:224:   while (val || p == buffer) {
	bne	a4,a2,.L144	#, p, tmp92,
.L137:
# kianv_stdlib.h:225:     *(p++) = val % 10;
	remu	a3,a0,a5	# tmp93, tmp83, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	addi	a4,a4,1	#, p, p
# kianv_stdlib.h:226:     val = val / 10;
	divu	a0,a0,a5	# tmp93, val, val
# kianv_stdlib.h:225:     *(p++) = val % 10;
	sb	a3,-1(a4)	# tmp83, MEM[(char *)p_18 + 4294967295B]
	j	.L136		#
.L144:
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	li	a3,805306368		# tmp88,
.L138:
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a3)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:230:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L138	#, _3,,
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a4)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a4,a4,-1	#, p, p
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:232:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a3)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:229:   while (p != buffer) {
	bne	a4,a2,.L138	#, p, tmp92,
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
	j	.L146		#
.L147:
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
.L146:
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
	bne	a3,zero,.L147	#, val,,
# kianv_stdlib.h:239:   while (val || p == buffer) {
	beq	a2,t3,.L147	#, p, tmp254,
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp202,
.L148:
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _3, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:245:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L148	#, _3,,
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	lbu	a5,-1(a2)	# MEM[(char *)p_16], MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a2,a2,-1	#, p, p
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	addi	a5,a5,48	#, _7, MEM[(char *)p_16]
# kianv_stdlib.h:247:     *((volatile uint32_t*) UART_TX) = '0' + *(--p);
	sw	a5,0(a4)	# _7, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:244:   while (p != buffer) {
	bne	a2,t3,.L148	#, p, tmp254,
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
	blt	a3,zero,.L154	#, i,,
	lui	a2,%hi(.LC0)	# tmp95,
	li	a1,-4		# _8,
	addi	a2,a2,%lo(.LC0)	# tmp94, tmp95,
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	li	a4,805306368		# tmp87,
.L156:
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	lw	a5,0(a4)		# _2, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:253:     while (!*((volatile uint32_t*) UART_READY))
	beq	a5,zero,.L156	#, _2,,
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
	bne	a1,a3,.L156	#, _8, i,
.L154:
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
.L165:
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
	beq	s0,s4,.L173	#, x0, x1,
.L166:
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	t4,a5,.L168	#, dy, e2,
# kianv_stdlib.h:287:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s0,s0,s5	# iftmp.6_9, x0, x0
	sub	a6,a6,a0	# err, err, _3
	slli	a1,s0,8	#, tmp107, x0
.L168:
# kianv_stdlib.h:288:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a5,.L165	#, dx, e2,
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
	bne	s0,s4,.L166	#, x0, x1,
.L173:
# kianv_stdlib.h:285:     if (x0 == x1 && y0 == y1) break;
	bne	s1,s6,.L166	#, y0, y1,
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
	beq	t1,zero,.L177	#, _14,,
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
.L202:
# stdlib.c:97: 		if (format[i] == '%') {
	beq	t1,t2,.L178	#, _14, tmp120,
.L179:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _42, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L179	#, _42,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	t1,0(a5)	# _14, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	t1,t0,.L231	#, _14, tmp216,
.L182:
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	addi	a3,a3,1	#, i, i
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	add	a4,a0,a3	# i, tmp193, format
	lbu	t1,0(a4)	# _14, *_13
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	bne	t1,zero,.L202	#, _14,,
.L177:
# stdlib.c:121: }
	lw	s0,60(sp)		#,
	li	a0,0		#,
	addi	sp,sp,96	#,,
	jr	ra		#
.L201:
# stdlib.c:99: 				if (format[i] == 'c') {
	beq	a4,a7,.L232	#, _10, tmp205,
# stdlib.c:103: 				if (format[i] == 's') {
	beq	a4,t3,.L233	#, _10, tmp206,
# stdlib.c:107: 				if (format[i] == 'd') {
	beq	a4,t4,.L234	#, _10, tmp207,
# stdlib.c:111: 				if (format[i] == 'u') {
	beq	a4,t5,.L235	#, _10, tmp208,
.L178:
# stdlib.c:98: 			while (format[++i]) {
	addi	a3,a3,1	#, i, i
# stdlib.c:98: 			while (format[++i]) {
	add	a4,a0,a3	# i, tmp187, format
	lbu	a4,0(a4)	# _10, MEM[(const char *)_131]
# stdlib.c:98: 			while (format[++i]) {
	bne	a4,zero,.L201	#, _10,,
	j	.L182		#
.L232:
# stdlib.c:100: 					printf_c(va_arg(ap,int));
	lw	a4,12(sp)		# D.2697, ap
	lw	a2,0(a4)		# _4, MEM[(int *)_121]
	addi	a4,a4,4	#, D.2698, D.2697
	sw	a4,12(sp)	# D.2698, ap
# stdlib.c:49:     print_chr(c);
	andi	a6,a2,0xff	# _33, _4
.L181:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _34, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L181	#, _34,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	andi	a2,a2,255	#, _36, _4
	sw	a2,0(a5)	# _36, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	bne	a6,t0,.L182	#, _33, tmp216,
.L231:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214,
	j	.L182		#
.L233:
# stdlib.c:104: 					printf_s(va_arg(ap,char*));
	lw	a4,12(sp)		# D.2699, ap
	lw	a6,0(a4)		# p, MEM[(char * *)_87]
	addi	a4,a4,4	#, D.2700, D.2699
	sw	a4,12(sp)	# D.2700, ap
.L230:
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _40,* p
	beq	a2,zero,.L182	#, _40,,
.L187:
# stdlib.c:56:     print_chr(*(p++));
	addi	a6,a6,1	#, p, p
.L184:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _39, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L184	#, _39,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a2,0(a5)	# _40, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	bne	a2,t0,.L230	#, _40, tmp216,
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:54: 	while (*p)
	lbu	a2,0(a6)	# _40,* p
	bne	a2,zero,.L187	#, _40,,
	j	.L182		#
.L234:
# stdlib.c:108: 					printf_d(va_arg(ap,int));
	lw	a2,12(sp)		# D.2701, ap
	lw	a4,0(a2)		# val, MEM[(int *)_122]
	addi	a2,a2,4	#, D.2702, D.2701
	sw	a2,12(sp)	# D.2702, ap
# stdlib.c:63: 	if (val < 0) {
	blt	a4,zero,.L190	#, val,,
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp213
.L191:
# stdlib.c:67: 	while (val || p == buffer) {
	bne	a4,zero,.L192	#, val,,
	bne	a2,t6,.L195	#, p, tmp213,
.L192:
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
	j	.L191		#
.L190:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a2,0(a5)		# _53, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a2,zero,.L190	#, _53,,
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	s0,0(a5)	# tmp218, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:65: 		val = -val;
	neg	a4,a4	# val, val
# stdlib.c:96: 	for (i = 0; format[i]; i++)
	mv	a2,t6	# p, tmp213
	j	.L191		#
.L237:
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a6,0(a5)	# _64, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a6,t0,.L236	#, _64, tmp216,
# stdlib.c:71: 	while (p != buffer)
	beq	a2,t6,.L182	#, p, tmp213,
.L195:
# stdlib.c:72: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _64, MEM[(char *)p_63]
# stdlib.c:72: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L193:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _65, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L193	#, _65,,
	j	.L237		#
.L236:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:71: 	while (p != buffer)
	bne	a2,t6,.L195	#, p, tmp213,
	j	.L182		#
.L235:
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	lw	a6,12(sp)		# D.2703, ap
# stdlib.c:78: 	char *p = buffer;
	mv	a2,t6	# p, tmp213
# stdlib.c:80:   val = val >= 0 ? val : -val;
	lw	a4,0(a6)		# MEM[(int *)_125], MEM[(int *)_125]
# stdlib.c:112: 					printf_u(va_arg(ap,int));
	addi	a6,a6,4	#, D.2704, D.2703
	sw	a6,12(sp)	# D.2704, ap
# stdlib.c:80:   val = val >= 0 ? val : -val;
	srai	a6,a4,31	#, tmp163, MEM[(int *)_125]
	xor	a4,a6,a4	# MEM[(int *)_125], val, tmp163
	sub	a4,a4,a6	# val, val, tmp163
.L196:
# stdlib.c:81: 	while (val || p == buffer) {
	bne	a4,zero,.L197	#, val,,
	bne	a2,t6,.L200	#, p, tmp213,
.L197:
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
	j	.L196		#
.L239:
# kianv_stdlib.h:194:   *((volatile uint32_t*) UART_TX) = c;
	sw	a6,0(a5)	# _80, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:195:    if (c == 13) {
	beq	a6,t0,.L238	#, _80, tmp216,
# stdlib.c:85: 	while (p != buffer)
	beq	a2,t6,.L182	#, p, tmp213,
.L200:
# stdlib.c:86: 		printf_c(*(--p));
	lbu	a6,-1(a2)	# _80, MEM[(char *)p_79]
# stdlib.c:86: 		printf_c(*(--p));
	addi	a2,a2,-1	#, p, p
.L198:
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	lw	a4,0(a5)		# _81, MEM[(volatile uint32_t *)805306368B]
# kianv_stdlib.h:192:   while (!*((volatile uint32_t*) UART_READY))
	beq	a4,zero,.L198	#, _81,,
	j	.L239		#
.L238:
# kianv_stdlib.h:196:     *((volatile uint32_t*) UART_TX) = 10;
	sw	a1,0(a5)	# tmp214, MEM[(volatile uint32_t *)805306368B]
# stdlib.c:85: 	while (p != buffer)
	bne	a2,t6,.L200	#, p, tmp213,
	j	.L182		#
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
	ble	a5,a3,.L240	#, _3, tmp81,
# stdlib.c:130: 		asm volatile ("ebreak");
 #APP
# 130 "stdlib.c" 1
	ebreak
# 0 "" 2
 #NO_APP
.L240:
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
	beq	a2,zero,.L243	#, n,,
	addi	a4,a1,1	#, bb, bb
	sub	a5,a0,a4	# tmp111, aa, bb
	sltiu	a5,a5,3	#, tmp114, tmp111
	sltiu	a3,a7,7	#, tmp117, n
	xori	a5,a5,1	#, tmp113, tmp114
	xori	a3,a3,1	#, tmp116, tmp117
	and	a5,a5,a3	# tmp116, tmp120, tmp113
	beq	a5,zero,.L244	#, tmp120,,
	or	a5,a0,a1	# bb, tmp121, aa
	andi	a5,a5,3	#, tmp122, tmp121
	bne	a5,zero,.L244	#, tmp122,,
	andi	a6,a2,-4	#, tmp127, n
	mv	a5,a1	# ivtmp.334, bb
	mv	a4,a0	# ivtmp.337, aa
	add	a6,a6,a1	# bb, _77, tmp127
.L245:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lw	a3,0(a5)		# vect__1.320, MEM <const vector(4) char> [(const char *)_43]
	addi	a5,a5,4	#, ivtmp.334, ivtmp.334
	addi	a4,a4,4	#, ivtmp.337, ivtmp.337
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sw	a3,-4(a4)	# vect__1.320, MEM <vector(4) char> [(char *)_45]
	bne	a5,a6,.L245	#, ivtmp.334, _77,
	andi	a5,a2,-4	#, niters_vector_mult_vf.314, n
	add	a4,a0,a5	# niters_vector_mult_vf.314, tmp.315, aa
	add	a1,a1,a5	# niters_vector_mult_vf.314, tmp.316, bb
	sub	a7,a7,a5	# tmp.317, n, niters_vector_mult_vf.314
	beq	a2,a5,.L243	#, n, niters_vector_mult_vf.314,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,0(a1)	# _10, *tmp.316_55
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,0(a4)	# _10, *tmp.315_54
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,zero,.L243	#, tmp.317,,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,1(a1)	# _72, MEM[(const char *)tmp.316_55 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	li	a5,1		# tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,1(a4)	# _72, MEM[(char *)tmp.315_54 + 1B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	beq	a7,a5,.L243	#, tmp.317, tmp128,
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a5,2(a1)	# _48, MEM[(const char *)tmp.316_55 + 2B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a5,2(a4)	# _48, MEM[(char *)tmp.315_54 + 2B]
	ret	
.L244:
	add	a2,a0,a2	# n, _23, aa
# stdlib.c:138: 	char *a = (char *) aa;
	mv	a5,a0	# a, aa
.L247:
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	lbu	a3,-1(a4)	# _37, MEM[(const char *)b_35 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	addi	a5,a5,1	#, a, a
	addi	a4,a4,1	#, bb, bb
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	sb	a3,-1(a5)	# _37, MEM[(char *)a_36 + 4294967295B]
# stdlib.c:140: 	while (n--) *(a++) = *(b++);
	bne	a2,a5,.L247	#, _23, a,
.L243:
# stdlib.c:142: }
	ret	
	.size	memcpy, .-memcpy
	.align	2
	.globl	strcpy
	.type	strcpy, @function
strcpy:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	mv	a5,a0	# dst, dst
	j	.L264		#
.L266:
# stdlib.c:150: 		char c = *(src++);
	lbu	a4,0(a1)	# c, MEM[(const char *)src_40 + 4294967295B]
# stdlib.c:151: 		*(dst++) = c;
	addi	a5,a5,1	#, dst, dst
# stdlib.c:150: 		char c = *(src++);
	addi	a1,a1,1	#, src, src
# stdlib.c:151: 		*(dst++) = c;
	sb	a4,-1(a5)	# c, MEM[(char *)dst_42 + 4294967295B]
# stdlib.c:152: 		if (!c) return r;
	beq	a4,zero,.L268	#, c,,
.L264:
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	or	a4,a5,a1	# src, tmp101, dst
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	andi	a4,a4,3	#, tmp102, tmp101
# stdlib.c:148: 	while ((((uint32_t)dst | (uint32_t)src) & 3) != 0)
	bne	a4,zero,.L266	#, tmp102,,
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
	bne	a4,zero,.L269	#, tmp108,,
.L267:
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
	beq	a4,zero,.L267	#, tmp120,,
.L269:
# stdlib.c:161: 			dst[0] = v & 0xff;
	sb	a3,0(a5)	# v, *dst_50
# stdlib.c:162: 			if ((v & 0xff) == 0)
	andi	a4,a3,255	#, tmp111, v
# stdlib.c:162: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L268	#, tmp111,,
# stdlib.c:164: 			v = v >> 8;
	srli	a4,a3,8	#, v, v
# stdlib.c:166: 			dst[1] = v & 0xff;
	sb	a4,1(a5)	# v, MEM[(char *)dst_50 + 1B]
# stdlib.c:167: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp112, v
# stdlib.c:167: 			if ((v & 0xff) == 0)
	beq	a4,zero,.L268	#, tmp112,,
# stdlib.c:169: 			v = v >> 8;
	srli	a4,a3,16	#, v, v
# stdlib.c:171: 			dst[2] = v & 0xff;
	sb	a4,2(a5)	# v, MEM[(char *)dst_50 + 2B]
# stdlib.c:172: 			if ((v & 0xff) == 0)
	andi	a4,a4,255	#, tmp113, v
# stdlib.c:172: 			if ((v & 0xff) == 0)
	bne	a4,zero,.L284	#, tmp113,,
.L268:
# stdlib.c:184: }
	ret	
.L284:
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
	j	.L286		#
.L290:
# stdlib.c:190: 		char c1 = *(s1++);
	lbu	a5,0(a0)	# c1, MEM[(const char *)s1_48 + 4294967295B]
# stdlib.c:191: 		char c2 = *(s2++);
	lbu	a4,0(a1)	# c2, MEM[(const char *)s2_50 + 4294967295B]
# stdlib.c:190: 		char c1 = *(s1++);
	addi	a0,a0,1	#, s1, s1
# stdlib.c:191: 		char c2 = *(s2++);
	addi	a1,a1,1	#, s2, s2
# stdlib.c:193: 		if (c1 != c2)
	bne	a5,a4,.L315	#, c1, c2,
# stdlib.c:195: 		else if (!c1)
	beq	a5,zero,.L305	#, c1,,
.L286:
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	or	a5,a0,a1	# s2, tmp101, s1
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	andi	a5,a5,3	#, tmp102, tmp101
# stdlib.c:188: 	while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0)
	bne	a5,zero,.L290	#, tmp102,,
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_14]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_16]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L295	#, v1, v2,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a2,-16842752		# tmp111,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	li	a3,-2139062272		# tmp116,
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a2,a2,-257	#, tmp110, tmp111
# stdlib.c:228: 		if (__builtin_expect((((v1) - 0x01010101UL) & ~(v1) & 0x80808080UL), 0))
	addi	a3,a3,128	#, tmp115, tmp116
	j	.L291		#
.L316:
# stdlib.c:201: 		uint32_t v1 = *(uint32_t*)s1;
	lw	a5,0(a0)		# v1, MEM[(uint32_t *)s1_29]
# stdlib.c:202: 		uint32_t v2 = *(uint32_t*)s2;
	lw	a4,0(a1)		# v2, MEM[(uint32_t *)s2_30]
# stdlib.c:204: 		if (__builtin_expect(v1 != v2, 0))
	bne	a5,a4,.L295	#, v1, v2,
.L291:
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
	beq	a5,zero,.L316	#, tmp114,,
.L305:
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
.L285:
# stdlib.c:234: }
	ret	
.L315:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	sltu	a0,a5,a4	# c2, tmp119, c1
	neg	a0,a0	# tmp120, tmp119
	ori	a0,a0,1	#, <retval>, tmp120
	ret	
.L295:
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a5,0xff	# c1, v1
# stdlib.c:208: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a4,0xff	# c2, v2
# stdlib.c:209: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L313	#, c1, c2,
# stdlib.c:196: 			return 0;
	li	a0,0		# <retval>,
# stdlib.c:210: 			if (!c1) return 0;
	beq	a3,zero,.L285	#, c1,,
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,8	#, v1, v1
# stdlib.c:211: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,8	#, v2, v2
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:213: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:214: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L313	#, c1, c2,
# stdlib.c:215: 			if (!c1) return 0;
	beq	a3,zero,.L285	#, c1,,
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a3,a5,16	#, v1, v1
# stdlib.c:216: 			v1 = v1 >> 8, v2 = v2 >> 8;
	srli	a2,a4,16	#, v2, v2
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a3,a3,0xff	# c1, v1
# stdlib.c:218: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	andi	a2,a2,0xff	# c2, v2
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bne	a3,a2,.L313	#, c1, c2,
# stdlib.c:220: 			if (!c1) return 0;
	beq	a3,zero,.L285	#, c1,,
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a5,a5,24	#, c1, v1
# stdlib.c:223: 			c1 = v1 & 0xff, c2 = v2 & 0xff;
	srli	a4,a4,24	#, c2, v2
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	beq	a5,a4,.L285	#, c1, c2,
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:224: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a5,a4,.L285	#, c1, c2,
	j	.L311		#
.L313:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,1		# <retval>,
# stdlib.c:219: 			if (c1 != c2) return c1 < c2 ? -1 : +1;
	bgeu	a3,a2,.L285	#, c1, c2,
.L311:
# stdlib.c:194: 			return c1 < c2 ? -1 : +1;
	li	a0,-1		# <retval>,
	ret	
	.size	strcmp, .-strcmp
	.align	2
	.globl	sin1
	.type	sin1, @function
sin1:
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a0,zero,.L318	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp96,
	add	a0,a0,a5	# tmp96, tmp98, angle
	slli	a0,a0,16	#, angle, tmp98
	srai	a0,a0,16	#, angle, angle
.L318:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a0,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_4, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp102, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_4, v0.41_4
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L319	#, tmp102,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp104, v0
	slli	a5,a5,16	#, v0, tmp104
	srai	a5,a5,16	#, v0, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a0,a0	# angle, angle
.L319:
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
	beq	a3,zero,.L320	#, tmp129,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp131, _5
	slli	a0,a0,16	#, _5, tmp131
	srli	a0,a0,16	#, _5, _5
.L320:
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
	bge	a0,zero,.L328	#, angle,,
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp98,
	xor	a2,a2,a5	# tmp98, prephitmp_78, prephitmp_78
.L328:
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
	bge	a3,zero,.L329	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp104,
	addi	a5,a5,1	#, tmp103, tmp104
	add	a2,a2,a5	# tmp103, tmp102, prephitmp_78
	slli	a4,a2,16	#, _4, tmp102
	slli	a3,a2,16	#, angle, tmp102
	srli	a4,a4,16	#, _4, _4
	srai	a3,a3,16	#, angle, angle
.L329:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_16, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp108, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_16, v0.41_16
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L330	#, tmp108,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp112, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _4, tmp112
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _4, _4
.L330:
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
	beq	a4,zero,.L331	#, tmp134,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp136, _37
	slli	a0,a0,16	#, _37, tmp136
	srli	a0,a0,16	#, _37, _37
.L331:
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
	addi	a5,a5,%lo(.LANCHOR2)	# ivtmp.396, tmp78,
	addi	a2,a5,37	#, _15, ivtmp.396
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	li	a3,805306368		# tmp80,
.L342:
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	lbu	a4,0(a5)	# _7, MEM[(char *)_13]
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	addi	a5,a5,1	#, ivtmp.396, ivtmp.396
# gfx_lib_hdmi.h:114:   *((volatile uint32_t *) VIDEO_RAW) = ((data_cmd & 0x01) << 8) | tx;
	sw	a4,12(a3)	# _7, MEM[(volatile uint32_t *)805306380B]
# gfx_lib_hdmi.h:192:   for (int i = 0; i < sizeof(oled_8bit_init_seq)/
	bne	a5,a2,.L342	#, ivtmp.396, _15,
# gfx_lib_hdmi.h:198: }
	ret	
	.size	init_oled8bit_colors, .-init_oled8bit_colors
	.align	2
	.globl	fb_setpixel
	.type	fb_setpixel, @function
fb_setpixel:
# gfx_lib_hdmi.h:202:   if  ( x > (HRES-1) ) return;
	li	a5,79		# tmp84,
	bgtu	a1,a5,.L344	#, x, tmp84,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	li	a5,59		# tmp85,
	bgtu	a2,a5,.L344	#, y, tmp85,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a2,2	#, tmp87, y
	add	a5,a5,a2	# y, tmp88, tmp87
	slli	a5,a5,4	#, tmp89, tmp88
	add	a5,a5,a1	# x, tmp90, tmp89
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	slli	a5,a5,2	#, tmp91, tmp90
	add	a0,a0,a5	# tmp91, tmp92, fb
	sw	a3,0(a0)	# color, *_12
.L344:
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
.L349:
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
	bgtu	s1,a3,.L350	#, x0, tmp97,
# gfx_lib_hdmi.h:203:   if  ( y > (VRES-1) ) return;
	bgtu	s0,t1,.L350	#, y0, tmp115,
# gfx_lib_hdmi.h:206:   fb[x + y*HRES] = color;
	sw	s7,0(a6)	# color, *_38
.L350:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	beq	s1,s3,.L358	#, x0, x1,
.L351:
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	bgt	a7,a1,.L353	#, dy, e2,
	sub	a2,a2,a0	# err, err, _3
# gfx_lib_hdmi.h:221:     if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
	add	s1,s1,s5	# iftmp.50_9, x0, x0
.L353:
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	blt	s2,a1,.L349	#, dx, e2,
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	a2,a2,s2	# dx, err, err
# gfx_lib_hdmi.h:222:     if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
	add	s0,s0,t3	# iftmp.51_10, y0, y0
	j	.L349		#
.L358:
# gfx_lib_hdmi.h:218:     if (x0 == x1 && y0 == y1) break;
	bne	s0,s6,.L351	#, y0, y1,
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
	lw	a4,4(a1)		# vect__1.412, MEM[(int *)p_4(D) + 4B]
# gfx_lib_hdmi.h:237:   return transformed;
	lw	a3,0(a1)		# MEM[(int *)p_4(D)], MEM[(int *)p_4(D)]
	sw	zero,8(a0)	#, <retval>.z
	sw	a4,4(a0)	# vect__1.412, MEM[(int *)&<retval> + 4B]
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
	lw	s2,4(a1)		# vect__1.424, MEM[(int *)p_8(D) + 4B]
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
	sw	s2,4(s0)	# vect__1.424, MEM[(int *)&<retval> + 4B]
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
	bge	a4,zero,.L369	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L369:
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
	beq	a1,zero,.L370	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L370:
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
	beq	a5,zero,.L371	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L371:
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
	bge	a3,zero,.L372	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L372:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L373	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L373:
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
	beq	a3,zero,.L374	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L374:
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
	bge	a4,zero,.L388	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L388:
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
	beq	a1,zero,.L389	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L389:
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
	beq	a5,zero,.L390	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L390:
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
	bge	a3,zero,.L391	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L391:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L392	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L392:
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
	beq	a3,zero,.L393	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L393:
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
	bge	a4,zero,.L407	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp163,
	xor	s8,s8,a5	# tmp163, prephitmp_203, prephitmp_203
	slli	a4,s8,16	#, angle, prephitmp_203
	srai	a4,a4,16	#, angle, angle
.L407:
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
	beq	a1,zero,.L408	#, tmp167,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp171, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _235, tmp171
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _235, _235
.L408:
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
	beq	a5,zero,.L409	#, tmp193,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp195, _74
	slli	a0,a0,16	#, _74, tmp195
	srli	a0,a0,16	#, _74, _74
.L409:
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
	bge	a3,zero,.L410	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,8192		# tmp206,
	addi	a5,a5,1	#, tmp205, tmp206
	add	s8,s8,a5	# tmp205, tmp204, prephitmp_203
	slli	a4,s8,16	#, _42, tmp204
	slli	a3,s8,16	#, angle, tmp204
	srli	a4,a4,16	#, _42, _42
	srai	a3,a3,16	#, angle, angle
.L410:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_84, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a1,a5,32	#, tmp210, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_84, v0.41_84
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a1,zero,.L411	#, tmp210,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a3,a3	# tmp214, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a3,16	#, _42, tmp214
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a4,a4,16	#, _42, _42
.L411:
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
	beq	a3,zero,.L412	#, tmp236,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp238, _105
	slli	a5,a5,16	#, _105, tmp238
	srli	a5,a5,16	#, _105, _105
.L412:
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
	addi	sp,sp,-144	#,,
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	a1,a1,-1	#, _82, tmp863
# main_cube3d_rotate_hdmi.c:71: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
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
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	sw	a1,40(sp)	# _82, %sfp
# main_cube3d_rotate_hdmi.c:71: void render_lines(point points [], size_t s, float angle_x, float angle_y, float angle_z, float scalef) {
	sw	a0,16(sp)	# tmp862, %sfp
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	beq	a1,zero,.L425	#, _82,,
	mv	s1,a5	# scalef, tmp867
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC4)	# tmp418,
	lw	a1,%lo(.LC4)(a5)		#,
	mv	a0,s1	#, scalef
	mv	s4,a2	# angle_x, tmp864
	mv	s0,a3	# angle_y, tmp865
	mv	s3,a4	# angle_z, tmp866
	call	__mulsf3		#
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC5)	# tmp956,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	s2,a0	# tmp868,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC5)(a5)		#,
	mv	a1,s2	#, tmp419
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	li	s5,-2147483648		# tmp427,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__subsf3		#
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a4,%hi(.LC6)	# tmp422,
	lw	a1,%lo(.LC6)(a4)		#,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a5,a0	# tmp869,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a0,s1	#, scalef
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	a5,12(sp)	# tmp869, %sfp
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__mulsf3		#
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lui	a5,%hi(.LC7)	# tmp957,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	mv	a1,a0	# tmp870,
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	lw	a0,%lo(.LC7)(a5)		#,
	call	__subsf3		#
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	call	__fixsfsi		#
	mv	s8,a0	# tmp871,
	xor	a0,s5,s2	# tmp419,, tmp427
	sw	s8,44(sp)	# tmp871, %sfp
	call	__fixsfsi		#
	mv	s9,a0	# tmp872,
# main_cube3d_rotate_hdmi.c:85:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	xor	a0,s5,s4	# angle_x,, tmp427
# main_cube3d_rotate_hdmi.c:80:     p0 = translate(&p0, HRES/2 -5*scalef, VRES/2 -15*scalef, -5*scalef);
	sw	s9,48(sp)	# tmp872, %sfp
# main_cube3d_rotate_hdmi.c:85:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
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
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp438,
	add	a5,a0,a5	# tmp438, _296, _296
	blt	a0,zero,.L428	#, _296,,
	mv	a5,a0	# _296, _296
.L428:
	slli	s6,a5,16	#, angle, _296
	srai	s6,s6,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s6,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp447, _296
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_331, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp447
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_331, v0.41_331
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	andi	s7,a4,32	#, _332, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,20(sp)	# v0.41_331, %sfp
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,24(sp)	# v1, %sfp
	not	s2,a4	# v0, v0
	beq	s7,zero,.L483	#, _332,,
.L430:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,s6,16	#, angle.46_305, angle
	li	a4,-24576		# tmp452,
	srli	a5,a5,16	#, angle.46_305, angle.46_305
	addi	a4,a4,1	#, tmp451, tmp452
	add	a4,a5,a4	# tmp451, tmp450, angle.46_305
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _307, tmp450
	li	a3,8192		# tmp455,
	addi	a3,a3,1	#, tmp454, tmp455
	srai	a4,a4,16	#, _307, _307
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s2,s2,31	#, _337, v0
	add	a5,a5,a3	# tmp454, _307, angle.46_305
	blt	a4,zero,.L432	#, _307,,
	mv	a5,a4	# _307, _307
.L432:
	slli	s11,a5,16	#, angle, _307
	srai	s11,s11,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s11,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp462, _307
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_362, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp462
	srai	a5,a5,16	#, v1, v1
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_362, v0.41_362
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,32(sp)	# v1, %sfp
	andi	s10,a4,32	#, _363, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,28(sp)	# v0.41_362, %sfp
	not	a5,a4	# v0, v0
	beq	s10,zero,.L484	#, _363,,
.L434:
# main_cube3d_rotate_hdmi.c:87:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	li	a0,-2147483648		# tmp466,
# main_cube3d_rotate_hdmi.c:87:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	xor	a0,a0,s0	# angle_y,, tmp466
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s0,a5,31	#, _368, v0
# main_cube3d_rotate_hdmi.c:87:     p0 = rotateY_pivot(&p0, &pivot, -angle_y);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
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
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp475,
	add	a5,a0,a5	# tmp475, _216, _216
	blt	a0,zero,.L436	#, _216,,
	mv	a5,a0	# _216, _216
.L436:
	slli	a6,a5,16	#, angle, _216
	srai	a6,a6,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,a6,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp484, _216
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_455, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp484
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_455, v0.41_455
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	andi	t1,a4,32	#, _456, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,36(sp)	# v0.41_455, %sfp
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,52(sp)	# v1, %sfp
	not	t3,a4	# v0, v0
	beq	t1,zero,.L485	#, _456,,
.L438:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,a6,16	#, angle.46_225, angle
	li	a4,-24576		# tmp489,
	srli	a5,a5,16	#, angle.46_225, angle.46_225
	addi	a4,a4,1	#, tmp488, tmp489
	add	a4,a5,a4	# tmp488, tmp487, angle.46_225
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _227, tmp487
	li	a3,8192		# tmp492,
	addi	a3,a3,1	#, tmp491, tmp492
	srai	a4,a4,16	#, _227, _227
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	t3,t3,31	#, _461, v0
	add	a5,a5,a3	# tmp491, _227, angle.46_225
	blt	a4,zero,.L440	#, _227,,
	mv	a5,a4	# _227, _227
.L440:
	slli	s8,a5,16	#, angle, _227
	srai	s8,s8,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s8,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp499, _227
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_486, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp499
	srai	a5,a5,16	#, v1, v1
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_486, v0.41_486
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a5,60(sp)	# v1, %sfp
	andi	a7,a4,32	#, _487, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,56(sp)	# v0.41_486, %sfp
	not	a5,a4	# v0, v0
	beq	a7,zero,.L486	#, _487,,
.L442:
# main_cube3d_rotate_hdmi.c:89:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s3	#, angle_z
	sw	a7,76(sp)	# _487, %sfp
	sw	t3,72(sp)	# _461, %sfp
	sw	t1,68(sp)	# _456, %sfp
	sw	a6,64(sp)	# angle, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s3,a5,31	#, _492, v0
# main_cube3d_rotate_hdmi.c:89:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
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
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,-32768		# tmp510,
	lw	a6,64(sp)		# angle, %sfp
	lw	t1,68(sp)		# _456, %sfp
	lw	t3,72(sp)		# _461, %sfp
	lw	a7,76(sp)		# _487, %sfp
	add	a5,a0,a5	# tmp510, _136, _136
	blt	a0,zero,.L444	#, _136,,
	mv	a5,a0	# _136, _136
.L444:
	slli	a0,a5,16	#, angle, _136
	srai	a0,a0,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,a0,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a4,16	#, v0.41_579, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp519, _136
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_579, v0.41_579
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s4,a5,16	#, v1, tmp519
	andi	t5,a4,32	#, _580, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	sw	a3,64(sp)	# v0.41_579, %sfp
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s4,s4,16	#, v1, v1
	not	a1,a4	# v0, v0
	beq	t5,zero,.L487	#, _580,,
.L446:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a5,a0,16	#, angle.46_145, angle
	li	a4,-24576		# tmp524,
	srli	a5,a5,16	#, angle.46_145, angle.46_145
	addi	a4,a4,1	#, tmp523, tmp524
	add	a4,a5,a4	# tmp523, tmp522, angle.46_145
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,a4,16	#, _147, tmp522
	li	a3,8192		# tmp527,
	addi	a3,a3,1	#, tmp526, tmp527
	srai	a4,a4,16	#, _147, _147
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a1,a1,31	#, _585, v0
	add	a5,a5,a3	# tmp526, _147, angle.46_145
	blt	a4,zero,.L448	#, _147,,
	mv	a5,a4	# _147, _147
.L448:
	slli	t6,a5,16	#, angle, _147
	srai	t6,t6,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,t6,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp534, _147
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s9,a4,16	#, v0.41_610, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v1, tmp534
	andi	t4,a4,32	#, _611, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s9,s9,16	#, v0.41_610, v0.41_610
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v1, v1
	not	a2,a4	# v0, v0
	beq	t4,zero,.L488	#, _611,,
.L450:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,s2,1	#, tmp543, _337
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lui	a4,%hi(.LANCHOR1)	# tmp817,
	addi	a4,a4,%lo(.LANCHOR1)	# tmp811, tmp817,
	slli	s2,s2,1	#, tmp539, _337
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a3,1	#, tmp544, tmp543
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,a4,s2	# tmp539, tmp540, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a4,a3	# tmp544, tmp545, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t2,0(s2)		# pretmp_412, sin90[_337]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a3,0(a3)		# sin90[_340], sin90[_340]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t0,24(sp)	#, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a2,a2,31	#, _616, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a3,a3,t2	# tmp547, sin90[_340], pretmp_412
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s7,zero,.L489	#, _332,,
.L452:
	andi	t0,t0,0xff	# tmp550, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a3,a3,t0	# tmp551, tmp547, tmp550
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	t0,s0,1	#, tmp562, _368
	slli	t0,t0,1	#, tmp563, tmp562
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s0,s0,1	#, tmp558, _368
	add	s0,a4,s0	# tmp558, tmp559, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t0,a4,t0	# tmp563, tmp564, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s0,0(s0)		# pretmp_178, sin90[_368]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t0,0(t0)		# sin90[_371], sin90[_371]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	s2,32(sp)	#, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a3,a3,8	#, tmp552, tmp551
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,t2	# pretmp_412, tmp555, tmp552
	slli	a3,a3,16	#, _542, tmp555
	srli	a3,a3,16	#, _542, _542
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	t0,t0,s0	# tmp566, sin90[_371], pretmp_178
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	s10,zero,.L490	#, _363,,
.L454:
	andi	s2,s2,0xff	# tmp569, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s2,t0,s2	# tmp570, tmp566, tmp569
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	t2,t3,1	#, tmp581, _461
	slli	t2,t2,1	#, tmp582, tmp581
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	t3,t3,1	#, tmp577, _461
	add	t3,a4,t3	# tmp577, tmp578, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t2,a4,t2	# tmp582, tmp583, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t0,0(t3)		# pretmp_562, sin90[_461]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t3,0(t2)		# sin90[_464], sin90[_464]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t2,52(sp)	#, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s2,s2,8	#, tmp571, tmp570
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,s2,s0	# pretmp_178, tmp574, tmp571
	slli	s5,s2,16	#, _552, tmp574
	srli	s5,s5,16	#, _552, _552
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	t3,t3,t0	# tmp585, sin90[_464], pretmp_562
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t1,zero,.L491	#, _456,,
.L456:
	andi	t2,t2,0xff	# tmp588, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	t2,t3,t2	# tmp589, tmp585, tmp588
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a6,s3,1	#, tmp600, _492
	slli	a6,a6,1	#, tmp601, tmp600
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s3,s3,1	#, tmp596, _492
	add	s3,a4,s3	# tmp596, tmp597, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a6,a4,a6	# tmp601, tmp602, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t1,0(s3)		# pretmp_565, sin90[_492]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a6,0(a6)		# sin90[_495], sin90[_495]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lhu	t3,60(sp)	#, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	t2,t2,8	#, tmp590, tmp589
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	t2,t2,t0	# pretmp_562, tmp593, tmp590
	slli	s10,t2,16	#, _564, tmp593
	srli	s10,s10,16	#, _564, _564
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a6,a6,t1	# tmp604, sin90[_495], pretmp_565
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	a7,zero,.L492	#, _487,,
.L458:
	andi	t3,t3,0xff	# tmp607, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a6,a6,t3	# tmp608, tmp604, tmp607
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a7,a1,1	#, tmp619, _585
	slli	a7,a7,1	#, tmp620, tmp619
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a1,a1,1	#, tmp615, _585
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a7,a4,a7	# tmp620, tmp621, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a1,a4,a1	# tmp615, tmp616, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s3,0(a7)		# sin90[_588], sin90[_588]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a1)		# pretmp_200, sin90[_585]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	a7,s4	# v1, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s7,a6,8	#, tmp609, tmp608
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,t1	# pretmp_565, tmp612, tmp609
	slli	s7,s7,16	#, _192, tmp612
	srli	s7,s7,16	#, _192, _192
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s3,s3,a1	# tmp623, sin90[_588], pretmp_200
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t5,zero,.L493	#, _580,,
.L460:
	andi	a7,a7,0xff	# tmp626, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s3,s3,a7	# tmp627, tmp623, tmp626
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a0,a2,1	#, tmp638, _616
	slli	a0,a0,1	#, tmp639, tmp638
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp634, _616
	add	a2,a4,a2	# tmp634, tmp635, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a4,a0	# tmp639, tmp640, tmp811
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a2)		# pretmp_90, sin90[_616]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s2,0(a4)		# sin90[_619], sin90[_619]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s3,s3,8	#, tmp628, tmp627
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s3,s3,a1	# pretmp_200, tmp631, tmp628
	slli	s3,s3,16	#, _89, tmp631
	srli	s3,s3,16	#, _89, _89
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s2,s2,a2	# tmp642, sin90[_619], pretmp_90
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	beq	t4,zero,.L494	#, _611,,
.L462:
	andi	a5,a5,0xff	# tmp645, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s2,s2,a5	# tmp646, tmp642, tmp645
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	lw	a5,20(sp)		# v0.41_331, %sfp
	lw	s0,16(sp)		# ivtmp.455, %sfp
	mv	a0,a3	# v1, _542
	andi	a5,a5,64	#, tmp654, v0.41_331
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s2,s2,8	#, tmp647, tmp646
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s2,s2,a2	# pretmp_90, tmp650, tmp647
	slli	s2,s2,16	#, _655, tmp650
	srli	s2,s2,16	#, _655, _655
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	bne	a5,zero,.L495	#, tmp654,,
.L464:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s6,%hi(.LC3)	# tmp814,
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	lw	a5,28(sp)		# v0.41_362, %sfp
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	s4,a0	# sin_theta, tmp876
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	mv	a0,s5	# v1, _552
	andi	a5,a5,64	#, tmp665, v0.41_362
	bne	a5,zero,.L496	#, tmp665,,
.L466:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	lw	a5,36(sp)		# v0.41_455, %sfp
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	mv	s5,a0	# cos_theta, tmp877
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	mv	a0,s10	# v1, _564
	andi	a5,a5,64	#, tmp676, v0.41_455
	bne	a5,zero,.L497	#, tmp676,,
.L468:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	lw	a5,56(sp)		# v0.41_486, %sfp
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	sw	a0,16(sp)	# tmp878, %sfp
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	neg	a0,s7	# v1, _192
	andi	a5,a5,64	#, tmp687, v0.41_486
	beq	a5,zero,.L498	#, tmp687,,
.L470:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	lw	a5,64(sp)		# v0.41_579, %sfp
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	sw	a0,20(sp)	# tmp879, %sfp
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	neg	a0,s3	# v1, _89
	andi	a5,a5,64	#, tmp698, v0.41_579
	beq	a5,zero,.L499	#, tmp698,,
.L472:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	andi	a5,s9,64	#, tmp709, v0.41_610
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	s3,a0	# sin_theta, tmp880
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	a0,s2	# v1, _655
	bne	a5,zero,.L500	#, tmp709,,
.L474:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s6)		#,
	lw	a3,%lo(.LC3+4)(s6)		#,
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	li	a5,0		# i,
	sw	a5,24(sp)	# i, %sfp
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp972,
	lw	s7,%lo(.LC5)(a5)		# tmp854,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp973,
	lw	s6,%lo(.LC7)(a5)		# tmp855,
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	s2,a0	# cos_theta, tmp881
	li	a5,0		# i,
.L475:
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s0)		#, MEM[(int *)_736 + 4B]
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	a5,a5,2	#, i, i
	sw	a5,36(sp)	# i, %sfp
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	s8,44(sp)		# _11, %sfp
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s0,s0,24	#, ivtmp.455, ivtmp.455
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _11, tmp720, tmp882
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-30	#,, tmp720
	call	__floatsisf		#
	mv	s10,a0	# tmp883,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s0)		#, MEM[(int *)_736 + 8B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	s11,48(sp)		# _12, %sfp
	add	a0,a0,s11	# _12,, tmp884
	call	__floatsisf		#
	mv	s9,a0	# tmp885,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s0)		#, MEM[(int *)_736 + 16B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	add	a0,a0,s8	# _11, tmp729, tmp886
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-30	#,, tmp729
	call	__floatsisf		#
	mv	s8,a0	# tmp887,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s0)		#, MEM[(int *)_736 + 20B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	add	a0,a0,s11	# _12,, tmp888
	call	__floatsisf		#
	mv	s11,a0	# tmp889,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s0)		#, MEM[(int *)_736]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _8, %sfp
	add	a0,a0,a5	# _8, tmp738, tmp890
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-40	#,, tmp738
	call	__floatsisf		#
	lw	a1,20(sp)		#, %sfp
	call	__mulsf3		#
	mv	a6,a0	# tmp891,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _313
	mv	a0,s4	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a6,28(sp)	# tmp741, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, _315
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,24(sp)	# tmp742, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	t1,24(sp)		# tmp742, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp893,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,t1	#, tmp742
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,16(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a6,28(sp)		# tmp741, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp894,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a6	#, tmp741
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp895
	call	__floatsisf		#
	mv	a4,a0	# tmp896,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _313
	mv	a0,s5	#, cos_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s10,a4	# _153, tmp896
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _315
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,24(sp)	# tmp754, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,24(sp)		# tmp754, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp898,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp754
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp899
	call	__floatsisf		#
	mv	s9,a0	# tmp900,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s0)		#, MEM[(int *)_736 + 12B]
	call	__floatsisf		#
	mv	a1,s1	#, scalef
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	lw	a5,12(sp)		# _8, %sfp
	add	a0,a0,a5	# _8, tmp764, tmp901
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-40	#,, tmp764
	call	__floatsisf		#
	lw	a1,20(sp)		#, %sfp
	call	__mulsf3		#
	mv	a7,a0	# tmp902,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s4	#, sin_theta
	mv	a0,s8	#, _273
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a7,28(sp)	# tmp767, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp768, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s11	#, _275
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	t1,24(sp)		# tmp768, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp904,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,t1	#, tmp768
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	lw	a1,16(sp)		#, %sfp
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a7,28(sp)		# tmp767, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp905,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a7	#, tmp767
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp906
	call	__floatsisf		#
	mv	a4,a0	# tmp907,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, cos_theta
	mv	a0,s8	#, _273
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s8,a4	# _113, tmp907
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp780, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, sin_theta
	mv	a0,s11	#, _275
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a4,24(sp)		# tmp780, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp909,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp780
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp910
	call	__floatsisf		#
	mv	s11,a0	# tmp911,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s3	#, sin_theta
	mv	a0,s8	#, _113
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp787, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s2	#, cos_theta
	mv	a0,s11	#, _115
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,24(sp)		# tmp787, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp913,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp787
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp914,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s2	#, cos_theta
	mv	a0,s8	#, _113
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,32(sp)	# tmp792, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp793, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s3	#, sin_theta
	mv	a0,s11	#, _115
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a7,24(sp)		# tmp793, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp916,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a7	#, tmp793
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	a2,a0	# tmp917,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _153
	mv	a0,s3	#, sin_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,28(sp)	# tmp798, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp799, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, _155
	mv	a0,s2	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a7,24(sp)		# tmp799, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp919,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a7	#, tmp799
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, tmp855
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a7,a0	# tmp920,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _153
	mv	a0,s2	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s8,a7	# tmp804, tmp920
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,24(sp)	# tmp805, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, _155
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a7,24(sp)		# tmp805, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp922,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a7	#, tmp805
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, tmp854
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	lw	a3,32(sp)		# tmp792, %sfp
	lw	a2,28(sp)		# tmp798, %sfp
	mv	a1,s8	#, tmp804
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	lw	a4,40(sp)		# _82, %sfp
	lw	a5,36(sp)		# i, %sfp
	bgtu	a4,a5,.L475	#, _82, i,
.L425:
# main_cube3d_rotate_hdmi.c:97: }
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
.L500:
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	neg	a0,s2	# v1, _655
	j	.L474		#
.L499:
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	a0,s3	# v1, _89
	j	.L472		#
.L498:
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	mv	a0,s7	# v1, _192
	j	.L470		#
.L497:
# gfx_lib_hdmi.h:281:   float sin_theta = SIN_FAST(angle);
	neg	a0,s10	# v1, _564
	j	.L468		#
.L496:
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	neg	a0,s5	# v1, _552
	j	.L466		#
.L495:
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	neg	a0,a3	# v1, _542
	j	.L464		#
.L494:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mv	a5,t6	# v1, angle
	j	.L462		#
.L493:
	mv	a7,a0	# v1, angle
	j	.L460		#
.L492:
	mv	t3,s8	# v1, angle
	j	.L458		#
.L491:
	mv	t2,a6	# v1, angle
	j	.L456		#
.L490:
	mv	s2,s11	# v1, angle
	j	.L454		#
.L489:
	mv	t0,s6	# v1, angle
	j	.L452		#
.L488:
	mv	a2,a4	# v0, v0
	j	.L450		#
.L487:
	mv	a1,a4	# v0, v0
	j	.L446		#
.L486:
	mv	a5,a4	# v0, v0
	j	.L442		#
.L485:
	mv	t3,a4	# v0, v0
	j	.L438		#
.L484:
	mv	a5,a4	# v0, v0
	j	.L434		#
.L483:
	mv	s2,a4	# v0, v0
	j	.L430		#
	.size	render_lines, .-render_lines
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
# gfx_lib_hdmi.h:231:   dma_action((uint32_t) framebuffer, rgb, VRES*HRES, DMA_MEMSET);
	lui	a4,%hi(framebuffer)	# tmp946,
# main_cube3d_rotate_hdmi.c:103: void main() {
	addi	sp,sp,-176	#,,
# gfx_lib_hdmi.h:231:   dma_action((uint32_t) framebuffer, rgb, VRES*HRES, DMA_MEMSET);
	addi	a4,a4,%lo(framebuffer)	# framebuffer.52_26, tmp946,
# main_cube3d_rotate_hdmi.c:103: void main() {
	sw	s2,160(sp)	#,
# gfx_lib_hdmi.h:231:   dma_action((uint32_t) framebuffer, rgb, VRES*HRES, DMA_MEMSET);
	sw	a4,84(sp)	# framebuffer.52_26, %sfp
# main_cube3d_rotate_hdmi.c:103: void main() {
	sw	ra,172(sp)	#,
	sw	s0,168(sp)	#,
	sw	s1,164(sp)	#,
	sw	s3,156(sp)	#,
	sw	s4,152(sp)	#,
	sw	s5,148(sp)	#,
	sw	s6,144(sp)	#,
	sw	s7,140(sp)	#,
	sw	s8,136(sp)	#,
	sw	s9,132(sp)	#,
	sw	s10,128(sp)	#,
	sw	s11,124(sp)	#,
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	li	a5,805306368		# tmp948,
	sw	a4,44(a5)	# framebuffer.52_26, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp954,
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	zero,48(a5)	#, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	a4,a4,704	#, tmp953, tmp954
	sw	a4,52(a5)	# tmp953, MEM[(volatile uint32_t *)805306420B]
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	lui	a4,%hi(.LC1)	# tmp1996,
	lw	a3,%lo(.LC1)(a4)		# tmp2066,
	lw	a4,%lo(.LC1+4)(a4)		#,
	lui	s2,%hi(.LC5)	# tmp1999,
	sw	a3,88(sp)	# tmp2066, %sfp
	sw	a4,92(sp)	#, %sfp
	lui	a4,%hi(.LC2)	# tmp1997,
	lw	a3,%lo(.LC2)(a4)		# tmp2067,
	lw	a4,%lo(.LC2+4)(a4)		#,
	sw	a3,96(sp)	# tmp2067, %sfp
	sw	a4,100(sp)	#, %sfp
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a4,2		# tmp957,
	sw	a4,56(a5)	# tmp957, MEM[(volatile uint32_t *)805306424B]
# main_cube3d_rotate_hdmi.c:115:   IO_OUT(GPIO_DIR, ~0);
	li	a4,-1		# tmp962,
# main_cube3d_rotate_hdmi.c:113:   *fb_ctrl = 0;
	sw	zero,36(a5)	#, MEM[(uint32_t *)805306404B]
# main_cube3d_rotate_hdmi.c:115:   IO_OUT(GPIO_DIR, ~0);
	sw	a4,20(a5)	# tmp962, MEM[(volatile uint32_t *)805306388B]
# main_cube3d_rotate_hdmi.c:116:   uint8_t led = 0x01;
	li	a5,1		# led,
	sw	a5,80(sp)	# led, %sfp
	lui	a5,%hi(.LANCHOR1)	# tmp2006,
	addi	a5,a5,%lo(.LANCHOR1)	# tmp2003, tmp2006,
	sw	a5,4(sp)	# tmp2003, %sfp
	lui	a5,%hi(.LANCHOR2)	# tmp2007,
	addi	a5,a5,%lo(.LANCHOR2)	# tmp2004, tmp2007,
	sw	a5,0(sp)	# tmp2004, %sfp
	lui	a5,%hi(.LANCHOR2+40)	# tmp2010,
	addi	a5,a5,%lo(.LANCHOR2+40)	# ivtmp.514, tmp2010,
# main_cube3d_rotate_hdmi.c:107:   int angle = 0;
	sw	zero,72(sp)	#, %sfp
	sw	a5,108(sp)	# ivtmp.514, %sfp
	lui	a5,%hi(.LANCHOR2+136)	# tmp2011,
	addi	a5,a5,%lo(.LANCHOR2+136)	# ivtmp.507, tmp2011,
	sw	a5,60(sp)	# ivtmp.507, %sfp
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	li	a5,-24576		# tmp986,
	addi	a5,a5,1	#, tmp985, tmp986
	sw	a5,20(sp)	# tmp985, %sfp
.L550:
# main_cube3d_rotate_hdmi.c:118:     render_lines(front, SIZEOF(front), angle, angle, angle, s);
	lw	a0,72(sp)		#, %sfp
	call	__floatsisf		#
	mv	s7,a0	# _1, tmp2076
# main_cube3d_rotate_hdmi.c:85:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	li	a0,-2147483648		# tmp964,
# main_cube3d_rotate_hdmi.c:85:     p0 = rotateX_pivot(&p0, &pivot, -angle_x);
	xor	a0,a0,s7	# _1,, tmp964
	call	__fixsfsi		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,88(sp)		#, %sfp
	lw	a3,92(sp)		#, %sfp
	call	__muldf3		#
	lw	a2,96(sp)		#, %sfp
	lw	a3,100(sp)		#, %sfp
	call	__divdf3		#
	call	__fixdfsi		#
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,a0,16	#, angle.39_617, tmp2077
	srli	a5,a5,16	#, angle.39_617, angle.39_617
	mv	a4,a5	# angle.39_617, angle.39_617
	sw	a5,104(sp)	# angle.39_617, %sfp
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp974,
	xor	a5,a4,a5	# tmp974, _618, angle.39_617
	sw	a5,16(sp)	# _618, %sfp
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	slli	a4,a0,16	#, _587, tmp2077
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,a5,16	#, angle, _618
	srai	a5,a5,16	#, angle, angle
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	srai	a4,a4,16	#, _587, _587
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	sw	a5,52(sp)	# angle, %sfp
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	sw	a4,76(sp)	# _587, %sfp
	blt	a4,zero,.L503	#, _587,,
	mv	a5,a4	# _587, _587
.L503:
	slli	s3,a5,16	#, angle, _587
	srai	s3,s3,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a4,s3,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp981, _587
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s10,a4,16	#, v0.41_622, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s5,a5,16	#, v1, tmp981
	andi	s4,a4,32	#, _623, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s10,s10,16	#, v0.41_622, v0.41_622
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	s5,s5,16	#, v1, v1
	not	s1,a4	# v0, v0
	bne	s4,zero,.L505	#, _623,,
	mv	s1,a4	# v0, v0
.L505:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a5,20(sp)		# tmp985, %sfp
	slli	s8,s3,16	#, angle.46_596, angle
	srli	s8,s8,16	#, angle.46_596, angle.46_596
	add	s9,s8,a5	# tmp985, tmp984, angle.46_596
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	s9,s9,16	#, _598, tmp984
	srai	s9,s9,16	#, _598, _598
	mv	a0,s9	#, _598
	call	sin1		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lui	s0,%hi(.LC3)	# tmp2398,
	lw	a2,%lo(.LC3)(s0)		#,
	lw	a3,%lo(.LC3+4)(s0)		#,
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s1,s1,31	#, _628, v0
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s6,a0	# tmp2078,
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	lw	a0,76(sp)		#, %sfp
	call	sin1		#
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s0)		#,
	lw	a3,%lo(.LC3+4)(s0)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
	li	a5,8192		# tmp999,
	addi	a5,a5,1	#, tmp998, tmp999
	mv	s0,a0	# sin_theta, tmp2079
	add	a6,s8,a5	# tmp998, _598, angle.46_596
	blt	s9,zero,.L507	#, _598,,
	mv	a6,s9	# _598, _598
.L507:
	slli	t1,a6,16	#, angle, _598
	srai	t1,t1,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,t1,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a6,a6	# tmp1006, _598
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a4,a5,16	#, v0.41_653, v0
	srli	a4,a4,16	#, v0.41_653, v0.41_653
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a6,a6,16	#, v1, tmp1006
	andi	a7,a5,32	#, _654, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	mv	s11,a4	# v0.41_653, v0.41_653
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a6,a6,16	#, v1, v1
	not	a4,a5	# v0, v0
	bne	a7,zero,.L509	#, _654,,
	mv	a4,a5	# v0, v0
.L509:
# main_cube3d_rotate_hdmi.c:89:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	mv	a0,s7	#, _1
	sw	a6,32(sp)	# v1, %sfp
	sw	a7,28(sp)	# _654, %sfp
	sw	t1,24(sp)	# angle, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s7,a4,31	#, _659, v0
# main_cube3d_rotate_hdmi.c:89:     p0 = rotateZ_pivot(&p0, &pivot, angle_z);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__floatsidf		#
	lw	a2,88(sp)		#, %sfp
	lw	a3,92(sp)		#, %sfp
	call	__muldf3		#
	lw	a2,96(sp)		#, %sfp
	lw	a3,100(sp)		#, %sfp
	call	__divdf3		#
	call	__fixdfsi		#
	slli	s8,a0,16	#, _427, tmp2080
	srai	s8,s8,16	#, _427, _427
	mv	a0,s8	#, _427
	sw	s8,56(sp)	# _427, %sfp
	call	sin1		#
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2402,
	lw	a3,%lo(.LC3+4)(a5)		#,
	lw	a2,%lo(.LC3)(a5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	slli	a5,s8,16	#, angle.44_432, _427
	srli	a5,a5,16	#, angle.44_432, angle.44_432
	mv	a3,a5	# angle.44_432, angle.44_432
	sw	a5,68(sp)	# angle.44_432, %sfp
# gfx_lib_hdmi.h:108:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	li	a5,32768		# tmp1023,
	xor	a5,a3,a5	# tmp1023, _433, angle.44_432
	sw	a5,12(sp)	# _433, %sfp
	slli	a5,a5,16	#, angle, _433
	srai	a5,a5,16	#, angle, angle
	sw	a5,48(sp)	# angle, %sfp
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	sw	a0,8(sp)	# tmp2081, %sfp
	lw	t1,24(sp)		# angle, %sfp
	lw	a7,28(sp)		# _654, %sfp
	lw	a6,32(sp)		# v1, %sfp
	mv	a1,a5	# _427, angle
	blt	s8,zero,.L511	#, _427,,
	mv	a1,s8	# _427, _427
.L511:
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a4,20(sp)		# tmp985, %sfp
	slli	a5,a1,16	#, angle.46_436, _427
	srli	a5,a5,16	#, angle.46_436, angle.46_436
	add	a4,a5,a4	# tmp985, tmp1025, angle.46_436
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a3,a4,16	#, _438, tmp1025
	srai	a3,a3,16	#, _438, _438
	li	a4,8192		# tmp1030,
	slli	a1,a1,16	#, angle, _427
	addi	a4,a4,1	#, tmp1029, tmp1030
	sw	a3,64(sp)	# _438, %sfp
	srai	a1,a1,16	#, angle, angle
	add	a5,a5,a4	# tmp1029, _438, angle.46_436
	blt	a3,zero,.L513	#, _438,,
	mv	a5,a3	# _438, _438
.L513:
	slli	t4,a5,16	#, angle, _438
	srai	t4,t4,16	#, angle, angle
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a3,t4,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1037, _438
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s8,a3,16	#, v0.41_746, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	t6,a5,16	#, v1, tmp1037
	andi	t5,a3,32	#, _747, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s8,s8,16	#, v0.41_746, v0.41_746
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	t6,t6,16	#, v1, v1
	not	a4,a3	# v0, v0
	bne	t5,zero,.L515	#, _747,,
	mv	a4,a3	# v0, v0
.L515:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a1,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	s9,a5,16	#, v0.41_777, v0
	andi	a0,a5,32	#, _778, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a4,a4,31	#, _752, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	s9,s9,16	#, v0.41_777, v0.41_777
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	t3,a1	# v1, angle
	not	a2,a5	# v0, v0
	bne	a0,zero,.L517	#, _778,,
	mv	a2,a5	# v0, v0
.L517:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a3,4(sp)		# tmp2003, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a5,s1,1	#, tmp1054, _628
	slli	a5,a5,1	#, tmp1055, tmp1054
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s1,s1,1	#, tmp1050, _628
	add	s1,a3,s1	# tmp1050, tmp1051, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a3,a5	# tmp1055, tmp1056, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t2,0(s1)		# pretmp_3131, sin90[_628]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a5)		# sin90[_631], sin90[_631]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a2,a2,31	#, _783, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,t2	# tmp1058, sin90[_631], pretmp_3131
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	s4,zero,.L519	#, _623,,
	mv	s5,s3	# v1, angle
.L519:
	andi	s5,s5,0xff	# tmp1061, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,s5	# tmp1062, tmp1058, tmp1061
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	t0,4(sp)		# tmp2003, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a3,s7,1	#, tmp1073, _659
	slli	a3,a3,1	#, tmp1074, tmp1073
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s7,s7,1	#, tmp1069, _659
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,t0,a3	# tmp1074, tmp1075, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,t0,s7	# tmp1069, tmp1070, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s5,0(a3)		# sin90[_662], sin90[_662]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	t0,0(s7)		# pretmp_2946, sin90[_659]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a3,a5,8	#, tmp1063, tmp1062
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a3,a3,t2	# pretmp_3131, tmp1066, tmp1063
	slli	a3,a3,16	#, _3003, tmp1066
	srli	a3,a3,16	#, _3003, _3003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s5,s5,t0	# tmp1077, sin90[_662], pretmp_2946
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a7,zero,.L521	#, _654,,
	mv	a6,t1	# v1, angle
.L521:
	andi	a6,a6,0xff	# tmp1080, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s5,s5,a6	# tmp1081, tmp1077, tmp1080
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a6,4(sp)		# tmp2003, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a5,a4,1	#, tmp1092, _752
	slli	a5,a5,1	#, tmp1093, tmp1092
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a4,a4,1	#, tmp1088, _752
	add	a4,a6,a4	# tmp1088, tmp1089, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a6,a5	# tmp1093, tmp1094, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a4,0(a4)		# pretmp_3141, sin90[_752]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s4,0(a5)		# sin90[_755], sin90[_755]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s5,s5,8	#, tmp1082, tmp1081
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s5,s5,t0	# pretmp_2946, tmp1085, tmp1082
	slli	s5,s5,16	#, _3001, tmp1085
	srli	s5,s5,16	#, _3001, _3001
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s4,s4,a4	# tmp1096, sin90[_755], pretmp_3141
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	t5,zero,.L523	#, _747,,
	mv	t6,t4	# v1, angle
.L523:
	andi	t6,t6,0xff	# tmp1099, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s4,s4,t6	# tmp1100, tmp1096, tmp1099
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a5,4(sp)		# tmp2003, %sfp
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a6,a2,1	#, tmp1111, _783
	slli	a6,a6,1	#, tmp1112, tmp1111
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a2,a2,1	#, tmp1107, _783
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a6,a5,a6	# tmp1112, tmp1113, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a2,a5,a2	# tmp1107, tmp1108, tmp2003
	lh	a5,0(a2)		# pretmp_3122, sin90[_783]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	s7,0(a6)		# sin90[_786], sin90[_786]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s4,s4,8	#, tmp1101, tmp1100
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s4,s4,a4	# pretmp_3141, tmp1104, tmp1101
	slli	s4,s4,16	#, _3139, tmp1104
	srli	s4,s4,16	#, _3139, _3139
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	s7,s7,a5	# tmp1115, sin90[_786], pretmp_3122
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	bne	a0,zero,.L525	#, _778,,
	mv	t3,a1	# v1, angle
.L525:
	andi	t3,t3,0xff	# tmp1118, v1
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	s7,s7,t3	# tmp1119, tmp1115, tmp1118
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	andi	s10,s10,64	#, tmp1129, v0.41_622
	lw	s1,108(sp)		# ivtmp.514, %sfp
	mv	a0,a3	# v1, _3003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	s7,s7,8	#, tmp1120, tmp1119
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	s7,s7,a5	# pretmp_3122, tmp1123, tmp1120
	slli	s7,s7,16	#, _98, tmp1123
	srli	s7,s7,16	#, _98, _98
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	beq	s10,zero,.L527	#, tmp1129,,
	neg	a0,a3	# v1, _3003
.L527:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2419,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	andi	a5,s11,64	#, tmp1140, v0.41_653
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	s3,a0	# sin_theta, tmp2082
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	mv	a0,s5	# v1, _3001
	beq	a5,zero,.L529	#, tmp1140,,
	neg	a0,s5	# v1, _3001
.L529:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2421,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	andi	s8,s8,64	#, tmp1151, v0.41_746
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:282:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s5,a0	# cos_theta, tmp2083
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	a0,s4	# v1, _3139
	beq	s8,zero,.L531	#, tmp1151,,
	neg	a0,s4	# v1, _3139
.L531:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2422,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	andi	s9,s9,64	#, tmp1162, v0.41_777
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s4,a0	# cos_theta, tmp2084
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	neg	a0,s7	# v1, _98
	bne	s9,zero,.L533	#, tmp1162,,
	mv	a0,s7	# v1, _98
.L533:
	slli	a0,a0,16	#,, v1
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2423,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LC8)	# tmp2424,
	lw	s7,%lo(.LC8)(a5)		# tmp2055,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2425,
	lw	s9,%lo(.LC7)(a5)		# tmp2061,
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	sw	a0,24(sp)	# sin_theta, %sfp
	sw	s5,28(sp)	# cos_theta, %sfp
.L534:
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s1)		#, MEM[(int *)_2601 + 4B]
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s1,s1,24	#, ivtmp.514, ivtmp.514
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2086
	call	__floatsisf		#
	mv	s11,a0	# tmp2087,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s1)		#, MEM[(int *)_2601 + 8B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2088
	call	__floatsisf		#
	mv	s10,a0	# tmp2089,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s1)		#, MEM[(int *)_2601 + 16B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2090
	call	__floatsisf		#
	mv	s8,a0	# tmp2091,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s1)		#, MEM[(int *)_2601 + 20B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2092
	call	__floatsisf		#
	mv	s5,a0	# tmp2093,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s1)		#, MEM[(int *)_2601]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2094
	call	__floatsisf		#
	lw	a1,28(sp)		#, %sfp
	call	__mulsf3		#
	mv	a5,a0	# tmp2095,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _604
	mv	a0,s3	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a5,36(sp)	# tmp1196, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _606
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,32(sp)	# tmp1197, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s6	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a6,32(sp)		# tmp1197, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2097,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a6	#, tmp1197
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,36(sp)		# tmp1196, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2098,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1196
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2426,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2099
	call	__floatsisf		#
	mv	a5,a0	# tmp2100,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _604
	mv	a0,s6	#, cos_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s11,a5	# _444, tmp2100
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _606
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,32(sp)	# tmp1209, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a2,32(sp)		# tmp1209, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2102,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a2	#, tmp1209
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, tmp2061
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2103
	call	__floatsisf		#
	mv	s10,a0	# tmp2104,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s1)		#, MEM[(int *)_2601 + 12B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2055
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2105
	call	__floatsisf		#
	lw	a1,28(sp)		#, %sfp
	call	__mulsf3		#
	mv	a2,a0	# tmp2106,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _564
	mv	a0,s0	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a2,36(sp)	# tmp1222, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1223, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s6	#, cos_theta
	mv	a0,s5	#, _566
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a6,32(sp)		# tmp1223, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2108,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a6	#, tmp1223
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a2,36(sp)		# tmp1222, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2109,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a2	#, tmp1222
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2427,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2110
	call	__floatsisf		#
	mv	a5,a0	# tmp2111,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, cos_theta
	mv	a0,s8	#, _564
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s8,a5	# _404, tmp2111
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s5	#, _566
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,32(sp)	# tmp1235, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,32(sp)		# tmp1235, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2113,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1235
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, tmp2061
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2114
	call	__floatsisf		#
	mv	s5,a0	# tmp2115,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a0,24(sp)		#, %sfp
	mv	a1,s8	#, _404
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1242, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, cos_theta
	mv	a0,s5	#, _406
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,32(sp)		# tmp1242, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2117,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp1242
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, tmp2061
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2118,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, cos_theta
	mv	a0,s8	#, _404
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,44(sp)	# tmp1247, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1248, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a0,24(sp)		#, %sfp
	mv	a1,s5	#, _406
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a2,32(sp)		# tmp1248, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2120,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a2	#, tmp1248
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s5,8(sp)		# sin_theta, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2121,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _444
	mv	a0,s5	#, sin_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,40(sp)	# tmp1253, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1254, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _446
	mv	a0,s4	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a4,32(sp)		# tmp1254, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2123,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a4	#, tmp1254
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2428,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a4,a0	# tmp2124,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _444
	mv	a0,s4	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a4,36(sp)	# tmp1259, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1260, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _446
	mv	a0,s5	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a4,32(sp)		# tmp1260, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2126,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a4	#, tmp1260
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	lw	a5,36(sp)		# tmp1259, %sfp
	lw	a3,44(sp)		# tmp1247, %sfp
	lw	a2,40(sp)		# tmp1253, %sfp
	mv	a1,a5	#, tmp1259
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	lw	a5,60(sp)		# ivtmp.507, %sfp
	bne	s1,a5,.L534	#, ivtmp.514, ivtmp.507,
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a0,64(sp)		#, %sfp
	mv	s1,a5	# ivtmp.507, ivtmp.507
	lw	s8,24(sp)		# sin_theta, %sfp
	call	sin1		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2430,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	s5,28(sp)		# cos_theta, %sfp
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	a5,%hi(.LC8)	# tmp2431,
	lw	s7,%lo(.LC8)(a5)		# tmp2044,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2432,
	lw	s9,%lo(.LC7)(a5)		# tmp2050,
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	sw	a0,24(sp)	# tmp2127, %sfp
	sw	s4,64(sp)	# cos_theta, %sfp
	sw	s6,28(sp)	# cos_theta, %sfp
.L535:
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,4(s1)		#, MEM[(int *)_2114 + 4B]
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	addi	s1,s1,24	#, ivtmp.507, ivtmp.507
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2128
	call	__floatsisf		#
	mv	s11,a0	# tmp2129,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-16(s1)		#, MEM[(int *)_2114 + 8B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2130
	call	__floatsisf		#
	mv	s10,a0	# tmp2131,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-8(s1)		#, MEM[(int *)_2114 + 16B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2132
	call	__floatsisf		#
	mv	s6,a0	# tmp2133,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-4(s1)		#, MEM[(int *)_2114 + 20B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2134
	call	__floatsisf		#
	mv	s4,a0	# tmp2135,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-24(s1)		#, MEM[(int *)_2114]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2136
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a4,a0	# tmp2137,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _1061
	mv	a0,s3	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a4,36(sp)	# tmp1299, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _1063
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,32(sp)	# tmp1300, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,32(sp)		# tmp1300, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2139,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1300
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a4,36(sp)		# tmp1299, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2140,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a4	#, tmp1299
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2433,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2141
	call	__floatsisf		#
	mv	a5,a0	# tmp2142,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _1061
	mv	a0,s5	#, cos_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s11,a5	# _901, tmp2142
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _1063
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,32(sp)	# tmp1312, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,32(sp)		# tmp1312, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2144,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1312
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, tmp2050
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2145
	call	__floatsisf		#
	mv	s10,a0	# tmp2146,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,-12(s1)		#, MEM[(int *)_2114 + 12B]
	call	__floatsisf		#
	mv	a1,s7	#, tmp2044
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2147
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a6,a0	# tmp2148,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s6	#, _1021
	mv	a0,s0	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a6,36(sp)	# tmp1325, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1326, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a0,28(sp)		#, %sfp
	mv	a1,s4	#, _1023
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a7,32(sp)		# tmp1326, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2150,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a7	#, tmp1326
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s3	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a6,36(sp)		# tmp1325, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2151,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a6	#, tmp1325
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lui	a5,%hi(.LC5)	# tmp2434,
	lw	a1,%lo(.LC5)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2152
	call	__floatsisf		#
	mv	a5,a0	# tmp2153,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a0,28(sp)		#, %sfp
	mv	a1,s6	#, _1021
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s6,a5	# _861, tmp2153
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, _1023
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,32(sp)	# tmp1338, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,32(sp)		# tmp1338, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2155,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1338
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, tmp2050
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2156
	call	__floatsisf		#
	mv	s4,a0	# tmp2157,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _861
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1345, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a0,24(sp)		#, %sfp
	mv	a1,s4	#, _863
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a3,32(sp)		# tmp1345, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2159,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a3	#, tmp1345
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, tmp2050
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2160,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a0,24(sp)		#, %sfp
	mv	a1,s6	#, _861
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,44(sp)	# tmp1350, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _863
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a0,32(sp)	# tmp1351, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s8	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,32(sp)		# tmp1351, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2162,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1351
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s6,8(sp)		# sin_theta, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a2,a0	# tmp2163,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _901
	mv	a0,s6	#, sin_theta
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	sw	a2,40(sp)	# tmp1356, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s4,64(sp)		# cos_theta, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a0,32(sp)	# tmp1357, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _903
	mv	a0,s4	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a6,32(sp)		# tmp1357, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2165,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a6	#, tmp1357
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2435,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a6,a0	# tmp2166,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _901
	mv	a0,s4	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a6,36(sp)	# tmp1362, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	sw	a0,32(sp)	# tmp1363, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _903
	mv	a0,s6	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a6,32(sp)		# tmp1363, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,a0	# tmp2168,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,a6	#, tmp1363
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	lw	a4,36(sp)		# tmp1362, %sfp
	lw	a3,44(sp)		# tmp1350, %sfp
	lw	a2,40(sp)		# tmp1356, %sfp
	mv	a1,a4	#, tmp1362
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate_hdmi.c:72:   for (int i = 0; i < s - 1; i = i + 2) {
	lui	a5,%hi(.LANCHOR2+232)	# tmp2437,
	addi	a5,a5,%lo(.LANCHOR2+232)	# tmp2436, tmp2437,
	bne	s1,a5,.L535	#, ivtmp.507, tmp2436,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	s1,0(sp)		# tmp2004, %sfp
	lui	s3,%hi(.LC8)	# tmp2439,
	lw	a0,232(s1)		#, MEM[(struct point *)&left_bottom].x
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s6,a0	# tmp2169,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,244(s1)		#, MEM[(struct point *)&left_bottom + 12B].x
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	sw	s6,24(sp)	# tmp2169, %sfp
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s7,a0	# tmp2170,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,248(s1)		#, MEM[(struct point *)&left_bottom + 12B].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s5,a0	# tmp2171,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,240(s1)		#, MEM[(struct point *)&left_bottom].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s4,a0	# tmp2172,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,252(s1)		#, MEM[(struct point *)&left_bottom + 12B].z
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	addi	s4,s4,-20	#, _249, tmp2172
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
	mv	s8,a0	# tmp2173,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,236(s1)		#, MEM[(struct point *)&left_bottom].y
# gfx_lib_hdmi.h:256:   point transformed = {p->x + tx, p->y + ty, p->z + tz};
	addi	s8,s8,-20	#, _252, tmp2173
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s3)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a5,76(sp)		# _587, %sfp
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s9,a0,-60	#, _1525, tmp2174
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	blt	a5,zero,.L536	#, _587,,
	lw	a4,104(sp)		# angle.39_617, %sfp
	sw	a5,52(sp)	# _587, %sfp
	sw	a4,16(sp)	# angle.39_617, %sfp
.L536:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	lw	a1,52(sp)		# angle, %sfp
	lw	a3,16(sp)		# _1482, %sfp
	srai	a5,a1,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_1567, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp1405, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_1567, v0.41_1567
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L537	#, tmp1405,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a1	# tmp1409, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _1482, tmp1409
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _1482, _1482
.L537:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a1,4(sp)		# tmp2003, %sfp
	andi	a5,a5,31	#, _1573, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp1417, _1573
	slli	a4,a4,1	#, tmp1418, tmp1417
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1413, _1573
	add	a5,a1,a5	# tmp1413, tmp1414, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a1,a4	# tmp1418, tmp1419, tmp2003
	lh	a0,0(a4)		# sin90[_1576], sin90[_1576]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _1574, sin90[_1573]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp1423, _1482
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp1431, v0.41_1567
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp1421, sin90[_1576], _1574
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp1424, tmp1421, tmp1423
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp1425, tmp1424
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _1574, tmp1428, tmp1425
	slli	a0,a0,16	#, _1588, tmp1428
	srli	a0,a0,16	#, _1588, _1588
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L538	#, tmp1431,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp1433, _1588
	slli	a0,a0,16	#, _1588, tmp1433
	srli	a0,a0,16	#, _1588, _1588
.L538:
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _1588
	srai	a0,a0,16	#,,
	lui	s3,%hi(.LC3)	# tmp2457,
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s3)		#,
	lw	a3,%lo(.LC3+4)(s3)		#,
# gfx_lib_hdmi.h:262:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s5,s5,-60	#, _1485, _234
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a5,16(sp)		# _618, %sfp
	lw	a3,20(sp)		# tmp985, %sfp
# gfx_lib_hdmi.h:266:   float sin_theta = SIN_FAST(angle);
	mv	s1,a0	# tmp2175,
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	add	s10,a5,a3	# tmp985, tmp1439, _618
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	s11,s10,16	#, angle, tmp1439
	srai	s11,s11,16	#, angle, angle
	mv	a0,s11	#, angle
	call	sin1		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s3)		#,
	lw	a3,%lo(.LC3+4)(s3)		#,
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	s10,s10,16	#, _1542, tmp1439
	srli	s10,s10,16	#, _1542, _1542
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s3,a0	# tmp2176,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s9	#, _1525
	call	__floatsisf		#
	mv	a5,a0	# tmp2177,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, _249
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s4,a5	# _1549, tmp2177
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s9,a0	# tmp2178,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, _1549
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
	mv	s6,a0	# tmp1447, tmp2179
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _1551
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2180,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s6	#, tmp1447
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a3,%hi(.LC7)	# tmp2461,
	lw	a1,%lo(.LC7)(a3)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2181,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s4	#, _1549
	mv	a0,s1	#, sin_theta
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s4,a5	# _1555, tmp2181
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, _1551
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	s6,a0	# tmp1452, tmp2182
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2183,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s6	#, tmp1452
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
	mv	s9,a0	# _1561, tmp2184
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	s11,zero,.L539	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a4,16(sp)		# _618, %sfp
	li	a5,8192		# tmp1458,
	addi	a5,a5,1	#, tmp1457, tmp1458
	add	a5,a4,a5	# tmp1457, tmp1456, _618
	slli	s10,a5,16	#, _1542, tmp1456
	slli	s11,a5,16	#, angle, tmp1456
	srli	s10,s10,16	#, _1542, _1542
	srai	s11,s11,16	#, angle, angle
.L539:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,s11,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_1629, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp1462, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_1629, v0.41_1629
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L540	#, tmp1462,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1464, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	s11,s11	# tmp1466, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v0, tmp1464
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	s10,s11,16	#, _1542, tmp1466
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	s10,s10,16	#, _1542, _1542
.L540:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a2,4(sp)		# tmp2003, %sfp
	andi	a5,a5,31	#, _1635, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp1474, _1635
	slli	a4,a4,1	#, tmp1475, tmp1474
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1470, _1635
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a2,a4	# tmp1475, tmp1476, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a2,a5	# tmp1470, tmp1471, tmp2003
	lh	a2,0(a5)		# _1636, sin90[_1635]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a5,0(a4)		# sin90[_1638], sin90[_1638]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s10,s10,0xff	# tmp1480, _1542
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a4,a3,64	#, tmp1488, v0.41_1629
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a5,a5,a2	# tmp1478, sin90[_1638], _1636
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a5,a5,s10	# tmp1481, tmp1478, tmp1480
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a5,a5,8	#, tmp1482, tmp1481
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a5,a5,a2	# _1636, tmp1485, tmp1482
	slli	a5,a5,16	#, _1650, tmp1485
	srli	a5,a5,16	#, _1650, _1650
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a4,zero,.L541	#, tmp1488,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a5,a5	# tmp1490, _1650
	slli	a5,a5,16	#, _1650, tmp1490
	srli	a5,a5,16	#, _1650, _1650
.L541:
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	slli	a0,a5,16	#,, _1650
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2465,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s4,s4,-30	#, _1367, _1555
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__muldf3		#
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp2185,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, _1485
# gfx_lib_hdmi.h:267:   float cos_theta = COS_FAST(angle);
	mv	s5,a5	# cos_theta, tmp2185
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	s11,a0	# tmp2186,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s8	#, _252
	call	__floatsisf		#
	mv	s10,a0	# tmp2187,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _1509
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s8,a0	# tmp1496, tmp2188
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s1	#, sin_theta
	mv	a0,s10	#, _1511
	call	__mulsf3		#
	mv	a1,a0	# tmp2189,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s8	#, tmp1496
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a5,%hi(.LC7)	# tmp2466,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s1	#, sin_theta
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s8,a0	# tmp2190,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s11	#, _1509
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _1511
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	s11,a0	# tmp1501, tmp2191
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2192,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s11	#, tmp1501
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
	mv	a5,a0	# tmp2193,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,s7,-20	#,, _230
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s7,a5	# tmp1507, tmp2193
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2194,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, tmp1507
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a4,24(sp)		# _218, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a5,a0	# tmp2195,
	mv	s6,a5	# _1435, tmp2195
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a4,-20	#,, _218
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	s7,a0	# tmp2196,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s9	#, _1561
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2197,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s7	#, tmp1516
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a5,56(sp)		# _427, %sfp
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s10,a0,-40	#, _1364, tmp2198
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	blt	a5,zero,.L542	#, _427,,
	lw	a4,68(sp)		# angle.44_432, %sfp
	sw	a5,48(sp)	# _427, %sfp
	sw	a4,12(sp)	# angle.44_432, %sfp
.L542:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	lw	a1,48(sp)		# angle, %sfp
	lw	a3,12(sp)		# _1738, %sfp
	srai	a5,a1,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a2,a5,16	#, v0.41_1753, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a4,a5,32	#, tmp1526, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a2,a2,16	#, v0.41_1753, v0.41_1753
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a4,zero,.L543	#, tmp1526,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a1	# tmp1530, angle
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a3,a4,16	#, _1738, tmp1530
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a3,a3,16	#, _1738, _1738
.L543:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a1,4(sp)		# tmp2003, %sfp
	andi	a5,a5,31	#, _1759, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp1538, _1759
	slli	a4,a4,1	#, tmp1539, tmp1538
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1534, _1759
	add	a5,a1,a5	# tmp1534, tmp1535, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a1,a4	# tmp1539, tmp1540, tmp2003
	lh	a0,0(a4)		# sin90[_1762], sin90[_1762]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a1,0(a5)		# _1760, sin90[_1759]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	a3,a3,0xff	# tmp1544, _1738
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a2,64	#, tmp1552, v0.41_1753
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a1	# tmp1542, sin90[_1762], _1760
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,a3	# tmp1545, tmp1542, tmp1544
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp1546, tmp1545
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a1	# _1760, tmp1549, tmp1546
	slli	a0,a0,16	#, _1774, tmp1549
	srli	a0,a0,16	#, _1774, _1774
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L544	#, tmp1552,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp1554, _1774
	slli	a0,a0,16	#, _1774, tmp1554
	srli	a0,a0,16	#, _1774, _1774
.L544:
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	slli	a0,a0,16	#,, _1774
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	s7,%hi(.LC3)	# tmp2475,
	lw	a2,%lo(.LC3)(s7)		#,
	lw	a3,%lo(.LC3+4)(s7)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	call	__truncdfsf2		#
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	lw	a5,12(sp)		# _433, %sfp
	lw	a3,20(sp)		# tmp985, %sfp
# gfx_lib_hdmi.h:296:   float sin_theta = SIN_FAST(angle);
	mv	s9,a0	# tmp2199,
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	add	s11,a5,a3	# tmp985, tmp1560, _433
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a4,s11,16	#, angle, tmp1560
	srai	a4,a4,16	#, angle, angle
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	slli	a6,s11,16	#, prephitmp_1172, tmp1560
	srli	a6,a6,16	#, prephitmp_1172, prephitmp_1172
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	mv	a0,a4	#, angle
	sw	a4,32(sp)	# angle, %sfp
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	sw	a6,28(sp)	# prephitmp_1172, %sfp
# gfx_lib_hdmi.h:109:   return sin1(angle - (int16_t)(((int32_t)INT16_MAX * 270) / 360));
	call	sin1		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__floatsidf		#
	lw	a2,%lo(.LC3)(s7)		#,
	lw	a3,%lo(.LC3+4)(s7)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	s7,a0	# tmp2200,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, _1364
	call	__floatsisf		#
	mv	s10,a0	# tmp2201,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, _1367
	call	__floatsisf		#
	mv	s4,a0	# tmp2202,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,s6,-40	#,, _1435
	call	__floatsisf		#
	mv	a5,a0	# tmp2203,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,s8,-30	#,, _1515
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s8,a5	# _1349, tmp2203
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	s6,a0	# tmp2204,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s8	#, _1349
	call	__mulsf3		#
	mv	s11,a0	# tmp1570, tmp2205
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s6	#, _1351
	call	__mulsf3		#
	mv	a1,a0	# tmp2206,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp1570
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2479,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	s11,a0	# tmp2207,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s7	#, cos_theta
	mv	a0,s8	#, _1349
	call	__mulsf3		#
	mv	s8,a0	# tmp1576, tmp2208
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s9	#, sin_theta
	mv	a0,s6	#, _1351
	call	__mulsf3		#
	mv	a1,a0	# tmp2209,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s8	#, tmp1576
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	s8,a0	# tmp2210,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _1389
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	s6,a0	# tmp1582, tmp2211
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, _1391
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2212,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s6	#, tmp1582
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2480,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	s6,a0	# tmp2213,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _1389
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp1588, tmp2214
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _1391
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2215,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, tmp1588
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	mv	a2,s8	#, tmp1581
	mv	a3,s11	#, tmp1575
	mv	a1,s6	#, tmp1587
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	s4,0(sp)		# tmp2004, %sfp
	lui	s6,%hi(.LC8)	# tmp2482,
	lw	a0,260(s4)		#, MEM[(struct point *)&left_top].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s6)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2216
	call	__floatsisf		#
	mv	s8,a0	# tmp2217,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,264(s4)		#, MEM[(struct point *)&left_top].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s6)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2218
	call	__floatsisf		#
	mv	s10,a0	# tmp2219,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,272(s4)		#, MEM[(struct point *)&left_top + 12B].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s6)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2220
	call	__floatsisf		#
	mv	s11,a0	# tmp2221,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,276(s4)		#, MEM[(struct point *)&left_top + 12B].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s6)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2222
	call	__floatsisf		#
	mv	s6,a0	# tmp2223,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _1997
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s4,a0	# tmp1622, tmp2224
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, _1999
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2225,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s4	#, tmp1622
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a3,%hi(.LC7)	# tmp2489,
	lw	a1,%lo(.LC7)(a3)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a5,0(sp)		# tmp2004, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	s4,a0	# tmp2226,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,268(a5)		#, MEM[(struct point *)&left_top + 12B].x
	call	__floatsisf		#
	lui	a4,%hi(.LC8)	# tmp2491,
	lw	a1,%lo(.LC8)(a4)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2227
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	a3,a0	# tmp2228,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _1997
	mv	a0,s1	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a3,24(sp)	# tmp1635, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s6	#, _1999
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,16(sp)	# tmp1636, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a3,16(sp)		# tmp1636, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2230,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a3	#, tmp1636
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,24(sp)		# tmp1635, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2231,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1635
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a5,0(sp)		# tmp2004, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	s6,a0	# tmp2232,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,256(a5)		#, MEM[(struct point *)&left_top].x
	call	__floatsisf		#
	lui	a4,%hi(.LC8)	# tmp2493,
	lw	a1,%lo(.LC8)(a4)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2233
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	a5,a0	# tmp2234,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _2037
	mv	a0,s1	#, sin_theta
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	sw	a5,24(sp)	# tmp1654, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _2039
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,16(sp)	# tmp1655, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a3,16(sp)		# tmp1655, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2236,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a3	#, tmp1655
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a5,24(sp)		# tmp1654, %sfp
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2237,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1654
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2238,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s8	#, _2037
	mv	a0,s3	#, cos_theta
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s8,a5,-40	#, _1852, tmp2238
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _2039
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	sw	a0,16(sp)	# tmp1666, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a5,16(sp)		# tmp1666, %sfp
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,a0	# tmp2240,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,a5	#, tmp1666
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a3,%hi(.LC7)	# tmp2494,
	lw	a1,%lo(.LC7)(a3)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a4,32(sp)		# angle, %sfp
	lw	a6,28(sp)		# prephitmp_1172, %sfp
# gfx_lib_hdmi.h:292:   point shifted_point = {p->x - pivot->x, p->y - pivot->y, p->z - pivot->z};
	addi	s10,a0,-30	#, _1855, tmp2241
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	bge	a4,zero,.L545	#, angle,,
# gfx_lib_hdmi.h:87:   if(angle < 0) { angle += INT16_MAX; angle += 1; }
	lw	a4,12(sp)		# _433, %sfp
	li	a5,8192		# tmp1674,
	addi	a5,a5,1	#, tmp1673, tmp1674
	add	a5,a4,a5	# tmp1673, tmp1672, _433
	slli	a6,a5,16	#, prephitmp_1172, tmp1672
	slli	a4,a5,16	#, angle, tmp1672
	srli	a6,a6,16	#, prephitmp_1172, prephitmp_1172
	srai	a4,a4,16	#, angle, angle
.L545:
# gfx_lib_hdmi.h:88:   v0 = (angle >> INTERP_BITS);
	srai	a5,a4,8	#, v0, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a3,a5,16	#, v0.41_2272, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	andi	a2,a5,32	#, tmp1678, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srli	a3,a3,16	#, v0.41_2272, v0.41_2272
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	beq	a2,zero,.L546	#, tmp1678,,
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a5,a5	# tmp1680, v0
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	not	a4,a4	# tmp1682, angle
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	slli	a5,a5,16	#, v0, tmp1680
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a6,a4,16	#, prephitmp_1172, tmp1682
# gfx_lib_hdmi.h:89:   if(v0 & FLIP_BIT) { v0 = ~v0; v1 = ~angle; } else { v1 = angle; }
	srai	a5,a5,16	#, v0, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srli	a6,a6,16	#, prephitmp_1172, prephitmp_1172
.L546:
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lw	a2,4(sp)		# tmp2003, %sfp
	andi	a5,a5,31	#, _2278, v0
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	addi	a4,a5,1	#, tmp1690, _2278
	slli	a4,a4,1	#, tmp1691, tmp1690
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	slli	a5,a5,1	#, tmp1686, _2278
	add	a5,a2,a5	# tmp1686, tmp1687, tmp2003
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a4,a2,a4	# tmp1691, tmp1692, tmp2003
	lh	a0,0(a4)		# sin90[_2281], sin90[_2281]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	lh	a2,0(a5)		# _2279, sin90[_2278]
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	andi	s11,a6,0xff	# tmp1696, prephitmp_1172
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	andi	a5,a3,64	#, tmp1704, v0.41_2272
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	sub	a0,a0,a2	# tmp1694, sin90[_2281], _2279
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	mul	a0,a0,s11	# tmp1697, tmp1694, tmp1696
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	srai	a0,a0,8	#, tmp1698, tmp1697
# gfx_lib_hdmi.h:91:   v1 = sin90[v0] + (int16_t) (((int32_t) (sin90[v0+1]-sin90[v0]) * (v1 & INTERP_MASK)) >> INTERP_BITS);
	add	a0,a0,a2	# _2279, tmp1701, tmp1698
	slli	a0,a0,16	#, _2293, tmp1701
	srli	a0,a0,16	#, _2293, _2293
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	beq	a5,zero,.L547	#, tmp1704,,
# gfx_lib_hdmi.h:92:   if((angle >> INTERP_BITS) & NEGATE_BIT) v1 = -v1;
	neg	a0,a0	# tmp1706, _2293
	slli	a0,a0,16	#, _2293, tmp1706
	srli	a0,a0,16	#, _2293, _2293
.L547:
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	slli	a0,a0,16	#,, _2293
	srai	a0,a0,16	#,,
	call	__floatsidf		#
	lui	a5,%hi(.LC3)	# tmp2498,
	lw	a2,%lo(.LC3)(a5)		#,
	lw	a3,%lo(.LC3+4)(a5)		#,
	call	__muldf3		#
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	call	__truncdfsf2		#
	mv	a5,a0	# tmp2242,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s8	#, _1852
# gfx_lib_hdmi.h:297:   float cos_theta = COS_FAST(angle);
	mv	s8,a5	# tmp1711, tmp2242
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	a5,a0	# tmp2243,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s10	#, _1855
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s10,a5	# _1877, tmp2243
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	a5,a0	# tmp2244,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,s6,-40	#,, _1923
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s6,a5	# _1879, tmp2244
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__floatsisf		#
	mv	s11,a0	# tmp2245,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,s4,-30	#,, _2003
	call	__floatsisf		#
	mv	s4,a0	# tmp2246,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s11	#, _1837
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, _1839
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a0,12(sp)	# tmp1714, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a5,12(sp)		# tmp1714, %sfp
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,a0	# tmp2248,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,a5	#, tmp1714
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2499,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a3,a0	# tmp2249,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s11	#, _1837
	mv	a0,s7	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	sw	a3,12(sp)	# tmp1719, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1720, tmp2250
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _1839
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2251,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, tmp1720
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	s11,a0	# tmp2252,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _1877
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	s4,a0	# tmp1726, tmp2253
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _1879
	mv	a0,s8	#, tmp1711
	call	__mulsf3		#
	mv	a1,a0	# tmp2254,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s4	#, tmp1726
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a5,%hi(.LC7)	# tmp2500,
	lw	a1,%lo(.LC7)(a5)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	s4,a0	# tmp2255,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _1877
	mv	a0,s8	#, tmp1711
	call	__mulsf3		#
	mv	s8,a0	# tmp1732, tmp2256
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s6	#, _1879
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2257,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s8	#, tmp1732
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s8,%hi(.LC8)	# tmp2502,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	lw	a3,12(sp)		# tmp1719, %sfp
	mv	a2,s11	#, tmp1725
	mv	a1,s4	#, tmp1731
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	s6,0(sp)		# tmp2004, %sfp
	lw	a0,284(s6)		#, MEM[(struct point *)&right_bottom].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s8)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2258
	call	__floatsisf		#
	mv	s10,a0	# tmp2259,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,288(s6)		#, MEM[(struct point *)&right_bottom].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s8)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2260
	call	__floatsisf		#
	mv	s4,a0	# tmp2261,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,296(s6)		#, MEM[(struct point *)&right_bottom + 12B].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s8)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2262
	call	__floatsisf		#
	mv	s11,a0	# tmp2263,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,300(s6)		#, MEM[(struct point *)&right_bottom + 12B].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s8)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2264
	call	__floatsisf		#
	mv	s8,a0	# tmp2265,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,280(s6)		#, MEM[(struct point *)&right_bottom].x
	call	__floatsisf		#
	lui	a5,%hi(.LC8)	# tmp2510,
	lw	a1,%lo(.LC8)(a5)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2266
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	s6,a0	# tmp2267,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _2556
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s4	#, _2558
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,12(sp)	# tmp1775, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a5,12(sp)		# tmp1775, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2269,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a5	#, tmp1775
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2270,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s6	#, tmp1774
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2271
	call	__floatsisf		#
	mv	s6,a0	# tmp2272,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _2556
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp1787, tmp2273
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s4	#, _2558
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2274,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s10	#, tmp1787
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2511,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2275
	call	__floatsisf		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a5,0(sp)		# tmp2004, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s4,a0	# tmp2276,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,292(a5)		#, MEM[(struct point *)&right_bottom + 12B].x
	call	__floatsisf		#
	lui	a5,%hi(.LC8)	# tmp2513,
	lw	a1,%lo(.LC8)(a5)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2277
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp2278,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s11	#, _2516
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _2518
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	sw	a0,12(sp)	# tmp1803, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	lw	a5,12(sp)		# tmp1803, %sfp
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,a0	# tmp2280,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,a5	#, tmp1803
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2281,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s10	#, tmp1802
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2282
	call	__floatsisf		#
	mv	s10,a0	# tmp2283,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s11	#, _2516
	mv	a0,s3	#, cos_theta
	call	__mulsf3		#
	mv	s11,a0	# tmp1815, tmp2284
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s8	#, _2518
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2285,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s11	#, tmp1815
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	a4,%hi(.LC7)	# tmp2514,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2286
	call	__floatsisf		#
	mv	s8,a0	# tmp2287,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s10	#, _2356
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	s11,a0	# tmp1822, tmp2288
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s8	#, _2358
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2289,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp1822
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2515,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2290,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s10	#, _2356
	mv	a0,s7	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s10,a5	# tmp1827, tmp2290
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1828, tmp2291
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s8	#, _2358
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2292,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, tmp1828
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
	mv	s8,a0	# tmp2293,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s6	#, _2396
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	s11,a0	# tmp1834, tmp2294
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, _2398
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2295,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s11	#, tmp1834
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lui	a4,%hi(.LC7)	# tmp2516,
	lw	a1,%lo(.LC7)(a4)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
	mv	a5,a0	# tmp2296,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s6	#, _2396
	mv	a0,s7	#, cos_theta
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s6,a5	# tmp1839, tmp2296
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__mulsf3		#
	mv	s11,a0	# tmp1840, tmp2297
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _2398
	mv	a0,s9	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2298,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s11	#, tmp1840
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s11,%hi(.LC8)	# tmp2518,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	mv	a3,s10	#, tmp1827
	mv	a2,s8	#, tmp1833
	mv	a1,s6	#, tmp1839
	call	fb_draw_bresenham.constprop.0		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	s4,0(sp)		# tmp2004, %sfp
	lw	a0,308(s4)		#, MEM[(struct point *)&right_top].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2299
	call	__floatsisf		#
	mv	s10,a0	# tmp2300,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,312(s4)		#, MEM[(struct point *)&right_top].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2301
	call	__floatsisf		#
	mv	s9,a0	# tmp2302,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,320(s4)		#, MEM[(struct point *)&right_top + 12B].y
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-60	#,, tmp2303
	call	__floatsisf		#
	mv	s8,a0	# tmp2304,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,324(s4)		#, MEM[(struct point *)&right_top + 12B].z
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2305
	call	__floatsisf		#
	mv	s6,a0	# tmp2306,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,304(s4)		#, MEM[(struct point *)&right_top].x
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2307
	call	__floatsisf		#
	mv	a1,s5	#, cos_theta
	call	__mulsf3		#
	mv	s4,a0	# tmp2308,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s10	#, _3044
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	s11,a0	# tmp1883, tmp2309
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s9	#, _3046
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2310,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s11	#, tmp1883
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2311,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s4	#, tmp1882
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lui	s11,%hi(.LC8)	# tmp2529,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2312
	call	__floatsisf		#
	mv	s4,a0	# tmp2313,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s10	#, _3044
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s10,a0	# tmp1895, tmp2314
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s9	#, _3046
	mv	a0,s1	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2315,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s10	#, tmp1895
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lui	s10,%hi(.LC7)	# tmp2527,
	lw	a1,%lo(.LC7)(s10)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2316
	call	__floatsisf		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a5,0(sp)		# tmp2004, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s1,a0	# tmp2317,
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	lw	a0,316(a5)		#, MEM[(struct point *)&right_top + 12B].x
	call	__floatsisf		#
	lw	a1,%lo(.LC8)(s11)		#,
	call	__mulsf3		#
# gfx_lib_hdmi.h:251:   point transformed = {p->x*sx, p->y*sy, p->z*sz};
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	addi	a0,a0,-20	#,, tmp2318
	call	__floatsisf		#
	mv	a1,s3	#, cos_theta
	call	__mulsf3		#
	mv	s3,a0	# tmp2319,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s8	#, _3004
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,s6	#, _3006
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	s9,a0	# tmp1911, tmp2320
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2321,
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a0,s9	#, tmp1911
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	mv	a1,zero	#,
	call	__addsf3		#
# gfx_lib_hdmi.h:271:   transformed.z = pivot->z + (shifted_point.y*sin_theta + shifted_point.z*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__floatsisf		#
	mv	a1,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2322,
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	mv	a0,s3	#, tmp1910
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:284:   transformed.x = pivot->x + (shifted_point.x*cos_theta + shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-40	#,, tmp2323
	call	__floatsisf		#
	mv	s3,a0	# tmp2324,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s8	#, _3004
	mv	a0,s5	#, cos_theta
	call	__mulsf3		#
	mv	s5,a0	# tmp1923, tmp2325
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a1,s6	#, _3006
	mv	a0,s0	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2326,
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	mv	a0,s5	#, tmp1923
	call	__subsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	lw	a1,%lo(.LC7)(s10)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:270:   transformed.y = pivot->y + (shifted_point.y*cos_theta - shifted_point.z*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	addi	a0,a0,-30	#,, tmp2327
	call	__floatsisf		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	s6,8(sp)		# sin_theta, %sfp
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s0,a0	# tmp2328,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s3	#, _2844
	mv	a0,s6	#, sin_theta
	call	__mulsf3		#
	mv	s5,a0	# tmp1930, tmp2329
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s0	#, _2846
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2330,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s5	#, tmp1930
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a1,%lo(.LC7)(s10)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s3	#, _2844
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s5,a0	# tmp2331,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	s3,a0	# tmp1936, tmp2332
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s0	#, _2846
	mv	a0,s6	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2333,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s3	#, tmp1936
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s4	#, _2884
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	s3,a0	# tmp2334,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s6	#, sin_theta
	call	__mulsf3		#
	mv	s0,a0	# tmp1942, tmp2335
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a1,s1	#, _2886
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2336,
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	a0,s0	#, tmp1942
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	lw	a1,%lo(.LC7)(s10)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	call	__fixsfsi		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s4	#, _2884
# gfx_lib_hdmi.h:300:   transformed.y = pivot->y + (shifted_point.x*sin_theta + shifted_point.y*cos_theta);
	mv	s0,a0	# tmp2337,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s7	#, cos_theta
	call	__mulsf3		#
	mv	s4,a0	# tmp1948, tmp2338
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a1,s1	#, _2886
	mv	a0,s6	#, sin_theta
	call	__mulsf3		#
	mv	a1,a0	# tmp2339,
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	mv	a0,s4	#, tmp1948
	call	__subsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	lw	a1,%lo(.LC5)(s2)		#,
	call	__addsf3		#
# gfx_lib_hdmi.h:299:   transformed.x = pivot->x + (shifted_point.x*cos_theta - shifted_point.y*sin_theta);
	call	__fixsfsi		#
# main_cube3d_rotate_hdmi.c:94:     fb_draw_bresenham(framebuffer, p0.x, p0.y, p1.x, p1.y, 0x00ffff);
	mv	a3,s5	#, tmp1935
	mv	a2,s3	#, tmp1941
	mv	a1,s0	#, tmp1947
	call	fb_draw_bresenham.constprop.0		#
# main_cube3d_rotate_hdmi.c:126:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	li	a5,805306368		# tmp1955,
# main_cube3d_rotate_hdmi.c:126:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	lw	a5,36(a5)		# MEM[(uint32_t *)805306404B], MEM[(uint32_t *)805306404B]
	li	a4,268435456		# prephitmp_719,
	andi	a5,a5,1	#, tmp1956, MEM[(uint32_t *)805306404B]
# main_cube3d_rotate_hdmi.c:126:     oled_show_fb_8or16(framebuffer, 0x10000000 + ((*fb_ctrl & 1) ? 0 : (8192*4)), 1);
	bne	a5,zero,.L548	#, tmp1956,,
	li	a4,268468224		# prephitmp_719,
.L548:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	lw	a2,84(sp)		# framebuffer.52_26, %sfp
	li	a5,805306368		# tmp1959,
# main_cube3d_rotate_hdmi.c:127:     *fb_ctrl ^= 1;
	lw	a3,36(a5)		# MEM[(uint32_t *)805306404B], MEM[(uint32_t *)805306404B]
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	sw	a2,44(a5)	# framebuffer.52_26, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	a4,48(a5)	# prephitmp_719, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp1965,
	addi	a4,a4,704	#, tmp1964, tmp1965
	sw	a4,52(a5)	# tmp1964, MEM[(volatile uint32_t *)805306420B]
# main_cube3d_rotate_hdmi.c:127:     *fb_ctrl ^= 1;
	xori	a4,a3,1	#, tmp1973, MEM[(uint32_t *)805306404B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a3,1		# tmp1968,
	sw	a3,56(a5)	# tmp1968, MEM[(volatile uint32_t *)805306424B]
# main_cube3d_rotate_hdmi.c:127:     *fb_ctrl ^= 1;
	sw	a4,36(a5)	# tmp1973, MEM[(uint32_t *)805306404B]
# main_cube3d_rotate_hdmi.c:130:     angle += delta_angle;
	lw	a5,72(sp)		# angle, %sfp
	addi	a5,a5,-2	#, angle, angle
	sw	a5,72(sp)	# angle, %sfp
# main_cube3d_rotate_hdmi.c:133:     if (angle < 0) angle = 359;
	bge	a5,zero,.L549	#, angle,,
# main_cube3d_rotate_hdmi.c:133:     if (angle < 0) angle = 359;
	li	a5,359		# angle,
	sw	a5,72(sp)	# angle, %sfp
.L549:
# kianv_stdlib.h:51:   *( (volatile uint32_t*) DMA_SRC  ) = src;
	lw	a4,84(sp)		# framebuffer.52_26, %sfp
	li	a5,805306368		# tmp1976,
	sw	a4,44(a5)	# framebuffer.52_26, MEM[(volatile uint32_t *)805306412B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	li	a4,4096		# tmp1982,
# kianv_stdlib.h:52:   *( (volatile uint32_t*) DMA_DST  ) = dst;
	sw	zero,48(a5)	#, MEM[(volatile uint32_t *)805306416B]
# kianv_stdlib.h:53:   *( (volatile uint32_t*) DMA_LEN  ) = len;
	addi	a4,a4,704	#, tmp1981, tmp1982
	sw	a4,52(a5)	# tmp1981, MEM[(volatile uint32_t *)805306420B]
# kianv_stdlib.h:54:   *( (volatile uint32_t*) DMA_CTRL ) = ctrl;
	li	a4,2		# tmp1985,
	sw	a4,56(a5)	# tmp1985, MEM[(volatile uint32_t *)805306424B]
# main_cube3d_rotate_hdmi.c:147:     led &= 7;
	lw	a4,80(sp)		# led, %sfp
# main_cube3d_rotate_hdmi.c:146:     IO_OUT(GPIO_OUTPUT, 0);
	sw	zero,28(a5)	#, MEM[(volatile uint32_t *)805306396B]
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	lw	a2,28(a5)		# _3212, MEM[(volatile uint32_t *)805306396B]
# main_cube3d_rotate_hdmi.c:147:     led &= 7;
	andi	a3,a4,7	#, led, led
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	li	a4,1		# tmp1993,
	sll	a4,a4,a3	# led, tmp1992, tmp1993
# main_cube3d_rotate_hdmi.c:149:     gpio_set_value(led++, 1);
	addi	a3,a3,1	#, led, led
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	or	a4,a4,a2	# _3212, _3216, tmp1992
# main_cube3d_rotate_hdmi.c:149:     gpio_set_value(led++, 1);
	sw	a3,80(sp)	# led, %sfp
# kianv_stdlib.h:125:       *p |=  (0x01 << (gpio & 0x1f));
	sw	a4,28(a5)	# _3216, MEM[(volatile uint32_t *)805306396B]
	j	.L550		#
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
	.word	1109393408
	.align	2
.LC6:
	.word	1097859072
	.align	2
.LC7:
	.word	1106247680
	.align	2
.LC8:
	.word	1082130432
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
