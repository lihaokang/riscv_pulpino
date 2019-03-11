//	===============================CoreLink CO. LTD.===============================
//	Information contained in this Confidential and Proprietary work has been
//          obtained by CoreLink CO LTD
//      This Software may be used only as authorized by a licensing agreement from
//          CoreLink Limited
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
//	This module name	:       top
//	Author          	:       weijie.chen
//	------------------------------------------------------------------------------
//	CoreLink Confidential Module(s) Information
//	UMC 0.11um Embedded Flash Process
//	------------------------------------------------------------------------------
// #############################################################################

`include "axi_bus.sv"
`include "debug_bus.sv"

`define AXI_ADDR_WIDTH         32
`define AXI_DATA_WIDTH         32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1

module pulpino_top#(
    parameter USE_ZERO_RISCY       = 1,
    parameter RISCY_RV32F          = 0,
    parameter ZERO_RV32M           = 1,
    parameter ZERO_RV32E           = 0)
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

	inout wire pad_0_spad,
	inout wire pad_1_spad,
	inout wire pad_2_spad,
	inout wire pad_3_spad,
	inout wire pad_4_spad,
	inout wire pad_5_spad,
	inout wire pad_6_spad,
	inout wire pad_7_spad,
	inout wire pad_8_spad,
	inout wire pad_9_spad,
	inout wire pad_10_spad,
	inout wire pad_11_spad,
	inout wire pad_12_spad,
	inout wire pad_13_spad,
	inout wire pad_14_spad,
	inout wire pad_15_spad,
	inout wire pad_16_spad,
	inout wire pad_17_spad,
	inout wire pad_18_spad,
	inout wire pad_19_spad,
	inout wire pad_20_spad,
	inout wire pad_21_spad,
	inout wire pad_22_spad,
	inout wire pad_23_spad,
	inout wire pad_24_spad,
	inout wire pad_25_spad,
	inout wire pad_26_spad,
	inout wire pad_27_spad,
	inout wire pad_28_spad,
	inout wire pad_29_spad,
	inout wire pad_30_spad,
	inout wire pad_31_spad,
	inout wire pad_32_spad,
	inout wire pad_33_spad,
	inout wire pad_34_spad

    //inout wire VDD,
    //inout wire VCC,
    //inout wire VSS,//GND
    //inout wire AVSS,//GND
    //inout wire VPP,
    //inout wire VNN
