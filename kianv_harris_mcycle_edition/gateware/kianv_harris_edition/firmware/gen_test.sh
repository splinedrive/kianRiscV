#!/bin/bash -x
BASENAME=`basename -s .S $1`
#/opt/riscv32im/bin/riscv32-unknown-elf-gcc -c -mabi=ilp32 \
#  -ffreestanding -nostdlib \
#  -Wl,--build-id=none,-Bstatic,-T,sections.lds,-Map,firmware.map,--strip-debug \
#  -march=rv32im -o $BASENAME.elf -DTEST_FUNC_NAME="$BASENAME" \
#  -DTEST_FUNC_TXT="\"$BASENAME\"" -DTEST_FUNC_RET="$BASENAME"_ret $1 -lgcc

/opt/riscv32im/bin/riscv32-unknown-elf-gcc  -mabi=ilp32 \
  -ffreestanding -nostdlib \
  -Wl,--build-id=none,-Bstatic,-T,sections.lds,-Map,firmware.map,--strip-debug \
  -march=rv32im -o $BASENAME.elf -DTEST_FUNC_NAME="$BASENAME" \
  -DTEST_FUNC_TXT="\"$BASENAME\"" -DTEST_FUNC_RET="$BASENAME"_ret $1 -lgcc

/opt/riscv32im/bin/riscv32-unknown-elf-objcopy -O binary $BASENAME.elf $BASENAME.bin
cp $BASENAME.elf firmware.elf
./makehex.py $BASENAME.bin $((8192*4)) > $BASENAME.hex                                                                                     
cp -v $BASENAME.hex firmware.hex
