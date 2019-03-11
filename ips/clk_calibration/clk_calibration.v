//===================================================================================
// Copyright (c) 2019 Corelink (beijing) Co., Ltd.
// Create by zhaowt.
//-----------------------------------------------------------------------------------
// Project Name       : CL1901
// File Name          : clk_calibration.v
// Author             : zhaowt
// Description        :
//-----------------------------------------------------------------------------------
// Create Date        : 2019/01/09
//
//===================================================================================

module clk_calibration (
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
                        //standard clock input
                        clk_32k,//include xtal32768 or external clk-32768
                        clk_rc32m,
                        clk_rc32k,
                        //regulate bits
                        freq_sel_rc32m,
                        freq_sel_rc32k,
                        //interrupt output
                        int_rc32m,
                        int_rc32k
                       );
   
    //*********** parameter definition ********************//
    parameter   CBA   = 32'h1B00_2000;// standard clock divide for rc32m
    parameter   SCD_H = CBA + 32'h00;// standard clock divide for rc32m
    parameter   SCD_L = CBA + 32'h04;// standard clock divide for rc32k
    parameter   SCV_H = CBA + 32'h08;// standard count value for rc32m
    parameter   SCV_L = CBA + 32'h0c;// standard count value for rc32k
    parameter   FCV_H = CBA + 32'h10;// final count value for rc32m,read only
    parameter   FCV_L = CBA + 32'h14;// final count value for rc32k,read only
    parameter   SVS_H = CBA + 32'h18;// set value of high clk select
    parameter   SVS_L = CBA + 32'h1c;// set value of low clk select
    parameter   INT_H = CBA + 32'h20;// interrupt of high clk
    parameter   INT_L = CBA + 32'h24;// interrupt of low clk
    parameter   SCO   = CBA + 32'h28;// start for calibration operation,

    parameter   STABLE_CY = 8'b0000_1111;//wait 15 cycle before count
    parameter   INT_CLR = 32'h01;
   

    // APB Bus
    input 				pclk;            // APB bus clock
    input 				prst_n;          // Async reset of APB bus
    input  [31:0]       paddr;           // apb bus address
    input  [31:0]       pwdata;          // apb bus write data signals
    input               pwrite;          // apb bus write signal
    input               psel;            // apb bus select signal
    input               penable;         // apb bus operation enable signal 
    output [31:0]       prdata;          // apb bus read data signals
    output              pready;          // apb bus slave ready signal
    output              pslverr;         // apb bus slave pslverr signal
    //
    input               clk_32k;
    input               clk_rc32m;
    input               clk_rc32k;
    output [7:0]        freq_sel_rc32m;
    output [3:0]        freq_sel_rc32k;
    output              int_rc32m;
    output              int_rc32k;
    //SYSC
    wire   [31:0]       prdata;
    reg    [31:0]       prdata_tmp;
    wire                apb_wr_en;
    wire                apb_rd_en;
    reg    [31:0]       cnt_clk_32k_rc32k;
    reg                 clk_32k_rc32k;
    reg    [31:0]       cnt_rc32m,cnt_rc32k;
    reg                 clk_32k_sync_rc32m_d0,clk_32k_sync_rc32m_d1,clk_32k_sync_rc32m_d2;
    reg                 clk_32k_sync_rc32k_d0,clk_32k_sync_rc32k_d1,clk_32k_sync_rc32k_d2;
    reg                 stable_rc32m,stable_rc32k;
    reg                 en_cnt_rc32m,en_cnt_rc32k;
    reg                 regulate_rc32m,regulate_rc32k;
    reg    [7:0]        cnt_stable_rc32m,cnt_stable_rc32k;
    //wire                clk_32k_sync_rc32m_negedge;
    wire                clk_32k_sync_rc32m_posedge;
    wire                finish_rc32m_calib,finish_rc32k_calib;
    wire                clk_32k_sync_rc32k_posedge;
    //wire                clk_32k_sync_rc32k_negedge;
        
    reg   [31:0]        ref_value_rc32m,ref_value_rc32k; 
    reg   [15:0]        num_standard_clk_rc32m,num_standard_clk_rc32k;
    reg   [15:0]        cnt_num_standard_clk_rc32m;
    reg   [15:0]        cnt_num_standard_clk_rc32k;
    reg                 start4rc32m,start4rc32k;        
    reg                 int_rc32m,int_rc32k;
    reg   [1:0]         regulate_state_rc32m;
    reg   [1:0]         regulate_state_rc32k;
    reg   [31:0]        final_value_rc32m,final_value_rc32k;
    reg                 regulate_rc32m_finish;
    reg                 regulate_rc32k_finish;
    reg   [7:0]         next_freq_sel_rc32m,shift_reg_rc32m,freq_sel_rc32m;
    reg   [3:0]         next_freq_sel_rc32k,shift_reg_rc32k,freq_sel_rc32k;
    reg   [2:0]         cnt_regulate_rc32m_finish;
    reg   [2:0]         cnt_regulate_rc32k_finish;
    wire                slow_rc32m,fast_rc32m,standard_rc32m;
    wire                slow_rc32k,fast_rc32k,standard_rc32k;
    wire                once_regulate_rc32m_finish;
    wire                once_regulate_rc32k_finish;
    wire                regulate_rc32k_posedge;
    reg                 regulate_rc32k_finish_d0;
    reg                 regulate_rc32k_finish_d1;
    reg                 regulate_rc32k_finish_d2;

    //******************* Logics ************************************//
    assign pready = 1'b1;
    assign pslverr = 1'b0;
    assign apb_wr_en = psel && pwrite && penable;
    assign apb_rd_en = psel && ~pwrite && penable;   
    assign slow_rc32m = start4rc32m && (ref_value_rc32m > final_value_rc32m);
    assign fast_rc32m = start4rc32m && (ref_value_rc32m < final_value_rc32m);
    assign standard_rc32m = start4rc32m && (ref_value_rc32m == cnt_rc32m);
    assign once_regulate_rc32m_finish = start4rc32m && regulate_rc32m && (regulate_state_rc32m == 2'b10);
    //
    assign slow_rc32k = start4rc32k && (ref_value_rc32k > final_value_rc32k);
    assign fast_rc32k = start4rc32k && (ref_value_rc32k < final_value_rc32k);
    assign standard_rc32k = start4rc32k && (ref_value_rc32k == cnt_rc32k);
    assign once_regulate_rc32k_finish = start4rc32k && regulate_rc32k && (regulate_state_rc32k == 2'b10);
    //=================================//
    //======APB Bus Write Process======//
    //=================================//
    
    //
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    ref_value_rc32m <= 32'h0;
                    ref_value_rc32k <= 32'h0;
                    num_standard_clk_rc32m <= 16'h0;
                end
            else if(apb_wr_en)
                begin
                    if(paddr == SCV_H)
                         ref_value_rc32m <= pwdata;
                    else if(paddr == SCV_L)
                         ref_value_rc32k <= pwdata;
                    else if(paddr == SCD_H)
                         num_standard_clk_rc32m <= pwdata[16:0];
                    else if(paddr == SCD_L)
                         num_standard_clk_rc32k <= pwdata[16:0];
                end
        end

    //APB BUS read operation
    always@(*)
        begin
            case(paddr)
                SCV_H  : prdata_tmp = ref_value_rc32m;
                SCV_L  : prdata_tmp = ref_value_rc32k;
                FCV_H  : prdata_tmp = final_value_rc32m;
                FCV_L  : prdata_tmp = final_value_rc32k;
                SVS_H  : prdata_tmp = {24'h0,freq_sel_rc32m};
                SVS_L  : prdata_tmp = {28'h0,freq_sel_rc32k};
                INT_H  : prdata_tmp = {31'h0,int_rc32m};
                INT_L  : prdata_tmp = {31'h0,int_rc32k};
                SCD_H  : prdata_tmp = {16'h0,num_standard_clk_rc32m};
                SCD_L  : prdata_tmp = {16'h0,num_standard_clk_rc32k};
                SCO    : prdata_tmp = {30'h0,start4rc32m,start4rc32k};
                default: prdata_tmp = 32'h0;
            endcase
        end
    assign prdata = apb_rd_en ? prdata_tmp : 32'h0;

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    start4rc32m <= 1'b0;
                    start4rc32k <= 1'b0;
                end
            else if(apb_wr_en && (paddr == SCO))
                begin
                    start4rc32m <= pwdata[1];
                    start4rc32k <= pwdata[0];
                end
            //else if(finish_rc32m_calib)
            else if(regulate_rc32m_finish)
                    start4rc32m <= 1'b0;
            //else if(finish_rc32k_calib)
            else if(regulate_rc32k_finish)
                    start4rc32k <= 1'b0;
        end

    //generate time for rc32m
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    clk_32k_sync_rc32m_d0 <= 1'b0;
                    clk_32k_sync_rc32m_d1 <= 1'b0;
                    clk_32k_sync_rc32m_d2 <= 1'b0;
                end
            else
                begin
                    clk_32k_sync_rc32m_d0 <= clk_32k;
                    clk_32k_sync_rc32m_d1 <= clk_32k_sync_rc32m_d0;
                    clk_32k_sync_rc32m_d2 <= clk_32k_sync_rc32m_d1;
                end
        end

    assign clk_32k_sync_rc32m_posedge =  clk_32k_sync_rc32m_d1 && ~clk_32k_sync_rc32m_d2;
    //assign clk_32k_sync_rc32m_negedge = ~clk_32k_sync_rc32m_d1 &&  clk_32k_sync_rc32m_d2;
    
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                stable_rc32m <= 1'b1;//default rc32m is stable 
            else if(!start4rc32m)
                stable_rc32m <= 1'b1; 
            else if(start4rc32m && (cnt_stable_rc32m == STABLE_CY))
                stable_rc32m <= 1'b1; 
            else if(start4rc32m && once_regulate_rc32m_finish)
                stable_rc32m <= 1'b0; 
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                en_cnt_rc32m <= 1'b0; 
            else if(start4rc32m && en_cnt_rc32m && clk_32k_sync_rc32m_posedge && (cnt_num_standard_clk_rc32m == (num_standard_clk_rc32m-1)))
                en_cnt_rc32m <= 1'b0; 
            else if(start4rc32m && clk_32k_sync_rc32m_posedge && ~en_cnt_rc32m)
                en_cnt_rc32m <= 1'b1; 
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                cnt_stable_rc32m <= 8'h0; 
            else if(start4rc32m && ~stable_rc32m)
                begin
                    if(cnt_stable_rc32m == STABLE_CY)
                        cnt_stable_rc32m <= 8'h0; 
                    else
                        cnt_stable_rc32m <= cnt_stable_rc32m + 8'h1; 
                end
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                cnt_rc32m <= 32'h0;
            else if(en_cnt_rc32m)
                begin
                   //if(clk_32k_sync_rc32m_posedge)
                    if(en_cnt_rc32m && clk_32k_sync_rc32m_posedge && (cnt_num_standard_clk_rc32m == (num_standard_clk_rc32m-1)))
                       cnt_rc32m <= 32'h0;
                   else
                       cnt_rc32m <= cnt_rc32m + 32'h1;
                end
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                cnt_num_standard_clk_rc32m <= 16'h0;
            else if(en_cnt_rc32m && clk_32k_sync_rc32m_posedge)
                begin
                    if(cnt_num_standard_clk_rc32m == (num_standard_clk_rc32m-1))
                        cnt_num_standard_clk_rc32m <= 16'h0;
                    else
                        cnt_num_standard_clk_rc32m <= cnt_num_standard_clk_rc32m + 16'b1;
                end
        end

    //always@(posedge ref_value_rc32m or negedge prst_n)
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                regulate_rc32m <= 1'b0;
            else if(once_regulate_rc32m_finish)
                regulate_rc32m <= 1'b0;
            else if(en_cnt_rc32m && clk_32k_sync_rc32m_posedge && (cnt_num_standard_clk_rc32m == (num_standard_clk_rc32m-1)))
                regulate_rc32m <= 1'b1;
        end



    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                final_value_rc32m <= 32'h0;
            //else if(en_cnt_rc32m && clk_32k_sync_rc32m_posedge)
            else if(en_cnt_rc32m && clk_32k_sync_rc32m_posedge && (cnt_num_standard_clk_rc32m == (num_standard_clk_rc32m-1)))
                final_value_rc32m <= cnt_rc32m;
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                regulate_state_rc32m <= 2'b00;
            else if(regulate_rc32m)
                begin
                    if(regulate_state_rc32m == 2'b10)
                        regulate_state_rc32m <= 2'b00;
                    else
                        regulate_state_rc32m <= regulate_state_rc32m + 2'b1;
                end
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                next_freq_sel_rc32m <= 8'b1000_0000;
            else if(regulate_rc32m_finish)
                next_freq_sel_rc32m <= 8'b1000_0000;
            else if(regulate_rc32m && (regulate_state_rc32m == 2'b00) && fast_rc32m)
                next_freq_sel_rc32m <= next_freq_sel_rc32m ^ shift_reg_rc32m;
            else if(regulate_rc32m && (regulate_state_rc32m == 2'b01))
                next_freq_sel_rc32m <= next_freq_sel_rc32m + shift_reg_rc32m;
        end
    //reagulate rc32m 
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                shift_reg_rc32m <= 8'b1000_0000;       
            else if(regulate_rc32m_finish)
                shift_reg_rc32m <= 8'b1000_0000;       
            else if(regulate_rc32m && (regulate_state_rc32m == 2'b00))
                shift_reg_rc32m <= {1'b0,shift_reg_rc32m[7:1]};       
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                freq_sel_rc32m <= 8'b1000_0000;
            else if(apb_wr_en && (paddr == SVS_H))
                freq_sel_rc32m <= pwdata[7:0];
            else if(start4rc32m && regulate_rc32m && (regulate_state_rc32m == 2'b10))
                freq_sel_rc32m <= next_freq_sel_rc32m;
        end

    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                regulate_rc32m_finish <= 1'b0;
            else if(regulate_rc32m_finish)
                regulate_rc32m_finish <= 1'b0;
            else if(once_regulate_rc32m_finish && (cnt_regulate_rc32m_finish == 3'b111))
                regulate_rc32m_finish <= 1'b1;
        end
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                cnt_regulate_rc32m_finish <= 3'b000;
            else if(once_regulate_rc32m_finish)
                begin
                    if(cnt_regulate_rc32m_finish == 3'b111)
                        cnt_regulate_rc32m_finish <= 3'b000;
                    else
                        cnt_regulate_rc32m_finish <= cnt_regulate_rc32m_finish + 3'b001;
                end
        end        
    
    //interrupt of rc32m_calib
    always@(posedge clk_rc32m or negedge prst_n)
        begin
            if(!prst_n)
                int_rc32m <= 1'b0;
            else if(apb_wr_en && (paddr == INT_H) && (pwdata == INT_CLR))
                int_rc32m <= 1'b0;
            else if(regulate_rc32m_finish)
                int_rc32m <= 1'b1;
        end

//============================================================//
//32k

    //
    always@(posedge clk_32k or negedge prst_n)
        begin
            if(!prst_n)
                cnt_clk_32k_rc32k <= 32'h0;
            else if(cnt_clk_32k_rc32k == (ref_value_rc32k-1))
                cnt_clk_32k_rc32k <= 32'h0;
            else
                cnt_clk_32k_rc32k <= cnt_clk_32k_rc32k + 32'h1;
        end

    always@(posedge clk_32k or negedge prst_n)
        begin
            if(!prst_n)
                clk_32k_rc32k <= 1'b0;
            else if((cnt_clk_32k_rc32k == (ref_value_rc32k[31:1]-1)) || (cnt_clk_32k_rc32k == (ref_value_rc32k-1)))
                clk_32k_rc32k <= ~clk_32k_rc32k;
        end    
    //generate time for rc32k
    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    clk_32k_sync_rc32k_d0 <= 1'b0;
                    clk_32k_sync_rc32k_d1 <= 1'b0;
                    clk_32k_sync_rc32k_d2 <= 1'b0;
                end
            else
                begin
                    //clk_32k_sync_rc32k_d0 <= clk_32k;
                    clk_32k_sync_rc32k_d0 <= clk_32k_rc32k;
                    clk_32k_sync_rc32k_d1 <= clk_32k_sync_rc32k_d0;
                    clk_32k_sync_rc32k_d2 <= clk_32k_sync_rc32k_d1;
                end
        end
    assign clk_32k_sync_rc32k_posedge =  clk_32k_sync_rc32k_d1 && ~clk_32k_sync_rc32k_d2;
    //assign clk_32k_sync_rc32k_negedge = ~clk_32k_sync_rc32k_d1 &&  clk_32k_sync_rc32k_d2;
    
    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                stable_rc32k <= 1'b1;//default rc32k is stable 
            else if(!start4rc32k)
                stable_rc32k <= 1'b1; 
            else if(start4rc32k && (cnt_stable_rc32k == STABLE_CY))
                stable_rc32k <= 1'b1; 
            else if(start4rc32k && once_regulate_rc32k_finish)
                stable_rc32k <= 1'b0; 
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                en_cnt_rc32k <= 1'b0; 
            else if(start4rc32k && en_cnt_rc32k && clk_32k_sync_rc32k_posedge && (cnt_num_standard_clk_rc32k == (num_standard_clk_rc32k-1)))
                en_cnt_rc32k <= 1'b0; 
            else if(start4rc32k && clk_32k_sync_rc32k_posedge && ~en_cnt_rc32k)
                en_cnt_rc32k <= 1'b1; 
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                cnt_stable_rc32k <= 8'h0; 
            else if(start4rc32k && ~stable_rc32k)
                begin
                    if(cnt_stable_rc32k == STABLE_CY)
                        cnt_stable_rc32k <= 8'h0; 
                    else
                        cnt_stable_rc32k <= cnt_stable_rc32k + 8'h1; 
                end
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                cnt_rc32k <= 32'h0;
            else if(en_cnt_rc32k)
                begin
                   //if(clk_32k_sync_rc32k_posedge)
                    if(en_cnt_rc32k && clk_32k_sync_rc32k_posedge && (cnt_num_standard_clk_rc32k == (num_standard_clk_rc32k-1)))
                       cnt_rc32k <= 32'h0;
                   else
                       cnt_rc32k <= cnt_rc32k + 32'h1;
                end
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                cnt_num_standard_clk_rc32k <= 16'h0;
            else if(en_cnt_rc32k && clk_32k_sync_rc32k_posedge)
                begin
                    if(cnt_num_standard_clk_rc32k == (num_standard_clk_rc32k-1))
                        cnt_num_standard_clk_rc32k <= 16'h0;
                    else
                        cnt_num_standard_clk_rc32k <= cnt_num_standard_clk_rc32k + 16'b1;
                end
        end

    //always@(posedge ref_value_rc32k or negedge prst_n)
    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                regulate_rc32k <= 1'b0;
            else if(once_regulate_rc32k_finish)
                regulate_rc32k <= 1'b0;
            else if(en_cnt_rc32k && clk_32k_sync_rc32k_posedge && (cnt_num_standard_clk_rc32k == (num_standard_clk_rc32k-1)))
                regulate_rc32k <= 1'b1;
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                final_value_rc32k <= 32'h0;
            //else if(en_cnt_rc32k && clk_32k_sync_rc32k_posedge)
            else if(en_cnt_rc32k && clk_32k_sync_rc32k_posedge && (cnt_num_standard_clk_rc32k == (num_standard_clk_rc32k-1)))
                final_value_rc32k <= cnt_rc32k;
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                regulate_state_rc32k <= 2'b00;
            else if(regulate_rc32k)
                begin
                    if(regulate_state_rc32k == 2'b10)
                        regulate_state_rc32k <= 2'b00;
                    else
                        regulate_state_rc32k <= regulate_state_rc32k + 2'b1;
                end
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                next_freq_sel_rc32k <= 4'b1000;
            else if(regulate_rc32k_finish)
                next_freq_sel_rc32k <= 4'b1000;
            else if(regulate_rc32k && (regulate_state_rc32k == 2'b00) && fast_rc32k)
                next_freq_sel_rc32k <= next_freq_sel_rc32k ^ shift_reg_rc32k;
            else if(regulate_rc32k && (regulate_state_rc32k == 2'b01))
                next_freq_sel_rc32k <= next_freq_sel_rc32k + shift_reg_rc32k;
        end
    //reagulate rc32k 
    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                shift_reg_rc32k <= 4'b1000;       
            else if(regulate_rc32k_finish)
                shift_reg_rc32k <= 4'b1000;       
            else if(regulate_rc32k && (regulate_state_rc32k == 2'b00))
                shift_reg_rc32k <= {1'b0,shift_reg_rc32k[3:1]};       
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                freq_sel_rc32k <= 4'b1000;
            else if(apb_wr_en && (paddr == SVS_L))
                freq_sel_rc32k <= pwdata[3:0];
            else if(start4rc32k && regulate_rc32k && (regulate_state_rc32k == 2'b10))
                freq_sel_rc32k <= next_freq_sel_rc32k;
        end

    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                regulate_rc32k_finish <= 1'b0;
            else if(regulate_rc32k_finish)
                regulate_rc32k_finish <= 1'b0;
            else if(once_regulate_rc32k_finish && (cnt_regulate_rc32k_finish == 2'b11))
                regulate_rc32k_finish <= 1'b1;
        end
    always@(posedge clk_rc32k or negedge prst_n)
        begin
            if(!prst_n)
                cnt_regulate_rc32k_finish <= 2'b00;
            else if(once_regulate_rc32k_finish)
                begin
                    if(cnt_regulate_rc32k_finish == 2'b11)
                        cnt_regulate_rc32k_finish <= 2'b00;
                    else
                        cnt_regulate_rc32k_finish <= cnt_regulate_rc32k_finish + 2'b01;
                end
        end        
    
    //interrupt of rc32k_calib
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    regulate_rc32k_finish_d0 <= 1'b0;
                    regulate_rc32k_finish_d1 <= 1'b0;
                    regulate_rc32k_finish_d2 <= 1'b0;
                end
            else
                begin
                    regulate_rc32k_finish_d0 <= regulate_rc32k_finish;
                    regulate_rc32k_finish_d1 <= regulate_rc32k_finish_d0;
                    regulate_rc32k_finish_d2 <= regulate_rc32k_finish_d1;
                end
        end

    assign regulate_rc32k_posedge = ~regulate_rc32k_finish_d2 && regulate_rc32k_finish_d1;
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                int_rc32k <= 1'b0;
            else if(apb_wr_en && (paddr == INT_L) && (pwdata == INT_CLR))
                int_rc32k <= 1'b0;
            else if(regulate_rc32k_posedge)
                int_rc32k <= 1'b1;
        end

endmodule //

