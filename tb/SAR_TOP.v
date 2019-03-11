`timescale 1ns/1ps

module SAR_TOP ( ADC_ANA_TP, ADC_CKOUT, ADC_DOUT, ADC_BIAS20U, ADC_CLKIN, ADC_IN,
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

wire pr_rdy, pu_reset_int, pu_reset, pu_int;

assign #0.1 pr_rdy = VCC&&(!AVSS)&&(&ADC_BIAS20U);
assign #0.1 pu_int = ~ADC_REG_IN_0[0];
assign #0.1 pu_reset_int = (!ADC_REG_IN_0[0])&&ADC_RESETB;
assign pu_reset = pr_rdy&&pu_reset_int;


always @(*) begin
    #0.1;
    if (pu_int&&(pr_rdy !== 1'b1)) begin
	if (VCC !== 1'b1)
	    $display("Error(%m), at %t, VCC should be set to 1'b1.\n", $realtime);
	if (ADC_BIAS20U !== 2'b11)
	    $display("Error(%m), at %t, ADC_BIAS20U should be set to 2'b11.\n", $realtime);
	if (AVSS !== 1'b0)
	    $display("Error(%m), at %t, AVSS should be set to 1'b0.\n", $realtime);
    end
end

always @(*) begin
    #0.1;
    if (pu_reset) begin
	if ((^ADC_REG_IN_0 !== 1'b0)&&(^ADC_REG_IN_0 !== 1'b1))
	    $display("Error(%m), at %t, ADC_REG_IN_0 has floating pin.\n", $realtime);
	else begin
	    if (ADC_REG_IN_0[11] === 1'b1) begin
	        if (ADC_VRM_EXT !== 1'b0)
	            $display("Error(%m), at %t, ADC_VRM_EXT should be set to 1'b0 when ADC_REG_IN_0[11] is 1'b1.\n", $realtime);
	    end
	    else if (ADC_REG_IN_0[11] === 1'b0) begin
	        if (ADC_VRM_AVSS !== 1'b0)
	            $display("Error(%m), at %t, ADC_VRM_AVSS should be set to 1'b0 when ADC_REG_IN_0[11] is 1'b0.\n", $realtime);
	    end
	    if (ADC_REG_IN_0[10:9] === 2'b00) begin
		if (ADC_VRP_VCC !== 1'b1)
	            $display("Error(%m), at %t, ADC_VRP_VCC should be set to 1'b1 when ADC_REG_IN_0[10:9] is 2'b00.\n", $realtime);
	    end
	    else if (ADC_REG_IN_0[10:9] === 2'b01) begin
		if (ADC_VRP_EXT !== 1'b1)
	            $display("Error(%m), at %t, ADC_VRP_EXT should be set to 1'b1 when ADC_REG_IN_0[10:9] is 2'b01.\n", $realtime);
	    end
	    else if (ADC_REG_IN_0[10:9] === 2'b10) begin
		if (ADC_VBG_IN !== 1'b1)
	            $display("Error(%m), at %t, ADC_VBG_IN should be set to 1'b1 when ADC_REG_IN_0[10:9] is 2'b10.\n", $realtime);
	    end
	    else if (ADC_REG_IN_0[10:9] === 2'b11) begin
	        $display("Error(%m), at %t, ADC_REG_IN_0[10:9] = 2'b11 is prohibited.\n", $realtime);
	    end
	end
	if ((^ADC_REG_IN_1 !== 1'b0)&&(^ADC_REG_IN_1 !== 1'b1))
	    $display("Error(%m), at %t, ADC_REG_IN_1 has floating pin.\n", $realtime);
	if ((^ADC_IN !== 1'b0)&&(^ADC_IN !== 1'b1))
	    $display("Error(%m), at %t, ADC_IN has floating pin.\n", $realtime);
    end
end

// =============================================================================
// Measure ADC_CLKIN period and frequency
// =============================================================================
wire refclk_chk_en;
assign refclk_chk_en = pu_int&&pr_rdy;

//refclk 24MHz ~ 40MHz
parameter REFCLK_MIN = 24e6;    
parameter REFCLK_MAX = 40e6;  

//check no_refclk error
event   no_refclk_error_event ;
event   refclk_error_out_event ;

reg refclk_period_valid, refclk_period_known;
real last_refclk_chg ;
real refclk_period ;
real refclk_freq;

initial begin
    refclk_period_valid = 1'b0;
    refclk_period_known = 1'b0;
    refclk_period <= 0;
    forever begin
        fork    : wait_refclk
            begin
                @(posedge ADC_CLKIN) ;
                disable no_refclk_error_block ;
                disable wait_refclk ;
            end
            begin
                #2_000 ;
                if(refclk_chk_en) begin
                    -> no_refclk_error_event ;
                end
                disable wait_refclk ;
            end
        join
 end
end
always @ (no_refclk_error_event) begin : no_refclk_error_block
    #2_000 ;
    $display("\nERROR(%m): at %t, no clock was detected on ADC_CLKIN within 4us.\n", $realtime) ;
//    `ifndef _PLL_NO_STOP
//        $finish;
//    `endif
end

