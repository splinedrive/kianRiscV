openFPGALoader -f -o $((1024*1024*1))  --board=tangnano20k  --external-flash boot.bin
openFPGALoader -f -o $((1024*1024*2))  --board=tangnano20k  --external-flash kernel
openFPGALoader -f -o $((1024*1024*7))  --board=tangnano20k  --external-flash kianv8mb.dtb
openFPGALoader -f --board=tangnano20k --external-flash -r tangnano20k.bin  
