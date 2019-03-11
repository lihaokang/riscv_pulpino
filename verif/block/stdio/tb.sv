module tb;

supply1 VCC, VDD;
supply0 GND;
reg DOUT = 0; 
wire DIN;
wire SPAD;

initial begin
	for(int i = 0; i < 10; i++) begin
		DOUT = 0;
		#10;
		DOUT = 1;
		#10;
	end
end

initial begin:dump_fsdb 
    $fsdbDumpfile("./tb.fsdb");
    $fsdbDumpvars(0, tb);
    $fsdbDumpon;
end

	IDIO_HJ110SIOPF50MVIHGSIM_A IDIO_HJ110SIOPF50MVIHGSIM_A(
		.DIN(DIN), 
		.DOUT(DOUT), 
		.SPAD(SPAD), 
		.ENO(1),
                .ENI(0),
                .OD(1), 
		.PU1(0), 
		.PU2(0), 
		.VCC(VCC), 
		.VDD(VDD), 
		.GND(GND));
endmodule
