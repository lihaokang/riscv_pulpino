//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : cmu                            //
//  Author       : zhaowt                         //
//  Description  : clock management unit          //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module cmu(
           //APB BUS
           pclk,
           prst_n,
           pwrite,
           psel,
           penable,
           paddr,
           pwdata,
           prdata,
           pready,
           //
           clk_rc32m,
           clk_rc32k,
           clk_32k,
           clk_sys,
           clk_adc,
           clk_ls,
           rc32m_pd,
           rc32m_ready,
           rc32k_ready,
           clk_select,
           shortxixo,
           en_xtal32k,
           ext_en_xtal32k,
           rst_por_n,
           clk_test,
           scan_en,
           scan_clk,
           scan_mode
          );

    input         pclk,prst_n,pwrite,psel,penable;
    input  [7:0]  paddr;
    input  [31:0] pwdata;
    output        pready;
    output [31:0] prdata;

    input         clk_rc32m,clk_rc32k,clk_32k;
    output        clk_sys,clk_adc,clk_ls;

    input         rc32m_ready,rc32k_ready;
    output        rc32m_pd;

    output [2:0]  clk_select;

    output        shortxixo;

    output        en_xtal32k,ext_en_xtal32k;

    input         rst_por_n;

    output        clk_test;

    input         scan_en;
    input         scan_clk;
    input         scan_mode;

    wire   [31:0] prdata;
    reg    [31:0] prdata_tmp;
    reg    [2:0]  rc32m_cnt;
    reg           rc32m_cnt_en;
    reg           rc32m_pd;
    reg           clk_test;
    wire   [2:0]  clk_status;
    wire          clk_adc;
    wire          clk_sys0,clk_sys1;
    wire          clk_32m_16m,clk_8m_4m,clk_2m_1m,clk_rc32k_32k;
    wire          apb_wr_en,apb_rd_en;
    wire          clk_adc_0_0,clk_adc_0_1;
    wire          clk_adc_0,clk_adc_1;
    wire          clk_sys_tmp;
    //==========control register list==============================//
    parameter     SCS_REG = 8'h00;           // system clock source
    parameter     LCS_REG = 8'h04;           // low speed clock source
    parameter     ACS_REG = 8'h08;           // adc clock source
    parameter     HCM_REG = 8'h0c;           // high clock mode,(write only),32'h1234_5678:power on rc32m
    parameter     CSS_REG = 8'h10;           // clock source status(read only)
                                                     // 0 : not ready   1 : ready
    parameter     SIO_REG = 8'h14;           // short XI XO
    parameter     ECS_REG = 8'h18;           // external clock select        //----00 : disable
                                                     // {EN_XTAL32K,EXT_EN_XTAL32K} //    01 : disable
                                                     //                             //    10 : crystal 32K
                                                     //                             //    11 : ext CLK
    parameter     TCS_REG = 8'h1c;           // Test Clock Select
                                                     // 4'b1000:  clk_rc32m
                                                     // 4'b1001:  clk_rc32k
                                                     // 4'b1010:  clk_32k(include xtal32k & others)
                                                     // 4'b1011:  clk_sys
                                                     // 4'b1100:  clk_ls
                                                     // 4'b1101:  clk_adc
                                                     
    parameter     HCM_PO = 32'h1234_5678;            // rc32m power on command
    parameter     HCM_PD = 32'h3141_5926;            // rc32m power down command
    parameter     CRYSTAL32K_WAIT_CYCLE = 21'h155CC0;// crystal wait time
    parameter     CRYSTAL32K_WAIT_CYCLE_SIM = 21'h8c;// just4sim
    //=============================================================//

    reg    [20:0] ext32k_ready_cnt;
    wire          ext32k_ready_1M;
    reg           ext32k_ready_cnt_en;

    reg    [2:0]  sys_clk_src;
    reg    [2:0]  sys_clk_select;
    reg           low_speed_clk_src;
    reg    [2:0]  clk_adc_src;
    wire          sys_clk_switch,low_speed_clk_switch,adc_clk_switch;
    //wire          sys_clk_select_32k;
    wire          sys_clk_select_32m;
    wire          clk_div1,clk_div2,clk_div4,clk_div8,clk_div16,clk_div32;
    reg           rc32m_ready_d0,rc32m_ready_d1,rc32m_ready_d2;
    reg           rc32k_ready_d0,rc32k_ready_d1,rc32k_ready_d2;
    reg           ext32k_ready_d0,ext32k_ready_d1,ext32k_ready_d2;
    reg           apb_wr_rc32m_pd;
    reg           shortxixo;
    reg           en_xtal32k,ext_en_xtal32k;
    reg    [3:0]  clk_test_select;

    wire          clk_32k_n,clk_rc32k_n;
    wire          clk_sys0_n,clk_sys1_n,clk_rc32k_32k_n,clk_2m_1m_n,clk_8m_4m_n,clk_32m_16m_n;
    wire          clk_adc_0_n,clk_adc_1_n,clk_adc_0_1_n,clk_adc_0_0_n;

    assign sys_clk_switch = apb_wr_en && (paddr == SCS_REG);
    assign low_speed_clk_switch = apb_wr_en && (paddr == LCS_REG);
    assign adc_clk_switch = apb_wr_en && (paddr == ACS_REG);
    
    //assign sys_clk_select_32k = sys_clk_switch && ((pwdata[2:0] == 32'h6) | (pwdata[2:0] == 32'h7));
    assign sys_clk_select_32m = sys_clk_switch && (pwdata[2:0] <=3'b101);
    assign clk_select = sys_clk_src;
    
    assign apb_wr_en = psel && pwrite && penable;
    assign apb_rd_en = psel && ~pwrite && penable;
    assign pready = 1'b1;
    //APB BUS write operation
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                begin
                    low_speed_clk_src <= 1'b0;
                    clk_adc_src <= 3'b000;
                    sys_clk_src <= 3'b000;
                    shortxixo <= 1'b0;
                    en_xtal32k <= 1'b0;
                    ext_en_xtal32k <= 1'b0;
                    clk_test_select <= 4'b0000;
                end
            else if(apb_wr_en)
                begin
                    if(paddr == SCS_REG)
                        sys_clk_src <= pwdata[2:0];
                    else if(paddr == LCS_REG)
                        low_speed_clk_src <= pwdata[0];
                    else if(paddr == ACS_REG)
                        clk_adc_src <= pwdata[2:0];
                    else if(paddr == SIO_REG)
                        shortxixo <= pwdata[0];
                    else if(paddr == ECS_REG)
                        {en_xtal32k,ext_en_xtal32k} <= pwdata[1:0];
                    else if(paddr == TCS_REG)
                        clk_test_select <= pwdata[3:0];
                end
        end

    //APB BUS read operation
    always@(*)
        begin
            case(paddr)
                SCS_REG : prdata_tmp = {29'h0,sys_clk_src};
                LCS_REG : prdata_tmp = {31'b0,low_speed_clk_src};
                ACS_REG : prdata_tmp = {29'h0,clk_adc_src};
                CSS_REG : prdata_tmp = {28'h0,rc32m_pd,clk_status};
                SIO_REG : prdata_tmp = {31'h0,shortxixo};
                ECS_REG : prdata_tmp = {30'h0,en_xtal32k,ext_en_xtal32k};
                TCS_REG : prdata_tmp = {28'h0,clk_test_select};
                default : prdata_tmp = 32'h0;
            endcase
        end
    assign prdata = apb_rd_en ? prdata_tmp : 32'h0;

    //===========================//
    //   high speed clk divider  //
    //===========================//
clk_div clk_hs_divider(
                       .clk(clk_rc32m),
                       //.rst_n(prst_n),
                       .rst_n(rst_por_n),
                       .clk_div1(clk_div1),
                       .clk_div2(clk_div2),
                       .clk_div4(clk_div4),
                       .clk_div8(clk_div8),
                       .clk_div16(clk_div16),
                       .clk_div32(clk_div32)
                      );

clk_inv6 clk_inv6_u0(
                     .clk0(clk_div1),
                     .clk1(clk_div2),
                     .clk2(clk_div4),
                     .clk3(clk_div8),
                     .clk4(clk_div16),
                     .clk5(clk_div32),
                     .clk0_n(clk_div1_n),
                     .clk1_n(clk_div2_n),
                     .clk2_n(clk_div4_n),
                     .clk3_n(clk_div8_n),
                     .clk4_n(clk_div16_n),
                     .clk5_n(clk_div32_n)
                    );

    //===========================//
    //    system clk select      //
    //===========================//

    //===========================//
    //      sys clk switch       //
    //===========================//

    //===================================================
    //sys_clk_src[2:0]  000    : internal high 32MHz
    //                  001    : internal high 16MHz
    //                  010    : internal high 8MHz
    //                  011    : internal high 4MHz 
    //                  100    : internal high 2MHz 
    //                  101    : internal high 1MHz 
    //                  110    : internal low speed clock 
    //                  111    : external low speed clock 
    //===================================================

    //por


    always@(posedge pclk or negedge rst_por_n)
        begin
            if(!rst_por_n)
                sys_clk_select <= 3'b000;
            else if(rc32m_ready_d2 && (sys_clk_src <= 3'b101))
                sys_clk_select <= sys_clk_src;
            else if(rc32k_ready_d2 && (sys_clk_src >= 3'b110))
                sys_clk_select <= sys_clk_src;
        end

clk_switch clk_sys_switch0_0(
                             .rst_n(rst_por_n),
                             .clk0(clk_div1), 
                             .clk0_n(clk_div1_n),
                             .clk1(clk_div2), 
                             .clk1_n(clk_div2_n),
                             .sel_clk(sys_clk_select[0] && (~sys_clk_select[1]) && (~sys_clk_select[2])),
                             .clk_o(clk_32m_16m)
                            );
clk_switch clk_sys_switch0_1(
                             .rst_n(rst_por_n),
                             .clk0(clk_div4),
                             .clk0_n(clk_div4_n),
                             .clk1(clk_div8),
                             .clk1_n(clk_div8_n),
                             .sel_clk(sys_clk_select[0] && sys_clk_select[1] && (~sys_clk_select[2])),
                             .clk_o(clk_8m_4m)
                            );
clk_switch clk_sys_switch0_2(
                             .rst_n(rst_por_n),
                             .clk0(clk_div16),
                             .clk0_n(clk_div16_n),
                             .clk1(clk_div32),
                             .clk1_n(clk_div32_n),
                             .sel_clk(sys_clk_select[0] && (~sys_clk_select[1]) && sys_clk_select[2]),
                             .clk_o(clk_2m_1m)
                            );
clk_switch clk_sys_switch0_3(
                             .rst_n(rst_por_n),
                             .clk0(clk_rc32k),
                             .clk0_n(clk_rc32k_n),
                             .clk1(clk_32k),
                             .clk1_n(clk_32k_n),
                             .sel_clk(sys_clk_select[0] && sys_clk_select[1] && sys_clk_select[2]),
                             .clk_o(clk_rc32k_32k)
                            );
clk_switch clk_sys_switch1_0(
                             .rst_n(rst_por_n),
                             .clk0(clk_32m_16m),
                             .clk0_n(clk_32m_16m_n),
                             .clk1(clk_8m_4m),
                             .clk1_n(clk_8m_4m_n),
                             .sel_clk(sys_clk_select[1] && (~sys_clk_select[2])),
                             .clk_o(clk_sys0)
                            );
clk_switch clk_sys_switch1_1(
                             .rst_n(rst_por_n),
                             .clk0(clk_2m_1m), 
                             .clk0_n(clk_2m_1m_n), 
                             .clk1(clk_rc32k_32k), 
                             .clk1_n(clk_rc32k_32k_n), 
                             .sel_clk(sys_clk_select[1] && sys_clk_select[2]), 
                             .clk_o(clk_sys1)
                            );
clk_switch clk_sys_switch2_0(
                             .rst_n(rst_por_n),
                             .clk0(clk_sys0), 
                             .clk0_n(clk_sys0_n), 
                             .clk1(clk_sys1), 
                             .clk1_n(clk_sys1_n), 
                             .sel_clk(sys_clk_select[2]), 
                             .clk_o(clk_sys_tmp)
                            );


    //assign  clk_sys0_n = ~clk_sys0;
    //assign  clk_sys1_n = ~clk_sys1;
    //assign  clk_rc32k_32k_n = ~clk_rc32k_32k;
    //assign  clk_2m_1m_n = ~clk_2m_1m;
    //assign  clk_8m_4m_n = ~clk_8m_4m;
    //assign  clk_32m_16m_n = ~clk_32m_16m;
    //assign  clk_32k_n = ~clk_32k;
    //assign  clk_rc32k_n = ~clk_rc32k;

    CKINVM12HM inv_u0( 
                      .Z(clk_sys0_n), 
                      .A(clk_sys0) 
                     );

    CKINVM12HM inv_u1( 
                      .Z(clk_sys1_n), 
                      .A(clk_sys1) 
                     );
    CKINVM12HM inv_u2( 
                      .Z(clk_rc32k_32k_n), 
                      .A(clk_rc32k_32k) 
                     );
    CKINVM12HM inv_u3( 
                      .Z(clk_2m_1m_n), 
                      .A(clk_2m_1m) 
                     );
    CKINVM12HM inv_u4( 
                      .Z(clk_8m_4m_n), 
                      .A(clk_8m_4m) 
                     );
    CKINVM12HM inv_u5( 
                      .Z(clk_32m_16m_n), 
                      .A(clk_32m_16m) 
                     );
    CKINVM12HM inv_u6( 
                      .Z(clk_32k_n), 
                      .A(clk_32k) 
                     );
    CKINVM12HM inv_u7( 
                      .Z(clk_rc32k_n), 
                      .A(clk_rc32k) 
                     );
    //===========================//
    //      adc clk select       //
    //===========================//

    //===================================================
    //clk_adc_src[2:0]        3'b000  : 32M
    //clk_adc_src[2:0]        3'b001  : 16M
    //clk_adc_src[2:0]        3'b010  : 8M
    //clk_adc_src[2:0]        3'b011  : 4M
    //clk_adc_src[2:0]        3'b100  : 2M
    //clk_adc_src[2:0]        3'b101  : 1M
    //clk_adc_src[2:0]        3'b110  : 2M
    //clk_adc_src[2:0]        3'b111  : 1M
    //===================================================
    reg [2:0] clk_adc_select;
    always@(*)
        begin
            case(clk_adc_src)
                3'b000  :  clk_adc_select <= 3'b000;
                3'b001  :  clk_adc_select <= 3'b001; 
                3'b010  :  clk_adc_select <= 3'b010;  
                3'b011  :  clk_adc_select <= 3'b011;
                3'b100  :  clk_adc_select <= 3'b100;
                3'b101  :  clk_adc_select <= 3'b101;
                default :  clk_adc_select <= 3'b000;
            endcase
        end
clk_switch adc_sys_switch0_0(
                          .rst_n(prst_n),
                          .clk0(clk_div1), 
                          .clk0_n(clk_div1_n), 
                          .clk1(clk_div2), 
                          .clk1_n(clk_div2_n), 
                          .sel_clk(clk_adc_select[0] && (~clk_adc_select[1]) && (~clk_adc_select[2])), 
                          .clk_o(clk_adc_0_0)
                         );

clk_switch adc_sys_switch0_1(
                          .rst_n(prst_n),
                          .clk0(clk_div4), 
                          .clk0_n(clk_div4_n), 
                          .clk1(clk_div8), 
                          .clk1_n(clk_div8_n), 
                          .sel_clk(clk_adc_select[0] && clk_adc_select[1] && (~clk_adc_select[2])), 
                          .clk_o(clk_adc_0_1)
                         );

clk_switch adc_sys_switch0_2(
                          .rst_n(prst_n),
                          .clk0(clk_div16), 
                          .clk0_n(clk_div16_n), 
                          .clk1(clk_div32), 
                          .clk1_n(clk_div32_n), 
                          .sel_clk(clk_adc_select[0] && clk_adc_select[2]), 
                          .clk_o(clk_adc_1)
                         );

clk_switch adc_sys_switch1_0(
                          .rst_n(prst_n),
                          .clk0(clk_adc_0_0), 
                          .clk0_n(clk_adc_0_0_n), 
                          .clk1(clk_adc_0_1), 
                          .clk1_n(clk_adc_0_1_n), 
                          .sel_clk(clk_adc_select[1] && (~clk_adc_select[2])), 
                          .clk_o(clk_adc_0)
                         );

clk_switch adc_sys_switch2_0(
                          .rst_n(prst_n),
                          .clk0(clk_adc_0), 
                          .clk0_n(clk_adc_0_n), 
                          .clk1(clk_adc_1), 
                          .clk1_n(clk_adc_1_n), 
                          .sel_clk(clk_adc_select[2]), 
                          .clk_o(clk_adc)
                         );

    assign clk_adc_0_n = ~clk_adc_0;
    assign clk_adc_1_n = ~clk_adc_1;
    assign clk_adc_0_1_n = ~clk_adc_0_1;
    assign clk_adc_0_0_n = ~clk_adc_0_0;

    //===========================//
    //    low speed clk select   //
    //===========================//

    //===================================================
    //low_speed_clk_src        0  : clk_rc32k
    //low_speed_clk_src        1  : clk_32k
    //===================================================

clk_switch clk_ls_switch(
                       .rst_n(prst_n),
                       .clk0(clk_rc32k), 
                       .clk0_n(clk_rc32k_n), 
                       .clk1(clk_32k), 
                       .clk1_n(clk_32k_n), 
                       .sel_clk(low_speed_clk_src), 
                       .clk_o(clk_ls)
                      );
    

    //===============================//
    // rc32m power supply management //
    //===============================//
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                apb_wr_rc32m_pd <= 1'b0;
            else if(apb_wr_rc32m_pd && (rc32m_cnt == 3'b111))
                apb_wr_rc32m_pd <= 1'b0;
            else if(apb_wr_en && (paddr == HCM_REG) && (pwdata == HCM_PD))
                apb_wr_rc32m_pd <= 1'b1;
        end    
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                rc32m_pd <= 1'b0;
            else if(apb_wr_en && (paddr == HCM_REG) && (pwdata == HCM_PO))
                rc32m_pd <= 1'b0;
            else if((rc32m_cnt == 3'b111) && (apb_wr_rc32m_pd))
                rc32m_pd <= 1'b1;
        end
    
    //==============================//
    //   osc clock status,1:ready   //
    //==============================//
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    rc32m_ready_d0 <= 1'b0;
                    rc32m_ready_d1 <= 1'b0;
                    rc32m_ready_d2 <= 1'b0;
                end
            else 
                begin
                    rc32m_ready_d0 <= rc32m_ready;
                    rc32m_ready_d1 <= rc32m_ready_d0;
                    rc32m_ready_d2 <= rc32m_ready_d1;
                end
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    rc32k_ready_d0 <= 1'b0;
                    rc32k_ready_d1 <= 1'b0;
                    rc32k_ready_d2 <= 1'b0;
                end
            else 
                begin
                    rc32k_ready_d0 <= rc32k_ready;
                    rc32k_ready_d1 <= rc32k_ready_d0;
                    rc32k_ready_d2 <= rc32k_ready_d1;
                end
        end
    assign clk_status = {ext32k_ready_d2,rc32k_ready_d2,rc32m_ready_d2};
    

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                rc32m_cnt_en <= 1'b0;
            else if((rc32m_cnt == 3'b111) && apb_wr_rc32m_pd)
                rc32m_cnt_en <= 1'b0;
            //else if(sys_clk_select_32k)
            else if(apb_wr_rc32m_pd)
                rc32m_cnt_en <= 1'b1;
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                rc32m_cnt <= 3'b000;
            else if(rc32m_cnt_en)
                begin
                    if(rc32m_cnt == 3'b111)
                        begin
                            if(apb_wr_rc32m_pd)
                                rc32m_cnt <= 3'b000;
                            else
                                rc32m_cnt <= rc32m_cnt;
                        end
                    else
                        rc32m_cnt <= rc32m_cnt + 3'b1;
                end
        end

    //==================================//
    //   crystal clock status,1:ready   //
    //==================================//
    
    wire   xtal32k_select,ext_clk_select;
    reg    ext32k_ready_cnt_en_d0,ext32k_ready_cnt_en_d1;

    assign xtal32k_select = en_xtal32k && ~ext_en_xtal32k;
    assign ext_clk_select = en_xtal32k && ext_en_xtal32k;
    
    always@(posedge clk_div32 or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    ext32k_ready_cnt_en_d0 <= 1'b0;
                    ext32k_ready_cnt_en_d1 <= 1'b0;
                    ext32k_ready_cnt_en <= 1'b0;
                end
            else
                begin
                    ext32k_ready_cnt_en_d0 <= xtal32k_select;
                    ext32k_ready_cnt_en_d1 <= ext32k_ready_cnt_en_d0;
                    ext32k_ready_cnt_en <= ext32k_ready_cnt_en_d1;
                end
        end

    always@(posedge clk_div32 or negedge prst_n)
        begin
            if(!prst_n)
                ext32k_ready_cnt <= 21'h0;
            else if(~ext32k_ready_cnt_en)//not select xtal32768
                ext32k_ready_cnt <= 21'h0;
            else if(ext32k_ready_cnt_en && (ext32k_ready_cnt < CRYSTAL32K_WAIT_CYCLE))
                ext32k_ready_cnt <= ext32k_ready_cnt + 21'h1;
        end
    assign ext32k_ready_1M = (ext32k_ready_cnt == CRYSTAL32K_WAIT_CYCLE);
    //sync signals to system clk
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    ext32k_ready_d0 <= 1'b0;
                    ext32k_ready_d1 <= 1'b0;
                    ext32k_ready_d2 <= 1'b0;
                end
            else
                begin
                    ext32k_ready_d0 <= ext32k_ready_1M;
                    ext32k_ready_d1 <= ext32k_ready_d0;
                    ext32k_ready_d2 <= ext32k_ready_d1;
                end
        end

    //test clock select
    //===============================================//
    // 4'b1000:  clk_rc32m
    // 4'b1001:  clk_rc32k
    // 4'b1010:  clk_32k(include xtal32k & others)
    // 4'b1011:  clk_sys
    // 4'b1100:  clk_ls
    // 4'b1101:  clk_adc
    //===============================================//
    always@(*)
        begin
            case(clk_test_select)
                4'b1000 : clk_test <= clk_rc32m;
                4'b1001 : clk_test <= clk_rc32k; 
                4'b1010 : clk_test <= clk_32k; 
                4'b1011 : clk_test <= clk_sys; 
                4'b1100 : clk_test <= clk_ls; 
                4'b1101 : clk_test <= clk_adc; 
                default : clk_test <= 1'b0; 
            endcase
        end


    //fast clock pulse generation
    wire clock_gating;
    wire clk_scan_out;
    reg  scan_en_d0_sclk;
    reg  scan_en_d0_32m;
    reg  scan_en_d1_32m;
    reg  scan_en_d2_32m;
    reg  scan_en_d3_32m;
    reg  scan_en_d4_32m;
    always@(posedge scan_clk or negedge prst_n)
        begin
            if(!prst_n)
                scan_en_d0_sclk <= 1'b0;
            else
                scan_en_d0_sclk <= ~scan_en;
        end

    always@(posedge clk_div1 or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    scan_en_d0_32m <= 1'b0;
                    scan_en_d1_32m <= 1'b0;
                    scan_en_d2_32m <= 1'b0;
                    scan_en_d3_32m <= 1'b0;
                    scan_en_d4_32m <= 1'b0;
                end
            else
                begin
                    scan_en_d0_32m <= scan_en_d0_sclk;
                    scan_en_d1_32m <= scan_en_d0_32m;
                    scan_en_d2_32m <= scan_en_d1_32m;
                    scan_en_d3_32m <= scan_en_d2_32m;
                    scan_en_d4_32m <= scan_en_d3_32m;
                end

        end
    assign clock_gating = scan_en_d2_32m & ~scan_en_d4_32m;   
    assign clk_scan_out = scan_en ? scan_clk : (clock_gating & clk_div1);
    
    assign clk_sys = scan_mode ? clk_scan_out : clk_sys_tmp;


endmodule
