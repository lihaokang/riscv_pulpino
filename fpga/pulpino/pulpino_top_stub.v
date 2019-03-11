// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Sun Feb  3 13:13:47 2019
// Host        : corelink218 running 64-bit CentOS Linux release 7.6.1810 (Core)
// Command     : write_verilog -force -mode synth_stub pulpino_top_stub.v
// Design      : pulpino_top
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pulpino_top(clk_sys, rstn_sys, clk, rst_n, clk_sel_i, 
  clk_standalone_i, testmode_i, fetch_enable_i, scan_enable_i, boot_sel_0_i, boot_sel_1_i, 
  spi_clk_i, spi_cs_i, spi_mode_o, spi_sdo0_o, spi_sdo1_o, spi_sdo2_o, spi_sdo3_o, spi_sdi0_i, 
  spi_sdi1_i, spi_sdi2_i, spi_sdi3_i, spi_master_clk_o, spi_master_csn0_o, spi_master_csn1_o, 
  spi_master_csn2_o, spi_master_csn3_o, spi_master_mode_o, spi_master_sdo0_o, 
  spi_master_sdo1_o, spi_master_sdo2_o, spi_master_sdo3_o, spi_master_sdi0_i, 
  spi_master_sdi1_i, spi_master_sdi2_i, spi_master_sdi3_i, scl_pad_i, scl_pad_o, 
  scl_padoen_o, sda_pad_i, sda_pad_o, sda_padoen_o, uart_tx, uart_rx, uart_rts, uart_dtr, uart_cts, 
  uart_dsr, gpio_in, gpio_out, gpio_dir, \gpio_padcfg[31] , \gpio_padcfg[30] , 
  \gpio_padcfg[29] , \gpio_padcfg[28] , \gpio_padcfg[27] , \gpio_padcfg[26] , 
  \gpio_padcfg[25] , \gpio_padcfg[24] , \gpio_padcfg[23] , \gpio_padcfg[22] , 
  \gpio_padcfg[21] , \gpio_padcfg[20] , \gpio_padcfg[19] , \gpio_padcfg[18] , 
  \gpio_padcfg[17] , \gpio_padcfg[16] , \gpio_padcfg[15] , \gpio_padcfg[14] , 
  \gpio_padcfg[13] , \gpio_padcfg[12] , \gpio_padcfg[11] , \gpio_padcfg[10] , 
  \gpio_padcfg[9] , \gpio_padcfg[8] , \gpio_padcfg[7] , \gpio_padcfg[6] , \gpio_padcfg[5] , 
  \gpio_padcfg[4] , \gpio_padcfg[3] , \gpio_padcfg[2] , \gpio_padcfg[1] , \gpio_padcfg[0] , 
  clk_standard, clk_calib_rc32m, clk_calib_rc32k, freq_sel_rc32m, freq_sel_rc32k, regin0, 
  regin1, adc_start, adc_rstb, adc_clkin_ana, adc_ckout, adc_dout, rst_async_por_n, 
  rst_async_key_n, pvd_in, pvd_sel, pd_ldo15, pd_v2i, pd_pvd, clk_rc32m, clk_rc32k, clk_32k, 
  rc32m_ready, rc32k_ready, rc32m_pd, shortxixo, en_xtal32k, ext_en_xtal32k, uart1_tx, uart1_rx, 
  uart1_rts, uart1_dtr, uart1_cts, uart1_dsr, uart2_tx, uart2_rx, uart2_rts, uart2_dtr, uart2_cts, 
  uart2_dsr, uart3_tx, uart3_rx, uart3_rts, uart3_dtr, uart3_cts, uart3_dsr, uart4_tx, uart4_rx, 
  uart4_rts, uart4_dtr, uart4_cts, uart4_dsr, uart5_tx, uart5_rx, uart5_rts, uart5_dtr, uart5_cts, 
  uart5_dsr, spi1_master_clk_o, spi1_master_csn0_o, spi1_master_csn1_o, spi1_master_csn2_o, 
  spi1_master_csn3_o, spi1_master_mode_o, spi1_master_sdo0_o, spi1_master_sdo1_o, 
  spi1_master_sdo2_o, spi1_master_sdo3_o, spi1_master_sdi0_i, spi1_master_sdi1_i, 
  spi1_master_sdi2_i, spi1_master_sdi3_i, scl1_pad_i, scl1_pad_o, scl1_padoen_o, sda1_pad_i, 
  sda1_pad_o, sda1_padoen_o, tck_i, trstn_i, tms_i, tdi_i, tdo_o, o_addr_eflsh, o_addr_1_eflsh, 
  o_word_eflsh, o_din_eflsh, i_dout_eflsh, o_resetb_eflsh, o_cs_eflsh, o_ae_eflsh, o_oe_eflsh, 
  o_ifren_eflsh, o_nvstr_eflsh, o_prog_eflsh, o_sera_eflsh, o_mase_eflsh, i_tbit_eflsh, 
  i_smten_pad, i_sce_pad, sclk_pad, o_sio_oen_pad, o_sio_pad, i_sio_pad, o_smten_eflsh, 
  o_sce_eflsh, sclk_eflsh, i_sio_oen_eflsh, i_sio_eflsh, o_sio_eflsh, \pad_cfg_o[31] , 
  \pad_cfg_o[30] , \pad_cfg_o[29] , \pad_cfg_o[28] , \pad_cfg_o[27] , \pad_cfg_o[26] , 
  \pad_cfg_o[25] , \pad_cfg_o[24] , \pad_cfg_o[23] , \pad_cfg_o[22] , \pad_cfg_o[21] , 
  \pad_cfg_o[20] , \pad_cfg_o[19] , \pad_cfg_o[18] , \pad_cfg_o[17] , \pad_cfg_o[16] , 
  \pad_cfg_o[15] , \pad_cfg_o[14] , \pad_cfg_o[13] , \pad_cfg_o[12] , \pad_cfg_o[11] , 
  \pad_cfg_o[10] , \pad_cfg_o[9] , \pad_cfg_o[8] , \pad_cfg_o[7] , \pad_cfg_o[6] , 
  \pad_cfg_o[5] , \pad_cfg_o[4] , \pad_cfg_o[3] , \pad_cfg_o[2] , \pad_cfg_o[1] , 
  \pad_cfg_o[0] , pad_mux_o)
