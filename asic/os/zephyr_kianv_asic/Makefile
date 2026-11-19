# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2026 Hirosh Dabui <hirosh@dabui.de>

BOARD ?= kianv_asic
SHELL := /bin/bash
BUILD_DIR ?= build
DOCKER_BUILD_DIR ?= build-docker
FULL_FLASH_SIZE ?= 0x800000
ORIGINAL_FLASH_IMAGE ?= /home/hd/hacking/contributions/kianRiscV/asic/os/ulinux_asic_kianv_soc/linux.bin
CPU_FREQ ?= 30000000
BAUDRATE ?= 115200
PYTHON_BOOTSTRAP ?= python3
VENV_DIR ?= $(CURDIR)/.venv
PYTHON ?= $(VENV_DIR)/bin/python
ZEPHYR_BASE_ORIGIN := $(origin ZEPHYR_BASE)
WEST ?= $(PYTHON) -m west
ZEPHYR_WORKSPACE ?= $(CURDIR)/zephyrproject
ZEPHYR_REPO ?= https://github.com/zephyrproject-rtos/zephyr
ZEPHYR_REV ?= main
ZEPHYR_BASE ?= $(ZEPHYR_WORKSPACE)/zephyr
ZEPHYR_REQUIREMENTS ?= $(ZEPHYR_BASE)/scripts/requirements-base.txt
LOCAL_TOOLCHAIN_DIR ?= $(CURDIR)/toolchain/riscv32ima
SYSTEM_TOOLCHAIN_DIR ?= /opt/riscv32ima
TOOLCHAIN_DIR ?= $(LOCAL_TOOLCHAIN_DIR)
TOOLCHAIN_SRC ?= $(CURDIR)/toolchain/riscv-gnu-toolchain
TOOLCHAIN_REPO ?= https://github.com/riscv-collab/riscv-gnu-toolchain.git
TOOLCHAIN_JOBS ?= $(shell nproc 2>/dev/null || echo 4)
CROSS_COMPILE ?= $(TOOLCHAIN_DIR)/bin/riscv32-unknown-elf-
SYSROOT_DIR ?= $(TOOLCHAIN_DIR)/riscv32-unknown-elf
TOOLCHAIN_HAS_NEWLIB ?= ON
BOOT_CC ?= $(CROSS_COMPILE)gcc
OBJCOPY ?= $(CROSS_COMPILE)objcopy
READELF ?= $(CROSS_COMPILE)readelf

ifeq ($(ZEPHYR_BASE_ORIGIN),undefined)
ZEPHYR_DEPS := zephyr-fetch
else
ZEPHYR_DEPS :=
endif

FLASH_IMAGE_OFFSET ?= 0x110000
FLASH_IMAGE_ADDR ?= 0x20110000
BOOT_FLASH_OFFSET ?= 0x100000
MICROPY_FLASH_OFFSET ?= 0x300000
MICROPY_FLASH_ADDR ?= 0x20300000
MICROPY_WORKSPACE ?= $(CURDIR)/micropython
MICROPY_REPO ?= https://github.com/micropython/micropython.git
MICROPY_REV ?= 0fd6c573ea815774668bbb16b8e197c8822368b2
MICROPY_DIR ?= $(MICROPY_WORKSPACE)/ports/kianv_riscv
MICROPY_BIN ?= $(MICROPY_DIR)/build/firmware.bin
MICROPY_COPT ?=
MICROPY_LDFLAGS ?=
MICROPY_LIBS ?=
RAM_IMAGE_ADDR ?= 0x80000000
DOCKER ?= docker
DOCKER_IMAGE ?= kianv-zephyr-asic
DOCKER_RUN_FLAGS ?=

.PHONY: all build native-build build-no-toolchain container-build docker-image docker-build python-env zephyr zephyr-fetch zephyr-python-deps zephyr-update micropython-fetch micropython-patch micropython-bin bootloader-dualboot dualboot-image original-zephyr-image toolchain toolchain-fetch toolchain-version clean

all: docker-build

toolchain-fetch:
	mkdir -p $(dir $(TOOLCHAIN_SRC))
	test -d $(TOOLCHAIN_SRC)/.git || git clone --recursive $(TOOLCHAIN_REPO) $(TOOLCHAIN_SRC)
	git -C $(TOOLCHAIN_SRC) submodule update --init --recursive

