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
`timescale 1ns/1ps
`include "adc_define.sv"

module adc_th;
	reg clk_32m;	
	reg clk_32M_divider;//soc internal 32M

	reg  [15:00] ADC_REG_IN_0;
	reg  [15:00] ADC_REG_IN_1;
	reg  [01:00] ADC_BIAS20U;
	reg  [07:00] ADC_IN;

	reg ADC_RESETB_TP;
	reg ADC_START_TP;
	reg ADC_VBG_IN;
	reg ADC_VRM_AVSS;
	reg ADC_VRM_EXT;
	reg ADC_VRP_EXT;
	reg ADC_VRP_VCC;
	reg AVSS;
	reg VCC;
    reg ADC_ANA_TP;

	wire [09:00] ADC_DOUT_TP;
	wire ADC_CKOUT_TP;
	//APB BUS signals
	wire         pclk,pready;
	assign       pclk = clk_32M_divider;
	wire [31:00] prdata;
	reg          prst_n,rc32m_pd,pwrite,psel,penable;
	reg  [31:00] pwdata,paddr;
//	reg          rstn;
	wire         adc_start,adc_rstb;
	reg          adc_ckout;
	reg  [09:00] adc_dout;
    wire [15:00] regin0,regin1;
	//parameter list
	//================== register address list=====================//
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
	`endif
	//================config register setting======================//
	// adc_speed_control_apb 	<= pwdata[14:13];
	// adc_vrm_sel_apb 	 	    <= pwdata[11];
	// adc_vrp_sel_apb 		    <= pwdata[10:09];
	// adc_in_sel_apb			<= pwdata[08:01];
	// adc_pd_apb				<= pwdata[00];
	
	// adc_select_apb		    <= pwdata[19];
	// adc_scan_apb		        <= pwdata[18];
	// adc_onthot_apb		    <= pwdata[17];
	// adc_sequential_apb       <= pwdata[16];
	//================config register setting======================//
	// mod/3:0/--select--scan--onthot--sequential
	parameter     slect_onehot				= 4'b1010;
	parameter     slect_seq   				= 4'b1001;
	parameter     ADC_CFG_DEAFAULT  		= 32'b0000_0000_0000_1010_0000_0000_0000_0000;//slect-onehot_adcin7=1
	parameter     ADC_CFG_mod1010_ad4   	= 32'b0000_0000_0000_1010_0000_0000_0010_0000;//slect-onehot_adcin4=1
	parameter     ADC_CFG_mod1010_ad3210  	= 32'b0000_0000_0000_1010_0000_0000_0001_1110;//slect-onehot_adcin0123=1;
	parameter     ADC_CFG_mod1001_ad3210  	= 32'b0000_0000_0000_1001_0000_0000_0001_1110;//slect-sequential_adcin01234=1;
	parameter     ADC_CFG_mod0110_ad643210  = 32'b0000_0000_0000_0110_0000_0000_1011_1110;//scan-onehot_adcin012346=1;
	parameter     ADC_CFG_mod0101_ad43210  	= 32'b0000_0000_0000_0101_0000_0000_0011_1110;//scan-sequential_adcin01234=1;
	parameter     ADC_CFG_mod0101_ad643210  = 32'b0000_0000_0000_0101_0000_0000_1011_1110;//scan-sequential_adcin012346=1;
	parameter     ADC_CFG_mod0101_ad7_0     = 32'b0000_0000_0000_0101_0000_0001_1111_1110;//scan-sequential_adcin012346=1;
    //===============control register setting======================//
	// adc_rstb_apb				<= pwdata[00];
	// adc_start_apb       		<= pwdata[01];
	//===============control register setting======================//
	parameter     ADC_CTL_RST  			= 32'h0000_0000;
	parameter     ADC_CTL_CLEAR		  	= 32'h0000_000D;
	parameter     ADC_CTL_STR   		= 32'h0000_000f;
	parameter     ADC_FIFO_OVERFLOW     = 32'h0010_0008;
    //=============================================================//
	initial
	begin
		prst_n	= 1;
		rc32m_pd= 0;
		psel 	= 1'b0;
		penable = 1'b0;
		pwrite 	= 1'b0;
		pwdata 	= 32'h0;
		paddr 	= 32'h0;
		//#200;
		//prst_n 	=1;
		#200;
		rc32m_pd=1;
		#200;
		rc32m_pd=0;
		//adc_cfg_default();
		//adc_cfg_slect_onehot(1);//adc in shift 8 times
		//adc_cfg_slect_seq(1);
		//adc_cfg_slect_onehot(0);  //adc in counter++ 256 times
		//adc_cfg_slect_sequential();
		//adc_cfg_scan_onehot();
		adc_cfg_scan_sequential();
		//read_register();
        //read_register();
        //read_register();
        //read_register();
		//apb_read(ADC_DOUT_REG,1);
		
		#10000;
		$finish(2);
	end
wire adc_clk;

`ifdef fpga

