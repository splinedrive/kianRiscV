# RISC-V Linux for TangNano20K

This is the initial release of a binary implementing a RISC-V Linux system on the TangNano20K. T
The system boots with 8 MByte SDRAM. Please note that the performance might not be the fastest as it runs with a
multicycle CPU and SDRAM (no cache). Later releases will include the Verilog source code.

## Flashing the system

To flash the system, use the following command with [OpenFPGALoader](https://github.com/trabucayre/openFPGALoader):

openFPGALoader  --board=tangnano20k --external-flash -f kianVLinuxRiscvSocTangNano20K.bin

Usage
Once the system is flashed, you can connect to it using tio.

tio -m INLCRNL /dev/serial/by-id/usb-SIPEED_20K_s_FRIEND_2023030621-if01-port0 -b 2000000
Enjoy exploring RISC-V Linux on your FPGA board!