`ifdef EFLASH_MODEL
    ,
    //EFC -> PF64AK
    output  wire [13:0]    o_addr_eflsh     ,//PF64AK.IN.ADDR
    output  wire           o_addr_1_eflsh   ,//PF64AK.IN.ADDR_1
    output  wire           o_word_eflsh     ,//PF64AK.IN.WORD
    output  reg [31:0]     o_din_eflsh      ,//PF64AK.IN.DIN
    input   [31:0]         i_dout_eflsh     ,//PF64AK.OUT.DOUT
    output  reg            o_resetb_eflsh   ,//PF64AK.IN.RESETB
    output  reg            o_cs_eflsh       ,//PF64AK.IN.CS
    output  reg            o_ae_eflsh       ,//PF64AK.IN.AE
    output  reg            o_oe_eflsh       ,//PF64AK.IN.OE
    output  wire           o_ifren_eflsh    ,//PF64AK.IN.IFREN
    output  reg            o_nvstr_eflsh    ,//PF64AK.IN.NVSTR
    output  reg            o_prog_eflsh     ,//PF64AK.IN.PROG
    output  reg            o_sera_eflsh     ,//PF64AK.IN.SERA
    output  reg            o_mase_eflsh     ,//PF64AK.IN.MASE
    input                  i_tbit_eflsh     ,//PF64AK.OUT.TBIT

    //EFT -> PF64AK
    //output  wire           o_vpp_eflsh      ,//PF64AK.IN.VPP//TBD
    //output  wire           o_vnn_eflsh      ,//PF64AK.IN.VNN//TBD
    output  wire           o_smten_eflsh    ,//PF64AK.IN.SMTEN
    output  wire           o_sce_eflsh      ,//PF64AK.IN.SCE
    output  wire           sclk_eflsh       ,//PF64AK.IN.SCLK
    input                  i_sio_oen_eflsh  ,//PF64AK.OUT.SIO_OEN
    input                  i_sio_eflsh      ,//PF64AK.OUT.SIO_O
    output  wire           o_sio_eflsh       //PF64AK.IN.SIO_I
`endif//EFLASH_MODEL    
);
    logic        testmode_i = 1'h0;//TBD
    logic        fetch_enable_i = 1'h1;//TBD

    logic        fetch_enable_int;
    logic        core_busy_int;
    logic        clk_gate_core_int;
    logic [31:0] irq_to_core_int;

    logic [31:0] boot_addr_int;
    //mbist    
    logic        ROM_MBISTPG_GO;
    logic        ROM_MBISTPG_DONE;
    logic        ROM_MBISTPG_SO;
    logic        ROM_LV_TM;
    logic[1:0]   ROM_BIST_SETUP;
    logic        ROM_MBISTPG_EN;
    logic        ROM_BIST_CLK;
    logic        ROM_MBISTPG_ASYNC_RESETN;
    logic        ROM_MBISTPG_MEM_RST;
    logic        RAM_MBISTPG_GO;
    logic        RAM_MBISTPG_DONE;
    logic        RAM_MBISTPG_SO;
    logic        RAM_LV_TM;
    logic[1:0]   RAM_BIST_SETUP;
    logic        RAM_MBISTPG_EN;
    logic        RAM_BIST_CLK;
    logic        RAM_MBISTPG_ASYNC_RESETN;
    logic        RAM_MBISTPG_MEM_RST;

    // JTAG signals
    logic              tck_i;
    logic              trstn_i;
    logic              tms_i;
    logic              tdi_i;
    logic              tdo_o;

   //EFT -> IOM
    logic              i_smten_pad    ;
    logic              i_sce_pad      ;
    logic              sclk_pad       ;
    logic              o_sio_oen_pad  ;  
    logic              o_sio_pad      ;
    logic              i_sio_pad      ;
    logic              clk_sys;
    logic              rstn_sys;

    //inout wire VDD                          ;//ANA.OUT.VOUT_LDO
//clk_calib
    logic [7:0]     freq_sel_rc32m  ;//ANA.IN.FREQ_SEL_RING32M
    logic [3:0]     freq_sel_rc32k  ;//ANA.IN.FREQ_SEL_RING32K

//adc
    logic [15:0] 	regin0          ;//ANA.IN.ADC_REG_IN_0
    logic [15:0] 	regin1          ;//ANA.IN.ADC_REG_IN_1
    logic         	adc_start       ;//ANA.IN.ADC_START
    logic         	adc_rstb        ;//ANA.IN.ADC_RESETB
    logic         	adc_clkin_ana   ;//ANA.IN.ADC_CLKIN
    logic			adc_ckout       ;//ANA.OUT.ADC_CKOUT
    logic[9:0]  	adc_dout        ;//ANA.OUT.ADC_DOUT

