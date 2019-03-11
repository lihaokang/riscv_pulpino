# setup search library
# set library path 
set search_path " \
 $::env(STD_CELL_PATH)/synopsys \
 $::env(STD_CELL_PATH)/symbol \
"

# set libraries
set symbol_library $::env(SYMBOL_LIB)
set target_library $::env(TARGET_LIB)

# dw_foundation.sldb will be automatically
set link_library $::env(TARGET_LIB)

################################################################################
# Wire Load
################################################################################
set auto_wire_load_selection false
set_wire_load_mode  top
set_wire_load_model -name $::env(WIRE_LOAD_MODEL)

read_verilog ./out/$::env(DESIGN_TOP).syn.v
current_design $::env(DESIGN_TOP)

link

check_design

# source constraints.tcl 
# report_constraint -all_violators

set test_default_scan_style multiplexed_flip_flop

set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 40
set test_default_period 100 

create_test_protocol -infer_asynch -infer_clock 

# pre-scan check
report_constraint -all_violators 

# Perform pre-scan test design rule checking.
dft_drc

set_scan_configuration -chain_count 1 

# checks scan specification for consistency
preview_dft

# insert scan chain
insert_dft 

# report scan cells
report_scan_path -view existing -chain all > rpt/$::env(DESIGN_TOP)_syn_dft.scan_path
report_scan_path -view existing -cell all > rpt/$::env(DESIGN_TOP)_syn_dft.scan_cell 

# report DFT ready design
report_area > rpt/$::env(DESIGN_TOP)_syn_dft.area.rpt
report_timing > rpt/$::env(DESIGN_TOP)_syn_dft.timing.rpt
report_power > rpt/$::env(DESIGN_TOP)_syn_dft.power.rpt 

# write protocol for ATPGA
write_test_protocol -output ./out/$::env(DESIGN_TOP)_syn_dft.spf 

# write scan-ready netlist
write -hierarchy -format verilog -output ./out/$::env(DESIGN_TOP)_syn_dft.v
write -hierarchy -format ddc -output ./out/$::env(DESIGN_TOP)_syn_dft.ddc 

# write for Primetime
write_sdf -version 2.1 -context verilog ./out/$::env(DESIGN_TOP)_syn_dft.sdf

quit