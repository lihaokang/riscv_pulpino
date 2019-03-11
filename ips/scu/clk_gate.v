module clk_gate(
                clk0,
                clk1,
                sel_clk0_dly3,
                sel_clk1_dly3,
                clk_o
               );

    output  clk_o;
    input   clk0;
    input   clk1;
    input   sel_clk0_dly3;
    input   sel_clk1_dly3;
    
    wire    clk_o;

    //assign clk0_g = clk0 & sel_clk0_dly3;
    //assign clk1_g = clk1 & sel_clk1_dly3;
    //assign clk_o = clk0_g | clk1_g ;

    LAGCEM8HM LAGCE_CLK0_G  (.GCK(clk0_g), .CK(clk0),  .E(sel_clk0_dly3));
    LAGCEM8HM LAGCE_CLK1_G  (.GCK(clk1_g), .CK(clk1),  .E(sel_clk1_dly3));
    LAGCEM8HM LAGCE_CLK_O   (.GCK(clk_o), .CK(clk0_g | clk1_g),  .E(1'h1));
endmodule
