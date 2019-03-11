//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : reset_sync                     //
//  Author       : zhaowt                         //
//  Description  : reset signal sync              //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module rst_sync(
                 clk,
                 rst_async_n,
                 rst_n
                );
    
    input    clk,rst_async_n;
    output   rst_n;
    
    reg      sync_rst_d0,sync_rst_d1;
    
    always@(posedge clk or negedge rst_async_n)
        begin
            if(~rst_async_n)
                begin
                    sync_rst_d0 <= 1'b0;
                    sync_rst_d1 <= 1'b0;
                end
            else
                begin
                    sync_rst_d0 <= 1'b1;
                    sync_rst_d1 <= sync_rst_d0;
                end
        end
    
    assign rst_n = sync_rst_d1;
endmodule
