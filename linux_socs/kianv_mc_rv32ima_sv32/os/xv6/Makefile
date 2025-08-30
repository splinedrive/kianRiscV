# ==========================
# Toolchain selection
# ==========================
# Prefer env-provided CROSS_COMPILE; otherwise try RISCV or local TOOLCHAIN_DIR.

# Examples:
#   CROSS_COMPILE=riscv32-unknown-elf-
#   or CROSS_COMPILE=/opt/riscv/bin/riscv32-buildroot-linux-gnu-
CROSS_COMPILE ?=
RISCV         ?=
TOOLCHAIN_DIR ?= ./riscv/riscv32ima-sv32-toolchain

# Auto-detect CROSS_COMPILE if empty
ifeq ($(strip $(CROSS_COMPILE)),)
  ifneq ($(strip $(RISCV)),)
    CROSS_CANDIDATES := \
      $(RISCV)/bin/riscv32-unknown-elf- \
      $(RISCV)/bin/riscv32-buildroot-linux-gnu- \
      $(RISCV)/bin/riscv32-unknown-linux-gnu-
  else
    CROSS_CANDIDATES := \
      $(TOOLCHAIN_DIR)/bin/riscv32-unknown-elf- \
      $(TOOLCHAIN_DIR)/bin/riscv32-buildroot-linux-gnu- \
      $(TOOLCHAIN_DIR)/bin/riscv32-unknown-linux-gnu-
  endif
  CROSS_COMPILE := $(firstword $(foreach p,$(CROSS_CANDIDATES),$(if $(wildcard $(p)gcc),$(p),)))
  ifeq ($(strip $(CROSS_COMPILE)),)
    $(warning Could not auto-detect a RISC-V toolchain; set CROSS_COMPILE or RISCV)
  endif
endif

# Tools (do not override if SDK already exported them)
CC       ?= $(CROSS_COMPILE)gcc
AS       ?= $(CROSS_COMPILE)gcc
LD       ?= $(CROSS_COMPILE)ld
AR       ?= $(CROSS_COMPILE)ar
OBJCOPY  ?= $(CROSS_COMPILE)objcopy
OBJDUMP  ?= $(CROSS_COMPILE)objdump
GDB      ?= $(CROSS_COMPILE)gdb
STRIP    ?= $(CROSS_COMPILE)strip

# Back-compat alias
TOOLPREFIX ?= $(CROSS_COMPILE)

# Host tool for mkfs (native)
HOSTCC ?= gcc

# Match libgcc to the chosen CC (may be empty if CC is unset)
LIBGCC := $(shell $(CC) -print-libgcc-file-name 2>/dev/null)

K=kernel
U=user

OBJS = \
  $K/entry.o \
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

CFLAGS = -Wall -Werror -O -fno-omit-frame-pointer -ggdb -gdwarf-2
CFLAGS += -MD
CFLAGS += -mcmodel=medany
# === RV32 core settings ===
CFLAGS += -march=rv32ima_zicsr_zifencei -mabi=ilp32 -mno-relax -mcmodel=medany
CFLAGS += -ffreestanding -fno-common -nostdlib -fno-pic
CFLAGS += -ffreestanding
CFLAGS += -fno-common -nostdlib
CFLAGS += -fno-builtin-strncpy -fno-builtin-strncmp -fno-builtin-strlen -fno-builtin-memset
CFLAGS += -fno-builtin-memmove -fno-builtin-memcmp -fno-builtin-log -fno-builtin-bzero
CFLAGS += -fno-builtin-strchr -fno-builtin-exit -fno-builtin-malloc -fno-builtin-putc
CFLAGS += -fno-builtin-free
CFLAGS += -fno-builtin-memcpy -Wno-main
CFLAGS += -fno-builtin-printf -fno-builtin-fprintf -fno-builtin-vprintf
CFLAGS += -I.
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)

# Disable PIE when possible
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]no-pie'),)
CFLAGS += -fno-pie -no-pie
endif
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]nopie'),)
CFLAGS += -fno-pie -nopie
endif

LDFLAGS = -z max-page-size=4096 --gc-sections

