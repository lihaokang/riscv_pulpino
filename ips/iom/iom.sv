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
//	------------------------------------------------------------------------------ //	Project and Control Information
//	------------------------------------------------------------------------------
//	Project Name	    :       Proton-SoC
//	This module name	:       io management
//	Author          	:       weijie.chen
//	------------------------------------------------------------------------------
//	CoreLink Confidential Module(s) Information
//	UMC 0.11um Embedded Flash Process
//	------------------------------------------------------------------------------
// #############################################################################

module iom
#(
    parameter APB_ADDR_WIDTH = 32  //APB slaves are 4KB by default
)
(
//apb
    input  logic                      HCLK,
    input  logic                      HRESETn,
    input  logic [APB_ADDR_WIDTH-1:0] PADDR,
    input  logic               [31:0] PWDATA,
    input  logic                      PWRITE,
    input  logic                      PSEL,
    input  logic                      PENABLE,
    output logic               [31:0] PRDATA,
    output logic                      PREADY,
    output logic                      PSLVERR,
//internal signals
    //SPI Slave
    input logic [1:0]       spi_mode_o,
    input logic             spi_sdo0_o,
    input logic             spi_sdo1_o,
    input logic             spi_sdo2_o,
    input logic             spi_sdo3_o,
    output  logic           spi_clk_i,
    output  logic           spi_cs_i,
    output  logic           spi_sdi0_i,
    output  logic           spi_sdi1_i,
    output  logic           spi_sdi2_i,
    output  logic           spi_sdi3_i,

    //SPI Master
    input logic             spi_master_clk_o,
    input logic             spi_master_csn0_o,
    input logic             spi_master_csn1_o,
    input logic             spi_master_csn2_o,
    input logic             spi_master_csn3_o,
    input logic [1:0]       spi_master_mode_o,
    input logic             spi_master_sdo0_o,
    input logic             spi_master_sdo1_o,
    input logic             spi_master_sdo2_o,
    input logic             spi_master_sdo3_o,
    output logic            spi_master_sdi0_i,
    output logic            spi_master_sdi1_i,
    output logic            spi_master_sdi2_i,
    output logic            spi_master_sdi3_i,

    //SPI1 Master
    input logic             spi1_master_clk_o,
    input logic             spi1_master_csn0_o,
    input logic             spi1_master_csn1_o,
    input logic             spi1_master_csn2_o,
    input logic             spi1_master_csn3_o,
    input logic [1:0]       spi1_master_mode_o,
    input logic             spi1_master_sdo0_o,
    input logic             spi1_master_sdo1_o,
    input logic             spi1_master_sdo2_o,
    input logic             spi1_master_sdo3_o,
    output  logic           spi1_master_sdi0_i,
    output  logic           spi1_master_sdi1_i,
    output  logic           spi1_master_sdi2_i,
    output  logic           spi1_master_sdi3_i,    

//i2c master
    output logic            scl_pad_i,
    output logic            sda_pad_i,
    input logic             scl_pad_o,
    input logic             scl_padoen_o,
    input logic             sda_pad_o,
    input logic             sda_padoen_o,

//i2c master1
    output logic            scl1_pad_i,
    output logic            sda1_pad_i,
    input logic             scl1_pad_o,
    input logic             scl1_padoen_o,
    input logic             sda1_pad_o,
    input logic             sda1_padoen_o,

//i2c master2
    output logic            scl2_pad_i,
    output logic            sda2_pad_i,
    input logic             scl2_pad_o,
    input logic             scl2_padoen_o,
    input logic             sda2_pad_o,
    input logic             sda2_padoen_o,

//i2c master3
    output logic            scl3_pad_i,
    output logic            sda3_pad_i,
    input logic             scl3_pad_o,
    input logic             scl3_padoen_o,
    input logic             sda3_pad_o,
    input logic             sda3_padoen_o,

//i2c master4
    output logic            scl4_pad_i,
    output logic            sda4_pad_i,
    input logic             scl4_pad_o,
    input logic             scl4_padoen_o,
    input logic             sda4_pad_o,
    input logic             sda4_padoen_o,

//i2c master5
    output logic            scl5_pad_i,
    output logic            sda5_pad_i,
    input logic             scl5_pad_o,
    input logic             scl5_padoen_o,
    input logic             sda5_pad_o,
    input logic             sda5_padoen_o,

    input logic             uart_tx,
    output logic            uart_rx,
    input logic             uart1_tx,
    output logic            uart1_rx,
    input logic             uart2_tx,
    output logic            uart2_rx,
    input logic             uart3_tx,
    output logic            uart3_rx,
    input logic             uart4_tx,
    output logic            uart4_rx,
    input logic             uart5_tx,
    output logic            uart5_rx,

// JTAG signals
    output logic            tck_i,
    output logic            trstn_i,
    output logic            tms_i,
    output logic            tdi_i,
    input logic             tdo_o,

    output logic            rst_async_key_n,

//boot-sel
    output logic            boot_sel_0_i,
    output logic            boot_sel_1_i,

//pwm    
    input logic             pwm0,
    input logic             pwm1,
    input logic             pwm2,
    input logic             pwm3,
    input logic             pwm4,
    input logic             pwm5,
    input logic             pwm6,
    input logic             pwm7,

//EFT
    output logic            i_smten_pad  ,
    output logic            i_sce_pad    ,
    output logic            sclk_pad     ,
    input  logic            o_sio_oen_pad, 
    input  logic            o_sio_pad    ,
    output logic            i_sio_pad    ,

//gpio1
    output logic    [4:0]   gpio1_in,//TBD
    input logic     [4:0]   gpio1_out,//TBD
    input logic     [4:0]   gpio1_dir,//TBD
                            
    output logic    [31:0]  gpio_in,
    input logic     [31:0]  gpio_out,
    input logic     [31:0]  gpio_dir,

    input logic             clk_32k,
    input logic             chip_rst_n,

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

//dfd signals
    input logic             clk_test,

//jtag-pads
	inout wire pad_jtag_tck_spad,
	inout wire pad_jtag_rstn_spad,
	inout wire pad_jtag_tms_spad,
	inout wire pad_jtag_tdi_spad,
	inout wire pad_jtag_tdo_spad,
    
	inout wire pad_resetn_spad,
	inout wire pad_cms_1_spad,

//boot-sel pads
	inout wire pad_cms_0_spad,
	inout wire pad_boot_sel_spad,
	inout wire pad_xtal0_spad,
	inout wire pad_xtal1_spad,

//idio-pads
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
	inout wire pad_34_spad
    );

//Internal Parameters
    localparam APB_DATA_WIDTH   = 8'd32;
    localparam IOM_BASE_ADDR    = 32'h1B00_5000;
    localparam REG_IOMCR0       = IOM_BASE_ADDR + 32'h0;
    localparam REG_IOMCR1       = IOM_BASE_ADDR + 32'h4;
    localparam REG_IOMCR2       = IOM_BASE_ADDR + 32'h8;
    localparam REG_IOMCR3       = IOM_BASE_ADDR + 32'hC;
    localparam REG_IOMCR4       = IOM_BASE_ADDR + 32'h10;
    localparam REG_ENO_CFG0     = IOM_BASE_ADDR + 32'h14;
    localparam REG_ENO_CFG1     = IOM_BASE_ADDR + 32'h18;
    localparam REG_ENI_CFG0     = IOM_BASE_ADDR + 32'h1C;
    localparam REG_ENI_CFG1     = IOM_BASE_ADDR + 32'h20;
    localparam REG_PU1_CFG0     = IOM_BASE_ADDR + 32'h24;
    localparam REG_PU1_CFG1     = IOM_BASE_ADDR + 32'h28;
    localparam REG_PU2_CFG0     = IOM_BASE_ADDR + 32'h2C;
    localparam REG_PU2_CFG1     = IOM_BASE_ADDR + 32'h30;
    localparam REG_OD_CFG0      = IOM_BASE_ADDR + 32'h34;
    localparam REG_OD_CFG1      = IOM_BASE_ADDR + 32'h38;

//apb
    wire [APB_ADDR_WIDTH-1:0] register_addr;
    wire        apb_wr, apb_rd;
    wire [3:0]  pad0_mode;
    wire [3:0]  pad1_mode;
    wire [3:0]  pad2_mode;
    wire [3:0]  pad3_mode;
    wire [3:0]  pad4_mode;
    wire [3:0]  pad5_mode;
    wire [3:0]  pad6_mode;
    wire [3:0]  pad7_mode;
    wire [3:0]  pad8_mode;
    wire [3:0]  pad9_mode;
    wire [3:0]  pad10_mode;
    wire [3:0]  pad11_mode;
    wire [3:0]  pad12_mode;
    wire [3:0]  pad13_mode;
    wire [3:0]  pad14_mode;
    wire [3:0]  pad15_mode;
    wire [3:0]  pad16_mode;
    wire [3:0]  pad17_mode;
    wire [3:0]  pad18_mode;
    wire [3:0]  pad19_mode;
    wire [3:0]  pad20_mode;
    wire [3:0]  pad21_mode;
    wire [3:0]  pad22_mode;
    wire [3:0]  pad23_mode;
    wire [3:0]  pad24_mode;
    wire [3:0]  pad25_mode;
    wire [3:0]  pad26_mode;
    wire [3:0]  pad27_mode;
    wire [3:0]  pad28_mode;
    wire [3:0]  pad29_mode;
    wire [3:0]  pad30_mode;
    wire [3:0]  pad31_mode;
    wire [3:0]  pad32_mode;
    wire [3:0]  pad33_mode;
    wire [3:0]  pad34_mode;
    wire [3:0]  pad_xtal0_mode;
    wire [3:0]  pad_xtal1_mode;

    reg [31:0]  iom_cr0;
    reg [31:0]  iom_cr1;
    reg [31:0]  iom_cr2;
    reg [31:0]  iom_cr3;
    reg [31:0]  iom_cr4;
    reg [31:0]  eno_cfg0;
    reg [31:0]  eno_cfg1;
    reg [31:0]  eni_cfg0;
    reg [31:0]  eni_cfg1;
    reg [31:0]  pu1_cfg0;
    reg [31:0]  pu1_cfg1;
    reg [31:0]  pu2_cfg0;
    reg [31:0]  pu2_cfg1;
    reg [31:0]  od_cfg0;
    reg [31:0]  od_cfg1;
    reg [31:0]  prdata_pre;
    
