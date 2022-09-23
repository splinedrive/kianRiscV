#!/bin/sh
FIRMWARE=firmware.bin

usage () {
  echo "ico|ulx3s|ice|fun|breakout|colori5|arty7|nexysa7|nexys_video|genesys2|stick <*.ld> <*.c> [-Ox]"
  echo "Default OPT_LEVEL is -Os, you can choose -O0, -O1, -O2, -O3"
}

if [ -z "$1" ] | [ -z "$2" ] | [ -z "$3" ]; then
  usage
  exit 1
fi

if   [ "$1" != "stick" ]; then
rm *.o; OPT_LEVEL=$4 ./kianv_firmware_gcc.sh $2 $3
else
rm *.o; OPT_LEVEL=$4 ./kianv_firmware_gcc_ri.sh $2 $3
fi

if   [ "$1" = "ico"   ]; then
  icoprog -O16 -f  < $FIRMWARE && icoprog -b
elif [ "$1" = "ulx3s" ]; then
#  fujprog -j flash -f 1048576 $FIRMWARE
  openFPGALoader  -f -o 1048576 --board=ulx3s -r $FIRMWARE
  #openFPGALoader  -f -o 1048576 --ftdi-serial K00530 --board=ulx3s -r $FIRMWARE
elif [ "$1" = "colori5" ]; then
  openFPGALoader  -f -o 1048576 --board=colorlight-i5 -r $FIRMWARE
elif [ "$1" = "ice"   ]; then
  iceprog -o 1M $FIRMWARE
elif [ "$1" = "stick"   ]; then
  iceprog -o 1M $FIRMWARE
elif [ "$1" = "fun"   ]; then
  iceFUNprog -o $((64*1024*4)) $FIRMWARE
elif [ "$1" = "breakout"   ]; then
  iceprog -o 1M $FIRMWARE
elif [ "$1" = "arty7" ]; then
  openFPGALoader -v -f -o $((4*1024*1024)) --board=arty_a7_100t -r $FIRMWARE
elif [ "$1" = "nexysa7" ]; then
  openFPGALoader -v -f -o $((4*1024*1024)) --board=arty_a7_100t -r $FIRMWARE
elif [ "$1" = "nexys_video" ]; then
  openFPGALoader -v -f -o $((10*1024*1024)) --board=nexysVideo -r $FIRMWARE
elif [ "$1" = "genesys2" ]; then
  openFPGALoader -v -f -o $((28*1024*1024)) --board=genesys2 -r $FIRMWARE
else
  usage
fi

