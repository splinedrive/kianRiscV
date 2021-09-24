#!/bin/sh
if   [ "$1" = "ico"   ]; then 
  make -f Makefile.icoboard clean && make -f Makefile.icoboard burn && icoprog -b
elif [ "$1" = "ulx3s" ]; then 
  make -f Makefile.ulx3s clean && make -f Makefile.ulx3s && openFPGALoader -f --board=ulx3s kianv_soc_ulx3s.bit
elif [ "$1" = "ice"   ]; then 
  make -f Makefile.icebreaker clean && make -f Makefile.icebreaker prog
elif [ "$1" = "fun"   ]; then 
  make -f Makefile.icefun clean && make -f Makefile.icefun  prog
elif   [ "$1" = "breakout"   ]; then 
  make -f Makefile.breakout clean && make -f Makefile.breakout prog
else
  echo "ico|ulx3s|ice|fun|breakout"
fi