//idio_io_wire
	wire pad_0_od	;
	wire pad_0_eno	;
	wire pad_0_eni	;
	wire pad_0_din	;
	wire pad_0_pu1	;
	wire pad_0_pu2	;
	wire pad_0_dout;

	wire pad_1_od	;
	wire pad_1_eno	;
	wire pad_1_eni	;
	wire pad_1_din	;
	wire pad_1_pu1	;
	wire pad_1_pu2	;
	wire pad_1_dout;

	wire pad_2_od	;
	wire pad_2_eno	;
	wire pad_2_eni	;
	wire pad_2_din	;
	wire pad_2_pu1	;
	wire pad_2_pu2	;
	wire pad_2_dout;

	wire pad_3_od	;
	wire pad_3_eno	;
	wire pad_3_eni	;
	wire pad_3_din	;
	wire pad_3_pu1	;
	wire pad_3_pu2	;
	wire pad_3_dout;

	wire pad_4_od	;
	wire pad_4_eno	;
	wire pad_4_eni	;
	wire pad_4_din	;
	wire pad_4_pu1	;
	wire pad_4_pu2	;
	wire pad_4_dout;

	wire pad_5_od	;
	wire pad_5_eno	;
	wire pad_5_eni	;
	wire pad_5_din	;
	wire pad_5_pu1	;
	wire pad_5_pu2	;
	wire pad_5_dout;

	wire pad_6_od	;
	wire pad_6_eno	;
	wire pad_6_eni	;
	wire pad_6_din	;
	wire pad_6_pu1	;
	wire pad_6_pu2	;
	wire pad_6_dout;

	wire pad_7_od	;
	wire pad_7_eno	;
	wire pad_7_eni	;
	wire pad_7_din	;
	wire pad_7_pu1	;
	wire pad_7_pu2	;
	wire pad_7_dout;

	wire pad_8_od	;
	wire pad_8_eno	;
	wire pad_8_eni	;
	wire pad_8_din	;
	wire pad_8_pu1	;
	wire pad_8_pu2	;
	wire pad_8_dout;

	wire pad_9_od	;
	wire pad_9_eno	;
	wire pad_9_eni	;
	wire pad_9_din	;
	wire pad_9_pu1	;
	wire pad_9_pu2	;
	wire pad_9_dout;

	wire pad_10_od	;
	wire pad_10_eno	;
	wire pad_10_eni	;
	wire pad_10_din	;
	wire pad_10_pu1	;
	wire pad_10_pu2	;
	wire pad_10_dout;

	wire pad_11_od	;
	wire pad_11_eno	;
	wire pad_11_eni	;
	wire pad_11_din	;
	wire pad_11_pu1	;
	wire pad_11_pu2	;
	wire pad_11_dout;

	wire pad_12_od	;
	wire pad_12_eno	;
	wire pad_12_eni	;
	wire pad_12_din	;
	wire pad_12_pu1	;
	wire pad_12_pu2	;
	wire pad_12_dout;

	wire pad_13_od	;
	wire pad_13_eno	;
	wire pad_13_eni	;
	wire pad_13_din	;
	wire pad_13_pu1	;
	wire pad_13_pu2	;
	wire pad_13_dout;

	wire pad_14_od	;
	wire pad_14_eno	;
	wire pad_14_eni	;
	wire pad_14_din	;
	wire pad_14_pu1	;
	wire pad_14_pu2	;
	wire pad_14_dout;

	wire pad_15_od	;
	wire pad_15_eno	;
	wire pad_15_eni	;
	wire pad_15_din	;
	wire pad_15_pu1	;
	wire pad_15_pu2	;
	wire pad_15_dout;

	wire pad_16_od	;
	wire pad_16_eno	;
	wire pad_16_eni	;
	wire pad_16_din	;
	wire pad_16_pu1	;
	wire pad_16_pu2	;
	wire pad_16_dout;

	wire pad_17_od	;
	wire pad_17_eno	;
	wire pad_17_eni	;
	wire pad_17_din	;
	wire pad_17_pu1	;
	wire pad_17_pu2	;
	wire pad_17_dout;

	wire pad_18_od	;
	wire pad_18_eno	;
	wire pad_18_eni	;
	wire pad_18_din	;
	wire pad_18_pu1	;
	wire pad_18_pu2	;
	wire pad_18_dout;

	wire pad_19_od	;
	wire pad_19_eno	;
	wire pad_19_eni	;
	wire pad_19_din	;
	wire pad_19_pu1	;
	wire pad_19_pu2	;
	wire pad_19_dout;

	wire pad_20_od	;
	wire pad_20_eno	;
	wire pad_20_eni	;
	wire pad_20_din	;
	wire pad_20_pu1	;
	wire pad_20_pu2	;
	wire pad_20_dout;

	wire pad_21_od	;
	wire pad_21_eno	;
	wire pad_21_eni	;
	wire pad_21_din	;
	wire pad_21_pu1	;
	wire pad_21_pu2	;
	wire pad_21_dout;

	wire pad_22_od	;
	wire pad_22_eno	;
	wire pad_22_eni	;
	wire pad_22_din	;
	wire pad_22_pu1	;
	wire pad_22_pu2	;
	wire pad_22_dout;

	wire pad_23_od	;
	wire pad_23_eno	;
	wire pad_23_eni	;
	wire pad_23_din	;
	wire pad_23_pu1	;
	wire pad_23_pu2	;
	wire pad_23_dout;

	wire pad_24_od	;
	wire pad_24_eno	;
	wire pad_24_eni	;
	wire pad_24_din	;
	wire pad_24_pu1	;
	wire pad_24_pu2	;
	wire pad_24_dout;

	wire pad_25_od	;
	wire pad_25_eno	;
	wire pad_25_eni	;
	wire pad_25_din	;
	wire pad_25_pu1	;
	wire pad_25_pu2	;
	wire pad_25_dout;

	wire pad_26_od	;
	wire pad_26_eno	;
	wire pad_26_eni	;
	wire pad_26_din	;
	wire pad_26_pu1	;
	wire pad_26_pu2	;
	wire pad_26_dout;

	wire pad_27_od	;
	wire pad_27_eno	;
	wire pad_27_eni	;
	wire pad_27_din	;
	wire pad_27_pu1	;
	wire pad_27_pu2	;
	wire pad_27_dout;

	wire pad_28_od	;
	wire pad_28_eno	;
	wire pad_28_eni	;
	wire pad_28_din	;
	wire pad_28_pu1	;
	wire pad_28_pu2	;
	wire pad_28_dout;

	wire pad_29_od	;
	wire pad_29_eno	;
	wire pad_29_eni	;
	wire pad_29_din	;
	wire pad_29_pu1	;
	wire pad_29_pu2	;
	wire pad_29_dout;

	wire pad_30_od	;
	wire pad_30_eno	;
	wire pad_30_eni	;
	wire pad_30_din	;
	wire pad_30_pu1	;
	wire pad_30_pu2	;
	wire pad_30_dout;

	wire pad_31_od	;
	wire pad_31_eno	;
	wire pad_31_eni	;
	wire pad_31_din	;
	wire pad_31_pu1	;
	wire pad_31_pu2	;
	wire pad_31_dout;

	wire pad_32_od	;
	wire pad_32_eno	;
	wire pad_32_eni	;
	wire pad_32_din	;
	wire pad_32_pu1	;
	wire pad_32_pu2	;
	wire pad_32_dout;

	wire pad_33_od	;
	wire pad_33_eno	;
	wire pad_33_eni	;
	wire pad_33_din	;
	wire pad_33_pu1	;
	wire pad_33_pu2	;
	wire pad_33_dout;

	wire pad_34_od	;
	wire pad_34_eno	;
	wire pad_34_eni	;
	wire pad_34_din	;
	wire pad_34_pu1	;
	wire pad_34_pu2	;
	wire pad_34_dout;

	wire pad_xtal0_od	;
	wire pad_xtal0_eno	;
	wire pad_xtal0_eni	;
	wire pad_xtal0_din	;
	wire pad_xtal0_pu1	;
	wire pad_xtal0_pu2	;
	wire pad_xtal0_dout ;

	wire pad_xtal1_od	;
	wire pad_xtal1_eno	;
	wire pad_xtal1_eni	;
	wire pad_xtal1_din	;
	wire pad_xtal1_pu1	;
	wire pad_xtal1_pu2	;
	wire pad_xtal1_dout ;

