if { ![info exists ::env(USE_ZERO_RISCY)] } {
  puts "USE_ZERO_RISCY = 0"
  set ::env(USE_ZERO_RISCY) 0
} else {
  puts "USE_ZERO_RISCY = 1"
}
if { ![info exists ::env(RISCY_RV32F)] } {
  puts "RISCY_RV32F = 0"
  set ::env(RISCY_RV32F) 0
} else {
  puts "RISCY_RV32F = 1"
}
if { ![info exists ::env(ZERO_RV32M)] } {
  puts "ZERO_RV32M = 0"
  set ::env(ZERO_RV32M) 0
} else {
  puts "ZERO_RV32M = 1"
}
if { ![info exists ::env(ZERO_RV32E)] } {
  puts "ZERO_RV32E = 0"
  set ::env(ZERO_RV32E) 0
} else {
  puts "ZERO_RV32E = 1"
}

if { $::env(USE_ZERO_RISCY)==1} {
    if {$::env(ZERO_RV32E)} {
          set NAME "MICRO_RISCY"
          puts "MICRO_RISCY COMPILATION"
    } else {
          set NAME "ZERO_RISCY"
          puts "ZERO_RISCY COMPILATION"
    }
} else {
    if {$::env(RISCY_RV32F)} {
          set NAME "RISCY_FP"
          puts "RISCY_FP COMPILATION"
    } else { 
          set NAME "RISCY"
          puts "RISCY COMPILATION"
    }
}


# create project
create_project pulpino . -part $::env(XILINX_PART)
#set_property board_part $::env(XILINX_BOARD) [current_project]




source tcl/ips_inc_dirs.tcl

# set up meaningful errors
source ../common/messages.tcl

source tcl/ips_src_files.tcl
source tcl/src_files.tcl

# add memory cuts
add_files -norecurse $FPGA_IPS/xilinx_clock_manager/ip/xilinx_clock_manager.dcp
add_files -norecurse $FPGA_IPS/xilinx_mem_instr_ram_8192/ip/xilinx_mem_instr_ram_8192.dcp
add_files -norecurse $FPGA_IPS/xilinx_mem_data_ram_4096/ip/xilinx_mem_data_ram_4096.dcp
add_files -norecurse $FPGA_IPS/xilinx_mem_boot_rom_1024/ip/xilinx_mem_boot_rom_1024.dcp

source ./tcl/ips_add_files.tcl

# add components
add_files -norecurse $SRC_COMPONENTS

# add pulpino
add_files -norecurse $SRC_PULPINO

add_files -norecurse $eflash_ctrl
add_files -norecurse $calib 
add_files -norecurse $rtc 
add_files -norecurse $wdt
add_files -norecurse $adc
add_files -norecurse $scu
add_files -norecurse $iom 
add_files -norecurse $pad

# set pulpino_top as top
set_property top pulpino_top [current_fileset]

# needed only if used in batch mode
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

add_files -fileset constrs_1 -norecurse constraints.xdc

# save area
set_property strategy Flow_AreaOptimized_High [get_runs synth_1]

# run synthesis
# first try will fail

catch {synth_design -rtl -name rtl_1 -generic USE_ZERO_RISCY=$::env(USE_ZERO_RISCY) -generic RISCY_RV32F=$::env(RISCY_RV32F) -generic ZERO_RV32M=$::env(ZERO_RV32M) -generic ZERO_RV32E=$::env(ZERO_RV32E) -verilog_define RISCV -verilog_define USE_VLOG -verilog_define LOG2N_FOR_FPGA -verilog_define DIGITAL_IP -verilog_define xilinx_fpga_mem -flatten_hierarchy full -gated_clock_conversion on -constrset constrs_1}

update_compile_order -fileset sources_1


synth_design -rtl -name rtl_1 -generic USE_ZERO_RISCY=$::env(USE_ZERO_RISCY) -generic RISCY_RV32F=$::env(RISCY_RV32F) -generic ZERO_RV32M=$::env(ZERO_RV32M) -generic ZERO_RV32E=$::env(ZERO_RV32E) -verilog_define RISCV -verilog_define USE_VLOG -verilog_define LOG2N_FOR_FPGA -verilog_define DIGITAL_IP -verilog_define xilinx_fpga_mem -flatten_hierarchy full -gated_clock_conversion on -constrset constrs_1



#set_property STEPS.SYNTH_DESIGN.ARGS.KEEP_EQUIVALENT_REGISTERS true [get_runs synth_1]
#set_property STEPS.SYNTH_DESIGN.ARGS.RESOURCE_SHARING off [get_runs synth_1]
#set_property STEPS.SYNTH_DESIGN.ARGS.NO_LC true [get_runs synth_1]
launch_runs synth_1
wait_on_run synth_1

open_run synth_1

# create reports
exec mkdir -p reports_${NAME}/
exec rm -rf reports_${NAME}/*
check_timing                                                            -file reports_${NAME}/pulpino_top.check_timing.rpt 
report_timing -max_paths 100 -nworst 100 -delay_type max -sort_by slack -file reports_${NAME}/pulpino_top.timing_WORST_100.rpt
report_timing -nworst 1 -delay_type max -sort_by group                  -file reports_${NAME}/pulpino_top.timing.rpt
report_utilization -hierarchical                                        -file reports_${NAME}/pulpino_top.utilization.rpt

# save EDIF netlist
write_edif -force pulpino_top.edn
write_verilog -force -mode synth_stub pulpino_top_stub.v
write_verilog -force -mode funcsim pulpino_top_funcsim.v
