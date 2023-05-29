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
RVGCC_LIB="/opt/riscv32im/riscv32-unknown-elf/lib/libc.a /opt/riscv32im/riscv32-unknown-elf/lib/libm.a /opt/riscv32im/lib/gcc/riscv32-unknown-elf/last/libgcc.a"
RVCPPFLAGS="-fno-exceptions -fno-enforce-eh-specs "
RVLDFLAGS="-m elf32lriscv -b elf32-littleriscv --no-relax "
RVCFLAGS="-fno-pic -march=rv32ima -mabi=ilp32  -fno-stack-protector -w -Wl,--no-relax -ffreestanding -Wl,--strip-debug,-Map=firmware.map,-nostartfiles"
/opt/riscv32im/bin/riscv32-unknown-elf-as crt0.S -o crt0.o
/opt/riscv32im/bin/riscv32-unknown-elf-gcc -S -fverbose-asm  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE -c
/opt/riscv32im/bin/riscv32-unknown-elf-as -alhnd "$FILEwoSUFFIX.s"  > "$FILEwoSUFFIX.lst"
/opt/riscv32im/bin/riscv32-unknown-elf-gcc  $OPT_LEVEL $RVCFLAGS -I$INCLUDE_DIR $FILE $RVGCC_LIB $START_FILE -c
/opt/riscv32im/bin/riscv32-unknown-elf-ld $RVLDFLAGS -T$LDS_FILE -o firmware.elf $FILEwoSUFFIX.o $RVGCC_LIB
/opt/riscv32im/bin/riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
/opt/riscv32im/bin/riscv32-unknown-elf-objdump -d -M no-aliases ./firmware.elf
