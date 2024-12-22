# SPDX-FileCopyrightText: © 2023 Uri Shaked   <uri@wokwi.com>
#                           2023/2024 Hirosh Dabui <hirosh@dabui.de>
# SPDX-License-Identifier: MIT

TOOLCHAIN_PATH ?= ../buildroot/output/host/bin

TOOLCHAIN_PREFIX ?= $(TOOLCHAIN_PATH)/riscv32-buildroot-linux-uclibc

CPU_FREQ ?= 31500000
SPI_FREQ ?= 10000000
BAUDRATE ?= 3000000
IMAGE_SIZE ?= $(shell wc -c < ../Image)
SOC_HAS_SPI ?= 0

LDS_FILE ?= kianv.ld
START_FILE = crt0.S
INCLUDE_DIR = .
FILE = bootloader.c
OPT_LEVEL ?= -Os
FILEwoSUFFIX = $(basename $(FILE))
RVCPPFLAGS = -fno-exceptions -fno-enforce-eh-specs
RVLDFLAGS = -Wl,-melf32lriscv -Wl,-belf32-littleriscv -Wl,--no-relax
RVCFLAGS = -fno-pic -march=rv32ima -mabi=ilp32 -fno-stack-protector -w -Wl,--no-relax -ffreestanding -Wl,--strip-debug,-Map=bootloader.map
RVCFLAGS += -nostartfiles -DCPU_FREQ=$(CPU_FREQ) -DSPI_FREQ=$(SPI_FREQ) -DBAUDRATE=$(BAUDRATE)
RVCFLAGS += -DIMAGE_SIZE=$(IMAGE_SIZE) -DSOC_HAS_SPI=$(SOC_HAS_SPI) -Wl,--no-warn-rwx-segments

all: bootloader.bin
	@echo "Image size is $(IMAGE_SIZE) bytes"

crt0.o: $(START_FILE)
	$(TOOLCHAIN_PREFIX)-as $(START_FILE) -o crt0.o

$(FILEwoSUFFIX).s: $(FILE)
	$(TOOLCHAIN_PREFIX)-gcc -S -fverbose-asm $(OPT_LEVEL) $(RVCFLAGS) -I$(INCLUDE_DIR) $< $(START_FILE) -c

$(FILEwoSUFFIX).lst: $(FILEwoSUFFIX).s
	$(TOOLCHAIN_PREFIX)-as -alhnd $< > $@

$(FILEwoSUFFIX).o: $(FILE)
	$(TOOLCHAIN_PREFIX)-gcc $(OPT_LEVEL) $(RVCFLAGS) -I$(INCLUDE_DIR) $< $(START_FILE) -c

bootloader.elf: crt0.o $(FILEwoSUFFIX).o
	$(TOOLCHAIN_PREFIX)-gcc $(OPT_LEVEL) $(RVCFLAGS) $(RVLDFLAGS) -T$(LDS_FILE) -o $@ crt0.o $(FILEwoSUFFIX).o -lc -lm -lgcc

bootloader.bin: bootloader.elf
	$(TOOLCHAIN_PREFIX)-objcopy -O binary $< $@

clean:
	rm -f *.o *.elf *.bin *.s *.map

.PHONY: all clean help

