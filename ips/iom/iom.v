module iom(
    output wire              o_spi_clk,//SPI Slave
    output wire              o_spi_cs,
    input  wire [1:0]        i_spi_mode,
    input  wire              i_spi_sdo0,
    input  wire              i_spi_sdo1,
    input  wire              i_spi_sdo2,
    input  wire              i_spi_sdo3,
    output wire              o_spi_sdi0,
    output wire              o_spi_sdi1,
    output wire              o_spi_sdi2,
    output wire              o_spi_sdi3,

    input  wire              i_spi_master_clk,//SPI Master
    input  wire              i_spi_master_csn0,
    input  wire              i_spi_master_csn1,
    input  wire              i_spi_master_csn2,
    input  wire              i_spi_master_csn3,
    input  wire [1:0]        i_spi_master_mode,
    input  wire              i_spi_master_sdo0,
    input  wire              i_spi_master_sdo1,
    input  wire              i_spi_master_sdo2,
    input  wire              i_spi_master_sdo3,
    output wire              o_spi_master_sdi0,
    output wire              o_spi_master_sdi1,
    output wire              o_spi_master_sdi2,
    output wire              o_spi_master_sdi3,

    output wire              o_scl_pad,//I2C
    input  wire              i_scl_pad_i,
    input  wire              i_scl_padoen,
    output wire              o_sda_pad,
    input  wire              i_sda_pad_i,
    input  wire              i_sda_padoen,

    input  wire              i_uart_tx,//uart0
    output wire              o_uart_rx,
    input  wire              i_uart1_tx,//uart1
    output wire              o_uart1_rx,
    input  wire              i_uart2_tx,//uart2
    output wire              o_uart2_rx,
    input  wire              i_uart3_tx,//uart3
    output wire              o_uart3_rx,
    input  wire              i_uart4_tx,//uart4
    output wire              o_uart4_rx,
    input  wire              i_uart5_tx,//uart5
    output wire              o_uart5_rx,

    input  wire [1:0]        i_iom_sel,   //io mux sel signal
    //for system reg signal
    input  wire              i_spi_clk_eni  ,      //from system reg
    input  wire              i_spi_clk_od   ,      //from system reg
    input  wire              i_spi_clk_pu1  ,      //from system reg
    input  wire              i_spi_clk_pu2  ,      //from system reg
    input  wire              i_spi_cs_eni   ,      //from system reg
    input  wire              i_spi_cs_od    ,      //from system reg
    input  wire              i_spi_cs_pu1   ,      //from system reg
    input  wire              i_spi_cs_pu2   ,      //from system reg
    input  wire [1:0]        i_spi_mode_eno ,      //from system reg
    input  wire [1:0]        i_spi_mode_od  ,      //from system reg
    input  wire [1:0]        i_spi_mode_pu1 ,      //from system reg
    input  wire [1:0]        i_spi_mode_pu2 ,      //from system reg
    input  wire              i_spi_sdo0_eno ,      //from system reg
    input  wire              i_spi_sdo0_od  ,      //from system reg
    input  wire              i_spi_sdo0_pu1 ,      //from system reg
    input  wire              i_spi_sdo0_pu2 ,      //from system reg
    input  wire              i_spi_sdo1_eno ,      //from system reg
    input  wire              i_spi_sdo1_od  ,      //from system reg
    input  wire              i_spi_sdo1_pu1 ,      //from system reg
    input  wire              i_spi_sdo1_pu2 ,      //from system reg
    input  wire              i_spi_sdo2_eno ,      //from system reg
    input  wire              i_spi_sdo2_od  ,      //from system reg
    input  wire              i_spi_sdo2_pu1 ,      //from system reg
    input  wire              i_spi_sdo2_pu2 ,      //from system reg
    input  wire              i_spi_sdo3_eno ,      //from system reg
    input  wire              i_spi_sdo3_od  ,      //from system reg
    input  wire              i_spi_sdo3_pu1 ,      //from system reg
    input  wire              i_spi_sdo3_pu2 ,      //from system reg
    input  wire              i_spi_sdi0_eni  ,      //from system reg
    input  wire              i_spi_sdi0_od   ,      //from system reg
    input  wire              i_spi_sdi0_pu1  ,      //from system reg
    input  wire              i_spi_sdi0_pu2  ,      //from system reg
    input  wire              i_spi_sdi1_eni  ,      //from system reg
    input  wire              i_spi_sdi1_od   ,      //from system reg
    input  wire              i_spi_sdi1_pu1  ,      //from system reg
    input  wire              i_spi_sdi1_pu2  ,      //from system reg
    input  wire              i_spi_sdi2_eni  ,      //from system reg
    input  wire              i_spi_sdi2_od   ,      //from system reg
    input  wire              i_spi_sdi2_pu1  ,      //from system reg
    input  wire              i_spi_sdi2_pu2  ,      //from system reg
    input  wire              i_spi_sdi3_eni  ,      //from system reg
    input  wire              i_spi_sdi3_od   ,      //from system reg
    input  wire              i_spi_sdi3_pu1  ,      //from system reg
    input  wire              i_spi_sdi3_pu2  ,      //from system reg
    input  wire              i_spi_master_clk_eno ,      //from system reg
    input  wire              i_spi_master_clk_od  ,      //from system reg
    input  wire              i_spi_master_clk_pu1 ,      //from system reg
    input  wire              i_spi_master_clk_pu2 ,      //from system reg
    input  wire              i_spi_master_csn0_eno ,      //from system reg
    input  wire              i_spi_master_csn0_od  ,      //from system reg
    input  wire              i_spi_master_csn0_pu1 ,      //from system reg
    input  wire              i_spi_master_csn0_pu2 ,      //from system reg
    input  wire              i_spi_master_csn1_eno ,      //from system reg
    input  wire              i_spi_master_csn1_od  ,      //from system reg
    input  wire              i_spi_master_csn1_pu1 ,      //from system reg
    input  wire              i_spi_master_csn1_pu2 ,      //from system reg
    input  wire              i_spi_master_csn2_eno ,      //from system reg
    input  wire              i_spi_master_csn2_od  ,      //from system reg
    input  wire              i_spi_master_csn2_pu1 ,      //from system reg
    input  wire              i_spi_master_csn2_pu2 ,      //from system reg
    input  wire              i_spi_master_csn3_eno ,      //from system reg
    input  wire              i_spi_master_csn3_od  ,      //from system reg
    input  wire              i_spi_master_csn3_pu1 ,      //from system reg
    input  wire              i_spi_master_csn3_pu2 ,      //from system reg
    input  wire [1:0]        i_spi_master_mode_eno ,      //from system reg
    input  wire [1:0]        i_spi_master_mode_od  ,      //from system reg
    input  wire [1:0]        i_spi_master_mode_pu1 ,      //from system reg
    input  wire [1:0]        i_spi_master_mode_pu2 ,      //from system reg
    input  wire              i_spi_master_sdo0_eno ,      //from system reg
    input  wire              i_spi_master_sdo0_od  ,      //from system reg
    input  wire              i_spi_master_sdo0_pu1 ,      //from system reg
    input  wire              i_spi_master_sdo0_pu2 ,      //from system reg
    input  wire              i_spi_master_sdo1_eno ,      //from system reg
    input  wire              i_spi_master_sdo1_od  ,      //from system reg
    input  wire              i_spi_master_sdo1_pu1 ,      //from system reg
    input  wire              i_spi_master_sdo1_pu2 ,      //from system reg
    input  wire              i_spi_master_sdo2_eno ,      //from system reg
    input  wire              i_spi_master_sdo2_od  ,      //from system reg
    input  wire              i_spi_master_sdo2_pu1 ,      //from system reg
    input  wire              i_spi_master_sdo2_pu2 ,      //from system reg
    input  wire              i_spi_master_sdo3_eno ,      //from system reg
    input  wire              i_spi_master_sdo3_od  ,      //from system reg
    input  wire              i_spi_master_sdo3_pu1 ,      //from system reg
    input  wire              i_spi_master_sdo3_pu2 ,      //from system reg
    input  wire              i_spi_master_sdi0_eni  ,      //from system reg
    input  wire              i_spi_master_sdi0_od   ,      //from system reg
    input  wire              i_spi_master_sdi0_pu1  ,      //from system reg
    input  wire              i_spi_master_sdi0_pu2  ,      //from system reg
    input  wire              i_spi_master_sdi1_eni  ,      //from system reg
    input  wire              i_spi_master_sdi1_od   ,      //from system reg
    input  wire              i_spi_master_sdi1_pu1  ,      //from system reg
    input  wire              i_spi_master_sdi1_pu2  ,      //from system reg
    input  wire              i_spi_master_sdi2_eni  ,      //from system reg
    input  wire              i_spi_master_sdi2_od   ,      //from system reg
    input  wire              i_spi_master_sdi2_pu1  ,      //from system reg
    input  wire              i_spi_master_sdi2_pu2  ,      //from system reg
    input  wire              i_spi_master_sdi3_eni  ,      //from system reg
    input  wire              i_spi_master_sdi3_od   ,      //from system reg
    input  wire              i_spi_master_sdi3_pu1  ,      //from system reg
    input  wire              i_spi_master_sdi3_pu2  ,      //from system reg
    input  wire              i_scl_pad_od   ,      //from system reg
    input  wire              i_scl_pad_pu1  ,      //from system reg
    input  wire              i_scl_pad_pu2  ,      //from system reg
    input  wire              i_sda_pad_od   ,      //from system reg
    input  wire              i_sda_pad_pu1  ,      //from system reg
    input  wire              i_sda_pad_pu2  ,      //from system reg
    input  wire              i_uart_tx_eno ,      //from system reg
    input  wire              i_uart_tx_od  ,      //from system reg
    input  wire              i_uart_tx_pu1 ,      //from system reg
    input  wire              i_uart_tx_pu2 ,      //from system reg
    input  wire              i_uart_rx_eni  ,      //from system reg
    input  wire              i_uart_rx_od   ,      //from system reg
    input  wire              i_uart_rx_pu1  ,      //from system reg
    input  wire              i_uart_rx_pu2  ,      //from system reg
    input  wire              i_uart1_tx_eno ,      //from system reg
    input  wire              i_uart1_tx_od  ,      //from system reg
    input  wire              i_uart1_tx_pu1 ,      //from system reg
    input  wire              i_uart1_tx_pu2 ,      //from system reg
    input  wire              i_uart1_rx_eni  ,      //from system reg
    input  wire              i_uart1_rx_od   ,      //from system reg
    input  wire              i_uart1_rx_pu1  ,      //from system reg
    input  wire              i_uart1_rx_pu2  ,      //from system reg
    input  wire              i_uart2_tx_eno ,      //from system reg
    input  wire              i_uart2_tx_od  ,      //from system reg
    input  wire              i_uart2_tx_pu1 ,      //from system reg
    input  wire              i_uart2_tx_pu2 ,      //from system reg
    input  wire              i_uart2_rx_eni  ,      //from system reg
    input  wire              i_uart2_rx_od   ,      //from system reg
    input  wire              i_uart2_rx_pu1  ,      //from system reg
    input  wire              i_uart2_rx_pu2  ,      //from system reg
    input  wire              i_uart3_tx_eno ,      //from system reg
    input  wire              i_uart3_tx_od  ,      //from system reg
    input  wire              i_uart3_tx_pu1 ,      //from system reg
    input  wire              i_uart3_tx_pu2 ,      //from system reg
    input  wire              i_uart3_rx_eni  ,      //from system reg
    input  wire              i_uart3_rx_od   ,      //from system reg
    input  wire              i_uart3_rx_pu1  ,      //from system reg
    input  wire              i_uart3_rx_pu2  ,      //from system reg
    input  wire              i_uart4_tx_eno ,      //from system reg
    input  wire              i_uart4_tx_od  ,      //from system reg
    input  wire              i_uart4_tx_pu1 ,      //from system reg
    input  wire              i_uart4_tx_pu2 ,      //from system reg
    input  wire              i_uart4_rx_eni  ,      //from system reg
    input  wire              i_uart4_rx_od   ,      //from system reg
    input  wire              i_uart4_rx_pu1  ,      //from system reg
    input  wire              i_uart4_rx_pu2  ,      //from system reg
    input  wire              i_uart5_tx_eno ,      //from system reg
    input  wire              i_uart5_tx_od  ,      //from system reg
    input  wire              i_uart5_tx_pu1 ,      //from system reg
    input  wire              i_uart5_tx_pu2 ,      //from system reg
    input  wire              i_uart5_rx_eni  ,      //from system reg
    input  wire              i_uart5_rx_od   ,      //from system reg
    input  wire              i_uart5_rx_pu1  ,      //from system reg
    input  wire              i_uart5_rx_pu2  ,      //from system reg
    //for gpio signal
    input  wire [31:0]       i_gpio,
    input  wire [31:0]       i_gpio_dir,  //0 for out input to chip; 1 for output 
    output wire [31:0]       o_gpio,
    //for chip pad signal
    inout  wire              pad_spi_clk,
    inout  wire              pad_spi_cs ,
    inout  wire              pad_spi_mode0,
    inout  wire              pad_spi_mode1,
    inout  wire              pad_spi_sdo0,
    inout  wire              pad_spi_sdo1,
    inout  wire              pad_spi_sdo2,
    inout  wire              pad_spi_sdo3,
    inout  wire              pad_spi_sdi0,
    inout  wire              pad_spi_sdi1,
    inout  wire              pad_spi_sdi2,
    inout  wire              pad_spi_sdi3,
    inout  wire              pad_spi_master_clk,
    inout  wire              pad_spi_master_csn0,
    inout  wire              pad_spi_master_csn1,
    inout  wire              pad_spi_master_csn2,
    inout  wire              pad_spi_master_csn3,
    inout  wire              pad_spi_master_mode0,
    inout  wire              pad_spi_master_mode1,
    inout  wire              pad_spi_master_sdo0,
    inout  wire              pad_spi_master_sdo1,
    inout  wire              pad_spi_master_sdo2,
    inout  wire              pad_spi_master_sdo3,
    inout  wire              pad_spi_master_sdi0,
    inout  wire              pad_spi_master_sdi1,
    inout  wire              pad_spi_master_sdi2,
    inout  wire              pad_spi_master_sdi3,
    inout  wire              pad_scl_pad,
    inout  wire              pad_sda_pad,
    inout  wire              pad_uart_tx,
    inout  wire              pad_uart_rx,
    inout  wire              pad_uart1_tx,
    inout  wire              pad_uart1_rx,
    inout  wire              pad_uart2_tx,
    inout  wire              pad_uart2_rx,
    inout  wire              pad_uart3_tx,
    inout  wire              pad_uart3_rx,
    inout  wire              pad_uart4_tx,
    inout  wire              pad_uart4_rx,
    inout  wire              pad_uart5_tx,
    inout  wire              pad_uart5_rx,

    inout  wire              VCC,
    inout  wire              VDD,
    inout  wire              GND
    );
  //--------------------------------------------------------------------------// 
  // Internal Parameters
  //--------------------------------------------------------------------------//
   localparam GPIO_OD = 1'b0;
 
   localparam GPIO_PU1 = 1'b1;

   localparam GPIO_PU2 = 1'b0;

   localparam DFLT_ENO = 1'b0;

   localparam DFLT_DOUT = 1'b0;

   localparam DFLT_ENI = 1'b0;

    wire   spi_clk_padeno_mux;
    wire   spi_clk_paddout_mux;
    wire   spi_clk_padeni_mux;
    wire   spi_clk_paddin_mux;
    wire   spi_clk_padod_mux;
    wire   spi_clk_padpu1_mux;
    wire   spi_clk_padpu2_mux;

    wire   spi_cs_padeno_mux;
    wire   spi_cs_paddout_mux;
    wire   spi_cs_padeni_mux;
    wire   spi_cs_paddin_mux;
    wire   spi_cs_padod_mux;
    wire   spi_cs_padpu1_mux;
    wire   spi_cs_padpu2_mux;

    wire   spi_mode0_padeno_mux;
    wire   spi_mode0_paddout_mux;
    wire   spi_mode0_padeni_mux;
    wire   spi_mode0_paddin_mux;
    wire   spi_mode0_padod_mux;
    wire   spi_mode0_padpu1_mux;
    wire   spi_mode0_padpu2_mux;

    wire   spi_mode1_padeno_mux;
    wire   spi_mode1_paddout_mux;
    wire   spi_mode1_padeni_mux;
    wire   spi_mode1_paddin_mux;
    wire   spi_mode1_padod_mux;
    wire   spi_mode1_padpu1_mux;
    wire   spi_mode1_padpu2_mux;

    wire   spi_sdo0_padeno_mux;
    wire   spi_sdo0_paddout_mux;
    wire   spi_sdo0_padeni_mux;
    wire   spi_sdo0_paddin_mux;
    wire   spi_sdo0_padod_mux;
    wire   spi_sdo0_padpu1_mux;
    wire   spi_sdo0_padpu2_mux;    

    wire   spi_sdo1_padeno_mux;
    wire   spi_sdo1_paddout_mux;
    wire   spi_sdo1_padeni_mux;
    wire   spi_sdo1_paddin_mux;
    wire   spi_sdo1_padod_mux;
    wire   spi_sdo1_padpu1_mux;
    wire   spi_sdo1_padpu2_mux; 

    wire   spi_sdo2_padeno_mux;
    wire   spi_sdo2_paddout_mux;
    wire   spi_sdo2_padeni_mux;
    wire   spi_sdo2_paddin_mux;
    wire   spi_sdo2_padod_mux;
    wire   spi_sdo2_padpu1_mux;
    wire   spi_sdo2_padpu2_mux;    

    wire   spi_sdo3_padeno_mux;
    wire   spi_sdo3_paddout_mux;
    wire   spi_sdo3_padeni_mux;
    wire   spi_sdo3_paddin_mux;
    wire   spi_sdo3_padod_mux;
    wire   spi_sdo3_padpu1_mux;
    wire   spi_sdo3_padpu2_mux; 

    wire   spi_sdi0_padeno_mux;
    wire   spi_sdi0_paddout_mux;
    wire   spi_sdi0_padeni_mux;
    wire   spi_sdi0_paddin_mux;
    wire   spi_sdi0_padod_mux;
    wire   spi_sdi0_padpu1_mux;
    wire   spi_sdi0_padpu2_mux;    

    wire   spi_sdi1_padeno_mux;
    wire   spi_sdi1_paddout_mux;
    wire   spi_sdi1_padeni_mux;
    wire   spi_sdi1_paddin_mux;
    wire   spi_sdi1_padod_mux;
    wire   spi_sdi1_padpu1_mux;
    wire   spi_sdi1_padpu2_mux; 

    wire   spi_sdi2_padeno_mux;
    wire   spi_sdi2_paddout_mux;
    wire   spi_sdi2_padeni_mux;
    wire   spi_sdi2_paddin_mux;
    wire   spi_sdi2_padod_mux;
    wire   spi_sdi2_padpu1_mux;
    wire   spi_sdi2_padpu2_mux;    

    wire   spi_sdi3_padeno_mux;
    wire   spi_sdi3_paddout_mux;
    wire   spi_sdi3_padeni_mux;
    wire   spi_sdi3_paddin_mux;
    wire   spi_sdi3_padod_mux;
    wire   spi_sdi3_padpu1_mux;
    wire   spi_sdi3_padpu2_mux; 

    wire   spi_master_clk_padeno_mux;
    wire   spi_master_clk_paddout_mux;
    wire   spi_master_clk_padeni_mux;
    wire   spi_master_clk_paddin_mux;
    wire   spi_master_clk_padod_mux;
    wire   spi_master_clk_padpu1_mux;
    wire   spi_master_clk_padpu2_mux;

    wire   spi_master_csn0_padeno_mux;
    wire   spi_master_csn0_paddout_mux;
    wire   spi_master_csn0_padeni_mux;
    wire   spi_master_csn0_paddin_mux;
    wire   spi_master_csn0_padod_mux;
    wire   spi_master_csn0_padpu1_mux;
    wire   spi_master_csn0_padpu2_mux;

    wire   spi_master_csn1_padeno_mux;
    wire   spi_master_csn1_paddout_mux;
    wire   spi_master_csn1_padeni_mux;
    wire   spi_master_csn1_paddin_mux;
    wire   spi_master_csn1_padod_mux;
    wire   spi_master_csn1_padpu1_mux;
    wire   spi_master_csn1_padpu2_mux;

    wire   spi_master_csn2_padeno_mux;
    wire   spi_master_csn2_paddout_mux;
    wire   spi_master_csn2_padeni_mux;
    wire   spi_master_csn2_paddin_mux;
    wire   spi_master_csn2_padod_mux;
    wire   spi_master_csn2_padpu1_mux;
    wire   spi_master_csn2_padpu2_mux;

    wire   spi_master_csn3_padeno_mux;
    wire   spi_master_csn3_paddout_mux;
    wire   spi_master_csn3_padeni_mux;
    wire   spi_master_csn3_paddin_mux;
    wire   spi_master_csn3_padod_mux;
    wire   spi_master_csn3_padpu1_mux;
    wire   spi_master_csn3_padpu2_mux;

    wire   spi_master_mode0_padeno_mux;
    wire   spi_master_mode0_paddout_mux;
    wire   spi_master_mode0_padeni_mux;
    wire   spi_master_mode0_paddin_mux;
    wire   spi_master_mode0_padod_mux;
    wire   spi_master_mode0_padpu1_mux;
    wire   spi_master_mode0_padpu2_mux;

    wire   spi_master_mode1_padeno_mux;
    wire   spi_master_mode1_paddout_mux;
    wire   spi_master_mode1_padeni_mux;
    wire   spi_master_mode1_paddin_mux;
    wire   spi_master_mode1_padod_mux;
    wire   spi_master_mode1_padpu1_mux;
    wire   spi_master_mode1_padpu2_mux;

    wire   spi_master_sdo0_padeno_mux;
    wire   spi_master_sdo0_paddout_mux;
    wire   spi_master_sdo0_padeni_mux;
    wire   spi_master_sdo0_paddin_mux;
    wire   spi_master_sdo0_padod_mux;
    wire   spi_master_sdo0_padpu1_mux;
    wire   spi_master_sdo0_padpu2_mux;    

    wire   spi_master_sdo1_padeno_mux;
    wire   spi_master_sdo1_paddout_mux;
    wire   spi_master_sdo1_padeni_mux;
    wire   spi_master_sdo1_paddin_mux;
    wire   spi_master_sdo1_padod_mux;
    wire   spi_master_sdo1_padpu1_mux;
    wire   spi_master_sdo1_padpu2_mux; 

    wire   spi_master_sdo2_padeno_mux;
    wire   spi_master_sdo2_paddout_mux;
    wire   spi_master_sdo2_padeni_mux;
    wire   spi_master_sdo2_paddin_mux;
    wire   spi_master_sdo2_padod_mux;
    wire   spi_master_sdo2_padpu1_mux;
    wire   spi_master_sdo2_padpu2_mux;    

    wire   spi_master_sdo3_padeno_mux;
    wire   spi_master_sdo3_paddout_mux;
    wire   spi_master_sdo3_padeni_mux;
    wire   spi_master_sdo3_paddin_mux;
    wire   spi_master_sdo3_padod_mux;
    wire   spi_master_sdo3_padpu1_mux;
    wire   spi_master_sdo3_padpu2_mux; 

    wire   spi_master_sdi0_padeno_mux;
    wire   spi_master_sdi0_paddout_mux;
    wire   spi_master_sdi0_padeni_mux;
    wire   spi_master_sdi0_paddin_mux;
    wire   spi_master_sdi0_padod_mux;
    wire   spi_master_sdi0_padpu1_mux;
    wire   spi_master_sdi0_padpu2_mux;    

    wire   spi_master_sdi1_padeno_mux;
    wire   spi_master_sdi1_paddout_mux;
    wire   spi_master_sdi1_padeni_mux;
    wire   spi_master_sdi1_paddin_mux;
    wire   spi_master_sdi1_padod_mux;
    wire   spi_master_sdi1_padpu1_mux;
    wire   spi_master_sdi1_padpu2_mux; 

    wire   spi_master_sdi2_padeno_mux;
    wire   spi_master_sdi2_paddout_mux;
    wire   spi_master_sdi2_padeni_mux;
    wire   spi_master_sdi2_paddin_mux;
    wire   spi_master_sdi2_padod_mux;
    wire   spi_master_sdi2_padpu1_mux;
    wire   spi_master_sdi2_padpu2_mux;    

    wire   spi_master_sdi3_padeno_mux;
    wire   spi_master_sdi3_paddout_mux;
    wire   spi_master_sdi3_padeni_mux;
    wire   spi_master_sdi3_paddin_mux;
    wire   spi_master_sdi3_padod_mux;
    wire   spi_master_sdi3_padpu1_mux;
    wire   spi_master_sdi3_padpu2_mux; 

    wire   scl_pad_padeno_mux;
    wire   scl_pad_paddout_mux;
    wire   scl_pad_padeni_mux;
    wire   scl_pad_paddin_mux;
    wire   scl_pad_padod_mux;
    wire   scl_pad_padpu1_mux;
    wire   scl_pad_padpu2_mux; 


    wire   sda_pad_padeno_mux;
    wire   sda_pad_paddout_mux;
    wire   sda_pad_padeni_mux;
    wire   sda_pad_paddin_mux;
    wire   sda_pad_padod_mux;
    wire   sda_pad_padpu1_mux;
    wire   sda_pad_padpu2_mux; 

    wire   uart_tx_padeno_mux;
    wire   uart_tx_paddout_mux;
    wire   uart_tx_padeni_mux;
    wire   uart_tx_paddin_mux;
    wire   uart_tx_padod_mux;
    wire   uart_tx_padpu1_mux;
    wire   uart_tx_padpu2_mux; 

    wire   uart_rx_padeno_mux;
    wire   uart_rx_paddout_mux;
    wire   uart_rx_padeni_mux;
    wire   uart_rx_paddin_mux;
    wire   uart_rx_padod_mux;
    wire   uart_rx_padpu1_mux;
    wire   uart_rx_padpu2_mux; 

    wire   uart1_tx_padeno_mux;
    wire   uart1_tx_paddout_mux;
    wire   uart1_tx_padeni_mux;
    wire   uart1_tx_paddin_mux;
    wire   uart1_tx_padod_mux;
    wire   uart1_tx_padpu1_mux;
    wire   uart1_tx_padpu2_mux; 

    wire   uart1_rx_padeno_mux;
    wire   uart1_rx_paddout_mux;
    wire   uart1_rx_padeni_mux;
    wire   uart1_rx_paddin_mux;
    wire   uart1_rx_padod_mux;
    wire   uart1_rx_padpu1_mux;
    wire   uart1_rx_padpu2_mux;

    wire   uart2_tx_padeno_mux;
    wire   uart2_tx_paddout_mux;
    wire   uart2_tx_padeni_mux;
    wire   uart2_tx_paddin_mux;
    wire   uart2_tx_padod_mux;
    wire   uart2_tx_padpu1_mux;
    wire   uart2_tx_padpu2_mux; 

    wire   uart2_rx_padeno_mux;
    wire   uart2_rx_paddout_mux;
    wire   uart2_rx_padeni_mux;
    wire   uart2_rx_paddin_mux;
    wire   uart2_rx_padod_mux;
    wire   uart2_rx_padpu1_mux;
    wire   uart2_rx_padpu2_mux;

    wire   uart3_tx_padeno_mux;
    wire   uart3_tx_paddout_mux;
    wire   uart3_tx_padeni_mux;
    wire   uart3_tx_paddin_mux;
    wire   uart3_tx_padod_mux;
    wire   uart3_tx_padpu1_mux;
    wire   uart3_tx_padpu2_mux; 

    wire   uart3_rx_padeno_mux;
    wire   uart3_rx_paddout_mux;
    wire   uart3_rx_padeni_mux;
    wire   uart3_rx_paddin_mux;
    wire   uart3_rx_padod_mux;
    wire   uart3_rx_padpu1_mux;
    wire   uart3_rx_padpu2_mux;

    wire   uart4_tx_padeno_mux;
    wire   uart4_tx_paddout_mux;
    wire   uart4_tx_padeni_mux;
    wire   uart4_tx_paddin_mux;
    wire   uart4_tx_padod_mux;
    wire   uart4_tx_padpu1_mux;
    wire   uart4_tx_padpu2_mux; 

    wire   uart4_rx_padeno_mux;
    wire   uart4_rx_paddout_mux;
    wire   uart4_rx_padeni_mux;
    wire   uart4_rx_paddin_mux;
    wire   uart4_rx_padod_mux;
    wire   uart4_rx_padpu1_mux;
    wire   uart4_rx_padpu2_mux;

    wire   uart5_tx_padeno_mux;
    wire   uart5_tx_paddout_mux;
    wire   uart5_tx_padeni_mux;
    wire   uart5_tx_paddin_mux;
    wire   uart5_tx_padod_mux;
    wire   uart5_tx_padpu1_mux;
    wire   uart5_tx_padpu2_mux; 

    wire   uart5_rx_padeno_mux;
    wire   uart5_rx_paddout_mux;
    wire   uart5_rx_padeni_mux;
    wire   uart5_rx_paddin_mux;
    wire   uart5_rx_padod_mux;
    wire   uart5_rx_padpu1_mux;
    wire   uart5_rx_padpu2_mux;

     assign  spi_clk_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[0];
     assign  spi_clk_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[0];
     assign  spi_clk_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_clk_eni : (~i_gpio_dir[0]);
     assign  o_spi_clk = (i_iom_sel == 2'h0) ? spi_clk_paddin_mux : 1'b0;
     assign  o_gpio[0] = (i_iom_sel == 2'h1) ? spi_clk_paddin_mux : 1'b0;
     assign  spi_clk_padod_mux = (i_iom_sel == 2'h0) ? i_spi_clk_od : GPIO_OD;
     assign  spi_clk_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_clk_pu1 : GPIO_PU1;
     assign  spi_clk_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_clk_pu2 : GPIO_PU2;

     assign  spi_cs_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[1];
     assign  spi_cs_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[1];
     assign  spi_cs_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_cs_eni : (~i_gpio_dir[1]);
     assign  o_spi_cs = (i_iom_sel == 2'h0) ? spi_cs_paddin_mux : 1'b0;
     assign  o_gpio[1] = (i_iom_sel == 2'h1) ? spi_cs_paddin_mux : 1'b0;
     assign  spi_cs_padod_mux = (i_iom_sel == 2'h0) ? i_spi_cs_od : GPIO_OD;
     assign  spi_cs_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_cs_pu1 : GPIO_PU1;
     assign  spi_cs_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_cs_pu2 : GPIO_PU2;

     assign  spi_mode0_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_mode_eno[0] : i_gpio_dir[2];
     assign  spi_mode0_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_mode[0] : i_gpio[2];
     assign  spi_mode0_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[2]);
     assign  o_gpio[2] = (i_iom_sel == 2'h1) ? spi_mode0_paddin_mux : 1'b0;
     assign  spi_mode0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_mode_od[0] : GPIO_OD;
     assign  spi_mode0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_mode_pu1[0] : GPIO_PU1;
     assign  spi_mode0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_mode_pu2[0] : GPIO_PU2;

     assign  spi_mode1_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_mode_eno[1] : i_gpio_dir[3];
     assign  spi_mode1_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_mode[1] : i_gpio[3];
     assign  spi_mode1_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[3]);
     assign  o_gpio[3] = (i_iom_sel == 2'h1) ? spi_mode1_paddin_mux : 1'b0;
     assign  spi_mode1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_mode_od[1] : GPIO_OD;
     assign  spi_mode1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_mode_pu1[1] : GPIO_PU1;
     assign  spi_mode1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_mode_pu2[1] : GPIO_PU2;

     assign  spi_sdo0_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_sdo0_eno : i_gpio_dir[4];
     assign  spi_sdo0_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_sdo0 : i_gpio[4];
     assign  spi_sdo0_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[4]);
     assign  o_gpio[4] = (i_iom_sel == 2'h1) ? spi_sdo0_paddin_mux : 1'b0;
     assign  spi_sdo0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdo0_od : GPIO_OD;
     assign  spi_sdo0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdo0_pu1 : GPIO_PU1;
     assign  spi_sdo0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdo0_pu2 : GPIO_PU2;

     assign  spi_sdo1_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_sdo1_eno : i_gpio_dir[5];
     assign  spi_sdo1_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_sdo1 : i_gpio[5];
     assign  spi_sdo1_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[5]);
     assign  o_gpio[5] = (i_iom_sel == 2'h1) ? spi_sdo1_paddin_mux : 1'b0;
     assign  spi_sdo1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdo1_od : GPIO_OD;
     assign  spi_sdo1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdo1_pu1 : GPIO_PU1;
     assign  spi_sdo1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdo1_pu2 : GPIO_PU2;     

     assign  spi_sdo2_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_sdo2_eno : i_gpio_dir[6];
     assign  spi_sdo2_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_sdo2 : i_gpio[6];
     assign  spi_sdo2_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[6]);
     assign  o_gpio[6] = (i_iom_sel == 2'h1) ? spi_sdo2_paddin_mux : 1'b0;
     assign  spi_sdo2_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdo2_od : GPIO_OD;
     assign  spi_sdo2_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdo2_pu1 : GPIO_PU1;
     assign  spi_sdo2_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdo2_pu2 : GPIO_PU2;

     assign  spi_sdo3_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_sdo3_eno : i_gpio_dir[7];
     assign  spi_sdo3_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_sdo3 : i_gpio[7];
     assign  spi_sdo3_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[7]);
     assign  o_gpio[7] = (i_iom_sel == 2'h1) ? spi_sdo3_paddin_mux : 1'b0;
     assign  spi_sdo3_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdo3_od : GPIO_OD;
     assign  spi_sdo3_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdo3_pu1 : GPIO_PU1;
     assign  spi_sdo3_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdo3_pu2 : GPIO_PU2;  

     assign  spi_sdi0_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[8];
     assign  spi_sdi0_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[8];
     assign  spi_sdi0_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_sdi0_eni : (~i_gpio_dir[8]);
     assign  o_spi_sdi0 = (i_iom_sel == 2'h0) ? spi_sdi0_paddin_mux : 1'b0;
     assign  o_gpio[8] = (i_iom_sel == 2'h1) ? spi_sdi0_paddin_mux : 1'b0;
     assign  spi_sdi0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdi0_od : GPIO_OD;
     assign  spi_sdi0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdi0_pu1 : GPIO_PU1;
     assign  spi_sdi0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdi0_pu2 : GPIO_PU2;

     assign  spi_sdi1_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[9];
     assign  spi_sdi1_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[9];
     assign  spi_sdi1_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_sdi1_eni : (~i_gpio_dir[9]);
     assign  o_spi_sdi1 = (i_iom_sel == 2'h0) ? spi_sdi1_paddin_mux : 1'b0;
     assign  o_gpio[9] = (i_iom_sel == 2'h1) ? spi_sdi1_paddin_mux : 1'b0;
     assign  spi_sdi1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdi1_od : GPIO_OD;
     assign  spi_sdi1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdi1_pu1 : GPIO_PU1;
     assign  spi_sdi1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdi1_pu2 : GPIO_PU2;

     assign  spi_sdi2_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[10];
     assign  spi_sdi2_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[10];
     assign  spi_sdi2_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_sdi2_eni : (~i_gpio_dir[10]);
     assign  o_spi_sdi2 = (i_iom_sel == 2'h0) ? spi_sdi2_paddin_mux : 1'b0;
     assign  o_gpio[10] = (i_iom_sel == 2'h1) ? spi_sdi2_paddin_mux : 1'b0;
     assign  spi_sdi2_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdi2_od : GPIO_OD;
     assign  spi_sdi2_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdi2_pu1 : GPIO_PU1;
     assign  spi_sdi2_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdi2_pu2 : GPIO_PU2;

     assign  spi_sdi3_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[11];
     assign  spi_sdi3_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[11];
     assign  spi_sdi3_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_sdi3_eni : (~i_gpio_dir[11]);
     assign  o_spi_sdi3 = (i_iom_sel == 2'h0) ? spi_sdi3_paddin_mux : 1'b0;
     assign  o_gpio[11] = (i_iom_sel == 2'h1) ? spi_sdi3_paddin_mux : 1'b0;
     assign  spi_sdi3_padod_mux = (i_iom_sel == 2'h0) ? i_spi_sdi3_od : GPIO_OD;
     assign  spi_sdi3_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_sdi3_pu1 : GPIO_PU1;
     assign  spi_sdi3_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_sdi3_pu2 : GPIO_PU2;

     assign  spi_master_clk_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_clk_eno : i_gpio_dir[12];
     assign  spi_master_clk_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_clk : i_gpio[12];
     assign  spi_master_clk_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[12]);
     assign  o_gpio[12] = (i_iom_sel == 2'h1) ? spi_master_clk_paddin_mux : 1'b0;
     assign  spi_master_clk_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_clk_od : GPIO_OD;
     assign  spi_master_clk_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_clk_pu1 : GPIO_PU1;
     assign  spi_master_clk_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_clk_pu2 : GPIO_PU2;

     assign  spi_master_csn0_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn0_eno : i_gpio_dir[13];
     assign  spi_master_csn0_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn0 : i_gpio[13];
     assign  spi_master_csn0_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[13]);
     assign  o_gpio[13] = (i_iom_sel == 2'h1) ? spi_master_csn0_paddin_mux : 1'b0;
     assign  spi_master_csn0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn0_od : GPIO_OD;
     assign  spi_master_csn0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn0_pu1 : GPIO_PU1;
     assign  spi_master_csn0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn0_pu2 : GPIO_PU2;

     assign  spi_master_csn1_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn1_eno : i_gpio_dir[14];
     assign  spi_master_csn1_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn1 : i_gpio[14];
     assign  spi_master_csn1_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[14]);
     assign  o_gpio[14] = (i_iom_sel == 2'h1) ? spi_master_csn1_paddin_mux : 1'b0;
     assign  spi_master_csn1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn1_od : GPIO_OD;
     assign  spi_master_csn1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn1_pu1 : GPIO_PU1;
     assign  spi_master_csn1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn1_pu2 : GPIO_PU2;

     assign  spi_master_csn2_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn2_eno : i_gpio_dir[15];
     assign  spi_master_csn2_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn2 : i_gpio[15];
     assign  spi_master_csn2_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[15]);
     assign  o_gpio[15] = (i_iom_sel == 2'h1) ? spi_master_csn2_paddin_mux : 1'b0;
     assign  spi_master_csn2_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn2_od : GPIO_OD;
     assign  spi_master_csn2_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn2_pu1 : GPIO_PU1;
     assign  spi_master_csn2_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn2_pu2 : GPIO_PU2;
     
     assign  spi_master_csn3_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn3_eno : i_gpio_dir[16];
     assign  spi_master_csn3_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn3 : i_gpio[16];
     assign  spi_master_csn3_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[16]);
     assign  o_gpio[16] = (i_iom_sel == 2'h1) ? spi_master_csn3_paddin_mux : 1'b0;
     assign  spi_master_csn3_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn3_od : GPIO_OD;
     assign  spi_master_csn3_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn3_pu1 : GPIO_PU1;
     assign  spi_master_csn3_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_csn3_pu2 : GPIO_PU2;

     assign  spi_master_mode0_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_eno[0] : i_gpio_dir[17];
     assign  spi_master_mode0_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode[0] : i_gpio[17];
     assign  spi_master_mode0_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[17]);
     assign  o_gpio[17] = (i_iom_sel == 2'h1) ? spi_master_mode0_paddin_mux : 1'b0;
     assign  spi_master_mode0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_od[0] : GPIO_OD;
     assign  spi_master_mode0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_pu1[0] : GPIO_PU1;
     assign  spi_master_mode0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_pu2[0] : GPIO_PU2;

     assign  spi_master_mode1_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_eno[1] : i_gpio_dir[18];
     assign  spi_master_mode1_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode[1] : i_gpio[18];
     assign  spi_master_mode1_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[18]);
     assign  o_gpio[18] = (i_iom_sel == 2'h1) ? spi_master_mode1_paddin_mux : 1'b0;
     assign  spi_master_mode1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_od[1] : GPIO_OD;
     assign  spi_master_mode1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_pu1[1] : GPIO_PU1;
     assign  spi_master_mode1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_mode_pu2[1] : GPIO_PU2;
    
     assign  spi_master_sdo0_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo0_eno : i_gpio_dir[19];
     assign  spi_master_sdo0_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo0 : i_gpio[19];
     assign  spi_master_sdo0_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[19]);
     assign  o_gpio[19] = (i_iom_sel == 2'h1) ? spi_master_sdo0_paddin_mux : 1'b0;
     assign  spi_master_sdo0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo0_od : GPIO_OD;
     assign  spi_master_sdo0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo0_pu1 : GPIO_PU1;
     assign  spi_master_sdo0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo0_pu2 : GPIO_PU2;

     assign  spi_master_sdo1_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo1_eno : i_gpio_dir[20];
     assign  spi_master_sdo1_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo1 : i_gpio[20];
     assign  spi_master_sdo1_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[20]);
     assign  o_gpio[20] = (i_iom_sel == 2'h1) ? spi_master_sdo1_paddin_mux : 1'b0;
     assign  spi_master_sdo1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo1_od : GPIO_OD;
     assign  spi_master_sdo1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo1_pu1 : GPIO_PU1;
     assign  spi_master_sdo1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo1_pu2 : GPIO_PU2;     

     assign  spi_master_sdo2_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo2_eno : i_gpio_dir[21];
     assign  spi_master_sdo2_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo2 : i_gpio[21];
     assign  spi_master_sdo2_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[21]);
     assign  o_gpio[21] = (i_iom_sel == 2'h1) ? spi_master_sdo2_paddin_mux : 1'b0;
     assign  spi_master_sdo2_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo2_od : GPIO_OD;
     assign  spi_master_sdo2_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo2_pu1 : GPIO_PU1;
     assign  spi_master_sdo2_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo2_pu2 : GPIO_PU2;

     assign  spi_master_sdo3_padeno_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo3_eno : i_gpio_dir[22];
     assign  spi_master_sdo3_paddout_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo3 : i_gpio[22];
     assign  spi_master_sdo3_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[22]);
     assign  o_gpio[22] = (i_iom_sel == 2'h1) ? spi_master_sdo3_paddin_mux : 1'b0;
     assign  spi_master_sdo3_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo3_od : GPIO_OD;
     assign  spi_master_sdo3_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo3_pu1 : GPIO_PU1;
     assign  spi_master_sdo3_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdo3_pu2 : GPIO_PU2;  

     assign  spi_master_sdi0_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[23];
     assign  spi_master_sdi0_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[23];
     assign  spi_master_sdi0_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi0_eni : (~i_gpio_dir[23]);
     assign  o_spi_master_sdi0 = (i_iom_sel == 2'h0) ? spi_master_sdi0_paddin_mux : 1'b0;
     assign  o_gpio[23] = (i_iom_sel == 2'h1) ? spi_master_sdi0_paddin_mux : 1'b0;
     assign  spi_master_sdi0_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi0_od : GPIO_OD;
     assign  spi_master_sdi0_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi0_pu1 : GPIO_PU1;
     assign  spi_master_sdi0_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi0_pu2 : GPIO_PU2;

     assign  spi_master_sdi1_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[24];
     assign  spi_master_sdi1_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[24];
     assign  spi_master_sdi1_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi1_eni : (~i_gpio_dir[24]);
     assign  o_spi_master_sdi1 = (i_iom_sel == 2'h0) ? spi_master_sdi1_paddin_mux : 1'b0;
     assign  o_gpio[24] = (i_iom_sel == 2'h1) ? spi_master_sdi1_paddin_mux : 1'b0;
     assign  spi_master_sdi1_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi1_od : GPIO_OD;
     assign  spi_master_sdi1_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi1_pu1 : GPIO_PU1;
     assign  spi_master_sdi1_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi1_pu2 : GPIO_PU2;

     assign  spi_master_sdi2_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[25];
     assign  spi_master_sdi2_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[25];
     assign  spi_master_sdi2_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi2_eni : (~i_gpio_dir[25]);
     assign  o_spi_master_sdi2 = (i_iom_sel == 2'h0) ? spi_master_sdi2_paddin_mux : 1'b0;
     assign  o_gpio[25] = (i_iom_sel == 2'h1) ? spi_master_sdi2_paddin_mux : 1'b0;
     assign  spi_master_sdi2_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi2_od : GPIO_OD;
     assign  spi_master_sdi2_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi2_pu1 : GPIO_PU1;
     assign  spi_master_sdi2_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi2_pu2 : GPIO_PU2;

     assign  spi_master_sdi3_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[26];
     assign  spi_master_sdi3_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[26];
     assign  spi_master_sdi3_padeni_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi3_eni : (~i_gpio_dir[26]);
     assign  o_spi_master_sdi3 = (i_iom_sel == 2'h0) ? spi_master_sdi3_paddin_mux : 1'b0;
     assign  o_gpio[26] = (i_iom_sel == 2'h1) ? spi_master_sdi3_paddin_mux : 1'b0;
     assign  spi_master_sdi3_padod_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi3_od : GPIO_OD;
     assign  spi_master_sdi3_padpu1_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi3_pu1 : GPIO_PU1;
     assign  spi_master_sdi3_padpu2_mux = (i_iom_sel == 2'h0) ? i_spi_master_sdi3_pu2 : GPIO_PU2;

     assign  scl_pad_padeno_mux = (i_iom_sel == 2'h0) ? i_scl_padoen : i_gpio_dir[27];
     assign  scl_pad_paddout_mux = (i_iom_sel == 2'h0) ? i_scl_pad_i : i_gpio[27];
     assign  scl_pad_padeni_mux = (i_iom_sel == 2'h0) ? (~i_scl_padoen) : (~i_gpio_dir[27]);
     assign  o_scl_pad = (i_iom_sel == 2'h0) ? scl_pad_paddin_mux : 1'b0;
     assign  o_gpio[27] = (i_iom_sel == 2'h1) ? scl_pad_paddin_mux : 1'b0;
     assign  scl_pad_padod_mux = (i_iom_sel == 2'h0) ? i_scl_pad_od : GPIO_OD;
     assign  scl_pad_padpu1_mux = (i_iom_sel == 2'h0) ? i_scl_pad_pu1 : GPIO_PU1;
     assign  scl_pad_padpu2_mux = (i_iom_sel == 2'h0) ? i_scl_pad_pu2 : GPIO_PU2;


     assign  sda_pad_padeno_mux = (i_iom_sel == 2'h0) ? i_sda_padoen : i_gpio_dir[28];
     assign  sda_pad_paddout_mux = (i_iom_sel == 2'h0) ? i_sda_pad_i : i_gpio[28];
     assign  sda_pad_padeni_mux = (i_iom_sel == 2'h0) ? (~i_sda_padoen) : (~i_gpio_dir[28]);
     assign  o_sda_pad = (i_iom_sel == 2'h0) ? sda_pad_paddin_mux : 1'b0;
     assign  o_gpio[28] = (i_iom_sel == 2'h1) ? sda_pad_paddin_mux : 1'b0;
     assign  sda_pad_padod_mux = (i_iom_sel == 2'h0) ? i_sda_pad_od : GPIO_OD;
     assign  sda_pad_padpu1_mux = (i_iom_sel == 2'h0) ? i_sda_pad_pu1 : GPIO_PU1;
     assign  sda_pad_padpu2_mux = (i_iom_sel == 2'h0) ? i_sda_pad_pu2 : GPIO_PU2;

     assign  uart_tx_padeno_mux = (i_iom_sel == 2'h0) ? i_uart_tx_eno : i_gpio_dir[29];
     assign  uart_tx_paddout_mux = (i_iom_sel == 2'h0) ? i_uart_tx : i_gpio[29];
     assign  uart_tx_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[29]);
     assign  o_gpio[29] = (i_iom_sel == 2'h1) ? uart_tx_paddin_mux : 1'b0;
     assign  uart_tx_padod_mux = (i_iom_sel == 2'h0) ? i_uart_tx_od : GPIO_OD;
     assign  uart_tx_padpu1_mux = (i_iom_sel == 2'h0) ? i_uart_tx_pu1 : GPIO_PU1;
     assign  uart_tx_padpu2_mux = (i_iom_sel == 2'h0) ? i_uart_tx_pu2 : GPIO_PU2;  

     assign  uart_rx_padeno_mux = (i_iom_sel == 2'h0) ? DFLT_ENO : i_gpio_dir[30];
     assign  uart_rx_paddout_mux = (i_iom_sel == 2'h0) ? DFLT_DOUT : i_gpio[30];
     assign  uart_rx_padeni_mux = (i_iom_sel == 2'h0) ? i_uart_rx_eni : (~i_gpio_dir[30]);
     assign  o_uart_rx = (i_iom_sel == 2'h0) ? uart_rx_paddin_mux : 1'b0;
     assign  o_gpio[30] = (i_iom_sel == 2'h1) ? uart_rx_paddin_mux : 1'b0;
     assign  uart_rx_padod_mux = (i_iom_sel == 2'h0) ? i_uart_rx_od : GPIO_OD;
     assign  uart_rx_padpu1_mux = (i_iom_sel == 2'h0) ? i_uart_rx_pu1 : GPIO_PU1;
     assign  uart_rx_padpu2_mux = (i_iom_sel == 2'h0) ? i_uart_rx_pu2 : GPIO_PU2;

     assign  uart1_tx_padeno_mux = (i_iom_sel == 2'h0) ? i_uart1_tx_eno : i_gpio_dir[31];
     assign  uart1_tx_paddout_mux = (i_iom_sel == 2'h0) ? i_uart1_tx : i_gpio[31];
     assign  uart1_tx_padeni_mux = (i_iom_sel == 2'h0) ? DFLT_ENI : (~i_gpio_dir[31]);
     assign  o_gpio[31] = (i_iom_sel == 2'h1) ? uart1_tx_paddin_mux : 1'b0;
     assign  uart1_tx_padod_mux = (i_iom_sel == 2'h0) ? i_uart1_tx_od : GPIO_OD;
     assign  uart1_tx_padpu1_mux = (i_iom_sel == 2'h0) ? i_uart1_tx_pu1 : GPIO_PU1;
     assign  uart1_tx_padpu2_mux = (i_iom_sel == 2'h0) ? i_uart1_tx_pu2 : GPIO_PU2;  

     assign  uart1_rx_padeno_mux = DFLT_ENO;
     assign  uart1_rx_paddout_mux = DFLT_DOUT;
     assign  uart1_rx_padeni_mux = i_uart1_rx_eni;
     assign  o_uart1_rx = uart1_rx_paddin_mux;
     assign  uart1_rx_padod_mux = i_uart1_rx_od;
     assign  uart1_rx_padpu1_mux = i_uart1_rx_pu1;
     assign  uart1_rx_padpu2_mux = i_uart1_rx_pu2;

     assign  uart2_tx_padeno_mux = i_uart2_tx_eno;
     assign  uart2_tx_paddout_mux = i_uart2_tx;
     assign  uart2_tx_padeni_mux = DFLT_ENI;
     assign  uart2_tx_padod_mux = i_uart2_tx_od;
     assign  uart2_tx_padpu1_mux = i_uart2_tx_pu1;
     assign  uart2_tx_padpu2_mux = i_uart2_tx_pu2; 

     assign  uart2_rx_padeno_mux = DFLT_ENO;
     assign  uart2_rx_paddout_mux = DFLT_DOUT;
     assign  uart2_rx_padeni_mux = i_uart2_rx_eni;
     assign  o_uart2_rx = uart2_rx_paddin_mux;
     assign  uart2_rx_padod_mux = i_uart2_rx_od;
     assign  uart2_rx_padpu1_mux = i_uart2_rx_pu1;
     assign  uart2_rx_padpu2_mux = i_uart2_rx_pu2;

     assign  uart3_tx_padeno_mux = i_uart3_tx_eno;
     assign  uart3_tx_paddout_mux = i_uart3_tx;
     assign  uart3_tx_padeni_mux = DFLT_ENI;
     assign  uart3_tx_padod_mux = i_uart3_tx_od;
     assign  uart3_tx_padpu1_mux = i_uart3_tx_pu1;
     assign  uart3_tx_padpu2_mux = i_uart3_tx_pu2; 

     assign  uart3_rx_padeno_mux = DFLT_ENO;
     assign  uart3_rx_paddout_mux = DFLT_DOUT;
     assign  uart3_rx_padeni_mux = i_uart3_rx_eni;
     assign  o_uart3_rx = uart3_rx_paddin_mux;
     assign  uart3_rx_padod_mux = i_uart3_rx_od;
     assign  uart3_rx_padpu1_mux = i_uart3_rx_pu1;
     assign  uart3_rx_padpu2_mux = i_uart3_rx_pu2;

     assign  uart4_tx_padeno_mux = i_uart4_tx_eno;
     assign  uart4_tx_paddout_mux = i_uart4_tx;
     assign  uart4_tx_padeni_mux = DFLT_ENI;
     assign  uart4_tx_padod_mux = i_uart4_tx_od;
     assign  uart4_tx_padpu1_mux = i_uart4_tx_pu1;
     assign  uart4_tx_padpu2_mux = i_uart4_tx_pu2; 

     assign  uart4_rx_padeno_mux = DFLT_ENO;
     assign  uart4_rx_paddout_mux = DFLT_DOUT;
     assign  uart4_rx_padeni_mux = i_uart4_rx_eni;
     assign  o_uart4_rx = uart4_rx_paddin_mux;
     assign  uart4_rx_padod_mux = i_uart4_rx_od;
     assign  uart4_rx_padpu1_mux = i_uart4_rx_pu1;
     assign  uart4_rx_padpu2_mux = i_uart4_rx_pu2;

     assign  uart5_tx_padeno_mux = i_uart5_tx_eno;
     assign  uart5_tx_paddout_mux = i_uart5_tx;
     assign  uart5_tx_padeni_mux = DFLT_ENI;
     assign  uart5_tx_padod_mux = i_uart5_tx_od;
     assign  uart5_tx_padpu1_mux = i_uart5_tx_pu1;
     assign  uart5_tx_padpu2_mux = i_uart5_tx_pu2; 

     assign  uart5_rx_padeno_mux = DFLT_ENO;
     assign  uart5_rx_paddout_mux = DFLT_DOUT;
     assign  uart5_rx_padeni_mux = i_uart5_rx_eni;
     assign  o_uart5_rx = uart5_rx_paddin_mux;
     assign  uart5_rx_padod_mux = i_uart5_rx_od;
     assign  uart5_rx_padpu1_mux = i_uart5_rx_pu1;
     assign  uart5_rx_padpu2_mux = i_uart5_rx_pu2;

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_clk   (
             .ENO(spi_clk_padoen_mux )        ,
             .DOUT(spi_clk_paddout_mux )      ,
             .ENI(spi_clk_padeni_mux )        ,
             .DIN(spi_clk_paddin_mux  )       ,
             .OD(spi_clk_padod_mux)           ,
             .PU1(spi_clk_padpu1_mux)         ,
             .PU2(spi_clk_padpu2_mux)         ,
             .SPAD(pad_spi_clk  )             ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_cs   (
             .ENO(spi_cs_padoen_mux )         ,
             .DOUT(spi_cs_paddout_mux )       ,
             .ENI(spi_cs_padeni_mux )         ,
             .DIN(spi_cs_paddin_mux  )        ,
             .OD(spi_cs_padod_mux)            ,
             .PU1(spi_cs_padpu1_mux)          ,
             .PU2(spi_cs_padpu2_mux)          ,
             .SPAD(pad_spi_cs  )              ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_mode0   (
             .ENO(spi_mode0_padoen_mux )      ,
             .DOUT(spi_mode0_paddout_mux )    ,
             .ENI(spi_mode0_padeni_mux )      ,
             .DIN(spi_mode0_paddin_mux  )     ,
             .OD(spi_mode0_padod_mux)         ,
             .PU1(spi_mode0_padpu1_mux)       ,
             .PU2(spi_mode0_padpu2_mux)       ,
             .SPAD(pad_spi_mode0  )           ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_mode1   (
             .ENO(spi_mode1_padoen_mux )      ,
             .DOUT(spi_mode1_paddout_mux )    ,
             .ENI(spi_mode1_padeni_mux )      ,
             .DIN(spi_mode1_paddin_mux  )     ,
             .OD(spi_mode1_padod_mux)         ,
             .PU1(spi_mode1_padpu1_mux)       ,
             .PU2(spi_mode1_padpu2_mux)       ,
             .SPAD(pad_spi_mode1  )           ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdo0   (
             .ENO(spi_sdo0_padoen_mux )       ,
             .DOUT(spi_sdo0_paddout_mux )     ,
             .ENI(spi_sdo0_padeni_mux )       ,
             .DIN(spi_sdo0_paddin_mux  )      ,
             .OD(spi_sdo0_padod_mux)          ,
             .PU1(spi_sdo0_padpu1_mux)        ,
             .PU2(spi_sdo0_padpu2_mux)        ,
             .SPAD(pad_spi_sdo0  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdo1   (
             .ENO(spi_sdo1_padoen_mux )       ,
             .DOUT(spi_sdo1_paddout_mux )     ,
             .ENI(spi_sdo1_padeni_mux )       ,
             .DIN(spi_sdo1_paddin_mux  )      ,
             .OD(spi_sdo1_padod_mux)          ,
             .PU1(spi_sdo1_padpu1_mux)        ,
             .PU2(spi_sdo1_padpu2_mux)        ,
             .SPAD(pad_spi_sdo1  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdo2   (
             .ENO(spi_sdo2_padoen_mux )       ,
             .DOUT(spi_sdo2_paddout_mux )     ,
             .ENI(spi_sdo2_padeni_mux )       ,
             .DIN(spi_sdo2_paddin_mux  )      ,
             .OD(spi_sdo2_padod_mux)          ,
             .PU1(spi_sdo2_padpu1_mux)        ,
             .PU2(spi_sdo2_padpu2_mux)        ,
             .SPAD(pad_spi_sdo2  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdo3   (
             .ENO(spi_sdo3_padoen_mux )       ,
             .DOUT(spi_sdo3_paddout_mux )     ,
             .ENI(spi_sdo3_padeni_mux )       ,
             .DIN(spi_sdo3_paddin_mux  )      ,
             .OD(spi_sdo3_padod_mux)          ,
             .PU1(spi_sdo3_padpu1_mux)        ,
             .PU2(spi_sdo3_padpu2_mux)        ,
             .SPAD(pad_spi_sdo3  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdi0   (
             .ENO(spi_sdi0_padoen_mux )       ,
             .DOUT(spi_sdi0_paddout_mux )     ,
             .ENI(spi_sdi0_padeni_mux )       ,
             .DIN(spi_sdi0_paddin_mux  )      ,
             .OD(spi_sdi0_padod_mux)          ,
             .PU1(spi_sdi0_padpu1_mux)        ,
             .PU2(spi_sdi0_padpu2_mux)        ,
             .SPAD(pad_spi_sdi0  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdi1   (
             .ENO(spi_sdi1_padoen_mux )       ,
             .DOUT(spi_sdi1_paddout_mux )     ,
             .ENI(spi_sdi1_padeni_mux )       ,
             .DIN(spi_sdi1_paddin_mux  )      ,
             .OD(spi_sdi1_padod_mux)          ,
             .PU1(spi_sdi1_padpu1_mux)        ,
             .PU2(spi_sdi1_padpu2_mux)        ,
             .SPAD(pad_spi_sdi1  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdi2   (
             .ENO(spi_sdi2_padoen_mux )       ,
             .DOUT(spi_sdi2_paddout_mux )     ,
             .ENI(spi_sdi2_padeni_mux )       ,
             .DIN(spi_sdi2_paddin_mux  )      ,
             .OD(spi_sdi2_padod_mux)          ,
             .PU1(spi_sdi2_padpu1_mux)        ,
             .PU2(spi_sdi2_padpu2_mux)        ,
             .SPAD(pad_spi_sdi2  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_sdi3   (
             .ENO(spi_sdi3_padoen_mux )       ,
             .DOUT(spi_sdi3_paddout_mux )     ,
             .ENI(spi_sdi3_padeni_mux )       ,
             .DIN(spi_sdi3_paddin_mux  )      ,
             .OD(spi_sdi3_padod_mux)          ,
             .PU1(spi_sdi3_padpu1_mux)        ,
             .PU2(spi_sdi3_padpu2_mux)        ,
             .SPAD(pad_spi_sdi3  )            ,
             .VCC(VCC)                        ,
             .VDD(VDD)                        ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_clk   (
             .ENO(spi_master_clk_padoen_mux )        ,
             .DOUT(spi_master_clk_paddout_mux )      ,
             .ENI(spi_master_clk_padeni_mux )        ,
             .DIN(spi_master_clk_paddin_mux  )       ,
             .OD(spi_master_clk_padod_mux)           ,
             .PU1(spi_master_clk_padpu1_mux)         ,
             .PU2(spi_master_clk_padpu2_mux)         ,
             .SPAD(pad_spi_master_clk  )             ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_csn0   (
             .ENO(spi_master_csn0_padoen_mux )        ,
             .DOUT(spi_master_csn0_paddout_mux )      ,
             .ENI(spi_master_csn0_padeni_mux )        ,
             .DIN(spi_master_csn0_paddin_mux  )       ,
             .OD(spi_master_csn0_padod_mux)           ,
             .PU1(spi_master_csn0_padpu1_mux)         ,
             .PU2(spi_master_csn0_padpu2_mux)         ,
             .SPAD(pad_spi_master_csn0  )             ,
             .VCC(VCC)                                ,
             .VDD(VDD)                                ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_csn1   (
             .ENO(spi_master_csn1_padoen_mux )        ,
             .DOUT(spi_master_csn1_paddout_mux )      ,
             .ENI(spi_master_csn1_padeni_mux )        ,
             .DIN(spi_master_csn1_paddin_mux  )       ,
             .OD(spi_master_csn1_padod_mux)           ,
             .PU1(spi_master_csn1_padpu1_mux)         ,
             .PU2(spi_master_csn1_padpu2_mux)         ,
             .SPAD(pad_spi_master_csn1  )             ,
             .VCC(VCC)                                ,
             .VDD(VDD)                                ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_csn2   (
             .ENO(spi_master_csn2_padoen_mux )        ,
             .DOUT(spi_master_csn2_paddout_mux )      ,
             .ENI(spi_master_csn2_padeni_mux )        ,
             .DIN(spi_master_csn2_paddin_mux  )       ,
             .OD(spi_master_csn2_padod_mux)           ,
             .PU1(spi_master_csn2_padpu1_mux)         ,
             .PU2(spi_master_csn2_padpu2_mux)         ,
             .SPAD(pad_spi_master_csn2  )             ,
             .VCC(VCC)                                ,
             .VDD(VDD)                                ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_csn3   (
             .ENO(spi_master_csn3_padoen_mux )        ,
             .DOUT(spi_master_csn3_paddout_mux )      ,
             .ENI(spi_master_csn3_padeni_mux )        ,
             .DIN(spi_master_csn3_paddin_mux  )       ,
             .OD(spi_master_csn3_padod_mux)           ,
             .PU1(spi_master_csn3_padpu1_mux)         ,
             .PU2(spi_master_csn3_padpu2_mux)         ,
             .SPAD(pad_spi_master_csn3  )             ,
             .VCC(VCC)                                ,
             .VDD(VDD)                                ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_mode0   (
             .ENO(spi_master_mode0_padoen_mux )        ,
             .DOUT(spi_master_mode0_paddout_mux )      ,
             .ENI(spi_master_mode0_padeni_mux )        ,
             .DIN(spi_master_mode0_paddin_mux  )       ,
             .OD(spi_master_mode0_padod_mux)           ,
             .PU1(spi_master_mode0_padpu1_mux)         ,
             .PU2(spi_master_mode0_padpu2_mux)         ,
             .SPAD(pad_spi_master_mode0  )             ,
             .VCC(VCC)                                 ,
             .VDD(VDD)                                 ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_mode1   (
             .ENO(spi_master_mode1_padoen_mux )        ,
             .DOUT(spi_master_mode1_paddout_mux )      ,
             .ENI(spi_master_mode1_padeni_mux )        ,
             .DIN(spi_master_mode1_paddin_mux  )       ,
             .OD(spi_master_mode1_padod_mux)           ,
             .PU1(spi_master_mode1_padpu1_mux)         ,
             .PU2(spi_master_mode1_padpu2_mux)         ,
             .SPAD(pad_spi_master_mode1  )             ,
             .VCC(VCC)                                 ,
             .VDD(VDD)                                 ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdo0   (
             .ENO(spi_master_sdo0_padoen_mux )       ,
             .DOUT(spi_master_sdo0_paddout_mux )     ,
             .ENI(spi_master_sdo0_padeni_mux )       ,
             .DIN(spi_master_sdo0_paddin_mux  )      ,
             .OD(spi_master_sdo0_padod_mux)          ,
             .PU1(spi_master_sdo0_padpu1_mux)        ,
             .PU2(spi_master_sdo0_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdo0  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdo1   (
             .ENO(spi_master_sdo1_padoen_mux )       ,
             .DOUT(spi_master_sdo1_paddout_mux )     ,
             .ENI(spi_master_sdo1_padeni_mux )       ,
             .DIN(spi_master_sdo1_paddin_mux  )      ,
             .OD(spi_master_sdo1_padod_mux)          ,
             .PU1(spi_master_sdo1_padpu1_mux)        ,
             .PU2(spi_master_sdo1_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdo1  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdo2   (
             .ENO(spi_master_sdo2_padoen_mux )       ,
             .DOUT(spi_master_sdo2_paddout_mux )     ,
             .ENI(spi_master_sdo2_padeni_mux )       ,
             .DIN(spi_master_sdo2_paddin_mux  )      ,
             .OD(spi_master_sdo2_padod_mux)          ,
             .PU1(spi_master_sdo2_padpu1_mux)        ,
             .PU2(spi_master_sdo2_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdo2  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdo3   (
             .ENO(spi_master_sdo3_padoen_mux )       ,
             .DOUT(spi_master_sdo3_paddout_mux )     ,
             .ENI(spi_master_sdo3_padeni_mux )       ,
             .DIN(spi_master_sdo3_paddin_mux  )      ,
             .OD(spi_master_sdo3_padod_mux)          ,
             .PU1(spi_master_sdo3_padpu1_mux)        ,
             .PU2(spi_master_sdo3_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdo3  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdi0   (
             .ENO(spi_master_sdi0_padoen_mux )       ,
             .DOUT(spi_master_sdi0_paddout_mux )     ,
             .ENI(spi_master_sdi0_padeni_mux )       ,
             .DIN(spi_master_sdi0_paddin_mux  )      ,
             .OD(spi_master_sdi0_padod_mux)          ,
             .PU1(spi_master_sdi0_padpu1_mux)        ,
             .PU2(spi_master_sdi0_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdi0  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdi1   (
             .ENO(spi_master_sdi1_padoen_mux )       ,
             .DOUT(spi_master_sdi1_paddout_mux )     ,
             .ENI(spi_master_sdi1_padeni_mux )       ,
             .DIN(spi_master_sdi1_paddin_mux  )      ,
             .OD(spi_master_sdi1_padod_mux)          ,
             .PU1(spi_master_sdi1_padpu1_mux)        ,
             .PU2(spi_master_sdi1_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdi1  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdi2   (
             .ENO(spi_master_sdi2_padoen_mux )       ,
             .DOUT(spi_master_sdi2_paddout_mux )     ,
             .ENI(spi_master_sdi2_padeni_mux )       ,
             .DIN(spi_master_sdi2_paddin_mux  )      ,
             .OD(spi_master_sdi2_padod_mux)          ,
             .PU1(spi_master_sdi2_padpu1_mux)        ,
             .PU2(spi_master_sdi2_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdi2  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_spi_master_sdi3   (
             .ENO(spi_master_sdi3_padoen_mux )       ,
             .DOUT(spi_master_sdi3_paddout_mux )     ,
             .ENI(spi_master_sdi3_padeni_mux )       ,
             .DIN(spi_master_sdi3_paddin_mux  )      ,
             .OD(spi_master_sdi3_padod_mux)          ,
             .PU1(spi_master_sdi3_padpu1_mux)        ,
             .PU2(spi_master_sdi3_padpu2_mux)        ,
             .SPAD(pad_spi_master_sdi3  )            ,
             .VCC(VCC)                               ,
             .VDD(VDD)                               ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_sda_pad   (
             .ENO(sda_pad_padeno_mux )       ,
             .DOUT(sda_pad_paddout_mux )     ,
             .ENI(sda_pad_padeni_mux )       ,
             .DIN(sda_pad_paddin_mux  )      ,
             .OD(sda_pad_padod_mux)          ,
             .PU1(sda_pad_padpu1_mux)        ,
             .PU2(sda_pad_padpu2_mux)        ,
             .SPAD(pad_sda_pad  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart_tx   (
             .ENO(uart_tx_padeno_mux )       ,
             .DOUT(uart_tx_paddout_mux )     ,
             .ENI(uart_tx_padeni_mux )       ,
             .DIN(uart_tx_paddin_mux  )      ,
             .OD(uart_tx_padod_mux)          ,
             .PU1(uart_tx_padpu1_mux)        ,
             .PU2(uart_tx_padpu2_mux)        ,
             .SPAD(pad_uart_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart_rx   (
             .ENO(uart_rx_padeno_mux )       ,
             .DOUT(uart_rx_paddout_mux )     ,
             .ENI(uart_rx_padeni_mux )       ,
             .DIN(uart_rx_paddin_mux  )      ,
             .OD(uart_rx_padod_mux)          ,
             .PU1(uart_rx_padpu1_mux)        ,
             .PU2(uart_rx_padpu2_mux)        ,
             .SPAD(pad_uart_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart1_tx   (
             .ENO(uart1_tx_padeno_mux )       ,
             .DOUT(uart1_tx_paddout_mux )     ,
             .ENI(uart1_tx_padeni_mux )       ,
             .DIN(uart1_tx_paddin_mux  )      ,
             .OD(uart1_tx_padod_mux)          ,
             .PU1(uart1_tx_padpu1_mux)        ,
             .PU2(uart1_tx_padpu2_mux)        ,
             .SPAD(pad_uart1_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart1_rx   (
             .ENO(uart1_rx_padeno_mux )       ,
             .DOUT(uart1_rx_paddout_mux )     ,
             .ENI(uart1_rx_padeni_mux )       ,
             .DIN(uart1_rx_paddin_mux  )      ,
             .OD(uart1_rx_padod_mux)          ,
             .PU1(uart1_rx_padpu1_mux)        ,
             .PU2(uart1_rx_padpu2_mux)        ,
             .SPAD(pad_uart1_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart2_tx   (
             .ENO(uart2_tx_padeno_mux )       ,
             .DOUT(uart2_tx_paddout_mux )     ,
             .ENI(uart2_tx_padeni_mux )       ,
             .DIN(uart2_tx_paddin_mux  )      ,
             .OD(uart2_tx_padod_mux)          ,
             .PU1(uart2_tx_padpu1_mux)        ,
             .PU2(uart2_tx_padpu2_mux)        ,
             .SPAD(pad_uart2_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart2_rx   (
             .ENO(uart2_rx_padeno_mux )       ,
             .DOUT(uart2_rx_paddout_mux )     ,
             .ENI(uart2_rx_padeni_mux )       ,
             .DIN(uart2_rx_paddin_mux  )      ,
             .OD(uart2_rx_padod_mux)          ,
             .PU1(uart2_rx_padpu1_mux)        ,
             .PU2(uart2_rx_padpu2_mux)        ,
             .SPAD(pad_uart2_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart3_tx   (
             .ENO(uart3_tx_padeno_mux )       ,
             .DOUT(uart3_tx_paddout_mux )     ,
             .ENI(uart3_tx_padeni_mux )       ,
             .DIN(uart3_tx_paddin_mux  )      ,
             .OD(uart3_tx_padod_mux)          ,
             .PU1(uart3_tx_padpu1_mux)        ,
             .PU2(uart3_tx_padpu2_mux)        ,
             .SPAD(pad_uart3_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart3_rx   (
             .ENO(uart3_rx_padeno_mux )       ,
             .DOUT(uart3_rx_paddout_mux )     ,
             .ENI(uart3_rx_padeni_mux )       ,
             .DIN(uart3_rx_paddin_mux  )      ,
             .OD(uart3_rx_padod_mux)          ,
             .PU1(uart3_rx_padpu1_mux)        ,
             .PU2(uart3_rx_padpu2_mux)        ,
             .SPAD(pad_uart3_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart4_tx   (
             .ENO(uart4_tx_padeno_mux )       ,
             .DOUT(uart4_tx_paddout_mux )     ,
             .ENI(uart4_tx_padeni_mux )       ,
             .DIN(uart4_tx_paddin_mux  )      ,
             .OD(uart4_tx_padod_mux)          ,
             .PU1(uart4_tx_padpu1_mux)        ,
             .PU2(uart4_tx_padpu2_mux)        ,
             .SPAD(pad_uart4_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart4_rx   (
             .ENO(uart4_rx_padeno_mux )       ,
             .DOUT(uart4_rx_paddout_mux )     ,
             .ENI(uart4_rx_padeni_mux )       ,
             .DIN(uart4_rx_paddin_mux  )      ,
             .OD(uart4_rx_padod_mux)          ,
             .PU1(uart4_rx_padpu1_mux)        ,
             .PU2(uart4_rx_padpu2_mux)        ,
             .SPAD(pad_uart4_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart5_tx   (
             .ENO(uart5_tx_padeno_mux )       ,
             .DOUT(uart5_tx_paddout_mux )     ,
             .ENI(uart5_tx_padeni_mux )       ,
             .DIN(uart5_tx_paddin_mux  )      ,
             .OD(uart5_tx_padod_mux)          ,
             .PU1(uart5_tx_padpu1_mux)        ,
             .PU2(uart5_tx_padpu2_mux)        ,
             .SPAD(pad_uart5_tx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

     IDIO_HJ110SIOPF50MVIHGSIM_A idio_pad_uart5_rx   (
             .ENO(uart5_rx_padeno_mux )       ,
             .DOUT(uart5_rx_paddout_mux )     ,
             .ENI(uart5_rx_padeni_mux )       ,
             .DIN(uart5_rx_paddin_mux  )      ,
             .OD(uart5_rx_padod_mux)          ,
             .PU1(uart5_rx_padpu1_mux)        ,
             .PU2(uart5_rx_padpu2_mux)        ,
             .SPAD(pad_uart5_rx  )            ,
             .VCC(VCC)                       ,
             .VDD(VDD)                       ,
             .GND(GND)
             );

endmodule
