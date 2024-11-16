###################################################################
# Makefile for Kianv RISC-V SoC - Xilinx Vivado Workflow
#
# This Makefile automates the synthesis and implementation flow
# for the Kianv RISC-V SoC on Xilinx FPGAs using Vivado.
# It includes project settings, Vivado configuration, and defines
# for SoC features.
#
# Key Variables:
# - NUM_CPUS: Number of threads for parallel processing
# - PROJ: Project name (default: soc)
# - SYSTEM_FREQUENCY: System clock frequency in Hz (default: 60 MHz)
# - PART: Xilinx FPGA part name (target device)
# - CONSTRAINTS: Xilinx Design Constraints (.xdc) file
#
# Key Targets:
# - `all`: Generates the bitstream for the specified project
# - `clean`: Removes temporary files and directories created by Vivado
#
###################################################################

NUM_CPUS := $(shell nproc)
PROJ = soc
SYSTEM_FREQUENCY ?= 60000000

# Vivado Paths
VIVADO = vivado
VIVADO_FLAGS = -mode batch -source
PROJECT_DIR = $(PWD)
DEFINES=-verilog_define SOC_IS_ARTIX7 -verilog_define SOC_HAS_AUDIO -verilog_define SOC_HAS_NETWORK -verilog_define SOC_HAS_GPIO -verilog_define SOC_HAS_SDRAM_MT48LC16M16A2 -verilog_define SOC_HAS_1LED
DEFINES +=-verilog_define SDRAM_SIZE=$$((1024*1024*32))

# Verilog Files
VERILOG_FILES := ../../pll_xc7.v \
                 ../../soc.v \
                 ../../bram.v \
                 ../../tx_uart.v \
                 ../../rx_uart.v \
                 ../../fifo.v \
                 ../../qqspi.v \
                 ../../clint.v \
								 ../../plic.v \
                 ../../spi.v \
                 ../../icache.v \
                 ../../cache.v \
								 ../../gpio.v \
								 ../../pwm.v \
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

# Xilinx Part and Constraints
PART = xc7a100tfgg676-1
CONSTRAINTS = wukong_v3.xdc

# Bitstream target
all: ${PROJ}.bit

# Synthesis, Implementation, and Bitstream Generation
%.bit: project.tcl $(VERILOG_FILES) $(CONSTRAINTS)
	$(VIVADO) $(VIVADO_FLAGS) project.tcl -tclargs $(PART) $(PROJ) $(CONSTRAINTS)

# TCL script to generate the Vivado project and run the flow
project.tcl:
	echo "set_param general.maxThreads $(NUM_CPUS)" > project.tcl
	echo "read_verilog $(VERILOG_FILES)" >> project.tcl
	echo "read_xdc $(CONSTRAINTS)" >> project.tcl
	echo "synth_design -top $(PROJ) -part $(PART) ${DEFINES} -verilog_define SYSTEM_CLK=$(SYSTEM_FREQUENCY)" >> project.tcl
	echo "opt_design" >> project.tcl
	echo "place_design" >> project.tcl
	echo "route_design" >> project.tcl
	echo "write_bitstream -force ${PROJ}.bit" >> project.tcl
	echo "exit" >> project.tcl


.PHONY: clean
clean:
	$(RM) -r project.tcl
	$(RM) -r .Xil  # Add '-r' to recursively remove the .Xil directory
	$(RM) *.bit *.jou *.log *.str project.tcl vivado*


