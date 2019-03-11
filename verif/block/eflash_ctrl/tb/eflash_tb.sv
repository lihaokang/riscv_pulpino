module eflash_tb(
        );
 
 
   reg aclk;
   reg rst_n;
   reg [31:0]  in_reg_vl;
   reg [31:0]  debug_data;
   supply1 VDD;
   supply0 VSS;


   initial begin
     force  debug_data = eflash_tb.u_PF64AK32EI40.FULLCHIP_STB.pf64ak32ei40_core.content[0];
      aclk <= 0;

      forever #15.625 aclk<=~aclk;      

    end

   
   // ---------------------------------------------------------------
   //AXI write address bus -------------- // USED// --------------
   wire [3:0]                                  slave_awid      ;   
   wire [31:0]                                 slave_awaddr    ; 
   wire [3:0]                                  slave_awlen     ;          
   wire [2:0]                                  slave_awsize    ;         
   wire [1:0]                                  slave_awburst   ;       
   wire [1:0]                                  slave_awlock    ;        
   wire [3:0]                                  slave_awcache   ;        
   wire [2:0]                                  slave_awprot    ; 
   wire [3:0]                                  slave_awregion  ;       
   wire                                        slave_awuser    ; 
   wire [3:0]                                  slave_awqos     ;  
   wire                                        slave_awvalid   ;        
   wire                                        slave_awready   ;        
   // ---------------------------------------------------------------

   //AXI write data bus -------------- // USED// --------------
   wire  [31:0]                                slave_wdata     ;
   wire  [3:0]                                 slave_wstrb     ;   
   wire                                        slave_wlast     ; 
   wire                                        slave_wuser     ;   
   wire                                        slave_wvalid    ;  
   wire                                        slave_wready    ;  
   // ---------------------------------------------------------------

   //AXI write response bus -------------- // USED// --------------
   wire    [3:0]                               slave_bid       ;
   wire    [1:0]                               slave_bresp     ;
   wire                                        slave_bvalid    ;
   wire                                        slave_buser     ;   
   wire                                        slave_bready    ;
   // ---------------------------------------------------------------



   //AXI read address bus -------------------------------------------
   wire [3:0]                                  slave_arid      ;
   wire [31:0]                                 slave_araddr    ;
   wire [ 3:0]                                 slave_arlen     ;   
   wire [ 2:0]                                 slave_arsize    ;  
   wire [ 1:0]                                 slave_arburst   ; 
   wire [1:0]                                  slave_arlock    ;  
   wire [ 3:0]                                 slave_arcache   ;
   wire [ 2:0]                                 slave_arprot    ;
   wire [ 3:0]                                 slave_arregion  ;       
   wire                                        slave_aruser    ;  
   wire [ 3:0]                                 slave_arqos     ;  
   reg                                         slave_arvalid   ; 
   wire                                        slave_arready   ; 
   // ---------------------------------------------------------------


   //AXI read data bus ----------------------------------------------
   wire  [3:0]                                 slave_rid     ;
   wire  [31:0]                                slave_rdata   ;
   wire [ 1:0]                                 slave_rresp   ;
   wire                                        slave_rlast   ;   
   wire                                        slave_ruser   ;   
   wire                                        slave_rvalid  ;  
   wire                                        slave_rready  ;  
   wire                                        test_fail;
   //eflash model signal
   wire [13:0]     o_addr_eflsh;
   wire            o_addr_1_eflsh;
   wire            o_word_eflsh;
   wire [31:0]     o_din_eflsh;
   wire [31:0]     i_dout_eflsh;
   wire            o_resetb_eflsh;
   wire            o_cs_eflsh;
   wire            o_ae_eflsh;
   wire            o_oe_eflsh;
   wire            o_ifren_eflsh;
   wire            o_nvstr_eflsh;
   wire            o_prog_eflsh;
   wire            o_sera_eflsh;
   wire            o_mase_eflsh;
   wire            i_tbit_eflsh;
   //test signal with pad
   wire            i_smten_pad;
   wire            i_sce_pad;
   wire            sclk_pad;
   wire            o_sio_oen_pad; 
   wire            o_sio_pad;
   wire            i_sio_pad;
   //test signal
   wire           o_smten_eflsh;
   wire           o_sce_eflsh;
   wire           sclk_eflsh;
   wire           i_sio_oen_eflsh; 
   wire           i_sio_eflsh;
   wire           o_sio_eflsh;

   assign slave_bid[3:2] = 2'h0;
  assign slave_rid[3:2] = 2'h0;
  assign i_smten_pad = 1'b0;
  assign i_sce_pad = 1'b0;
  assign sclk_pad = 1'b0;
  assign i_sio_pad = 1'b0;
  assign slave_awregion = 4'h0;
  assign slave_awuser = 1'b0;
  assign slave_awqos = 4'h0;
  assign slave_wuser = 1'b0;
  assign slave_arburst = 2'h0;
  assign slave_arregion = 4'h0;
  assign slave_aruser = 1'b0;
  assign slave_arqos = 4'h0;


  axi_master_bfm axi_master(/*AUTOINST*/
                         // Outputs
                         .awid                  (slave_awid[3:0]),
                         .awadr                 (slave_awaddr[31:0]),
                         .awlen                 (slave_awlen[3:0]),
                         .awsize                (slave_awsize[2:0]),
                         .awburst               (slave_awburst[1:0]),
                         .awlock                (slave_awlock[1:0]),
                         .awcache               (slave_awcache[3:0]),
                         .awprot                (slave_awprot[2:0]),
                         .awvalid               (slave_awvalid),
                         .wid                   (4'h0),
                         .wrdata                (slave_wdata[31:0]),
                         .wstrb                 (slave_wstrb[3:0]),
                         .wlast                 (slave_wlast),
                         .wvalid                (slave_wvalid),
                         .bid                   (slave_bid[3:0]),
                         .bresp                 (slave_bresp[1:0]),
                         .bvalid                (slave_bvalid),
                         .arid                  (slave_arid[3:0]),
                         .araddr                (slave_araddr[31:0]),
                         .arlen                 (slave_arlen[3:0]),
                         .arsize                (slave_arsize[2:0]),
                         .arlock                (slave_arlock[1:0]),
                         .arcache               (slave_arcache[3:0]),
                         .arprot                (slave_arprot[2:0]),
                         .arvalid               (slave_arvalid),
                         .rready                (slave_rready),
                         .test_fail             (test_fail),
                         // Inputs
                         .aclk                  (aclk),
                         .aresetn               (rst_n),
                         .awready               (slave_awready),
                         .wready                (slave_wready),
                         .bready                (slave_bready),
                         .arready               (slave_arready),
                         .rid                   (slave_rid[3:0]),
                         .rdata                 (slave_rdata[31:0]),
                         .rresp                 (slave_rresp[1:0]),
                         .rlast                 (slave_rlast),
                         .rvalid                (slave_rvalid));

      

eflash_ctrl u_eflash_ctrl(
   //system signal
   .clk              (aclk),
   .rst_n            (rst_n),         
   // ---------------------------------------------------------------
   //AXI write address bus -------------- // USED// --------------
  .i_slave_awid      (slave_awid[1:0]),   
  .i_slave_awaddr    (slave_awaddr), 
  .i_slave_awlen     ({4'h0,slave_awlen}),          
  .i_slave_awsize    (slave_awsize),         
  .i_slave_awburst   (slave_awburst),       
  .i_slave_awlock    (slave_awlock[0] ),        
  .i_slave_awcache   (slave_awcache),        
  .i_slave_awprot    (slave_awprot), 
  .i_slave_awregion  (slave_awregion),       
  .i_slave_awuser    (slave_awuser), 
  .i_slave_awqos     (slave_awqos),  
  .i_slave_awvalid   (slave_awvalid),        
  .o_slave_awready   (slave_awready),        
   // ---------------------------------------------------------------

   //AXI write data bus -------------- // USED// --------------
   .i_slave_wdata     (slave_wdata),
   .i_slave_wstrb     (slave_wstrb),   
   .i_slave_wlast     (slave_wlast), 
   .i_slave_wuser     (slave_wuser),   
   .i_slave_wvalid    (slave_wvalid),  
   .o_slave_wready    (slave_wready),  
   // ---------------------------------------------------------------

   //AXI write response bus -------------- // USED// --------------
   .o_slave_bid       (slave_bid[1:0]),
   .o_slave_bresp     (slave_bresp),
   .o_slave_bvalid    (slave_bvalid),
   .o_slave_buser     (slave_buser),   
   .i_slave_bready    (slave_bready),
   // ---------------------------------------------------------------



   //AXI read address bus -------------------------------------------
   .i_slave_arid      (slave_arid[1:0]),
   .i_slave_araddr    (slave_araddr),
   .i_slave_arlen     ({4'h0,slave_arlen} ),   
   .i_slave_arsize    (slave_arsize),  
   .i_slave_arburst   (slave_arburst), 
   .i_slave_arlock    (slave_arlock[0]),  
   .i_slave_arcache   (slave_arcache),
   .i_slave_arprot    (slave_arprot),
   .i_slave_arregion  (slave_arregion),       
   .i_slave_aruser    (slave_aruser),  
   .i_slave_arqos     (slave_arqos),  
   .i_slave_arvalid   (slave_arvalid), 
   .o_slave_arready   (slave_arready), 
   // ---------------------------------------------------------------


   //AXI read data bus ----------------------------------------------
   .o_slave_rid     (slave_rid[1:0]),
   .o_slave_rdata   (slave_rdata),
   .o_slave_rresp   (slave_rresp),
   .o_slave_rlast   (slave_rlast),   
   .o_slave_ruser   (slave_ruser),   
   .o_slave_rvalid  (slave_rvalid),  
   .i_slave_rready  (slave_rready),  

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
   //test signal with pad
   .i_smten_pad  (i_smten_pad),
   .i_sce_pad    (i_sce_pad),
   .sclk_pad     (sclk_pad),
   .o_sio_oen_pad  (o_sio_oen_pad), 
   .o_sio_pad      (o_sio_pad),
   .i_sio_pad      (i_sio_pad),
   //test signal
   .o_smten_eflsh      (o_smten_eflsh),
   .o_sce_eflsh        (o_sce_eflsh),
   .sclk_eflsh         (sclk_eflsh),
   .i_sio_oen_eflsh    (i_sio_oen_eflsh), 
   .i_sio_eflsh        (i_sio_eflsh),
   .o_sio_eflsh        (o_sio_eflsh)
   
   );

PF64AK32EI40 u_PF64AK32EI40(
        .ADDR          (o_addr_eflsh)    , 
        .DIN           (o_din_eflsh)    , 
        .DOUT          (i_dout_eflsh)    ,                
        .CS            (o_cs_eflsh)    , 
        .AE            (o_ae_eflsh)    , 
        .OE            (o_oe_eflsh)    , 
        .IFREN         (o_ifren_eflsh)    , 
        .NVSTR         (o_nvstr_eflsh)    , 
        .PROG          (o_prog_eflsh)    , 
        .SERA          (o_sera_eflsh)    , 
        .MASE          (o_mase_eflsh)    , 
        .TBIT          (i_tbit_eflsh)    ,                 
        .ADDR_1        (o_addr_1_eflsh)    , 
        .WORD          (o_word_eflsh)    ,               
        .RESETB        (o_resetb_eflsh)    ,                  
        .VDD           (VDD)    , 
        .VSS           (VSS)    , 
        .VPP           (1'b1)    , 
        .VNN           (1'b0)    ,               
        .SMTEN         (o_smten_eflsh)    , 
        .SCE           (o_sce_eflsh)    , 
        .SCLK          (sclk_eflsh)    , 
        .SIO_OEN       (i_sio_oen_eflsh)    , 
        .SIO_O         (i_sio_eflsh)    , 
        .SIO_I         (o_sio_eflsh)    );

    initial begin
      
      rst_n <= 1'b0;
      #100;
      rst_n <= 1'b1;
      @(posedge aclk);
      @(posedge aclk);
      axi_master.read_single(32'h10800,in_reg_vl,3'h2,4'h0);
      axi_master.write_single(32'h10800,32'h200,3'h2,4'hf);
      #2500000;
      axi_master.write_single(32'h00000,32'h87654321,3'h2,4'hf);
      #50000;
      axi_master.read_single(32'h00000,in_reg_vl,3'h2,4'h0);
      #200;

      $finish;
    end

    initial begin
    $fsdbDumpfile("eflash_tb.fsdb");
    $fsdbDumpvars(0,"eflash_tb");
    end 

endmodule
