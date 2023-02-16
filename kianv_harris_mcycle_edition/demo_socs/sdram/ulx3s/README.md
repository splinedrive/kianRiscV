sdram test bytewise 8MByte on ulx3s
===================================
You want to run sdramtest on a ulx3s-85f FGPA?
Just flash these images to run kianriscv soc with sdram support!
Baudrate is 1000000

flash firmware on colorlight i5 or i9 with
```bash
openFPGALoader  -f -o 1048576 --board=colorlight-i5 -r sdram_ulx3s_32Mbyte_bytewise.bin
```

flash kianRiscv rv32im multicycle soc via
```bash
openFPGALoader  -f --board=ulx3s -r soc_ulx3s-85f.bit
```
These is a binary release and the source code will released later.
