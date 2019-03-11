
module pulpemu_top(  

  input         ext_tck_i,
  input         ext_trst_ni,
  input         ext_tdi_i,
  input         ext_tms_i,
  output        ext_tdo_o,
 
  input         ext_uart_rx,
  output        ext_uart_tx,
  
  input         ext_uart0_rx,
  output        ext_uart0_tx,
  
  
//  output        uart_tx ,
//  input         uart_rx ,
  
//  output        uart1_tx ,
//  input         uart1_rx ,
//  output        uart2_tx ,
//  input         uart2_rx ,
//  output        uart3_tx ,
//  input         uart3_rx ,
//  output        uart4_tx ,
//  input         uart4_rx ,
//  output        uart5_tx ,
//  input         uart5_rx ,
  
  
  
  input         ext_spi_mosi,
  output        ext_spi_miso,
  input         ext_spi_sck,
  input         ext_spi_cs,
  
  
  output        ext_m_spi_mosi,
  input         ext_m_spi_miso,  
  output        ext_m_spi_sck,
  output        ext_m_spi_cs,
  
  
  output        ext_m_spi1_mosi,
  input         ext_m_spi1_miso,
  output        ext_m_spi1_sck,
  output        ext_m_spi1_cs,
  
  
  inout         ext_scl,
  inout         ext_sda,
  
  inout         ext_scl1,
  inout         ext_sda1,
  
  output        ext_sda_pup,
  output        ext_scl_pup,
  
  output  [3:0] LD_o,
  
  input         ext_sw0,
  input         ext_sw1,
  input         ext_sw2,
  input         ext_sw3,
  
  output        led0_b,
  output        led0_g,
  output        led0_r,
  
  output        led1_b,
  output        led1_g,
  output        led1_r,

  output        led2_b,
  output        led2_g,
  output        led2_r,

  output        led3_b,
  output        led3_g,
  output        led3_r,
  
  input   [3:0] btn,
  
  
  
  input         ext_rstn_i,
  input         ext_clk_i
  
  
  
  );


