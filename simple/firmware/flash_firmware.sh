#!/bin/sh
FIRMWARE=firmware.bin

if [ -z "$1" ] | [ -z "$2" ] | [ -z "$3" ]; then 
  echo "ico|ulx3s|ice|fun|breakout <*.ld> <*.c>"
  exit 1
fi

rm *.o; ./kianv_firmware_gcc.sh $2 $3
if   [ "$1" = "ico"   ]; then 
  icoprog -O16 -f  < $FIRMWARE && icoprog -b
elif [ "$1" = "ulx3s" ]; then 
  fujprog -j flash -f 1048576 $FIRMWARE
  openFPGALoader  --board=ulx3s -r
elif [ "$1" = "ice"   ]; then 
  iceprog -o 1M $FIRMWARE
elif [ "$1" = "fun"   ]; then 
  iceFUNprog -o $((64*1024*4)) $FIRMWARE
elif [ "$1" = "breakout"   ]; then 
  iceprog -o 1M $FIRMWARE
else
  echo "ico|ulx3s|ice|fun|breakout <*.ld> <*.c>"
fi

