###################################################################
# Makefile for Kianv RISC-V SoC Project
#
# Adjusted for a directory structure with the Makefile in a folder
# that is two levels deeper relative to source files.
###################################################################

# Project Configuration
DEVICE ?= 85k
PROJ = soc
SYSTEM_FREQUENCY ?= 60000000
DEFINES = -DSOC_IS_ULX3S -DSOC_IS_ECP5 -DSOC_HAS_EXT_FLASH -DSOC_HAS_AUDIO -DSOC_HAS_NETWORK
DEFINES += -DSOC_HAS_EXT_OLED -DSOC_HAS_8LEDS -DSOC_HAS_GPIO -DSOC_HAS_SDRAM_MT48LC16M16A2
DEFINES += -DSDRAM_SIZE=33554432

RM = rm -rf
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

LPF_FILE = ./ulx3s_v20.lpf

# Build all steps to generate the final bitstream
all: ${PROJ}.bit

# Synthesis: Generate the JSON file
${PROJ}.json: $(VERILOG_FILES)
	yosys $(DEFINES) -DSYSTEM_CLK=${SYSTEM_FREQUENCY} -p \
        "synth_ecp5 -abc9 -json $@ -top ${PROJ}" $^

# Place and route: Generate the config file
${PROJ}_out.config: ${PROJ}.json
ifeq ($(DEVICE),um-85k)
	@echo "Using um-85k configuration"
	nextpnr-ecp5 --freq 250 --speed 7 --timing-allow-fail --json $< --textcfg $@ --um-85k --package CABGA381 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),85k)
	@echo "Using 85k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --85k --package CABGA381 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),25k)
	@echo "Using 25k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --25k --package CABGA381 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),45k)
	@echo "Using 45k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --45k --package CABGA381 --lpf $(LPF_FILE)
else ifeq ($(DEVICE),12k)
	@echo "Using 12k configuration"
	nextpnr-ecp5 --freq 250 --speed 6 --timing-allow-fail --json $< --textcfg $@ --12k --package CABGA381 --lpf $(LPF_FILE)
else
	$(error Unknown DEVICE value: $(DEVICE))
endif

# Bitstream generation: Pack the config file into a bitstream
${PROJ}.bit: ${PROJ}_out.config
	ecppack --compress --input $< --bit $@

# Clean up build artifacts
.PHONY: clean
clean:
	$(RM) *.bit *.config *.json

