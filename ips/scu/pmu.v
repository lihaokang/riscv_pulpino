//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : pmu                            //
//  Author       : zhaowt                         //
//  Description  : power management unit          //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module pmu(
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
           clk_select,
           pd_ldo15,
           pd_v2i,
           pd_pvd,
           pvd_sel,
           pvd_in,
           atest_en,
           atest_sel
          );

    input         pclk,prst_n,pwrite,psel,penable,pvd_in;
    input  [7:0]  paddr;
    input  [31:0] pwdata;
    input  [2:0]  clk_select;
    output        pready;
    output [31:0] prdata;
    output        pd_ldo15,pd_v2i,pd_pvd;
    output [3:0]  pvd_sel;
    output        atest_en;
    output [1:0]  atest_sel;
    //==========control register list==============================//
    parameter     PD15_REG  = 8'h00;// Power Down 1.5V
                                    // 0 : no power down ---(default)
                                    // 1 : power down    ---(voltage=1.2V)
    parameter     VCS_REG   = 8'h04;// Voltage Current Status REGister,Read Only Register
    parameter     PDV2I_REG = 8'h08;// pd signal of bias current and reference voltage for ADC,LDO1P5 and PVD
    parameter     PDPVD_REG = 8'h0c;// pd signal for PVD block
    parameter     PVDSL_REG = 8'h10;// select signal of PVD reference voltage
    parameter     PVDIN_REG = 8'h14;// PVD input,read only
    parameter     ATEN_REG  = 8'h18;// analog test enable
    parameter     ATSEL_REG = 8'h1c;// analog test select
    //=============================================================//

    wire   [31:0] prdata;
    reg    [31:0] prdata_tmp;
    reg           pd_ldo15,pd_pvd,pd_v2i;
    reg           pvd_in_d0,pvd_in_d1;
    reg           vm_ready;//voltage mode select
    reg    [6:0]  vm_ready_cnt,cnt_num;
    reg    [3:0]  pvd_sel;
    reg           vm_ready_cnt_en;
    reg           atest_en;
    reg    [1:0]  atest_sel;
    wire          apb_wr_en,apb_rd_en;
    wire          power_switch;
    assign apb_wr_en = psel && pwrite && penable;
    assign apb_rd_en = psel && ~pwrite && penable;
    assign pready = 1'b1;
    assign power_switch = apb_wr_en && (paddr == PD15_REG);
    //APB BUS write operation
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                begin
                    pd_ldo15 <= 1'b0;
                    pd_pvd <= 1'b0;
                    pd_v2i <= 1'b0;
                    pvd_sel <= 4'b0000;
                    atest_en <= 1'b0;
                    atest_sel <= 2'b00;
                end
            else if(apb_wr_en)
                begin
                    if(paddr == PD15_REG)
                        pd_ldo15 <= pwdata[0];
                    else if(paddr == PDV2I_REG)
                        pd_v2i <= pwdata[0];
                    else if(paddr == PDPVD_REG)
                        pd_pvd <= pwdata[0];
                    else if(paddr == PVDSL_REG)
                        pvd_sel <= pwdata[3:0];
                    else if(paddr == ATEN_REG)
                        atest_en <= pwdata[0];
                    else if(paddr == ATSEL_REG)
                        atest_sel <= pwdata[1:0];
                end
        end
    //
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                vm_ready <= 1'b1;
            else if(power_switch)
                vm_ready <= 1'b0;
            else if(vm_ready_cnt == cnt_num)
                vm_ready <= 1'b1;
        end

    //APB BUS read operation
    always@(*)
        begin
            case(paddr)
                PD15_REG : prdata_tmp = {31'h0,pd_ldo15};
                VCS_REG  : prdata_tmp = {31'h0,vm_ready};
                PDV2I_REG: prdata_tmp = {31'h0,pd_v2i};
                PDPVD_REG: prdata_tmp = {31'h0,pd_pvd};
                PVDSL_REG: prdata_tmp = {28'h0,pvd_sel};
                PVDIN_REG: prdata_tmp = {31'h0,pvd_in_d1};
                ATEN_REG : prdata_tmp = {31'h0,atest_en};
                ATSEL_REG: prdata_tmp = {30'h0,atest_sel};
                default  : prdata_tmp = 32'h0;
            endcase
        end
    assign prdata = apb_rd_en ? prdata_tmp : 32'h0;
    //counter for ready signal
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                vm_ready_cnt_en <= 1'b0;
            else if(vm_ready_cnt == cnt_num)
                vm_ready_cnt_en <= 1'b0;
            else if(power_switch)
                vm_ready_cnt_en <= 1'b1;

        end

    always@(posedge pclk or negedge prst_n)//wait 3us after each power switch
        begin
            if(~prst_n)
                vm_ready_cnt <= 32'b0;
            else if(vm_ready_cnt_en && (vm_ready_cnt == cnt_num))
                vm_ready_cnt <= 32'b0;
            else if(vm_ready_cnt_en)
                vm_ready_cnt <= vm_ready_cnt + 32'b1;
        end    
    
    always@(*)
        begin
            case(clk_select)
                3'b000  : cnt_num <= 7'b110_0000;
                3'b001  : cnt_num <= 7'b011_0000;
                3'b010  : cnt_num <= 7'b001_1000;
                3'b011  : cnt_num <= 7'b000_1100;
                3'b100  : cnt_num <= 7'b000_0110;
                3'b101  : cnt_num <= 7'b000_0011;
                3'b110  : cnt_num <= 7'b000_0010;
                3'b111  : cnt_num <= 7'b000_0010;
                default : cnt_num <= 7'b110_0000;
            endcase
        end

    //sync pvd input

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pvd_in_d0 <= 1'b0;
                    pvd_in_d1 <= 1'b0;
                end
            else
                begin
                    pvd_in_d0 <= pvd_in;
                    pvd_in_d1 <= pvd_in_d0;
                end
        end

endmodule
