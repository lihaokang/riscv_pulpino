//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : apb_adc_control             				    //
//  				Author       : huiyng cao                   				//
//  				Description  : control adc by apb         				    //
//  				Create Date  : 2019/01/19                 				    //
//                    				                        				    //
//==============================================================================//
module adc_control(
	//system signal
    input       		pclk,
	input				prst_n,
	input				clk_32m,
	//adc control    
	output reg			adc_start,
	output wire			adc_rstb,
	output reg[07:00]	adc_in_sel,
	//from adc data	
	input				adc_ckout,
    input [09:00]  		adc_dout,
	
	//signal interactive with apb	
	input    			adc_start_apb,
	input    			adc_rstb_apb,
	input [07:00]		adc_in_sel_apb,
	
	input				adc_select_apb,
	input				adc_scan_apb,
	input				adc_onthot_apb,
	input				adc_sequential_apb,
	
	input  [15:00]		adc_round_num_apb,
	input  [15:00]		adc_fifo_half_apb,
	input  [15:00]		adc_fifo_full_apb,
	output [15:00]		adc_fifo_real_num_apb,
	output wire  		adc_half_interrupt,
	output wire			adc_full_interrupt,
	
	output reg[09:00]	adc_dout_apb,
	output reg			adc_doutflag_apb,
	
    input  				rd_clk_apb,
	input  				rd_en_apb,
	output wire[09:00] 	dout_apb,
	output wire 		valid_apb,
	output wire 		empty_apb,
	output wire 		full_apb);  
	
	//edge sample circuit	
	assign  adc_rstb = adc_rstb_apb;
	reg 	adc_start_apb_r0,adc_rstb_apb_r0,adc_ckout_r0;
	reg 	adc_start_apb_r1,adc_rstb_apb_r1,adc_ckout_r1;
	reg     adc_doutflag_apb_r0,adc_doutflag_apb_r1;
	wire 	adc_start_apb_pos,adc_rstb_apb_pos,adc_ckout_neg;
	assign 	adc_start_apb_pos= ~adc_start_apb_r1 & adc_start_apb_r0;
	assign 	adc_rstb_apb_pos = ~adc_rstb_apb_r1  & adc_rstb_apb_r0;
	assign 	adc_ckout_neg    = ~adc_ckout_r0     & adc_ckout_r1;
	assign 	adc_doutflag_apb_pos = ~adc_doutflag_apb_r1  & adc_doutflag_apb_r0;
	wire rstb = prst_n & adc_rstb;
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_start_apb_r0<=0;
					adc_start_apb_r1<=0;
					adc_rstb_apb_r0	<=0;
					adc_rstb_apb_r1	<=0;
					adc_ckout_r0	<=0;
					adc_ckout_r1	<=0;	
					adc_doutflag_apb_r0<=0;	
					adc_doutflag_apb_r1<=0;	
				end
			else
				begin
					adc_start_apb_r0<=adc_start_apb;
					adc_start_apb_r1<=adc_start_apb_r0;
					adc_rstb_apb_r0	<=adc_rstb_apb;
					adc_rstb_apb_r1	<=adc_rstb_apb_r0;
					adc_ckout_r0	<=adc_ckout;
					adc_ckout_r1	<=adc_ckout_r0;
					adc_doutflag_apb_r0<=adc_doutflag_apb;
					adc_doutflag_apb_r1<=adc_doutflag_apb_r0;
				end
		end
	//control signal generate state machine
	parameter     adc_idle 			=0,
				  adc_start_sample	=1,
				  adc_select_wait	=2,
				  adc_mux			=3,
				  adc_mux_wait		=4,
				  adc_round         =5;
	reg [07:00]adc_contrl_state;
	reg [07:00]scan_adc_ini;
	reg [15:00]adc_round_num;
    always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
			begin
				adc_contrl_state 	<= adc_idle;
				adc_dout_apb		<= 0;
				adc_doutflag_apb	<= 0;
				adc_start			<= 0;
				adc_round_num		<= 0;
			end
			else
			begin
			case (adc_contrl_state)
				adc_idle:
					begin
						if((adc_start_apb_pos)&&(~adc_full_interrupt))
							begin
								adc_contrl_state<=adc_start_sample;
							end
						else
							begin
								adc_contrl_state<=adc_idle;
							end
						adc_dout_apb		<= adc_dout_apb;
						adc_doutflag_apb    <= adc_doutflag_apb;
						adc_start			<= 0;
						adc_round_num		<= 0;
					end
				adc_start_sample:
				begin
					if(~adc_start_apb)
						begin
							adc_contrl_state	<= adc_idle;
							adc_dout_apb		<= adc_dout;
							adc_doutflag_apb	<= adc_doutflag_apb;
						end
					else
						begin
							if(adc_ckout_neg)
								begin					
									if((~adc_select_apb)&&(adc_scan_apb))adc_contrl_state	<= adc_mux;
									else adc_contrl_state<= adc_select_wait;
									adc_dout_apb		<= adc_dout;
									adc_doutflag_apb	<= 1;
								end
							else 
								begin
									adc_contrl_state	<= adc_start_sample;
									adc_dout_apb		<= adc_dout_apb;
									adc_doutflag_apb	<= 0;
								end	
						end
					
					adc_start			<= 1;
					adc_round_num		<= adc_round_num;
					
				end
				adc_select_wait:
					begin
						if(adc_start_apb)
							begin
								if((~adc_onthot_apb)&&(adc_sequential_apb))
									begin
										if(~adc_full_interrupt)
											begin
												adc_contrl_state<=adc_start_sample;
												adc_start		<= 1;
											end
										else
											begin
												adc_contrl_state<=adc_select_wait;
												adc_start		<= 0;
											end
									end
								else
									begin
										adc_contrl_state<=adc_idle;
										adc_start		<= 0;
									end
							end
						else
							begin
								adc_contrl_state<=adc_idle;
								adc_start		<= 0;
							end
						
						adc_dout_apb		<= adc_dout_apb;
						adc_doutflag_apb	<= adc_doutflag_apb;
						adc_round_num		<= adc_round_num;
					end
				adc_mux:
					begin
						if(adc_start_apb)
							begin
								if(adc_full_interrupt)
									begin
										adc_contrl_state	<= adc_mux_wait;
										adc_start			<= 0;
										adc_dout_apb		<= adc_dout_apb;
										adc_doutflag_apb	<= adc_doutflag_apb;
										adc_round_num		<= adc_round_num;
									end
								else
									begin
										adc_contrl_state	<= adc_round;
										adc_start			<= 0;
										adc_dout_apb		<= adc_dout_apb;
										adc_doutflag_apb	<= adc_doutflag_apb;
										adc_round_num		<= adc_round_num;
									end
							end
						else
							begin
								adc_contrl_state	<= adc_idle;
								adc_start			<= 0;
								adc_dout_apb		<= adc_dout_apb;
								adc_doutflag_apb	<= adc_doutflag_apb;
								adc_round_num		<= adc_round_num;
							end
					end
				adc_mux_wait:
					begin
						if(adc_start_apb)
							begin
								if(~adc_full_interrupt)
									begin
										adc_contrl_state	<= adc_round;
										adc_start			<= 0;
										adc_dout_apb		<= adc_dout_apb;
										adc_doutflag_apb	<= adc_doutflag_apb;
										adc_round_num		<= adc_round_num;
									end
								else
									begin
										adc_contrl_state	<= adc_mux_wait;
										adc_start			<= 0;
										adc_dout_apb		<= adc_dout_apb;
										adc_doutflag_apb	<= adc_doutflag_apb;
										adc_round_num		<= adc_round_num;
									end
							end
						else
							begin
								adc_contrl_state	<= adc_idle;
								adc_start			<= 0;
								adc_dout_apb		<= adc_dout_apb;
								adc_doutflag_apb	<= adc_doutflag_apb;
								adc_round_num		<= adc_round_num;
							end
					end
				adc_round:
					begin
						if(adc_start_apb)
							begin
								if((~adc_onthot_apb)&&(adc_sequential_apb))
									begin
										if(adc_in_sel==scan_adc_ini)
											begin
												adc_round_num<=adc_round_num+1;
												if(adc_round_num<adc_round_num_apb)adc_contrl_state<=adc_start_sample;
												else adc_contrl_state<=adc_idle;
											end
												
										else
											begin
												adc_round_num<=adc_round_num;
												adc_contrl_state<=adc_start_sample;
											end
									end
								else
									begin
										if(adc_in_sel==scan_adc_ini)
											begin
												adc_contrl_state<=adc_idle;
											end
												
										else
											begin
												adc_contrl_state<=adc_start_sample;
											end
										adc_round_num		<= adc_round_num;
									end
								adc_start			<= 0;
								adc_dout_apb		<= adc_dout_apb;
								adc_doutflag_apb	<= adc_doutflag_apb;
							end
						else
							begin
								adc_contrl_state 	<= adc_idle;
								adc_dout_apb		<= adc_dout_apb;
								adc_doutflag_apb	<= adc_doutflag_apb;
								adc_start			<= 0;
								adc_round_num		<= adc_round_num;
							end
						end
				default:
				begin
					adc_contrl_state 	<= adc_idle;
					adc_dout_apb		<= 0;
					adc_doutflag_apb	<= 0;
					adc_start			<= 0;
					adc_round_num		<= 0;
				end
			endcase
			end
		end
	//adc input select signal generate
	
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
				scan_adc_ini<=8'b1000_0000;
				adc_in_sel <=8'b1000_0000;
				end
			else if(adc_contrl_state!=adc_start_sample)
				begin
					if((~adc_select_apb)&&(adc_scan_apb))
						begin
							if(adc_contrl_state==adc_idle)
								begin
									if		(adc_in_sel_apb[7])
										begin
										scan_adc_ini<=8'b1000_0000;
										adc_in_sel	<=8'b1000_0000;
										end						
									else if	(adc_in_sel_apb[6])
										begin
										scan_adc_ini<=8'b0100_0000;
										adc_in_sel	<=8'b0100_0000;
										end						
									else if	(adc_in_sel_apb[5])
										begin
										scan_adc_ini<=8'b0010_0000;
										adc_in_sel	<=8'b0010_0000;
										end						
									else if	(adc_in_sel_apb[4])
										begin
										scan_adc_ini<=8'b0001_0000;
										adc_in_sel	<=8'b0001_0000;
										end						
									else if	(adc_in_sel_apb[3])
										begin
										scan_adc_ini<=8'b0000_1000;
										adc_in_sel	<=8'b0000_1000;
										end						
									else if	(adc_in_sel_apb[2])
										begin
										scan_adc_ini<=8'b0000_0100;
										adc_in_sel	<=8'b0000_0100;
										end						
									else if	(adc_in_sel_apb[1])
										begin
										scan_adc_ini<=8'b0000_0010;
										adc_in_sel	<=8'b0000_0010;
										end						
									else if	(adc_in_sel_apb[0])
										begin
										scan_adc_ini<=8'b0000_0001;
										adc_in_sel	<=8'b0000_0001;
										end						
									else					   
										begin
										scan_adc_ini<=8'b1000_0000;
										adc_in_sel	<=8'b1000_0000;
										end						
								end
							else if(adc_contrl_state==adc_mux)
								begin
									case(adc_in_sel)
										8'b1000_0000:
											begin
												if		(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else					   adc_in_sel<=8'b1000_0000;
											end
										8'b0100_0000:
											begin
												if		(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else					   adc_in_sel<=8'b0100_0000;
											end
										8'b0010_0000:
											begin
												if		(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else					   adc_in_sel<=8'b0010_0000;
											end
										8'b0001_0000:
											begin
												if		(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else					   adc_in_sel<=8'b0001_0000;
											end
										8'b0000_1000:
											begin
												if		(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else					   adc_in_sel<=8'b0000_1000;
											end
										8'b0000_0100:
											begin
												if		(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else					   adc_in_sel<=8'b0000_0100;
											end
										8'b0000_0010:
											begin
												if		(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else if	(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else					   adc_in_sel<=8'b0000_0010;
											end
										8'b0000_0001:
											begin
												if		(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else					   adc_in_sel<=8'b0000_0001;
											end
										default:
											begin
												if		(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else					   adc_in_sel<=8'b1000_0000;
											end
									endcase
									scan_adc_ini<=scan_adc_ini;
								end
							else 
								begin
									adc_in_sel<=adc_in_sel;
									scan_adc_ini<=scan_adc_ini;
								end
						end
					else
						begin
							if		(adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
							else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
							else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
							else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
							else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
							else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
							else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
							else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
							else					   adc_in_sel<=8'b1000_0000;
							scan_adc_ini<=scan_adc_ini;
							
						end
				end
			else 
				begin
					scan_adc_ini<=scan_adc_ini;
					adc_in_sel <=adc_in_sel;
				end
		end

	reg adc_fifo_wr_en;
	reg [9:0]adc_fifo_din;
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_fifo_wr_en<=0;
					adc_fifo_din<=0;
				end
			else
				begin
					if(adc_doutflag_apb_pos)
						begin
							adc_fifo_wr_en<=1;
							adc_fifo_din<=adc_dout_apb;
						end
					else
						begin
							adc_fifo_wr_en<=0;
							adc_fifo_din<=adc_fifo_din;
						end
				end
		end
	fifo_async adc_fifo_async 
		(
		.rst(~rstb),
		.wr_clk(clk_32m),
		.wr_en(adc_fifo_wr_en),
		.din(adc_fifo_din),         
		.rd_clk(rd_clk_apb),
		.rd_en(rd_en_apb),
		.valid(valid_apb),
		.dout(dout_apb),
		.empty(empty_apb),
		.full(full_apb),
		
		.adc_fifo_half(adc_fifo_half_apb),
		.adc_fifo_full(adc_fifo_full_apb),
		.fifo_real_num(adc_fifo_real_num_apb),
		.adc_half(adc_half_interrupt),
		.adc_full(adc_full_interrupt)
		);
endmodule