//scu
    logic			rst_async_por_n ;//ANA.OUT.RESETB
    logic           atest_en        ;//ANA.IN.ATEST_EN
    logic [1:0]     atest_sel       ;//ANA.IN.ATEST_SEL    
    logic			pvd_in          ;//ANA.OUT.PVD_OUT
    logic [3:0] 	pvd_sel         ;//ANA.IN.PVD_SEL
    logic 			pd_ldo15        ;//ANA.IN.PD_LDO15
    logic 			pd_v2i          ;//ANA.IN.PD_V2I
    logic 			pd_pvd          ;//ANA.IN.PD_PVD
    logic			clk_rc32m       ;//ANA.OUT.RING32M_CLK
    logic			clk_rc32k       ;//ANA.OUT.RING32K_CLK
    logic			clk_32k         ;//ANA.OUT.XTAL32K_CLK
    logic			rc32m_ready     ;//ANA.OUT.RING32M_CLK_RDY
    logic			rc32k_ready     ;//ANA.OUT.RING32K_CLK_RDY
    logic 			rc32m_pd        ;//ANA.IN.PD_RING32M
    logic 			shortxixo       ;//ANA.IN.SHORTXIXO
    logic 			en_xtal32k      ;//ANA.IN.EN_XTAL32K
    logic 			ext_en_xtal32k  ;//ANA.IN.EXT_EN_XTAL32K
                                             
    //EFC -> PF64AK
    logic [13:0]    o_addr_eflsh    ;//PF64AK.IN.ADDR
    logic           o_addr_1_eflsh  ;//PF64AK.IN.ADDR_1
    logic           o_word_eflsh    ;//PF64AK.IN.WORD
    logic [31:0]    o_din_eflsh     ;//PF64AK.IN.DIN
    logic [31:0]    i_dout_eflsh    ;//PF64AK.OUT.DOUT
    logic           o_resetb_eflsh  ;//PF64AK.IN.RESETB
    logic           o_cs_eflsh      ;//PF64AK.IN.CS
    logic           o_ae_eflsh      ;//PF64AK.IN.AE
    logic           o_oe_eflsh      ;//PF64AK.IN.OE
    logic           o_ifren_eflsh   ;//PF64AK.IN.IFREN
    logic           o_nvstr_eflsh   ;//PF64AK.IN.NVSTR
    logic           o_prog_eflsh    ;//PF64AK.IN.PROG
    logic           o_sera_eflsh    ;//PF64AK.IN.SERA
    logic           o_mase_eflsh    ;//PF64AK.IN.MASE
    logic           i_tbit_eflsh    ;//PF64AK.OUT.TBIT
    
    //EFT -> PF64AK
    //logic           o_vpp_eflsh     ;//PF64AK.IN.VPP//TBD
    //logic           o_vnn_eflsh     ;//PF64AK.IN.VNN//TBD
    logic           o_smten_eflsh   ;//PF64AK.IN.SMTEN
    logic           o_sce_eflsh     ;//PF64AK.IN.SCE
    logic           sclk_eflsh      ;//PF64AK.IN.SCLK
    logic           i_sio_oen_eflsh ;//PF64AK.OUT.SIO_OEN
    logic           i_sio_eflsh     ;//PF64AK.OUT.SIO_O
    logic           o_sio_eflsh     ;//PF64AK.IN.SIO_I

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH     ),
    .AXI_ID_WIDTH   ( `AXI_ID_SLAVE_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH     )
  )
//change for eflash-ctrl support by weijie.chen@2019.01
//  slaves[2:0]();
  slaves[3:0]();
  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  masters[2:0]();

  DEBUG_BUS
  debug();

  //----------------------------------------------------------------------------//
  // Core region
  //----------------------------------------------------------------------------//
  core_region
  #(
    .AXI_ADDR_WIDTH       ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH       ( `AXI_DATA_WIDTH      ),
    .AXI_ID_MASTER_WIDTH  ( `AXI_ID_MASTER_WIDTH ),
    .AXI_ID_SLAVE_WIDTH   ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_USER_WIDTH       ( `AXI_USER_WIDTH      ),
    .USE_ZERO_RISCY       (  USE_ZERO_RISCY      ),
    .RISCY_RV32F          (  RISCY_RV32F         ),
    .ZERO_RV32M           (  ZERO_RV32M          ),
    .ZERO_RV32E           (  ZERO_RV32E          )
  )
  core_region_i
  (
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

    .clk            ( clk_sys           ),
    .rst_n          ( rstn_sys          ),

    .testmode_i     ( testmode_i        ),
    .fetch_enable_i ( fetch_enable_int  ),
    .irq_i          ( irq_to_core_int   ),
    .core_busy_o    ( core_busy_int     ),
    .clock_gating_i ( clk_gate_core_int ),
    .boot_addr_i    ( boot_addr_int     ),

    .core_master    ( masters[0]        ),
    .dbg_master     ( masters[1]        ),
    .data_slave     ( slaves[1]         ),
    .instr_slave    ( slaves[0]         ),
    .debug          ( debug             ),

    .tck_i          ( tck_i             ),
    .trstn_i        ( trstn_i           ),
    .tms_i          ( tms_i             ),
    .tdi_i          ( tdi_i             ),
    .tdo_o          ( tdo_o             )
  );

  //----------------------------------------------------------------------------//
  // Peripherals
  //----------------------------------------------------------------------------//
  peripherals
  #(
    .AXI_ADDR_WIDTH      ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH      ( `AXI_DATA_WIDTH      ),
    .AXI_SLAVE_ID_WIDTH  ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_MASTER_ID_WIDTH ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH      ( `AXI_USER_WIDTH      )
  )
  peripherals_i
  (
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
	.pad_34_spad	(pad_34_spad),

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
    
//EFT    
    .i_smten_pad     (i_smten_pad),
    .i_sce_pad       (i_sce_pad),
    .sclk_pad        (sclk_pad),
    .o_sio_oen_pad   (o_sio_oen_pad), 
    .o_sio_pad       (o_sio_pad),
    .i_sio_pad       (i_sio_pad),

//jtag    
    .tck_i           (tck_i              ),
    .trstn_i         (trstn_i            ),
    .tms_i           (tms_i              ),
    .tdi_i           (tdi_i              ),
    .tdo_o           (tdo_o              ),

    .clk_i           ( clk_sys           ),
    .rst_n           ( rstn_sys          ),

    .axi_spi_master  ( masters[2]        ),
    .debug           ( debug             ),
    .testmode_i      ( testmode_i        ),    
    .slave           ( slaves[2]         ),
    
    .core_busy_i     ( core_busy_int     ),
    .irq_o           ( irq_to_core_int   ),
    .fetch_enable_i  ( fetch_enable_i    ),
    .fetch_enable_o  ( fetch_enable_int  ),
    .clk_gate_core_o ( clk_gate_core_int ),

//adc
	.regin0			(regin0				),
	.regin1			(regin1				),
    .adc_start		(adc_start			),
    .adc_rstb		(adc_rstb			),
	.adc_ckout		(adc_ckout			),
    .adc_dout		(adc_dout			),
    .adc_clkin_ana	(adc_clkin_ana		),

//clk_calib
    .freq_sel_rc32m  	(freq_sel_rc32m  		),
	.freq_sel_rc32k  	(freq_sel_rc32k  		),

//scu    
	.rst_async_por_n 	(rst_async_por_n 		),
    .atest_en           (atest_en               ),
    .atest_sel          (atest_sel              ),    
    .pvd_in          	(pvd_in          		),
    .pvd_sel         	(pvd_sel         		),
	.pd_ldo15        	(pd_ldo15        		),
    .pd_v2i          	(pd_v2i          		),
	.pd_pvd          	(pd_pvd          		),
	.clk_rc32m       	(clk_rc32m       		),
    .clk_rc32k       	(clk_rc32k       		),
    .clk_32k         	(clk_32k         		),
	.rc32m_ready     	(rc32m_ready     		),
    .rc32k_ready     	(rc32k_ready     		),
	.rc32m_pd        	(rc32m_pd        		),
	.shortxixo       	(shortxixo       		),
    .en_xtal32k      	(en_xtal32k      		),
    .ext_en_xtal32k  	(ext_en_xtal32k  		),
    .sys_rst_n  	    (rstn_sys  		        ),
    .clk_sys  	        (clk_sys  		        ),

    .boot_addr_o        ( boot_addr_int         )
  );


  //----------------------------------------------------------------------------//
  // Axi node
  //----------------------------------------------------------------------------//

  axi_node_intf_wrap
  #(
