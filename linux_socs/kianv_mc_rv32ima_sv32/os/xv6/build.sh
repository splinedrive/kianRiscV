#!/bin/bash

make clean && make && make fs.img
riscv32-buildroot-linux-gnu-objcopy -O binary kernel/kernel xv6.bin 
gcc ./rle_encoder.c -o rle_encode
./rle_encode xv6.bin xv6.rle 

if [ -z "$1" ]; then
  echo "Usage: $0 /dev/sdX"
  exit 1
fi

DEVICE="$1"

# Ensure the device exists
if [ ! -b "$DEVICE" ]; then
  echo "Error: Device $DEVICE not found!"
  exit 1
fi

echo "Using device: $DEVICE"

# Clean the device with zero-fill
echo "Zeroing out the device..."
sudo dd if=/dev/zero of="$DEVICE" bs=512 seek=$((1024*1024/512)) count=$((12*1024*1024/512)) status=progress

# Burn the filesystem image
echo "Burning filesystem image..."
sudo dd if=fs.img of="$DEVICE" bs=512 seek=$((1024*1024*2/512)) conv=sync status=progress

# Burn the kernel image
echo "Burning compressed kernel image..."
sudo dd if=xv6.rle of="$DEVICE" bs=512 seek=$((1024*1024/512)) conv=sync status=progress

echo "All operations completed successfully on $DEVICE."

