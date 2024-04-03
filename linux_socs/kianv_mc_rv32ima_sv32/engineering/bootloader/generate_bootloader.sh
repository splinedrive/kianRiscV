PATH=$PATH:/opt/riscv32im/bin ./kianv_firmware_gcc.sh kianv_bootrom.ld kernelboot.c sdcard.c
./bin2hex.py firmware.bin bootloader.hex