//change for eflash-ctrl support by weijie.chen@2019.01
//    .NB_MASTER      ( 3                    ),
    .NB_MASTER      ( 4                    ),
    .NB_SLAVE       ( 3                    ),
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  axi_interconnect_i
  (
    .clk       ( clk_sys    ),
    .rst_n     ( rstn_sys   ),
    .test_en_i ( testmode_i ),

    .master    ( slaves     ),
    .slave     ( masters    ),
//change by weijie.chen for eflash_ctrl support@2019.01
//    .start_addr_i ( { 32'h1A10_0000, 32'h0010_0000, 32'h0000_0000 } ),
//    .end_addr_i   ( { 32'h1A11_FFFF, 32'h001F_FFFF, 32'h000F_FFFF } )
    .start_addr_i ( { 32'h0011_0000, 32'h1A10_0000, 32'h0010_0000, 32'h0000_0000 } ),
    .end_addr_i   ( { 32'h0012_0800, 32'h1B00_FFFF, 32'h0010_4000, 32'h000F_FFFF } )
  );

eflash_ctrl axi4_eflash_ctrl(
   //system signal
   .clk               (clk_sys),
   .rst_n             (rstn_sys),         

   //AXI write address bus
   .i_slave_awid      (slaves[3].aw_id),
   .i_slave_awaddr    (slaves[3].aw_addr), 
   .i_slave_awlen     (slaves[3].aw_len),          
   .i_slave_awsize    (slaves[3].aw_size),         
   .i_slave_awburst   (slaves[3].aw_burst),       
   .i_slave_awlock    (slaves[3].aw_lock),        
   .i_slave_awcache   (slaves[3].aw_cache),        
   .i_slave_awprot    (slaves[3].aw_prot), 
   .i_slave_awregion  (slaves[3].aw_region),       
   .i_slave_awuser    (slaves[3].aw_user), 
   .i_slave_awqos     (slaves[3].aw_qos),  
   .i_slave_awvalid   (slaves[3].aw_valid),        
   .o_slave_awready   (slaves[3].aw_ready),        

   //AXI write data bus
   .i_slave_wdata     (slaves[3].w_data),
   .i_slave_wstrb     (slaves[3].w_strb),   
   .i_slave_wlast     (slaves[3].w_last), 
   .i_slave_wuser     (slaves[3].w_user),   
   .i_slave_wvalid    (slaves[3].w_valid),  
   .o_slave_wready    (slaves[3].w_ready),  

   //AXI write response bus
   .o_slave_bid       (slaves[3].b_id),
   .o_slave_bresp     (slaves[3].b_resp),
   .o_slave_bvalid    (slaves[3].b_valid),
   .o_slave_buser     (slaves[3].b_user),   
   .i_slave_bready    (slaves[3].b_ready),

   //AXI read address bus
   .i_slave_arid      (slaves[3].ar_id),
   .i_slave_araddr    (slaves[3].ar_addr),
   .i_slave_arlen     (slaves[3].ar_len),   
   .i_slave_arsize    (slaves[3].ar_size),  
   .i_slave_arburst   (slaves[3].ar_burst), 
   .i_slave_arlock    (slaves[3].ar_lock),  
   .i_slave_arcache   (slaves[3].ar_cache),
   .i_slave_arprot    (slaves[3].ar_prot),
   .i_slave_arregion  (slaves[3].ar_region),       
   .i_slave_aruser    (slaves[3].ar_user),  
   .i_slave_arqos     (slaves[3].ar_qos),  
   .i_slave_arvalid   (slaves[3].ar_valid), 
   .o_slave_arready   (slaves[3].ar_ready), 

   //AXI read data bus
   .o_slave_rid       (slaves[3].r_id),
   .o_slave_rdata     (slaves[3].r_data),
   .o_slave_rresp     (slaves[3].r_resp),
   .o_slave_rlast     (slaves[3].r_last),   
   .o_slave_ruser     (slaves[3].r_user),   
   .o_slave_rvalid    (slaves[3].r_valid),  
   .i_slave_rready    (slaves[3].r_ready),  

   //eflash model signal
   .o_addr_eflsh      (o_addr_eflsh),
   .o_addr_1_eflsh    (o_addr_1_eflsh),
   .o_word_eflsh      (o_word_eflsh),
   .o_din_eflsh       (o_din_eflsh),
   .i_dout_eflsh      (i_dout_eflsh),
   .o_resetb_eflsh    (o_resetb_eflsh),
   .o_cs_eflsh        (o_cs_eflsh),
   .o_ae_eflsh        (o_ae_eflsh),
   .o_oe_eflsh        (o_oe_eflsh),
   .o_ifren_eflsh     (o_ifren_eflsh),
   .o_nvstr_eflsh     (o_nvstr_eflsh),
   .o_prog_eflsh      (o_prog_eflsh),
   .o_sera_eflsh      (o_sera_eflsh),
   .o_mase_eflsh      (o_mase_eflsh),
   .i_tbit_eflsh      (i_tbit_eflsh),
   //EFT -> IOM
   .i_smten_pad       (i_smten_pad),
   .i_sce_pad         (i_sce_pad),
   .sclk_pad          (sclk_pad),
   .o_sio_oen_pad     (o_sio_oen_pad), 
   .o_sio_pad         (o_sio_pad),
   .i_sio_pad         (i_sio_pad),
   //EFT -> PF64AK
   .o_smten_eflsh     (o_smten_eflsh),
   .o_sce_eflsh       (o_sce_eflsh),
   .sclk_eflsh        (sclk_eflsh),
   .i_sio_oen_eflsh   (i_sio_oen_eflsh), 
   .i_sio_eflsh       (i_sio_eflsh),
   .o_sio_eflsh       (o_sio_eflsh)
);

