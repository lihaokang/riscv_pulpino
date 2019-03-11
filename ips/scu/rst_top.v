//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : reset_top                      //
//  Author       : zhaowt                         //
//  Description  : reset signal generator         //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module rst_top(
                pclk,
                prst_n,
                pwrite,
                psel,
                penable,
                paddr,
                pwdata,
                prdata,
                pready,
                clk_rc32m,
                rst_async_por_n,
                rst_async_key_n,
                rst_wdt_n,
                rst_por_n,
                chip_rst_n,
                rst_n
               );
    
    input         pclk,prst_n,pwrite,psel,penable;
    input  [7:0]  paddr;
    input  [31:0] pwdata;
    output        pready;
    output [31:0] prdata;
    input         rst_async_por_n,rst_async_key_n,rst_wdt_n;
    input         clk_rc32m;
    output        rst_por_n;
    output        rst_n;
    output        chip_rst_n;
    wire          rst_por_n,rst_key_n;
    wire          sw_rst_wr;
    wire          pready;
    wire          apb_wr_en,apb_rd_en;
    reg           rst_sw_n,rst_sw_n_d0,rst_sw_n_d1,rst_sw_trigger;
    reg    [3:0]  status_rst;
    reg    [31:0] prdata;
    reg           key_rst_pulse_d0;
    reg           wdt_rst_pulse_d0;
    reg           sw_rst_pulse_d0;
    wire          key_rst_pulse;
    wire          wdt_rst_pulse;
    wire          sw_rst_pulse;
    //==========control register list==============================//
    parameter     SRW_REG = 8'h00;//software reset write register,write only
    parameter     RRS_REG = 8'h04;//reset record status register,read only
    parameter     SRW_VAL = 32'h20190114; //write value for software reset
    //=============================================================//
    assign pready = 1'b1;
    assign apb_wr_en = psel && pwrite && penable;
    assign apb_rd_en = psel && ~pwrite && penable;
    assign rst_n = rst_por_n & rst_key_n & rst_wdt_n & rst_sw_n; 
    assign chip_rst_n = rst_por_n & rst_key_n; 
    assign sw_rst_wr = apb_wr_en && (paddr == SRW_REG) && (pwdata == SRW_VAL);

    always@(posedge pclk or negedge rst_n)
        begin
            if(!rst_n)
                rst_sw_trigger <= 1'b1;
            //else if(sw_rst_wr)
            else if(~rst_sw_trigger)
                rst_sw_trigger <= 1'b1;
            else if(sw_rst_wr)
                rst_sw_trigger <= 1'b0;
        end
    //always@(posedge pclk or negedge rst_sw_trigger)
    always@(posedge pclk or negedge rst_por_n)
        begin
            if(!rst_por_n)
                begin
                    rst_sw_n_d0 <= 1'b1;
                    rst_sw_n_d1 <= 1'b1;
                    rst_sw_n <= 1'b1;
                end
            else if(~rst_sw_trigger)
                begin
                    rst_sw_n_d0 <= 1'b0;
                    rst_sw_n_d1 <= 1'b0;
                    rst_sw_n <= 1'b1;
                end
            else
                begin
                    rst_sw_n_d0 <= 1'b1;
                    rst_sw_n_d1 <= rst_sw_n_d0;
                    rst_sw_n <= rst_sw_n_d1;
                end
        end
        
    always@(posedge pclk or negedge rst_por_n)
        begin
            if(!rst_por_n)
                begin
                    key_rst_pulse_d0 <= 1'b0;
                    wdt_rst_pulse_d0 <= 1'b0;
                    sw_rst_pulse_d0 <= 1'b0;
                end
            else
                begin
                    key_rst_pulse_d0 <= ~rst_key_n;
                    wdt_rst_pulse_d0 <= ~rst_wdt_n;
                    sw_rst_pulse_d0 <= ~rst_sw_n;
                end
        end
    assign key_rst_pulse = key_rst_pulse_d0 && rst_key_n;
    assign wdt_rst_pulse = wdt_rst_pulse_d0 && rst_wdt_n;
    assign sw_rst_pulse = sw_rst_pulse_d0 && rst_sw_n;

    always@(posedge pclk or negedge rst_por_n)
        begin
            if(!rst_por_n)
                status_rst <= 4'b0001;
            else if(key_rst_pulse)
                status_rst <= 4'b0010;
            else if(wdt_rst_pulse)
                status_rst <= 4'b0100;
            else if(sw_rst_pulse)
                status_rst <= 4'b1000;
        end
    always@(*)
        begin
            if(apb_rd_en)
                begin
                    case(paddr)
                        RRS_REG : prdata <= {28'h0,status_rst};
                        default : prdata <= 32'h0;
                    endcase
                end
            else
                prdata <= 32'h0;
        end
//por signal---Asynchronous reset synchronous release
rst_sync rst_por_sync(
                      .clk(clk_rc32m),
                      .rst_async_n(rst_async_por_n),
                      .rst_n(rst_por_n)
                     );
//key signal---Asynchronous reset synchronous release
rst_sync rst_key_sync(
                      .clk(pclk),
                      .rst_async_n(rst_async_key_n),
                      .rst_n(rst_key_n)
                    );

endmodule
