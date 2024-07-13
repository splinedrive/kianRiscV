openFPGALoader -b cyc1000 --write-flash -o $((1024*1024*2)) Image 
openFPGALoader -b cyc1000 --write-flash -o $((1024*1024*1)) bootloader.bin 
openFPGALoader -b cyc1000 --write-flash -o $((1024*(1024 + 512)) kianv8mb.dtb
openFPGALoader -b cyc1000 --write-flash  soc.rbf