ANA_TOP analog_top(
    .ADC_CKOUT           (adc_ckout), 
    .ADC_DOUT            (adc_dout), 
    .ANA_TOP_TP          (pad_30_spad),//ANA_TOP_TP
    .PVD_OUT             (pvd_in), 
    .RESETB              (rst_async_por_n), 
    .RING32K_CLK         (clk_rc32k),
    .RING32K_CLK_RDY     (rc32k_ready), 
    .RING32M_CLK         (clk_rc32m), 
    .RING32M_CLK_RDY     (rc32m_ready), 
    //.VOUT_LDO            (VDD), 
    .XTAL32K_CLK         (clk_32k), 
    .ADC_CLKIN           (adc_clkin_ana),
    .ADC_IN              ({pad_22_spad, pad_23_spad, pad_24_spad, pad_25_spad, pad_26_spad, pad_27_spad, pad_28_spad, pad_29_spad}), 
    //.ADC_IN_7            (pad_22_spad), 
    //.ADC_IN_6            (pad_23_spad), 
    //.ADC_IN_5            (pad_24_spad), 
    //.ADC_IN_4            (pad_25_spad), 
    //.ADC_IN_3            (pad_26_spad), 
    //.ADC_IN_2            (pad_27_spad), 
    //.ADC_IN_1            (pad_28_spad), 
    //.ADC_IN_0            (pad_29_spad), 
    .ADC_REG_IN_0        (regin0), 
    .ADC_REG_IN_1        (regin1), 
    .ADC_RESETB          (adc_rstb), 
    .ADC_START           (adc_start), 
    .ADC_VRM_EXT         (pad_32_spad),//ADC_VRM_EXT
    .ADC_VRP_EXT         (pad_31_spad),//ADC_VRP_EXT
    .ATEST_EN            (atest_en), 
    .ATEST_SEL           (atest_sel), 
    //.AVSS                (AVSS), 
    .EN_XTAL32K          (en_xtal32k), 
    .EXT_EN_XTAL32K      (ext_en_xtal32k), 
    .FREQ_SEL_RING32K    (freq_sel_rc32k), 
    .FREQ_SEL_RING32M    (freq_sel_rc32m),
    .PD_LDO15            (pd_ldo15), 
    .PD_PVD              (pd_pvd), 
    .PD_RING32M          (rc32m_pd), 
    .PD_V2I              (pd_v2i), 
    .PVD_SEL             (pvd_sel), 
    .SHORTXIXO           (shortxixo), 
    //.VCC                 (VCC), 
    .XI                  (pad_xtal0_spad),//xtal_in
    .XO                  (pad_xtal1_spad)//xtal_out
);

