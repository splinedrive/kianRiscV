icesprog -w -o $((1024*1024*1))  boot.bin
icesprog -w -o $((1024*1024*2))  kernel
icesprog -w -o $((1024*1024*7))  kianv32mb.dtb
icesprog -w ./icesugar-pro/soc_70Mhz.bit 