//chip mode select
	wire pad_cms_0_din;
	wire pad_cms_1_din;
	reg [1:0] chip_mode_pre;
	reg [1:0] chip_mode;
    wire atpg_mode;
    wire mbist_mode;
    wire eft_mode;
    wire user_mode;

    always @(posedge clk_32k, negedge chip_rst_n) begin
        if(!chip_rst_n) begin
            chip_mode_pre    <= 2'h0;
            chip_mode        <= 2'h0;
        end
        else begin
            chip_mode_pre    <= {pad_cms_1_din, pad_cms_0_din};
            chip_mode        <= chip_mode_pre;
        end
    end
    
    assign atpg_mode    = (chip_mode == 2'b10) ? 1'h1 : 1'h0;
    assign mbist_mode   = (chip_mode == 2'b01) ? 1'h1 : 1'h0;
    assign eft_mode     = (chip_mode == 2'b11) ? 1'h1 : 1'h0;
    assign user_mode    = (chip_mode == 2'b00) ? 1'h1 : 1'h0;

//self-apb
    assign register_addr= PADDR[APB_ADDR_WIDTH-1:0];
    assign apb_wr       = PSEL && PENABLE && PWRITE;
    assign apb_rd       = PSEL && PENABLE && !PWRITE;
    
    assign pad0_mode     = (user_mode == 1'h1) ? iom_cr0[3 : 0] : 4'hF;//TBD
    assign pad1_mode     = (user_mode == 1'h1) ? iom_cr0[7 : 4] : 4'hF;
    assign pad2_mode     = (user_mode == 1'h1) ? iom_cr0[11: 8] : 4'hF;
    assign pad3_mode     = (user_mode == 1'h1) ? iom_cr0[15:12] : 4'hF;
    assign pad4_mode     = (user_mode == 1'h1) ? iom_cr0[19:16] : 4'hF;
    assign pad5_mode     = (user_mode == 1'h1) ? iom_cr0[23:20] : 4'hF;
    assign pad6_mode     = (user_mode == 1'h1) ? iom_cr0[27:24] : 4'hF;
    assign pad7_mode     = (user_mode == 1'h1) ? iom_cr0[31:28] : 4'hF;
    assign pad8_mode     = (user_mode == 1'h1) ? iom_cr1[3 : 0] : 4'hF;
    assign pad9_mode     = (user_mode == 1'h1) ? iom_cr1[7 : 4] : 4'hF;
    assign pad10_mode    = (user_mode == 1'h1) ? iom_cr1[11: 8] : 4'hF;
    assign pad11_mode    = (user_mode == 1'h1) ? iom_cr1[15:12] : 4'hF;
    assign pad12_mode    = (user_mode == 1'h1) ? iom_cr1[19:16] : 4'hF;
    assign pad13_mode    = (user_mode == 1'h1) ? iom_cr1[23:20] : 4'hF;
    assign pad14_mode    = (user_mode == 1'h1) ? iom_cr1[27:24] : 4'hF;
    assign pad15_mode    = (user_mode == 1'h1) ? iom_cr1[31:28] : 4'hF;
    assign pad16_mode    = (user_mode == 1'h1) ? iom_cr2[3 : 0] : 4'hF;
    assign pad17_mode    = (user_mode == 1'h1) ? iom_cr2[7 : 4] : 4'hF;
    assign pad18_mode    = (user_mode == 1'h1) ? iom_cr2[11: 8] : 4'hF;
    assign pad19_mode    = (user_mode == 1'h1) ? iom_cr2[15:12] : 4'hF;
    assign pad20_mode    = (user_mode == 1'h1) ? iom_cr2[19:16] : 4'hF;
    assign pad21_mode    = (user_mode == 1'h1) ? iom_cr2[23:20] : 4'hF;
    assign pad22_mode    = (user_mode == 1'h1) ? iom_cr2[27:24] : 4'hF;
    assign pad23_mode    = (user_mode == 1'h1) ? iom_cr2[31:28] : 4'hF;
    assign pad24_mode    = (user_mode == 1'h1) ? iom_cr3[3 : 0] : 4'hF;
    assign pad25_mode    = (user_mode == 1'h1) ? iom_cr3[7 : 4] : 4'hF;
    assign pad26_mode    = (user_mode == 1'h1) ? iom_cr3[11: 8] : 4'hF;
    assign pad27_mode    = (user_mode == 1'h1) ? iom_cr3[15:12] : 4'hF;
    assign pad28_mode    = (user_mode == 1'h1) ? iom_cr3[19:16] : 4'hF;
    assign pad29_mode    = (user_mode == 1'h1) ? iom_cr3[23:20] : 4'hF;
    assign pad30_mode    = (user_mode == 1'h1) ? iom_cr3[27:24] : 4'hF;
    assign pad31_mode    = (user_mode == 1'h1) ? iom_cr3[31:28] : 4'hF;
    assign pad32_mode    = (user_mode == 1'h1) ? iom_cr4[3 : 0] : 4'hF;
    assign pad33_mode    = (user_mode == 1'h1) ? iom_cr4[7 : 4] : 4'hF;
    assign pad34_mode    = (user_mode == 1'h1) ? iom_cr4[11: 8] : 4'hF;
    assign pad_xtal0_mode= iom_cr4[15:12];//TBD
    assign pad_xtal1_mode= iom_cr4[19:16];

    always_ff @(posedge HCLK, negedge HRESETn) begin
        if(~HRESETn) begin
            iom_cr0     <= 32'h22222222;
            iom_cr1     <= 32'h22222222;
            iom_cr2     <= 32'h22222222;
            iom_cr3     <= 32'h22222222;
            iom_cr4     <= 32'h222;
            eno_cfg0    <= 32'h0;
            eno_cfg1    <= 32'h0;
            eni_cfg0    <= 32'hFFFFFFFF;
            eni_cfg1    <= 32'h1F;
            pu1_cfg0    <= 32'h0;
            pu1_cfg1    <= 32'h0;
            pu2_cfg0    <= 32'h0;
            pu2_cfg1    <= 32'h0;
            od_cfg0     <= 32'h0;
            od_cfg1     <= 32'h0;
        end
        else begin
            if (apb_wr) begin
                case(register_addr)
                    REG_IOMCR0:
                        iom_cr0 <= PWDATA;
                    REG_IOMCR1:
                        iom_cr1 <= PWDATA;
                    REG_IOMCR2:
                        iom_cr2 <= PWDATA;
                    REG_IOMCR3:
                        iom_cr3 <= PWDATA;
                    REG_IOMCR4:
                        iom_cr4 <= PWDATA;
                    REG_ENO_CFG0:
                        eno_cfg0 <= PWDATA;
                    REG_ENO_CFG1:
                        eno_cfg1 <= PWDATA;
                    REG_ENI_CFG0:
                        eni_cfg0 <= PWDATA;
                    REG_ENI_CFG1:
                        eni_cfg1 <= PWDATA;
                    REG_PU1_CFG0:
                        pu1_cfg0 <= PWDATA;
                    REG_PU1_CFG1:
                        pu1_cfg1 <= PWDATA;
                    REG_PU2_CFG0:
                        pu2_cfg0 <= PWDATA;
                    REG_PU2_CFG1:
                        pu2_cfg1 <= PWDATA;
                    REG_OD_CFG0:
                        od_cfg0 <= PWDATA;
                    REG_OD_CFG1:
                        od_cfg1 <= PWDATA;
                endcase
            end
            else begin
                iom_cr0  <= iom_cr0 ;
                iom_cr1  <= iom_cr1 ;
                iom_cr2  <= iom_cr2 ;
                iom_cr3  <= iom_cr3 ;
                iom_cr4  <= iom_cr4 ;
                eno_cfg0 <= eno_cfg0;
                eno_cfg1 <= eno_cfg1;
                eni_cfg0 <= eni_cfg0;
                eni_cfg1 <= eni_cfg1;
                pu1_cfg0 <= pu1_cfg0;
                pu1_cfg1 <= pu1_cfg1;
                pu2_cfg0 <= pu2_cfg0;
                pu2_cfg1 <= pu2_cfg1;
                od_cfg0  <= od_cfg0 ;
                od_cfg1  <= od_cfg1 ;
            end
        end
    end

    always_comb begin
        case (register_addr)
            REG_IOMCR0:     prdata_pre = iom_cr0;
            REG_IOMCR1:     prdata_pre = iom_cr1;
            REG_IOMCR2:     prdata_pre = iom_cr2;
            REG_IOMCR3:     prdata_pre = iom_cr3;
            REG_IOMCR4:     prdata_pre = iom_cr4;
            REG_ENO_CFG0:   prdata_pre = eno_cfg0;
            REG_ENO_CFG1:   prdata_pre = eno_cfg1;
            REG_ENI_CFG0:   prdata_pre = eni_cfg0;
            REG_ENI_CFG1:   prdata_pre = eni_cfg1;
            REG_PU1_CFG0:   prdata_pre = pu1_cfg0;
            REG_PU1_CFG1:   prdata_pre = pu1_cfg1;
            REG_PU2_CFG0:   prdata_pre = pu2_cfg0;
            REG_PU2_CFG1:   prdata_pre = pu2_cfg1;
            REG_OD_CFG0:    prdata_pre = od_cfg0;
            REG_OD_CFG1:    prdata_pre = od_cfg1;
            default: prdata_pre = {APB_DATA_WIDTH{1'b0}};
        endcase
    end

    assign PRDATA = apb_rd ? prdata_pre : {APB_DATA_WIDTH{1'b0}};
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

//boot-sel
    wire boot_sel_i;
    assign boot_sel_1_i = boot_sel_i;
    assign boot_sel_0_i = 1'h0;

//mbist
    wire clk_mbist;
    wire rstn_mbist;
    LAGCEM8HM LAGCE_CLK_MBIST (.GCK(clk_mbist), .CK(clk_32k),  .E(mbist_mode));
    assign rstn_mbist = chip_rst_n;

    assign ROM_BIST_CLK             = clk_mbist;
    assign RAM_BIST_CLK             = clk_mbist;
    assign ROM_MBISTPG_MEM_RST      = rstn_mbist;
    assign RAM_MBISTPG_MEM_RST      = rstn_mbist;
    assign ROM_MBISTPG_ASYNC_RESETN = rstn_mbist;
    assign RAM_MBISTPG_ASYNC_RESETN = rstn_mbist;
    assign ROM_LV_TM            = (mbist_mode == 1'h1) ? pad_3_din : 1'b0;
    assign ROM_BIST_SETUP[0]    = (mbist_mode == 1'h1) ? pad_4_din : 1'b0;
    assign ROM_BIST_SETUP[1]    = (mbist_mode == 1'h1) ? pad_5_din : 1'b0;
    assign ROM_MBISTPG_EN       = (mbist_mode == 1'h1) ? pad_6_din : 1'b0;
    assign RAM_LV_TM            = (mbist_mode == 1'h1) ? pad_13_din: 1'b0;
    assign RAM_BIST_SETUP[0]    = (mbist_mode == 1'h1) ? pad_14_din: 1'b0;
    assign RAM_BIST_SETUP[1]    = (mbist_mode == 1'h1) ? pad_15_din: 1'b0;
    assign RAM_MBISTPG_EN       = (mbist_mode == 1'h1) ? pad_16_din: 1'b0;

//atpg
    wire clk_atpg;
    wire scan_en;
    wire [3:0] scan_in;
    reg [3:0] scan_out;
    //LAGCEM8HM LAGCE_CLK_SCAN (.GCK(clk_atpg), .CK(clk_32k),  .E(atpg_mode));


//idio_io_assign
	assign scl_pad_i	= (pad0_mode == 4'h0) ? pad_0_din : 1'b0;
	assign i_smten_pad	= (eft_mode == 1'h1) ? pad_0_din : 1'b0;
	assign gpio_in[0]	= (pad0_mode == 4'h2) ? pad_0_din : 1'b0;
	assign pad_0_od		= od_cfg0[0];
	assign pad_0_eno	= (pad0_mode == 4'h0) ? scl_padoen_o : eno_cfg0[0];
	assign pad_0_eni	= eni_cfg0[0];
	assign pad_0_pu1	= pu1_cfg0[0];
	assign pad_0_pu2	= pu2_cfg0[0];
	assign pad_0_dout	= (mbist_mode == 1'h1) ? ROM_MBISTPG_GO :
                        (pad0_mode == 4'h0) ? scl_pad_o :
						(pad0_mode == 4'h1) ? spi1_master_clk_o :
						(pad0_mode == 4'h4) ? clk_test :
						(pad0_mode == 4'h2) ? gpio_out[0]: 1'b0;

	assign sda_pad_i	= (pad1_mode == 4'h0) ? pad_1_din : 1'b0;
	assign i_sce_pad	= (eft_mode == 1'h1) ? pad_1_din : 1'b0;
	assign gpio_in[1]	= (pad1_mode == 4'h2) ? pad_1_din : 1'b0;
	assign pad_1_od		= od_cfg0[1];
	assign pad_1_eno	= (pad1_mode == 4'h0) ? sda_padoen_o : eno_cfg0[1];
	assign pad_1_eni	= eni_cfg0[1];
	assign pad_1_pu1	= pu1_cfg0[1];
	assign pad_1_pu2	= pu2_cfg0[1];
	assign pad_1_dout	= (mbist_mode == 1'h1) ? ROM_MBISTPG_DONE :
                        (pad1_mode == 4'h0) ? sda_pad_o :
						(pad1_mode == 4'h1) ? spi1_master_csn0_o :
						(pad1_mode == 4'h2) ? gpio_out[1]: 1'b0;

	assign scan_en      = atpg_mode ? pad_2_din : 1'b0;
	assign spi1_master_sdi0_i	= (pad2_mode == 4'h1) ? pad_2_din : 1'b0;
	assign sclk_pad	= (eft_mode == 1'h1) ? pad_2_din : 1'b0;
	assign gpio_in[2]	= (pad2_mode == 4'h2) ? pad_2_din : 1'b0;
	assign pad_2_od		= od_cfg0[2];
	assign pad_2_eno	= eno_cfg0[2];
	assign pad_2_eni	= eni_cfg0[2];
	assign pad_2_pu1	= pu1_cfg0[2];
	assign pad_2_pu2	= pu2_cfg0[2];
	assign pad_2_dout	= (mbist_mode == 1'h1) ? ROM_MBISTPG_SO :
                        (pad2_mode == 4'h0) ? uart_tx :
						(pad2_mode == 4'h1) ? spi1_master_sdo0_o :
						(pad2_mode == 4'h2) ? gpio_out[2]: 1'b0;

	assign scan_in[0]	= atpg_mode ? pad_3_din : 1'b0;
	assign uart_rx	= (pad3_mode == 4'h0) ? pad_3_din : 1'b0;
	assign spi1_master_sdi1_i	= (pad3_mode == 4'h1) ? pad_3_din : 1'b0;
	assign i_sio_pad	= (eft_mode == 1'h1) ? pad_3_din : 1'b0;
	assign gpio_in[3]	= (pad3_mode == 4'h2) ? pad_3_din : 1'b0;
	assign pad_3_od		= od_cfg0[3];
	assign pad_3_eno	= eno_cfg0[3];
	assign pad_3_eni	= eni_cfg0[3];
	assign pad_3_pu1	= pu1_cfg0[3];
	assign pad_3_pu2	= pu2_cfg0[3];
	assign pad_3_dout	= (pad3_mode == 4'h0) ? 1'b0 :
						(pad3_mode == 4'h1) ? spi1_master_sdo1_o :
						(pad3_mode == 4'h2) ? gpio_out[3]: 
						(eft_mode == 4'h1) ? o_sio_pad :1'b0;

	assign scan_in[1]	= atpg_mode ? pad_4_din : 1'b0;
	assign spi_clk_i	= (pad4_mode == 4'h0) ? pad_4_din : 1'b0;
	assign scl3_pad_i	= (pad4_mode == 4'h1) ? pad_4_din : 1'b0;
	assign gpio_in[4]	= (pad4_mode == 4'h2) ? pad_4_din : 1'b0;
	assign pad_4_od		= od_cfg0[4];
	assign pad_4_eno	= eno_cfg0[4];
	assign pad_4_eni	= eni_cfg0[4];
	assign pad_4_pu1	= pu1_cfg0[4];
	assign pad_4_pu2	= pu2_cfg0[4];
	assign pad_4_dout	= (pad4_mode == 4'h0) ? 1'b0 :
						(pad4_mode == 4'h1) ? scl3_pad_o :
						(pad4_mode == 4'h6) ? pwm0 :
						(pad4_mode == 4'h2) ? gpio_out[4]: 1'b0;

	assign scan_in[2]	= atpg_mode ? pad_5_din : 1'b0;
	assign spi_cs_i	= (pad5_mode == 4'h0) ? pad_5_din : 1'b0;
	assign sda3_pad_i	= (pad5_mode == 4'h1) ? pad_5_din : 1'b0;
	assign gpio_in[5]	= (pad5_mode == 4'h2) ? pad_5_din : 1'b0;
	assign pad_5_od		= od_cfg0[5];
	assign pad_5_eno	= eno_cfg0[5];
	assign pad_5_eni	= eni_cfg0[5];
	assign pad_5_pu1	= pu1_cfg0[5];
	assign pad_5_pu2	= pu2_cfg0[5];
	assign pad_5_dout	= (pad5_mode == 4'h0) ? 1'b0 :
						(pad5_mode == 4'h1) ? sda3_pad_o :
						(pad5_mode == 4'h6) ? pwm1 :
						(pad5_mode == 4'h2) ? gpio_out[5]: 1'b0;

	assign scan_in[3]	= atpg_mode ? pad_6_din : 1'b0;
	assign scl4_pad_i	= (pad6_mode == 4'h1) ? pad_6_din : 1'b0;
	assign gpio_in[6]	= (pad6_mode == 4'h2) ? pad_6_din : 1'b0;
	assign pad_6_od		= od_cfg0[6];
	assign pad_6_eno	= eno_cfg0[6];
	assign pad_6_eni	= eni_cfg0[6];
	assign pad_6_pu1	= pu1_cfg0[6];
	assign pad_6_pu2	= pu2_cfg0[6];
	assign pad_6_dout	= (pad6_mode == 4'h0) ? spi_mode_o[0] :
						(pad6_mode == 4'h1) ? scl4_pad_o :
						(pad6_mode == 4'h6) ? pwm2 :
						(pad6_mode == 4'h2) ? gpio_out[6]: 1'b0;

	assign clk_atpg     = atpg_mode ? pad_7_din : 1'b0;
	assign sda4_pad_i	= (pad7_mode == 4'h1) ? pad_7_din : 1'b0;
	assign gpio_in[7]	= (pad7_mode == 4'h2) ? pad_7_din : 1'b0;
	assign pad_7_od		= od_cfg0[7];
	assign pad_7_eno	= eno_cfg0[7];
	assign pad_7_eni	= eni_cfg0[7];
	assign pad_7_pu1	= pu1_cfg0[7];
	assign pad_7_pu2	= pu2_cfg0[7];
	assign pad_7_dout	= (pad7_mode == 4'h0) ? spi_mode_o[1] :
						(pad7_mode == 4'h1) ? sda4_pad_o :
						(pad7_mode == 4'h6) ? pwm3 :
						(pad7_mode == 4'h2) ? gpio_out[7]: 1'b0;

	assign spi_sdi0_i	= (pad8_mode == 4'h0) ? pad_8_din : 1'b0;
	assign gpio_in[8]	= (pad8_mode == 4'h2) ? pad_8_din : 1'b0;
	assign pad_8_od		= od_cfg0[8];
	assign pad_8_eno	= eno_cfg0[8];
	assign pad_8_eni	= eni_cfg0[8];
	assign pad_8_pu1	= pu1_cfg0[8];
	assign pad_8_pu2	= pu2_cfg0[8];
	assign pad_8_dout	= atpg_mode ? scan_out[0] :
                        (pad8_mode == 4'h0) ? spi_sdo0_o :
						(pad8_mode == 4'h1) ? uart5_tx :
						(pad8_mode == 4'h6) ? pwm4 :
						(pad8_mode == 4'h2) ? gpio_out[8]: 1'b0;

	assign spi_sdi1_i	= (pad9_mode == 4'h0) ? pad_9_din : 1'b0;
	assign uart5_rx	= (pad9_mode == 4'h1) ? pad_9_din : 1'b0;
	assign gpio_in[9]	= (pad9_mode == 4'h2) ? pad_9_din : 1'b0;
	assign pad_9_od		= od_cfg0[9];
	assign pad_9_eno	= eno_cfg0[9];
	assign pad_9_eni	= eni_cfg0[9];
	assign pad_9_pu1	= pu1_cfg0[9];
	assign pad_9_pu2	= pu2_cfg0[9];
	assign pad_9_dout	= atpg_mode ? scan_out[1] :
                        (pad9_mode == 4'h0) ? spi_sdo1_o :
						(pad9_mode == 4'h1) ? 1'b0 :
						(pad9_mode == 4'h6) ? pwm5 :
						(pad9_mode == 4'h2) ? gpio_out[9]: 1'b0;

	assign spi_sdi2_i	= (pad10_mode == 4'h0) ? pad_10_din : 1'b0;
	assign scl5_pad_i	= (pad10_mode == 4'h1) ? pad_10_din : 1'b0;
	assign gpio_in[10]	= (pad10_mode == 4'h2) ? pad_10_din : 1'b0;
	assign pad_10_od	= od_cfg0[10];
	assign pad_10_eno	= eno_cfg0[10];
	assign pad_10_eni	= eni_cfg0[10];
	assign pad_10_pu1	= pu1_cfg0[10];
	assign pad_10_pu2	= pu2_cfg0[10];
	assign pad_10_dout	= atpg_mode ? scan_out[2] :
                        (mbist_mode == 1'h1) ? RAM_MBISTPG_GO :
                        (pad10_mode == 4'h0) ? spi_sdo2_o :
						(pad10_mode == 4'h1) ? scl5_pad_o :
						(pad10_mode == 4'h6) ? pwm6 :
						(pad10_mode == 4'h2) ? gpio_out[10]: 1'b0;

	assign spi_sdi3_i	= (pad11_mode == 4'h0) ? pad_11_din : 1'b0;
	assign sda5_pad_i	= (pad11_mode == 4'h1) ? pad_11_din : 1'b0;
	assign gpio_in[11]	= (pad11_mode == 4'h2) ? pad_11_din : 1'b0;
	assign pad_11_od	= od_cfg0[11];
	assign pad_11_eno	= eno_cfg0[11];
	assign pad_11_eni	= eni_cfg0[11];
	assign pad_11_pu1	= pu1_cfg0[11];
	assign pad_11_pu2	= pu2_cfg0[11];
	assign pad_11_dout	= atpg_mode ? scan_out[3] :
                        (mbist_mode == 1'h1) ? RAM_MBISTPG_DONE :
                        (pad11_mode == 4'h0) ? spi_sdo3_o :
						(pad11_mode == 4'h1) ? sda5_pad_o :
						(pad11_mode == 4'h6) ? pwm7 :
						(pad11_mode == 4'h2) ? gpio_out[11]: 1'b0;

	assign scl1_pad_i	= (pad12_mode == 4'h0) ? pad_12_din : 1'b0;
	assign gpio_in[12]	= (pad12_mode == 4'h2) ? pad_12_din : 1'b0;
	assign pad_12_od	= od_cfg0[12];
	assign pad_12_eno	= (pad12_mode == 4'h0) ? scl1_padoen_o : eno_cfg0[12];
	assign pad_12_eni	= eni_cfg0[12];
	assign pad_12_pu1	= pu1_cfg0[12];
	assign pad_12_pu2	= pu2_cfg0[12];
	assign pad_12_dout	= (mbist_mode == 1'h1) ? RAM_MBISTPG_SO :
                        (pad12_mode == 4'h0) ? scl1_pad_o :
						(pad12_mode == 4'h1) ? spi1_master_csn1_o :
						(pad12_mode == 4'h2) ? gpio_out[12]: 1'b0;

	assign sda1_pad_i	= (pad13_mode == 4'h0) ? pad_13_din : 1'b0;
	assign gpio_in[13]	= (pad13_mode == 4'h2) ? pad_13_din : 1'b0;
	assign pad_13_od	= od_cfg0[13];
	assign pad_13_eno	= (pad13_mode == 4'h0) ? sda1_padoen_o : eno_cfg0[13];
	assign pad_13_eni	= eni_cfg0[13];
	assign pad_13_pu1	= pu1_cfg0[13];
	assign pad_13_pu2	= pu2_cfg0[13];
	assign pad_13_dout	= (pad13_mode == 4'h0) ? sda1_pad_o :
						(pad13_mode == 4'h1) ? spi1_master_csn2_o :
						(pad13_mode == 4'h2) ? gpio_out[13]: 1'b0;

	assign gpio_in[14]	= (pad14_mode == 4'h2) ? pad_14_din : 1'b0;
	assign pad_14_od	= od_cfg0[14];
	assign pad_14_eno	= eno_cfg0[14];
	assign pad_14_eni	= eni_cfg0[14];
	assign pad_14_pu1	= pu1_cfg0[14];
	assign pad_14_pu2	= pu2_cfg0[14];
	assign pad_14_dout	= (pad14_mode == 4'h0) ? uart1_tx :
						(pad14_mode == 4'h1) ? spi1_master_csn3_o :
						(pad14_mode == 4'h2) ? gpio_out[14]: 1'b0;

	assign uart1_rx	= (pad15_mode == 4'h0) ? pad_15_din : 1'b0;
	assign gpio_in[15]	= (pad15_mode == 4'h2) ? pad_15_din : 1'b0;
	assign pad_15_od	= od_cfg0[15];
	assign pad_15_eno	= eno_cfg0[15];
	assign pad_15_eni	= eni_cfg0[15];
	assign pad_15_pu1	= pu1_cfg0[15];
	assign pad_15_pu2	= pu2_cfg0[15];
	assign pad_15_dout	= (pad15_mode == 4'h0) ? 1'b0 :
						(pad15_mode == 4'h1) ? spi1_master_mode_o[0] :
						(pad15_mode == 4'h2) ? gpio_out[15]: 1'b0;

	assign gpio_in[16]	= (pad16_mode == 4'h2) ? pad_16_din : 1'b0;
	assign pad_16_od	= od_cfg0[16];
	assign pad_16_eno	= eno_cfg0[16];
	assign pad_16_eni	= eni_cfg0[16];
	assign pad_16_pu1	= pu1_cfg0[16];
	assign pad_16_pu2	= pu2_cfg0[16];
	assign pad_16_dout	= (pad16_mode == 4'h0) ? spi_master_clk_o :
						(pad16_mode == 4'h2) ? gpio_out[16]: 1'b0;

	assign gpio_in[17]	= (pad17_mode == 4'h2) ? pad_17_din : 1'b0;
	assign pad_17_od	= od_cfg0[17];
	assign pad_17_eno	= eno_cfg0[17];
	assign pad_17_eni	= eni_cfg0[17];
	assign pad_17_pu1	= pu1_cfg0[17];
	assign pad_17_pu2	= pu2_cfg0[17];
	assign pad_17_dout	= (pad17_mode == 4'h0) ? spi_master_csn0_o :
						(pad17_mode == 4'h2) ? gpio_out[17]: 1'b0;

	assign spi_master_sdi0_i	= (pad18_mode == 4'h0) ? pad_18_din : 1'b0;
	assign gpio_in[18]	= (pad18_mode == 4'h2) ? pad_18_din : 1'b0;
	assign pad_18_od	= od_cfg0[18];
	assign pad_18_eno	= eno_cfg0[18];
	assign pad_18_eni	= eni_cfg0[18];
	assign pad_18_pu1	= pu1_cfg0[18];
	assign pad_18_pu2	= pu2_cfg0[18];
	assign pad_18_dout	= (pad18_mode == 4'h0) ? spi_master_sdo0_o :
						(pad18_mode == 4'h2) ? gpio_out[18]: 1'b0;

	assign spi_master_sdi1_i	= (pad19_mode == 4'h0) ? pad_19_din : 1'b0;
	assign gpio_in[19]	= (pad19_mode == 4'h2) ? pad_19_din : 1'b0;
	assign pad_19_od	= od_cfg0[19];
	assign pad_19_eno	= eno_cfg0[19];
	assign pad_19_eni	= eni_cfg0[19];
	assign pad_19_pu1	= pu1_cfg0[19];
	assign pad_19_pu2	= pu2_cfg0[19];
	assign pad_19_dout	= (pad19_mode == 4'h0) ? spi_master_sdo1_o :
						(pad19_mode == 4'h2) ? gpio_out[19]: 1'b0;

	assign scl2_pad_i	= (pad20_mode == 4'h0) ? pad_20_din : 1'b0;
	assign gpio_in[20]	= (pad20_mode == 4'h2) ? pad_20_din : 1'b0;
	assign pad_20_od	= od_cfg0[20];
	assign pad_20_eno	= (pad20_mode == 4'h1) ? scl2_padoen_o : eno_cfg0[20];
	assign pad_20_eni	= eni_cfg0[20];
	assign pad_20_pu1	= pu1_cfg0[20];
	assign pad_20_pu2	= pu2_cfg0[20];
	assign pad_20_dout	= (pad20_mode == 4'h0) ? scl2_pad_o :
						(pad20_mode == 4'h1) ? spi1_master_mode_o[1] :
						(pad20_mode == 4'h2) ? gpio_out[20]: 1'b0;

	assign sda2_pad_i	= (pad21_mode == 4'h0) ? pad_21_din : 1'b0;
	assign spi1_master_sdi2_i	= (pad21_mode == 4'h1) ? pad_21_din : 1'b0;
	assign gpio_in[21]	= (pad21_mode == 4'h2) ? pad_21_din : 1'b0;
	assign pad_21_od	= od_cfg0[21];
	assign pad_21_eno	= (pad21_mode == 4'h1) ? sda2_padoen_o : eno_cfg0[21];
	assign pad_21_eni	= eni_cfg0[21];
	assign pad_21_pu1	= pu1_cfg0[21];
	assign pad_21_pu2	= pu2_cfg0[21];
	assign pad_21_dout	= (pad21_mode == 4'h0) ? sda2_pad_o :
						(pad21_mode == 4'h1) ? spi1_master_sdo2_o :
						(pad21_mode == 4'h2) ? gpio_out[21]: 1'b0;

//	assign ADC_IN_7	= (pad22_mode == 4'h1) ? pad_22_din : 1'b0;
	assign gpio_in[22]	= (pad22_mode == 4'h2) ? pad_22_din : 1'b0;
	assign pad_22_od	= od_cfg0[22];
	assign pad_22_eno	= eno_cfg0[22];
	assign pad_22_eni	= eni_cfg0[22];
	assign pad_22_pu1	= pu1_cfg0[22];
	assign pad_22_pu2	= pu2_cfg0[22];
	assign pad_22_dout	= (pad22_mode == 4'h0) ? uart2_tx :
						(pad22_mode == 4'h2) ? gpio_out[22]: 1'b0;

	assign uart2_rx	= (pad23_mode == 4'h0) ? pad_23_din : 1'b0;
//	assign ADC_IN_6	= (pad23_mode == 4'h1) ? pad_23_din : 1'b0;
	assign gpio_in[23]	= (pad23_mode == 4'h2) ? pad_23_din : 1'b0;
	assign pad_23_od	= od_cfg0[23];
	assign pad_23_eno	= eno_cfg0[23];
	assign pad_23_eni	= eni_cfg0[23];
	assign pad_23_pu1	= pu1_cfg0[23];
	assign pad_23_pu2	= pu2_cfg0[23];
	assign pad_23_dout	= (pad23_mode == 4'h0) ? 1'b0 :
						(pad23_mode == 4'h2) ? gpio_out[23]: 1'b0;

//	assign ADC_IN_5	= (pad24_mode == 4'h1) ? pad_24_din : 1'b0;
	assign gpio_in[24]	= (pad24_mode == 4'h2) ? pad_24_din : 1'b0;
	assign pad_24_od	= od_cfg0[24];
	assign pad_24_eno	= atpg_mode ? 1'b1: eno_cfg0[24];
	assign pad_24_eni	= atpg_mode ? 1'b0: eni_cfg0[24];
	assign pad_24_pu1	= pu1_cfg0[24];
	assign pad_24_pu2	= pu2_cfg0[24];
	assign pad_24_dout	= (pad24_mode == 4'h0) ? spi_master_csn1_o :
						(pad24_mode == 4'h2) ? gpio_out[24]: 1'b0;

//	assign ADC_IN_4	= (pad25_mode == 4'h1) ? pad_25_din : 1'b0;
	assign gpio_in[25]	= (pad25_mode == 4'h2) ? pad_25_din : 1'b0;
	assign pad_25_od	= od_cfg0[25];
	assign pad_25_eno	= atpg_mode ? 1'h1 : eno_cfg0[25];
	assign pad_25_eni	= atpg_mode ? 1'h0 : eni_cfg0[25];
	assign pad_25_pu1	= pu1_cfg0[25];
	assign pad_25_pu2	= pu2_cfg0[25];
	assign pad_25_dout	= (pad25_mode == 4'h0) ? spi_master_csn2_o :
						(pad25_mode == 4'h2) ? gpio_out[25]: 1'b0;

//	assign ADC_IN_3	= (pad26_mode == 4'h1) ? pad_26_din : 1'b0;
	assign gpio_in[26]	= (pad26_mode == 4'h2) ? pad_26_din : 1'b0;
	assign pad_26_od	= od_cfg0[26];
	assign pad_26_eno	= atpg_mode ? 1'h1: eno_cfg0[26];
	assign pad_26_eni	= atpg_mode ? 1'h0: eni_cfg0[26];
	assign pad_26_pu1	= pu1_cfg0[26];
	assign pad_26_pu2	= pu2_cfg0[26];
	assign pad_26_dout	= (pad26_mode == 4'h0) ? spi_master_csn3_o :
						(pad26_mode == 4'h2) ? gpio_out[26]: 1'b0;

//	assign ADC_IN_2	= (pad27_mode == 4'h1) ? pad_27_din : 1'b0;
	assign gpio_in[27]	= (pad27_mode == 4'h2) ? pad_27_din : 1'b0;
	assign pad_27_od	= od_cfg0[27];
	assign pad_27_eno	= atpg_mode ? 1'h1: eno_cfg0[27];
	assign pad_27_eni	= atpg_mode ? 1'h0: eni_cfg0[27];
	assign pad_27_pu1	= pu1_cfg0[27];
	assign pad_27_pu2	= pu2_cfg0[27];
	assign pad_27_dout	= (pad27_mode == 4'h0) ? spi_master_mode_o[0] :
						(pad27_mode == 4'h2) ? gpio_out[27]: 1'b0;

//	assign ADC_IN_1	= (pad28_mode == 4'h1) ? pad_28_din : 1'b0;
	assign gpio_in[28]	= (pad28_mode == 4'h2) ? pad_28_din : 1'b0;
	assign pad_28_od	= od_cfg0[28];
	assign pad_28_eno	= eno_cfg0[28];
	assign pad_28_eni	= eni_cfg0[28];
	assign pad_28_pu1	= pu1_cfg0[28];
	assign pad_28_pu2	= pu2_cfg0[28];
	assign pad_28_dout	= (pad28_mode == 4'h0) ? spi_master_mode_o[1] :
						(pad28_mode == 4'h2) ? gpio_out[28]: 1'b0;

	assign spi_master_sdi2_i	= (pad29_mode == 4'h0) ? pad_29_din : 1'b0;
//	assign ADC_IN_0	= (pad29_mode == 4'h1) ? pad_29_din : 1'b0;
	assign gpio_in[29]	= (pad29_mode == 4'h2) ? pad_29_din : 1'b0;
	assign pad_29_od	= od_cfg0[29];
	assign pad_29_eno	= eno_cfg0[29];
	assign pad_29_eni	= eni_cfg0[29];
	assign pad_29_pu1	= pu1_cfg0[29];
	assign pad_29_pu2	= pu2_cfg0[29];
	assign pad_29_dout	= (pad29_mode == 4'h0) ? spi_master_sdo2_o :
						(pad29_mode == 4'h2) ? gpio_out[29]: 1'b0;

	assign spi_master_sdi3_i	= (pad30_mode == 4'h0) ? pad_30_din : 1'b0;
	assign gpio_in[30]	= (pad30_mode == 4'h2) ? pad_30_din : 1'b0;
	assign pad_30_od	= od_cfg0[30];
	assign pad_30_eno	= eno_cfg0[30];
	assign pad_30_eni	= eni_cfg0[30];
	assign pad_30_pu1	= pu1_cfg0[30];
	assign pad_30_pu2	= pu2_cfg0[30];
	assign pad_30_dout	= (pad30_mode == 4'h0) ? spi_master_sdo3_o :
//						(pad30_mode == 4'h1) ? ANA_TOP_TP :
						(pad30_mode == 4'h2) ? gpio_out[30]: 1'b0;

//	assign ADC_VRP_EXT	= (pad31_mode == 4'h1) ? pad_31_din : 1'b0;
	assign gpio_in[31]	= (pad31_mode == 4'h2) ? pad_31_din : 1'b0;
	assign pad_31_od	= od_cfg0[31];
	assign pad_31_eno	= eno_cfg0[31];
	assign pad_31_eni	= eni_cfg0[31];
	assign pad_31_pu1	= pu1_cfg0[31];
	assign pad_31_pu2	= pu2_cfg0[31];
	assign pad_31_dout	= (pad31_mode == 4'h0) ? uart3_tx :
						(pad31_mode == 4'h2) ? gpio_out[31]: 1'b0;

	assign uart3_rx	= (pad32_mode == 4'h0) ? pad_32_din : 1'b0;
//	assign ADC_VRM_EXT	= (pad32_mode == 4'h1) ? pad_32_din : 1'b0;
	assign gpio1_in[0]	= (pad32_mode == 4'h2) ? pad_32_din : 1'b0;
	assign pad_32_od	= od_cfg1[0];
	assign pad_32_eno	= eno_cfg1[0];
	assign pad_32_eni	= eni_cfg1[0];
	assign pad_32_pu1	= pu1_cfg1[0];
	assign pad_32_pu2	= pu2_cfg1[0];
	assign pad_32_dout	= (pad32_mode == 4'h0) ? 1'b0 :
						(pad32_mode == 4'h2) ? gpio1_out[0]: 1'b0;

	assign spi1_master_sdi3_i	= (pad33_mode == 4'h1) ? pad_33_din : 1'b0;
	assign gpio1_in[1]	= (pad33_mode == 4'h2) ? pad_33_din : 1'b0;
	assign pad_33_od	= od_cfg1[1];
	assign pad_33_eno	= eno_cfg1[1];
	assign pad_33_eni	= eni_cfg1[1];
	assign pad_33_pu1	= pu1_cfg1[1];
	assign pad_33_pu2	= pu2_cfg1[1];
	assign pad_33_dout	= (pad33_mode == 4'h0) ? uart4_tx :
						(pad33_mode == 4'h1) ? spi1_master_sdo3_o :
						(pad33_mode == 4'h2) ? gpio1_out[1]: 1'b0;

	assign uart4_rx	= (pad34_mode == 4'h0) ? pad_34_din : 1'b0;
	assign gpio1_in[2]	= (pad34_mode == 4'h2) ? pad_34_din : 1'b0;
	assign pad_34_od	= od_cfg1[2];
	assign pad_34_eno	= eno_cfg1[2];
	assign pad_34_eni	= eni_cfg1[2];
	assign pad_34_pu1	= pu1_cfg1[2];
	assign pad_34_pu2	= pu2_cfg1[2];
	assign pad_34_dout	= (pad34_mode == 4'h0) ? 1'b0 :
						(pad34_mode == 4'h2) ? gpio1_out[2]: 1'b0;

//	assign xtal_in  	    = (pad_xtal0_mode == 4'h0) ? pad_xtal0_din : 1'b0;
	assign gpio1_in[3]	    = (pad_xtal0_mode == 4'h2) ? pad_xtal0_din : 1'b0;
	assign pad_xtal0_od	    = od_cfg1[3];
	assign pad_xtal0_eno	= eno_cfg1[3];
	assign pad_xtal0_eni	= eni_cfg1[3];
	assign pad_xtal0_pu1	= pu1_cfg1[3];
	assign pad_xtal0_pu2	= pu2_cfg1[3];
	assign pad_xtal0_dout	= (pad_xtal0_mode == 4'h2) ? gpio1_out[3]: 1'b0;

//	assign xtal_out 	    = (pad_xtal1_mode == 4'h0) ? pad_xtal1_din : 1'b0;
	assign gpio1_in[4]	    = (pad_xtal1_mode == 4'h2) ? pad_xtal1_din : 1'b0;
	assign pad_xtal1_od	    = od_cfg1[4];
	assign pad_xtal1_eno	= eno_cfg1[4];
	assign pad_xtal1_eni	= eni_cfg1[4];
	assign pad_xtal1_pu1	= pu1_cfg1[4];
	assign pad_xtal1_pu2	= pu2_cfg1[4];
	assign pad_xtal1_dout	= (pad_xtal1_mode == 4'h2) ? gpio1_out[4]: 1'b0;

//idio_inst
	IDIO idio_pad_0(
		.OD		(pad_0_od	),
		.ENO	(pad_0_eno	),
		.ENI	(pad_0_eni	),
		.DIN	(pad_0_din	),
		.PU1	(pad_0_pu1	),
		.PU2	(pad_0_pu2	),
		.DOUT	(pad_0_dout	),
		.SPAD	(pad_0_spad	)
	);

	IDIO idio_pad_1(
		.OD		(pad_1_od	),
		.ENO	(pad_1_eno	),
		.ENI	(pad_1_eni	),
		.DIN	(pad_1_din	),
		.PU1	(pad_1_pu1	),
		.PU2	(pad_1_pu2	),
		.DOUT	(pad_1_dout	),
		.SPAD	(pad_1_spad	)
	);

	IDIO idio_pad_2(
		.OD		(pad_2_od	),
		.ENO	(pad_2_eno	),
		.ENI	(pad_2_eni	),
		.DIN	(pad_2_din	),
		.PU1	(pad_2_pu1	),
		.PU2	(pad_2_pu2	),
		.DOUT	(pad_2_dout	),
		.SPAD	(pad_2_spad	)
	);

	IDIO idio_pad_3(
		.OD		(pad_3_od	),
		.ENO	(pad_3_eno	),
		.ENI	(pad_3_eni	),
		.DIN	(pad_3_din	),
		.PU1	(pad_3_pu1	),
		.PU2	(pad_3_pu2	),
		.DOUT	(pad_3_dout	),
		.SPAD	(pad_3_spad	)
	);

	IDIO idio_pad_4(
		.OD		(pad_4_od	),
		.ENO	(pad_4_eno	),
		.ENI	(pad_4_eni	),
		.DIN	(pad_4_din	),
		.PU1	(pad_4_pu1	),
		.PU2	(pad_4_pu2	),
		.DOUT	(pad_4_dout	),
		.SPAD	(pad_4_spad	)
	);

	IDIO idio_pad_5(
		.OD		(pad_5_od	),
		.ENO	(pad_5_eno	),
		.ENI	(pad_5_eni	),
		.DIN	(pad_5_din	),
		.PU1	(pad_5_pu1	),
		.PU2	(pad_5_pu2	),
		.DOUT	(pad_5_dout	),
		.SPAD	(pad_5_spad	)
	);

	IDIO idio_pad_6(
		.OD		(pad_6_od	),
		.ENO	(pad_6_eno	),
		.ENI	(pad_6_eni	),
		.DIN	(pad_6_din	),
		.PU1	(pad_6_pu1	),
		.PU2	(pad_6_pu2	),
		.DOUT	(pad_6_dout	),
		.SPAD	(pad_6_spad	)
	);

	IDIO idio_pad_7(
		.OD		(pad_7_od	),
		.ENO	(pad_7_eno	),
		.ENI	(pad_7_eni	),
		.DIN	(pad_7_din	),
		.PU1	(pad_7_pu1	),
		.PU2	(pad_7_pu2	),
		.DOUT	(pad_7_dout	),
		.SPAD	(pad_7_spad	)
	);

	IDIO idio_pad_8(
		.OD		(pad_8_od	),
		.ENO	(pad_8_eno	),
		.ENI	(pad_8_eni	),
		.DIN	(pad_8_din	),
		.PU1	(pad_8_pu1	),
		.PU2	(pad_8_pu2	),
		.DOUT	(pad_8_dout	),
		.SPAD	(pad_8_spad	)
	);

	IDIO idio_pad_9(
		.OD		(pad_9_od	),
		.ENO	(pad_9_eno	),
		.ENI	(pad_9_eni	),
		.DIN	(pad_9_din	),
		.PU1	(pad_9_pu1	),
		.PU2	(pad_9_pu2	),
		.DOUT	(pad_9_dout	),
		.SPAD	(pad_9_spad	)
	);

	IDIO idio_pad_10(
		.OD		(pad_10_od	),
		.ENO	(pad_10_eno	),
		.ENI	(pad_10_eni	),
		.DIN	(pad_10_din	),
		.PU1	(pad_10_pu1	),
		.PU2	(pad_10_pu2	),
		.DOUT	(pad_10_dout	),
		.SPAD	(pad_10_spad	)
	);

	IDIO idio_pad_11(
		.OD		(pad_11_od	),
		.ENO	(pad_11_eno	),
		.ENI	(pad_11_eni	),
		.DIN	(pad_11_din	),
		.PU1	(pad_11_pu1	),
		.PU2	(pad_11_pu2	),
		.DOUT	(pad_11_dout	),
		.SPAD	(pad_11_spad	)
	);

	IDIO idio_pad_12(
		.OD		(pad_12_od	),
		.ENO	(pad_12_eno	),
		.ENI	(pad_12_eni	),
		.DIN	(pad_12_din	),
		.PU1	(pad_12_pu1	),
		.PU2	(pad_12_pu2	),
		.DOUT	(pad_12_dout	),
		.SPAD	(pad_12_spad	)
	);

	IDIO idio_pad_13(
		.OD		(pad_13_od	),
		.ENO	(pad_13_eno	),
		.ENI	(pad_13_eni	),
		.DIN	(pad_13_din	),
		.PU1	(pad_13_pu1	),
		.PU2	(pad_13_pu2	),
		.DOUT	(pad_13_dout	),
		.SPAD	(pad_13_spad	)
	);

	IDIO idio_pad_14(
		.OD		(pad_14_od	),
		.ENO	(pad_14_eno	),
		.ENI	(pad_14_eni	),
		.DIN	(pad_14_din	),
		.PU1	(pad_14_pu1	),
		.PU2	(pad_14_pu2	),
		.DOUT	(pad_14_dout	),
		.SPAD	(pad_14_spad	)
	);

	IDIO idio_pad_15(
		.OD		(pad_15_od	),
		.ENO	(pad_15_eno	),
		.ENI	(pad_15_eni	),
		.DIN	(pad_15_din	),
		.PU1	(pad_15_pu1	),
		.PU2	(pad_15_pu2	),
		.DOUT	(pad_15_dout	),
		.SPAD	(pad_15_spad	)
	);

	IDIO idio_pad_16(
		.OD		(pad_16_od	),
		.ENO	(pad_16_eno	),
		.ENI	(pad_16_eni	),
		.DIN	(pad_16_din	),
		.PU1	(pad_16_pu1	),
		.PU2	(pad_16_pu2	),
		.DOUT	(pad_16_dout	),
		.SPAD	(pad_16_spad	)
	);

	IDIO idio_pad_17(
		.OD		(pad_17_od	),
		.ENO	(pad_17_eno	),
		.ENI	(pad_17_eni	),
		.DIN	(pad_17_din	),
		.PU1	(pad_17_pu1	),
		.PU2	(pad_17_pu2	),
		.DOUT	(pad_17_dout	),
		.SPAD	(pad_17_spad	)
	);

	IDIO idio_pad_18(
		.OD		(pad_18_od	),
		.ENO	(pad_18_eno	),
		.ENI	(pad_18_eni	),
		.DIN	(pad_18_din	),
		.PU1	(pad_18_pu1	),
		.PU2	(pad_18_pu2	),
		.DOUT	(pad_18_dout	),
		.SPAD	(pad_18_spad	)
	);

	IDIO idio_pad_19(
		.OD		(pad_19_od	),
		.ENO	(pad_19_eno	),
		.ENI	(pad_19_eni	),
		.DIN	(pad_19_din	),
		.PU1	(pad_19_pu1	),
		.PU2	(pad_19_pu2	),
		.DOUT	(pad_19_dout	),
		.SPAD	(pad_19_spad	)
	);

	IDIO idio_pad_20(
		.OD		(pad_20_od	),
		.ENO	(pad_20_eno	),
		.ENI	(pad_20_eni	),
		.DIN	(pad_20_din	),
		.PU1	(pad_20_pu1	),
		.PU2	(pad_20_pu2	),
		.DOUT	(pad_20_dout	),
		.SPAD	(pad_20_spad	)
	);

	IDIO idio_pad_21(
		.OD		(pad_21_od	),
		.ENO	(pad_21_eno	),
		.ENI	(pad_21_eni	),
		.DIN	(pad_21_din	),
		.PU1	(pad_21_pu1	),
		.PU2	(pad_21_pu2	),
		.DOUT	(pad_21_dout	),
		.SPAD	(pad_21_spad	)
	);

	IDIO idio_pad_22(
		.OD		(pad_22_od	),
		.ENO	(pad_22_eno	),
		.ENI	(pad_22_eni	),
		.DIN	(pad_22_din	),
		.PU1	(pad_22_pu1	),
		.PU2	(pad_22_pu2	),
		.DOUT	(pad_22_dout	),
		.SPAD	(pad_22_spad	)
	);

	IDIO idio_pad_23(
		.OD		(pad_23_od	),
		.ENO	(pad_23_eno	),
		.ENI	(pad_23_eni	),
		.DIN	(pad_23_din	),
		.PU1	(pad_23_pu1	),
		.PU2	(pad_23_pu2	),
		.DOUT	(pad_23_dout	),
		.SPAD	(pad_23_spad	)
	);

	IDIO idio_pad_24(
		.OD		(pad_24_od	),
		.ENO	(pad_24_eno	),
		.ENI	(pad_24_eni	),
		.DIN	(pad_24_din	),
		.PU1	(pad_24_pu1	),
		.PU2	(pad_24_pu2	),
		.DOUT	(pad_24_dout	),
		.SPAD	(pad_24_spad	)
	);

	IDIO idio_pad_25(
		.OD		(pad_25_od	),
		.ENO	(pad_25_eno	),
		.ENI	(pad_25_eni	),
		.DIN	(pad_25_din	),
		.PU1	(pad_25_pu1	),
		.PU2	(pad_25_pu2	),
		.DOUT	(pad_25_dout	),
		.SPAD	(pad_25_spad	)
	);

	IDIO idio_pad_26(
		.OD		(pad_26_od	),
		.ENO	(pad_26_eno	),
		.ENI	(pad_26_eni	),
		.DIN	(pad_26_din	),
		.PU1	(pad_26_pu1	),
		.PU2	(pad_26_pu2	),
		.DOUT	(pad_26_dout	),
		.SPAD	(pad_26_spad	)
	);

	IDIO idio_pad_27(
		.OD		(pad_27_od	),
		.ENO	(pad_27_eno	),
		.ENI	(pad_27_eni	),
		.DIN	(pad_27_din	),
		.PU1	(pad_27_pu1	),
		.PU2	(pad_27_pu2	),
		.DOUT	(pad_27_dout	),
		.SPAD	(pad_27_spad	)
	);

	IDIO idio_pad_28(
		.OD		(pad_28_od	),
		.ENO	(pad_28_eno	),
		.ENI	(pad_28_eni	),
		.DIN	(pad_28_din	),
		.PU1	(pad_28_pu1	),
		.PU2	(pad_28_pu2	),
		.DOUT	(pad_28_dout	),
		.SPAD	(pad_28_spad	)
	);

	IDIO idio_pad_29(
		.OD		(pad_29_od	),
		.ENO	(pad_29_eno	),
		.ENI	(pad_29_eni	),
		.DIN	(pad_29_din	),
		.PU1	(pad_29_pu1	),
		.PU2	(pad_29_pu2	),
		.DOUT	(pad_29_dout	),
		.SPAD	(pad_29_spad	)
	);

	IDIO idio_pad_30(
		.OD		(pad_30_od	),
		.ENO	(pad_30_eno	),
		.ENI	(pad_30_eni	),
		.DIN	(pad_30_din	),
		.PU1	(pad_30_pu1	),
		.PU2	(pad_30_pu2	),
		.DOUT	(pad_30_dout	),
		.SPAD	(pad_30_spad	)
	);

	IDIO idio_pad_31(
		.OD		(pad_31_od	),
		.ENO	(pad_31_eno	),
		.ENI	(pad_31_eni	),
		.DIN	(pad_31_din	),
		.PU1	(pad_31_pu1	),
		.PU2	(pad_31_pu2	),
		.DOUT	(pad_31_dout	),
		.SPAD	(pad_31_spad	)
	);

	IDIO idio_pad_32(
		.OD		(pad_32_od	),
		.ENO	(pad_32_eno	),
		.ENI	(pad_32_eni	),
		.DIN	(pad_32_din	),
		.PU1	(pad_32_pu1	),
		.PU2	(pad_32_pu2	),
		.DOUT	(pad_32_dout	),
		.SPAD	(pad_32_spad	)
	);

	IDIO idio_pad_33(
		.OD		(pad_33_od	),
		.ENO	(pad_33_eno	),
		.ENI	(pad_33_eni	),
		.DIN	(pad_33_din	),
		.PU1	(pad_33_pu1	),
		.PU2	(pad_33_pu2	),
		.DOUT	(pad_33_dout	),
		.SPAD	(pad_33_spad	)
	);

	IDIO idio_pad_34(
		.OD		(pad_34_od	),
		.ENO	(pad_34_eno	),
		.ENI	(pad_34_eni	),
		.DIN	(pad_34_din	),
		.PU1	(pad_34_pu1	),
		.PU2	(pad_34_pu2	),
		.DOUT	(pad_34_dout	),
		.SPAD	(pad_34_spad	)
	);

//self-inst
    wire tck_i_din;
	ICLK pad_jtag_tck(
		.DIN	(tck_i_din),
		.DINP	(tck_i),
		.SPAD	(pad_jtag_tck_spad)
	);

    wire trstn_i_hv;
	IRSTB pad_jtag_rstn(
		.DIN	(trstn_i),
		.DIN_HV	(trstn_i_hv),
		.SPAD	(pad_jtag_rstn_spad)
	);

	IDIO pad_jtag_tms(
		.OD		(1'b0	),
		.ENO	(1'b0	),
		.ENI	(1'b1	),
		.DIN	(tms_i	),
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(1'b0	),//TBD
		.SPAD	(pad_jtag_tms_spad	)
	);

	IDIO pad_jtag_tdi(
		.OD		(1'b0	),
		.ENO	(1'b0	),
		.ENI	(1'b1	),
		.DIN	(tdi_i	),
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(1'b0	),//TBD
		.SPAD	(pad_jtag_tdi_spad	)
	);

	IDIO pad_jtag_tdo(
		.OD		(1'b0	),
		.ENO	(1'b1	),
		.ENI	(1'b0	),
		.DIN	(   	),//TBD
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(tdo_o	),
		.SPAD	(pad_jtag_tdo_spad	)
	);
//boot-sel
	IDIO pad_cms_0(
		.OD		(1'b0	),
		.ENO	(1'b0	),
		.ENI	(1'b1	),
		.DIN	(pad_cms_0_din),
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(1'b0	),//TBD
		.SPAD	(pad_cms_0_spad)
	);

	IDIO pad_boot_sel(
		.OD		(1'b0	),
		.ENO	(1'b0	),
		.ENI	(1'b1	),
		.DIN	(boot_sel_i),
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(1'b0	),//TBD
		.SPAD	(pad_boot_sel_spad)
	);

	IDIO pad_cms_1(
		.OD		(1'b0	),
		.ENO	(1'b0	),
		.ENI	(1'b1	),
		.DIN	(pad_cms_1_din),
		.PU1	(1'b0	),//TBD
		.PU2	(1'b0	),//TBD
		.DOUT	(1'b0	),//TBD
		.SPAD	(pad_cms_1_spad)
	);

	IDIO idio_pad_xtal0(
		.OD		(pad_xtal0_od	),
		.ENO	(pad_xtal0_eno	),
		.ENI	(pad_xtal0_eni	),
		.DIN	(pad_xtal0_din	),
		.PU1	(pad_xtal0_pu1	),
		.PU2	(pad_xtal0_pu2	),
		.DOUT	(pad_xtal0_dout	),
		.SPAD	(pad_xtal0_spad	)
	);

	IDIO idio_pad_xtal1(
		.OD		(pad_xtal1_od	),
		.ENO	(pad_xtal1_eno	),
		.ENI	(pad_xtal1_eni	),
		.DIN	(pad_xtal1_din	),
		.PU1	(pad_xtal1_pu1	),
		.PU2	(pad_xtal1_pu2	),
		.DOUT	(pad_xtal1_dout	),
		.SPAD	(pad_xtal1_spad	)
	);

    wire rst_async_key_n_hv;
	IRSTB pad_resetn(
		.DIN	(rst_async_key_n),
		.DIN_HV	(rst_async_key_n_hv),
		.SPAD	(pad_resetn_spad)
	);

endmodule
