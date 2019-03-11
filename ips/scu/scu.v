//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : scu                            //
//  Author       : zhaowt                         //
//  Description  : system control unit            //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module scu(
           pclk,
           prst_n,
           pwrite,
           psel,
           penable,
           paddr,
           pwdata,
           prdata,
           pready,
           pslverr,
           //rmu
           rst_async_por_n,//por in
           rst_async_key_n,//ext rst in
           rst_wdt_n,//wdt rst in
           rst_n,
           chip_rst_n,
           //pmu
           pd_ldo15,//voltage mode select
           pd_v2i,
           pd_pvd,
           pvd_in,
           pvd_sel,
           atest_en,
           atest_sel,
            //cmu
           clk_rc32m,
           clk_rc32k,
           clk_32k,//ext crystal
           clk_sys,//system clock
           clk_adc,//adc clock
           clk_ls,//low-speed clock
           rc32m_pd,//power down
           rc32m_ready,
           rc32k_ready,
           shortxixo,
           en_xtal32k,
           ext_en_xtal32k,
           clk_test
          );
    //APB BUS signals
    input         pclk,prst_n,pwrite,psel,penable;
    input  [31:0] paddr,pwdata;
    output        pready;
    output        pslverr;
    output [31:0] prdata;

    //*****************************************************************//
    //slv0 IO
    input         rst_async_por_n,rst_async_key_n,rst_wdt_n;
    output        rst_n, chip_rst_n;

    //slv1 IO
    input         pvd_in;
    output        pd_ldo15;
    output        pd_v2i,pd_pvd;
    output [3:0]  pvd_sel;
    output        atest_en;
    output [1:0]  atest_sel;
    //slv2 IO
    input         clk_rc32m,clk_rc32k,clk_32k;
    input         rc32m_ready,rc32k_ready;
    output        clk_sys,clk_adc,clk_ls,rc32m_pd;
    output        shortxixo,en_xtal32k,ext_en_xtal32k;
    output        clk_test;

    //*****************************************************************//
    //apb signals
    wire          pclk,prst_n,pwrite,psel,penable,pready;
    wire   [31:0] paddr,pwdata,prdata;
    //slv0 signals
    wire          pwrite0,psel0,penable0,pready0;
    wire   [7:0]  paddr0;

    wire   [31:0] pwdata0,prdata0;
    wire          rst_async_por_n,rst_async_key_n,rst_wdt_n,rst_n,chip_rst_n;
    wire          rst_por_n;
    wire          clk_test;

    //slv1 signals
    wire          pwrite1,psel1,penable1,pready1;
    wire   [7:0]  paddr1;
    wire   [31:0] pwdata1,prdata1;

    wire          pd_ldo15;      
    wire   [2:0]  clk_select;
    wire          pd_v2i,pd_pvd,pvd_in;
    wire   [3:0]  pvd_sel;
    wire          atest_en;
    wire   [1:0]  atest_sel;
    //slv2 signals
    wire          pwrite2,psel2,penable2,pready2;
    wire   [7:0]  paddr2;
    wire   [31:0] pwdata2,prdata2;

    wire          clk_rc32m,clk_rc32k,clk_32k,clk_sys,clk_adc,clk_ls;
    wire          rc32m_pd,rc32m_ready,rc32k_ready;
    wire          shortxixo,en_xtal32k,ext_en_xtal32k;
    
    //slv0 instance
rst_top rst_top_u0(
                   .pclk(pclk),
                   .prst_n(prst_n),
                   .pwrite(pwrite0),
                   .psel(psel0),
                   .penable(penable0),
                   .paddr(paddr0),
                   .pwdata(pwdata0),
                   .prdata(prdata0),
                   .pready(pready0),
                   .clk_rc32m(clk_rc32m),
                   .rst_async_por_n(rst_async_por_n),
                   .rst_async_key_n(rst_async_key_n),
                   .rst_wdt_n(rst_wdt_n),
                   .rst_por_n(rst_por_n),
                   .chip_rst_n(chip_rst_n),
                   .rst_n(rst_n)
                  );
    //slv1 instance
pmu         pmu_u0(
                   .pclk(pclk),
                   .prst_n(prst_n),
                   .pwrite(pwrite1),
                   .psel(psel1),
                   .penable(penable1),
                   .paddr(paddr1),
                   .pwdata(pwdata1),
                   .prdata(prdata1),
                   .pready(pready1),
                   //
                   .clk_select(clk_select),//from cmu
                   .pd_ldo15(pd_ldo15),//to ext  
                   .pd_v2i(pd_v2i),
                   .pd_pvd(pd_pvd),
                   .pvd_sel(pvd_sel),
                   .pvd_in(pvd_in),
                   .atest_en(atest_en),
                   .atest_sel(atest_sel)
                  );
    //slv2 instance
cmu         cmu_u0(
                   .pclk(pclk),
                   .prst_n(prst_n),
                   .pwrite(pwrite2),
                   .psel(psel2),
                   .penable(penable2),
                   .paddr(paddr2),
                   .pwdata(pwdata2),
                   .prdata(prdata2),
                   .pready(pready2),
                   .clk_rc32m(clk_rc32m),
                   .clk_rc32k(clk_rc32k),
                   .clk_32k(clk_32k),
                   .clk_sys(clk_sys),
                   .clk_adc(clk_adc),
                   .clk_ls(clk_ls),
                   .rc32m_pd(rc32m_pd),
                   .rc32m_ready(rc32m_ready),
                   .rc32k_ready(rc32k_ready),
                   .clk_select(clk_select),
                   .shortxixo(shortxixo),
                   .en_xtal32k(en_xtal32k),
                   .ext_en_xtal32k(ext_en_xtal32k),
                   .rst_por_n(rst_por_n),
                   .clk_test(clk_test)
                  );


apb_bus_dec apb_bus_dec_u0(
                   .pwrite(pwrite),
                   .psel(psel),
                   .penable(penable),
                   .pready(pready),
                   .paddr(paddr),
                   .pwdata(pwdata),
                   .prdata(prdata),
                   //slv0
                   .pwrite0(pwrite0),
                   .psel0(psel0),
                   .penable0(penable0),
                   .pready0(pready0),
                   .pwdata0(pwdata0),
                   .prdata0(prdata0),
                   .paddr0(paddr0),
                   //slv1
                   .pwrite1(pwrite1),
                   .psel1(psel1),
                   .penable1(penable1),
                   .pready1(pready1),
                   .pwdata1(pwdata1),
                   .prdata1(prdata1),
                   .paddr1(paddr1),
                   //slv2
                   .pwrite2(pwrite2),
                   .psel2(psel2),
                   .penable2(penable2),
                   .pready2(pready2),
                   .pwdata2(pwdata2),
                   .prdata2(prdata2),
                   .paddr2(paddr2)
                  );


assign pslverr = 1'b0;
endmodule
