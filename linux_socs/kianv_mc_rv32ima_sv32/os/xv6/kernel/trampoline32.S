        #
        # low-level code to handle traps from user space into
        # the kernel, and returns from kernel to user.
        #
        # the kernel maps the page holding this code
        # at the same virtual address (TRAMPOLINE)
        # in user and kernel space so that it continues
        # to work when it switches page tables.
        # kernel.ld causes this code to start at
        # a page boundary.
        #

#include "riscv.h"
#include "memlayout.h"

.section trampsec
.globl trampoline
trampoline:
.align 4
.globl uservec
uservec:
	#
        # trap.c sets stvec to point here, so
        # traps from user space start here,
        # in supervisor mode, but with a
        # user page table.
        #

        # save user a0 in sscratch so
        # a0 can be used to get at TRAPFRAME.
        csrw sscratch, a0

        # each process has a separate p->trapframe memory area,
        # but it's mapped to the same virtual address
        # (TRAPFRAME) in every process's user page table.
        li a0, TRAPFRAME

        # save the user registers in TRAPFRAME
        sw ra, 20(a0)
        sw sp, 24(a0)
        sw gp, 28(a0)
        sw tp, 32(a0)
        sw t0, 36(a0)
        sw t1, 40(a0)
        sw t2, 44(a0)
        sw s0, 48(a0)
        sw s1, 52(a0)
        sw a1, 60(a0)
        sw a2, 64(a0)
        sw a3, 68(a0)
        sw a4, 72(a0)
        sw a5, 76(a0)
        sw a6, 80(a0)
        sw a7, 84(a0)
        sw s2, 88(a0)
        sw s3, 92(a0)
        sw s4, 96(a0)
        sw s5, 100(a0)
        sw s6, 104(a0)
        sw s7, 108(a0)
        sw s8, 112(a0)
        sw s9, 116(a0)
        sw s10, 120(a0)
        sw s11, 124(a0)
        sw t3, 128(a0)
        sw t4, 132(a0)
        sw t5, 136(a0)
        sw t6, 140(a0)

	# save the user a0 in p->trapframe->a0
        csrr t0, sscratch
        sw t0, 56(a0)

        # initialize kernel stack pointer, from p->trapframe->kernel_sp
        lw sp, 4(a0)

        # make tp hold the current hartid, from p->trapframe->kernel_hartid
        lw tp, 16(a0)

        # load the address of usertrap(), from p->trapframe->kernel_trap
        lw t0, 8(a0)


        # fetch the kernel page table address, from p->trapframe->kernel_satp.
        lw t1, 0(a0)

        # wait for any previous memory operations to complete, so that
        # they use the user page table.
        sfence.vma zero, zero

        # install the kernel page table.
        csrw satp, t1

        # flush now-stale user entries from the TLB.
        sfence.vma zero, zero

        # jump to usertrap(), which does not return
        jr t0

.globl userret
userret:
        # userret(pagetable)
        # called by usertrapret() in trap.c to
        # switch from kernel to user.
        # a0: user page table, for satp.

        # switch to the user page table.
        sfence.vma zero, zero
        csrw satp, a0
        sfence.vma zero, zero

        li a0, TRAPFRAME

        # restore all but a0 from TRAPFRAME
        lw ra, 20(a0)
        lw sp, 24(a0)
        lw gp, 28(a0)
        lw tp, 32(a0)
        lw t0, 36(a0)
        lw t1, 40(a0)
        lw t2, 44(a0)
        lw s0, 48(a0)
        lw s1, 52(a0)
        lw a1, 60(a0)
        lw a2, 64(a0)
        lw a3, 68(a0)
        lw a4, 72(a0)
        lw a5, 76(a0)
        lw a6, 80(a0)
        lw a7, 84(a0)
        lw s2, 88(a0)
        lw s3, 92(a0)
        lw s4, 96(a0)
        lw s5, 100(a0)
        lw s6, 104(a0)
        lw s7, 108(a0)
        lw s8, 112(a0)
        lw s9, 116(a0)
        lw s10, 120(a0)
        lw s11, 124(a0)
        lw t3, 128(a0)
        lw t4, 132(a0)
        lw t5, 136(a0)
        lw t6, 140(a0)

	# restore user a0
        lw a0, 56(a0)

        # return to user mode and user pc.
        # usertrapret() set up sstatus and sepc.
        sret
