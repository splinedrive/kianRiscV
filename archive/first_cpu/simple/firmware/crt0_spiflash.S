#.include "femtorv32.inc"
# taken and adjusted from his project https://github.com/BrunoLevy/learn-fpga
.text
.global _start
.type _start, @function

_start:
.option push
.option norelax
#     li gp,IO_BASE       #   Base address of memory-mapped IO
.option pop

#     li   t0,IO_HW_CONFIG_RAM  # Can't use IO_HW_CONFIG_RAM(gp) (too far away !)
#     add  t0,t0,gp             # Read RAM size in hw config register and
#     lw   sp,0(t0)             # initialize SP at end of RAM
#     li   t0,0                 # reset t0 to 0
# icebreaker, icoboard
#lui sp, %hi(8192);
#addi sp, sp, %lo(8192);
#la sp, __stacktop
lui sp, %hi(__stacktop);
addi sp, sp, %lo(__stacktop);
#srli sp,sp,2


# icoboard
#lui sp,      %hi(0x10000000 + 1024*1024);
#addi sp, sp, %lo(0x10000000 + 1024*1024);

#ifdef ULX3S
#lui sp,      %hi(0x00000000 + 393216/4)
#addi sp, sp, %lo(0x00000000 + 393216/4)
#endif

# zero-init bss section:
# clears from _sbss to _ebss
# _sbss and _ebss are defined by linker script (spi_flash.ld)
     la a0, _sbss
     la a1, _ebss
     bge a0, a1, end_init_bss
loop_init_bss:
     sw zero, 0(a0)
     addi a0, a0, 4
     blt a0, a1, loop_init_bss
end_init_bss:

# copy data section from SPI Flash to BRAM:
# copies from _sidata (in flash) to _sdata ... _edata (in BRAM)
# _sidata, _sdata and _edata are defined by linker script (spi_flash.ld)
     la a0, _sidata
     la a1, _sdata
     la a2, _edata
     bge a1, a2, end_init_data
loop_init_data:
     lw a3, 0(a0)
     sw a3, 0(a1)
     addi a0, a0, 4
     addi a1, a1, 4
     blt a1, a2, loop_init_data
end_init_data:

     call main
loop:
        j loop
.balign 4
#   tail exit