$(LOCAL_TOOLCHAIN_DIR)/bin/riscv32-unknown-elf-gcc: toolchain-fetch
	cd $(TOOLCHAIN_SRC) && ./configure \
	  --prefix=$(LOCAL_TOOLCHAIN_DIR) \
	  --target=riscv32-unknown-elf \
	  --with-arch=rv32ima \
	  --with-abi=ilp32
	$(MAKE) -C $(TOOLCHAIN_SRC) -j$(TOOLCHAIN_JOBS)

toolchain: $(LOCAL_TOOLCHAIN_DIR)/bin/riscv32-unknown-elf-gcc

toolchain-version:
	$(CROSS_COMPILE)gcc --version

$(PYTHON):
	$(PYTHON_BOOTSTRAP) -m venv $(VENV_DIR)
	$(PYTHON) -m pip install --upgrade pip west

python-env: $(PYTHON)

zephyr-fetch: python-env
	test -d $(ZEPHYR_WORKSPACE)/.west || $(WEST) init -m $(ZEPHYR_REPO) --mr $(ZEPHYR_REV) $(ZEPHYR_WORKSPACE)
	cd $(ZEPHYR_WORKSPACE) && $(WEST) update -o=--depth=1 -n -f smart

$(BUILD_DIR)/.zephyr-python-deps: python-env $(ZEPHYR_DEPS) $(ZEPHYR_REQUIREMENTS)
	mkdir -p $(BUILD_DIR)
	$(PYTHON) -m pip install -r $(ZEPHYR_REQUIREMENTS)
	touch $(BUILD_DIR)/.zephyr-python-deps

zephyr-python-deps: $(BUILD_DIR)/.zephyr-python-deps

zephyr-update:
	cd $(ZEPHYR_WORKSPACE) && $(WEST) update

zephyr: zephyr-python-deps
	ZEPHYR_BASE=$(ZEPHYR_BASE) ZEPHYR_TOOLCHAIN_VARIANT=cross-compile \
	cmake -S . -B $(BUILD_DIR) -GNinja -DBOARD=$(BOARD) \
	  -DPython3_EXECUTABLE=$(PYTHON) \
	  -DCROSS_COMPILE=$(CROSS_COMPILE) \
	  -DTOOLCHAIN_HAS_NEWLIB=$(TOOLCHAIN_HAS_NEWLIB) \
	  -DBUILD_VERSION=kianv-local \
	  -DSYSROOT_DIR=$(SYSROOT_DIR)
	ninja -C $(BUILD_DIR)

micropython-fetch:
	test -d $(MICROPY_WORKSPACE)/.git || git clone $(MICROPY_REPO) $(MICROPY_WORKSPACE)
	git -C $(MICROPY_WORKSPACE) remote set-url origin $(MICROPY_REPO)
	git -C $(MICROPY_WORKSPACE) fetch --depth=1 origin $(MICROPY_REV)
	git -C $(MICROPY_WORKSPACE) checkout --force --detach $(MICROPY_REV)
	git -C $(MICROPY_WORKSPACE) reset --hard $(MICROPY_REV)

micropython-patch: micropython-fetch
	git -C $(MICROPY_WORKSPACE) clean -fdx -- ports/kianv_riscv
	cd $(MICROPY_WORKSPACE) && git apply --recount $(CURDIR)/patches/micropython-kianv-asic.patch

micropython-bin: micropython-patch
	rm -rf $(MICROPY_DIR)/build
	PATH=$(dir $(CROSS_COMPILE)):$$PATH $(MAKE) -C $(MICROPY_DIR) \
	  CROSS_COMPILE=$(CROSS_COMPILE) \
	  COPT="$(MICROPY_COPT)" \
	  $(if $(MICROPY_LDFLAGS),LDFLAGS="$(MICROPY_LDFLAGS)",) \
	  $(if $(MICROPY_LIBS),LIBS="$(MICROPY_LIBS)",) \
	  all
	test -f $(MICROPY_BIN)

