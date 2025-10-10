###################################################################
# Kianv RISC-V SoC for Lattice ECP5 — Makefile
###################################################################

PROJ = soc
SYSTEM_FREQUENCY ?= 55000000

DEFINES = -DSOC_IS_ECP5 -DSOC_HAS_SDRAM_MT48LC16M16A2 -DSOC_HAS_1LED -DSDRAM_SIZE=$$((1024*1024*32))
DEFINES += -DTRP_NS=15 -DTRCD_NS=15 -DTRFC_NS=66 -DTWR_NS=15 -DCAS=2 -DTREFI_NS=7800
DEFINES += -DNUM_ENTRIES_ITLB=64 -DNUM_ENTRIES_DTLB=64 -DICACHE_ENTRIES_PER_WAY=64 -DDCACHE_ENTRIES_PER_WAY=64

RM = rm -rf

include ../sources.mk

LPF_FILE ?= ./icepi-zero-v1_3.lpf

# Default rule — print vars then build
default: print-vars all

# Print configuration info
print-vars:
	@echo "----------------------------------------"
	@echo "Project:        ${PROJ}"
	@echo "LPF file:       ${LPF_FILE}"
	@echo "System freq:    ${SYSTEM_FREQUENCY} Hz"
	@echo "Defines:        ${DEFINES}"
	@echo "----------------------------------------"

# Full build process
all: ${PROJ}.bit

${PROJ}.json: ${SRCS}
	yosys ${DEFINES} -DSYSTEM_CLK=${SYSTEM_FREQUENCY} \
		-p "synth_ecp5 -json ${PROJ}.json -top ${PROJ}" ${SRCS}

${PROJ}_out.config: ${PROJ}.json ${LPF_FILE}
	nextpnr-ecp5 --freq 350 --timing-allow-fail --router router2 \
		--json ${PROJ}.json --textcfg ${PROJ}_out.config --25k --speed 6 \
		--package CABGA256 --lpf ${LPF_FILE}

${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input ${PROJ}_out.config --bit ${PROJ}.bit

clean:
	${RM} ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

.PHONY: default all clean print-vars
