!/usr/bin/env bash
# -----------------------------------------------------------------------------
# FPGA build script for IcePi Zero (ECP5)
# Usage: ./build.sh [lpf_file]
# Example: ./build.sh icepi-zero-v1_2.lpf
# Default: icepi-zero-v1_3.lpf
# -----------------------------------------------------------------------------

set -euo pipefail

LPF_FILE="${1:-icepi-zero-v1_3.lpf}"

echo "Building FPGA design for LPF file: ${LPF_FILE}"
echo "----------------------------------------"

# Clean previous build artifacts
make -f Makefile clean

# Build with the specified LPF
if ! make -f Makefile LPF_FILE="${LPF_FILE}"; then
	echo "Error: Build failed. Check synthesis and place & route logs."
	exit 1
fi

# Check for generated bitstream
if [ ! -f soc.bit ]; then
	echo "Error: Bitstream not found (soc.bit missing)."
	exit 1
fi

echo "Build successful: soc.bit generated."

# Flash to FPGA
echo "Flashing to IcePi Zero..."
openFPGALoader -b icepi-zero -f soc.bit

echo "Done."
