###################################################################
# Makefile for Kianv RISC-V SoC - ECP5 FPGA Workflow
#
# Automates the synthesis, placement, routing, and bitstream
# generation process for the Kianv RISC-V SoC targeting an ECP5 FPGA.
###################################################################

# Project name (matches the top-level module)
PROJ = soc

# System frequency and defines
SYSTEM_FREQUENCY ?= 55000000
DEFINES = -DSOC_IS_ECP5 -DSOC_HAS_SDRAM_M12L64322A -DSOC_HAS_1LED -DSDRAM_SIZE=$$((1024*1024*8))
DEFINES += -DNUM_ENTRIES_ITLB=64 -DNUM_ENTRIES_DTLB=64 -DICACHE_ENTRIES_PER_WAY=64 -DDCACHE_ENTRIES_PER_WAY=64

DEFINES += -DTRP_NS=15
DEFINES += -DTRC_NS=60
DEFINES += -DTRCD_NS=15
DEFINES += -DTCH_NS=2
DEFINES += -DCAS=2

# Tools and paths
RM = rm -rf

include ../sources.mk

LPF_FILE = ./colorlighti9.lpf

###################################################################
# Targets
###################################################################

# Main target
all: ${PROJ}.bit

# Generate JSON for synthesis
${PROJ}.json: ${SRCS}
	yosys ${DEFINES} -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p "synth_ecp5 -json ${PROJ}.json -top ${PROJ}" ${SRCS}

# Generate config from JSON
${PROJ}_out.config: ${PROJ}.json ${LPF_FILE}
	nextpnr-ecp5 --freq 350 --timing-allow-fail --router router1 \
		--json ${PROJ}.json --textcfg ${PROJ}_out.config --45k --speed 6 \
		--package CABGA381 --lpf ${LPF_FILE}

# Generate bitstream from config
${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input ${PROJ}_out.config --bit ${PROJ}.bit

# Clean temporary and generated files
clean:
	${RM} ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

.PHONY: all clean
