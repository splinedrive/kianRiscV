###################################################################
# Makefile for Kianv RISC-V SoC on Lattice ECP5 (IceSugar-Pro)
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
# - VERILOG_FILES: List of Verilog source files for the SoC
#
# Key Targets:
# - `all`: Runs the entire build process, generating a .bit file
# - `clean`: Removes generated files to reset the build environment
#
###################################################################

PROJ=soc
SYSTEM_FREQUENCY ?= 50000000
DEFINES=-DSOC_IS_ECP5 -DSOC_HAS_SDRAM_MT48LC16M16A2 -DSOC_HAS_1LED -DSDRAM_SIZE=$$((1024*1024*32))

RM             = rm -rf
VERILOG_FILES := ../../soc.v \
                 ../../pll.v \
								 ../../bram.v \
								 ../../tx_uart.v \
								 ../../rx_uart.v \
								 ../../fifo.v \
								 ../../qqspi.v \
								 ../../clint.v \
								 ../../plic.v \
								 ../../spi_nor_flash.v \
								 ../../spi.v \
								 ../../gpio.v \
								 ../../pwm.v \
								 ../../cache.v \
								 ../../icache.v \
								 ../../sdram/mt48lc16m16a2_ctrl.v \
								 ../../kianv_harris_edition/kianv_harris_mc_edition.v \
								 ../../kianv_harris_edition/control_unit.v  \
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

LPF_FILE = ./icesugar-pro.lpf

all: ${PROJ}.bit
${PROJ}.json: ${VERILOG_FILES}
	yosys ${DEFINES} -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p "synth_ecp5 -json ${PROJ}.json -top ${PROJ}" ${VERILOG_FILES}

${PROJ}_out.config: ${PROJ}.json ${LPF_FILE}
	nextpnr-ecp5 --freq 350 --timing-allow-fail --router router1 \
		--json ${PROJ}.json --textcfg ${PROJ}_out.config --25k --speed 6 \
		--package CABGA256 --lpf ${LPF_FILE}

${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input ${PROJ}_out.config --bit ${PROJ}.bit

clean:
	$(RM) -f ${PROJ}.bit ${PROJ}_out.config ${PROJ}.json

.PHONY: clean
