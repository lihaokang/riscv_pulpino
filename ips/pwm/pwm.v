//===================================================================================
// Copyright (c) 2019 Corelink (beijing) Co., Ltd.
// Create by zhaowt.
//-----------------------------------------------------------------------------------
// Project Name       : CL1901
// File Name          : wdt.v
// Author             : zhaowt
// Description        :
//-----------------------------------------------------------------------------------
// Create Date        : 2019/02/21
//
//===================================================================================


`define TD #1
`define SFR_D_W 32

module pwm (
            // APB BUS signals
            pclk,
            prst_n,
            paddr,
            pwdata,
            pwrite,
            penable,
            psel,
            prdata,
            pready,
            pslverr,
            //pheri clk
            // Outputs
            pwm0,
            pwm1,
            pwm2,
            pwm3,
            pwm4,
            pwm5,
            pwm6,
            pwm7
           );
   
    //*********** parameter definition ********************//
    parameter             PWM_BA      = 32'h1A10_2000;  // base address of wdt
    parameter             PWM0_PERIOD = PWM_BA + 32'h00;// pwm0 cfg register0  
    parameter             PWM0_PULSE  = PWM_BA + 32'h04;// pwm0 cfg register1
    parameter             PWM1_PERIOD = PWM_BA + 32'h08;// pwm1 cfg register0  
    parameter             PWM1_PULSE  = PWM_BA + 32'h0C;// pwm1 cfg register1
    parameter             PWM2_PERIOD = PWM_BA + 32'h10;// pwm2 cfg register0  
    parameter             PWM2_PULSE  = PWM_BA + 32'h14;// pwm2 cfg register1
    parameter             PWM3_PERIOD = PWM_BA + 32'h18;// pwm3 cfg register0  
    parameter             PWM3_PULSE  = PWM_BA + 32'h1C;// pwm3 cfg register1
    parameter             PWM4_PERIOD = PWM_BA + 32'h20;// pwm4 cfg register0  
    parameter             PWM4_PULSE  = PWM_BA + 32'h24;// pwm4 cfg register1
    parameter             PWM5_PERIOD = PWM_BA + 32'h28;// pwm5 cfg register0  
    parameter             PWM5_PULSE  = PWM_BA + 32'h2C;// pwm5 cfg register1
    parameter             PWM6_PERIOD = PWM_BA + 32'h30;// pwm6 cfg register0  
    parameter             PWM6_PULSE  = PWM_BA + 32'h34;// pwm6 cfg register1
    parameter             PWM7_PERIOD = PWM_BA + 32'h38;// pwm7 cfg register0  
    parameter             PWM7_PULSE  = PWM_BA + 32'h3C;// pwm7 cfg register1
    parameter             PWM_CFG     = PWM_BA + 32'h40;// pwm config register
    parameter             PWM_CTRL    = PWM_BA + 32'h44;// pwm control register
   
    // APB Bus
    input 				  pclk;            // APB bus clock.
    input 				  prst_n;          // Async reset of APB bus.
    input  [31:0]         paddr;           // apb bus address
    input  [31:0]         pwdata;          // apb bus write data signals
    input                 pwrite;          // apb bus write signal
    input                 psel;            // apb bus select signal
    input                 penable;         // apb bus operation enable signal 
    output [31:0]         prdata;          // apb bus read data signals
    output                pready;          // apb bus slave ready signal
    output                pslverr;
    //output of pwmx4
    output                pwm0;
    output                pwm1;
    output                pwm2;
    output                pwm3;
    output                pwm4;
    output                pwm5;
    output                pwm6;
    output                pwm7;
    //SYSC
    reg    [31:0]         prdata_tmp;
    wire   [31:0]         prdata;
    wire                  pready;
    wire                  pslverr;
    wire                  apb_wr_en;
    wire                  apb_rd_en;
    //******************* Logics ************************************//
    assign pready = 1'b1;
    assign pslverr = 1'b0;
    assign apb_wr_en  = psel && pwrite && penable;
    assign apb_rd_en  = psel && ~pwrite && penable;   

    //=================================//
    //======APB Bus Write Process======//
    //=================================//
    reg    [31:0]         pwm0_period;
    reg    [31:0]         pwm0_pulse;
    reg    [31:0]         pwm1_period;
    reg    [31:0]         pwm1_pulse;
    reg    [31:0]         pwm2_period;
    reg    [31:0]         pwm2_pulse;
    reg    [31:0]         pwm3_period;
    reg    [31:0]         pwm3_pulse;
    reg    [31:0]         pwm4_period;
    reg    [31:0]         pwm4_pulse;
    reg    [31:0]         pwm5_period;
    reg    [31:0]         pwm5_pulse;
    reg    [31:0]         pwm6_period;
    reg    [31:0]         pwm6_pulse;
    reg    [31:0]         pwm7_period;
    reg    [31:0]         pwm7_pulse;
    reg    [7:0]          pwm_cfg;
    reg    [7:0]          pwm_ctrl;


    reg    [31:0]         pwm0_period_buf;
    reg    [31:0]         pwm0_pulse_buf;
    reg    [31:0]         pwm1_period_buf;
    reg    [31:0]         pwm1_pulse_buf;
    reg    [31:0]         pwm2_period_buf;
    reg    [31:0]         pwm2_pulse_buf;
    reg    [31:0]         pwm3_period_buf;
    reg    [31:0]         pwm3_pulse_buf;
    reg    [31:0]         pwm4_period_buf;
    reg    [31:0]         pwm4_pulse_buf;
    reg    [31:0]         pwm5_period_buf;
    reg    [31:0]         pwm5_pulse_buf;
    reg    [31:0]         pwm6_period_buf;
    reg    [31:0]         pwm6_pulse_buf;
    reg    [31:0]         pwm7_period_buf;
    reg    [31:0]         pwm7_pulse_buf;    
    reg    [7:0]          pwm_ctrl_d0;
    reg    [31:0]         cnt_pwm0;   
    reg    [31:0]         cnt_pwm1;   
    reg    [31:0]         cnt_pwm2;   
    reg    [31:0]         cnt_pwm3;   
    reg    [31:0]         cnt_pwm4;   
    reg    [31:0]         cnt_pwm5;   
    reg    [31:0]         cnt_pwm6;   
    reg    [31:0]         cnt_pwm7;   
    reg    [7:0]          pwm_en_d0;
    reg                   pwm0_en,pwm1_en,pwm2_en,pwm3_en;
    reg                   pwm4_en,pwm5_en,pwm6_en,pwm7_en;
    wire                  pwm0_start;
    wire                  pwm1_start;
    wire                  pwm2_start;
    wire                  pwm3_start;
    wire                  pwm4_start;
    wire                  pwm5_start;
    wire                  pwm6_start;
    wire                  pwm7_start;
    wire                  pwm0_finish;
    wire                  pwm1_finish;
    wire                  pwm2_finish;
    wire                  pwm3_finish;
    wire                  pwm4_finish;
    wire                  pwm5_finish;
    wire                  pwm6_finish;
    wire                  pwm7_finish;    
    reg                   pwm0_tmp;
    reg                   pwm1_tmp;
    reg                   pwm2_tmp;
    reg                   pwm3_tmp;
    reg                   pwm4_tmp;
    reg                   pwm5_tmp;
    reg                   pwm6_tmp;
    reg                   pwm7_tmp;
    wire                  pwm0;
    wire                  pwm1;
    wire                  pwm2;
    wire                  pwm3;
    wire                  pwm4;
    wire                  pwm5;
    wire                  pwm6;
    wire                  pwm7;
    //Initial value of wdt
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm0_period <= 32'hFFFF_FFFF;
                    pwm0_pulse <= 32'h0000_FFFF;
                    pwm1_period <= 32'hFFFF_FFFF;
                    pwm1_pulse <= 32'h0000_FFFF;
                    pwm2_period <= 32'hFFFF_FFFF;
                    pwm2_pulse <= 32'h0000_FFFF;
                    pwm3_period <= 32'hFFFF_FFFF;
                    pwm3_pulse <= 32'h0000_FFFF;   
                    pwm4_period <= 32'hFFFF_FFFF;
                    pwm4_pulse <= 32'h0000_FFFF;
                    pwm5_period <= 32'hFFFF_FFFF;
                    pwm5_pulse <= 32'h0000_FFFF;
                    pwm6_period <= 32'hFFFF_FFFF;
                    pwm6_pulse <= 32'h0000_FFFF;
                    pwm7_period <= 32'hFFFF_FFFF;
                    pwm7_pulse <= 32'h0000_FFFF;
                    pwm_ctrl <= 8'h00;
                end
            else if(apb_wr_en)
                begin
                    if(paddr == PWM0_PERIOD)
                        pwm0_period <= pwdata;
                    else if(paddr == PWM0_PULSE)
                        pwm0_pulse <= pwdata;
                    else if(paddr == PWM1_PERIOD)
                        pwm1_period <= pwdata;
                    else if(paddr == PWM1_PULSE)
                        pwm1_pulse <= pwdata;
                    else if(paddr == PWM2_PERIOD)
                        pwm2_period <= pwdata;
                    else if(paddr == PWM2_PULSE)
                        pwm2_pulse <= pwdata;
                    else if(paddr == PWM3_PERIOD)
                        pwm3_period <= pwdata;
                    else if(paddr == PWM3_PULSE)
                        pwm3_pulse <= pwdata;
                    else if(paddr == PWM4_PERIOD)
                        pwm4_period <= pwdata;
                    else if(paddr == PWM4_PULSE)
                        pwm4_pulse <= pwdata;
                    else if(paddr == PWM5_PERIOD)
                        pwm5_period <= pwdata;
                    else if(paddr == PWM5_PULSE)
                        pwm5_pulse <= pwdata;
                    else if(paddr == PWM6_PERIOD)
                        pwm6_period <= pwdata;
                    else if(paddr == PWM6_PULSE)
                        pwm6_pulse <= pwdata;
                    else if(paddr == PWM7_PERIOD)
                        pwm7_period <= pwdata;
                    else if(paddr == PWM7_PULSE)
                        pwm7_pulse <= pwdata;
                    else if(paddr == PWM_CTRL)
                        pwm_ctrl <= pwdata[7:0];
                end
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                pwm_cfg <= 8'h00;
            else if(apb_wr_en && (paddr == PWM_CFG))
                begin
                    pwm_cfg[0] <= pwm0_en ? pwm_cfg[0] : pwdata[0];
                    pwm_cfg[1] <= pwm1_en ? pwm_cfg[1] : pwdata[1];
                    pwm_cfg[2] <= pwm2_en ? pwm_cfg[2] : pwdata[2];
                    pwm_cfg[3] <= pwm3_en ? pwm_cfg[3] : pwdata[3];
                    pwm_cfg[4] <= pwm4_en ? pwm_cfg[4] : pwdata[4];
                    pwm_cfg[5] <= pwm5_en ? pwm_cfg[5] : pwdata[5];
                    pwm_cfg[6] <= pwm6_en ? pwm_cfg[6] : pwdata[6];
                    pwm_cfg[7] <= pwm7_en ? pwm_cfg[7] : pwdata[7];
                end
            else if(pwm0_finish)
                pwm_cfg[0] <= 1'b0;
            else if(pwm1_finish)
                pwm_cfg[1] <= 1'b0;
            else if(pwm2_finish)
                pwm_cfg[2] <= 1'b0;
            else if(pwm3_finish)
                pwm_cfg[3] <= 1'b0;
            else if(pwm4_finish)
                pwm_cfg[4] <= 1'b0;
            else if(pwm5_finish)
                pwm_cfg[5] <= 1'b0;
            else if(pwm6_finish)
                pwm_cfg[6] <= 1'b0;
            else if(pwm7_finish)
                pwm_cfg[7] <= 1'b0;
        end
    
    //APB Bus Read Data Process.
    always@(*)
        begin
            case(paddr)
                PWM0_PERIOD : prdata_tmp <= pwm0_period;
                PWM0_PULSE  : prdata_tmp <= pwm0_pulse;
                PWM1_PERIOD : prdata_tmp <= pwm1_period;
                PWM1_PULSE  : prdata_tmp <= pwm1_pulse;
                PWM2_PERIOD : prdata_tmp <= pwm2_period;
                PWM2_PULSE  : prdata_tmp <= pwm2_pulse;
                PWM3_PERIOD : prdata_tmp <= pwm3_period;
                PWM3_PULSE  : prdata_tmp <= pwm3_pulse;
                PWM4_PERIOD : prdata_tmp <= pwm4_period;
                PWM4_PULSE  : prdata_tmp <= pwm4_pulse;
                PWM5_PERIOD : prdata_tmp <= pwm5_period;
                PWM5_PULSE  : prdata_tmp <= pwm5_pulse;
                PWM6_PERIOD : prdata_tmp <= pwm6_period;
                PWM6_PULSE  : prdata_tmp <= pwm6_pulse;
                PWM7_PERIOD : prdata_tmp <= pwm7_period;
                PWM7_PULSE  : prdata_tmp <= pwm7_pulse;
                PWM_CFG     : prdata_tmp <= {24'h0,pwm_cfg};
                PWM_CTRL    : prdata_tmp <= {24'h0,pwm_ctrl};
                default     : prdata_tmp <= {`SFR_D_W{1'b0}};
            endcase
        end

    assign prdata = apb_rd_en ? prdata_tmp : 32'h0;

    //***************** Counter Part *********************//
    //****************************************************//

    //controll part
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm_ctrl_d0 <= 8'h00;
            else
                pwm_ctrl_d0 <= pwm_ctrl;
        end

    assign pwm0_start = pwm_ctrl[0] & ~pwm_ctrl_d0[0];
    assign pwm1_start = pwm_ctrl[1] & ~pwm_ctrl_d0[1];
    assign pwm2_start = pwm_ctrl[2] & ~pwm_ctrl_d0[2];
    assign pwm3_start = pwm_ctrl[3] & ~pwm_ctrl_d0[3];
    assign pwm4_start = pwm_ctrl[4] & ~pwm_ctrl_d0[4];
    assign pwm5_start = pwm_ctrl[5] & ~pwm_ctrl_d0[5];
    assign pwm6_start = pwm_ctrl[6] & ~pwm_ctrl_d0[6];
    assign pwm7_start = pwm_ctrl[7] & ~pwm_ctrl_d0[7];

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm0_period_buf <= 32'h0;
                    pwm0_pulse_buf <= 32'h0;
                end
            else if(pwm0_start || (cnt_pwm0 == (pwm0_period_buf-1)))
                begin
                    pwm0_period_buf <= pwm0_period;
                    pwm0_pulse_buf <= pwm0_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm1_period_buf <= 32'h0;
                    pwm1_pulse_buf <= 32'h0;
                end
            else if(pwm1_start || (cnt_pwm1 == (pwm1_period_buf-1)))
                begin
                    pwm1_period_buf <= pwm1_period;
                    pwm1_pulse_buf <= pwm1_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm2_period_buf <= 32'h0;
                    pwm2_pulse_buf <= 32'h0;
                end
            else if(pwm2_start || (cnt_pwm2 == (pwm2_period_buf-1)))
                begin
                    pwm2_period_buf <= pwm2_period;
                    pwm2_pulse_buf <= pwm2_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm3_period_buf <= 32'h0;
                    pwm3_pulse_buf <= 32'h0;
                end
            else if(pwm3_start || (cnt_pwm3 == (pwm3_period_buf-1)))
                begin
                    pwm3_period_buf <= pwm3_period;
                    pwm3_pulse_buf <= pwm3_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm4_period_buf <= 32'h0;
                    pwm4_pulse_buf <= 32'h0;
                end
            else if(pwm4_start || (cnt_pwm4 == (pwm4_period_buf-1)))
                begin
                    pwm4_period_buf <= pwm4_period;
                    pwm4_pulse_buf <= pwm4_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm5_period_buf <= 32'h0;
                    pwm5_pulse_buf <= 32'h0;
                end
            else if(pwm5_start || (cnt_pwm5 == (pwm5_period_buf-1)))
                begin
                    pwm5_period_buf <= pwm5_period;
                    pwm5_pulse_buf <= pwm5_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm6_period_buf <= 32'h0;
                    pwm6_pulse_buf <= 32'h0;
                end
            else if(pwm6_start || (cnt_pwm6 == (pwm6_period_buf-1)))
                begin
                    pwm6_period_buf <= pwm6_period;
                    pwm6_pulse_buf <= pwm6_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                begin
                    pwm7_period_buf <= 32'h0;
                    pwm7_pulse_buf <= 32'h0;
                end
            else if(pwm7_start || (cnt_pwm7 == (pwm7_period_buf-1)))
                begin
                    pwm7_period_buf <= pwm7_period;
                    pwm7_pulse_buf <= pwm7_pulse;
                end
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm0_en <= 1'b0;
            else if(pwm0_start)
                pwm0_en <= 1'b1;
            //else if(~pwm_ctrl[0] && ~pwm0_tmp)
            else if(~pwm_ctrl[0] && (cnt_pwm0 == (pwm0_pulse_buf-1)))
                pwm0_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm1_en <= 1'b0;
            else if(pwm1_start)
                pwm1_en <= 1'b1;
            //else if(~pwm_ctrl[1] && ~pwm1_tmp)
            else if(~pwm_ctrl[1] && (cnt_pwm1 == (pwm1_pulse_buf-1)))
                pwm1_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm2_en <= 1'b0;
            else if(pwm2_start)
                pwm2_en <= 1'b1;
            //else if(~pwm_ctrl[2] && ~pwm2_tmp)
            else if(~pwm_ctrl[2] && (cnt_pwm2 == (pwm2_pulse_buf-1)))
                pwm2_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm3_en <= 1'b0;
            else if(pwm3_start)
                pwm3_en <= 1'b1;
            //else if(~pwm_ctrl[3] && ~pwm3_tmp)
            else if(~pwm_ctrl[3] && (cnt_pwm3 == (pwm3_pulse_buf-1)))
                pwm3_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm4_en <= 1'b0;
            else if(pwm4_start)
                pwm4_en <= 1'b1;
            //else if(~pwm_ctrl[0] && ~pwm4_tmp)
            else if(~pwm_ctrl[4] && (cnt_pwm4 == (pwm4_pulse_buf-1)))
                pwm4_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm5_en <= 1'b0;
            else if(pwm5_start)
                pwm5_en <= 1'b1;
            //else if(~pwm_ctrl[1] && ~pwm5_tmp)
            else if(~pwm_ctrl[5] && (cnt_pwm5 == (pwm5_pulse_buf-1)))
                pwm5_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm6_en <= 1'b0;
            else if(pwm6_start)
                pwm6_en <= 1'b1;
            //else if(~pwm_ctrl[2] && ~pwm6_tmp)
            else if(~pwm_ctrl[6] && (cnt_pwm6 == (pwm6_pulse_buf-1)))
                pwm6_en <= 1'b0;
        end

    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm7_en <= 1'b0;
            else if(pwm7_start)
                pwm7_en <= 1'b1;
            //else if(~pwm_ctrl[3] && ~pwm7_tmp)
            else if(~pwm_ctrl[7] && (cnt_pwm7 == (pwm7_pulse_buf-1)))
                pwm7_en <= 1'b0;
        end
    always@(posedge pclk or negedge prst_n)
        begin
            if(~prst_n)
                pwm_en_d0 <= 8'h00;
            else
                pwm_en_d0 <= {pwm7_en,pwm6_en,pwm5_en,pwm4_en,pwm3_en,pwm2_en,pwm1_en,pwm0_en};
        end

    assign pwm0_finish = ~pwm0_en & pwm_en_d0[0]; 
    assign pwm1_finish = ~pwm1_en & pwm_en_d0[1]; 
    assign pwm2_finish = ~pwm2_en & pwm_en_d0[2]; 
    assign pwm3_finish = ~pwm3_en & pwm_en_d0[3]; 
    assign pwm4_finish = ~pwm4_en & pwm_en_d0[4]; 
    assign pwm5_finish = ~pwm5_en & pwm_en_d0[5]; 
    assign pwm6_finish = ~pwm6_en & pwm_en_d0[6]; 
    assign pwm7_finish = ~pwm7_en & pwm_en_d0[7]; 

    //pwm0 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm0 <= 32'h0;
            else if(~pwm0_en)
                cnt_pwm0 <= 32'h0;
            else if(pwm0_en)
                begin
                    if(cnt_pwm0 == (pwm0_period_buf-1))
                        cnt_pwm0 <= 32'h0;
                    else
                        cnt_pwm0 <= cnt_pwm0 + 32'h1;
                end
        end

    //pwm1 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm1 <= 32'h0;
            else if(~pwm1_en)
                cnt_pwm1 <= 32'h0;
            else if(pwm1_en)
                begin
                    if(cnt_pwm1 == (pwm1_period_buf-1))
                        cnt_pwm1 <= 32'h0;
                    else
                        cnt_pwm1 <= cnt_pwm1 + 32'h1;
                end
        end
    //pwm2 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm2 <= 32'h0;
            else if(~pwm2_en)
                cnt_pwm2 <= 32'h0;
            else if(pwm2_en)
                begin
                    if(cnt_pwm2 == (pwm2_period_buf-1))
                        cnt_pwm2 <= 32'h0;
                    else
                        cnt_pwm2 <= cnt_pwm2 + 32'h1;
                end
        end
    //pwm3 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm3 <= 32'h0;
            else if(~pwm3_en)
                cnt_pwm3 <= 32'h0;
            else if(pwm3_en)
                begin
                    if(cnt_pwm3 == (pwm3_period_buf-1))
                        cnt_pwm3 <= 32'h0;
                    else
                        cnt_pwm3 <= cnt_pwm3 + 32'h1;
                end
        end
    //pwm4 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm4 <= 32'h0;
            else if(~pwm4_en)
                cnt_pwm4 <= 32'h0;
            else if(pwm4_en)
                begin
                    if(cnt_pwm4 == (pwm4_period_buf-1))
                        cnt_pwm4 <= 32'h0;
                    else
                        cnt_pwm4 <= cnt_pwm4 + 32'h1;
                end
        end

    //pwm5 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm5 <= 32'h0;
            else if(~pwm5_en)
                cnt_pwm5 <= 32'h0;
            else if(pwm5_en)
                begin
                    if(cnt_pwm5 == (pwm5_period_buf-1))
                        cnt_pwm5 <= 32'h0;
                    else
                        cnt_pwm5 <= cnt_pwm5 + 32'h1;
                end
        end
    //pwm6 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm6 <= 32'h0;
            else if(~pwm6_en)
                cnt_pwm6 <= 32'h0;
            else if(pwm6_en)
                begin
                    if(cnt_pwm6 == (pwm6_period_buf-1))
                        cnt_pwm6 <= 32'h0;
                    else
                        cnt_pwm6 <= cnt_pwm6 + 32'h1;
                end
        end
    //pwm7 counter
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                cnt_pwm7 <= 32'h0;
            else if(~pwm7_en)
                cnt_pwm7 <= 32'h0;
            else if(pwm7_en)
                begin
                    if(cnt_pwm7 == (pwm7_period_buf-1))
                        cnt_pwm7 <= 32'h0;
                    else
                        cnt_pwm7 <= cnt_pwm7 + 32'h1;
                end
        end
    //pwm0 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm0_tmp <= 1'b0;
            else if(~pwm0_en)
                pwm0_tmp <= 1'b0;
            else if(cnt_pwm0 == (pwm0_period_buf-1))
                pwm0_tmp <= 1'b1;
            else if(cnt_pwm0 == (pwm0_pulse_buf-1))
                pwm0_tmp <= 1'b0;
        end
    //pwm1 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm1_tmp <= 1'b0;
            else if(~pwm1_en)
                pwm1_tmp <= 1'b0;
            else if(cnt_pwm1 == (pwm1_period_buf-1))
                pwm1_tmp <= 1'b1;
            else if(cnt_pwm1 == (pwm1_pulse_buf-1))
                pwm1_tmp <= 1'b0;
        end

    //pwm2 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm2_tmp <= 1'b0;
            else if(~pwm2_en)
                pwm2_tmp <= 1'b0;
            else if(cnt_pwm2 == (pwm2_period_buf-1))
                pwm2_tmp <= 1'b1;
            else if(cnt_pwm2 == (pwm2_pulse_buf-1))
                pwm2_tmp <= 1'b0;
        end
    //pwm3 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm3_tmp <= 1'b0;
            else if(~pwm3_en)
                pwm3_tmp <= 1'b0;            
            else if(cnt_pwm3 == (pwm3_period_buf-1))
                pwm3_tmp <= 1'b1;
            else if(cnt_pwm3 == (pwm3_pulse_buf-1))
                pwm3_tmp <= 1'b0;
        end
    //pwm4 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm4_tmp <= 1'b0;
            else if(~pwm4_en)
                pwm4_tmp <= 1'b0;
            else if(cnt_pwm4 == (pwm4_period_buf-1))
                pwm4_tmp <= 1'b1;
            else if(cnt_pwm4 == (pwm4_pulse_buf-1))
                pwm4_tmp <= 1'b0;
        end
    //pwm5 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm5_tmp <= 1'b0;
            else if(~pwm5_en)
                pwm5_tmp <= 1'b0;
            else if(cnt_pwm5 == (pwm5_period_buf-1))
                pwm5_tmp <= 1'b1;
            else if(cnt_pwm5 == (pwm5_pulse_buf-1))
                pwm5_tmp <= 1'b0;
        end

    //pwm6 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm6_tmp <= 1'b0;
            else if(~pwm6_en)
                pwm6_tmp <= 1'b0;
            else if(cnt_pwm6 == (pwm6_period_buf-1))
                pwm6_tmp <= 1'b1;
            else if(cnt_pwm6 == (pwm6_pulse_buf-1))
                pwm6_tmp <= 1'b0;
        end
    //pwm7 output
    always@(posedge pclk or negedge prst_n)
        begin
            if(!prst_n)
                pwm7_tmp <= 1'b0;
            else if(~pwm7_en)
                pwm7_tmp <= 1'b0;            
            else if(cnt_pwm7 == (pwm7_period_buf-1))
                pwm7_tmp <= 1'b1;
            else if(cnt_pwm7 == (pwm7_pulse_buf-1))
                pwm7_tmp <= 1'b0;
        end

    assign pwm0 = pwm0_en ? (pwm_cfg[0] ? ~pwm0_tmp : pwm0_tmp) : 1'b0;
    assign pwm1 = pwm1_en ? (pwm_cfg[1] ? ~pwm1_tmp : pwm1_tmp) : 1'b0;
    assign pwm2 = pwm2_en ? (pwm_cfg[2] ? ~pwm2_tmp : pwm2_tmp) : 1'b0;
    assign pwm3 = pwm3_en ? (pwm_cfg[3] ? ~pwm3_tmp : pwm3_tmp) : 1'b0;
    assign pwm4 = pwm4_en ? (pwm_cfg[4] ? ~pwm4_tmp : pwm4_tmp) : 1'b0;
    assign pwm5 = pwm5_en ? (pwm_cfg[5] ? ~pwm5_tmp : pwm5_tmp) : 1'b0;
    assign pwm6 = pwm6_en ? (pwm_cfg[6] ? ~pwm6_tmp : pwm6_tmp) : 1'b0;
    assign pwm7 = pwm7_en ? (pwm_cfg[7] ? ~pwm7_tmp : pwm7_tmp) : 1'b0;

   endmodule // pwm.v

