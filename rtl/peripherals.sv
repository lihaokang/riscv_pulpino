//	===============================CoreLink CO. LTD.===============================
//	Information contained in this Confidential and Proprietary work has been
//      obtained by CoreLink CO LTD
//  This Software may be used only as authorized by a licensing agreement from
//      CoreLink Limited
//
//              COPYRIGHT (C) 2017-2019 CoreLink DESIGN Limited
//                          ALL RIGHTS RESERVED
//
//	The entire notice above must be displayed on all authorized CoreLink copies.
//	Copies may be made only to the extended consent by a licensing
//		agreement from CoreLink Limited.
//
//	------------------------------------------------------------------------------
//	Project and Control Information
//	------------------------------------------------------------------------------
//	Project Name	    :       Proton-SoC
//	This module name	:       peripherals
//	Author          	:       weijie.chen
//	------------------------------------------------------------------------------
//	CoreLink Confidential Module(s) Information
//	UMC 0.11um Embedded Flash Process
//	------------------------------------------------------------------------------
// #############################################################################

`include "axi_bus.sv"
`include "apb_bus.sv"
`include "debug_bus.sv"
`include "config.sv"

module peripherals
  #(
    parameter AXI_ADDR_WIDTH       = 32,
    parameter AXI_DATA_WIDTH       = 64,
    parameter AXI_USER_WIDTH       = 6,
    parameter AXI_SLAVE_ID_WIDTH   = 6,
    parameter AXI_MASTER_ID_WIDTH  = 6,
    parameter ROM_START_ADDR       = 32'h8000
  )
  (
//pads
	inout wire pad_jtag_tck_spad,
	inout wire pad_jtag_rstn_spad,
	inout wire pad_jtag_tms_spad,
	inout wire pad_jtag_tdi_spad,
	inout wire pad_jtag_tdo_spad,

	inout wire pad_cms_0_spad,
	inout wire pad_boot_sel_spad,
	inout wire pad_xtal0_spad,
	inout wire pad_xtal1_spad,
	inout wire pad_resetn_spad,
	inout wire pad_cms_1_spad,

	inout wire pad_0_spad	,
	inout wire pad_1_spad	,
	inout wire pad_2_spad	,
	inout wire pad_3_spad	,
	inout wire pad_4_spad	,
	inout wire pad_5_spad	,
	inout wire pad_6_spad	,
	inout wire pad_7_spad	,
	inout wire pad_8_spad	,
	inout wire pad_9_spad	,
	inout wire pad_10_spad	,
	inout wire pad_11_spad	,
	inout wire pad_12_spad	,
	inout wire pad_13_spad	,
	inout wire pad_14_spad	,
	inout wire pad_15_spad	,
	inout wire pad_16_spad	,
	inout wire pad_17_spad	,
	inout wire pad_18_spad	,
	inout wire pad_19_spad	,
	inout wire pad_20_spad	,
	inout wire pad_21_spad	,
	inout wire pad_22_spad	,
	inout wire pad_23_spad	,
	inout wire pad_24_spad	,
	inout wire pad_25_spad	,
	inout wire pad_26_spad	,
	inout wire pad_27_spad	,
	inout wire pad_28_spad	,
	inout wire pad_29_spad	,
	inout wire pad_30_spad	,
	inout wire pad_31_spad	,
	inout wire pad_32_spad	,
	inout wire pad_33_spad	,
	inout wire pad_34_spad	,

// JTAG signals
    output logic            tck_i,
    output logic            trstn_i,
    output logic            tms_i,
    output logic            tdi_i,
    input logic             tdo_o,

//EFT
    output logic            i_smten_pad  ,
    output logic            i_sce_pad    ,
    output logic            sclk_pad     ,
    input  logic            o_sio_oen_pad, 
    input  logic            o_sio_pad    ,
    output logic            i_sio_pad    ,

//mbist    
    input logic             ROM_MBISTPG_GO,
    input logic             ROM_MBISTPG_DONE,
    input logic             ROM_MBISTPG_SO,
    output logic            ROM_LV_TM,
    output logic[1:0]       ROM_BIST_SETUP,
    output logic            ROM_MBISTPG_EN,
    output logic            ROM_BIST_CLK,
    output logic            ROM_MBISTPG_ASYNC_RESETN,
    output logic            ROM_MBISTPG_MEM_RST,
                            
    input logic             RAM_MBISTPG_GO,
    input logic             RAM_MBISTPG_DONE,
    input logic             RAM_MBISTPG_SO,
    output logic            RAM_LV_TM,
    output logic[1:0]       RAM_BIST_SETUP,
    output logic            RAM_MBISTPG_EN,
    output logic            RAM_BIST_CLK,
    output logic            RAM_MBISTPG_ASYNC_RESETN,
    output logic            RAM_MBISTPG_MEM_RST,

    // Clock and Reset
    input logic clk_i,
    input logic rst_n,

    AXI_BUS.Master axi_spi_master,

    DEBUG_BUS.Master debug,
    input  logic             testmode_i,

    AXI_BUS.Slave  slave,

    input  logic              core_busy_i,
    output logic [31:0]       irq_o,
    input  logic              fetch_enable_i,
    output logic              fetch_enable_o,
    output logic              clk_gate_core_o,

//clk_calib
//    input                   clk_standard,
//    input                   clk_calib_rc32m,
//    input                   clk_calib_rc32k,
    output [7:0]            freq_sel_rc32m,
    output [3:0]            freq_sel_rc32k,

//adc
	output logic [15:0] 	regin0,regin1,
    output logic         	adc_start,
    output logic         	adc_rstb,
    output logic         	adc_clkin_ana,
	input  logic			adc_ckout,
    input  logic[9:0]  	    adc_dout,

//scu
	input  logic			rst_async_por_n,
	input  logic			pvd_in,
	output wire [3:0] 	    pvd_sel,
    output logic            atest_en,
    output logic [1:0]      atest_sel,
    
	output wire 			pd_ldo15,
	output wire 			pd_v2i,
	output wire 			pd_pvd,
	input  logic			clk_rc32m,
	input  logic			clk_rc32k,
	input  logic			clk_32k,
	input  logic			rc32m_ready,
	input  logic			rc32k_ready,
	output wire 			rc32m_pd,
	output wire 			shortxixo,
	output wire 			en_xtal32k,
	output wire 			ext_en_xtal32k,
    //internal
    output wire             sys_rst_n,
    output wire             clk_sys,

    output logic       [31:0] boot_addr_o
  );

  localparam APB_ADDR_WIDTH  = 32;

//PERIPH_IP
  localparam APB_NUM_SLAVES  = 26;//25//21/20/13/8

  APB_BUS s_apb_bus();

  APB_BUS s_uart_bus();
  APB_BUS s_gpio_bus();
  APB_BUS s_spi_bus();
  APB_BUS s_timer_bus();
  APB_BUS s_pwm_bus();
  APB_BUS s_event_unit_bus();
  APB_BUS s_i2c_bus();
  APB_BUS s_soc_ctrl_bus();
  APB_BUS s_debug_bus();

  APB_BUS s_wdt_bus();
  APB_BUS s_rtc_bus();
  APB_BUS s_calib_bus();
  APB_BUS s_scu_bus();
  APB_BUS s_adc_bus();

