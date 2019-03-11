################################################################################
# Machine options
################################################################################

# Use multiple cores
set_host_options -max_cores 8

################################################################################
# Search path
################################################################################

# set library path 
set search_path " \
 $::env(TARGET_LIB_DIR) \
 $::env(SYMBOL_LIB_DIR) \
 $::env(MEM_LIB_DIR) \
 $::env(SYNTHETIC_LIB_DIR) \
"

# set RTL search path
# set search_path [concat $::env(WS_ROOT)/rtl $::env(WS_ROOT)/ips]
set rtl_inc_path [sh cat vlog_search_path_synthesis.f]
set search_path [concat $search_path $rtl_inc_path]

################################################################################
# Libraries
################################################################################

# set libraries
set synthetic_library $::env(SYNTHETIC_LIB)
set symbol_library    $::env(SYMBOL_LIB)
set target_library    $::env(TARGET_LIB)
set link_library      [concat $target_library $synthetic_library]

# directory where DC placed intermediate files
define_design_lib WORK -path ./WORK

################################################################################
# Source Files        
################################################################################

set my_verilog_files [sh cat vlog_filelist_synthesis.f]

# Set the top module of your design
set design_top $::env(DESIGN_TOP)

################################################################################
# Read design       
################################################################################

# elaborate design
analyze -format sverilog $my_verilog_files
elaborate $design_top
current_design $design_top

################################################################################
# Design uniquification 
################################################################################
uniquify

################################################################################
## Clock constraints
################################################################################

# select clk pin on the symbol
set clock_net  clk
set clock_name clk
#create_generated_clock -name ${clock_name} \
#             -period [expr 1000 / $::env(TARGET_CLK_FREQ_MHZ)] \
#             [get_pins ${clock_net}]


# do not re-buffer the clock network since we
# are doing CTS in P&R
set_dont_touch_network [get_clocks $clock_name]

# respect the hold time requirement of all clocked flip-flops
set_fix_hold [get_clocks $clock_name]

create_clock -name  jtag_tck [get_ports {pad_jtag_tck_spad}] -period 100.000
create_clock -name  clk_32k  [get_ports {pad_xtal0_spad}] -period 100.000


create_generated_clock -name clk_rc32m -source [get_ports {pad_xtal0_spad}] -master_clock clk_32k -multiply_by 5 [get_pins analog_top/RING32M_CLK]
create_generated_clock -name clk_rc32k -source [get_ports {pad_xtal0_spad}] -master_clock clk_32k -multiply_by 1 [get_pins analog_top/RING32K_CLK]



set clk_div2_net   peripherals_i/apb_scu/cmu_u0/clk_hs_divider/clk_cnt_reg[0]/Q
set clk_div4_net   peripherals_i/apb_scu/cmu_u0/clk_hs_divider/clk_cnt_reg[1]/Q
set clk_div8_net   peripherals_i/apb_scu/cmu_u0/clk_hs_divider/clk_cnt_reg[2]/Q
set clk_div16_net  peripherals_i/apb_scu/cmu_u0/clk_hs_divider/clk_cnt_reg[3]/Q
set clk_div32_net  peripherals_i/apb_scu/cmu_u0/clk_hs_divider/clk_cnt_reg[4]/Q
set clk_sys_net    peripherals_i/apb_scu/cmu_u0/clk_sys_switch2_0/clk_gate_u0/clk_o
set clk_adc_net    peripherals_i/apb_scu/cmu_u0/adc_sys_switch2_0/clk_gate_u0/clk_o
set clk_1s_net     peripherals_i/apb_scu/cmu_u0/clk_1s_switch/clk_gate_u0/clk_o

create_generated_clock -divide_by 2  -name clk_16m -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_div2_net}]
create_generated_clock -divide_by 4  -name clk_8m  -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_div4_net}]
create_generated_clock -divide_by 8  -name clk_4m  -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_div8_net}]
create_generated_clock -divide_by 16 -name clk_2m  -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_div16_net}]
create_generated_clock -divide_by 32 -name clk_1m  -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_div32_net}]
set_clock_group -logically_exclusive -group clk_16m -group clk_8m -group clk_4m -group clk_2m -group clk_1m

set_clock_group -asynchronous -group clk_rc32m -group clk_rc32k -group clk_32k -group clk_16m -group clk_8m -group clk_4m -group clk_2m -group clk_1m
 
create_generated_clock               -name clk_sys1 -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_sys_net}]
create_generated_clock -divide_by 2  -name clk_sys2 -source [get_pins ${clk_div2_net}]        -master_clock clk_16m   [get_pins ${clk_sys_net}] -add
create_generated_clock -divide_by 4  -name clk_sys3 -source [get_pins ${clk_div4_net}]        -master_clock clk_8m    [get_pins ${clk_sys_net}] -add
create_generated_clock -divide_by 8  -name clk_sys4 -source [get_pins ${clk_div8_net}]        -master_clock clk_4m    [get_pins ${clk_sys_net}] -add
create_generated_clock -divide_by 16 -name clk_sys5 -source [get_pins ${clk_div16_net}]       -master_clock clk_2m    [get_pins ${clk_sys_net}] -add
create_generated_clock -divide_by 32 -name clk_sys6 -source [get_pins ${clk_div32_net}]       -master_clock clk_1m    [get_pins ${clk_sys_net}] -add
create_generated_clock               -name clk_sys7 -source [get_pins analog_top/RING32K_CLK] -master_clock clk_rc32k [get_pins ${clk_sys_net}] -add
create_generated_clock               -name clk_sys8 -source [get_ports {pad_xtal0_spad}]      -master_clock clk_32k   [get_pins ${clk_sys_net}] -add
set_clock_group -physically_exclusive -group clk_sys1 -group clk_sys2 -group clk_sys3 -group clk_sys4 -group clk_sys5 -group clk_sys6 -group clk_sys7 -group clk_sys8


