//====================//
//                    //
//====================//
module clk_switch (
                    rst_n,
                    clk0, 
                    clk0_n,
                    clk1, 
                    clk1_n,
                    sel_clk, 
                    clk_o
                   );
    //in/output
    input  rst_n;
    input  clk0;
    input  clk0_n;
    input  clk1;
    input  clk1_n;
    input  sel_clk;
    output clk_o;
    //register
    reg    sel_clk0_d0;
    reg    sel_clk0_d1;
    reg    sel_clk0_dly1;
    reg    sel_clk0_dly2 ;
    reg    sel_clk0_dly3;
    reg    sel_clk1_d0;
    reg    sel_clk1_d1;
    reg    sel_clk1_dly1;
    reg    sel_clk1_dly2;
    reg    sel_clk1_dly3;
    
    wire   clk0_n,clk1_n;
    wire   clk0_g,clk1_g;
    wire   clk_o;
    //part1
    always@(posedge clk0 or negedge rst_n)
        begin
            if(!rst_n) 
                begin
                    sel_clk0_d0 <= 1'b1;
                    sel_clk0_d1 <= 1'b1;
                end
            else 
                begin
                    sel_clk0_d0 <= (~sel_clk) & (~sel_clk1_dly3);
                    sel_clk0_d1 <= sel_clk0_d0;
                end
        end

    // part2
    always@(posedge clk0_n or negedge rst_n)
    //always@(posedge clk0 or negedge rst_n)
        begin
            if(!rst_n) 
                begin
                    sel_clk0_dly1 <= 1'b1;
                    sel_clk0_dly2 <= 1'b1;
                    sel_clk0_dly3 <= 1'b1;
                end
            else 
                begin
                    sel_clk0_dly1 <= sel_clk0_d1;
                    sel_clk0_dly2 <= sel_clk0_dly1;
                    sel_clk0_dly3 <= sel_clk0_dly2;
                end
        end
    // part3
    always@(posedge clk1 or negedge rst_n)
        begin
            if(!rst_n) 
                begin
                    sel_clk1_d0 <= 1'b0;
                    sel_clk1_d1 <= 1'b0;
                end
            else 
                begin
                    sel_clk1_d0 <= sel_clk & (~sel_clk0_dly3);
                    sel_clk1_d1 <= sel_clk1_d0;
                end
        end
    
    // part4
    always @ (posedge clk1_n or negedge rst_n)
    //always @ (posedge clk1 or negedge rst_n)
    begin
       if(!rst_n) 
           begin
               sel_clk1_dly1 <= 1'b0;
               sel_clk1_dly2 <= 1'b0;
               sel_clk1_dly3 <= 1'b0;
           end
    else 
        begin
            sel_clk1_dly1 <= sel_clk1_d1;
            sel_clk1_dly2 <= sel_clk1_dly1;
            sel_clk1_dly3 <= sel_clk1_dly2;
        end
    end
    
    // part5
    //clk_gate_xxx clk_gate_a ( .CP(clk0), .EN(sel_clk0_dly3), .Q(clk0_g),  .TE(1'b0)   );
    //clk_gate_xxx clk_gate_b ( .CP(clk1), .EN(sel_clk1_dly3), .Q(clk1_g),  .TE(1'b0)   );
    //assign clk0_g = clk0 & sel_clk0_dly3;
    //assign clk1_g = clk1 & sel_clk1_dly3;
    //assign clk_o = clk0_g | clk1_g ;
    
clk_gate clk_gate_u0(
                     .clk0(clk0),
                     .clk1(clk1),
                     .sel_clk0_dly3(sel_clk0_dly3),
                     .sel_clk1_dly3(sel_clk1_dly3),
                     .clk_o(clk_o)
                    );
endmodule
