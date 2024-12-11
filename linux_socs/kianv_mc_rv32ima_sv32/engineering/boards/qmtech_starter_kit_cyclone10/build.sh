#!/usr/bin/bash
clear && time (make -f Makefile clean && make -f Makefile && openFPGALoader -c usb-blaster -B spiOverJtag_10cl055484.rbf.gz qmtech_start_kit_cyclone10-KianV-RV32IMA-SV32.rbf)

