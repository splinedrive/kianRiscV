VFILES="
top_tb.v 
top.v 
tx_uart.v
spi_nor_flash.v 
qqspi.v 
cache/cache.v
kianv_harris_edition/kianv_harris_mc_edition.v
kianv_harris_edition/control_unit.v 
kianv_harris_edition/datapath_unit.v
kianv_harris_edition/register_file.v
kianv_harris_edition/design_elements.v
kianv_harris_edition/alu.v
kianv_harris_edition/main_fsm.v
kianv_harris_edition/extend.v
kianv_harris_edition/alu_decoder.v
kianv_harris_edition/store_alignment.v
kianv_harris_edition/store_decoder.v
kianv_harris_edition/load_decoder.v
kianv_harris_edition/load_alignment.v
kianv_harris_edition/multiplier_extension_decoder.v
kianv_harris_edition/divider.v
kianv_harris_edition/multiplier.v
kianv_harris_edition/divider_decoder.v
kianv_harris_edition/multiplier_decoder.v
kianv_harris_edition/csr_unit.v
kianv_harris_edition/csr_decoder.v
"
rm -Rf obj_dir
#verilator -DSIM -O3 --trace -cc top.v kianv.v register_file.v bram.v --exe top_tb.cpp
#verilator -j $(nproc) -DSIM -O3 -GBRAM_WORDS=$((2048*8*4)) -DFIRMWARE='"./firmware/firmware.hex"' -cc top.v kianv.v register_file.v bram.v soc_hw_reg.v --exe top_tb.cpp
verilator -j $(nproc) -I./kianv_harris_edition -DSIM -O3 --top-module top -cc $VFILES --exe top_tb.cpp
make -j 9 -C obj_dir -f Vtop.mk Vtop



