#!/usr/bin/bash
clear && time (make -f Makefile.cyc1000 clean && make -f Makefile.cyc1000 && openFPGALoader -b cyc1000 --write-flash cyc1000-KianV-RV32IMA-SV32-xv6.rbf )
