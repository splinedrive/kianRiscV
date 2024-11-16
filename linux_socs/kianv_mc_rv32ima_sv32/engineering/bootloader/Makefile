#
# kianv.v - RISC-V rv32ima
#
# copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
#
# permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# the software is provided "as is" and the author disclaims all warranties
# with regard to this software including all implied warranties of
# merchantability and fitness. in no event shall the author be liable for
# any special, direct, indirect, or consequential damages or any damages
# whatsoever resulting from loss of use, data or profits, whether in an
# action of contract, negligence or other tortious action, arising out of
# or in connection with the use or performance of this software.
#

# Define source files
OBJS = start.S custom_stdlib.c kianv_io_utils.c bootloader.c sd.c spi.c timer.c

# Define the toolchain prefix (adjust as needed)
TOOLPREFIX = riscv32-buildroot-linux-gnu-

# Find libgcc path automatically
LIBGCC := $(shell $(TOOLPREFIX)gcc -print-libgcc-file-name)

# Compiler and linker flags
CFLAGS = -Wall -Os -march=rv32ima_zicsr -mabi=ilp32 --freestanding -nostartfiles -fno-stack-protector -fno-pic -fno-common -fno-builtin
LDFLAGS = -T riscv.ld -static -nostdlib -L$(dir $(LIBGCC)) -lgcc -Wl,--no-dynamic-linker -Wl,-z,norelro -Wl,--disable-new-dtags

# Define the compiler and linker
CC = $(TOOLPREFIX)gcc
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

# Default target
all: firmware

# Compile and link to generate the ELF file
firmware.elf: $(OBJS) riscv.ld
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)

# Generate hex file from ELF file
firmware.hex: firmware.elf
	$(OBJCOPY) firmware.elf -O binary firmware.bin
	xxd -e firmware.bin | cut -c 11-46 > firmware.hex

# Disassemble ELF file for debugging
%.obj: %.elf
	$(OBJDUMP) -d $<

# Main target to generate hex file
firmware: firmware.hex
	./split_firmware.py

# Clean up generated files
clean:
	rm -f *.elf *.o *.hex firmware.hex firmware.bin

.PHONY: all clean

