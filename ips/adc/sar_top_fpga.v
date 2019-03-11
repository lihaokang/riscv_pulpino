//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : apb_adc_control             				    //
//  				Author       : tao wen                      				//
//  				Modify       : huiyng cao                      				//
//  				Description  : control adc by apb         				    //
//  				Create Date  : 2019/01/19                 				    //
//                  Review Date  : 2019/02/03			                        //
//==============================================================================//
`timescale 1ns/1ps

module SAR_TOP_fpga ( ADC_ANA_TP, ADC_CKOUT, ADC_DOUT, ADC_BIAS20U, ADC_CLKIN, ADC_IN,
ADC_REG_IN_0, ADC_REG_IN_1, ADC_RESETB, ADC_START, ADC_VBG_IN, ADC_VRM_AVSS,
ADC_VRM_EXT, ADC_VRP_EXT, ADC_VRP_VCC, AVSS, VCC );

  input  [15:0] ADC_REG_IN_0; 
  input  [15:0] ADC_REG_IN_1;
  input  [7:0] ADC_IN;
  input ADC_CLKIN;
  input ADC_RESETB;  
  input ADC_START;
  input ADC_VBG_IN;
  input ADC_VRM_AVSS;
  input ADC_VRM_EXT;
  input ADC_VRP_EXT;
  input ADC_VRP_VCC;

  input VCC;  //5V Power Supply
  input AVSS;  //Ground
  input  [1:0] ADC_BIAS20U;  //ADC Bias Current

  output  [9:0] ADC_DOUT;  
  output ADC_ANA_TP;
  output ADC_CKOUT;

    reg         ADC_CKOUT;
    reg  [7:0]  div_clk;
    reg  [6:0]  num,num0,num1,num2,num3,num4,num5,num6,num7;
    reg  [6:0]  cnt;
    reg  [2:0]  port;
    reg  [1:0]  state;
    reg         clk;
    reg         cnt_en;
    reg  [31:0] adc_ckout0,adc_ckout1;
always@(*)
    begin
        case(ADC_REG_IN_0[14:13])
            2'b00 : div_clk <= 8'h10;
            2'b01 : div_clk <= 8'h20;
            2'b10 : div_clk <= 8'h40;
            2'b11 : div_clk <= 8'h80;
        endcase
    end

always@(posedge ADC_CLKIN or negedge ADC_RESETB)
    begin
        if(!ADC_RESETB)
            cnt <= 8'h0;
        else if(!ADC_START)
            cnt <= 8'h0;
        else if(cnt == div_clk-1)
            cnt <= 8'h0;
        else if(ADC_START)
            cnt <= cnt + 8'h1;
    end

always@(posedge ADC_CLKIN or negedge ADC_RESETB)
    begin
        if(!ADC_RESETB)
            ADC_CKOUT <= 1'b0;
        else if(!ADC_START)
            ADC_CKOUT <= 1'b0;
        else if(cnt == (div_clk-1))
            ADC_CKOUT <= 1'b0;
        else if(cnt == (div_clk[7:1]-1))
            ADC_CKOUT <= 1'b1;
    end
always@(posedge ADC_CLKIN or negedge ADC_RESETB)
    begin
        if(!ADC_RESETB)
            cnt_en <= 1'b0;
        else if(ADC_START && (cnt == (div_clk[7:1]-1)))
            cnt_en <= 1'b1;
    end

always@(posedge ADC_CLKIN or negedge ADC_RESETB)
    begin
        if(!ADC_RESETB)
            begin
                num0 <= 7'h0;
                num1 <= 7'h0;
                num2 <= 7'h0;
                num3 <= 7'h0;
                num4 <= 7'h0;
                num5 <= 7'h0;
                num6 <= 7'h0;
                num7 <= 7'h0;
            end
        else if(ADC_START && (cnt == (div_clk[7:1]-1)))
            begin
                case(ADC_REG_IN_0[8:1])
                    8'b0000_0001: num0 <= num0 + 7'b1;
                    8'b0000_0010: num1 <= num1 + 7'b1;
                    8'b0000_0100: num2 <= num2 + 7'b1;
                    8'b0000_1000: num3 <= num3 + 7'b1;
                    8'b0001_0000: num4 <= num4 + 7'b1;
                    8'b0010_0000: num5 <= num5 + 7'b1;
                    8'b0100_0000: num6 <= num6 + 7'b1;
                    8'b1000_0000: num7 <= num7 + 7'b1;
                endcase
            end
    end
    
	reg ADC_CKOUT0,ADC_CKOUT1;
	wire 	ADC_CKOUT_pos;
	assign 	ADC_CKOUT_pos= ~ADC_CKOUT1 & ADC_CKOUT0;
	always@(posedge ADC_CLKIN)
		begin
			ADC_CKOUT0<=ADC_CKOUT;
			ADC_CKOUT1<=ADC_CKOUT0;
		end
		
    always@(*)
        begin
			if(!ADC_RESETB)begin num<=0; port <=0; end
			else if(ADC_CKOUT_pos)begin
				case(ADC_REG_IN_0[8:1])
						8'b0000_0001:
									begin
										num <= num0;
										port <= 3'b000;
									end
						8'b0000_0010: 
									begin
										num <= num1;
										port <= 3'b001;
									end
						8'b0000_0100: 
									begin
										num <= num2;
										port <= 3'b010;
									end
						8'b0000_1000: 
									begin
										num <= num3;
										port <= 3'b011;
									end
						8'b0001_0000: 
									begin
										num <= num4;
										port <= 3'b100;
									end
						8'b0010_0000: 
									begin
										num <= num5;
										port <= 3'b101;
									end
						8'b0100_0000: 
									begin
										num <= num6;
										port <= 3'b110;
									end
						8'b1000_0000: 
									begin
										num <= num7;
										port <= 3'b111;
									end
				endcase end
			else begin num <= num; port <= port; end
		end
    //assign ADC_DOUT = ADC_CKOUT ? {port,num} : 10'b0;
    assign ADC_DOUT = {port,num};
// =============================================================================
// Measure ADC_CLKIN period and frequency
// =============================================================================

endmodule
