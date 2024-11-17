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

# Tools and paths
RM = rm -rf
VERILOG_FILES = ../../soc.v \
                ../../pll.v \
                ../../bram.v \
                ../../tx_uart.v \
                ../../rx_uart.v \
                ../../fifo.v \
                ../../qqspi.v \
                ../../clint.v \
                ../../spi.v \
                ../../cache.v \
                ../../icache.v \
                ../../plic.v \
                ../../sdram/m12l64322a_ctrl.v \
                ../../kianv_harris_edition/kianv_harris_mc_edition.v \
                ../../kianv_harris_edition/control_unit.v \
                ../../kianv_harris_edition/datapath_unit.v \
                ../../kianv_harris_edition/register_file.v \
                ../../kianv_harris_edition/design_elements.v \
                ../../kianv_harris_edition/design_elements_fpgacpu_ca.v \
                ../../kianv_harris_edition/alu.v \
                ../../kianv_harris_edition/main_fsm.v \
                ../../kianv_harris_edition/extend.v \
                ../../kianv_harris_edition/alu_decoder.v \
                ../../kianv_harris_edition/store_alignment.v \
                ../../kianv_harris_edition/store_decoder.v \
                ../../kianv_harris_edition/load_decoder.v \
                ../../kianv_harris_edition/load_alignment.v \
                ../../kianv_harris_edition/multiplier_extension_decoder.v \
                ../../kianv_harris_edition/divider.v \
                ../../kianv_harris_edition/multiplier.v \
                ../../kianv_harris_edition/divider_decoder.v \
                ../../kianv_harris_edition/multiplier_decoder.v \
                ../../kianv_harris_edition/csr_exception_handler.v \
                ../../kianv_harris_edition/csr_decoder.v \
                ../../kianv_harris_edition/sv32.v \
                ../../kianv_harris_edition/sv32_table_walk.v \
                ../../kianv_harris_edition/sv32_translate_instruction_to_physical.v \
                ../../kianv_harris_edition/sv32_translate_data_to_physical.v \
                ../../kianv_harris_edition/tag_ram.v

LPF_FILE = ./colorlighti9.lpf

###################################################################
# Targets
###################################################################

# Main target
all: ${PROJ}.bit

# Generate JSON for synthesis
${PROJ}.json: ${VERILOG_FILES}
	yosys ${DEFINES} -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p "synth_ecp5 -json ${PROJ}.json -top ${PROJ}" ${VERILOG_FILES}

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
