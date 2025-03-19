PROJ=soc

RM             = rm -rf
VERILOG_FILES := gowin_rpll/gowin_rpll.v \
                 bram.v \
                 tx_uart.v \
                 rx_uart.v \
                 fifo.v \
                 qqspi.v \
                 clint.v \
                 sdram/m12l64322a_ctrl.v \
                 kianv_harris_edition/kianv_harris_mc_edition.v \
                 kianv_harris_edition/control_unit.v  \
                 kianv_harris_edition/datapath_unit.v \
                 kianv_harris_edition/register_file.v \
                 kianv_harris_edition/design_elements.v \
                 kianv_harris_edition/alu.v \
                 kianv_harris_edition/main_fsm.v \
                 kianv_harris_edition/extend.v \
                 kianv_harris_edition/alu_decoder.v \
                 kianv_harris_edition/store_alignment.v \
                 kianv_harris_edition/store_decoder.v \
                 kianv_harris_edition/load_decoder.v \
                 kianv_harris_edition/load_alignment.v \
                 kianv_harris_edition/multiplier_extension_decoder.v \
                 kianv_harris_edition/divider.v \
                 kianv_harris_edition/multiplier.v \
                 kianv_harris_edition/divider_decoder.v \
                 kianv_harris_edition/multiplier_decoder.v \
                 kianv_harris_edition/csr_exception_handler.v \
                 kianv_harris_edition/csr_decoder.v

all: ${PROJ}.fs

%.json: %.v
	yosys -p "synth_gowin -family gw2a -top ${PROJ} -json $@" ${VERILOG_FILES} $<

%_out.config: %.json
	nextpnr-himbaechel --json $< --write $@ --device GW2AR-LV18QN88C8/I7 --vopt family=GW2A-18C --vopt cst=tangnano20k.cst

%.fs: %_out.config
	gowin_pack -d GW2A-18C -o $@ $<

prog: ${PROJ}.fs
	openFPGALoader -b tangnano20k -f $<

clean:
	$(RM) -f ${PROJ}.fs ${PROJ}_out.config ${PROJ}.json

.PHONY: prog clean

