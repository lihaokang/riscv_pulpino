

set RTL ../../rtl
set IPS ../../ips
set FPGA_IPS ../ips
set FPGA_RTL ../rtl
set FPGA_PULPINO ../pulpino

# create project
create_project pulpemu . -part $::env(XILINX_PART)


# set up meaningful errors
source ../common/messages.tcl

# create block design
#source tcl/ps7_bd.tcl

# validate
#validate_bd_design

# generate
#generate_target all [get_files ./pulpemu.srcs/sources_1/bd/ps7/ps7.bd]
#make_wrapper -files [get_files ./pulpemu.srcs/sources_1/bd/ps7/ps7.bd] -top
#add_files -norecurse ./pulpemu.srcs/sources_1/bd/ps7/hdl/ps7_wrapper.v

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# add pulpemu_top
#add_files -norecurse ../rtl/clk_rst_gen.v
add_files -norecurse ../rtl/pulpemu_top.v
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# add pulpino
#if { $::env(USE_ZERO_RISCY)==0 & $::env(RISCY_RV32F)==1 } {
#    add_files -norecurse ../pulpino/pulpino.edn \
#	../pulpino/pulpino_stub.v \
#	../ips/xilinx_fp_fma/ip/xilinx_fp_fma_stub.vhdl \
#	../ips/xilinx_fp_fma/ip/xilinx_fp_fma_stub.v \
#	../pulpino/xilinx_fp_fma_floating_point_v7_1_viv.edn \
#	../pulpino/xilinx_fp_fma_mult_gen_v12_0_viv.edn \
#	../ips/xilinx_clock_manager/ip/xilinx_clock_manager.dcp
#} else {
#    add_files -norecurse ../pulpino/pulpino.edn \
#	../pulpino/pulpino_stub.v \
#	../ips/xilinx_clock_manager/ip/xilinx_clock_manager.dcp
#}

add_files -norecurse ../pulpino/pulpino_top.edn \ ../pulpino/pulpino_top_stub.v
add_files -norecurse ../ips/xilinx_clock_manager/ip/xilinx_clock_manager.dcp

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
get_property source_mgmt_mode [current_project]
set_property source_mgmt_mode DisplayOnly [current_project]
get_property source_mgmt_mode [current_project]

# save area
set_property strategy Flow_AreaOptimized_High [get_runs synth_1]

# synthesize
synth_design -rtl -name rtl_1

launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1
# write_edif pulpemu.edf

# export hardware design for sdk
#write_hwdef -force -file ./pulpemu.hwdef

# run implementation
source tcl/impl.tcl
