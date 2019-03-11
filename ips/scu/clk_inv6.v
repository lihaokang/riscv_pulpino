module clk_inv6(
                clk0,
                clk1,
                clk2,
                clk3,
                clk4,
                clk5,
                clk0_n,
                clk1_n,
                clk2_n,
                clk3_n,
                clk4_n,
                clk5_n
               );
    input  clk0;
    input  clk1;
    input  clk2;
    input  clk3;
    input  clk4;
    input  clk5;
    output clk0_n;
    output clk1_n;
    output clk2_n;
    output clk3_n;
    output clk4_n;
    output clk5_n;

    //assign clk0_n = ~clk0;
    //assign clk1_n = ~clk1;
    //assign clk2_n = ~clk2;
    //assign clk3_n = ~clk3;
    //assign clk4_n = ~clk4;
    //assign clk5_n = ~clk5;

    CKINVM12HM CKINV_CLK0(.A(clk0), .Z(clk0_n));
    CKINVM12HM CKINV_CLK1(.A(clk1), .Z(clk1_n));
    CKINVM12HM CKINV_CLK2(.A(clk2), .Z(clk2_n));
    CKINVM12HM CKINV_CLK3(.A(clk3), .Z(clk3_n));
    CKINVM12HM CKINV_CLK4(.A(clk4), .Z(clk4_n));
    CKINVM12HM CKINV_CLK5(.A(clk5), .Z(clk5_n));

endmodule