wire [31:0] gpio_dir;                // output
wire [31:0] gpio_in = {btn[3:0],28'b0};                 // input
wire [31:0] gpio_out;                // output

wire        scl_oen;
wire        scl_in;
wire        scl_out;
wire        sda_oen;
wire        sda_in;
wire        sda_out;

wire        scl1_oen;
wire        scl1_in;
wire        scl1_out;
wire        sda1_oen;
wire        sda1_in;
wire        sda1_out;




wire      s_rstn_pulpino;


assign ext_scl = (~scl_oen) ? scl_out : 1'bz;
assign scl_in  = ext_scl;
assign ext_sda = (~sda_oen) ? sda_out : 1'bz;
assign sda_in  = ext_sda;

assign ext_scl1 = (~scl1_oen) ? scl1_out : 1'bz;
assign scl1_in  = ext_scl1;
assign ext_sda1 = (~sda1_oen) ? sda1_out : 1'bz;
assign sda1_in  = ext_sda1;


wire   fetch_en = ext_sw0 ;

wire   w_clk32M ;

reg  [31:0] clk_32k_cnt;
reg         clk_32k_int ;

wire   w_clk32K = clk_32k_int ;
 
parameter P_32K_Freq = 32768;
 
always@(posedge  ext_clk_i or negedge ext_rstn_i)
if(~ext_rstn_i)
 begin
    clk_32k_cnt <= 1 ;
    clk_32k_int  <= 0 ;
 end
else if(clk_32k_cnt == (100000000/P_32K_Freq)/2)
  begin
     clk_32k_cnt <= 1 ;
     clk_32k_int <= ~clk_32k_int ;
  end
else 
  begin
      clk_32k_cnt <= clk_32k_cnt + 1'b1 ;
   end 
   
   
reg  [31:0] clk_2m_cnt;
reg         clk_2m_int ;

wire   w_clk2M = clk_2m_int ;
 
parameter P_2M_Freq = 2000000;
 
always@(posedge  ext_clk_i or negedge ext_rstn_i)
if(~ext_rstn_i)
 begin
    clk_2m_cnt <= 1 ;
    clk_2m_int  <= 0 ;
 end
else if(clk_2m_cnt == (100000000/P_2M_Freq)/2)
  begin
     clk_2m_cnt <= 1 ;
     clk_2m_int <= ~clk_2m_int ;
  end
else 
  begin
      clk_2m_cnt <= clk_2m_cnt + 1'b1 ;
   end 


reg rst_async_por_n   ;
reg rst_async_key_n   ;

reg [7:0] rst_cnt ;

  
  
always@(posedge  ext_clk_i or negedge ext_rstn_i)
   if(~ext_rstn_i)
    begin
       rst_cnt <= 1 ;
    end
   else if(rst_cnt == 100)
     begin
        rst_cnt <= rst_cnt ;
     end
   else 
     begin
         rst_cnt <= rst_cnt + 1'b1 ;
      end   
    
always@(posedge  ext_clk_i or negedge ext_rstn_i)
   if(~ext_rstn_i)
    begin
       rst_async_por_n <= 0 ;
       rst_async_key_n <= 0 ;
    end
   else if(rst_cnt >10)
     begin
       rst_async_por_n <= 1 ;
       rst_async_key_n <= 1 ;
     end
          

xilinx_clock_manager u_xilinx_clock_manager 
 (
  .clk_o     (w_clk32M),
  
  .rst_ni    (ext_rstn_i),
  .rst_no    (s_rstn_pulpino),
  .clk100_i  (ext_clk_i)
 );


  // PULPino SoC
  pulpino_top  pulpino_top_i 
    (
      // Clock and Reset
      
      .clk               ( w_clk32M  ),
      .rst_n             ( s_rstn_pulpino ),
  
      .fetch_enable_i    ( fetch_en       ),
      
      .clk_sel_i         ( 1'b0           ),
      .clk_standalone_i  ( 1'b0           ),
      .testmode_i        ( 1'b0           ),
      .scan_enable_i     ( 1'b0           ),
  
      .boot_sel_0_i      (ext_sw1),
      .boot_sel_1_i      (ext_sw2),
      
      // JTAG signals
      
      .tck_i             ( ext_tck_i      ),
      .trstn_i           ( ext_trst_ni    ),
      .tms_i             ( ext_tms_i      ),
      .tdi_i             ( ext_tdi_i      ),
      .tdo_o             ( ext_tdo_o      ),
  
      //SPI Slave
      .spi_clk_i         ( 1'b0    ),//ext_spi_sck
      .spi_cs_i          ( 1'b1     ),//ext_spi_cs
      .spi_mode_o        (                ),
      .spi_sdi0_i        ( ext_spi_mosi   ),
      .spi_sdi1_i        ( 1'b0           ),
      .spi_sdi2_i        ( 1'b0           ),
      .spi_sdi3_i        ( 1'b0           ),
      .spi_sdo0_o        ( ext_spi_miso   ),
      .spi_sdo1_o        (                ),
      .spi_sdo2_o        (                ),
      .spi_sdo3_o        (                ),
  
      //SPI Master
      .spi_master_clk_o  ( ext_m_spi_sck  ),
      .spi_master_csn0_o ( ext_m_spi_cs   ),
      .spi_master_csn1_o (                ),
      .spi_master_csn2_o (                ),
      .spi_master_csn3_o (                ),
      .spi_master_mode_o (                ),
      .spi_master_sdi0_i ( ext_m_spi_miso ),
      .spi_master_sdi1_i ( 1'b0           ),
      .spi_master_sdi2_i ( 1'b0           ),
      .spi_master_sdi3_i ( 1'b0           ),
      .spi_master_sdo0_o ( ext_m_spi_mosi ),
      .spi_master_sdo1_o (                ),
      .spi_master_sdo2_o (                ),
      .spi_master_sdo3_o (                ),
      
      //I2C
      .scl_pad_i         ( scl_in         ),
      .scl_pad_o         ( scl_out        ),
      .scl_padoen_o      ( scl_oen        ),
      .sda_pad_i         ( sda_in         ),
      .sda_pad_o         ( sda_out        ),
      .sda_padoen_o      ( sda_oen        ),

      
      .uart_tx           ( ext_uart_tx    ), // outputext_uart_rx
      .uart_rx           ( ext_uart_rx    ), // input
      .uart_rts          (                ), // output
      .uart_dtr          (                ), // output
      .uart_cts          ( 1'b0           ), // input
      .uart_dsr          ( 1'b0           ),  // input
  
  
      .gpio_in           ( gpio_in        ),
      .gpio_out          ( gpio_out       ),
      .gpio_dir          ( gpio_dir       ),
  
  //clk_calib
      .clk_standard      (w_clk32M),
      .clk_calib_rc32m   (w_clk32M),
      .clk_calib_rc32k   (w_clk32K),
      .freq_sel_rc32m    (), //out
      .freq_sel_rc32k    (), //out
  
  //adc
      .regin0            (), //out
      .regin1            (), //out
      .adc_start         (), //out
      .adc_rstb          (), //out
      .adc_ckout         (w_clk2M), //in
      .adc_dout          (10'h3aa), //in10
  
  //scu
     .rst_async_por_n    (rst_async_por_n), //in
     .rst_async_key_n    (rst_async_key_n), //in
     .pvd_in             (1'b0), //in
     .pvd_sel            (), //out
     .pd_ldo15           (), //out
     .pd_v2i             (), //out
     .pd_pvd             (), //out
     .clk_rc32m          (w_clk32M), //in
     .clk_rc32k          (w_clk32K), //in
     .clk_32k            (w_clk32K), //in
     .rc32m_ready        (1'b1), //in
     .rc32k_ready        (1'b1), //in
     .rc32m_pd           (), //out
     .shortxixo          (), //out
     .en_xtal32k         (), //out
     .ext_en_xtal32k     (), //out
  
  //PERIPH_IP
  //uart
      .uart1_tx           ( uart1_tx    ), // output
      .uart1_rx           ( 1'b1    ), // input
      .uart1_rts          (                ), // output
      .uart1_dtr          (                ), // output
      .uart1_cts          ( 1'b0           ), // input
      .uart1_dsr          ( 1'b0           ),  // input
      
      .uart2_tx           ( uart2_tx    ), // output
      .uart2_rx           (  1'b1    ), // input
      .uart2_rts          (                ), // output
      .uart2_dtr          (                ), // output
      .uart2_cts          ( 1'b0           ), // input
      .uart2_dsr          ( 1'b0           ),  // input

      .uart3_tx           ( uart3_tx    ), // output
      .uart3_rx           (  1'b1    ), // input
      .uart3_rts          (                ), // output
      .uart3_dtr          (                ), // output
      .uart3_cts          ( 1'b0           ), // input
      .uart3_dsr          ( 1'b0           ),  // input

      .uart4_tx           ( uart4_tx    ), // output
      .uart4_rx           (  1'b1    ), // input
      .uart4_rts          (                ), // output
      .uart4_dtr          (                ), // output
      .uart4_cts          ( 1'b0           ), // input
      .uart4_dsr          ( 1'b0           ),  // input

      .uart5_tx           ( uart5_tx       ), // output
      .uart5_rx           (  1'b1       ), // input
      .uart5_rts          (                ), // output
      .uart5_dtr          (                ), // output
      .uart5_cts          ( 1'b0           ), // input
      .uart5_dsr          ( 1'b0           ),  // input

  
  //spi1
  //i2c1
      .spi1_master_clk_o  ( ext_m_spi1_sck  ),
      .spi1_master_csn0_o ( ext_m_spi1_cs   ),
      .spi1_master_csn1_o (                 ),
      .spi1_master_csn2_o (                 ),
      .spi1_master_csn3_o (                 ),
      .spi1_master_mode_o (                 ),
      .spi1_master_sdi0_i ( ext_m_spi1_miso ),
      .spi1_master_sdi1_i ( 1'b0            ),
      .spi1_master_sdi2_i ( 1'b0            ),
      .spi1_master_sdi3_i ( 1'b0            ),
      .spi1_master_sdo0_o ( ext_m_spi1_mosi ),
      .spi1_master_sdo1_o (                 ),
      .spi1_master_sdo2_o (                 ),
      .spi1_master_sdo3_o (                 ),
      
      //I2C
      .scl1_pad_i         ( scl1_in         ),
      .scl1_pad_o         ( scl1_out        ),
      .scl1_padoen_o      ( scl1_oen        ),
      .sda1_pad_i         ( sda1_in         ),
      .sda1_pad_o         ( sda1_out        ),
      .sda1_padoen_o      ( sda1_oen        ),
  
  
  //EFLASH_EN
     //eflash model signal
     .o_addr_eflsh        (), //out
     .o_addr_1_eflsh      (), //out
     .o_word_eflsh        (), //out
     .o_din_eflsh         (), //out
     .i_dout_eflsh        (32'd0), //in32
     .o_resetb_eflsh      (), //out
     .o_cs_eflsh          (), //out
     .o_ae_eflsh          (), //out
     .o_oe_eflsh          (), //out
     .o_ifren_eflsh       (), //out
     .o_nvstr_eflsh       (), //out
     .o_prog_eflsh        (), //out
     .o_sera_eflsh        (), //out
     .o_mase_eflsh        (), //out
     .i_tbit_eflsh        (1'b0), //in
     //test signal with pad, TBD, fpga_emu ignore
     .i_smten_pad         (1'b0), //in
     .i_sce_pad           (1'b0), //in
     .sclk_pad            (1'b0), //in
     .o_sio_oen_pad       (), //out
     .o_sio_pad           (), //out
     .i_sio_pad           (1'b0), //in
     //test signal, TBD   , fpga_emu ignore
     .o_smten_eflsh       (), //out
     .o_sce_eflsh         (), //out
     .sclk_eflsh          (), //out
     .i_sio_oen_eflsh     (1'b0), //in
     .i_sio_eflsh         (1'b0), //in
     .o_sio_eflsh         () //out
  
      // PULPino specific pad config
//      .pad_cfg_o          (), //out
//      .pad_mux_o          () //out
    );  
  
  
  
  
//  assign ext_uart_tx = ext_uart0_rx ;
//  assign ext_uart0_tx = ext_uart_rx ;
  
  
  assign led0_b      = gpio_out[0] ;
  assign led0_g      = gpio_out[1] ;
  assign led0_r      = gpio_out[2] ;
  
  
  assign led1_b      = gpio_out[3] ;
  assign led1_g      = gpio_out[4] ;
  assign led1_r      = gpio_out[5] ;


  assign led2_b      = gpio_out[6] ;
  assign led2_g      = gpio_out[7] ;
  assign led2_r      = gpio_out[8] ;

  assign led3_b      = gpio_out[9] ;
  assign led3_g      = gpio_out[10] ;
  assign led3_r      = gpio_out[11] ;
  
  assign LD_o[0]     = w_clk2M ;
  assign LD_o[1]     = w_clk32K ;
  assign LD_o[2]     = rst_async_por_n ;
  assign LD_o[3]     = rst_async_key_n ;




endmodule
