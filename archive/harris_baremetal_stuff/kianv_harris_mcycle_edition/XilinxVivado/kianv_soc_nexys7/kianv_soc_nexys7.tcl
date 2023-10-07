open_project {kianv_soc_nexys7.xpr}
update_compile_order -fileset sources_1
reset_run synth_1
reset_run impl_1 -prev_step
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
