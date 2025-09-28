###################################################################
# Makefile for KianV RISC-V SoC on CYC1000 (Cyclone 10 LP)
#
# This Makefile automates the synthesis, fitting, assembly, timing
# analysis, and programming for the KianV RISC-V SoC on an Altera
# Cyclone 10 LP FPGA (CYC1000). It uses Quartus tools to compile
# the design and create a bitstream for the target FPGA.
#
# Key Variables:
# - PROJECT: Project name (default: cyc1000-KianV-RV32IMA-SV32-xv6)
# - TOP_LEVEL_ENTITY: Top module name in the Verilog design
# - FAMILY, PART: FPGA device family and part number
# - VERILOG_DEFINE: Defines specific project options and parameters
# - SRCS: List of Verilog source files for the SoC
#
# Key Targets:
# - `all`: Builds the entire project and generates the .rbf bitstream file
# - `clean`: Removes generated files and resets the project environment
# - `program`: Programs the FPGA with the generated .sof file
# - `program-pof`: Programs the FPGA with a .pof configuration file
#
# Required Tools:
# - Quartus Prime software (path configurable with QUARTUS_PATH)
# - Quartus executables (quartus_map, quartus_fit, quartus_asm, etc.)
#
# Usage:
# - Configure the PROJECT, PART, and source files (SRCS) as needed.
# - Run `make all` to build the bitstream, `make clean` to clean the
#   directory, and `make program` to load the design onto the FPGA.
#
###################################################################

PROJECT = cyc1000-KianV-RV32IMA-SV32-xv6
TOP_LEVEL_ENTITY = soc
ASSIGNMENT_FILES = $(PROJECT).qpf $(PROJECT).qsf

VERILOG_DEFINE = -verilog_macro "SOC_IS_CYCLONE10"
VERILOG_DEFINE += -verilog_macro "SOC_HAS_8LEDS"
VERILOG_DEFINE += -verilog_macro "SYSTEM_CLK=45000000"
VERILOG_DEFINE += -verilog_macro "SOC_HAS_SDRAM_W9864G6JT"
VERILOG_DEFINE += -verilog_macro SDRAM_SIZE=$(shell echo $$((1024*1024*8)))
VERILOG_DEFINE += -verilog_macro NUM_ENTRIES_ITLB=64
VERILOG_DEFINE += -verilog_macro NUM_ENTRIES_DTLB=64
VERILOG_DEFINE += -verilog_macro ICACHE_ENTRIES_PER_WAY=64
VERILOG_DEFINE += -verilog_macro DCACHE_ENTRIES_PER_WAY=64
VERILOG_DEFINE += -verilog_macro TRP_NS=20
VERILOG_DEFINE += -verilog_macro TRC_NS=20
VERILOG_DEFINE += -verilog_macro TRCD_NS=20
VERILOG_DEFINE += -verilog_macro TCH_NS=2
VERILOG_DEFINE += -verilog_macro CAS=2

###################################################################
# Part, Family, Boardfile DE1 or DE2
FAMILY = "Cyclone 10 LP"
PART = 10CL025YU256C8G
BOARDFILE = cyc1000Pins
###################################################################

###################################################################
# Setup your sources here
#SRCS = $(wildcard ../fpga/*.sv) \
#  $(wildcard ../fpga/*.v) \
#  $(wildcard ../fpga/*.vhdl) \
#  $(wildcard ../fpga/*.vhd) \
#  $(wildcard ../fpga/*.qsys)

include ../sources.mk

###################################################################
# Main Targets
#
# all: build everything
# clean: remove output files and database
# program: program your device with the compiled design
###################################################################

all: smart.log $(PROJECT).asm.rpt $(PROJECT).sta.rpt $(PROJECT).rbf

clean:
	$(RM) -rf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof *.rbf db incremental_db *.summary *.smsg *.jdi $(ASSIGNMENT_FILES)

