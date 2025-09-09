#!/usr/bin/env bash
set -euo pipefail

# --- config / sanity ---
KERNEL_IMG="fw_payload.rle"
ROOTFS_IMG="rootfs.ext2"

usage() {
	echo "Usage: sudo $0 /dev/sdX"
	echo "       (example: sudo $0 /dev/sdb)"
	exit 1
}

[[ $# -eq 1 ]] || usage
DEVICE="$1"

if [[ ! -b "$DEVICE" ]]; then
	echo "Error: $DEVICE is not a block device."
	exit 1
fi

if [[ ! -f "$KERNEL_IMG" ]]; then
	echo "Error: $KERNEL_IMG not found in current directory: $(pwd)"
	exit 1
fi
if [[ ! -f "$ROOTFS_IMG" ]]; then
	echo "Error: $ROOTFS_IMG not found in current directory: $(pwd)"
	exit 1
fi

echo "================================================================="
echo "WARNING: This will DESTROY ALL DATA on $DEVICE"
echo "Will create a fresh GPT with:"
echo "  - ${DEVICE}1  (100MiB)  <- $KERNEL_IMG"
echo "  - ${DEVICE}2  (rest)    <- $ROOTFS_IMG"
echo "================================================================="
read -r -p "Are you sure you want to continue? [y/N] " response
if [[ "${response}" != "y" && "${response}" != "Y" ]]; then
	echo "Aborting."
	exit 1
fi

# --- unmount anything mounted from this device ---
echo "[1/5] Unmounting any mounted partitions on $DEVICE ..."
# shellcheck disable=SC2046
for mp in $(lsblk -ln -o MOUNTPOINT "${DEVICE}"* | awk 'NF'); do
	echo "  umount $mp"
	umount -f "$mp" || true
done

# --- wipe and create partitions ---
echo "[2/5] Wiping existing signatures and partition table ..."
wipefs --all --force "$DEVICE" || true
sgdisk --zap-all "$DEVICE" || true

echo "[3/5] Creating new GPT and partitions ..."
# New GPT
sgdisk -o "$DEVICE"

# p1: 100MiB (for kernel payload). Use Linux type; it's a raw dd target anyway.
sgdisk -n 1:0:+100M -t 1:8300 -c 1:"kernel" "$DEVICE"

# p2: remainder (for rootfs)
sgdisk -n 2:0:0 -t 2:8300 -c 2:"rootfs" "$DEVICE"

# Re-read partition table
partprobe "$DEVICE" || true
udevadm settle || true
sleep 2

P1="${DEVICE}1"
P2="${DEVICE}2"

if [[ ! -b "$P1" || ! -b "$P2" ]]; then
	echo "Error: Partitions not found after (re)partitioning ($P1 / $P2)."
	lsblk "$DEVICE"
	exit 1
fi
echo "Partitioning completed:"
lsblk "$DEVICE"

# --- flash kernel payload to p1 ---
echo "[4/5] Writing kernel payload to $P1 ..."
dd if="$KERNEL_IMG" of="$P1" bs=512 conv=sync status=progress
sync

# --- flash rootfs to p2 ---
echo "[5/5] Writing rootfs to $P2 ..."
dd if="$ROOTFS_IMG" of="$P2" bs=512 conv=sync status=progress
sync

echo "All done."
echo "Kernel written to: $P1"
echo "Rootfs written to: $P2"