bootloader-dualboot: zephyr
	mkdir -p $(BUILD_DIR)/boot
	$(BOOT_CC) -Os -ffreestanding -fno-pic -fno-stack-protector -nostdlib \
	  -march=rv32ima_zicsr_zifencei -mabi=ilp32 -Wl,--no-relax \
	  -DCPU_FREQ=$(CPU_FREQ) -DBAUDRATE=$(BAUDRATE) \
	  -DIMAGE_FLASH_ADDR=$(FLASH_IMAGE_ADDR) \
	  -DIMAGE_RAM_ADDR=$(RAM_IMAGE_ADDR) \
	  -DIMAGE_SIZE=$$(stat -c%s $(BUILD_DIR)/zephyr/zephyr.bin) \
	  -DMICROPY_FLASH_ADDR=$(MICROPY_FLASH_ADDR) \
	  -T boot/dualboot.ld \
	  boot/dualboot_crt0.S boot/dualboot_loader.c -o $(BUILD_DIR)/boot/bootloader_dualboot.elf
	$(OBJCOPY) -O binary $(BUILD_DIR)/boot/bootloader_dualboot.elf $(BUILD_DIR)/boot/bootloader_dualboot.bin
	test $$(stat -c%s $(BUILD_DIR)/boot/bootloader_dualboot.bin) -le $$(( $(FLASH_IMAGE_OFFSET) - 0x100000 ))

dualboot-image: bootloader-dualboot micropython-bin
	{ \
	  echo "@$$(printf "%x" $(BOOT_FLASH_OFFSET))"; \
	  hexdump -v -e '"" 32/1 "%02x " "\n"' $(BUILD_DIR)/boot/bootloader_dualboot.bin; \
	  echo "@$$(printf "%x" $(FLASH_IMAGE_OFFSET))"; \
	  hexdump -v -e '"" 32/1 "%02x " "\n"' $(BUILD_DIR)/zephyr/zephyr.bin; \
	  echo "@$$(printf "%x" $(MICROPY_FLASH_OFFSET))"; \
	  hexdump -v -e '"" 32/1 "%02x " "\n"' $(MICROPY_BIN); \
	} > $(BUILD_DIR)/firmware_dualboot.hex
	dd if=/dev/zero bs=1 count=0 seek=$$(( $(MICROPY_FLASH_OFFSET) + $$(stat -c%s $(MICROPY_BIN)) )) of=$(BUILD_DIR)/firmware_dualboot_nor_full.bin
	tr '\000' '\377' < $(BUILD_DIR)/firmware_dualboot_nor_full.bin > $(BUILD_DIR)/firmware_dualboot_nor_full.bin.tmp
	mv $(BUILD_DIR)/firmware_dualboot_nor_full.bin.tmp $(BUILD_DIR)/firmware_dualboot_nor_full.bin
	dd if=$(BUILD_DIR)/boot/bootloader_dualboot.bin of=$(BUILD_DIR)/firmware_dualboot_nor_full.bin bs=1 seek=$$(( $(BOOT_FLASH_OFFSET) )) conv=notrunc
	dd if=$(BUILD_DIR)/zephyr/zephyr.bin of=$(BUILD_DIR)/firmware_dualboot_nor_full.bin bs=1 seek=$$(( $(FLASH_IMAGE_OFFSET) )) conv=notrunc
	dd if=$(MICROPY_BIN) of=$(BUILD_DIR)/firmware_dualboot_nor_full.bin bs=1 seek=$$(( $(MICROPY_FLASH_OFFSET) )) conv=notrunc
	dd if=$(BUILD_DIR)/firmware_dualboot_nor_full.bin of=$(BUILD_DIR)/firmware_dualboot_nor_payload.bin bs=1 skip=$$(( $(BOOT_FLASH_OFFSET) ))
	dd if=/dev/zero bs=1 count=0 seek=$$(( $(FULL_FLASH_SIZE) )) of=$(BUILD_DIR)/firmware_dualboot_nor_8m.bin
	tr '\000' '\377' < $(BUILD_DIR)/firmware_dualboot_nor_8m.bin > $(BUILD_DIR)/firmware_dualboot_nor_8m.bin.tmp
	mv $(BUILD_DIR)/firmware_dualboot_nor_8m.bin.tmp $(BUILD_DIR)/firmware_dualboot_nor_8m.bin
	dd if=$(BUILD_DIR)/boot/bootloader_dualboot.bin of=$(BUILD_DIR)/firmware_dualboot_nor_8m.bin bs=1 seek=$$(( $(BOOT_FLASH_OFFSET) )) conv=notrunc
	dd if=$(BUILD_DIR)/zephyr/zephyr.bin of=$(BUILD_DIR)/firmware_dualboot_nor_8m.bin bs=1 seek=$$(( $(FLASH_IMAGE_OFFSET) )) conv=notrunc
	dd if=$(MICROPY_BIN) of=$(BUILD_DIR)/firmware_dualboot_nor_8m.bin bs=1 seek=$$(( $(MICROPY_FLASH_OFFSET) )) conv=notrunc
	if [ -f "$(ORIGINAL_FLASH_IMAGE)" ]; then \
	  dd if=$(ORIGINAL_FLASH_IMAGE) of=$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin bs=1 count=$$(( $(BOOT_FLASH_OFFSET) )); \
	  dd if=/dev/zero bs=1 count=0 seek=$$(( $(FULL_FLASH_SIZE) )) of=$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin; \
	  dd if=$(BUILD_DIR)/boot/bootloader_dualboot.bin of=$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin bs=1 seek=$$(( $(BOOT_FLASH_OFFSET) )) conv=notrunc; \
	  dd if=$(BUILD_DIR)/zephyr/zephyr.bin of=$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin bs=1 seek=$$(( $(FLASH_IMAGE_OFFSET) )) conv=notrunc; \
	  dd if=$(MICROPY_BIN) of=$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin bs=1 seek=$$(( $(MICROPY_FLASH_OFFSET) )) conv=notrunc; \
	fi
	$(READELF) -h $(BUILD_DIR)/zephyr/zephyr.elf | sed -n 's/.*Entry point address:[[:space:]]*/Zephyr entry: /p'
	@echo "Dualboot hex: $(BUILD_DIR)/firmware_dualboot.hex"
	@echo "Dualboot NOR full image from flash base 0x20000000: $(BUILD_DIR)/firmware_dualboot_nor_full.bin"
	@echo "Dualboot 8 MiB full image from flash base 0x20000000: $(BUILD_DIR)/firmware_dualboot_nor_8m.bin"
	@if [ -f "$(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin" ]; then echo "Dualboot 8 MiB full image with original first 1 MiB: $(BUILD_DIR)/firmware_dualboot_with_original_prefix_8m.bin"; fi
	@echo "Dualboot NOR payload image for flash offset 0x$$(printf "%x" $(BOOT_FLASH_OFFSET)): $(BUILD_DIR)/firmware_dualboot_nor_payload.bin"
	@echo "MicroPython image at flash offset 0x$$(printf "%x" $(MICROPY_FLASH_OFFSET)): $(MICROPY_BIN)"

