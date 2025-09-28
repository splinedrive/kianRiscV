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
SYSTEM_FREQUENCY ?= 48000000

# Vivado Paths
VIVADO = vivado
VIVADO_FLAGS = -mode batch -source
PROJECT_DIR := $(shell pwd)
DEFINES := -verilog_define SOC_IS_ARTIX7 \
           -verilog_define SOC_HAS_SDRAM_MT48LC16M16A2 \
           -verilog_define SOC_HAS_1LED \
           -verilog_define SDRAM_SIZE=$$((1024*1024*32)) \
					 -verilog_define NUM_ENTRIES_ITLB=64 \
					 -verilog_define NUM_ENTRIES_DTLB=64 \
					 -verilog_define ICACHE_ENTRIES_PER_WAY=64 \
					 -verilog_define DCACHE_ENTRIES_PER_WAY=64 \
					 -verilog_define TRP_NS=15 \
					 -verilog_define TRC_NS=60 \
					 -verilog_define TRCD_NS=15 \
					 -verilog_define TCH_NS=2 \
					 -verilog_define CAS=2

include ../sources.mk

# Xilinx Part and Constraints
PART = xc7a35tftg256-1
CONSTRAINTS = kirsch.xdc

# Bitstream Target
all: $(PROJ).bit

# Synthesis, Implementation, and Bitstream Generation
$(PROJ).bit: project.tcl $(SRCS) $(CONSTRAINTS)
	$(VIVADO) $(VIVADO_FLAGS) project.tcl -tclargs $(PART) $(PROJ) $(CONSTRAINTS)

# Generate project.tcl Script
project.tcl:
	echo "set_param general.maxThreads $(NUM_CPUS)" > project.tcl
	echo "read_verilog $(SRCS)" >> project.tcl
	echo "read_xdc $(CONSTRAINTS)" >> project.tcl
	echo "synth_design -top $(PROJ) -part $(PART) ${DEFINES} -verilog_define SYSTEM_CLK=$(SYSTEM_FREQUENCY)" >> project.tcl
	echo "opt_design" >> project.tcl
	echo "place_design" >> project.tcl
	echo "route_design" >> project.tcl
	echo "write_bitstream -force $(PROJ).bit" >> project.tcl
	echo "exit" >> project.tcl

# Clean Target
.PHONY: clean
clean:
	rm -rf project.tcl .Xil *.bit *.jou *.log *.str vivado*
