# RISC-V Linux for ULX3S and IceSugar-Pro FPGA boards

This is the initial release of a binary implementing a RISC-V Linux system on the ULX3S and IceSugar-Pro FPGA boards. The system boots with 32 MByte SDRAM. Please note that the performance might not be the fastest as it runs with a multicycle CPU and SDRAM (no cache). Later releases will include the Verilog source code and additional features.

## Flashing the system

To flash the system, use the following command with [OpenFPGALoader](https://github.com/trabucayre/openFPGALoader):

./flash.sh <soc_variant>
<soc_variant> could be something like ulx3s/soc_12f_70mhz.bit.

Check the ulx3s or icesuger-pro folders for the specific FPGA board files.

Usage
Once the system is flashed, you can connect to it using tio.

For ULX3S:
tio -m INLCRNL /dev/serial/by-id/usb-FER-RADIONA-EMARD_ULX3S_FPGA_85K_v3.0.8_K00530-if00-port0 -b 3000000
For IceSugar-Pro:
tio -m INLCRNL /dev/serial/by-id/usb-MuseLab_DAPLink_CMSIS-DAP_07100001006400443300000a4e503750a5a5a5a597969908-if01 -b 3000000

Enjoy exploring RISC-V Linux on your FPGA board!