original-zephyr-image: dualboot-image

docker-image:
	$(DOCKER) build -t $(DOCKER_IMAGE) -f Dockerfile .

docker-build: docker-image
	$(DOCKER) run --rm $(DOCKER_RUN_FLAGS) \
	  -u $$(id -u):$$(id -g) \
	  -v $(CURDIR):/work \
	  -w /work \
	  $(DOCKER_IMAGE) \
	  make container-build BUILD_DIR=$(DOCKER_BUILD_DIR)

build: docker-build

native-build: toolchain dualboot-image

container-build: TOOLCHAIN_DIR := /usr
container-build: CROSS_COMPILE := /usr/bin/riscv64-unknown-elf-
container-build: SYSROOT_DIR :=
container-build: TOOLCHAIN_HAS_NEWLIB := OFF
container-build: MICROPY_COPT := --specs=picolibc.specs -Wno-error=dangling-pointer
container-build: MICROPY_LDFLAGS := -march=rv32ima -mabi=ilp32 -flto -ffreestanding -nostartfiles -nostdlib -Wl,-Bstatic,-T,riscv.ld -L/usr/lib/picolibc/riscv64-unknown-elf/lib/rv32ia/ilp32 -L/usr/lib/picolibc/riscv64-unknown-elf/lib
container-build: MICROPY_LIBS := -lm -lc -lgcc
container-build: dualboot-image

build-no-toolchain: TOOLCHAIN_DIR := $(if $(wildcard $(LOCAL_TOOLCHAIN_DIR)/bin/riscv32-unknown-elf-gcc),$(LOCAL_TOOLCHAIN_DIR),$(SYSTEM_TOOLCHAIN_DIR))
build-no-toolchain: dualboot-image

clean:
	rm -rf $(BUILD_DIR)
