module clk_inv2(
                clk0,
                clk1,
                clk0_n,
                clk1_n,
               );
    input  clk0;
    input  clk1;
    output clk0_n;
    output clk1_n;

    assign clk0_n = ~clk0;
    assign clk1_n = ~clk1;

endmodule
