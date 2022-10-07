TOP := top.sv
TOP_MODULE := $(basename $(TOP))
VERILOG_FILES := $(TOP) \
								 riscv_defines.svh \
								 kianv_harris_sc_edition.sv \
								 control_unit.sv \
								 datapath_unit.sv \
								 main_decoder.sv \
								 extend.sv \
								 register_file32.sv \
								 design_elements.sv \
								 adder.sv \
								 alu32.sv \
								 csr_unit.sv \
								 csr_decoder.sv \
								 load_alignment.sv \
								 load_decoder.sv \
								 store_alignment.sv \
								 store_decoder.sv \
								 alu_decoder.sv \
								 dmem32.sv \
								 imem32.sv \
								 pseudo_havard.sv 
#								 unittest.sv
TOP_LEVEL=$(basename $(top_level))

#objects := $(wildcard *.sv *.svh)
all: isim

objects := $(VERILOG_FILES)
beauty: format lint

format: $(objects)
	verible-verilog-format --inplace $?

lint: $(objects)
	verilator --top $(TOP_MODULE) --lint-only $?

xsim_gui: xelab
	xsim --gui sim_snapshot.wdb
xsim: xelab
	xsim sim_snapshot

xelab: xvlog
	xelab -debug typical -top top_tb -snapshot sim_snapshot

xvlog: $(objects)
	xvlog -sv top_tb.sv $?

isim: iverilog
	./a.out

iverilog: $(objects)
	iverilog  -DSIM -g2012 -g2005-sv -s top_tb top_tb.sv $?

verilator: $(objects)
	verilator -DSIM -j $(nproc) -CFLAGS "-O3 -static -s" -LDFLAGS "-static" --trace -O3  --exe top_tb.cpp --top-module top -cc $?
	make -j $(nproc) -C obj_dir -f Vtop.mk Vtop

diagram: $(objects)
	@echo "Generating schematic for: "$(TOP_LEVEL)
	yosys -p "read_verilog -sv $(objects); prep -top $(TOP_LEVEL); write_json output.json"
	netlistsvg output.json -o $(TOP_LEVEL).svg
	display $(TOP_LEVEL).svg

.PHONE: clean
clean:
	rm -f output.json a.out *.svg
	rm -Rf obj_dir
	rm -f xvlog.*
	rm -f xelab.*
	rm -Rf xsim.dir
