read_netlist ./out/$::env(DESIGN_TOP)_syn_dft.v
read_netlist $::env(STD_CELL_PATH)/verilog/ua11lscef15bdrll_pg_sdf21.v

run_build_model $::env(DESIGN_TOP)

run drc out/$::env(DESIGN_TOP)_syn_dft.spf

set faults -model stuck
add faults -all

set_atpg -abort_limit 100 -merge high
run_atpg -auto_compression

report_summaries 

set_faults -report collapsed
report_summaries

set_faults -fault_coverage
report_summaries 

report patterns -all

write_patterns ./out/$::env(DESIGN_TOP)_syn_ATPG.wgl -format WGL
write_patterns ./out/$::env(DESIGN_TOP)_syn_ATPG.stil -format STIL 

write_patterns $::env(DESIGN_TOP)_syn_ATPG_tb.v -format verilog 