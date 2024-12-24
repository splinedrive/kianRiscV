# Toolchain configuration
TOOLCHAIN_DIR := ./riscv32ima-sv32-toolchain
TOOLPREFIX    := $(TOOLCHAIN_DIR)/bin/riscv32-unknown-elf-
LIBGCC        := $(shell $(TOOLPREFIX)gcc -print-libgcc-file-name)

K=kernel
U=user

OBJS = \
  $K/entry32.o \
  $K/start.o \
  $K/console.o \
  $K/printf.o \
  $K/uart.o \
  $K/kalloc.o \
  $K/spinlock.o \
  $K/string.o \
  $K/main.o \
  $K/vm.o \
  $K/proc.o \
  $K/swtch.o \
  $K/trampoline.o \
  $K/trap.o \
  $K/syscall.o \
  $K/sysproc.o \
  $K/bio.o \
  $K/fs.o \
  $K/log.o \
  $K/sleeplock.o \
  $K/file.o \
  $K/pipe.o \
  $K/exec.o \
  $K/sysfile.o \
  $K/kernelvec.o \
  $K/plic.o \
  $K/sdcard.o \

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

CFLAGS = -Wall -Werror -O -fno-omit-frame-pointer #-ggdb -gdwarf-2
CFLAGS += -march=rv32ima_zicsr
CFLAGS += -mabi=ilp32
CFLAGS += -mcmodel=medany
CFLAGS += -ffreestanding -nostdlib -mno-relax -fno-stack-protector #-fno-common #-s
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -I.

LDFLAGS = -z max-page-size=4096 --gc-sections#-s

$K/kernel: $(OBJS) $K/kernel.ld $U/initcode
	$(LD) $(LDFLAGS) -T$K/kernel.ld -o $K/kernel $(OBJS) $(LIBGCC)
	$(OBJDUMP) -S $K/kernel > $K/kernel.asm
	$(OBJDUMP) -t $K/kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $K/kernel.sym

$U/initcode: $U/initcode.S
	$(CC) $(CFLAGS) -nostdinc -I. -I$K -c $U/initcode.S -o $U/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o $U/initcode.out $U/initcode.o $(LIBGCC)
	$(OBJCOPY) -S -O binary $U/initcode.out $U/initcode
	$(OBJDUMP) -S $U/initcode.o > $U/initcode.asm

tags:
	ctags kernel/*.S kernel/*.c

$K/entry.o:	$K/entry32.S
	$(CC) $(CFLAGS) -c -o $K/entry.o $K/entry32.S
$K/swtch.o:	$K/swtch32.S
	$(CC) $(CFLAGS) -c -o $K/swtch.o $K/swtch32.S
$K/trampoline.o:	$K/trampoline32.S
	$(CC) $(CFLAGS) -c -o $K/trampoline.o $K/trampoline32.S
$K/kernelvec.o:	$K/kernelvec32.S
	$(CC) $(CFLAGS) -c -o $K/kernelvec.o $K/kernelvec32.S

ULIB = $U/ulib.o $U/usys.o $U/printf.o $U/umalloc.o

_%: %.o $(ULIB)
	$(LD) $(LDFLAGS) -T $U/user.ld -o $@ $^
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym

$U/usys.S : $U/usys.pl
	perl $U/usys.pl > $U/usys.S

$U/usys.o : $U/usys.S
	$(CC) $(CFLAGS) -c -o $U/usys.o $U/usys.S

$U/_forktest: $U/forktest.o $(ULIB)
	# forktest has less library code linked in - needs to be small
	# in order to be able to max out the proc table.
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $U/_forktest $U/forktest.o $U/ulib.o $U/usys.o  -L$(LIBGCC) #-lgcc
	$(OBJDUMP) -S $U/_forktest > $U/forktest.asm

mkfs/mkfs: mkfs/mkfs.c $K/fs.h
	gcc -Werror -Wall -I. -o mkfs/mkfs mkfs/mkfs.c

# Prevent deletion of intermediate files, e.g. cat.o, after first build, so
# that disk image changes after first build are persistent until clean.  More
# details:
# http://www.gnu.org/software/make/manual/html_node/Chained-Rules.html
.PRECIOUS: %.o

UPROGS=\
	$U/_cat\
	$U/_echo\
	$U/_forktest\
	$U/_grep\
	$U/_init\
	$U/_kill\
	$U/_ln\
	$U/_ls\
	$U/_mkdir\
	$U/_rm\
	$U/_sh\
	$U/_wc\
	$U/_zombie\
	$U/_stressfs\
	$U/_usertests\
	$U/_pingpong\
	$U/_hello_world\
	$U/_freemem\

fs.img: mkfs/mkfs README kianv.txt $(UPROGS)
	mkfs/mkfs fs.img README kianv.txt $(UPROGS)

-include kernel/*.d user/*.d

clean:
	rm -f *.tex *.dvi *.idx *.aux *.log *.ind *.ilg \
	*/*.o */*.d */*.asm */*.sym xv6.* \
	$U/initcode $U/initcode.out $K/kernel xv6.elf fs.img \
	mkfs/mkfs .gdbinit \
        $U/usys.S \
	$(UPROGS)

ifndef CPUS
CPUS := 1
endif
