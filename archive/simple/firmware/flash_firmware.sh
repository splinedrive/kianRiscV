#!/bin/sh
FIRMWARE=firmware.bin

usage () {
  echo "ico|ulx3s|ice|fun|breakout|colori5 <*.ld> <*.c> [-Ox]"
  echo "Default OPT_LEVEL is -Os, you can choose -O0, -O1, -O2, -O3"
}

if [ -z "$1" ] | [ -z "$2" ] | [ -z "$3" ]; then
  usage
  exit 1
fi

rm *.o; OPT_LEVEL=$4 ./kianv_firmware_gcc.sh $2 $3
if   [ "$1" = "ico"   ]; then
  icoprog -O16 -f  < $FIRMWARE && icoprog -b
elif [ "$1" = "ulx3s" ]; then
#  fujprog -j flash -f 1048576 $FIRMWARE
  openFPGALoader  -f -o 1048576 --board=ulx3s -r $FIRMWARE
elif [ "$1" = "colori5" ]; then
  openFPGALoader  -f -o 1048576 --board=colorlight-i5 -r $FIRMWARE
elif [ "$1" = "ice"   ]; then
  iceprog -o 1M $FIRMWARE
elif [ "$1" = "fun"   ]; then
  iceFUNprog -o $((64*1024*4)) $FIRMWARE
elif [ "$1" = "breakout"   ]; then
  iceprog -o 1M $FIRMWARE
else
  usage
fi

