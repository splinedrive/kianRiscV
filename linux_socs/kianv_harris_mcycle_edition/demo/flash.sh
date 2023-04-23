openFPGALoader -f -o $((1024*1024*1))  --board=ulx3s boot.bin
openFPGALoader -f -o $((1024*1024*2))  --board=ulx3s kernel
openFPGALoader -f -o $((1024*1024*7))  --board=ulx3s kianv32mb.dtb
openFPGALoader -f --board=ulx3s -r $1
