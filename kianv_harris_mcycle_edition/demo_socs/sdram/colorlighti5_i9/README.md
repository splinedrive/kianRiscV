sdram test bytewise 8MByte on colorlight i5, i9
===============================================
You want to run sdramtest on a colorlight FGPA?
Just flash these images to run kianriscv soc with sdram support!
Baudrate is 1000000

flash firmware on colorlight i5 or i9 with
```bash
openFPGALoader  -f -o 1048576 --board=colorlight-i5 -r sdram_colori5_i9_8Mbyte_bytewise.bin
```

flash kianRiscv rv32im multicycle soc via
```bash
openFPGALoader  -f --board=colorlight-i5 -r soc_colori5.bit
openFPGALoader  -f --board=colorlight-i9 -r soc_colori9.bit
```
These is a binary release and the source code will released later.
