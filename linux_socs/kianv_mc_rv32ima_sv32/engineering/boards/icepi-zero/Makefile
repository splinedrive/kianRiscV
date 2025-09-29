###################################################################
# Makefile for Kianv RISC-V SoC on Lattice ECP5
#
# This Makefile automates the FPGA build process for the Kianv RISC-V
# SoC on a Lattice ECP5 platform using open-source tools: Yosys for
# synthesis, NextPNR for place-and-route, and EcpPack for bitstream
# generation.
#
# Key Variables:
# - PROJ: Project name (default: soc)
# - SYSTEM_FREQUENCY: Target system clock frequency in Hz (default: 50 MHz)
# - DEFINES: Defines for SoC configuration, including memory and I/O features
# - SRCS: List of Verilog source files for the SoC
#
# Key Targets:
# - `all`: Runs the entire build process, generating a .bit file
# - `clean`: Removes generated files to reset the build environment
#
###################################################################

PROJ=soc
SYSTEM_FREQUENCY ?= 55000000
DEFINES =  -DSOC_IS_ECP5 -DSOC_HAS_SDRAM_MT48LC16M16A2 -DSOC_HAS_1LED -DSDRAM_SIZE=$$((1024*1024*32))
DEFINES += -DTRP_NS=15 -DTRCD_NS=15 -DTRFC_NS=66 -DTWR_NS=15 -DCAS=2 -DTREFI_NS=7800
DEFINES += -DNUM_ENTRIES_ITLB=64 -DNUM_ENTRIES_DTLB=64 -DICACHE_ENTRIES_PER_WAY=64 -DDCACHE_ENTRIES_PER_WAY=64

RM             = rm -rf

include ../sources.mk

LPF_FILE = ./icepi-zero-v1_2.lpf

all: ${PROJ}.bit
${PROJ}.json: ${SRCS}
	yosys ${DEFINES} -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p "synth_ecp5 -json ${PROJ}.json -top ${PROJ}" ${SRCS}

${PROJ}_out.config: ${PROJ}.json ${LPF_FILE}
	nextpnr-ecp5 --freq 350 --timing-allow-fail --router router2 \
		--json ${PROJ}.json --textcfg ${PROJ}_out.config --25k --speed 6 \
		--package CABGA256 --lpf ${LPF_FILE}

${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input ${PROJ}_out.config --bit ${PROJ}.bit

clean:
	$(RM) -f ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

.PHONY: clean