//PERIPH_IP
  APB_BUS s_uart1_bus();
  APB_BUS s_uart2_bus();
  APB_BUS s_uart3_bus();
  APB_BUS s_uart4_bus();
  APB_BUS s_uart5_bus();
  APB_BUS s_spi1_bus();
  APB_BUS s_i2c1_bus();
  APB_BUS s_i2c2_bus();
  APB_BUS s_i2c3_bus();
  APB_BUS s_i2c4_bus();
  APB_BUS s_i2c5_bus();

  APB_BUS s_iom_bus();
//internal signals
    logic              clk_test;//scu
    logic              rst_async_key_n;//scu
    logic              chip_rst_n;//scu
    logic              spi_clk_i;
    logic              spi_cs_i;
    logic [1:0]        spi_mode_o;
    logic              spi_sdo0_o;
    logic              spi_sdo1_o;
    logic              spi_sdo2_o;
    logic              spi_sdo3_o;
    logic              spi_sdi0_i;
    logic              spi_sdi1_i;
    logic              spi_sdi2_i;
    logic              spi_sdi3_i;

    logic              uart_tx;
    logic              uart_rx;
    logic              uart1_tx;
    logic              uart1_rx;
    logic              uart2_tx;
    logic              uart2_rx;
    logic              uart3_tx;
    logic              uart3_rx;
    logic              uart4_tx;
    logic              uart4_rx;
    logic              uart5_tx;
    logic              uart5_rx;

    logic              spi_master_clk;
    logic              spi_master_csn0;
    logic              spi_master_csn1;
    logic              spi_master_csn2;
    logic              spi_master_csn3;
    logic       [1:0]  spi_master_mode;
    logic              spi_master_sdo0;
    logic              spi_master_sdo1;
    logic              spi_master_sdo2;
    logic              spi_master_sdo3;
    logic              spi_master_sdi0;
    logic              spi_master_sdi1;
    logic              spi_master_sdi2;
    logic              spi_master_sdi3;

    logic              spi1_master_clk;
    logic              spi1_master_csn0;
    logic              spi1_master_csn1;
    logic              spi1_master_csn2;
    logic              spi1_master_csn3;
    logic       [1:0]  spi1_master_mode;
    logic              spi1_master_sdo0;
    logic              spi1_master_sdo1;
    logic              spi1_master_sdo2;
    logic              spi1_master_sdo3;
    logic              spi1_master_sdi0;
    logic              spi1_master_sdi1;
    logic              spi1_master_sdi2;
    logic              spi1_master_sdi3;

    logic              scl_pad_i;
    logic              scl_pad_o;
    logic              scl_padoen_o;
    logic              sda_pad_i;
    logic              sda_pad_o;
    logic              sda_padoen_o;

    logic              scl1_pad_i;
    logic              scl1_pad_o;
    logic              scl1_padoen_o;
    logic              sda1_pad_i;
    logic              sda1_pad_o;
    logic              sda1_padoen_o;

    logic              scl2_pad_i;
    logic              scl2_pad_o;
    logic              scl2_padoen_o;
    logic              sda2_pad_i;
    logic              sda2_pad_o;
    logic              sda2_padoen_o;
                           
    logic              scl3_pad_i;
    logic              scl3_pad_o;
    logic              scl3_padoen_o;
    logic              sda3_pad_i;
    logic              sda3_pad_o;
    logic              sda3_padoen_o;
                           
    logic              scl4_pad_i;
    logic              scl4_pad_o;
    logic              scl4_padoen_o;
    logic              sda4_pad_i;
    logic              sda4_pad_o;
    logic              sda4_padoen_o;
                           
    logic              scl5_pad_i;
    logic              scl5_pad_o;
    logic              scl5_padoen_o;
    logic              sda5_pad_i;
    logic              sda5_pad_o;
    logic              sda5_padoen_o;

    logic       [4:0]  gpio1_in;
    logic       [4:0]  gpio1_out;
    logic       [4:0]  gpio1_dir;//TBD

    logic       [31:0] gpio_in;
    logic       [31:0] gpio_out;
    logic       [31:0] gpio_dir;//TBD
    //logic [31:0] [5:0] gpio_padcfg;//TBD

    //logic [31:0] [5:0] pad_cfg_o;//TBD
    //logic       [31:0] pad_mux_o;//TBD

    //boot-sel
    logic              boot_sel_0_i;
    logic              boot_sel_1_i;

    logic [1:0]        s_spim_event;
    logic [3:0]        timer_irq;
    logic [31:0]       peripheral_clock_gate_ctrl;
    logic              s_uart_event;
    logic              i2c_event;
    logic              s_gpio_event;

    logic              pwm0;
    logic              pwm1;
    logic              pwm2;
    logic              pwm3;
    logic              pwm4;
    logic              pwm5;
    logic              pwm6;
    logic              pwm7;
                       
    logic              s_uart1_event;
    logic              s_uart2_event;
    logic              s_uart3_event;
    logic              s_uart4_event;
    logic              s_uart5_event;
    logic [1:0]        s_spim1_event;
                       
    logic              i2c1_event;
    logic              i2c2_event;
    logic              i2c3_event;
    logic              i2c4_event;
    logic              i2c5_event;
                       
    logic              gck_uart0;
    logic              gck_uart1;
    logic              gck_uart2;
    logic              gck_uart3;
    logic              gck_uart4;
    logic              gck_uart5;
    logic              gck_i2c0 ;
    logic              gck_i2c1 ;
    logic              gck_i2c2 ;
    logic              gck_i2c3 ;
    logic              gck_i2c4 ;
    logic              gck_i2c5 ;
    logic              gck_calib;
    logic              gck_wdt  ;
    logic              gck_adc  ;
    logic              gck_timer;
    logic              gck_pwm  ;

//scu
    wire clk_adc;
    wire clk_ls;

//adc
    wire adc_half_interrupt;
    wire adc_full_interrupt;

//rtc
    wire rtc_interrupt;

//wdt
    wire wdt_sys_rst_n;

