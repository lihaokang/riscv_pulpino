module eflash_ctrl(
   //system signal
   input              clk  ,
   input              rst_n,        
   // ---------------------------------------------------------------
   //AXI write address bus -------------- // USED// --------------
   input  wire [3:0]                                  i_slave_awid      ,   
   input  wire [31:0]                                 i_slave_awaddr    , 
   input  wire [7:0]                                  i_slave_awlen     ,          
   input  wire [2:0]                                  i_slave_awsize    ,         
   input  wire [1:0]                                  i_slave_awburst   ,       
   input  wire                                        i_slave_awlock    ,        
   input  wire [3:0]                                  i_slave_awcache   ,        
   input  wire [2:0]                                  i_slave_awprot    , 
   input  wire [3:0]                                  i_slave_awregion  ,       
   input  wire                                        i_slave_awuser    , 
   input  wire [3:0]                                  i_slave_awqos     ,  
   input  wire                                        i_slave_awvalid   ,        
   output wire                                        o_slave_awready   ,        
   // ---------------------------------------------------------------

   //AXI write data bus -------------- // USED// --------------
   input  wire  [31:0]                                i_slave_wdata     ,
   input  wire  [3:0]                                 i_slave_wstrb     ,   
   input  wire                                        i_slave_wlast     , 
   input  wire                                        i_slave_wuser     ,   
   input  wire                                        i_slave_wvalid    ,  
   output reg                                         o_slave_wready    ,  
   // ---------------------------------------------------------------

   //AXI write response bus -------------- // USED// --------------
   output  reg    [3:0]                               o_slave_bid       ,
   output  reg    [1:0]                               o_slave_bresp     ,
   output  reg                                        o_slave_bvalid    ,
   output  wire                                       o_slave_buser     ,   
   input   wire                                       i_slave_bready    ,
   // ---------------------------------------------------------------



   //AXI read address bus -------------------------------------------
   input  wire [3:0]                                  i_slave_arid      ,
   input  wire [31:0]                                 i_slave_araddr    ,
   input  wire [ 7:0]                                 i_slave_arlen     ,   
   input  wire [ 2:0]                                 i_slave_arsize    ,  
   input  wire [ 1:0]                                 i_slave_arburst   , 
   input  wire                                        i_slave_arlock    ,  
   input  wire [ 3:0]                                 i_slave_arcache   ,
   input  wire [ 2:0]                                 i_slave_arprot    ,
   input  wire [ 3:0]                                 i_slave_arregion  ,       
   input  wire                                        i_slave_aruser    ,  
   input  wire [ 3:0]                                 i_slave_arqos     ,  
   input  wire                                        i_slave_arvalid   , 
   output reg                                         o_slave_arready   , 
   // ---------------------------------------------------------------


   //AXI read data bus ----------------------------------------------
   output reg  [3:0]                                  o_slave_rid       ,
   output reg  [31:0]                                 o_slave_rdata     ,
   output wire [ 1:0]                                 o_slave_rresp     ,
   output wire                                        o_slave_rlast     ,   
   output wire                                        o_slave_ruser     ,   
   output reg                                         o_slave_rvalid    ,  
   input  wire                                        i_slave_rready    ,  

   //eflash model signal
   output  wire [13:0]    o_addr_eflsh         ,
   output  wire           o_addr_1_eflsh       ,
   output  wire           o_word_eflsh         ,
   output  reg [31:0]     o_din_eflsh          ,
   input   [31:0]         i_dout_eflsh         ,
   output  reg            o_resetb_eflsh       ,
   output  reg            o_cs_eflsh           ,
   output  reg            o_ae_eflsh           ,
   output  reg            o_oe_eflsh           ,
   output  wire           o_ifren_eflsh        ,
   output  reg            o_nvstr_eflsh        ,
   output  reg            o_prog_eflsh         ,
   output  reg            o_sera_eflsh         ,
   output  reg            o_mase_eflsh         ,
   input                  i_tbit_eflsh         ,
   //test signal with pad
   input                  i_smten_pad          ,
   input                  i_sce_pad            ,
   input                  sclk_pad             ,
   output  wire           o_sio_oen_pad        , 
   output  wire           o_sio_pad            ,
   input                  i_sio_pad            ,
   //test signal
   output  wire           o_smten_eflsh        ,
   output  wire           o_sce_eflsh          ,
   output  wire           sclk_eflsh           ,
   input                  i_sio_oen_eflsh      , 
   input                  i_sio_eflsh          ,
   output  wire           o_sio_eflsh
   
   );


  //--------------------------------------------------------------------------// 
  // Internal Parameters
  //--------------------------------------------------------------------------//
   localparam STANDBY     = 3'h0;
 
   localparam WRITE       = 3'h1;
 
   localparam READ        = 3'h2;
 
   localparam PAGE_ERASE  = 3'h3;
 
   localparam MACRO_ERASE = 3'h4;

   localparam IN_REG_ADDR = 16'h8200;

   localparam INFOR_ADDR_BEGIN = 16'h8000;

  //--------------------------------------------------------------------------// 
  // Internal wire and reg
  //--------------------------------------------------------------------------//
   wire            read_en_comb;
   reg             read_en;
   wire            write_cmd_en_comb;
   reg             write_cmd_en;
   wire            write_data_en_comb;
   reg             write_data_en;
   wire            read_begin;
   wire            write_begin;
   wire            page_erase_begin;
   wire            macro_erase_begin;
   wire            tbit_end;
   wire            read_end;
   wire            deflt_addr_read;
   wire            deflt_addr_write;
   wire            in_reg_read;
   wire            in_reg_write; 
   wire            wr_data_eflash;
   wire            wr_infor_addr;
   wire            rd_infor_addr;
   reg   [31:0]    slave_awaddr_ff0;
   reg   [31:0]    slave_awaddr_wr;

   reg             tbit_ff0;
   reg             tbit_ff1;

   reg             active_en;
   reg   [7:0]     page_num;
   reg             macro_erase;
   reg             erase_en;
   reg   [2:0]     cur_st;
   reg   [2:0]     next_st;
   reg   [2:0]     in_cnt;
   reg             resetb_eflsh_pre;
   reg   [13:0]    addr_eflsh      ;
   reg             ifren_eflsh     ;
  //--------------------------------------------------------------------------// 
  // Internal block
  //--------------------------------------------------------------------------//
   assign o_ifren_eflsh = read_begin ? rd_infor_addr : ifren_eflsh;

   assign o_addr_eflsh = read_begin ? i_slave_araddr[15:2] : addr_eflsh;

   assign tbit_end = tbit_ff1 & (tbit_ff0 == 1'b0);
  
   assign wr_infor_addr = (slave_awaddr_wr[17:2] < IN_REG_ADDR) & (slave_awaddr_wr[17:2] >= INFOR_ADDR_BEGIN);

   assign rd_infor_addr = (i_slave_araddr[17:2] < IN_REG_ADDR) & (i_slave_araddr[17:2] >= INFOR_ADDR_BEGIN);

   assign o_slave_awready = write_cmd_en_comb;
 
   assign o_slave_rlast = 1'b1;   
  
   assign o_slave_rresp = 2'h0;

   assign o_slave_buser = 1'b0;
  
   assign o_slave_ruser = 1'b0;

   assign wr_data_eflash = i_slave_wvalid & o_slave_wready;
 
   assign deflt_addr_read = i_slave_arvalid & o_slave_arready & (i_slave_araddr[17:2] > IN_REG_ADDR);
  
   assign deflt_addr_write = wr_data_eflash & (slave_awaddr_wr[17:2] > IN_REG_ADDR);
 
   assign in_reg_read = i_slave_arvalid & o_slave_arready & (i_slave_araddr[17:2] == IN_REG_ADDR);
  
   assign in_reg_write = wr_data_eflash & (slave_awaddr_wr[17:2] == IN_REG_ADDR);
  
   assign read_begin =  i_slave_arvalid & o_slave_arready & (i_slave_araddr[17:2] < IN_REG_ADDR);
  
   assign write_begin =  wr_data_eflash & (slave_awaddr_wr[17:2] < IN_REG_ADDR);
  
   assign page_erase_begin = in_reg_write & i_slave_wdata[9] & (i_slave_wdata[8] == 1'b0);
  
   assign macro_erase_begin = in_reg_write & i_slave_wdata[9] & i_slave_wdata[8];
 
   assign read_end = (cur_st == READ) & (in_cnt[0] == 1'b1);

  // assign read_end = (cur_st == READ) & (in_cnt[1:0] == 2'h2);

    //for test block
   assign  o_smten_eflsh = i_smten_pad;
  
   assign  o_sce_eflsh = i_sce_pad;
  
   assign  sclk_eflsh = sclk_pad;
  
   assign  o_sio_oen_pad = i_sio_oen_eflsh;
   
   assign  o_sio_pad = i_sio_eflsh;
   
   assign  o_sio_eflsh = i_sio_pad;
   
   assign  o_word_eflsh = 1'b0;
  
   assign  o_addr_1_eflsh = 1'b0;

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           write_cmd_en <= 1'b1;     
       end 
       else if(i_slave_awvalid == 1'b1 && o_slave_awready == 1'b1) begin
           write_cmd_en <= 1'b0; 
       end 
       else if(o_slave_bvalid == 1'b1 && i_slave_bready == 1'b1) begin
           write_cmd_en <= 1'b1;           
       end 
   end

   assign write_cmd_en_comb = (o_slave_bvalid & i_slave_bready) ? 1'b1 : write_cmd_en;

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           write_data_en <= 1'b1;     
       end 
       else if(i_slave_wvalid == 1'b1 && o_slave_wready == 1'b1) begin
           write_data_en <= 1'b0; 
       end 
       else if(o_slave_bvalid == 1'b1 && i_slave_bready == 1'b1) begin
           write_data_en <= 1'b1;           
       end 
   end

   assign write_data_en_comb = (o_slave_bvalid & i_slave_bready) ? 1'b1 : write_data_en;

   //for write
   always @(*) begin
       if(i_slave_wvalid == 1'b1 && active_en == 1'b1 && i_slave_arvalid == 1'b0 && write_data_en_comb == 1'b1) begin
           o_slave_wready = 1'b1;
       end
       else if(i_slave_wvalid == 1'b1 && slave_awaddr_wr[17:2] > IN_REG_ADDR && write_data_en_comb == 1'b1) begin
           o_slave_wready = 1'b1;
       end
       else begin
           o_slave_wready = 1'b0;
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_bvalid <= 1'b0;
       end
       else if(deflt_addr_write == 1'b1 || in_reg_write == 1'b1) begin
           o_slave_bvalid <= 1'b1;
       end
       else if(cur_st == WRITE && tbit_end == 1'b1) begin
           o_slave_bvalid <= 1'b1;
       end
       else if(i_slave_bready == 1'b1) begin
           o_slave_bvalid <= 1'b0;           
       end
   end
   
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_bresp <= 2'h0;
       end
       else if(deflt_addr_write == 1'b1) begin
           o_slave_bresp <= 2'h2;
       end
       else if((cur_st == WRITE && tbit_end == 1'b1) || in_reg_write == 1'b1) begin
           o_slave_bresp <= 2'h0;
       end
       else if(i_slave_bready == 1'b1) begin
           o_slave_bresp <= 2'h0;         
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_bid <= 4'h0;
       end
       else if(i_slave_awvalid == 1'b1 && o_slave_awready == 1'b1) begin
           o_slave_bid <= i_slave_awid;
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           slave_awaddr_ff0 <= 32'h0;
       end
       else if(i_slave_awvalid == 1'b1 && o_slave_awready == 1'b1) begin
           slave_awaddr_ff0 <= i_slave_awaddr;
       end
   end

   always @(*) begin
       if(i_slave_awvalid == 1'b1 && o_slave_awready == 1'b1) begin
           slave_awaddr_wr = i_slave_awaddr;
       end
       else begin
           slave_awaddr_wr = slave_awaddr_ff0;
       end
   end

   //for axi read
   always @(*) begin
       if(i_slave_arvalid == 1'b1 && active_en == 1'b1 && read_en_comb == 1'b1) begin
           o_slave_arready = 1'b1;
       end
       else if(i_slave_arvalid == 1'b1 && i_slave_araddr[17:2] >= IN_REG_ADDR && read_en_comb == 1'b1) begin
           o_slave_arready = 1'b1;
       end
       else begin
           o_slave_arready = 1'b0;
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           read_en <= 1'b1;     
       end 
       else if(i_slave_arvalid == 1'b1 && o_slave_arready == 1'b1) begin
           read_en <= 1'b0; 
       end 
       else if(o_slave_rvalid == 1'b1 && i_slave_rready == 1'b1) begin
           read_en <= 1'b1;           
       end 
   end

   assign read_en_comb = (o_slave_rvalid & i_slave_rready) ? 1'b1 : read_en;

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_rid <= 4'h0;
       end
       else if(i_slave_arvalid == 1'b1 && o_slave_arready == 1'b1) begin
           o_slave_rid <= i_slave_arid;
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_rdata <= 32'h0; 
       end
       else if(read_end == 1'b1 ) begin
           o_slave_rdata <= i_dout_eflsh;
       end
       else if(in_reg_read == 1'b1) begin
           o_slave_rdata <= {cur_st,18'h0,active_en,erase_en,macro_erase,page_num};       
       end
       else if(deflt_addr_read == 1'b1) begin
           o_slave_rdata <= 32'h12345678;            
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_slave_rvalid <= 1'b0; 
       end
       else if(read_end == 1'b1 || (i_slave_arvalid == 1'b1 && i_slave_araddr[17:2] >= IN_REG_ADDR && o_slave_arready == 1'b1)) begin
           o_slave_rvalid <= 1'b1;
       end
       else if(i_slave_rready == 1'b1) begin
           o_slave_rvalid <= 1'b0;             
       end
   end   

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           page_num <= 8'h0;
       end
       else if(in_reg_write == 1'b1) begin
           page_num <= i_slave_wdata[7:0];
       end 
   end
  
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           macro_erase <= 1'b0;
       end
       else if(in_reg_write == 1'b1) begin
           macro_erase <= i_slave_wdata[8];
       end 
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           erase_en <= 1'b0;
       end
       else if(in_reg_write == 1'b1) begin
           erase_en <= i_slave_wdata[9];
       end
       else if(tbit_end == 1'b1) begin
           erase_en <= 1'b0;       
       end 
   end

   always @(*)  begin
       if(cur_st == STANDBY) begin
           active_en = 1'b1; 
       end
       else begin
           active_en = 1'b0;
       end
   end  

//tbit
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           tbit_ff0 <= 1'b0;
       end 
       else begin
           tbit_ff0 <= i_tbit_eflsh;
       end
   end
 
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           tbit_ff1 <= 1'b0;
       end 
       else begin
           tbit_ff1 <= tbit_ff0;
       end
   end

 // in state
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           resetb_eflsh_pre <= 1'b0;
       end
       else begin
           resetb_eflsh_pre <= 1'b1;        
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_resetb_eflsh <= 1'b0;
       end
       else begin
           o_resetb_eflsh <= resetb_eflsh_pre;        
       end
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           cur_st <= STANDBY;
       end
       else begin
           cur_st <= next_st;
       end
   end
   
   //for internal state
   always @(*) begin
       case(cur_st)
            STANDBY : begin
               if(read_begin == 1'b1) begin
                   next_st = READ;
               end
               else if(write_begin == 1'b1) begin
                   next_st = WRITE;
               end
               else if(page_erase_begin == 1'b1) begin
                   next_st = PAGE_ERASE;
               end
               else if(macro_erase_begin == 1'b1) begin
                   next_st = MACRO_ERASE;
               end
               else begin
                   next_st = STANDBY;
               end
            end
            WRITE : begin
               if(tbit_end == 1'b1) begin
                   next_st = STANDBY;
               end
               else begin
                   next_st = WRITE;
               end
            end
            READ : begin
               if(read_end == 1'b1) begin
                   next_st = STANDBY;                    
               end
               else begin
                   next_st = READ;
               end
            end
            PAGE_ERASE : begin
               if(tbit_end == 1'b1) begin
                   next_st = STANDBY;
               end
               else begin
                   next_st = PAGE_ERASE;
               end
            end
            MACRO_ERASE : begin
               if(tbit_end == 1'b1) begin
                   next_st = STANDBY;
               end
               else begin
                   next_st = MACRO_ERASE;
               end
            end
            default : begin
               next_st = STANDBY;
            end
            endcase
   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           in_cnt <= 3'h0; 
       end
       else if(tbit_end == 1'b1 ||  read_end == 1'b1) begin
           in_cnt <= 3'h0; 
       end
       else if(in_cnt == 3'h7) begin
           in_cnt <= 3'h7;
       end
       else if(cur_st == READ || cur_st == WRITE || cur_st == PAGE_ERASE || cur_st == MACRO_ERASE) begin
           in_cnt <= in_cnt + 1;
       end    
   end    

  //for new
    //for AE
//   always @(posedge clk or negedge rst_n) begin
//       if(rst_n == 1'b0) begin
//           o_ae_eflsh <= 1'b0; 
//       end
//       else if(read_begin == 1'b1) begin
//           o_ae_eflsh <= 1'b1;
//       end
//       else if((|in_cnt) == 1'b0 && cur_st == READ) begin
//           o_ae_eflsh <= 1'b0;
//       end        
//       else if((|in_cnt) == 1'b0 && (cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE)) begin
//           o_ae_eflsh <= 1'b1;
//       end
//       else begin
//           o_ae_eflsh <= 1'b0;
//       end
//   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_ae_eflsh <= 1'b0; 
       end
       else if(read_begin == 1'b1) begin
           o_ae_eflsh <= 1'b1;
       end
       else if((|in_cnt) == 1'b0 && (cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE)) begin
           o_ae_eflsh <= 1'b1;
       end
       else begin
           o_ae_eflsh <= 1'b0;
       end
   end

  //for CS
   always @(*) begin
       if(page_erase_begin == 1'b1 || macro_erase_begin == 1'b1 || write_begin == 1'b1 || read_begin == 1'b1) begin
           o_cs_eflsh = 1'b1; 
       end
       else if(cur_st == STANDBY)begin
           o_cs_eflsh = 1'b0;           
       end
       else begin
           o_cs_eflsh = 1'b1;           
       end
   end

  //for CS
 //  always @(posedge clk or negedge rst_n) begin
 //      if(rst_n == 1'b0) begin
 //          o_cs_eflsh <= 1'b0; 
 //      end
 //      else if(page_erase_begin == 1'b1 || macro_erase_begin == 1'b1 || write_begin == 1'b1 || read_begin == 1'b1) begin
 //          o_cs_eflsh <= 1'b1; 
 //      end
 //      else if(next_st == STANDBY) begin
 //          o_cs_eflsh <= 1'b0;
 //      end
 //  end

  //for OE     
//   always @(posedge clk or negedge rst_n) begin
//       if(rst_n == 1'b0) begin
//           o_oe_eflsh <= 1'b0; 
//       end
//       else if(read_begin == 1'b1) begin
//           o_oe_eflsh <= 1'b1; 
//       end
//       else if(in_cnt[0] == 1'b1 && cur_st == READ) begin
//           o_oe_eflsh <= 1'b0;
//       end
//   end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_oe_eflsh <= 1'b0; 
       end
       else if(in_cnt[0] == 1'b1 && cur_st == READ) begin
           o_oe_eflsh <= 1'b0; 
       end
       else if(read_begin == 1'b1) begin
           o_oe_eflsh <= 1'b1;
       end
   end

   //for PROG
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_prog_eflsh <= 1'b0; 
       end
       else if(write_begin == 1'b1) begin
           o_prog_eflsh <= 1'b1; 
       end
       else if(in_cnt == 3'h1 && cur_st == WRITE) begin
           o_prog_eflsh <= 1'b0;
       end
   end

   //for SERA 
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_sera_eflsh <= 1'b0; 
       end
       else if(page_erase_begin == 1'b1) begin
           o_sera_eflsh <= 1'b1; 
       end
       else if(in_cnt == 3'h1 && cur_st == PAGE_ERASE) begin
           o_sera_eflsh <= 1'b0;
       end
   end

   //for MASE
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_mase_eflsh <= 1'b0; 
       end
       else if(macro_erase_begin == 1'b1) begin
           o_mase_eflsh <= 1'b1; 
       end
       else if(in_cnt == 3'h1 && cur_st == MACRO_ERASE) begin
           o_mase_eflsh <= 1'b0;
       end
   end

   //for NVSTR 
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_nvstr_eflsh <= 1'b0; 
       end
       else if(tbit_end == 1'b1) begin
           o_nvstr_eflsh <= 1'b0; 
       end
       else if(in_cnt == 3'h1 && (cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE)) begin
           o_nvstr_eflsh <= 1'b1;
       end
   end

   //for din
   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           o_din_eflsh <= 32'hffffffff;
       end
       else if(write_begin == 1'b1) begin
           o_din_eflsh <= i_slave_wdata;
       end
       else if(cur_st == WRITE && in_cnt == 3'h1) begin
           o_din_eflsh <= 32'hffffffff;
       end
   end

   //for IFREN 
 //  always @(posedge clk or negedge rst_n) begin
 //      if(rst_n == 1'b0) begin
 //          o_ifren_eflsh <= 1'b0;
 //      end
 //      else if(write_begin == 1'b1 && wr_infor_addr == 1'b1) begin
 //          o_ifren_eflsh <= 1'b1;
 //      end
 //      else if(read_begin == 1'b1 && rd_infor_addr == 1'b1) begin
 //          o_ifren_eflsh <= 1'b1;
 //      end
 //      else if((page_erase_begin == 1'b1 || macro_erase_begin == 1'b1) && i_slave_wdata[6] == 1'b1) begin
 //          o_ifren_eflsh <= 1'b1;
 //      end
 //      else if(cur_st == READ && in_cnt == 19'h0) begin
 //          o_ifren_eflsh <= 1'b0;
 //      end
 //      else if((cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE) && in_cnt == 19'h1) begin
 //          o_ifren_eflsh <= 1'b0;
 //      end
 //  end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           ifren_eflsh <= 1'b0;
       end
       else if(read_begin == 1'b1 && rd_infor_addr == 1'b1) begin
           ifren_eflsh <= 1'b1;
       end
       else if((cur_st == READ) && in_cnt == 1'b0) begin
           ifren_eflsh <= 1'b0;
       end
       else if(write_begin == 1'b1 && wr_infor_addr == 1'b1) begin
           ifren_eflsh <= 1'b1;
       end        
       else if((page_erase_begin == 1'b1 || macro_erase_begin == 1'b1) && i_slave_wdata[6] == 1'b1) begin
           ifren_eflsh <= 1'b1;
       end
       else if((cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE) && in_cnt == 3'h1) begin
           ifren_eflsh <= 1'b0;
       end
   end

   //for eflash addr 
 //  always @(posedge clk or negedge rst_n) begin
 //      if(rst_n == 1'b0) begin
 //          o_addr_eflsh <= 14'h0;
 //      end
 //      else if(read_begin == 1'b1) begin
 //          o_addr_eflsh <= i_slave_araddr[15:2];
 //      end
 //      else if(write_begin == 1'b1) begin
 //          o_addr_eflsh <= slave_awaddr_wr[15:2];
 //      end

 //      else if(page_erase_begin == 1'b1) begin
 //          o_addr_eflsh <= {i_slave_wdata[5:0],8'h0};         
 //      end
 //      else if(cur_st == READ && in_cnt == 19'h0) begin
 //          o_addr_eflsh <= 14'h0;
 //      end
 //      else if((cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE) && in_cnt == 19'h1) begin
 //          o_addr_eflsh <= 14'h0;
 //      end
 //  end

   always @(posedge clk or negedge rst_n) begin
       if(rst_n == 1'b0) begin
           addr_eflsh <= 14'h0;
       end
       else if(read_begin == 1'b1) begin
           addr_eflsh <= i_slave_araddr[15:2];
       end
       else if(cur_st == READ && in_cnt == 1'b0) begin
           addr_eflsh <= 14'h0;
       end        
       else if(write_begin == 1'b1) begin
           addr_eflsh <= slave_awaddr_wr[15:2];
       end

       else if(page_erase_begin == 1'b1) begin
           addr_eflsh <= {i_slave_wdata[5:0],8'h0};         
       end
       else if((cur_st == MACRO_ERASE || cur_st == PAGE_ERASE || cur_st == WRITE) && in_cnt == 3'h1) begin
           addr_eflsh <= 14'h0;
       end
   end

endmodule



