REPO_URL := https://github.com/buildroot/buildroot.git
BRANCH := master
DIR := buildroot
FW_PAYLOAD_BIN := buildroot/output/images/fw_payload.bin
FW_PAYLOAD_RLE := fw_payload.rle

CC=gcc
CFLAGS=-Wall -g
SRC_DIR=utils
SRC=$(SRC_DIR)/rle_encode.c
OBJ=$(SRC:.c=.o)
RLE_ENCODE=utils/rle_encode

.PHONY: build clone-buildroot customize_buildroot

# Default target
build: clean customize_buildroot
	@echo "Starting build process..."
	@make -j $(shell nproc) -C $(DIR)

customize_buildroot: clone-buildroot
	@echo "Customizing Buildroot..."
	@cp -av bldroot/board/kianv $(DIR)/board/
	@cp -av bldroot/boot $(DIR)/board/  # This seems to be a mistake; it copies to /board/ but was intended for /boot/ based on later commands.
	@cp -av bldroot/configs/kianv_rv32ima_sv32_buildroot_defconfig $(DIR)/configs/
	@cp -av bldroot/boot $(DIR)/
	@cp -av bldroot/package $(DIR)/
	@dtc -I dts -O dtb -o $(DIR)/board/kianv/rv32ima_sv32/kianv.dtb bldroot/board/kianv/rv32ima_sv32/kianv.dts -S 4096
	@rsync -avz --delete bldroot/rootfs-overlay $(DIR)/
	@make -C $(DIR) kianv_rv32ima_sv32_buildroot_defconfig
	@echo "Applying patch if not already applied..."
	@cd $(DIR) && if patch -p1 --forward --dry-run --silent < ../bldroot/patches/0001-fix-make-parameter.patch >/dev/null; then \
    patch -p1 --forward < ../bldroot/patches/0001-fix-make-parameter.patch; \
	else \
    echo "Patch already applied or failed. Skipping..."; \
	fi

clone-buildroot:
	@if [ ! -d "$(DIR)" ]; then \
		echo "Cloning Buildroot into $(DIR)..."; \
		git clone --depth 1 -b $(BRANCH) $(REPO_URL) $(DIR); \
	else \
		echo "Already cloned Buildroot into $(DIR)..."; \
	fi

unmount:
	@echo "Unmounting all mounted partitions on $(DEVICE)..."
	@for partition in $(shell ls $(DEVICE)?* 2>/dev/null); do \
		sudo umount $$partition || true; \
	done
partition-disk: unmount
	@if [ -z "$(DEVICE)" ]; then \
		echo "Error: DEVICE parameter not specified."; \
		echo "Usage: make partition-disk DEVICE=/dev/sdx"; \
		exit 1; \
	fi
	@echo "WARNING: This will destroy ALL data on $(DEVICE)!"
	@read -p "Are you sure you want to continue? [y/N] " response; \
	if [ "$$response" != "y" ] && [ "$$response" != "Y" ]; then \
		echo "Aborting."; \
		exit 1; \
	fi
	@echo "Erasing existing partitions on $(DEVICE)..."
	@sudo wipefs --all $(DEVICE)
	@sudo sgdisk --zap-all $(DEVICE)
	@echo "Creating new partitions on $(DEVICE)..."
	@echo -e ",100M,0\n,100M,83\n" | sudo sfdisk $(DEVICE)
	@echo "Partitioning completed."

flash_os: partition-disk $(FW_PAYLOAD_RLE) flash_kernel flash_rootfs
	@echo "Burn os process completed."

flash_kernel: unmount $(FW_PAYLOAD_RLE)
	@echo "Burning kernel payload to $(DEVICE)1..."
	@sudo dd if=fw_payload.rle of=$(DEVICE)1 bs=4M status=progress
	@echo "Syncing disks..."
	@sudo sync
	@echo "Burn kernel process completed."

flash_rootfs: unmount $(FW_PAYLOAD_RLE)
	@echo "Burning rootfs to $(DEVICE)2..."
	@sudo dd if=buildroot/output/images/rootfs.ext2 of=$(DEVICE)2 bs=4M status=progress
	@echo "Syncing disks..."
	@sudo sync
	@echo "Burn rootfs process completed."

# Rule to encode the firmware payload using RLE
$(FW_PAYLOAD_RLE): $(RLE_ENCODE)
	@echo "Encoding firmware payload with RLE..."
	@./utils/rle_encode $(FW_PAYLOAD_BIN) $@

$(RLE_ENCODE): $(OBJ)
	@$(CC) $(CFLAGS) -o $@ $^

$(SRCDIR)/%.o: $(SRCDIR)/%.c
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -f $(FW_PAYLOAD_RLE)
	@rm -f $(OBJ) $(RLE_ENCODE)
