###################################################################
# Makefile for KianV RISC-V SoC on CYC1000 (Cyclone 10 LP)
###################################################################

PROJECT = qmtech_start_kit_cyclone10-KianV-RV32IMA-SV32
TOP_LEVEL_ENTITY = soc
ASSIGNMENT_FILES = $(PROJECT).qpf $(PROJECT).qsf

VERILOG_DEFINE = -verilog_macro "SOC_IS_CYCLONE10"
#VERILOG_DEFINE = -verilog_macro "SOC_HAS_1LED"
VERILOG_DEFINE += -verilog_macro "SYSTEM_CLK=50000000"
VERILOG_DEFINE += -verilog_macro "SOC_HAS_SDRAM_MT48LC16M16A2"
VERILOG_DEFINE += -verilog_macro "SOC_HAS_NETWORK"
VERILOG_DEFINE += -verilog_macro "SOC_HAS_GPIO"
VERILOG_DEFINE += -verilog_macro SDRAM_SIZE=$(shell echo $$((1024*1024*32)))
VERILOG_DEFINE += -verilog_macro NUM_ENTRIES_ITLB=32
VERILOG_DEFINE += -verilog_macro NUM_ENTRIES_DTLB=32
VERILOG_DEFINE += -verilog_macro ICACHE_ENTRIES_PER_WAY=32
VERILOG_DEFINE += -verilog_macro DCACHE_ENTRIES_PER_WAY=32
VERILOG_DEFINE += -verilog_macro DTREFI_NS=7800
VERILOG_DEFINE += -verilog_macro TRCD_NS=15
VERILOG_DEFINE += -verilog_macro TRFC_NS=66
VERILOG_DEFINE += -verilog_macro TRP_NS=15
VERILOG_DEFINE += -verilog_macro TWR_NS=15
VERILOG_DEFINE += -verilog_macro CAS=2

FAMILY = "Cyclone 10 LP"
PART = 10CL016YU484C8G
BOARDFILE = qmtech_start_kit_cyclone10.pins

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
	$(RM) -rf *.rpt *.chg smart.log *.htm *.eqn *.pin *.sof *.pof *.rbf db incremental_db *.summary *.smsg *.jdi *.sld $(ASSIGNMENT_FILES)

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
	$(QUARTUS_CPF) -c $(PROJECT).sof $(PROJECT).rbf

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
