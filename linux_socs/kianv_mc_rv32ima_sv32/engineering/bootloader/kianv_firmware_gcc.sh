#!/bin/bash
LDS_FILE=$1
START_FILE=crt0.S
INCLUDE_DIR=.
FILE=$2
if [[ -z $OPT_LEVEL ]]
then
  OPT_LEVEL=-Os
fi
FILEwoSUFFIX=`echo $FILE | cut -d '.' -f1`
rm -f firmware.elf
RVCPPFLAGS="-fno-exceptions -fno-enforce-eh-specs "
RVLDFLAGS="-Wl,-melf32lriscv -Wl,-belf32-littleriscv -Wl,--no-relax"
RVCFLAGS="-fno-pic -march=rv32ima -mabi=ilp32  -fno-stack-protector -w -Wl,--no-relax -ffreestanding -Wl,--strip-debug,-Map=firmware.map -nostartfiles"
riscv32-unknown-elf-as crt0.S -o crt0.o
riscv32-unknown-elf-gcc -S -fverbose-asm  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $START_FILE -c
riscv32-unknown-elf-as -alhnd "$FILEwoSUFFIX.s"  > "$FILEwoSUFFIX.lst"
riscv32-unknown-elf-gcc  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $START_FILE -c
riscv32-unknown-elf-gcc $OPT_LEVEL $RVCFLAGS $RVLDFLAGS -T$LDS_FILE -o firmware.elf crt0.o $FILEwoSUFFIX.o -lc -lm -lgcc
riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
#riscv32-unknown-elf-objdump -d -M no-aliases ./firmware.elf

