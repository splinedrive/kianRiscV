#!/bin/bash
VFILES="
       kianv_harris_mc_edition.v
       control_unit.v datapath_unit.v
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
       csr_unit.v
       csr_decoder.v
       "
#iverilog $VFILES && ./a.out -fst
FILEwoSUFFIX=`echo $1 | cut -d '.' -f1`
echo $FILEwoSUFFIX
yosys -p "prep -top $FILEwoSUFFIX; write_json output.json" $VFILES
netlistsvg output.json -o $FILEwoSUFFIX.svg