SAR_TOP_fpga U_SAR_TOP( 
		.ADC_ANA_TP			(ADC_ANA_TP), 
		.ADC_CKOUT			(ADC_CKOUT_TP), 
		.ADC_DOUT			(ADC_DOUT_TP), 
		.ADC_BIAS20U		(ADC_BIAS20U), 
		.ADC_CLKIN			(adc_clk), 
		.ADC_IN				(ADC_IN),

		.ADC_REG_IN_0	    (ADC_REG_IN_0), 
		.ADC_REG_IN_1		(ADC_REG_IN_1), 
		.ADC_RESETB			(ADC_RESETB_TP), 
		.ADC_START			(ADC_START_TP), 
		.ADC_VBG_IN			(ADC_VBG_IN), 
		.ADC_VRM_AVSS		(ADC_VRM_AVSS),

		.ADC_VRM_EXT		(ADC_VRM_EXT), 
		.ADC_VRP_EXT		(ADC_VRP_EXT), 
		.ADC_VRP_VCC		(ADC_VRP_VCC), 
		.AVSS				(AVSS), 
		.VCC 				(VCC )
		);


`else

SAR_TOP U_SAR_TOP( 
		.ADC_ANA_TP			(ADC_ANA_TP), 
		.ADC_CKOUT			(ADC_CKOUT_TP), 
		.ADC_DOUT			(ADC_DOUT_TP), 
		.ADC_BIAS20U		(ADC_BIAS20U), 
		.ADC_CLKIN			(adc_clk), 
		.ADC_IN				(ADC_IN),

		.ADC_REG_IN_0	    (ADC_REG_IN_0), 
		.ADC_REG_IN_1		(ADC_REG_IN_1), 
		.ADC_RESETB			(ADC_RESETB_TP), 
		.ADC_START			(ADC_START_TP), 
		.ADC_VBG_IN			(ADC_VBG_IN), 
		.ADC_VRM_AVSS		(ADC_VRM_AVSS),

		.ADC_VRM_EXT		(ADC_VRM_EXT), 
		.ADC_VRP_EXT		(ADC_VRP_EXT), 
		.ADC_VRP_VCC		(ADC_VRP_VCC), 
		.AVSS				(AVSS), 
		.VCC 				(VCC )
		);

`endif

apb_adc_control u_apb_adc_control(
		.rc32m_pd(rc32m_pd),
	//APB BUS
		.pclk(pclk),
		.prst_n(prst_n),
		.pwrite(pwrite),
		.psel(psel),
		.penable(penable),
		.paddr(paddr),
		.pwdata(pwdata),
		.prdata(prdata),
		.pready(pready),
	//adc control
		.clk_32m(clk_32m),
		.regin0(regin0),
		.regin1(regin1),

        .adc_clk(adc_clk),
		.adc_start(adc_start),
		.adc_rstb(adc_rstb),
		.adc_ckout(adc_ckout),
		.adc_dout(adc_dout),
		.adc_half_interrupt(),
		.adc_full_interrupt());

initial clk_32m = 1'b0;
real clkin_freq = 32;
always #(500/clkin_freq) clk_32m = ~clk_32m;

initial clk_32M_divider = 1'b0;
parameter PERID_32M = 31.2;
always 
	#(PERID_32M/2) clk_32M_divider<= ~clk_32M_divider;


`ifdef fpga

`else

initial begin
//    $fsdbDumpfile("adc_th.fsdb");
//    $fsdbDumpvars(0,adc_th);
end