PF64AK32EI40 PF64AK32EI40(
    .ADDR          (o_addr_eflsh    ), 
    .DIN           (o_din_eflsh     ), 
    .DOUT          (i_dout_eflsh    ),                
    .CS            (o_cs_eflsh      ), 
    .AE            (o_ae_eflsh      ), 
    .OE            (o_oe_eflsh      ), 
    .IFREN         (o_ifren_eflsh   ), 
    .NVSTR         (o_nvstr_eflsh   ), 
    .PROG          (o_prog_eflsh    ), 
    .SERA          (o_sera_eflsh    ), 
    .MASE          (o_mase_eflsh    ), 
    .TBIT          (i_tbit_eflsh    ),                 
    .ADDR_1        (o_addr_1_eflsh  ), 
    .WORD          (o_word_eflsh    ),               
    .RESETB        (o_resetb_eflsh  ),                  
    //.VDD           (VDD             ), 
    //.VSS           (VSS             ), 
    //.VPP           (VPP             ), 
    //.VNN           (VNN             ),               
    .SMTEN         (o_smten_eflsh   ), 
    .SCE           (o_sce_eflsh     ),
    .SCLK          (sclk_eflsh      ),
    .SIO_OEN       (i_sio_oen_eflsh ), 
    .SIO_O         (i_sio_eflsh     ), 
    .SIO_I         (o_sio_eflsh     )
);//o_sio_eflsh
endmodule

