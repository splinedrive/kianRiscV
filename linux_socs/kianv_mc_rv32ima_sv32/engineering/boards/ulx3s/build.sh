#!/bin/bash
DEVICE=${1:-85k}
make -f Makefile clean
make -f Makefile DEVICE=$DEVICE
openFPGALoader -f --board=ulx3s soc.bit

