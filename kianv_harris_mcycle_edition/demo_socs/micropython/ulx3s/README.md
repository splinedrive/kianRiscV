Micropython on ulx3s
================================
You want to run micropython on a ulx3s FGPA?
Just flash these images to run kianriscv soc with sdram support!
Baudrate is 1000000

taken micropython from https://github.com/smunaut/micropython

flash firmware on ulx3s
```bash
openFPGALoader  -f -o 1048576 --board=ulx3s -r micropython_v1.12-265.bin
```

flash kianRiscv rv32im multicycle soc via
```bash
openFPGALoader  -f --board=ulx3s -r soc_ulx3s_85f.bit
```
These is a binary release and the source code will released later.