# --------------------------
# User-specific flags (size)
# --------------------------
# Start from CFLAGS, then remove debug/opt flags and add size-oriented flags.
UCFLAGS := $(CFLAGS)
UCFLAGS := $(filter-out -ggdb -gdwarf-2 -O -fno-omit-frame-pointer,$(UCFLAGS))
UCFLAGS += -Os -fomit-frame-pointer -fno-asynchronous-unwind-tables -fno-unwind-tables

ULDFLAGS := $(LDFLAGS)

# ==========================
# Kernel
# ==========================
$K/kernel: $(OBJS) $K/kernel.ld
	$(LD) $(LDFLAGS) -T $K/kernel.ld -o $K/kernel $(OBJS)
	$(OBJDUMP) -S $K/kernel > $K/kernel.asm
	$(OBJDUMP) -t $K/kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $K/kernel.sym

$K/%.o: $K/%.S
	$(CC) $(CFLAGS) -c -o $@ $<
$K/%.o: $K/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# ==========================
# Tags
# ==========================
tags: $(OBJS)
	etags kernel/*.S kernel/*.c

# ==========================
# User programs
# ==========================
ULIB = $U/ulib.o $U/usys.o $U/printf.o $U/umalloc.o

# user .c -> .o with size-first flags
$U/%.o: $U/%.c
	$(CC) $(UCFLAGS) -c -o $@ $<

$U/usys.S : $U/usys.pl
	perl $U/usys.pl > $U/usys.S

$U/usys.o : $U/usys.S
	$(CC) $(UCFLAGS) -c -o $U/usys.o $U/usys.S

# Generic user link rule; also link libgcc (fixes __umoddi3 etc.), then strip
_%: %.o $(ULIB) $U/user.ld
	$(LD) $(ULDFLAGS) -T $U/user.ld -o $@ $< $(ULIB) $(LIBGCC)
	$(OBJDUMP) -S $@ > $*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $*.sym
	$(STRIP) -s $@

$U/_forktest: $U/forktest.o $(ULIB)
	# forktest links less lib code to be tiny
	$(LD) $(ULDFLAGS) -N -e main -Ttext 0 -o $U/_forktest $U/forktest.o $U/ulib.o $U/usys.o $(LIBGCC)
	$(OBJDUMP) -S $U/_forktest > $U/forktest.asm
	$(STRIP) -s $U/_forktest

# ==========================
# File system image
# ==========================
mkfs/mkfs: mkfs/mkfs.c $K/fs.h $K/param.h
	$(HOSTCC) -I. -o mkfs/mkfs mkfs/mkfs.c

# Prevent deletion of intermediate files (e.g., cat.o) after first build.
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
        $U/_stressfs\
        $U/_usertests\
        $U/_grind\
        $U/_wc\
        $U/_zombie\
        $U/_logstress\
        $U/_forphan\
        $U/_dorphan\

fs.img: mkfs/mkfs README kianv.txt $(UPROGS)
	mkfs/mkfs fs.img README kianv.txt $(UPROGS)

-include kernel/*.d user/*.d

# ==========================
# Utilities
# ==========================
.PHONY: clean show-toolchain sizes

clean:
	rm -f *.tex *.dvi *.idx *.aux *.log *.ind *.ilg \
	*/*.o */*.d */*.asm */*.sym \
	$K/kernel fs.img \
	mkfs/mkfs .gdbinit \
	$U/usys.S \
	$(UPROGS)

show-toolchain:
	@echo "CC           = $(CC)"
	@echo "CROSS_COMPILE= $(CROSS_COMPILE)"
	@echo "LIBGCC       = $(LIBGCC)"
	@echo "RISCV        = $(RISCV)"
	@echo "TOOLCHAIN_DIR= $(TOOLCHAIN_DIR)"

# Quick size report for user binaries after strip
sizes: $(UPROGS)
	@echo "Sizes after strip:"
	@for f in $(UPROGS); do \
	  printf "%-20s " "$$f"; \
	  ls -l $$f | awk '{print $$5" bytes"}'; \
	done

# ==========================
# Parallel build control
# ==========================
ifndef CPUS
CPUS := 1
endif

