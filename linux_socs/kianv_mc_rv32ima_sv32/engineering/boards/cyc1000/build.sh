#!/usr/bin/bash
clear && time (make -f Makefile clean && make -f Makefile && openFPGALoader -b cyc1000 --write-flash cyc1000-KianV-RV32IMA-SV32-xv6.rbf )
