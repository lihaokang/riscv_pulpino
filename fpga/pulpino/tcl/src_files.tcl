set RTL ../../rtl
set IPS ../../ips
set ipsDir ../../ips
set FPGA_IPS ../ips
set FPGA_RTL ../rtl

# components
set SRC_COMPONENTS " \
   $RTL/components/pulp_clock_gating.sv \
   $RTL/components/cluster_clock_gating.sv \
   $RTL/components/cluster_clock_inverter.sv \
   $RTL/components/cluster_clock_mux2.sv \
   $RTL/components/rstgen.sv \
   $RTL/components/pulp_clock_inverter.sv \
   $RTL/components/pulp_clock_mux2.sv \
   $RTL/components/generic_fifo.sv \
   $RTL/components/sp_ram.sv \
"

# pulpino
set SRC_PULPINO " \
   $RTL/axi2apb_wrap.sv \
   $RTL/periph_bus_wrap.sv \
   $RTL/core2axi_wrap.sv \
   $RTL/axi_node_intf_wrap.sv \
   $RTL/axi_spi_slave_wrap.sv \
   $RTL/axi_slice_wrap.sv \
   $RTL/axi_mem_if_SP_wrap.sv \
   $RTL/core_region.sv \
   $RTL/boot_code.sv \
   $RTL/instr_ram_wrap.sv \
   $RTL/sp_data_ram_wrap.sv \
   $RTL/sp_instr_ram_wrap.sv \
   $RTL/boot_rom_wrap.sv \
   $RTL/peripherals.sv \
   $RTL/ram_mux.sv \
   $RTL/pulpino_top.sv \
   $RTL/clk_rst_gen.sv \
"


set eflash_ctrl " \
$ipsDir/eflash_ctrl/rtl/eflash_ctrl.v \
"
set pad " \
$ipsDir/../verif/block/stdio/HJ110SIOPF50MVIHGSIM_A_v0.4_20160622.v \
"
set iom " \
$ipsDir/iom/iom.sv \
"

set calib " \
$ipsDir/clk_calibration/clk_calibration.v \
"

set rtc " \
$ipsDir/rtc/rtc_top.v \
"

set wdt " \
$ipsDir/wdt/wdt.v \
"
set adc " \
$ipsDir/adc/adc_control.sv \
$ipsDir/adc/apb_adc_control.sv \
$ipsDir/adc/fifo_async.sv \
"
set scu " \
$ipsDir/scu/apb_bus_dec.v \
$ipsDir/scu/clk_div.v \
$ipsDir/scu/clk_switch.v \
$ipsDir/scu/cmu.v \
$ipsDir/scu/pmu.v \
$ipsDir/scu/rst_sync.v \
$ipsDir/scu/rst_top.v \
$ipsDir/scu/scu.v \
"