map: smart.log $(PROJECT).map.rpt
fit: smart.log $(PROJECT).fit.rpt
asm: smart.log $(PROJECT).asm.rpt
sta: smart.log $(PROJECT).sta.rpt
smart: smart.log
rbf: $(PROJECT).rbf

###################################################################
# Executable Configuration
#
# QUARTUS_PATH: If empty then system path is searched.
#               If set then requires trailing slash.
#               Commented out so it may be set from environment.
###################################################################

# QUARTUS_PATH = /opt/altera/13.0sp1/quartus/bin/

QUARTUS_MAP  = $(QUARTUS_PATH)quartus_map
QUARTUS_FIT  = $(QUARTUS_PATH)quartus_fit
QUARTUS_ASM  = $(QUARTUS_PATH)quartus_asm
QUARTUS_STA  = $(QUARTUS_PATH)quartus_sta
QUARTUS_SH   = $(QUARTUS_PATH)quartus_sh
QUARTUS_PGM  = $(QUARTUS_PATH)quartus_pgm
QUARTUS_CPF  = $(QUARTUS_PATH)quartus_cpf

ifeq ($(shell uname -m),x86_64)
QUARTUS_ARGS = --64bit
endif

MAP_ARGS = $(QUARTUS_ARGS) --read_settings_files=on $(addprefix --source=,$(SRCS)) $(VERILOG_DEFINE)
FIT_ARGS = $(QUARTUS_ARGS) --part=$(PART) --read_settings_files=on
ASM_ARGS = $(QUARTUS_ARGS)
STA_ARGS = $(QUARTUS_ARGS)
SH_ARGS  = $(QUARTUS_ARGS)
PGM_ARGS = $(QUARTUS_ARGS) --no_banner --mode=jtag

###################################################################
# Target implementations
###################################################################

STAMP = echo done >

$(PROJECT).map.rpt: map.chg $(SRCS)
	$(QUARTUS_MAP) $(MAP_ARGS) $(PROJECT)
	$(STAMP) fit.chg

$(PROJECT).fit.rpt: fit.chg $(PROJECT).map.rpt
	$(QUARTUS_FIT) $(FIT_ARGS) $(PROJECT)
	$(STAMP) asm.chg
	$(STAMP) sta.chg

$(PROJECT).asm.rpt: asm.chg $(PROJECT).fit.rpt
	$(QUARTUS_ASM) $(ASM_ARGS) $(PROJECT)

$(PROJECT).sta.rpt: sta.chg $(PROJECT).fit.rpt
	$(QUARTUS_STA) $(STA_ARGS) $(PROJECT)

$(PROJECT).sof: $(PROJECT).fit.rpt
	$(QUARTUS_ASM) $(ASM_ARGS) $(PROJECT)

smart.log: $(ASSIGNMENT_FILES)
	$(QUARTUS_SH) $(SH_ARGS) --determine_smart_action $(PROJECT) > smart.log

$(PROJECT).rbf: $(PROJECT).sof
	$(QUARTUS_CPF) -c output_files/$(PROJECT).sof $(PROJECT).rbf

###################################################################
# Project initialization
###################################################################

$(ASSIGNMENT_FILES):
	$(QUARTUS_SH) $(SH_ARGS) --prepare -f $(FAMILY) -t $(TOP_LEVEL_ENTITY) $(PROJECT)
	-cat $(BOARDFILE) >> $(PROJECT).qsf
	echo "set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL" >> $(PROJECT).qsf

map.chg:
	$(STAMP) map.chg

fit.chg:
	$(STAMP) fit.chg

sta.chg:
	$(STAMP) sta.chg

asm.chg:
	$(STAMP) asm.chg

###################################################################
# Programming the device
###################################################################

program: $(PROJECT).sof
	$(QUARTUS_PGM) $(PGM_ARGS) -o "P;$(PROJECT).sof"

program-pof: $(PROJECT).pof
	$(QUARTUS_PGM) $(PGM_ARGS) -o "BVP;$(PROJECT).pof"

