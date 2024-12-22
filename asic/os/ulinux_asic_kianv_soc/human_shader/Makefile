all : human_shader

PREFIX:=../buildroot/output/host/bin/riscv32-buildroot-linux-uclibc-
CC:=$(PREFIX)gcc
OBJDUMP:=$(PREFIX)objdump

# Note:  regymm says to do -fPIE -pie -static, instead of -fPIC
CFLAGS:=-mabi=ilp32 -fPIE -pie -static -march=rv32ima -Os -s -g -ffunction-sections -fdata-sections
LDFLAGS:=-Wl,-elf2flt=-r -Wl,-gc-sections

C_S+=human_shader.c

test : deploy
	make -C .. toolchain
	make -C ../mini-rv32ima mini-rv32ima
	../mini-rv32ima/mini-rv32ima -f ../buildroot/output/images/Image

human_shader : human_shader.c
	$(CC) $(CFLAGS) $(C_S) $(LDFLAGS) -o $@
	$(OBJDUMP) -S $@.gdb > $@.S

deploy : human_shader
	cp $^ ../buildroot/output/target/root

rebuild :
	make -C.. toolchain 

clean :
	rm -rf human_shader human_shader.gdb human_shader.S
