all: firmware.hex

clean:
	rm -f firmware.hex firmware.elf firmware.bin

firmware.elf: sections.lds start.s firmware.c
	riscv32-unknown-elf-gcc -mabi=ilp32 -march=rv32i -Wl,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib -o firmware.elf start.s firmware.c

firmware.bin: firmware.elf
	riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin

firmware.hex: firmware.bin
	python3 makehex.py $^ 8192 > $@