always @ (negedge refclk_chk_en) begin
    disable no_refclk_error_block;
end

always @(posedge ADC_CLKIN)
begin
    case(refclk_period_known)
        1'b0:
            begin
                last_refclk_chg <= $realtime;
                refclk_period_valid <= 1'b0;
                refclk_period_known <= 1'b1;
            end
        1'b1:
            begin
                refclk_period = $realtime - last_refclk_chg;
                last_refclk_chg = $realtime;

                if ((1/(refclk_period/1e9) < REFCLK_MIN*0.999) || (1/(refclk_period/1e9) > REFCLK_MAX*1.001))
                begin
                    refclk_period_valid <= 1'b0;
                    if(refclk_chk_en)
                        -> refclk_error_out_event;
                end
                else
                begin
                    refclk_period_valid <= 1'b1;
                    refclk_period_known <= 1'b1;
                end
            end
        default:
            begin
                last_refclk_chg <= $realtime;
                refclk_period_known <= 1'b0;
                refclk_period_valid <= 1'b0;
                refclk_period <= 0;
            end
    endcase
end

always @ (refclk_period or refclk_chk_en) begin
    if (!refclk_chk_en)
        disable refclk_error_out_block;
    else if(refclk_period > 0)
        if ((1/(refclk_period/1e9) >= REFCLK_MIN) && (1/(refclk_period/1e9) <= REFCLK_MAX))
            disable refclk_error_out_block;
end

always @ (refclk_error_out_event) begin : refclk_error_out_block
    wait(refclk_period_known);
    #10_000;
    $display("\nERROR(%m): at %t, ADC_CLKIN = %.2f MHz is invalid.", $realtime, 1/(refclk_period/1e9)/1e6,
             "  Expected between %.2f MHz and %.2f MHz.", REFCLK_MIN/1e6, REFCLK_MAX/1e6,
             "  Started checking for a valid ADC_CLKIN frequency 10 us ago.\n");
//    `ifndef _PLL_NO_STOP
//      $finish;
//    `endif
end


always @ (refclk_period_valid or refclk_period) begin
   if (refclk_period_valid)
      refclk_freq = 1/(refclk_period/1e9);
   else
      refclk_freq = 0;
end


//////////////////////////////////////////////////////

real adc_out_freq;

initial adc_out_freq = 2;

always @(*) begin
    if (pu_reset) begin
	case (ADC_REG_IN_0[14:13])
	    2'b00: adc_out_freq = 2; //2Msps
	    2'b01: adc_out_freq = 1; //1Msps
	    2'b10: adc_out_freq = 0.5; //500Ksps
	    2'b11: adc_out_freq = 0.25; //250Ksps
	endcase
    end
    else adc_out_freq = 2;
end

reg adc_ckout_i;
wire adc_en;
reg start_i_1;
reg [9:0] adc_dout_i;

initial adc_ckout_i = 1'b0;
assign adc_en = pu_reset&&ADC_START;

always #(500/adc_out_freq) begin
    if (adc_en)
	adc_ckout_i = ~adc_ckout_i;
    else
	adc_ckout_i = 1'b0;
end

always @(posedge adc_ckout_i or negedge adc_en) begin
    if (!adc_en) begin
	start_i_1 <= 1'b0;
    end
    else begin
	start_i_1 <= ADC_START;
    end
end

initial adc_dout_i = 10'b0;

always @(posedge adc_ckout_i or negedge adc_en) begin
    if (!adc_en)
	adc_dout_i <= 10'b0;
    else if (start_i_1)
	adc_dout_i <= #0.2 adc_dout_i + 1'b1;
    else
	adc_dout_i <= 10'b0;
end
	
assign ADC_DOUT =  (pr_rdy === 1'b1) ? (adc_en ? adc_dout_i : 10'b0) : 10'bx;
assign ADC_CKOUT = (pr_rdy === 1'b1) ? adc_ckout_i : 1'bx;


endmodule
