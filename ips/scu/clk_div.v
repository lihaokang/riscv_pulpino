//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //       
//  File Name    : clk_div                        //
//  Author       : zhaowt                         //
//  Description  : clock divider                  //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module clk_div(
               clk,
               rst_n,
               clk_div1,
               clk_div2,
               clk_div4,
               clk_div8,
               clk_div16,
               clk_div32
              );

    input         clk,rst_n;
    output        clk_div1,clk_div2,clk_div4,clk_div8,clk_div16,clk_div32;

    reg    [8:0] clk_cnt; 

    always@(posedge clk or negedge rst_n)
        begin
            if(~rst_n)
                clk_cnt <= 9'h0;
            else
                clk_cnt <= clk_cnt + 9'b1;
        end
    
    assign {clk_div32,clk_div16,clk_div8,clk_div4,clk_div2,clk_div1} = {clk_cnt[4:0],clk&rst_n};

endmodule
