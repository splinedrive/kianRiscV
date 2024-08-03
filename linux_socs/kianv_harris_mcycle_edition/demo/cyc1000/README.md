# RISC-V uLinux for cyc1000

This is the initial release of a binary implementing a RISC-V Linux system on the cyc1000.
The system boots with 8 MByte SDRAM. Please note that the performance might not be the fastest as it runs with a
multicycle CPU and SDRAM (no cache).

## Flashing the system

To flash the system, use the following command with [OpenFPGALoader](https://github.com/trabucayre/openFPGALoader):

Use the flash.sh script
```
openFPGALoader -b cyc1000 --write-flash -o $((1024*1024*2)) Image
openFPGALoader -b cyc1000 --write-flash -o $((1024*1024*1)) bootloader.bin
openFPGALoader -b cyc1000 --write-flash -o $((1024*(1024 + 512)) kianv8mb.dtb
openFPGALoader -b cyc1000 --write-flash  soc.rbf
```

Usage
Once the system is flashed, you can connect to it using tio.

```
tio -m INLCRNL /dev/ttyUSBx -b 2000000
```
Enjoy exploring RISC-V Linux on your FPGA board!
