#!/bin/bash
VFILES="
       top_tb.v
       kianv_harris_mc_edition.v
       control_unit.v datapath_unit.v
       unittest.v
       register_file.v
       design_elements.v
       alu.v
       main_fsm.v
       extend.v
       alu_decoder.v
       ../bram.v
       store_alignment.v
       store_decoder.v
       load_decoder.v
       load_alignment.v
       multiplier_extension_decoder.v
       divider.v
       multiplier.v
       divider_decoder.v
       multiplier_decoder.v
       csr_exception_handler.v
       csr_decoder.v
       "
iverilog -DSIM $VFILES && ./a.out -fst +test=$1
