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
//                  Review Date  : 2019/02/18  				                    //
//==============================================================================//
module adc_control(
	//system signal
	input               rc32m_pd,
	input				clk_32m,
    input       		pclk,
	input				prst_n,
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
	output wire[15:00]	adc_fifo_real_num_apb,
	output wire  		adc_half_interrupt,
	output wire			adc_full_interrupt,
	
	output reg[09:00]	adc_dout_apb,
	output reg			adc_doutflag_apb,
	
    input  				rd_clk_apb,
	input  				rd_en_apb,
	output wire[13:00] 	dout_apb,
	output wire 		valid_apb,
	output wire 		empty_apb,
	output wire 		full_apb,
	output wire         rstb);  
	
	//edge sample circuit	
	
	reg 	adc_start_apb_r0,adc_ckout_r0;
	reg 	adc_start_apb_r1,adc_ckout_r1;
	reg     adc_doutflag_apb_r0,adc_doutflag_apb_r1;
	reg     adc_rstb_apb_r0=0;
	reg     adc_rstb_apb_r1=0;
	wire     adc_rstb_apb_neg;
	assign  adc_rstb_apb_neg    = (~adc_rstb_apb_r0) & adc_rstb_apb_r1;
	 
	wire 	adc_start_apb_pos,adc_ckout_neg;
	assign 	adc_start_apb_pos= ~adc_start_apb_r1 & adc_start_apb_r0;
	assign 	adc_ckout_neg    = ~adc_ckout_r0     & adc_ckout_r1;
	wire    adc_doutflag_apb_pos;
	assign 	adc_doutflag_apb_pos = ~adc_doutflag_apb_r1  & adc_doutflag_apb_r0;
	assign  adc_rstb = rstb;
	assign  rstb = prst_n & (~adc_rstb_apb_neg) & (~rc32m_pd);
	always@(posedge pclk)
		begin
			adc_rstb_apb_r0<=adc_rstb_apb;
			adc_rstb_apb_r1<=adc_rstb_apb_r0;
		end
	
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_start_apb_r0<=0;
					adc_start_apb_r1<=0;
					adc_ckout_r0	<=0;
					adc_ckout_r1	<=0;	
					adc_doutflag_apb_r0<=0;	
					adc_doutflag_apb_r1<=0;	
				end
			else
				begin
					adc_start_apb_r0<=adc_start_apb;
					adc_start_apb_r1<=adc_start_apb_r0;
					adc_ckout_r0	<=adc_ckout;
					adc_ckout_r1	<=adc_ckout_r0;
					adc_doutflag_apb_r0<=adc_doutflag_apb;
					adc_doutflag_apb_r1<=adc_doutflag_apb_r0;
				end
		end
	//control signal generate state machine
	parameter     adc_idle 			=0,
				  adc_start_sample	=1,
				  adc_select_delay  =2,
				  adc_select_wait	=3,
				  adc_mux_delay     =4,
				  adc_mux			=5,
				  adc_mux_wait		=6,
				  adc_round         =7;
	reg [07:00]adc_contrl_state;
	reg [07:00]scan_adc_ini;
	reg [15:00]adc_round_num,sel_seq_num,select_delay_cnt,mux_delay_cnt;
    always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
			begin
				adc_contrl_state 	<= adc_idle;
				adc_dout_apb		<= 0;
				adc_doutflag_apb	<= 0;
				adc_start			<= 0;
				adc_round_num		<= 0;
				select_delay_cnt    <= 0;
				mux_delay_cnt       <= 0;
				//sel_seq_num         <= 0;
			end
			else
			begin
			case (adc_contrl_state)
				adc_idle:
					begin
						if((adc_start_apb_pos)&&(~full_apb))
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
						select_delay_cnt    <= 0;
						mux_delay_cnt       <= 0;
						//sel_seq_num         <= 0;
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
									if((~adc_select_apb)&&(adc_scan_apb))adc_contrl_state	<= adc_mux_delay;
									else adc_contrl_state<= adc_select_delay;
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
				adc_select_delay:
					begin
						if(select_delay_cnt < 3)
							begin
								select_delay_cnt<=select_delay_cnt+1;
								adc_contrl_state<= adc_select_delay;
							end
						else
							begin
								select_delay_cnt<=0;
								adc_contrl_state<= adc_select_wait;
							end
					    adc_start			<= 0;
					end
				adc_select_wait:
					begin
						if(adc_start_apb)
							begin
								if((~adc_onthot_apb)&&(adc_sequential_apb))
									begin
										if(~full_apb)
											begin
												if(adc_round_num_apb==0)
													begin
													adc_contrl_state<=adc_start_sample;
													adc_start		<= 1;
													end
												else
													begin
														if(sel_seq_num<adc_round_num_apb)
															begin
																adc_contrl_state<=adc_start_sample;
																adc_start		<= 1;
																//sel_seq_num     <= sel_seq_num+1;
															end
														else
															begin
																adc_contrl_state<=adc_idle;
																adc_start		<= 0;
															end
													
													end
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
					
				adc_mux_delay:
					begin
						if(mux_delay_cnt < 3)
							begin
								mux_delay_cnt<=mux_delay_cnt+1;
								adc_contrl_state<= adc_mux_delay;
							end
						else
							begin
								mux_delay_cnt<=0;
								adc_contrl_state<= adc_mux;
							end
					    adc_start			<= 0;
					end
				adc_mux:
					begin
						if(adc_start_apb)
							begin
								if(full_apb)
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
								if(~full_apb)
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
												if(adc_round_num<(adc_round_num_apb-1))adc_contrl_state<=adc_start_sample;
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
					select_delay_cnt    <= 0;
					mux_delay_cnt       <= 0;
				end
			endcase
			end
		end
	//adc input select signal generate
	
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
				// scan_adc_ini<=8'b1000_0000;
				// adc_in_sel <=8'b1000_0000;
				scan_adc_ini<=8'b0000_0000;
				adc_in_sel  <=8'b0000_0000;
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
										// scan_adc_ini<=8'b1000_0000;
										// adc_in_sel	<=8'b1000_0000;
										scan_adc_ini<=8'b0000_0000;
										adc_in_sel	<=8'b0000_0000;
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
												if      (adc_in_sel_apb[7])adc_in_sel<=8'b1000_0000;
												else if	(adc_in_sel_apb[6])adc_in_sel<=8'b0100_0000;
												else if	(adc_in_sel_apb[5])adc_in_sel<=8'b0010_0000;
												else if	(adc_in_sel_apb[4])adc_in_sel<=8'b0001_0000;
												else if	(adc_in_sel_apb[3])adc_in_sel<=8'b0000_1000;
												else if	(adc_in_sel_apb[2])adc_in_sel<=8'b0000_0100;
												else if	(adc_in_sel_apb[1])adc_in_sel<=8'b0000_0010;
												else if	(adc_in_sel_apb[0])adc_in_sel<=8'b0000_0001;
												else					   adc_in_sel<=8'b0000_0000;
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
							else					   adc_in_sel<=8'b0000_0000;
							scan_adc_ini<=scan_adc_ini;
							
						end
				end
			else 
				begin
					scan_adc_ini<=scan_adc_ini;
					adc_in_sel <=adc_in_sel;
				end
		end
    reg [3:0]adc_channel;
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_channel<=4'b0000;
				end
			else
				begin
					case(adc_in_sel)
						8'b1000_0000:adc_channel<=4'b1000;
						8'b0100_0000:adc_channel<=4'b0111;
						8'b0010_0000:adc_channel<=4'b0110;
						8'b0001_0000:adc_channel<=4'b0101;
						8'b0000_1000:adc_channel<=4'b0100;
						8'b0000_0100:adc_channel<=4'b0011;
						8'b0000_0010:adc_channel<=4'b0010;
						8'b0000_0001:adc_channel<=4'b0001;
						default:adc_channel<=4'b0000;
					endcase
				end
		end
	reg adc_fifo_wr_en;
	reg [13:0]adc_fifo_din;
	always@(posedge clk_32m or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_fifo_wr_en<=0;
					adc_fifo_din<=0;
					sel_seq_num <=0;
				end
			else
				begin
					if((adc_ckout_neg)&&(~full_apb))
						begin
							adc_fifo_wr_en<=1;
							adc_fifo_din<={adc_channel,adc_dout};
						end
					else
						begin
							adc_fifo_wr_en<=0;
							adc_fifo_din<=adc_fifo_din;
						end
					if(adc_sequential_apb&&adc_select_apb)
						begin
							if(adc_contrl_state<=adc_idle)sel_seq_num<=0;
							else if(adc_fifo_wr_en)sel_seq_num<=sel_seq_num+1;
							else sel_seq_num<=sel_seq_num;
							
						end
					else sel_seq_num<=0;
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
