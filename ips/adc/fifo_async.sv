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
//                  Review Date  : 2019/02/14  				                    //
//==============================================================================//
module fifo_async#(
                 parameter   data_width = 14,
                 parameter   data_depth = 16,
                 parameter   addr_width = 4
)
(
                  input                           rst,
                  input                           wr_clk,
                  input                           wr_en,
                  input      [data_width-1:0]     din,         
                  input                           rd_clk,
                  input                           rd_en,
                  output reg                      valid,
                  output wire [data_width-1:0]    dout,
                  output                          empty,
                  output                          full,
				  
				  input  [15:00]		adc_fifo_half,
				  input  [15:00]		adc_fifo_full,
				  output reg[15:00]		fifo_real_num,
				  
				  output reg adc_half,adc_full
    );


reg    [addr_width:0]    wr_addr_ptr;
reg    [addr_width:0]    rd_addr_ptr;
wire   [addr_width-1:0]  wr_addr;
wire   [addr_width-1:0]  rd_addr;

wire   [addr_width:0]    wr_addr_gray;
reg    [addr_width:0]    wr_addr_gray_d1;
reg    [addr_width:0]    wr_addr_gray_d2;
wire   [addr_width:0]    rd_addr_gray;
reg    [addr_width:0]    rd_addr_gray_d1;
reg    [addr_width:0]    rd_addr_gray_d2;


reg [data_width-1:0] fifo_ram [data_depth-1:0];

//=========================================================write fifo 
integer i;
always@(posedge wr_clk or posedge rst)
    begin
       if(rst)
          for(i = 0; i < data_depth; i = i + 1 ) begin fifo_ram[i] <= 'h0;end
       else if(wr_en && (~full))
          fifo_ram[wr_addr] <= din;
       else
          fifo_ram[wr_addr] <= fifo_ram[wr_addr];
    end     
//========================================================read_fifo
reg [data_width-1:0]dout0,dout1;
assign dout=(rd_en)?dout0:dout1;
always@(*)
   begin
      if(rst)
         begin
            dout0 <= 'h0;
            valid <= 1'b0;
         end
      else if (rd_en && (~empty))
         begin
            dout0 <= fifo_ram[rd_addr];
            valid <= 1'b1;
         end
      else
         begin
            dout0 <=   0;
            valid <= 1'b0;
         end
   end
always@(posedge rd_clk or posedge rst)
      begin
         if(rst)
               dout1<= 'h0;
         else if (rd_en && (~empty))
               dout1<= fifo_ram[rd_addr];
         else
               dout1<=   dout1;
      end
assign wr_addr = wr_addr_ptr[addr_width-1-:addr_width];
assign rd_addr = rd_addr_ptr[addr_width-1-:addr_width];
//=========================================================gray code synchronizton
always@(posedge wr_clk or posedge rst )
   begin
	  if(rst)
		begin
		  rd_addr_gray_d1 <= 0;
		  rd_addr_gray_d2 <= 0;
		end
	  else
		begin
		  rd_addr_gray_d1 <= rd_addr_gray;
		  rd_addr_gray_d2 <= rd_addr_gray_d1;
		end
   end
always@(posedge wr_clk or posedge rst)
   begin
      if(rst)
         wr_addr_ptr <= 'h0;
      else if(wr_en && (~full))
         wr_addr_ptr <= wr_addr_ptr + 1;
      else 
         wr_addr_ptr <= wr_addr_ptr;
   end
//=========================================================rd_clk
always@(posedge rd_clk )
      begin
		if(rst)
			begin
			  wr_addr_gray_d1 <= 0;
			  wr_addr_gray_d2 <= 0;
			end
	    else
			begin
			  wr_addr_gray_d1 <= wr_addr_gray;
			  wr_addr_gray_d2 <= wr_addr_gray_d1;
			end
      end
always@(posedge rd_clk or posedge rst)
   begin
      if(rst)
         rd_addr_ptr <= 'h0;
      else if(rd_en && (~empty))
         rd_addr_ptr <= rd_addr_ptr + 1;
      else 
         rd_addr_ptr <= rd_addr_ptr;
   end

//========================================================== translation gary code
assign wr_addr_gray = (wr_addr_ptr >> 1) ^ wr_addr_ptr;
assign rd_addr_gray = (rd_addr_ptr >> 1) ^ rd_addr_ptr;

assign full = (wr_addr_gray == {~(rd_addr_gray_d2[addr_width-:2]),rd_addr_gray_d2[addr_width-2:0]}) ;
assign empty = ( rd_addr_gray == wr_addr_gray_d2 );

always@(posedge wr_clk or posedge rst)
   begin
      if(rst)fifo_real_num <= 16'h0;
	  else if(wr_addr_ptr==rd_addr_ptr)fifo_real_num <= 16'h0;
      else if(wr_addr_ptr[addr_width-1:0]>rd_addr_ptr[addr_width-1:0])fifo_real_num<={12'b0,(wr_addr_ptr[addr_width-1:0]-rd_addr_ptr[addr_width-1:0])};
      else fifo_real_num<={12'b0,(data_depth-(rd_addr_ptr[addr_width-1:0]-wr_addr_ptr[addr_width-1:0]))};
   end
   
always@(posedge wr_clk or posedge rst)
   begin
      if(rst)adc_half<=0;
      else if(fifo_real_num<adc_fifo_half)adc_half<=0;
	  else adc_half<=1;
   end
   
always@(posedge wr_clk or posedge rst)
   begin
      if(rst)adc_full<=0;
      else if(fifo_real_num<adc_fifo_full)adc_full<=0;
	  else adc_full<=1;
   end
// always@(*)
   // begin
      // if(rst)fifo_real_num <= 16'h0;
	  // else if(wr_addr_ptr==rd_addr_ptr)fifo_real_num <= 16'h0;
      // else if(wr_addr_ptr[addr_width-1:0]>rd_addr_ptr[addr_width-1:0])fifo_real_num<={12'b0,(wr_addr_ptr[addr_width-1:0]-rd_addr_ptr[addr_width-1:0])};
      // else fifo_real_num<={12'b0,(data_depth-(rd_addr_ptr[addr_width-1:0]-wr_addr_ptr[addr_width-1:0]))};
   // end 
 
// always@(*)
   // begin
      // if(rst)adc_half<=0;
      // else if(fifo_real_num<adc_fifo_half)adc_half<=0;
	  // else adc_half<=1;
   // end
   
// always@(*)
   // begin
      // if(rst)adc_full<=0;
      // else if(fifo_real_num<adc_fifo_full)adc_full<=0;
	  // else adc_full<=1;
   // end   
endmodule