create_generated_clock               -name clk_adc1 -source [get_pins analog_top/RING32M_CLK] -master_clock clk_rc32m [get_pins ${clk_adc_net}]
create_generated_clock -divide_by 2  -name clk_adc2 -source [get_pins ${clk_div2_net}]        -master_clock clk_16m   [get_pins ${clk_adc_net}] -add
create_generated_clock -divide_by 4  -name clk_adc3 -source [get_pins ${clk_div4_net}]        -master_clock clk_8m    [get_pins ${clk_adc_net}] -add
create_generated_clock -divide_by 8  -name clk_adc4 -source [get_pins ${clk_div8_net}]        -master_clock clk_4m    [get_pins ${clk_adc_net}] -add
create_generated_clock -divide_by 16 -name clk_adc5 -source [get_pins ${clk_div16_net}]       -master_clock clk_2m    [get_pins ${clk_adc_net}] -add
create_generated_clock -divide_by 32 -name clk_adc6 -source [get_pins ${clk_div32_net}]       -master_clock clk_1m    [get_pins ${clk_adc_net}] -add
set_clock_group -physically_exclusive -group clk_adc1 -group clk_adc2 -group clk_adc3 -group clk_adc4 -group clk_adc5 -group clk_adc6

create_generated_clock               -name clk_1s1 -source [get_pins analog_top/RING32K_CLK]  -master_clock clk_rc32m [get_pins ${clk_1s_net}]
create_generated_clock               -name clk_1s2 -source [get_ports {pad_xtal0_spad}]       -master_clock clk_32k   [get_pins ${clk_1s_net}] -add
set_clock_group -physically_exclusive -group clk_1s1 -group clk_1s2


#set_dont_touch_network [get_clocks clk_rc32m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_rc32m]

#set_dont_touch_network [get_clocks clk_rc32k]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_rc32k]

#set_dont_touch_network [get_clocks clk_16m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_16m]

#set_dont_touch_network [get_clocks clk_8m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_8m]

#set_dont_touch_network [get_clocks clk_4m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_4m]

#set_dont_touch_network [get_clocks clk_2m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_2m]

#set_dont_touch_network [get_clocks clk_1m]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_1m]

#set_dont_touch_network [get_clocks clk_32k]
#set_clock_gating_check -setup 0.5 -hold 0.5 [get_clocks clk_32k]


# set clock clock skew

# clock uncertainty
# small circuits: 0.1 ns
# large circuits: 0.3 ns
set_clock_uncertainty $::env(CLK_UNCERTAINTY) [get_clocks $clock_name]

# clock latency
# small design: 1 ns
# large design: 3 ns
set_clock_latency $::env(CLK_LATENCY) [get_clocks $clock_name]

# since we are doing CTS in P&R, the clock source driving
# capability is poor, thus we set clock tree as ideal
# network without driving issues to avoid hazard in timing
# evaluation
set_ideal_network [get_ports clk]

# clock transition
# experience: max = 0.5 ns
set_input_transition 0.5 [all_inputs]

################################################################################
# Set design environment
################################################################################

# operation condition
# set_operating_conditions –max "slow" –max_library "slow" –min "fast" -min library "fast"

# drive strength / input delay for pads 
set_drive 0.288001 [all_inputs]
set_input_delay 0.34 -clock [get_clocks $clock_name] [all_inputs]

# set load
set_load 0.06132 [all_outputs]
set_output_delay -clock $clock_name 2 [all_outputs]

# set wireload model
set auto_wire_load_selection false
set_wire_load_mode top
set_wire_load_model -name $::env(WIRE_LOAD_MODEL)


################################################################################
# Area and fanouts
################################################################################

set_max_area $::env(TARGET_AREA)
set_max_fanout $::env(MAX_FANOUT) [get_designs $design_top]

# used when you are translating some netlist from one technology to another
link

################################################################################
# Compile design
################################################################################

# completely flatten the hierarchy to allow
# optimization to cross hierarchy boundaries
ungroup -flatten -all

# check internal DC representation for design consistency
check_design

# verifies timing setup is complete
check_timing

# enable DC ultra optimizations
compile_ultra

################################################################################
# Output
################################################################################
file mkdir out

# save design
write -format ddc -hierarchy -output ./out/${design_top}.ddc

# test protocal
write_test_protocol -output ./out/${design_top}.spf

# save delay and parasitic data
write_sdf -version 1.0 out/${design_top}.sdf

# this file is necessary for P&R with Encounter
write_sdc out/${design_top}.sdc

# save synthesized verilog netlist
write -format verilog -hierarchy -output ./out/${design_top}.syn.v

# write milkyway database
if {[shell_is_in_topographical_mode]} {
    write_milkyway -output $design_top -overwrite
}

# report
file mkdir rpt
report_design >> rpt/${design_top}_design.rpt
report_area >> rpt/${design_top}_area.rpt
report_reference >> rpt/${design_top}_area.rpt
report_register -level_sensitive >> rpt/${design_top}_latches.rpt
report_register -edge >> rpt/${design_top}_flops.rpt
report_constraint -all_violators >> rpt/${design_top}_violators.rpt
report_power >> rpt/${design_top}_power.rpt
report_timing -path full -nosplit >> rpt/${design_top}_min_timing.rpt

quit
