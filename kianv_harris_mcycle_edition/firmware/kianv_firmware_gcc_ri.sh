#!/bin/bash

LDS_FILE=$1
#LDS_FILE=spi_nor.ld
#LDS_FILE=spi_nor2sram.ld
#LDS_FILE=spi_nor2spram.ld
#LDS_FILE=spi_nor2bram.ld
START_FILE=crt0_spiflash.S
#LDS_FILE=sections.ld
#LDS_FILE=firmware.ld
#START_FILE=firmware.S
INCLUDE_DIR=.
FILE=$2
if [[ -z $OPT_LEVEL ]]
then
  OPT_LEVEL=-Os
fi
FILEwoSUFFIX=`echo $FILE | cut -d '.' -f1`
rm -f firmware.elf
RVGCC_LIB="/opt/riscv32i/riscv32-unknown-elf/lib/libc.a /opt/riscv32i/riscv32-unknown-elf/lib/libm.a /opt/riscv32i/lib/gcc/riscv32-unknown-elf/last/libgcc.a"
RVCPPFLAGS="-fno-exceptions -fno-enforce-eh-specs "
RVLDFLAGS="-m elf32lriscv -b elf32-littleriscv --no-relax "
RVCFLAGS="-fno-pic -march=rv32i -mabi=ilp32  -fno-stack-protector -w -Wl,--no-relax -ffreestanding -Wl,--strip-debug,-Map=firmware.map,-nostartfiles"
#/opt/riscv32i/bin/riscv32-unknown-elf-gcc $OPT_LEVEL -march=rv32i -mabi=ilp32 -nostartfiles -Wl,-Bstatic,-T,$LDS_FILE,--strip-debug,-Map=firmware.map,--cref -lsupc++ -fno-zero-initialized-in-bss -ffreestanding -o firmware.elf -I$INCLUDE_DIR  $START_FILE $FILE -lm
#/opt/riscv32i/bin/riscv32-unknown-elf-gcc $OPT_LEVEL -march=rv32i -mabi=ilp32 -nostartfiles -Wl,-Bstatic,-T,$LDS_FILE,--strip-debug,-Map=firmware.map,--cref -lsupc++ -fno-zero-initialized-in-bss -ffreestanding -o firmware.elf -I$INCLUDE_DIR  $START_FILE $FILE -lm
/opt/riscv32i/bin/riscv32-unknown-elf-as crt0_spiflash.S -o crt0_spiflash.o
/opt/riscv32i/bin/riscv32-unknown-elf-gcc -S -fverbose-asm  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE -c
/opt/riscv32i/bin/riscv32-unknown-elf-as -alhnd "$FILEwoSUFFIX.s"  > "$FILEwoSUFFIX.lst"
/opt/riscv32i/bin/riscv32-unknown-elf-gcc  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE -c
#/opt/riscv32i/bin/riscv32-unknown-elf-g++ $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE -c
/opt/riscv32i/bin/riscv32-unknown-elf-ld $RVLDFLAGS -T$LDS_FILE -o firmware.elf $FILEwoSUFFIX.o $RVGCC_LIB
/opt/riscv32i/bin/riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
/opt/riscv32i/bin/riscv32-unknown-elf-objdump -d -M no-aliases ./firmware.elf
#/opt/riscv32i/bin/riscv32-unknown-elf-gcc -Wa,-adhln -g -T$LDS_FILE $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE > $FILEwoSUFFIX.S
#./makehex.py firmware.bin 8192  > firmware.hex
./makehex.py firmware.bin 40000 > firmware.hex

#/opt/riscv32i/bin/riscv32-unknown-elf-as -alhnd $FILE
#/opt/riscv32i/bin/riscv32-unknown-elf-objcopy -O verilog firmware.elf firmware.hex && /opt/riscv32i/bin/riscv32-unknown-elf-objdump -d ./firmware.elf
#/opt/riscv32i/bin/riscv32-unknown-elf-gcc -Wa,-adhln -g -march=rv32i -mabi=ilp32 -nostartfiles -Wl,-Bstatic,-T,$LDS_FILE,--strip-debug,-Map=firmware.map,--cref -fno-zero-initialized-in-bss -ffreestanding -nostdlib -o firmware.elf -I$INCLUDE_DIR  $START_FILE $FILE
        # Note: --no-relax because I'm using gp for fast access to mapped IO.
#RVASFLAGS=-march=$(ARCH) -mabi=$(ABI) $(DEVICES_ASM) $(RVINCS)


#/opt/riscv32i/bin/riscv32-unknown-elf-gcc $OPT_LEVEL $RVCFLAGS  $FILE -Wl,-gc-sections,--strip-debug -o firmware.elf
#/opt/riscv32i/bin/riscv32-unknown-elf-ld	$RVLDFLAGS -T$LDS_FILE main_mandel_float.o -o firmware.elf $RVGCC_LIB
#/opt/riscv32i/bin/riscv32-unknown-elf-strip --strip-all firmware.elf
#/opt/riscv32i/bin/riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