//calib
    wire calib_interrupt_rc32m;
    wire calib_interrupt_rc32k;

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// Peripheral Clock Gating                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////
  clk_rst_ctrl soc_clk_rst_ctrl(
    .sys_clk            (clk_sys       ),
    .sys_rstn           (sys_rst_n     ),
    .clk_gating_cfg     (peripheral_clock_gate_ctrl),
    .clk_uart0          (gck_uart0     ),
    .clk_uart1          (gck_uart1     ),
    .clk_uart2          (gck_uart2     ),
    .clk_uart3          (gck_uart3     ),
    .clk_uart4          (gck_uart4     ),
    .clk_uart5          (gck_uart5     ),
    .clk_i2c0           (gck_i2c0      ),
    .clk_i2c1           (gck_i2c1      ),
    .clk_i2c2           (gck_i2c2      ),
    .clk_i2c3           (gck_i2c3      ),
    .clk_i2c4           (gck_i2c4      ),
    .clk_i2c5           (gck_i2c5      ),

    .clk_calib          (gck_calib     ),
    .clk_wdt            (gck_wdt       ),
    .clk_adc            (gck_adc       ),
    .clk_pwm            (gck_pwm       ),
    .clk_timer          (gck_timer     )
  );
  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// SPI Slave, AXI Master                                      ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  axi_spi_slave_wrap
  #(
    .AXI_ADDRESS_WIDTH  ( AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH       ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH       ),
    .AXI_ID_WIDTH       ( AXI_MASTER_ID_WIDTH  )
  )
  axi_spi_slave_i
  (
    .clk_i      ( clk_sys        ),
    .rst_ni     ( rst_n          ),

    .test_mode  ( testmode_i     ),

    .axi_master ( axi_spi_master ),

    .spi_clk    ( spi_clk_i      ),
    .spi_cs     ( spi_cs_i       ),
    .spi_mode   ( spi_mode_o     ),
    .spi_sdo0   ( spi_sdo0_o     ),
    .spi_sdo1   ( spi_sdo1_o     ),
    .spi_sdo2   ( spi_sdo2_o     ),
    .spi_sdo3   ( spi_sdo3_o     ),
    .spi_sdi0   ( spi_sdi0_i     ),
    .spi_sdi1   ( spi_sdi1_i     ),
    .spi_sdi2   ( spi_sdi2_i     ),
    .spi_sdi3   ( spi_sdi3_i     )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// AXI2APB Bridge                                             ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  axi2apb_wrap
  #(
      .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
      .AXI_DATA_WIDTH ( AXI_DATA_WIDTH     ),
      .AXI_USER_WIDTH ( AXI_USER_WIDTH     ),
      .AXI_ID_WIDTH   ( AXI_SLAVE_ID_WIDTH ),
      .APB_ADDR_WIDTH ( APB_ADDR_WIDTH     )
  )
  axi2apb_i
  (
    .clk_i     ( clk_i      ),
    .rst_ni    ( rst_n      ),
    .test_en_i ( testmode_i ),

    .axi_slave ( slave      ),

    .apb_master( s_apb_bus  )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Bus                                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  periph_bus_wrap
  #(
     .APB_ADDR_WIDTH( APB_ADDR_WIDTH ),
     .APB_DATA_WIDTH( 32             )
  )
  periph_bus_i
  (
     .clk_i             ( clk_i            ),
     .rst_ni            ( rst_n            ),

	 .iom_master        ( s_iom_bus        ),

	 .adc_master        ( s_adc_bus        ),
     .rtc_master        ( s_rtc_bus        ),
     .wdt_master        ( s_wdt_bus        ),
     .scu_master        ( s_scu_bus        ),
     .calib_master      ( s_calib_bus      ),

     .apb_slave         ( s_apb_bus        ),

//PERIPH_IP
     .uart1_master      ( s_uart1_bus      ),
     .uart2_master      ( s_uart2_bus      ),
     .uart3_master      ( s_uart3_bus      ),
     .uart4_master      ( s_uart4_bus      ),
     .uart5_master      ( s_uart5_bus      ),
     .i2c1_master       ( s_i2c1_bus       ),
     .i2c2_master       ( s_i2c2_bus       ),
     .i2c3_master       ( s_i2c3_bus       ),
     .i2c4_master       ( s_i2c4_bus       ),
     .i2c5_master       ( s_i2c5_bus       ),
     .spi1_master       ( s_spi1_bus       ),

     .uart_master       ( s_uart_bus       ),
     .gpio_master       ( s_gpio_bus       ),
     .spi_master        ( s_spi_bus        ),
     .timer_master      ( s_timer_bus      ),
     .pwm_master        ( s_pwm_bus        ),
     .event_unit_master ( s_event_unit_bus ),
     .i2c_master        ( s_i2c_bus        ),
     .soc_ctrl_master   ( s_soc_ctrl_bus   ),
     .debug_master      ( s_debug_bus      )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 0: APB UART interface                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  `ifndef VERILATOR
`ifdef USE_VLOG
  apb_uart_sv
    #(
       .APB_ADDR_WIDTH( 5 )
    )
    apb_uart_i
    (
      .CLK      ( gck_uart0             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart_bus.psel       ),
      .PENABLE  ( s_uart_bus.penable    ),
      .PWRITE   ( s_uart_bus.pwrite     ),
      .PADDR    ( s_uart_bus.paddr[6:2] ),
      .PWDATA   ( s_uart_bus.pwdata     ),
      .PRDATA   ( s_uart_bus.prdata     ),
      .PREADY   ( s_uart_bus.pready     ),
      .PSLVERR  ( s_uart_bus.pslverr    ),

      .rx_i     ( uart_rx               ),
      .tx_o     ( uart_tx               ),
      .event_o  ( s_uart_event          )
    );
