Here I am initially releasing the binary that implements a RISC-V Linux on the ULX3S. 
The system boots with 32 MByte SDRAM. It's not the fastest because it runs with a 
multicycle CPU and SDRAM. Later, the Verilog source code and a few more features will follow. 
To flash the system, call ./flash.sh with the OpenFPGALoader. Have fun!
