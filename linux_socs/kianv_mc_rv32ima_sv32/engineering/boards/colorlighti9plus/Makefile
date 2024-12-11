###################################################################
# Makefile for Kianv RISC-V SoC on Xilinx Artix-7 (Colorlight i9+)
#
# This Makefile automates the design synthesis, implementation,
# and bitstream generation for the Kianv RISC-V SoC on an Artix-7
# FPGA using the Colorlight i9+ board. The Makefile leverages
# Xilinx Vivado to compile and generate the bitstream.
#
# Key Variables:
# - NUM_CPUS: Number of CPU cores to utilize in parallel processing
# - PROJ: Project name (default: soc)
# - SYSTEM_FREQUENCY: Target system clock frequency in Hz (default: 45 MHz)
# - PART: Xilinx FPGA part identifier for Artix-7 on Colorlight i9+
# - CONSTRAINTS: Xilinx Design Constraints (.xdc) file specifying pin mappings
# - VIVADO_FLAGS: Flags to configure Vivado's batch processing mode
# - SRCS: List of Verilog source files for SoC and modules
#
# Key Targets:
# - `all`: Main target, generates the .bit file
# - `clean`: Removes generated files and resets project environment
#
# Project Flow:
# 1. Synthesis, optimization, placement, and routing are done by Vivado.
# 2. `project.tcl` is generated to define project flow and configurations.
# 3. The Vivado project is processed in batch mode to generate the final .bit file.
#
# Usage:
# - Run `make all` to build the bitstream.
# - Run `make clean` to remove temporary and output files.
# - Adjust `SYSTEM_FREQUENCY` or `PART` as needed based on target hardware.
#
###################################################################

# Project and System Frequency
NUM_CPUS := $(shell nproc)
PROJ = soc
SYSTEM_FREQUENCY ?= 45000000

# Vivado Paths
VIVADO = vivado
VIVADO_FLAGS = -mode batch -source
PROJECT_DIR = $(PWD)
DEFINES := -verilog_define SOC_IS_ARTIX7 \
           -verilog_define SOC_HAS_SDRAM_M12L64322A \
           -verilog_define SOC_HAS_1LED \
           -verilog_define SDRAM_SIZE=$$((1024*1024*8)) \
					 -verilog_define NUM_ENTRIES_ITLB=64 \
					 -verilog_define NUM_ENTRIES_DTLB=64 \
					 -verilog_define ICACHE_ENTRIES_PER_WAY=64 \
					 -verilog_define TRP_NS=15 \
					 -verilog_define TRC_NS=60 \
					 -verilog_define TRCD_NS=15 \
					 -verilog_define TCH_NS=2 \
					 -verilog_define CAS=2


include ../sources.mk

# Xilinx Part and Constraints
PART = xc7a50tfgg484-1
CONSTRAINTS = colorlighti9plus.xdc

# Bitstream target
all: ${PROJ}.bit

# Synthesis, Implementation, and Bitstream Generation
%.bit: project.tcl $(SRCS) $(CONSTRAINTS)
	$(VIVADO) $(VIVADO_FLAGS) project.tcl -tclargs $(PART) $(PROJ) $(CONSTRAINTS)

# TCL script to generate the Vivado project and run the flow
project.tcl:
	echo "set_param general.maxThreads $(NUM_CPUS)" > project.tcl
	echo "read_verilog $(SRCS)" >> project.tcl
	echo "read_xdc $(CONSTRAINTS)" >> project.tcl
	echo "synth_design -top $(PROJ) -part $(PART) ${DEFINES} -verilog_define SYSTEM_CLK=$(SYSTEM_FREQUENCY)" >> project.tcl
	echo "opt_design" >> project.tcl
	echo "place_design" >> project.tcl
	echo "route_design" >> project.tcl
	echo "write_bitstream -force ${PROJ}.bit" >> project.tcl
	echo "exit" >> project.tcl


.PHONY: clean
clean:
	$(RM) -r .Xil  # Add '-r' to recursively remove the .Xil directory
	$(RM) clockInfo.txt
	$(RM) *.bit *.jou *.log *.str project.tcl vivado*


