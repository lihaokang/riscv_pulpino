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
`include "adc_define.sv"

module apb_adc_control
	`ifdef cosim
		#(
		parameter APB_ADDR_WIDTH = 12  //APB slaves are 4KB by default
		)
	`else
	`endif
	
	(
	//APB BUS
    input       		pclk,
    input       		prst_n,
    input       		pwrite,
    input       		psel,
    input       		penable,
	`ifdef cosim
		input  [APB_ADDR_WIDTH-1:00]      paddr,
	`else
		input  [31:00]      paddr,
	`endif
    
    input  [31:00]      pwdata,
    output reg [31:00]  prdata,
    output wire     	pready,
	output wire         pslverr,
	//adc control
	input               rc32m_pd,
    input				clk_32m,
	output wire [15:00] regin0,regin1,

	output wire         adc_clk,
    output wire         adc_start,
    output wire         adc_rstb,
	input				adc_ckout,
    input  [09:00]  	adc_dout,
	
	output wire         adc_half_interrupt,
    output wire         adc_full_interrupt);
	assign pslverr = 0;
	assign adc_clk=clk_32m;
	//==========ADC CONFIG signal list=============================//
	reg  [01:00]adc_speed_control_apb,adc_vrp_sel_apb;
	reg	        adc_vrm_sel_apb;
	reg  [07:00]adc_in_sel_apb;
	reg         adc_pd_apb;
	reg  [15:00]adc_round_num_apb,adc_fifo_half_apb,adc_fifo_full_apb,adc_fifo_real_num_apb;
	wire [01:00]adc_speed_control,adc_vrp_sel;
	wire	    adc_vrm_sel;
	wire [07:00]adc_in_sel;
	wire        adc_pd;
	assign adc_speed_control = adc_speed_control_apb; 
	assign adc_vrp_sel = adc_vrp_sel_apb;
	assign adc_vrm_sel = adc_vrm_sel_apb; 
	assign adc_pd = adc_pd_apb; 
	
	assign regin0 = {1'b0,adc_speed_control,1'b0,adc_vrm_sel,adc_vrp_sel,adc_in_sel,adc_pd};
	assign regin1 = 16'b0; 
	//==========ADC control signal list=============================//
    reg    adc_start_apb;
	reg    adc_rstb_apb=1;
	reg    half_enabe_apb,full_enable_apb;
	wire         adc_half_interrupt_apb;
    wire         adc_full_interrupt_apb;
	assign adc_half_interrupt =(half_enabe_apb)? adc_half_interrupt_apb:0;
	assign adc_full_interrupt =(full_enable_apb)?adc_full_interrupt_apb:0;
    reg    adc_select_apb,adc_scan_apb,adc_onthot_apb,adc_sequential_apb;
    	
	wire    [09:00] adc_dout_apb;
	wire    adc_doutflag_apb;//-1 active -0 deactive
	
	wire  	rd_en_apb;
	wire 	[13:00] dout_apb;
	wire  	valid_apb;
	wire  	empty_apb;
	wire  	full_apb;
	wire    rstb;
	adc_control uadc_control(
	//system signal
		.pclk(pclk),
		.prst_n(prst_n),
		.rc32m_pd(rc32m_pd),
		.clk_32m(clk_32m),
//		.rstn(rstn),
	//to adc control   
		.adc_start(adc_start),
		.adc_rstb(adc_rstb),
		.adc_in_sel(adc_in_sel),
	//from adc data	
		.adc_ckout(adc_ckout),
		.adc_dout(adc_dout),
    //signal interactive with apb
		.adc_start_apb(adc_start_apb),
		.adc_rstb_apb(adc_rstb_apb),
		.adc_in_sel_apb(adc_in_sel_apb),
		
		.adc_select_apb(adc_select_apb),
		.adc_scan_apb(adc_scan_apb),
		.adc_onthot_apb(adc_onthot_apb),
		.adc_sequential_apb(adc_sequential_apb),
		
		.adc_round_num_apb(adc_round_num_apb),
		.adc_fifo_full_apb(adc_fifo_full_apb),
		.adc_fifo_half_apb(adc_fifo_half_apb),
		.adc_fifo_real_num_apb(adc_fifo_real_num_apb),
		.adc_half_interrupt(adc_half_interrupt_apb),
		.adc_full_interrupt(adc_full_interrupt_apb),
		
		.adc_dout_apb(adc_dout_apb),
		.adc_doutflag_apb(adc_doutflag_apb),
		
		.rd_clk_apb(pclk),
		.rd_en_apb(rd_en_apb),
		.dout_apb(dout_apb),
		.valid_apb(valid_apb),
		.empty_apb(empty_apb),
		.full_apb(full_apb),
		.rstb(rstb));
		
	//===========control register address list=====================//
	`ifdef cosim
		parameter     ADC_BA 	= 'h1A10_8000;//base address of adc_control
		parameter     ADC_CFG_REG 	=   'h000;//adc config
		parameter     ADC_ROUND_NUM =   'h004;//adc round number
		parameter     ADC_FIFO_INT 	=   'h008;//adc fifo interrupt number
		parameter     ADC_CTL_REG 	=   'h00C;//adc control
		parameter     ADC_DOUT_REG 	=   'h010;//adc data output
		parameter     ADC_FIFO_STATE=   'h014;//adc fifo state
	`else
		parameter     ADC_BA 	= 'h1B00_4000;//base address of adc_control
		parameter     ADC_CFG_REG 	= ADC_BA + 'h00;//adc config
		parameter     ADC_ROUND_NUM = ADC_BA + 'h04;//adc round number
		parameter     ADC_FIFO_INT 	= ADC_BA + 'h08;//adc fifo interrupt number
		parameter     ADC_CTL_REG 	= ADC_BA + 'h0C;//adc control
		parameter     ADC_DOUT_REG 	= ADC_BA + 'h10;//adc data output
		parameter     ADC_FIFO_STATE= ADC_BA + 'h14;//adc fifo state
		
		parameter     ADC_test1_REG 	= ADC_BA + 'h100;
		parameter     ADC_test2_REG     = ADC_BA + 'h104;
		parameter     ADC_test3_REG 	= ADC_BA + 'h108;
	`endif
	
	//=====================APB BUS operation=======================//
    wire   apb_wr_en,apb_rd_en;
    
    assign apb_wr_en = pwrite && penable;
    assign apb_rd_en =~pwrite && penable;
    assign pready = 1;
    assign rd_en_apb = ((~empty_apb)&&(paddr==ADC_DOUT_REG))?apb_rd_en:0;
    //APB BUS write operation
    always@(posedge pclk or negedge rstb)
        begin
            if(~rstb)
                begin
                    adc_speed_control_apb 	<= 2'b0;
                    adc_vrm_sel_apb 	 	<= 1'b0;
                    adc_vrp_sel_apb 		<= 2'b0;
					adc_in_sel_apb			<= 8'b0000_0000;
					adc_pd_apb				<= 1'b0;
					
//					adc_rstb_apb		<= 1;
					adc_start_apb       <= 0;
					half_enabe_apb		<= 1;
					full_enable_apb		<= 1;
					adc_select_apb		<= 1;
					adc_scan_apb		<= 0;
					adc_onthot_apb		<= 1;
					adc_sequential_apb  <= 0;
					
					adc_round_num_apb 	<= 1;
					adc_fifo_half_apb	<= 8;
					adc_fifo_full_apb   <= 16;
                end
            else if(apb_wr_en)
                begin
					case (paddr)
						ADC_CFG_REG:
							begin
								adc_speed_control_apb 	<= pwdata[14:13];
								adc_vrm_sel_apb 	 	<= pwdata[11];
								adc_vrp_sel_apb 		<= pwdata[10:09];
								adc_in_sel_apb			<= pwdata[08:01];
								adc_pd_apb				<= pwdata[00];
								
								adc_select_apb		<= pwdata[19];
								adc_scan_apb		<= pwdata[18];
								adc_onthot_apb		<= pwdata[17];
								adc_sequential_apb  <= pwdata[16];
							end
						ADC_CTL_REG:
							begin
								adc_rstb_apb		<= pwdata[00];
								adc_start_apb       <= pwdata[01];
								half_enabe_apb		<= pwdata[02];
								full_enable_apb		<= pwdata[03];
								
							end
						ADC_ROUND_NUM:adc_round_num_apb <= pwdata[15:00];
						ADC_FIFO_INT:
							begin
								adc_fifo_full_apb       <= pwdata[31:16];
								adc_fifo_half_apb		<= pwdata[15:00];
							end
						default:
							begin
								adc_speed_control_apb 	<= 2'b0;
								adc_vrm_sel_apb 	 	<= 1'b0;
								adc_vrp_sel_apb 		<= 2'b0;
								adc_in_sel_apb			<= 8'b0000_0000;
								adc_pd_apb				<= 1'b0;
								
								adc_rstb_apb		<= 1;
								adc_start_apb       <= 0;
								half_enabe_apb		<= 1;
								full_enable_apb		<= 1;
								adc_select_apb		<= 1;
								adc_scan_apb		<= 0;
								adc_onthot_apb		<= 1;
								adc_sequential_apb  <= 0;
								
								adc_round_num_apb 	<= 1;
								adc_fifo_half_apb	<= 8;
								adc_fifo_full_apb   <= 16;
							end
					endcase
                end
        end

	reg [15:00]adc_half_pcnt,adc_full_pcnt,empty_pcnt,full_pcnt;
	reg [15:00]rstb_ncnt=0; 
		
	always@(*)
		begin
			if(~rstb)
				begin
					prdata <= 32'h0;
				end
			
			else if(apb_rd_en)
				begin
					case (paddr)
						ADC_CFG_REG:	prdata <= {12'b0,adc_select_apb,adc_scan_apb,adc_onthot_apb,adc_sequential_apb,1'b0,adc_speed_control_apb,
												   1'b0,adc_vrm_sel_apb,adc_vrp_sel_apb,adc_in_sel_apb,adc_pd_apb};
						ADC_ROUND_NUM:	prdata <= {16'b0,adc_round_num_apb};
						ADC_FIFO_INT:	prdata <= {adc_fifo_full_apb,adc_fifo_half_apb};
						ADC_CTL_REG:	prdata <= {28'b0,full_enable_apb,half_enabe_apb,adc_start_apb,adc_rstb_apb};
						ADC_FIFO_STATE:	prdata <= {adc_fifo_real_num_apb,12'b0,adc_half_interrupt,adc_full_interrupt,empty_apb,full_apb};
						ADC_DOUT_REG:	prdata <= {18'b0,dout_apb};
						
						ADC_test1_REG:  prdata <= {adc_full_pcnt,adc_half_pcnt};
						ADC_test2_REG:  prdata <= {full_pcnt,empty_pcnt};
						ADC_test3_REG:  prdata <= {16'h0,rstb_ncnt};
						default:		prdata <= 32'h0;
					endcase
				end 
			else prdata <= 32'h0;
		end
//////////////////////////////test cod///////////////////////////////////
	reg 	adc_half_interrupt_r0,adc_full_interrupt_r0,empty_apb_r0,full_apb_r0;
	reg     rstb_r0=0;
	reg 	adc_half_interrupt_r1,adc_full_interrupt_r1,empty_apb_r1,full_apb_r1;
	reg     rstb_r1=0;
	wire    adc_half_interrupt_pos,adc_full_interrupt_pos;
	wire    empty_apb_pos,full_apb_pos;
	wire    rstb_neg;
	
	assign 	adc_half_interrupt_pos= ~adc_half_interrupt_r1 & adc_half_interrupt_r0;
	assign 	adc_full_interrupt_pos= ~adc_full_interrupt_r1 & adc_full_interrupt_r0;
	assign 	empty_apb_pos= ~empty_apb_r1 & empty_apb_r0;
	assign 	full_apb_pos = ~full_apb_r1  & full_apb_r0;
	assign 	rstb_neg     = ~rstb_r0      & rstb_r1;
	
	
	always@(posedge pclk)
		begin
			rstb_r0<=rstb;
			rstb_r1<=rstb_r0;
			if(rstb_neg)rstb_ncnt<=rstb_ncnt+1;
			else rstb_ncnt<=rstb_ncnt;
		end
	
	always@(posedge pclk or negedge rstb)
		begin
			if(~rstb)
				begin
					adc_half_interrupt_r0<=0;
					adc_half_interrupt_r1<=0;
					
					adc_full_interrupt_r0<=0;
					adc_full_interrupt_r1<=0;
					
					empty_apb_r0<=0;	
					empty_apb_r1<=0;	
					
					full_apb_r0<=0;	
					full_apb_r1<=0;
					
					adc_half_pcnt<=0;	
					adc_full_pcnt<=0;	
					empty_pcnt<=0;	
					full_pcnt<=0;	
				end
			else
				begin
					adc_half_interrupt_r0<=adc_half_interrupt;
					adc_half_interrupt_r1<=adc_half_interrupt_r0;
					
					adc_full_interrupt_r0<=adc_full_interrupt;
					adc_full_interrupt_r1<=adc_full_interrupt_r0;
					
					empty_apb_r0<=empty_apb;
					empty_apb_r1<=empty_apb_r0;
					
					full_apb_r0<=full_apb;
					full_apb_r1<=full_apb_r0;
					

					if(adc_half_interrupt_pos)adc_half_pcnt<=adc_half_pcnt+1;
					else adc_half_pcnt<=adc_half_pcnt;
					
					if(adc_full_interrupt_pos)adc_full_pcnt<=adc_full_pcnt+1;
					else adc_full_pcnt<=adc_full_pcnt;
					
					if(empty_apb_pos)empty_pcnt<=empty_pcnt+1;
					else empty_pcnt<=empty_pcnt;
					
					if(full_apb_pos)full_pcnt<=full_pcnt+1;
					else full_pcnt<=full_pcnt;
				end
		end

endmodule
