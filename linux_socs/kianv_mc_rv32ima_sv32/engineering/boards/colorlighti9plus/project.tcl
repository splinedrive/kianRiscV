set_param general.maxThreads 32
read_verilog ./pll_xc7.v ../../soc.v ../../bram.v ../../tx_uart.v ../../rx_uart.v ../../fifo.v ../../qqspi.v ../../clint.v ../../spi.v ../../cache.v ../../icache.v ../../plic.v ../../sdram/m12l64322a_ctrl.v ../../kianv_harris_edition/kianv_harris_mc_edition.v ../../kianv_harris_edition/control_unit.v ../../kianv_harris_edition/datapath_unit.v ../../kianv_harris_edition/register_file.v ../../kianv_harris_edition/design_elements.v ../../kianv_harris_edition/design_elements_fpgacpu_ca.v ../../kianv_harris_edition/alu.v ../../kianv_harris_edition/main_fsm.v ../../kianv_harris_edition/extend.v ../../kianv_harris_edition/alu_decoder.v ../../kianv_harris_edition/store_alignment.v ../../kianv_harris_edition/store_decoder.v ../../kianv_harris_edition/load_decoder.v ../../kianv_harris_edition/load_alignment.v ../../kianv_harris_edition/multiplier_extension_decoder.v ../../kianv_harris_edition/divider.v ../../kianv_harris_edition/multiplier.v ../../kianv_harris_edition/divider_decoder.v ../../kianv_harris_edition/multiplier_decoder.v ../../kianv_harris_edition/csr_exception_handler.v ../../kianv_harris_edition/csr_decoder.v ../../kianv_harris_edition/sv32.v ../../kianv_harris_edition/sv32_table_walk.v ../../kianv_harris_edition/sv32_translate_instruction_to_physical.v ../../kianv_harris_edition/sv32_translate_data_to_physical.v ../../kianv_harris_edition/tag_ram.v
read_xdc colorlighti9plus.xdc
synth_design -top soc -part xc7a50tfgg484-1 -verilog_define SOC_IS_ARTIX7 -verilog_define SYSTEM_CLK=45000000 -verilog_define SOC_HAS_1LED -verilog_define SDRAM_SIZE=8388608
opt_design
place_design
route_design
write_bitstream -force soc.bit
exit