`else
  apb_uart apb_uart_i (
    .CLK      ( clk_int[1]   ),
    .RSTN     ( rst_n        ),

    .PSEL     ( s_uart_bus.psel    ),
    .PENABLE  ( s_uart_bus.penable    ),
    .PWRITE   ( s_uart_bus.pwrite     ),
    .PADDR    ( s_uart_bus.paddr[4:2] ),
    .PWDATA   ( s_uart_bus.pwdata     ),
    .PRDATA   ( s_uart_bus.prdata  ),
    .PREADY   ( s_uart_bus.pready  ),
    .PSLVERR  ( s_uart_bus.pslverr ),

    .INT      ( s_uart_event ),   //Interrupt output

    .OUT1N    (),                    //Output 1
    .OUT2N    (),                    //Output 2
    .RTSN     ( uart_rts    ),       //RTS output
    .DTRN     ( uart_dtr    ),       //DTR output
    .CTSN     ( uart_cts    ),       //CTS input
    .DSRN     ( uart_dsr    ),       //DSR input
    .DCDN     ( 1'b1        ),       //DCD input
    .RIN      ( 1'b1        ),       //RI input
    .SIN      ( uart_rx     ),
    .SOUT     ( uart_tx     )
  );
`endif//USE_VLOG  
  `else
  apb_uart_sv
    #(
       .APB_ADDR_WIDTH( 3 )
    )
    apb_uart_i
    (
      .CLK      ( clk_int[1]            ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart_bus.psel       ),
      .PENABLE  ( s_uart_bus.penable    ),
      .PWRITE   ( s_uart_bus.pwrite     ),
      .PADDR    ( s_uart_bus.paddr[4:2] ),
      .PWDATA   ( s_uart_bus.pwdata     ),
      .PRDATA   ( s_uart_bus.prdata     ),
      .PREADY   ( s_uart_bus.pready     ),
      .PSLVERR  ( s_uart_bus.pslverr    ),

      .rx_i     ( uart_rx               ),
      .tx_o     ( uart_tx               ),
      .event_o  ( s_uart_event          )
    );
  `endif

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 1: APB GPIO interface                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_gpio apb_gpio_i
  (
    .HCLK       ( clk_sys               ),
    .HRESETn    ( rst_n                 ),

    .PADDR      ( s_gpio_bus.paddr[11:0]),
    .PWDATA     ( s_gpio_bus.pwdata     ),
    .PWRITE     ( s_gpio_bus.pwrite     ),
    .PSEL       ( s_gpio_bus.psel       ),
    .PENABLE    ( s_gpio_bus.penable    ),
    .PRDATA     ( s_gpio_bus.prdata     ),
    .PREADY     ( s_gpio_bus.pready     ),
    .PSLVERR    ( s_gpio_bus.pslverr    ),
//gpio1
    .gpio1_in     ( gpio1_in      ),
    .gpio1_out    ( gpio1_out     ),
    .gpio1_dir    ( gpio1_dir     ),

    .gpio_in      ( gpio_in       ),
    .gpio_out     ( gpio_out      ),
    .gpio_dir     ( gpio_dir      ),
//    .gpio_padcfg  ( gpio_padcfg   ),
    .interrupt    ( s_gpio_event  )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 2: APB SPI Master interface                      ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_spi_master
  #(
      .BUFFER_DEPTH(8)
  )
  apb_spi_master_i
  (
    .HCLK         ( clk_sys              ),
    .HRESETn      ( rst_n                ),

    .PADDR        ( s_spi_bus.paddr[11:0]),
    .PWDATA       ( s_spi_bus.pwdata     ),
    .PWRITE       ( s_spi_bus.pwrite     ),
    .PSEL         ( s_spi_bus.psel       ),
    .PENABLE      ( s_spi_bus.penable    ),
    .PRDATA       ( s_spi_bus.prdata     ),
    .PREADY       ( s_spi_bus.pready     ),
    .PSLVERR      ( s_spi_bus.pslverr    ),

    .events_o     ( s_spim_event ),

    .spi_clk      ( spi_master_clk  ),
    .spi_csn0     ( spi_master_csn0 ),
    .spi_csn1     ( spi_master_csn1 ),
    .spi_csn2     ( spi_master_csn2 ),
    .spi_csn3     ( spi_master_csn3 ),
    .spi_mode     ( spi_master_mode ),
    .spi_sdo0     ( spi_master_sdo0 ),
    .spi_sdo1     ( spi_master_sdo1 ),
    .spi_sdo2     ( spi_master_sdo2 ),
    .spi_sdo3     ( spi_master_sdo3 ),
    .spi_sdi0     ( spi_master_sdi0 ),
    .spi_sdi1     ( spi_master_sdi1 ),
    .spi_sdi2     ( spi_master_sdi2 ),
    .spi_sdi3     ( spi_master_sdi3 )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 3: Timer Unit                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_timer
  apb_timer_i
  (
    .HCLK       ( gck_timer              ),
    .HRESETn    ( rst_n                  ),

    .PADDR      ( s_timer_bus.paddr[11:0]),
    .PWDATA     ( s_timer_bus.pwdata     ),
    .PWRITE     ( s_timer_bus.pwrite     ),
    .PSEL       ( s_timer_bus.psel       ),
    .PENABLE    ( s_timer_bus.penable    ),
    .PRDATA     ( s_timer_bus.prdata     ),
    .PREADY     ( s_timer_bus.pready     ),
    .PSLVERR    ( s_timer_bus.pslverr    ),

    .irq_o      ( timer_irq    )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 4: Event Unit                                    ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_event_unit
  apb_event_unit_i
  (
    .clk_i            ( clk_i                       ),
    .HCLK             ( clk_sys                     ),
    .HRESETn          ( rst_n                       ),

    .PADDR            ( s_event_unit_bus.paddr[11:0]),
    .PWDATA           ( s_event_unit_bus.pwdata     ),
    .PWRITE           ( s_event_unit_bus.pwrite     ),
    .PSEL             ( s_event_unit_bus.psel       ),
    .PENABLE          ( s_event_unit_bus.penable    ),
    .PRDATA           ( s_event_unit_bus.prdata     ),
    .PREADY           ( s_event_unit_bus.pready     ),
    .PSLVERR          ( s_event_unit_bus.pslverr    ),

    .irq_i            ( {4'h0, timer_irq, s_spim_event, s_spim1_event, s_gpio_event, s_uart_event, s_uart1_event, s_uart2_event, s_uart3_event, s_uart4_event, s_uart5_event, calib_interrupt_rc32k, calib_interrupt_rc32m, rtc_interrupt, adc_full_interrupt, adc_half_interrupt, i2c_event, i2c1_event, i2c2_event, i2c3_event, i2c4_event, i2c5_event, 2'h0} ),
    .event_i          ( {4'h0, timer_irq, s_spim_event, s_spim1_event, s_gpio_event, s_uart_event, s_uart1_event, s_uart2_event, s_uart3_event, s_uart4_event, s_uart5_event, calib_interrupt_rc32k, calib_interrupt_rc32m, rtc_interrupt, adc_full_interrupt, adc_half_interrupt, i2c_event, i2c1_event, i2c2_event, i2c3_event, i2c4_event, i2c5_event, 2'h0} ),

    .irq_o            ( irq_o              ),

    .fetch_enable_i   ( fetch_enable_i     ),
    .fetch_enable_o   ( fetch_enable_o     ),
    .clk_gate_core_o  ( clk_gate_core_o    ),
    .core_busy_i      ( core_busy_i        )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 5: I2C                                           ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb_i2c
  apb_i2c_i
  (
    .HCLK         ( gck_i2c0              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c_bus.paddr[11:0] ),
    .PWDATA       ( s_i2c_bus.pwdata      ),
    .PWRITE       ( s_i2c_bus.pwrite      ),
    .PSEL         ( s_i2c_bus.psel        ),
    .PENABLE      ( s_i2c_bus.penable     ),
    .PRDATA       ( s_i2c_bus.prdata      ),
    .PREADY       ( s_i2c_bus.pready      ),
    .PSLVERR      ( s_i2c_bus.pslverr     ),
    .interrupt_o  ( i2c_event     ),
    .scl_pad_i    ( scl_pad_i     ),
    .scl_pad_o    ( scl_pad_o     ),
    .scl_padoen_o ( scl_padoen_o  ),
    .sda_pad_i    ( sda_pad_i     ),
    .sda_pad_o    ( sda_pad_o     ),
    .sda_padoen_o ( sda_padoen_o  )
  );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 7: PULPino control                               ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

    apb_pulpino
    #(
      .BOOT_ADDR ( ROM_START_ADDR )
    )
    apb_pulpino_i
    (
      .HCLK        ( clk_i        ),
      .HRESETn     ( rst_n        ),

      .PADDR       ( s_soc_ctrl_bus.paddr[11:0]),
      .PWDATA      ( s_soc_ctrl_bus.pwdata     ),
      .PWRITE      ( s_soc_ctrl_bus.pwrite     ),
      .PSEL        ( s_soc_ctrl_bus.psel       ),
      .PENABLE     ( s_soc_ctrl_bus.penable    ),
      .PRDATA      ( s_soc_ctrl_bus.prdata     ),
      .PREADY      ( s_soc_ctrl_bus.pready     ),
      .PSLVERR     ( s_soc_ctrl_bus.pslverr    ),

      .boot_sel_0_i( boot_sel_0_i              ),
      .boot_sel_1_i( boot_sel_1_i              ),

      //.pad_cfg_o   ( pad_cfg_o                  ),
      .clk_gate_o  ( peripheral_clock_gate_ctrl ),
      //.pad_mux_o   ( pad_mux_o                  ),
      .boot_addr_o ( boot_addr_o                )
    );

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  /// APB Slave 8: APB2PER for debug                             ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  apb2per
  #(
    .PER_ADDR_WIDTH ( 15             ),
    .APB_ADDR_WIDTH ( APB_ADDR_WIDTH )
  )
  apb2per_debug_i
  (
    .clk_i                ( clk_i                   ),
    .rst_ni               ( rst_n                   ),

    .PADDR                ( s_debug_bus.paddr       ),
    .PWDATA               ( s_debug_bus.pwdata      ),
    .PWRITE               ( s_debug_bus.pwrite      ),
    .PSEL                 ( s_debug_bus.psel        ),
    .PENABLE              ( s_debug_bus.penable     ),
    .PRDATA               ( s_debug_bus.prdata      ),
    .PREADY               ( s_debug_bus.pready      ),
    .PSLVERR              ( s_debug_bus.pslverr     ),

    .per_master_req_o     ( debug.req               ),
    .per_master_add_o     ( debug.addr              ),
    .per_master_we_o      ( debug.we                ),
    .per_master_wdata_o   ( debug.wdata             ),
    .per_master_be_o      (                         ),
    .per_master_gnt_i     ( debug.gnt               ),

    .per_master_r_valid_i ( debug.rvalid            ),
    .per_master_r_opc_i   ( '0                      ),
    .per_master_r_rdata_i ( debug.rdata             )
  );

    // APB Slave 9
    wdt apb_wdt(
        .pclk       (gck_wdt),
        .prst_n     (rst_n),

        .pwrite		(s_wdt_bus.pwrite),
        .psel		(s_wdt_bus.psel),
        .penable	(s_wdt_bus.penable),
        .paddr		(s_wdt_bus.paddr),
        .pwdata		(s_wdt_bus.pwdata),
        .prdata		(s_wdt_bus.prdata),
        .pready		(s_wdt_bus.pready),
        .pslverr	(s_wdt_bus.pslverr),

        .clk_ls     (clk_ls),
        .wdt2sync_rst_n(wdt_sys_rst_n)
    );

    // APB Slave 10
    rtc_top apb_rtc(
        .pclk       (clk_sys),
        .prst_n     (rst_n),
                    
        .psel       (s_rtc_bus.psel),
        .penable    (s_rtc_bus.penable),
        .pwrite     (s_rtc_bus.pwrite),
        .paddr      (s_rtc_bus.paddr),
        .pwdata     (s_rtc_bus.pwdata),
        .prdata     (s_rtc_bus.prdata),
        .pready     (s_rtc_bus.pready),
        .pslverr    (s_rtc_bus.pslverr),

        .rtc_clk    (clk_ls),//TBD
        .inta_o     (rtc_interrupt)//TBD
    );

    // APB Slave 11
    clk_calibration apb_clk_calibration(
        .pclk       (gck_calib),
        .prst_n     (rst_n),
        
        .pwrite		(s_calib_bus.pwrite),
        .psel		(s_calib_bus.psel),
        .penable	(s_calib_bus.penable),
        .paddr		(s_calib_bus.paddr),
        .pwdata		(s_calib_bus.pwdata),
        .prdata		(s_calib_bus.prdata),
        .pready		(s_calib_bus.pready),
        .pslverr	(s_calib_bus.pslverr),
        
        .clk_32k        (clk_32k),//include xtal32768 or external clk-32768
        .clk_rc32m      (clk_rc32m),
        .clk_rc32k      (clk_rc32k),
        //regulate bits
        .freq_sel_rc32m (freq_sel_rc32m),
        .freq_sel_rc32k (freq_sel_rc32k),
        //interrupt output
        .int_rc32m      (calib_interrupt_rc32m),
        .int_rc32k      (calib_interrupt_rc32k)
    );

    // APB Slave 12
    scu apb_scu(
        .pclk           (clk_i),
        .prst_n         (rst_n),
        
        .pwrite		    (s_scu_bus.pwrite),
        .psel		    (s_scu_bus.psel),
        .penable	    (s_scu_bus.penable),
        .paddr		    (s_scu_bus.paddr),
        .pwdata		    (s_scu_bus.pwdata),
        .prdata		    (s_scu_bus.prdata),
        .pready		    (s_scu_bus.pready),
        .pslverr	    (s_scu_bus.pslverr),

        .rst_async_por_n(rst_async_por_n), //1 bit input
        .rst_async_key_n(rst_async_key_n), //1 bit input
        .rst_wdt_n      (wdt_sys_rst_n), 

        .chip_rst_n     (chip_rst_n),
        .rst_n          (sys_rst_n),

        .pd_ldo15       (pd_ldo15), //1 bit output
        .pd_v2i         (pd_v2i), //1 bit output
        .pd_pvd         (pd_pvd), //1 bit output
        .pvd_in         (pvd_in), //1 bit input
        .pvd_sel        (pvd_sel), //4 bit output
        .atest_en       (atest_en),
        .atest_sel      (atest_sel),

        .clk_rc32m      (clk_rc32m),
        .clk_rc32k      (clk_rc32k),
        .clk_32k        (clk_32k),
        .rc32m_ready    (rc32m_ready),
        .rc32k_ready    (rc32k_ready),

        .clk_sys        (clk_sys), 
        .clk_adc        (clk_adc), 
        .clk_ls         (clk_ls), //wdt/rtc

        .rc32m_pd       (rc32m_pd), //1 bit output
        .shortxixo      (shortxixo), //1 bit output
        .en_xtal32k     (en_xtal32k), //1 bit output
        .ext_en_xtal32k (ext_en_xtal32k), //1 bit output

        .clk_test       (clk_test)
    );

  // APB Slave 13
    apb_adc_control apb_adc_control(
        .pclk		    (gck_adc),
        .prst_n		    (rst_n),
                        
        .pwrite		    (s_adc_bus.pwrite),
        .psel		    (s_adc_bus.psel),
        .penable	    (s_adc_bus.penable),
        .paddr		    (s_adc_bus.paddr),
        .pwdata		    (s_adc_bus.pwdata),
        .prdata		    (s_adc_bus.prdata),
        .pready		    (s_adc_bus.pready),
        .pslverr	    (s_adc_bus.pslverr),
                        
        //adc control
        .rc32m_pd	    (rc32m_pd),
        .clk_32m	    (clk_adc),
        .regin0		    (regin0),
        .regin1		    (regin1),

        .adc_clk		(adc_clkin_ana),
                        
        .adc_start	    (adc_start),
        .adc_rstb	    (adc_rstb),
        .adc_ckout	    (adc_ckout),
        .adc_dout	    (adc_dout),
                        
        .adc_half_interrupt(adc_half_interrupt),
        .adc_full_interrupt(adc_full_interrupt)
    );
//PERIPH_IP
  // APB Slave 14
  apb_uart_sv
    #(.APB_ADDR_WIDTH(5))
    apb_uart1
    (
      .CLK      ( gck_uart1             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart1_bus.psel      ),
      .PENABLE  ( s_uart1_bus.penable   ),
      .PWRITE   ( s_uart1_bus.pwrite    ),
      .PADDR    ( s_uart1_bus.paddr[6:2]),
      .PWDATA   ( s_uart1_bus.pwdata    ),
      .PRDATA   ( s_uart1_bus.prdata    ),
      .PREADY   ( s_uart1_bus.pready    ),
      .PSLVERR  ( s_uart1_bus.pslverr   ),

      .rx_i     ( uart1_rx              ),
      .tx_o     ( uart1_tx              ),
      .event_o  ( s_uart1_event         )
    );
  // APB Slave 15
  apb_uart_sv
    #(.APB_ADDR_WIDTH(5))
    apb_uart2
    (
      .CLK      ( gck_uart2             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart2_bus.psel      ),
      .PENABLE  ( s_uart2_bus.penable   ),
      .PWRITE   ( s_uart2_bus.pwrite    ),
      .PADDR    ( s_uart2_bus.paddr[6:2]),
      .PWDATA   ( s_uart2_bus.pwdata    ),
      .PRDATA   ( s_uart2_bus.prdata    ),
      .PREADY   ( s_uart2_bus.pready    ),
      .PSLVERR  ( s_uart2_bus.pslverr   ),

      .rx_i     ( uart2_rx              ),
      .tx_o     ( uart2_tx              ),
      .event_o  ( s_uart2_event         )
    );
  // APB Slave 16
  apb_uart_sv
    #(.APB_ADDR_WIDTH(5))
    apb_uart3
    (
      .CLK      ( gck_uart3             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart3_bus.psel      ),
      .PENABLE  ( s_uart3_bus.penable   ),
      .PWRITE   ( s_uart3_bus.pwrite    ),
      .PADDR    ( s_uart3_bus.paddr[6:2]),
      .PWDATA   ( s_uart3_bus.pwdata    ),
      .PRDATA   ( s_uart3_bus.prdata    ),
      .PREADY   ( s_uart3_bus.pready    ),
      .PSLVERR  ( s_uart3_bus.pslverr   ),

      .rx_i     ( uart3_rx              ),
      .tx_o     ( uart3_tx              ),
      .event_o  ( s_uart3_event         )
    );
  // APB Slave 17
  apb_uart_sv
    #(.APB_ADDR_WIDTH(5))
    apb_uart4
    (
      .CLK      ( gck_uart4             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart4_bus.psel      ),
      .PENABLE  ( s_uart4_bus.penable   ),
      .PWRITE   ( s_uart4_bus.pwrite    ),
      .PADDR    ( s_uart4_bus.paddr[6:2]),
      .PWDATA   ( s_uart4_bus.pwdata    ),
      .PRDATA   ( s_uart4_bus.prdata    ),
      .PREADY   ( s_uart4_bus.pready    ),
      .PSLVERR  ( s_uart4_bus.pslverr   ),

      .rx_i     ( uart4_rx              ),
      .tx_o     ( uart4_tx              ),
      .event_o  ( s_uart4_event         )
    );
  // APB Slave 18
  apb_uart_sv
    #(.APB_ADDR_WIDTH(5))
    apb_uart5
    (
      .CLK      ( gck_uart5             ),
      .RSTN     ( rst_n                 ),

      .PSEL     ( s_uart5_bus.psel      ),
      .PENABLE  ( s_uart5_bus.penable   ),
      .PWRITE   ( s_uart5_bus.pwrite    ),
      .PADDR    ( s_uart5_bus.paddr[6:2]),
      .PWDATA   ( s_uart5_bus.pwdata    ),
      .PRDATA   ( s_uart5_bus.prdata    ),
      .PREADY   ( s_uart5_bus.pready    ),
      .PSLVERR  ( s_uart5_bus.pslverr   ),

      .rx_i     ( uart5_rx              ),
      .tx_o     ( uart5_tx              ),
      .event_o  ( s_uart5_event         )
    );
  // APB Slave 19
  apb_i2c apb_i2c1
  (
    .HCLK         ( gck_i2c1              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c1_bus.paddr[11:0]),
    .PWDATA       ( s_i2c1_bus.pwdata     ),
    .PWRITE       ( s_i2c1_bus.pwrite     ),
    .PSEL         ( s_i2c1_bus.psel       ),
    .PENABLE      ( s_i2c1_bus.penable    ),
    .PRDATA       ( s_i2c1_bus.prdata     ),
    .PREADY       ( s_i2c1_bus.pready     ),
    .PSLVERR      ( s_i2c1_bus.pslverr    ),
    .interrupt_o  ( i2c1_event     ),
    .scl_pad_i    ( scl1_pad_i     ),
    .scl_pad_o    ( scl1_pad_o     ),
    .scl_padoen_o ( scl1_padoen_o  ),
    .sda_pad_i    ( sda1_pad_i     ),
    .sda_pad_o    ( sda1_pad_o     ),
    .sda_padoen_o ( sda1_padoen_o  )
  );
  // APB Slave 20
  apb_i2c apb_i2c2
  (
    .HCLK         ( gck_i2c2              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c2_bus.paddr[11:0]),
    .PWDATA       ( s_i2c2_bus.pwdata     ),
    .PWRITE       ( s_i2c2_bus.pwrite     ),
    .PSEL         ( s_i2c2_bus.psel       ),
    .PENABLE      ( s_i2c2_bus.penable    ),
    .PRDATA       ( s_i2c2_bus.prdata     ),
    .PREADY       ( s_i2c2_bus.pready     ),
    .PSLVERR      ( s_i2c2_bus.pslverr    ),
    .interrupt_o  ( i2c2_event     ),
    .scl_pad_i    ( scl2_pad_i     ),
    .scl_pad_o    ( scl2_pad_o     ),
    .scl_padoen_o ( scl2_padoen_o  ),
    .sda_pad_i    ( sda2_pad_i     ),
    .sda_pad_o    ( sda2_pad_o     ),
    .sda_padoen_o ( sda2_padoen_o  )
  );
  // APB Slave 21
  apb_i2c apb_i2c3
  (
    .HCLK         ( gck_i2c3              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c3_bus.paddr[11:0]),
    .PWDATA       ( s_i2c3_bus.pwdata     ),
    .PWRITE       ( s_i2c3_bus.pwrite     ),
    .PSEL         ( s_i2c3_bus.psel       ),
    .PENABLE      ( s_i2c3_bus.penable    ),
    .PRDATA       ( s_i2c3_bus.prdata     ),
    .PREADY       ( s_i2c3_bus.pready     ),
    .PSLVERR      ( s_i2c3_bus.pslverr    ),
    .interrupt_o  ( i2c3_event     ),
    .scl_pad_i    ( scl3_pad_i     ),
    .scl_pad_o    ( scl3_pad_o     ),
    .scl_padoen_o ( scl3_padoen_o  ),
    .sda_pad_i    ( sda3_pad_i     ),
    .sda_pad_o    ( sda3_pad_o     ),
    .sda_padoen_o ( sda3_padoen_o  )
  );
  // APB Slave 22
  apb_i2c apb_i2c4
  (
    .HCLK         ( gck_i2c4              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c4_bus.paddr[11:0]),
    .PWDATA       ( s_i2c4_bus.pwdata     ),
    .PWRITE       ( s_i2c4_bus.pwrite     ),
    .PSEL         ( s_i2c4_bus.psel       ),
    .PENABLE      ( s_i2c4_bus.penable    ),
    .PRDATA       ( s_i2c4_bus.prdata     ),
    .PREADY       ( s_i2c4_bus.pready     ),
    .PSLVERR      ( s_i2c4_bus.pslverr    ),
    .interrupt_o  ( i2c4_event     ),
    .scl_pad_i    ( scl4_pad_i     ),
    .scl_pad_o    ( scl4_pad_o     ),
    .scl_padoen_o ( scl4_padoen_o  ),
    .sda_pad_i    ( sda4_pad_i     ),
    .sda_pad_o    ( sda4_pad_o     ),
    .sda_padoen_o ( sda4_padoen_o  )
  );
  // APB Slave 23
  apb_i2c apb_i2c5
  (
    .HCLK         ( gck_i2c5              ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_i2c5_bus.paddr[11:0]),
    .PWDATA       ( s_i2c5_bus.pwdata     ),
    .PWRITE       ( s_i2c5_bus.pwrite     ),
    .PSEL         ( s_i2c5_bus.psel       ),
    .PENABLE      ( s_i2c5_bus.penable    ),
    .PRDATA       ( s_i2c5_bus.prdata     ),
    .PREADY       ( s_i2c5_bus.pready     ),
    .PSLVERR      ( s_i2c5_bus.pslverr    ),
    .interrupt_o  ( i2c5_event     ),
    .scl_pad_i    ( scl5_pad_i     ),
    .scl_pad_o    ( scl5_pad_o     ),
    .scl_padoen_o ( scl5_padoen_o  ),
    .sda_pad_i    ( sda5_pad_i     ),
    .sda_pad_o    ( sda5_pad_o     ),
    .sda_padoen_o ( sda5_padoen_o  )
  );
  // APB Slave 24
  apb_spi_master
  #(.BUFFER_DEPTH(8))
  apb_spi_master1
  (
    .HCLK         ( clk_sys               ),
    .HRESETn      ( rst_n                 ),

    .PADDR        ( s_spi1_bus.paddr[11:0]),
    .PWDATA       ( s_spi1_bus.pwdata     ),
    .PWRITE       ( s_spi1_bus.pwrite     ),
    .PSEL         ( s_spi1_bus.psel       ),
    .PENABLE      ( s_spi1_bus.penable    ),
    .PRDATA       ( s_spi1_bus.prdata     ),
    .PREADY       ( s_spi1_bus.pready     ),
    .PSLVERR      ( s_spi1_bus.pslverr    ),

    .events_o     ( s_spim1_event ),

    .spi_clk      ( spi1_master_clk  ),
    .spi_csn0     ( spi1_master_csn0 ),
    .spi_csn1     ( spi1_master_csn1 ),
    .spi_csn2     ( spi1_master_csn2 ),
    .spi_csn3     ( spi1_master_csn3 ),
    .spi_mode     ( spi1_master_mode ),
    .spi_sdo0     ( spi1_master_sdo0 ),
    .spi_sdo1     ( spi1_master_sdo1 ),
    .spi_sdo2     ( spi1_master_sdo2 ),
    .spi_sdo3     ( spi1_master_sdo3 ),
    .spi_sdi0     ( spi1_master_sdi0 ),
    .spi_sdi1     ( spi1_master_sdi1 ),
    .spi_sdi2     ( spi1_master_sdi2 ),
    .spi_sdi3     ( spi1_master_sdi3 )
  );

  // APB Slave 25
  iom apb_iom(
    .HCLK         (clk_sys),
    .HRESETn      (rst_n),

    .PADDR        (s_iom_bus.paddr),
    .PWDATA       (s_iom_bus.pwdata),
    .PWRITE       (s_iom_bus.pwrite),
    .PSEL         (s_iom_bus.psel),
    .PENABLE      (s_iom_bus.penable),
    .PRDATA       (s_iom_bus.prdata),
    .PREADY       (s_iom_bus.pready),
    .PSLVERR      (s_iom_bus.pslverr),

//internal signals
    .spi_mode_o          (spi_mode_o       ),
    .spi_sdo0_o          (spi_sdo0_o       ),
    .spi_sdo1_o          (spi_sdo1_o       ),
    .spi_sdo2_o          (spi_sdo2_o       ),
    .spi_sdo3_o          (spi_sdo3_o       ),
    .spi_clk_i           (spi_clk_i        ),
    .spi_cs_i            (spi_cs_i         ),
    .spi_sdi0_i          (spi_sdi0_i       ),
    .spi_sdi1_i          (spi_sdi1_i       ),
    .spi_sdi2_i          (spi_sdi2_i       ),
    .spi_sdi3_i          (spi_sdi3_i       ),
    .spi_master_clk_o    (spi_master_clk   ),
    .spi_master_csn0_o   (spi_master_csn0  ),
    .spi_master_csn1_o   (spi_master_csn1  ),
    .spi_master_csn2_o   (spi_master_csn2  ),
    .spi_master_csn3_o   (spi_master_csn3  ),
    .spi_master_mode_o   (spi_master_mode  ),
    .spi_master_sdo0_o   (spi_master_sdo0  ),
    .spi_master_sdo1_o   (spi_master_sdo1  ),
    .spi_master_sdo2_o   (spi_master_sdo2  ),
    .spi_master_sdo3_o   (spi_master_sdo3  ),
    .spi_master_sdi0_i   (spi_master_sdi0  ),
    .spi_master_sdi1_i   (spi_master_sdi1  ),
    .spi_master_sdi2_i   (spi_master_sdi2  ),
    .spi_master_sdi3_i   (spi_master_sdi3  ),

    .spi1_master_clk_o   (spi1_master_clk  ),
    .spi1_master_csn0_o  (spi1_master_csn0 ),
    .spi1_master_csn1_o  (spi1_master_csn1 ),
    .spi1_master_csn2_o  (spi1_master_csn2 ),
    .spi1_master_csn3_o  (spi1_master_csn3 ),
    .spi1_master_mode_o  (spi1_master_mode ),
    .spi1_master_sdo0_o  (spi1_master_sdo0 ),
    .spi1_master_sdo1_o  (spi1_master_sdo1 ),
    .spi1_master_sdo2_o  (spi1_master_sdo2 ),
    .spi1_master_sdo3_o  (spi1_master_sdo3 ),
    .spi1_master_sdi0_i  (spi1_master_sdi0 ),
    .spi1_master_sdi1_i  (spi1_master_sdi1 ),
    .spi1_master_sdi2_i  (spi1_master_sdi2 ),
    .spi1_master_sdi3_i  (spi1_master_sdi3 ),

    .scl_pad_i           (scl_pad_i        ),
    .sda_pad_i           (sda_pad_i        ),
    .scl_pad_o           (scl_pad_o        ),
    .scl_padoen_o        (scl_padoen_o     ),
    .sda_pad_o           (sda_pad_o        ),
    .sda_padoen_o        (sda_padoen_o     ),
    .scl1_pad_i          (scl1_pad_i       ),
    .sda1_pad_i          (sda1_pad_i       ),
    .scl1_pad_o          (scl1_pad_o       ),
    .scl1_padoen_o       (scl1_padoen_o    ),
    .sda1_pad_o          (sda1_pad_o       ),
    .sda1_padoen_o       (sda1_padoen_o    ),
    .scl2_pad_i          (scl2_pad_i       ),
    .sda2_pad_i          (sda2_pad_i       ),
    .scl2_pad_o          (scl2_pad_o       ),
    .scl2_padoen_o       (scl2_padoen_o    ),
    .sda2_pad_o          (sda2_pad_o       ),
    .sda2_padoen_o       (sda2_padoen_o    ),
    .scl3_pad_i          (scl3_pad_i       ),
    .sda3_pad_i          (sda3_pad_i       ),
    .scl3_pad_o          (scl3_pad_o       ),
    .scl3_padoen_o       (scl3_padoen_o    ),
    .sda3_pad_o          (sda3_pad_o       ),
    .sda3_padoen_o       (sda3_padoen_o    ),
    .scl4_pad_i          (scl4_pad_i       ),
    .sda4_pad_i          (sda4_pad_i       ),
    .scl4_pad_o          (scl4_pad_o       ),
    .scl4_padoen_o       (scl4_padoen_o    ),
    .sda4_pad_o          (sda4_pad_o       ),
    .sda4_padoen_o       (sda4_padoen_o    ),
    .scl5_pad_i          (scl5_pad_i       ),
    .sda5_pad_i          (sda5_pad_i       ),
    .scl5_pad_o          (scl5_pad_o       ),
    .scl5_padoen_o       (scl5_padoen_o    ),
    .sda5_pad_o          (sda5_pad_o       ),
    .sda5_padoen_o       (sda5_padoen_o    ),
    .uart_tx             (uart_tx          ),
    .uart_rx             (uart_rx          ),
    .uart1_tx            (uart1_tx         ),
    .uart1_rx            (uart1_rx         ),
    .uart2_tx            (uart2_tx         ),
    .uart2_rx            (uart2_rx         ),
    .uart3_tx            (uart3_tx         ),
    .uart3_rx            (uart3_rx         ),
    .uart4_tx            (uart4_tx         ),
    .uart4_rx            (uart4_rx         ),
    .uart5_tx            (uart5_tx         ),
    .uart5_rx            (uart5_rx         ),
    .gpio1_in            (gpio1_in         ),//TBD
    .gpio1_out           (gpio1_out        ),//TBD
    .gpio1_dir           (gpio1_dir        ),//TBD
    .gpio_in             (gpio_in          ),
    .gpio_out            (gpio_out         ),
    .gpio_dir            (gpio_dir         ),
//jtag    
    .tck_i               (tck_i            ),
    .trstn_i             (trstn_i          ),
    .tms_i               (tms_i            ),
    .tdi_i               (tdi_i            ),
    .tdo_o               (tdo_o            ),

    .rst_async_key_n     (rst_async_key_n  ),
    .chip_rst_n          (chip_rst_n       ),
    .clk_32k             (clk_32k          ),
//boot-sel
    .boot_sel_0_i        (boot_sel_0_i     ),
    .boot_sel_1_i        (boot_sel_1_i     ),
//EFT
    .i_smten_pad         (i_smten_pad),
    .i_sce_pad           (i_sce_pad),
    .sclk_pad            (sclk_pad),
    .o_sio_oen_pad       (o_sio_oen_pad), 
    .o_sio_pad           (o_sio_pad),
    .i_sio_pad           (i_sio_pad),

//dfd signals    
    .clk_test            (clk_test),

//pwm    
    .pwm0                (pwm0),
    .pwm1                (pwm1),
    .pwm2                (pwm2),
    .pwm3                (pwm3),
    .pwm4                (pwm4),
    .pwm5                (pwm5),
    .pwm6                (pwm6),
    .pwm7                (pwm7),

//mbist    
    .ROM_MBISTPG_GO          (ROM_MBISTPG_GO          ),
    .ROM_MBISTPG_DONE        (ROM_MBISTPG_DONE        ),
    .ROM_MBISTPG_SO          (ROM_MBISTPG_SO          ),
    .ROM_LV_TM               (ROM_LV_TM               ),
    .ROM_BIST_SETUP          (ROM_BIST_SETUP          ),
    .ROM_MBISTPG_EN          (ROM_MBISTPG_EN          ),
    .ROM_BIST_CLK            (ROM_BIST_CLK            ),
    .ROM_MBISTPG_ASYNC_RESETN(ROM_MBISTPG_ASYNC_RESETN),
    .ROM_MBISTPG_MEM_RST     (ROM_MBISTPG_MEM_RST     ),
    .RAM_MBISTPG_GO          (RAM_MBISTPG_GO          ),
    .RAM_MBISTPG_DONE        (RAM_MBISTPG_DONE        ),
    .RAM_MBISTPG_SO          (RAM_MBISTPG_SO          ),
    .RAM_LV_TM               (RAM_LV_TM               ),
    .RAM_BIST_SETUP          (RAM_BIST_SETUP          ),
    .RAM_MBISTPG_EN          (RAM_MBISTPG_EN          ),
    .RAM_BIST_CLK            (RAM_BIST_CLK            ),
    .RAM_MBISTPG_ASYNC_RESETN(RAM_MBISTPG_ASYNC_RESETN),
    .RAM_MBISTPG_MEM_RST     (RAM_MBISTPG_MEM_RST     ),

//pads
	.pad_jtag_tck_spad 	 (pad_jtag_tck_spad 	),
	.pad_jtag_rstn_spad	 (pad_jtag_rstn_spad	),
	.pad_jtag_tms_spad 	 (pad_jtag_tms_spad 	),
	.pad_jtag_tdi_spad 	 (pad_jtag_tdi_spad 	),
	.pad_jtag_tdo_spad 	 (pad_jtag_tdo_spad 	),

	.pad_cms_0_spad      (pad_cms_0_spad 	    ),
	.pad_boot_sel_spad   (pad_boot_sel_spad 	),
	.pad_xtal0_spad      (pad_xtal0_spad 	    ),
	.pad_xtal1_spad      (pad_xtal1_spad 	    ),
	.pad_resetn_spad     (pad_resetn_spad 	    ),
	.pad_cms_1_spad      (pad_cms_1_spad 	    ),

	.pad_0_spad	    (pad_0_spad	),
	.pad_1_spad	    (pad_1_spad	),
	.pad_2_spad	    (pad_2_spad	),
	.pad_3_spad	    (pad_3_spad	),
	.pad_4_spad	    (pad_4_spad	),
	.pad_5_spad	    (pad_5_spad	),
	.pad_6_spad	    (pad_6_spad	),
	.pad_7_spad	    (pad_7_spad	),
	.pad_8_spad	    (pad_8_spad	),
	.pad_9_spad	    (pad_9_spad	),
	.pad_10_spad	(pad_10_spad),
	.pad_11_spad	(pad_11_spad),
	.pad_12_spad	(pad_12_spad),
	.pad_13_spad	(pad_13_spad),
	.pad_14_spad	(pad_14_spad),
	.pad_15_spad	(pad_15_spad),
	.pad_16_spad	(pad_16_spad),
	.pad_17_spad	(pad_17_spad),
	.pad_18_spad	(pad_18_spad),
	.pad_19_spad	(pad_19_spad),
	.pad_20_spad	(pad_20_spad),
	.pad_21_spad	(pad_21_spad),
	.pad_22_spad	(pad_22_spad),
	.pad_23_spad	(pad_23_spad),
	.pad_24_spad	(pad_24_spad),
	.pad_25_spad	(pad_25_spad),
	.pad_26_spad	(pad_26_spad),
	.pad_27_spad	(pad_27_spad),
	.pad_28_spad	(pad_28_spad),
	.pad_29_spad	(pad_29_spad),
	.pad_30_spad	(pad_30_spad),
	.pad_31_spad	(pad_31_spad),
	.pad_32_spad	(pad_32_spad),
	.pad_33_spad	(pad_33_spad),
	.pad_34_spad	(pad_34_spad)
  );

  // APB Slave 26
  pwm apb_pwm(
    .pclk         (gck_pwm),
    .prst_n       (rst_n),

    .paddr        (s_pwm_bus.paddr),
    .pwdata       (s_pwm_bus.pwdata),
    .pwrite       (s_pwm_bus.pwrite),
    .psel         (s_pwm_bus.psel),
    .penable      (s_pwm_bus.penable),
    .prdata       (s_pwm_bus.prdata),
    .pready       (s_pwm_bus.pready),
    .pslverr      (s_pwm_bus.pslverr),

    .pwm0         (pwm0),
    .pwm1         (pwm1),
    .pwm2         (pwm2),
    .pwm3         (pwm3),
    .pwm4         (pwm4),
    .pwm5         (pwm5),
    .pwm6         (pwm6),
    .pwm7         (pwm7)
  );

endmodule