`endif


always @(*)
	begin
		ADC_START_TP	= adc_start;
		ADC_RESETB_TP	= adc_rstb;
		ADC_REG_IN_0	= regin0;
		ADC_REG_IN_1	= regin1;
		adc_ckout   	= ADC_CKOUT_TP;
		adc_dout    	= ADC_DOUT_TP;
	end
	
initial begin
	default_value;
//    test_case;
    #5000_000;
    $finish;
end
//function task list
	task adc_cfg_default;
		begin
			#500;
			apb_write(ADC_CFG_REG,ADC_CFG_DEAFAULT);
			#500;
			apb_write(ADC_CTL_REG,ADC_CTL_STR);
			#1000;
			apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
			#500;
			apb_read(ADC_DOUT_REG,1);
			
			
		end
	endtask
	
	task adc_cfg_slect_onehot;//if shift == 1 then adc in shift,else adc_in ++
		input shift;
		begin
			reg [07:00]adc_in_ini=8'b1000_0000;
			reg [31:00]ADC_CFG_slect_onehot = {12'b0,slect_onehot,7'b0,adc_in_ini,1'b0};
			reg [07:00]i;
			if(shift)
				begin
					for(i=0;i<9;i=i+1)begin
					#500;
					apb_write(ADC_CFG_REG,ADC_CFG_slect_onehot);
					#500;
					apb_write(ADC_CTL_REG,ADC_CTL_STR);
					#1000;
					apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
					adc_in_ini=adc_in_ini>>1;
					ADC_CFG_slect_onehot = {12'b0,slect_onehot,7'b0,adc_in_ini,1'b0};end
					#500;
					apb_read(ADC_DOUT_REG,10);
				end
			else
				begin
					for(i=0;i<255;i=i+1)begin
					#500;
					apb_write(ADC_CFG_REG,ADC_CFG_slect_onehot);
					#500;
					apb_write(ADC_CTL_REG,ADC_CTL_STR);
					#1000;
					apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
					adc_in_ini=adc_in_ini+1;
					ADC_CFG_slect_onehot = {12'b0,slect_onehot,7'b0,adc_in_ini,1'b0};end
					#500;
					apb_read(ADC_DOUT_REG,20);
				end
		end
	endtask
	
	task adc_cfg_slect_seq;//if shift == 1 then adc in shift,else adc_in ++
		input shift;
		begin
			reg [07:00]adc_in_ini=8'b1000_0000;
			reg [31:00]ADC_CFG_slect_seq = {12'b0,slect_seq,7'b0,adc_in_ini,1'b0};
			reg [07:00]i;
			if(shift)
				begin
					for(i=0;i<8;i=i+1)begin
					#500;
					apb_write(ADC_CFG_REG,ADC_CFG_slect_seq);
					#500;
					apb_write(ADC_ROUND_NUM,1);
					#500;
					apb_write(ADC_CTL_REG,ADC_CTL_STR);
					#1000;
					apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
					adc_in_ini=adc_in_ini>>1;
					ADC_CFG_slect_seq = {12'b0,slect_seq,7'b0,adc_in_ini,1'b0};end
					#5000;
					apb_read(ADC_FIFO_STATE,1);
					apb_read(ADC_DOUT_REG,10);
					apb_read(ADC_FIFO_STATE,1);
				end
			else
				begin
					// for(i=0;i<255;i=i+1)begin
					// #500;
					// apb_write(ADC_CFG_REG,ADC_CFG_slect_onehot);
					// #500;
					// apb_write(ADC_CTL_REG,ADC_CTL_STR);
					// #1000;
					// apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
					// adc_in_ini=adc_in_ini+1;
					// ADC_CFG_slect_onehot = {12'b0,slect_onehot,7'b0,adc_in_ini,1'b0};end
					// #500;
					// apb_read(ADC_DOUT_REG,20);
				end
		end
	endtask
	
	task adc_cfg_slect_sequential;
		begin
			#500;
			apb_write(ADC_CFG_REG,ADC_CFG_mod1001_ad3210);
			#500;
			apb_write(ADC_ROUND_NUM,0);
			#500;
			apb_write(ADC_FIFO_INT,ADC_FIFO_OVERFLOW);
			#500;
			apb_write(ADC_CTL_REG,ADC_CTL_STR);
			#50000;
			apb_read(ADC_FIFO_STATE,1);
			apb_read(ADC_DOUT_REG,24);
			// #50000;
			// apb_read(ADC_FIFO_STATE,1);
			// apb_read(ADC_DOUT_REG,2);
//			#5000;
//			apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
		end
	endtask

	task adc_cfg_scan_onehot;
		begin
			#500;
			apb_write(ADC_CFG_REG,ADC_CFG_mod0110_ad643210);
			#500;
			apb_write(ADC_FIFO_INT,ADC_FIFO_OVERFLOW);
			#500;
			apb_write(ADC_CTL_REG,ADC_CTL_STR);
//			#5000;
//			apb_read(ADC_DOUT_REG,5);
			#5000;
			apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
		end
	endtask
	
	task adc_cfg_scan_sequential;
		begin
		#500;
		apb_write(ADC_CFG_REG,ADC_CFG_mod0101_ad7_0);
		#500;
		apb_write(ADC_ROUND_NUM,6);
		#500;
		apb_write(ADC_FIFO_INT,ADC_FIFO_OVERFLOW);
		#500;
		apb_write(ADC_CTL_REG,ADC_CTL_STR);
		// #500;
		// apb_write(ADC_CTL_REG,ADC_CTL_RST);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#5000;
		apb_read(ADC_DOUT_REG,8);
		#500;
		apb_write(ADC_CTL_REG,ADC_CTL_RST);
		#500;
		apb_write(ADC_CTL_REG,ADC_CTL_STR);
		// #5000;
		// apb_read(ADC_DOUT_REG,24);
//		#30000;
//		apb_write(ADC_CTL_REG,ADC_CTL_CLEAR);
		end
	endtask
	
	task read_register;
		begin
			#500;
			apb_read(ADC_CFG_REG,1);
			#500;
			apb_read(ADC_ROUND_NUM,1);
			#500;
			apb_read(ADC_FIFO_INT,1);
			#500;
			apb_read(ADC_CTL_REG,1);
			#500;
            apb_read(ADC_DOUT_REG,1);
			#500;
			apb_read(ADC_FIFO_STATE,1);
		end
	endtask
//base task list	
	task test_case;
	begin
		#30_000;
		ADC_REG_IN_0[14:13] = 2'b01;
		#30_000;
		ADC_REG_IN_0[14:13] = 2'b10;
		#30_000;
		ADC_REG_IN_0[14:13] = 2'b11;
		#30_000;
		clkin_freq = 40;
		#30_000;
		ADC_VRP_VCC = 1'b0;
		#30_000;
		ADC_REG_IN_0[10:9] = 2'b01;
		ADC_VRP_EXT = 1'b0;
		#30_000;
		ADC_REG_IN_0[10:9] = 2'b10;
		ADC_VBG_IN = 1'b0;
		#30_000;
		ADC_VRM_AVSS = 1'b1;
		#30_000;
		ADC_REG_IN_0[11] = 1'b1;
		ADC_VRM_EXT = 1'b1;
		#30_000;
		ADC_START_TP = 1'b0;
		#30_000;
		ADC_BIAS20U = 2'b01;
		#30_000;
	end
	endtask

	task default_value;
		begin
			VCC = 1'b1;
			AVSS = 1'b0;
			ADC_BIAS20U = 2'b11;
			ADC_REG_IN_0 = 16'h0000;
//			ADC_REG_IN_0[8:1] = 8'b1000_0000;
			ADC_REG_IN_0[8:1] = 8'b0000_0000;
			ADC_REG_IN_1 = 16'h0000;
			ADC_VRM_EXT = 1'b0;
			ADC_VRM_AVSS = 1'b0;
			ADC_VRP_VCC = 1'b1;
			ADC_VRP_EXT = 1'b1;
			ADC_VBG_IN = 1'b1;
			ADC_IN = 8'b0;
			ADC_START_TP = 1'b0;
			ADC_RESETB_TP = 1'b1;

		end
	endtask

	task apb_write;
		input [31:0] addr_wr,data_wr;
		begin
			@(posedge pclk)
			paddr <= addr_wr;
			pwdata <= data_wr;
			psel <= 1'b1;
			pwrite <= 1'b1;
			`ifdef apb
			    penable <= 1'b0;
				@(posedge pclk)
				penable <= 1'b1;
			`else
				penable <= 1'b1;
				// @(posedge pclk)
				// penable <= 1'b1;
			`endif
			@(posedge pclk)
			paddr <= 32'h0;
			pwrite <= 1'b0;
			psel <= 1'b0;
			penable <= 1'b0;
			pwdata <= 32'h0;
		end
	endtask

	task apb_read;
		input [31:0] addr_rd,pkg_num;
		begin
			reg  [31:00]  i;
			for(i=0;i<pkg_num;i=i+1)begin
				#500;
				@(posedge pclk)
				paddr <= addr_rd;
				pwrite <= 1'b0;
				psel <= 1'b1;
				
				`ifdef apb
					penable <= 1'b0;
					@(posedge pclk)
					penable <= 1'b1;
				`else
					penable <= 1'b1;
					// @(posedge pclk)
					// penable <= 1'b1;
				`endif
				@(posedge pclk)
				paddr <= 32'h0;
				pwrite <= 1'b0;
				psel <= 1'b0;
				penable <= 1'b0;
			end
		end
	endtask

endmodule
