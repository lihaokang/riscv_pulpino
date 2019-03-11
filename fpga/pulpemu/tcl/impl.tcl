# clocks
#create_clock -period 50.000 -name clk      [get_nets {pulpino_wrap_i/clk}]
#create_clock -period 40.000 -name spi_sck  [get_nets {pulpino_wrap_i/spi_clk_i}]
#create_clock -period 40.000 -name tck      [get_nets {pulpino_wrap_i/tck_i}]

# define false paths between all clocks
#set_clock_groups -asynchronous \
#                 -group { clk } \
#                 -group { spi_sck } \
#                 -group { tck }

create_clock -period 10.000 -name ext_clk_i [get_nets ext_clk_i]

# ----------------------------------------------------------------------------
# CLK & RESET
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN C2 [get_ports ext_rstn_i]
set_property PACKAGE_PIN E3 [get_ports ext_clk_i]


set_property IOSTANDARD LVCMOS33 [get_ports ext_rstn_i]
set_property IOSTANDARD LVCMOS33 [get_ports ext_clk_i]


# ----------------------------------------------------------------------------
# User LEDs
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN H5 [get_ports {LD_o[0]}]
set_property PACKAGE_PIN J5 [get_ports {LD_o[1]}]
set_property PACKAGE_PIN T9 [get_ports {LD_o[2]}]
set_property PACKAGE_PIN T10 [get_ports {LD_o[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {LD_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LD_o[3]}]

# ----------------------------------------------------------------------------
# JTAG
# ----------------------------------------------------------------------------

##Pmod Header JA

set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { ext_tck_i }]; #IO_0_15 Sch=ja[1]
set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { ext_tdo_o }]; #IO_L6N_T0_VREF_15 Sch=ja[7]
set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { ext_tms_i }]; #IO_L4P_T0_15 Sch=ja[2]
set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { ext_tdi_i }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { ext_trst_ni }]; #IO_L4N_T0_15 Sch=ja[3]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ext_tck_i_IBUF]

# ----------------------------------------------------------------------------
# UART
# ----------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { ext_uart_tx }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { ext_uart_rx }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in


#ChipKit SPI master
#ChipKit Digital I/O Low
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi_cs }]; #IO_L16P_T2_CSI_B_14 Sch=ck_io[0]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi_miso }]; #IO_L18P_T2_A12_D28_14 Sch=ck_io[1]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi_sck }]; #IO_L19P_T3_A10_D26_14 Sch=ck_io[3]
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi_mosi }]; #IO_L5P_T0_D06_14 Sch=ck_io[4]

#ChipKit SPI Slave
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ext_spi_sck_IBUF]

set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { ext_spi_miso }]; #IO_L17N_T2_35 Sch=ck_miso
set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { ext_spi_mosi }]; #IO_L17P_T2_35 Sch=ck_mosi
set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { ext_spi_sck }]; #IO_L18P_T2_35 Sch=ck_sck
set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { ext_spi_cs }]; #IO_L16N_T2_35 Sch=ck_ss

#ChipKit I2C
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ext_scl }]; #IO_L4P_T0_D04_14 Sch=ck_scl
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { ext_sda }]; #IO_L4N_T0_D05_14 Sch=ck_sda
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { ext_scl_pup }]; #IO_L9N_T1_DQS_AD3N_15 Sch=scl_pup
set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports { ext_sda_pup }]; #IO_L9P_T1_DQS_AD3P_15 Sch=sda_pup

#Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { ext_sw0 }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { ext_sw1 }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { ext_sw2 }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { ext_sw3 }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]


#LEDs

set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led0_b }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { led0_g }]; #IO_L19N_T3_VREF_35 Sch=led0_g
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { led0_r }]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { led1_b }]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { led1_g }]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { led1_r }]; #IO_L20N_T3_35 Sch=led1_r
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { led2_b }]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { led2_g }]; #IO_L22N_T3_35 Sch=led2_g
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { led2_r }]; #IO_L22P_T3_35 Sch=led2_r
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { led3_b }]; #IO_L23P_T3_35 Sch=led3_b
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { led3_g }]; #IO_L24P_T3_35 Sch=led3_g
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { led3_r }]; #IO_L23N_T3_35 Sch=led3_r



#Buttons

set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L12P_T1_MRCC_16 Sch=btn[3]



