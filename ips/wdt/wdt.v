//===================================================================================
// Copyright (c) 2019 Corelink (beijing) Co., Ltd.
// Create by zhaowt.
//-----------------------------------------------------------------------------------
// Project Name       : CL1901
// File Name          : wdt.v
// Author             : zhaowt
// Description        :
//-----------------------------------------------------------------------------------
// Create Date        : 2019/01/09
//
//===================================================================================


`define TD #1
`define SFR_D_W 32

module wdt (
            // APB BUS signals
            pclk,
            prst_n,
            paddr,
            pwdata,
            pwrite,
            penable,
            psel,
            prdata,
            pready,
            pslverr,
            //pheri clk
            clk_ls,
            // Outputs
            wdt2sync_rst_n
           );
   
    //*********** parameter definition ********************//
    parameter             WDT_BA   = 32'h1B00_0000;  // base address of wdt
    parameter             SVR      = WDT_BA + 32'h00;// Starting Value Register
    parameter             WER      = WDT_BA + 32'h04;// Wdt Enable Register;start dog with pwdata[0]=1
    parameter             FWR      = WDT_BA + 32'h08;// Feed Wdt Register
    parameter             FW_VALUE = 32'h76;
   
   

   
    // APB Bus
    input 				  pclk;            // APB bus clock.
    input 				  prst_n;          // Async reset of APB bus.
    input  [31:0]         paddr;           // apb bus address
    input  [31:0]         pwdata;          // apb bus write data signals
    input                 pwrite;          // apb bus write signal
    input                 psel;            // apb bus select signal
    input                 penable;         // apb bus operation enable signal 
    output [31:0]         prdata;          // apb bus read data signals
    output                pready;          // apb bus slave ready signal
    output                pslverr;          // apb bus slave err signal
    output                wdt2sync_rst_n;
    //
    input                 clk_ls;
    //SYSC
    reg    [31:0]         prdata_tmp;
    wire   [31:0]         prdata;
    wire                  pready;
    wire                  pslverr;
    wire                  wdt_feed_ls;
    wire                  wdt_bark_ls;
    reg                   wdt_feed;
    reg                   wdt_feed_d0,wdt_feed_d1,wdt_feed_d2;
    reg                   wdt_bark_d0,wdt_bark_d1,wdt_bark;
    reg                   wdt_feed_ls_d0,wdt_feed_ls_d1,wdt_feed_ls_d2;
    reg                   wdt_en;
    reg                   wdt_en_ls,wdt_en_ls_d0,wdt_en_ls_d1;
    reg                   wdt_rst_gen,wdt_rst_d0,wdt_rst_d1,wdt_rst_d2,wdt_rst_d3;
    reg    [31:0]         wdt_sv,wdt_cnt;
    wire                  wr_en;
    wire                  rd_en;
    //******************* Logics ************************************//
    assign pready = 1'b1;
    assign pslverr = 1'b0;
    assign wr_en  = psel && pwrite && penable;
    assign rd_en  = psel && ~pwrite && penable;   

    //=================================//
    //======APB Bus Write Process======//
    //=================================//
    
    //Initial value of wdt
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                wdt_sv <= 32'hFFFF_FFFF;//default value is max
            else if(~wdt_en)
                begin
                    if(wr_en && (paddr == SVR))
                        wdt_sv <= pwdata;
                end
        end
    //start signal
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    wdt_bark_d0 <= 1'b0;
                    wdt_bark_d1 <= 1'b0;
                    wdt_bark <= 1'b0;
                end
            else
                begin
                    wdt_bark_d0 <= wdt_bark_ls;
                    wdt_bark_d1 <= wdt_bark_d0;
                    wdt_bark <= wdt_bark_d1;
                end
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                wdt_en <= 0;
            else if(~wdt_en)
                begin
 	                if(wr_en && (paddr == WER))
 	                    wdt_en <= pwdata[0];
                end
            else if(wdt_en && wdt_bark)
                wdt_en <= 0;
        end
    //wdt feed signal
    always@(posedge clk_ls or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    wdt_feed_ls_d0 <= 1'b0;
                    wdt_feed_ls_d1 <= 1'b0;
                    wdt_feed_ls_d2 <= 1'b1;
                end
            else
                begin
                    wdt_feed_ls_d0 <= wdt_feed;
                    wdt_feed_ls_d1 <= wdt_feed_ls_d0;
                    wdt_feed_ls_d2 <= ~wdt_feed_ls_d1;
                end
        end
    assign wdt_feed_ls = (wdt_feed_ls_d2 & wdt_feed_ls_d1) & wdt_en_ls;

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    wdt_feed_d0 <= 1'b0;
                    wdt_feed_d1 <= 1'b0;
                    wdt_feed_d2 <= 1'b0;
                end
            else
                begin
                    wdt_feed_d0 <= wdt_feed_ls;
                    wdt_feed_d1 <= wdt_feed_d0;
                    wdt_feed_d2 <= wdt_feed_d1;
                end
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                wdt_feed <= 1'b0;
            else if(wdt_feed_d2)
                wdt_feed <= 1'b0;
            else if(wr_en && (paddr == FWR) && (pwdata == FW_VALUE))
                wdt_feed <= 1'b1;
        end

    //APB Bus Read Data Process.
    always@(*)
        begin
            case(paddr)
                SVR : prdata_tmp = wdt_sv;
                WER : prdata_tmp = {{(`SFR_D_W-1){1'b0}},wdt_en};
                default : prdata_tmp = {`SFR_D_W{1'b0}};
            endcase
        end
    assign prdata = rd_en ? prdata_tmp : 32'h0;
 //***************** Counter Part *********************//
 //****************************************************//
       
    assign wdt_bark_ls = (wdt_cnt == wdt_sv) & wdt_en_ls;
    //sync wdt_en signal to clk_ls
    always@(posedge clk_ls or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    wdt_en_ls_d0 <= 1'b0;
                    wdt_en_ls_d1 <= 1'b0;
                    wdt_en_ls <= 1'b0;
                end
            else
                begin
                    wdt_en_ls_d0 <= wdt_en;
                    wdt_en_ls_d1 <= wdt_en_ls_d0;
                    wdt_en_ls <= wdt_en_ls_d1;
                end
        end
    always@(posedge clk_ls or negedge prst_n)
        begin
            if(!prst_n)
                wdt_cnt <= 32'h1;
            else if(!wdt_en_ls)
                wdt_cnt <= 32'h1;
            else if(wdt_en_ls)
                begin
                    if(wdt_bark_ls | wdt_feed_ls)
                        wdt_cnt <= 32'h1;
                    else
                        wdt_cnt <= wdt_cnt + 32'h1;
                end
        end
    //***************** Reset generate Process ******************//
    //***********************************************************//
    // it keeps zero after asserted and should be cleared after system reset. 
    always@(posedge pclk or negedge prst_n) 
        begin
            if(!prst_n)
                wdt_rst_gen <= 1'b1;
            //else if(!wdt_bark)
            else if(!wdt_rst_gen)
                wdt_rst_gen <= 1'b1;
            else if(wdt_bark)
                wdt_rst_gen <= 1'b0;
        end
    always@(posedge pclk or negedge wdt_rst_gen)
        begin
            if(!wdt_rst_gen)
                begin
                    wdt_rst_d0 <= 1'b0;
                    wdt_rst_d1 <= 1'b0;
                    wdt_rst_d2 <= 1'b1;
                end
            else
                begin
                    wdt_rst_d0 <= 1'b1;
                    wdt_rst_d1 <= wdt_rst_d0;
                    wdt_rst_d2 <= wdt_rst_d1;
                end
        end
        
        assign    wdt2sync_rst_n = wdt_rst_d2;
endmodule // wdt.v

