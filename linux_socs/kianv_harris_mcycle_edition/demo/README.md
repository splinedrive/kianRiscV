Here I am initially releasing the binary that implements a RISC-V Linux on the ULX3S. 
The system boots with 32 MByte SDRAM. It's not the fastest because it runs with a 
multicycle CPU and SDRAM (no cache). Later, the Verilog source code and a few more features will follow. 
To flash the system, call 

./flash.sh <soc_variant>

soc_12f_70mhz.bit
soc_25f_70mhz.bit
soc_45f_70mhz.bit
soc_85f_70mhz.bit

with the OpenFPGALoader. Have fun!

tio -m INLCRNL /dev/serial/by-id/usb-FER-RADIONA-EMARD_ULX3S_FPGA_85K_v3.0.8_K00530-if00-port0 -b 3000000


