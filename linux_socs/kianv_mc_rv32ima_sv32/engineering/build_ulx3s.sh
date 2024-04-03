#!/bin/bash
rm -f soc.v
ln -s soc_enterprise.v soc.v

DEVICE=${1:-85k}
make -f Makefile.ulx3s clean
make -f Makefile.ulx3s DEVICE=$DEVICE
openFPGALoader -f --board=ulx3s soc.bit