set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi1_mosi }]; #IO_L11P_T1_SRCC_14 Sch=ck_io[8]
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi1_miso }]; #IO_L10P_T1_D14_14 Sch=ck_io[9]
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi1_sck }]; #IO_L18N_T2_A11_D27_14 Sch=ck_io[10]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { ext_m_spi1_cs }]; #IO_L17N_T2_A13_D29_14 Sch=ck_io[11]

set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { ext_scl1 }]; #IO_L12N_T1_MRCC_14 Sch=ck_io[12]
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { ext_sda1 }]; #IO_L12P_T1_MRCC_14 Sch=ck_io[13]


set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ext_uart0_rx }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=ck_io[34]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { ext_uart0_tx }]; #IO_L11N_T1_SRCC_14 Sch=ck_io[35]


###Pmod Header JB

#set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_L12P_T1_MRCC_15 Sch=jb[1]//E15
#set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { uart1_tx }]; #IO_L12N_T1_MRCC_15 Sch=jb[2] //E16
#set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { uart2_tx }]; #IO_L22N_T3_A16_15 Sch=jb[3]// //D15
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { uart3_tx }]; #IO_L23P_T3_FOE_B_15 Sch=jb[4]//C15
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L23N_T3_FWE_B_15 Sch=jb[7] //J17
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { uart1_rx}]; #IO_L24P_T3_RS1_15 Sch=jb[8]//J18
#set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { uart2_rx}]; #IO_L24N_T3_RS0_15 Sch=jb[9]//K15
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { uart3_rx }]; #IO_25_15 Sch=jb[10] //J15


###Pmod Header JD

#set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { uart4_tx }]; #IO_L11N_T1_SRCC_35 Sch=jd[1]
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { uart5_tx }]; #IO_L12N_T1_MRCC_35 Sch=jd[2]
##set_property -dict { PACKAGE_PIN F4    IOSTANDARD LVCMOS33 } [get_ports { jd[3] }]; #IO_L13P_T2_MRCC_35 Sch=jd[3]
##set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { jd[4] }]; #IO_L13N_T2_MRCC_35 Sch=jd[4]
#set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { uart4_rx }]; #IO_L14P_T2_SRCC_35 Sch=jd[7]
#set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { uart5_rx }]; #IO_L14N_T2_SRCC_35 Sch=jd[8]
##set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { jd[9] }]; #IO_L15P_T2_DQS_35 Sch=jd[9]
##set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { jd[10] }]; #IO_L15N_T2_DQS_35 Sch=jd[10]



# physical constraints
# source tcl/floorplan.xdc

save_constraints

# set for RuntimeOptimized implementation
# set_property "steps.opt_design.args.directive" "RuntimeOptimized"   [get_runs impl_1]
# set_property "steps.place_design.args.directive" "RuntimeOptimized" [get_runs impl_1]
# set_property "steps.route_design.args.directive" "RuntimeOptimized" [get_runs impl_1]
set_property strategy Area_Explore [get_runs impl_1]

launch_runs impl_1
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# report area utilization
report_utilization -hierarchical -hierarchical_depth 1 -file pulpemu.txt
report_utilization -hierarchical -hierarchical_depth 2 -cells pulpino_top_i -file pulpino_top.txt

report_timing_summary -file pulpemu_timing_summary.txt
report_timing         -file pulpemu_timing.txt         -max_paths 10

# output Verilog netlist + SDC for timing simulation
#write_verilog -force -mode timesim -cell pulpino_wrap_i ../simu/pulpino_impl.v
#write_sdf     -force -cell pulpino_wrap_i ../simu/pulpino_impl.sdf

#if { [info exists ::env(PROBES)] } {
   # create new design run for probes
#   create_run impl_2 -parent_run synth_1 -flow {Vivado Implementation 2014}
#   current_run [get_runs impl_2]
#   set_property incremental_checkpoint pulpemu.runs/impl_1/pulpemu_top_routed.dcp [get_runs impl_2]
#   set_property strategy Flow_RuntimeOptimized [get_runs impl_2]
#   open_run synth_1
#   #link_design -name netlist_1
#   source tcl/probes.tcl
#   save_constraints
#   reset_run impl_2

#   # set for RuntimeOptimized implementation
#   set_property "steps.opt_design.args.directive" "RuntimeOptimized" [get_runs impl_2]
#   set_property "steps.place_design.args.directive" "RuntimeOptimized" [get_runs impl_2]
#   set_property "steps.route_design.args.directive" "RuntimeOptimized" [get_runs impl_2]

#   launch_runs impl_2 -to_step write_bitstream
#   wait_on_run impl_2
#}

