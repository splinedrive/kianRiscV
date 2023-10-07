riscv32-unknown-elf-as --march=rv32im $1 -o firmware.elf
riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
riscv32-unknown-elf-objdump -d -M no-aliases ./firmware.elf
./makehex.py firmware.bin $((512)) > firmware.hex


