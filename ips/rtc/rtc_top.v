



`include "rtc_defines.v"

module rtc_top(
           pclk,
           prst_n,
           pwrite,
           psel,
           penable,
           paddr,
           pwdata,
           prdata,
           pready,
           pslverr,

	       rtc_clk,
           inta_o
);


input         pclk,prst_n,pwrite,psel,penable;
input  [31:0] paddr,pwdata;
output        pready;
output        pslverr;
output [31:0] prdata;

input	rtc_clk;	
output  inta_o;
reg     inta_o;
reg    inta_o_dly;
wire    apb_wr_en,apb_rd_en;
reg    [31:0] prdata;

reg	[3:0]		time_s;		
reg	[2:0]		time_ts;	
reg	[3:0]		time_m;		
reg	[2:0]		time_tm;	
reg	[3:0]		time_h;		
reg	[1:0]		time_th;	
reg	[2:0]		time_dow;	

reg	[3:0]		date_d;		
reg	[1:0]		date_td;	
reg	[3:0]		date_m;		
reg			    date_tm;	
reg	[3:0]		date_y;		
reg	[3:0]		date_ty;	
reg	[3:0]		date_c;		
reg	[3:0]		date_tc;	

reg	[15:0]		cntr_div;	
reg	[26:0]		rrtc_talrm;	

reg	[18:0]		rrtc_ctrl;	

reg [2:0]       ctr_en;
wire            inc_flg;
reg [1:0]       inc_flg_dly;


wire [22:0]		rrtc_time;	
reg	 [22:0]		rrtc_time_sync;	
wire [26:0]		rrtc_date;	
reg	 [26:0]		rrtc_date_sync;	
wire			rrtc_time_sel;	
wire			rrtc_date_sel;	
wire			rrtc_talrm_sel;	
wire			rrtc_ctrl_sel;	
wire			rst_time_s;	
wire			rst_time_ts;	
wire			rst_time_m;	
wire			rst_time_tm;	
wire			rst_time_h;	
wire			rst_time_th;	
wire			rst_time_dow;	
wire			rst_date_d;	
wire			rst_date_td;	
wire			rst_date_m;	
wire			rst_date_tm;	
wire			rst_date_y;	
wire			rst_date_ty;	
wire			rst_date_c;	
wire			rst_date_tc;	
wire			inc_time_s;	
wire			inc_time_ts;	
wire			inc_time_m;	
wire			inc_time_tm;	
wire			inc_time_h;	
wire			inc_time_th;	
wire			inc_time_dow;	
wire			inc_date_d;	
wire			inc_date_td;	
wire			inc_date_m;	
wire			inc_date_tm;	
wire			inc_date_y;	
wire			inc_date_ty;	
wire			inc_date_c;	
wire			inc_date_tc;	
wire			one_date_d;	
wire			one_date_m;	
wire			alarm;		
wire			leapyear;	
wire            set_dat_vld;

wire			match_mins;	
wire			match_hrs;	
wire			match_dow;	
wire			match_days;	

reg [2:0] alarm_dly;


assign apb_wr_en = psel && pwrite && penable;
assign apb_rd_en = psel && ~pwrite && penable;
assign pready = 1'b1;
assign pslverr = 1'b0;




assign rrtc_time_sel  =  (paddr  == `RTC_TIME ) ;
assign rrtc_date_sel  =  (paddr  == `RTC_DATE ) ;
assign rrtc_talrm_sel =  (paddr  == `RTC_TALRM ) ;
assign rrtc_ctrl_sel  =  (paddr  == `RTC_CTRL ) ;


assign rrtc_time = {time_dow, time_th, time_h, time_tm,time_m, time_ts, time_s};
assign rrtc_date = {date_tc, date_c, date_ty, date_y,date_tm, date_m, date_td, date_d};


always@(*)
begin
    if(apb_rd_en)
        begin
        	case (paddr)
        		`RTC_TIME:  prdata[31:0]  = {9'b0,rrtc_time_sync};
        		`RTC_DATE:  prdata[31:0]  = {5'b0,rrtc_date_sync};
        		`RTC_TALRM: prdata[31:0]  = {5'b0,rrtc_talrm};
        		`RTC_CTRL:  prdata[31:0]  = {13'b0,rrtc_ctrl};
        		default:  prdata[31:0]    = 32'h0;
            endcase
        end
    else
        begin
            prdata = 32'h0;
        end
end

always @(posedge pclk or negedge prst_n)
if (~prst_n)
begin
   rrtc_time_sync <=  23'b0;
   rrtc_date_sync <=  27'h100c841;
end
else
begin
   if((rrtc_time_sel == 1'b1) && (apb_wr_en==1'b1))
   begin
      rrtc_time_sync <=  pwdata[22:0];
   end
   else if((rrtc_date_sel==1'b1) && (apb_wr_en==1'b1))
   begin
      rrtc_date_sync <=  pwdata[26:0];
   end
   else if(inc_flg_dly[1] == 1'b1)
   begin
      rrtc_time_sync <=  rrtc_time;
      rrtc_date_sync <=  rrtc_date;
   end
   else
   begin
      rrtc_time_sync <=  rrtc_time_sync;
      rrtc_date_sync <=  rrtc_date_sync;
   end
end

always @(posedge pclk or negedge prst_n)
if (~prst_n)
begin
   inc_flg_dly <=  2'b0;
end
else
begin
   inc_flg_dly[0] <=  inc_flg;
   inc_flg_dly[1] <=  inc_flg_dly[0];
end



always @(posedge pclk or negedge prst_n)
if (~prst_n)
	rrtc_ctrl <=  19'h47fff;
else if (rrtc_ctrl_sel && apb_wr_en)
	rrtc_ctrl <=  pwdata;
else if (rrtc_ctrl[`RTC_CTRL_EN])
	rrtc_ctrl[`RTC_CTRL_ALRM] <=  rrtc_ctrl[`RTC_CTRL_ALRM] | alarm_dly[1];
else
	rrtc_ctrl <=  rrtc_ctrl;



always @(posedge pclk or negedge prst_n)
if (~prst_n)
	rrtc_talrm <=  'b0;
else if (rrtc_talrm_sel && apb_wr_en)
	rrtc_talrm <=  pwdata[26:0];
else if(inta_o_dly == 1'b1 && inta_o == 1'b0)
begin
    rrtc_talrm[`RTC_TALRM_CLR] <=  1'b0;
    rrtc_talrm[25:0] <=  rrtc_talrm[25:0];
end
else
	rrtc_talrm <=  rrtc_talrm;


always @(posedge pclk or negedge prst_n)
if(~prst_n)
	inta_o_dly <=  'b0;
else
begin
   inta_o_dly <=  inta_o;
end 


assign set_dat_vld = (ctr_en[1] == 1'b1)&&(ctr_en[2] == 1'b0);
assign inc_flg = ((ctr_en[2]==1)&(cntr_div==0)) ? 1'b1 : 1'b0;


always @(posedge rtc_clk or negedge prst_n)
	if (~prst_n) 
    begin
		cntr_div <=  16'd32767;
	end 
    else if ((set_dat_vld) | (cntr_div==0)) 
    begin
		cntr_div <=  rrtc_ctrl[`RTC_CTRL_DIV];
	end 
    else if (ctr_en[2] == 1'b1)
		cntr_div <=  cntr_div - 1;
    else
		cntr_div <=  cntr_div;

always @(posedge rtc_clk or negedge prst_n)
begin
   if(~prst_n)
   begin
      ctr_en <=  3'b0;
   end
   else
   begin
      ctr_en[0] <=  rrtc_ctrl[`RTC_CTRL_EN];
      ctr_en[1] <=  ctr_en[0];
      ctr_en[2] <=  ctr_en[1];
   end
end


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_s <=  4'b0;
	else if (set_dat_vld)
		time_s <=  rrtc_time_sync[`RTC_TIME_S];
	else if (rst_time_s)
		time_s <=  4'b0;
	else if (inc_time_s)
		time_s <=  time_s + 1;
	else
		time_s <=  time_s;




always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_ts <=  3'b0;        
	else if (set_dat_vld)
		time_ts <=  rrtc_time_sync[`RTC_TIME_TS];
	else if (rst_time_ts)
		time_ts <=  3'b0;
	else if (inc_time_ts)
		time_ts <=  time_ts + 1;
	else
		time_ts <=  time_ts;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_m <=  4'b0;        
	else if (set_dat_vld)
		time_m <=  rrtc_time_sync[`RTC_TIME_M];
	else if (rst_time_m)
		time_m <=  4'b0;
	else if (inc_time_m)
		time_m <=  time_m + 1;
	else
		time_m <=  time_m;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_tm <=  3'b0;
	else if (set_dat_vld)
		time_tm <=  rrtc_time_sync[`RTC_TIME_TM];
	else if (rst_time_tm)
		time_tm <=  3'b0;
	else if (inc_time_tm)
		time_tm <=  time_tm + 1;
	else
		time_tm <=  time_tm;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_h <=  4'b0;
	else if (set_dat_vld)
		time_h <=  rrtc_time_sync[`RTC_TIME_H];
	else if (rst_time_h)
		time_h <=  4'b0;
	else if (inc_time_h)
		time_h <=  time_h + 1;
	else
		time_h <=  time_h;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_th <=  2'b0;
	else if (set_dat_vld)
		time_th <=  rrtc_time_sync[`RTC_TIME_TH];
	else if (rst_time_th)
		time_th <=  2'b0;
	else if (inc_time_th)
		time_th <=  time_th + 1;
	else
		time_th <=  time_th;

always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		time_dow <=  3'h1;
	else if (set_dat_vld)
		time_dow <=  rrtc_time_sync[`RTC_TIME_DOW];
	else if (rst_time_dow)
		time_dow <=  3'h1;
	else if (inc_time_dow)
		time_dow <=  time_dow + 1;
	else
		time_dow <=  time_dow;

always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_d <=  4'h1;
	else if (set_dat_vld)
		date_d <=  rrtc_date_sync[`RTC_DATE_D];
	else if (one_date_d)
		date_d <=  4'h1;
	else if (rst_date_d)
		date_d <=  4'h0;
	else if (inc_date_d)
		date_d <=  date_d + 1;
	else
		date_d <=  date_d;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_td <=  2'b0;
	else if (set_dat_vld)
		date_td <=  rrtc_date_sync[`RTC_DATE_TD];
	else if (rst_date_td)
		date_td <=  2'b0;
	else if (inc_date_td)
		date_td <=  date_td + 1;
	else
		date_td <=  date_td;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_m <=  4'h1;
	else if (set_dat_vld)
		date_m <=  rrtc_date_sync[`RTC_DATE_M];
	else if (one_date_m)
		date_m <=  4'h1;
	else if (rst_date_m)
		date_m <=  4'h0;
	else if (inc_date_m)
		date_m <=  date_m + 1;
	else
		date_m <=  date_m;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_tm <=  1'b0;
	else if (set_dat_vld)
		date_tm <=  rrtc_date_sync[`RTC_DATE_TM];
	else if (rst_date_tm)
		date_tm <=  1'b0;
	else if (inc_date_tm)
		date_tm <=  date_tm + 1;
	else
		date_tm <=  date_tm;



always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_y <=  4'h9;
	else if (set_dat_vld)
		date_y <=  rrtc_date_sync[`RTC_DATE_Y];
	else if (rst_date_y)
		date_y <=  4'b0;
	else if (inc_date_y)
		date_y <=  date_y + 1;
	else
		date_y <=  date_y;



always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_ty <=  4'h1;
	else if (set_dat_vld)
		date_ty <=  rrtc_date_sync[`RTC_DATE_TY];
	else if (rst_date_ty)
		date_ty <=  4'b0;
	else if (inc_date_ty)
		date_ty <=  date_ty + 1;
	else
		date_ty <=  date_ty;


always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_c <=  4'h0;
	else if (set_dat_vld)
		date_c <=  rrtc_date_sync[`RTC_DATE_C];
	else if (rst_date_c)
		date_c <=  4'b0;
	else if (inc_date_c)
		date_c <=  date_c + 1;
	else
		date_c <=  date_c;



always @(posedge rtc_clk or negedge prst_n)
    if(~prst_n)
		date_tc <=  4'h2;
	else if (set_dat_vld)
		date_tc <=  rrtc_date_sync[`RTC_DATE_TC];
	else if (rst_date_tc)
		date_tc <=  4'b0;
	else if (inc_date_tc)
		date_tc <=  date_tc + 1;
	else
		date_tc <=  date_tc;




assign match_dow  = (time_dow == rrtc_talrm[`RTC_TALRM_DOW])&rrtc_talrm[`RTC_TALRM_CDOW];
assign match_mins = (time_m == rrtc_talrm[`RTC_TALRM_M]) & (time_tm == rrtc_talrm[`RTC_TALRM_TM])&rrtc_talrm[`RTC_TALRM_CM];
assign match_hrs  = (time_h == rrtc_talrm[`RTC_TALRM_H]) & (time_th == rrtc_talrm[`RTC_TALRM_TH])&rrtc_talrm[`RTC_TALRM_CH];
assign match_days = (date_d == rrtc_talrm[`RTC_TALRM_D]) & (date_td == rrtc_talrm[`RTC_TALRM_TD])&rrtc_talrm[`RTC_TALRM_CD];


assign alarm = (match_mins   | ~rrtc_talrm[`RTC_TALRM_CM]) & (match_hrs    | ~rrtc_talrm[`RTC_TALRM_CH]) &
		(match_dow    | ~rrtc_talrm[`RTC_TALRM_CDOW]) &(match_days   | ~rrtc_talrm[`RTC_TALRM_CD]) &
		(rrtc_talrm[`RTC_TALRM_CM] | rrtc_talrm[`RTC_TALRM_CH] | rrtc_talrm[`RTC_TALRM_CDOW] | rrtc_talrm[`RTC_TALRM_CD]);

always @(posedge pclk or negedge prst_n)
if(~prst_n)
	alarm_dly <=  3'b000;
else
begin
    alarm_dly[0] <=  alarm;
    alarm_dly[1] <=  alarm_dly[0];
    alarm_dly[2] <=  alarm_dly[1];
end


always @(posedge pclk or negedge prst_n)
if(~prst_n)
	inta_o <=  'b0;
else
begin
   if((alarm_dly[1]=='b1) &(alarm_dly[2] == 'b0) & rrtc_ctrl[`RTC_CTRL_INTE])
      inta_o <=  'b1;
   else if(rrtc_talrm[`RTC_TALRM_CLR])
      inta_o <=  'b0;
   else
      inta_o <=  inta_o;

end



assign rst_time_s = (time_s == 4'd9) & (inc_flg==1'b1) ;
assign rst_time_ts = (time_ts == 3'd5) & rst_time_s ;
assign rst_time_m = (time_m == 4'd9) & rst_time_ts  ;
assign rst_time_tm = (time_tm == 3'd5) & rst_time_m ;
assign rst_time_h = (time_h == 4'd9) & rst_time_tm
			| (time_th == 2'd2) & (time_h == 4'd3) & rst_time_tm
			;
assign rst_time_th = (time_th == 2'd2) & rst_time_h ;
assign rst_time_dow = (time_dow == 3'd7) & rst_time_th ;
assign one_date_d = 
	       ({date_tm, date_m} == 8'h01 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h02 & date_td == 2'd2 & date_d == 4'd8 & ~leapyear |
		{date_tm, date_m} == 8'h02 & date_td == 2'd2 & date_d == 4'd9 & leapyear |
		{date_tm, date_m} == 8'h03 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h04 & date_td == 2'd3 & date_d == 4'd0 |
		{date_tm, date_m} == 8'h05 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h06 & date_td == 2'd3 & date_d == 4'd0 |
		{date_tm, date_m} == 8'h07 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h08 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h09 & date_td == 2'd3 & date_d == 4'd0 |
		{date_tm, date_m} == 8'h10 & date_td == 2'd3 & date_d == 4'd1 |
		{date_tm, date_m} == 8'h11 & date_td == 2'd3 & date_d == 4'd0 |
		{date_tm, date_m} == 8'h12 & date_td == 2'd3 & date_d == 4'd1 ) & rst_time_th ;
assign rst_date_d = date_d == 4'd9 & rst_time_th;
assign rst_date_td = ({date_tm, date_m} == 8'h02 & date_td[1] |
		date_td == 2'h3) & (rst_date_d | one_date_d) ;
assign one_date_m = date_tm & (date_m == 4'd2) & rst_date_td ;
assign rst_date_m = ~date_tm & (date_m == 4'd9) & rst_date_td;
assign rst_date_tm = date_tm & (rst_date_m | one_date_m) ;
assign rst_date_y = (date_y == 4'd9) & rst_date_tm ;
assign rst_date_ty = (date_ty == 4'd9)& rst_date_y  ;
assign rst_date_c = (date_c == 4'd9) & rst_date_ty ;
assign rst_date_tc = (date_tc == 4'd9) & rst_date_c ;


assign inc_time_s  = ctr_en[2] & inc_flg ;
assign inc_time_ts = rst_time_s;
assign inc_time_m = rst_time_ts;
assign inc_time_tm = rst_time_m;
assign inc_time_h = rst_time_tm;
assign inc_time_th = rst_time_h;
assign inc_time_dow = rst_time_th;
assign inc_date_d = rst_time_th;
assign inc_date_td = rst_date_d;
assign inc_date_m = rst_date_td;
assign inc_date_tm = rst_date_m;
assign inc_date_y = rst_date_tm;
assign inc_date_ty = rst_date_y;
assign inc_date_c = rst_date_ty;
assign inc_date_tc = rst_date_c;



assign leapyear =
	(({date_ty, date_y} == 8'h00) &				
	 (( date_tc[0] & ~date_c[3] & (date_c[1:0] == 2'b10)) |	
	  (~date_tc[0] & (date_c[1:0] == 2'b00) &		
	   ((date_c[3:2] == 2'b01) | ~date_c[2])))) |
	(~date_ty[0] & (date_y[1:0] == 2'b00) & ({date_ty, date_y} != 8'h00)) | 
	(date_ty[0] & (date_y[1:0] == 2'b10));			

endmodule
