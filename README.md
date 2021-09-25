A very simple riscv cpu/soc one single file implementation created in my spare time!
But it is full rv32im CPU :) I have wrote all from scratch to learn and
has many potential to speedup. I wanted only to bootstrap my cpu and is a sparetime hobby project.
I was able to run on ulx3s a raytracer in spram with 115MHz.
You can run raytracing, mandelbrot in float and integer.
You can run oled demos and many more! But all is a hack!

The project starts after I have done a certificate in
https://www.edx.org/course/building-a-risc-v-cpu-core

I have some example socs implemented:
icoboard, ulx3s, icebreak, icefun, breakout and not checkedin yet: arty7, gowin, deca, colorlight, blackicemx
\
cd simple/socs\
./build_fpga.sh\
ico|ulx3s|ice|fun|breakout

./build_fpga.sh ico # will build for icoboard fpga image and will flash\

The firmware is flashed on nor memory! On simple fpga boards like iceFun or breakout
the code will executed from nor flash. On icoboard you can run it from sram and you have 1MBytes SRAM
memory! On icebreaker you can run it over spram or bram, ....
I have implemented the simplest spi flash memory controller you can have. On icebreaker
a quad spi with ddr is possible. It is funny to see instruction executed
from nor taking > 64 cycles :( and is nice to see your cpu will raytrace a picture on your oled and executes code
from nor flash.......What a nice experience\
Firmware:\
cd simple/firmware\
flash with\ 
./flash_firmware.sh \
ico|ulx3s|ice|fun|breakout <*.ld> <*.c>

spi_nor2bram_fun.ld # boot from spi-nor icefun and copy code to bram
spi_nor2bram.ld # boot from spi-nor icebreaker, breakout, icoboard and copy to bram
spi_nor2bram_ulx3s.ld # boot from spi-nor ulx3s and copy to bram
spi_nor2spram.ld # boot from spi-nor icebreaker and copy to spram
spi_nor2sram.ld # boot from spi-nor and copy to sram icoboard
spi_nor_fun.ld # boot and execute instructions only from spi-nor on icefun
spi_nor.ld # boot and execute instructions only from spi-nor all boards, excluded icefun\

example rayracing on icefun:\
./flash_firmware.sh spi_nor_fun.ld main_raytracer.c #with oled ssd1331\
example rayracing on iceboard:\
./flash_firmware.sh spi_nor2sram.ld  main_raytracer.c #with oled ssd1331\
example rayracing on ulx3s:\
./flash_firmware.sh spi_nor2bram_ulx3s.ld  main_raytracer.c #with oled ssd1331\
example rayracing on breakout:\
./flash_firmware.sh spi_nor.ld  main_raytracer.c #with oled ssd1331\
example rayracing on breakout:\
./flash_firmware.sh spi_nor.ld  main_raytracer_st7735.c #with oled st7735s instruction over flash\
example rayracing on ulx3s:\
./flash_firmware.sh spi_nor2bram_ulx3s.ld  main_raytracer_st7735.c #with oled st7735s instruction over spram\
\
try main_mandel.c or main_mandel_float.c\
\
also we have st7735 versions\

some programs are using external uart hw, check pcfs but icebreaker, breakout and ulx3s don't need
external uart hw. Check for ttyUSB devices and try
stty -F /dev/ttyUSBx 11520 raw\
cat /dev/ttyUSBx


to get output like pi.c, main_prime.c, main_rv32m.c, main_rv32m_printf.c, ....

On icoboard I have implemented also a vga controller that uses the sram as framebuffer. The
cpu and the videocontroller shares the sram memmory together. But I have disabled in the
kianv_soc_icoboard.v the videocontroller but you can enable it. I wanted to write a hyperram controller for icoboard
but found out that hyperram and sram shares the same databus and then I switch to the oled displays.
I was complete unmotivated. My dream was to use hyperram with a simple cache to run code for my cpu
and using the sram as framebuffer. But with same databus it makes no sense for me!

Have fun!

Hirosh

![riscv](kianv_cpu.png)
![riscv](riscv_kianv.jpg)
![riscv](riscv_kianv2.jpg)