/* synthesis syn_black_box black_box_pad_pin="clk_sys,rstn_sys,clk,rst_n,clk_sel_i,clk_standalone_i,testmode_i,fetch_enable_i,scan_enable_i,boot_sel_0_i,boot_sel_1_i,spi_clk_i,spi_cs_i,spi_mode_o[1:0],spi_sdo0_o,spi_sdo1_o,spi_sdo2_o,spi_sdo3_o,spi_sdi0_i,spi_sdi1_i,spi_sdi2_i,spi_sdi3_i,spi_master_clk_o,spi_master_csn0_o,spi_master_csn1_o,spi_master_csn2_o,spi_master_csn3_o,spi_master_mode_o[1:0],spi_master_sdo0_o,spi_master_sdo1_o,spi_master_sdo2_o,spi_master_sdo3_o,spi_master_sdi0_i,spi_master_sdi1_i,spi_master_sdi2_i,spi_master_sdi3_i,scl_pad_i,scl_pad_o,scl_padoen_o,sda_pad_i,sda_pad_o,sda_padoen_o,uart_tx,uart_rx,uart_rts,uart_dtr,uart_cts,uart_dsr,gpio_in[31:0],gpio_out[31:0],gpio_dir[31:0],\gpio_padcfg[31] [5:0],\gpio_padcfg[30] [5:0],\gpio_padcfg[29] [5:0],\gpio_padcfg[28] [5:0],\gpio_padcfg[27] [5:0],\gpio_padcfg[26] [5:0],\gpio_padcfg[25] [5:0],\gpio_padcfg[24] [5:0],\gpio_padcfg[23] [5:0],\gpio_padcfg[22] [5:0],\gpio_padcfg[21] [5:0],\gpio_padcfg[20] [5:0],\gpio_padcfg[19] [5:0],\gpio_padcfg[18] [5:0],\gpio_padcfg[17] [5:0],\gpio_padcfg[16] [5:0],\gpio_padcfg[15] [5:0],\gpio_padcfg[14] [5:0],\gpio_padcfg[13] [5:0],\gpio_padcfg[12] [5:0],\gpio_padcfg[11] [5:0],\gpio_padcfg[10] [5:0],\gpio_padcfg[9] [5:0],\gpio_padcfg[8] [5:0],\gpio_padcfg[7] [5:0],\gpio_padcfg[6] [5:0],\gpio_padcfg[5] [5:0],\gpio_padcfg[4] [5:0],\gpio_padcfg[3] [5:0],\gpio_padcfg[2] [5:0],\gpio_padcfg[1] [5:0],\gpio_padcfg[0] [5:0],clk_standard,clk_calib_rc32m,clk_calib_rc32k,freq_sel_rc32m[7:0],freq_sel_rc32k[3:0],regin0[15:0],regin1[15:0],adc_start,adc_rstb,adc_clkin_ana,adc_ckout,adc_dout[9:0],rst_async_por_n,rst_async_key_n,pvd_in,pvd_sel[3:0],pd_ldo15,pd_v2i,pd_pvd,clk_rc32m,clk_rc32k,clk_32k,rc32m_ready,rc32k_ready,rc32m_pd,shortxixo,en_xtal32k,ext_en_xtal32k,uart1_tx,uart1_rx,uart1_rts,uart1_dtr,uart1_cts,uart1_dsr,uart2_tx,uart2_rx,uart2_rts,uart2_dtr,uart2_cts,uart2_dsr,uart3_tx,uart3_rx,uart3_rts,uart3_dtr,uart3_cts,uart3_dsr,uart4_tx,uart4_rx,uart4_rts,uart4_dtr,uart4_cts,uart4_dsr,uart5_tx,uart5_rx,uart5_rts,uart5_dtr,uart5_cts,uart5_dsr,spi1_master_clk_o,spi1_master_csn0_o,spi1_master_csn1_o,spi1_master_csn2_o,spi1_master_csn3_o,spi1_master_mode_o[1:0],spi1_master_sdo0_o,spi1_master_sdo1_o,spi1_master_sdo2_o,spi1_master_sdo3_o,spi1_master_sdi0_i,spi1_master_sdi1_i,spi1_master_sdi2_i,spi1_master_sdi3_i,scl1_pad_i,scl1_pad_o,scl1_padoen_o,sda1_pad_i,sda1_pad_o,sda1_padoen_o,tck_i,trstn_i,tms_i,tdi_i,tdo_o,o_addr_eflsh[13:0],o_addr_1_eflsh,o_word_eflsh,o_din_eflsh[31:0],i_dout_eflsh[31:0],o_resetb_eflsh,o_cs_eflsh,o_ae_eflsh,o_oe_eflsh,o_ifren_eflsh,o_nvstr_eflsh,o_prog_eflsh,o_sera_eflsh,o_mase_eflsh,i_tbit_eflsh,i_smten_pad,i_sce_pad,sclk_pad,o_sio_oen_pad,o_sio_pad,i_sio_pad,o_smten_eflsh,o_sce_eflsh,sclk_eflsh,i_sio_oen_eflsh,i_sio_eflsh,o_sio_eflsh,\pad_cfg_o[31] [5:0],\pad_cfg_o[30] [5:0],\pad_cfg_o[29] [5:0],\pad_cfg_o[28] [5:0],\pad_cfg_o[27] [5:0],\pad_cfg_o[26] [5:0],\pad_cfg_o[25] [5:0],\pad_cfg_o[24] [5:0],\pad_cfg_o[23] [5:0],\pad_cfg_o[22] [5:0],\pad_cfg_o[21] [5:0],\pad_cfg_o[20] [5:0],\pad_cfg_o[19] [5:0],\pad_cfg_o[18] [5:0],\pad_cfg_o[17] [5:0],\pad_cfg_o[16] [5:0],\pad_cfg_o[15] [5:0],\pad_cfg_o[14] [5:0],\pad_cfg_o[13] [5:0],\pad_cfg_o[12] [5:0],\pad_cfg_o[11] [5:0],\pad_cfg_o[10] [5:0],\pad_cfg_o[9] [5:0],\pad_cfg_o[8] [5:0],\pad_cfg_o[7] [5:0],\pad_cfg_o[6] [5:0],\pad_cfg_o[5] [5:0],\pad_cfg_o[4] [5:0],\pad_cfg_o[3] [5:0],\pad_cfg_o[2] [5:0],\pad_cfg_o[1] [5:0],\pad_cfg_o[0] [5:0],pad_mux_o[31:0]" */;
  output clk_sys;
  output rstn_sys;
  input clk;
  input rst_n;
  input clk_sel_i;
  input clk_standalone_i;
  input testmode_i;
  input fetch_enable_i;
  input scan_enable_i;
  input boot_sel_0_i;
  input boot_sel_1_i;
  input spi_clk_i;
  input spi_cs_i;
  output [1:0]spi_mode_o;
  output spi_sdo0_o;
  output spi_sdo1_o;
  output spi_sdo2_o;
  output spi_sdo3_o;
  input spi_sdi0_i;
  input spi_sdi1_i;
  input spi_sdi2_i;
  input spi_sdi3_i;
  output spi_master_clk_o;
  output spi_master_csn0_o;
  output spi_master_csn1_o;
  output spi_master_csn2_o;
  output spi_master_csn3_o;
  output [1:0]spi_master_mode_o;
  output spi_master_sdo0_o;
  output spi_master_sdo1_o;
  output spi_master_sdo2_o;
  output spi_master_sdo3_o;
  input spi_master_sdi0_i;
  input spi_master_sdi1_i;
  input spi_master_sdi2_i;
  input spi_master_sdi3_i;
  input scl_pad_i;
  output scl_pad_o;
  output scl_padoen_o;
  input sda_pad_i;
  output sda_pad_o;
  output sda_padoen_o;
  output uart_tx;
  input uart_rx;
  output uart_rts;
  output uart_dtr;
  input uart_cts;
  input uart_dsr;
  input [31:0]gpio_in;
  output [31:0]gpio_out;
  output [31:0]gpio_dir;
  output [5:0]\gpio_padcfg[31] ;
  output [5:0]\gpio_padcfg[30] ;
  output [5:0]\gpio_padcfg[29] ;
  output [5:0]\gpio_padcfg[28] ;
  output [5:0]\gpio_padcfg[27] ;
  output [5:0]\gpio_padcfg[26] ;
  output [5:0]\gpio_padcfg[25] ;
  output [5:0]\gpio_padcfg[24] ;
  output [5:0]\gpio_padcfg[23] ;
  output [5:0]\gpio_padcfg[22] ;
  output [5:0]\gpio_padcfg[21] ;
  output [5:0]\gpio_padcfg[20] ;
  output [5:0]\gpio_padcfg[19] ;
  output [5:0]\gpio_padcfg[18] ;
  output [5:0]\gpio_padcfg[17] ;
  output [5:0]\gpio_padcfg[16] ;
  output [5:0]\gpio_padcfg[15] ;
  output [5:0]\gpio_padcfg[14] ;
  output [5:0]\gpio_padcfg[13] ;
  output [5:0]\gpio_padcfg[12] ;
  output [5:0]\gpio_padcfg[11] ;
  output [5:0]\gpio_padcfg[10] ;
  output [5:0]\gpio_padcfg[9] ;
  output [5:0]\gpio_padcfg[8] ;
  output [5:0]\gpio_padcfg[7] ;
  output [5:0]\gpio_padcfg[6] ;
  output [5:0]\gpio_padcfg[5] ;
  output [5:0]\gpio_padcfg[4] ;
  output [5:0]\gpio_padcfg[3] ;
  output [5:0]\gpio_padcfg[2] ;
  output [5:0]\gpio_padcfg[1] ;
  output [5:0]\gpio_padcfg[0] ;
  input clk_standard;
  input clk_calib_rc32m;
  input clk_calib_rc32k;
  output [7:0]freq_sel_rc32m;
  output [3:0]freq_sel_rc32k;
  output [15:0]regin0;
  output [15:0]regin1;
  output adc_start;
  output adc_rstb;
  output adc_clkin_ana;
  input adc_ckout;
  input [9:0]adc_dout;
  input rst_async_por_n;
  input rst_async_key_n;
  input pvd_in;
  output [3:0]pvd_sel;
  output pd_ldo15;
  output pd_v2i;
  output pd_pvd;
  input clk_rc32m;
  input clk_rc32k;
  input clk_32k;
  input rc32m_ready;
  input rc32k_ready;
  output rc32m_pd;
  output shortxixo;
  output en_xtal32k;
  output ext_en_xtal32k;
  output uart1_tx;
  input uart1_rx;
  output uart1_rts;
  output uart1_dtr;
  input uart1_cts;
  input uart1_dsr;
  output uart2_tx;
  input uart2_rx;
  output uart2_rts;
  output uart2_dtr;
  input uart2_cts;
  input uart2_dsr;
  output uart3_tx;
  input uart3_rx;
  output uart3_rts;
  output uart3_dtr;
  input uart3_cts;
  input uart3_dsr;
  output uart4_tx;
  input uart4_rx;
  output uart4_rts;
  output uart4_dtr;
  input uart4_cts;
  input uart4_dsr;
  output uart5_tx;
  input uart5_rx;
  output uart5_rts;
  output uart5_dtr;
  input uart5_cts;
  input uart5_dsr;
  output spi1_master_clk_o;
  output spi1_master_csn0_o;
  output spi1_master_csn1_o;
  output spi1_master_csn2_o;
  output spi1_master_csn3_o;
  output [1:0]spi1_master_mode_o;
  output spi1_master_sdo0_o;
  output spi1_master_sdo1_o;
  output spi1_master_sdo2_o;
  output spi1_master_sdo3_o;
  input spi1_master_sdi0_i;
  input spi1_master_sdi1_i;
  input spi1_master_sdi2_i;
  input spi1_master_sdi3_i;
  input scl1_pad_i;
  output scl1_pad_o;
  output scl1_padoen_o;
  input sda1_pad_i;
  output sda1_pad_o;
  output sda1_padoen_o;
  input tck_i;
  input trstn_i;
  input tms_i;
  input tdi_i;
  output tdo_o;
  output [13:0]o_addr_eflsh;
  output o_addr_1_eflsh;
  output o_word_eflsh;
  output [31:0]o_din_eflsh;
  input [31:0]i_dout_eflsh;
  output o_resetb_eflsh;
  output o_cs_eflsh;
  output o_ae_eflsh;
  output o_oe_eflsh;
  output o_ifren_eflsh;
  output o_nvstr_eflsh;
  output o_prog_eflsh;
  output o_sera_eflsh;
  output o_mase_eflsh;
  input i_tbit_eflsh;
  input i_smten_pad;
  input i_sce_pad;
  input sclk_pad;
  output o_sio_oen_pad;
  output o_sio_pad;
  input i_sio_pad;
  output o_smten_eflsh;
  output o_sce_eflsh;
  output sclk_eflsh;
  input i_sio_oen_eflsh;
  input i_sio_eflsh;
  output o_sio_eflsh;
  output [5:0]\pad_cfg_o[31] ;
  output [5:0]\pad_cfg_o[30] ;
  output [5:0]\pad_cfg_o[29] ;
  output [5:0]\pad_cfg_o[28] ;
  output [5:0]\pad_cfg_o[27] ;
  output [5:0]\pad_cfg_o[26] ;
  output [5:0]\pad_cfg_o[25] ;
  output [5:0]\pad_cfg_o[24] ;
  output [5:0]\pad_cfg_o[23] ;
  output [5:0]\pad_cfg_o[22] ;
  output [5:0]\pad_cfg_o[21] ;
  output [5:0]\pad_cfg_o[20] ;
  output [5:0]\pad_cfg_o[19] ;
  output [5:0]\pad_cfg_o[18] ;
  output [5:0]\pad_cfg_o[17] ;
  output [5:0]\pad_cfg_o[16] ;
  output [5:0]\pad_cfg_o[15] ;
  output [5:0]\pad_cfg_o[14] ;
  output [5:0]\pad_cfg_o[13] ;
  output [5:0]\pad_cfg_o[12] ;
  output [5:0]\pad_cfg_o[11] ;
  output [5:0]\pad_cfg_o[10] ;
  output [5:0]\pad_cfg_o[9] ;
  output [5:0]\pad_cfg_o[8] ;
  output [5:0]\pad_cfg_o[7] ;
  output [5:0]\pad_cfg_o[6] ;
  output [5:0]\pad_cfg_o[5] ;
  output [5:0]\pad_cfg_o[4] ;
  output [5:0]\pad_cfg_o[3] ;
  output [5:0]\pad_cfg_o[2] ;
  output [5:0]\pad_cfg_o[1] ;
  output [5:0]\pad_cfg_o[0] ;
  output [31:0]pad_mux_o;
endmodule
