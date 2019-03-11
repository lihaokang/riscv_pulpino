///****************************************************************************
// Verilog model
// project: PF64AK32EI40
///============================================================================
// These Verilog HDL models are provided "as is" without warranty
// of any kind, included but not limited to, implied warranty
// of merchantability and fitness for a particular purpose.
///****************************************************************************
`timescale  1ns / 100ps

`define MEM_SIZE           16384       // Main memory 64K Byte (16K x 32 Bits)
`define SEC_SIZE           256         // sector size 1K Byte (256 x 32 Bits)
`define SEC_BIT_ADDR       8           // sector address
`define INFO_SIZE          512         // Information memory 2K Byte ( 512 x 32 Bits)
`define INFO_BIT_ADDR      9           // Information memory address
`define INFO_SEC_BIT_ADDR  8           // Information memory sector address
`define INFO_SEC_SIZE      256 
`define BIT_ADDR           14          // Address
`define BIT_DATA           32
`define DIF_ADDR_BITS      4    	     // eflash_addr 18 - BIT_ADDR 14	    

`define BYTEWIDTH          16
`define WORDWIDTH          32
`define DOUBLEWORDWIDTH    64

`define Tas    0             // address setup time
`define Tah    5             // address hold time
`define Ts     5             // Setup time of write and erase
`define Th     5             // Hold time of write and erase
`define Tds	   0             // Data setup time
`define Tdh	   5             // Data Hold time

`define Tao	    5            // Dout still keep valid data when oe=1 and next AE rising edge
`define Tac	    40           // Read address access time
`define Toe	    10           // OE high to Output Delay
//`define Thz	    3            // CE or OE low to Output High Z

`define Taad   40            // AE to AE delay during read
`define Tae    10            // AE pulse width
`define Tael   10            // AE low pulse width

`define Tpah_p 20000         // Address hod time when program
`define Tpdh_p 20000         // Data hod time when program
`define Tpah_s 2000000       // Address hod time when sector erase
`define Tpah_m 10000000      // Address hod time when mase erase 

`define Tfastp 6000          // FASTP cycle time(6us)
`define Tlast_max  3000      // FASTP goes ow after the last BUSY rising edge
`define Tlast_min  100       // FASTP goes ow after the last BUSY rising edge
`define Tprog  20000         // Byte Program cycle time(20us)
`define Tprog_cnt  400       // Byte Program cycle count
`define Tser   2000000       // Sector Erase Cycle Time (2ms)
`define Tser_cnt   40000     // Sector Erase Cycle count
`define Tmer   10000000      // MACRO Erase Cycle Time (10ms)
`define Tmer_cnt   200000    // MACRO Erase Cycle count

`define Tnvstr 10            // NVSTR to AE delay 
//`define Tprog  20000         // Byte Program cycle time  (20us)
//`define Tser   2000000       // Sector Erase Cycle Time  (2ms)
//`define Tmer   10000000      // MACRO Erase Cycle Time   (10ms)

`define Trv        20        // Recover time from TBIT falling edge to next AE rising edge
`define Ttr        100       // TBIT rises after NVSTR
//`define Ttf_prog   20000     // TBIT falls after NVSTR for write
//`define Ttf_sera   2000000   // TBIT falls after NVSTR for sector erase
//`define Ttf_mase   10000000  // TBIT falls after NVSTR for macro erase
`define Tbt_mase   100000      // Macro Erase discharge time 100us
`define Tbt_sera   100000      // Macro Erase discharge time 100us
`define Tbt_prog   3000        // Macro Erase discharge time   3  us

`define Tcs     5            // CS setup time to AE rising edge

`define Ttmr    20         // TMR pulse width 20ns
`define Tcme    10         // Test mode all 10 ns limit 
`define Tmertm  10         // Test mode all 10 ns limit 
`define Tmry    10         // Test mode all 10 ns limit 
`define Tms     10         // Test mode all 10 ns limit 
`define Tmh     10         // Test mode all 10 ns limit 
`define InitTime  1          // default initial time after power up

`define Top_max        82.5     // OSC pre-amble time
`define Tpst_max       82.5     // OSC post-amble time
`define Toc_typical    25       // Oscillator half-cycle time

`define Tresetb        10       // RESET delay from active to inactive

///****************************************************************************
// AC DC timing check 
// These Verilog HDL models are provided "as is" without warranty
// of any kind, included but not limited to, implied warranty
// of merchantability and fitness for a particular purpose.
///****************************************************************************

module acdc_check_pf64ak32ei40 (prog, mase, sera, cs, ae, oe, nvstr, ifren, tme, tmr, fastp, busy, tbit,  
                       prog_latch, sera_latch, mase_latch, 
                       addr, din, resetb, wrong_timing, ae_delay);

   input prog, mase, sera, cs, oe, ae, nvstr, ifren, tme, tmr, fastp, busy, tbit;
   input prog_latch, sera_latch, mase_latch, resetb;
   input [(`BIT_ADDR-1):0] addr; 
   input [(`BIT_DATA-1):0] din; 
   
   output wrong_timing;	  
   output ae_delay;

 
   wire prog, mase, sera, oe, nvstr; 
   reg  wrong_timing;
   
   ///////////////////////////////////////////////
   // TIMING VALUES
   ///////////////////////////////////////////////	  
   real t_cs_rise;
   
   real t_prog_rise;
   real t_prog_fall;
   
   real t_nvstr_prog_rise;
   real t_nvstr_mase_rise;
   real t_nvstr_sera_rise;
   real t_nvstr_rise;
   real t_nvstr_fall;
   
   real t_mase_rise;
   real t_mase_fall;
   
   real t_sera_rise;
   real t_sera_fall;
   
   real t_din_setup;
   real t_din_hold;
   
   real t_addr_setup;
   real t_addr_hold;
   
   real t_ae_rise;
   real t_ae_rise_aad;
   real t_ae_fall;
 
   real t_oe_rise;
   real t_oe_fall;
 
   real t_tme_rise;
   real t_tmr_rise;
   real t_tmr_fall;
 
   real t_busy_rise;
   real t_fastp_fall;
   
   real t_resetb_rise;
   real t_resetb_fall;
   
   real t_tbit_fall;
   
   ///////////////////////////////////////////////
   //                timing initial             //
   //  function: remove 0.0 ns violation        //
   ///////////////////////////////////////////////
   initial begin
   t_cs_rise = -1000.0;
   
   t_prog_rise = -1000.0;
   t_prog_fall = -1000.0;
   
   t_nvstr_prog_rise = -1000.0;
   t_nvstr_mase_rise = -1000.0;
   t_nvstr_sera_rise = -1000.0;
   t_nvstr_rise = -1000.0;
   t_nvstr_fall = -1000.0;
   
   t_mase_rise = -1000.0;
   t_mase_fall = -1000.0;
   
   t_sera_rise = -1000.0;
   t_sera_fall = -1000.0;
   
   t_din_setup = -1000.0;
   t_din_hold = -1000.0;
   
   t_addr_setup = -1000.0;
   t_addr_hold = -1000.0;
   
   t_ae_rise = -1000.0;
   t_ae_rise_aad = -1000.0;
   t_ae_fall = -1000.0;
   
   t_oe_rise = -1000.0;
   t_oe_fall = -1000.0;
   
   t_tme_rise = -1000.0;
   t_tmr_rise = -1000.0;
   t_tmr_fall = -1000.0;

   t_busy_rise = -1000.0;
   t_fastp_fall = -1000.0; 
   
   t_resetb_rise = -100000.0;
   t_resetb_fall = -100000.0;
   
   t_tbit_fall = -100000.0;
   
   end
   ///////////////////////////////////////////////

   
   initial wrong_timing = 1'b0;
   always @(posedge wrong_timing)
      #50 wrong_timing = 1'b0;

		 
   //--------------------------------------------------
   // This process check signals				 
   //--------------------------------------------------
   //--------------------------------------------------
   // Read				 
   // tAS, tAH, tAAD, tAE, tCS
   //--------------------------------------------------
   //--------------------------------------------------
   // Program	
   // tS, tH, tDS, tDH, tNVSTR, tPROG
   //--------------------------------------------------
   //--------------------------------------------------
   // Sector Erase	
   // tS, tH, tSER
   //--------------------------------------------------
   //--------------------------------------------------
   // Macro Erase	
   // tS, tH, tMER
   //--------------------------------------------------	   
   //--------------------------------------------------
   // Test Mode	
   // Tcme, Tmertm, Ttmr, Tmry, Tms, Ttmr, Tmh
   //--------------------------------------------------	
   always @(resetb) 
    if ($realtime > `InitTime)
    begin
       if(resetb == 1'b1) t_resetb_rise = $realtime;
       else               t_resetb_fall = $realtime;
	end
	   
    always @(cs) 
    if ($realtime > `InitTime)
    begin
       if(cs == 1'b1) t_cs_rise = $realtime;
    end

    always @(tbit) 
    if ($realtime > `InitTime)
    begin
       if(tbit == 1'b0) t_tbit_fall = $realtime;
    end

    always @(oe) 
    if ($realtime > `InitTime)
    begin
       if(oe == 1'b1) t_oe_rise = $realtime;
       else           t_oe_fall = $realtime;

       if(oe == 1'b0)
       begin
//Read Toe
          if ((t_oe_fall - t_oe_rise) < `Toe) 
          begin
             $display("ERROR! @%.2fns : Toe violated",$realtime);
             $display("[neg OE: %.2fns] - [pos OE: %.2fns] < [Toe: %.2fns]", t_oe_fall, t_oe_rise, `Toe);
             wrong_timing = 1'b1;
          end
       end
    end

    always @(ae) 
    if ($realtime > `InitTime)
    begin
       if(ae == 1'b1) t_ae_rise = $realtime;
       else           t_ae_fall = $realtime;

       if(ae == 1'b1)
       begin
//Read Tcs
          if ((t_ae_rise - t_cs_rise) < `Tcs) 
          begin
             $display("ERROR! @%.2fns : tCS setup time violated",$realtime);
             $display("[pos AE: %.2fns] - [pos CS: %.2fns] < [Tcs: %.2fns]", t_ae_rise, t_cs_rise, `Tcs);
             wrong_timing = 1'b1;
          end
//Read Tas
          if ((t_ae_rise - t_addr_setup) < `Tas) 
          begin
             $display("ERROR! @%.2fns : tAS setup time violated",$realtime);
             $display("[pos AE: %.2fns] - [setup ADDR: %.2fns] < [Tas: %.2fns]", t_ae_rise, t_addr_setup, `Tas);
             wrong_timing = 1'b1;
          end
//Read Taad
          if ((t_ae_rise - t_ae_rise_aad) < `Taad) 
          begin
             $display("ERROR! @%.2fns : tAAD AE to AE delay time violated in read operation",$realtime);
             $display("[pos AE: %.2fns] - [pos AE: %.2fns] < [Taad: %.2fns]", t_ae_rise, t_ae_rise_aad, `Taad);
             wrong_timing = 1'b1;
          end
          t_ae_rise_aad =$realtime;
//Program Ts
          if ((t_ae_rise - t_prog_rise) < `Ts) 
          begin
             $display("ERROR! @%.2fns : tS setup time violated in Program",$realtime);
             $display("[pos AE: %.2fns] - [pos PROG: %.2fns] < [Ts: %.2fns]", t_ae_rise, t_prog_rise, `Ts);
             wrong_timing = 1'b1;
          end
//Program Tds
          if ((prog == 1'b1) && ((t_ae_rise - t_din_setup) < `Tds))
          begin
             $display("ERROR! @%.2fns : tDS setup time violated",$realtime);
             $display("[pos AE: %.2fns] - [setup DATA: %.2fns] < [Tds: %.2fns]", t_ae_rise, t_din_setup, `Tds);
             wrong_timing = 1'b1;
          end
//Sector Erase Ts
          if ((t_ae_rise - t_sera_rise) < `Ts) 
          begin
             $display("ERROR! @%.2fns : tS setup time violated in Sector Erase",$realtime);
             $display("[pos AE: %.2fns] - [pos SERA: %.2fns] < [Ts: %.2fns]", t_ae_rise, t_sera_rise, `Ts);
             wrong_timing = 1'b1;
          end
//Macro Erase Ts
          if ((t_ae_rise - t_mase_rise) < `Ts) 
          begin
             $display("ERROR! @%.2fns : tS setup time violated in Macro Erase",$realtime);
             $display("[pos AE: %.2fns] - [pos MASE: %.2fns] < [Ts: %.2fns]", t_ae_rise, t_mase_rise, `Ts);
             wrong_timing = 1'b1;
          end
//read Tael
          if ((t_ae_rise - t_ae_fall) < `Tael) 
          begin
             $display("ERROR! @%.2fns : tAEL AE low pulse width violated",$realtime);
             $display("[pos AE: %.2fns] - [neg AE: %.2fns] < [Tael: %.2fns]", t_ae_rise, t_ae_fall, `Tael);
             wrong_timing = 1'b1;
          end 
//Reset Recover
          if ((t_ae_rise - t_resetb_rise) < `Tresetb) 
          begin
             $display("ERROR! @%.2fns : Tresetb setup time violated",$realtime);
             $display("[pos AE: %.2fns] - [pos RESETB: %.2fns] < [Tresetb: %.2fns]", t_ae_rise, t_resetb_rise, `Tresetb);
             wrong_timing = 1'b1;
          end
//Trv
          if ((t_ae_rise - t_tbit_fall) < `Trv) 
          begin
             $display("ERROR! @%.2fns : TBIT low to next AE rising time violated",$realtime);
             $display("[pos AE: %.2fns] - [neg TBIT: %.2fns] < [Trv: %.2fns]", t_ae_rise, t_tbit_fall, `Trv);
             wrong_timing = 1'b1;
          end
       end 
       //else ---------------------------------------
       else
       begin
//read Tae
          if ((t_ae_fall - t_ae_rise) < `Tae) 
          begin
             $display("ERROR! @%.2fns : tAE AE pulse width violated",$realtime);
             $display("[neg AE: %.2fns] - [pos AE: %.2fns] < [Tae: %.2fns]", t_ae_fall, t_ae_rise, `Tae);
             wrong_timing = 1'b1;
          end
       end
    end
	
 reg ae_delay;	 
 always @(ae) 
 if(ae == 1'b1)		 
 begin
	 #0.1;
	 ae_delay = 1'b1;
 end
 else 
	 ae_delay = 1'b0; 
	 
//Read Tah
    always @(addr or ifren)
    if ($realtime > `InitTime) 
    begin  
       if(ae_delay == 1'b1) 
       begin
          t_addr_hold = $realtime;
          if ( (t_addr_hold - t_ae_rise) < `Tah) 
          begin
             $display("ERROR! @%.2fns : tAH hold time violated",$realtime);
             $display("[hold ADDR: %.2fns] - [pos AE: %.2fns] < [Tah: %.2fns]", t_addr_hold, t_ae_rise, `Tah);
             wrong_timing = 1'b1;
          end
       end
       else  t_addr_setup = $realtime;
    end

//Program Th
    always @(prog)
    if ($realtime > `InitTime) 
    begin
       if(prog == 1'b1) t_prog_rise = $realtime;
       else             t_prog_fall = $realtime;

       if((ae == 1'b1) && (prog == 1'b0)) 
       begin
          if ( (t_prog_fall - t_ae_rise) < `Th) 
          begin
             $display("ERROR! @%.2fns : tH hold time violated in Program",$realtime);
             $display("[neg PROG: %.2fns] - [pos AE: %.2fns] < [Th: %.2fns]", t_prog_fall, t_ae_rise, `Th);
             wrong_timing = 1'b1;
          end
       end
//Test mode timing Tmry, Tmh
       if(prog == 1'b1)
       begin
          if ( (t_prog_rise - t_tmr_fall) < `Tmry) 
          begin
             $display("ERROR! @%.2fns : Tmry violated",$realtime);
             $display("[pos PROG: %.2fns] - [neg TMR: %.2fns] < [Tmry: %.2fns]", t_prog_rise, t_tmr_fall, `Tmry);
             wrong_timing = 1'b1;
          end
       end
       else //(prog == 1'b0)
       begin
          if ( (t_prog_fall - t_tmr_fall) < `Tmh) 
          begin
             $display("ERROR! @%.2fns : Tmh violated",$realtime);
             $display("[neg PROG: %.2fns] - [neg TMR: %.2fns] < [Tmh: %.2fns]", t_prog_fall, t_tmr_fall, `Tmh);
             wrong_timing = 1'b1;
          end
       end
    end

//Program Tdh
    always @(din)
    if ($realtime > `InitTime) 
    begin
       if(ae == 1'b1) 
       begin
          t_din_hold = $realtime;
          if ((prog_latch == 1'b1) && ((t_din_hold - t_ae_rise) < `Tdh))
          begin
             $display("ERROR! @%.2fns : tDH hold time violated",$realtime);
             $display("[hold DATA: %.2fns] - [pos AE: %.2fns] < [Tdh: %.2fns]", t_din_hold, t_ae_rise, `Tdh);
             wrong_timing = 1'b1;
          end
       end
       else  t_din_setup = $realtime;
    end


   always @(nvstr)
   if ($realtime > `InitTime) 
   begin					  
      if(nvstr == 1'b1)
      begin
         t_nvstr_rise = $realtime;
         if(prog_latch == 1'b1) t_nvstr_prog_rise = $realtime;
         if(mase_latch == 1'b1) t_nvstr_mase_rise = $realtime;
         if(sera_latch == 1'b1) t_nvstr_sera_rise = $realtime;
      end 
      else  t_nvstr_fall = $realtime;
	  
      if(nvstr == 1'b1)
      begin
//Tnvstr of Program, Sector Erase, Macro Erase 
         if ((t_nvstr_rise - t_ae_rise) < `Tnvstr)
         begin
            $display("ERROR! @%.2fns : tNVSTR setup time violated in program operation ",$realtime); 
            $display("[pos NVSTR: %.2fns] - [pos AE: %.2fns] < [Tnvstr: %.2fns]", t_nvstr_rise, t_ae_rise, `Tnvstr);
            wrong_timing = 1'b1;
         end
      end
      //else   nvstr == 1'b0 -----------------------------------
      else
      begin
//Program Tprog  
         if ((prog_latch == 1'b1) && ((t_nvstr_fall - t_nvstr_prog_rise) < `Tprog))
         begin
            $display("ERROR! @%.2fns : Tprog(NVSTR high pulse width condition violated in Program",$realtime); 
            $display("[neg NVSTR: %.2fns] - [pos NVSTR: %.2fns] < [Tprog: %.2fns]", t_nvstr_fall, t_nvstr_prog_rise, `Tprog);
            wrong_timing = 1'b1;
         end
//Sector Erase Tser
         if ((sera_latch == 1'b1) && ((t_nvstr_fall - t_nvstr_sera_rise) < `Tser))
         begin
            $display("ERROR! @%.2fns : Tser(NVSTR high pulse width condition violated in Sector Erase",$realtime); 
            $display("[neg NVSTR: %.2fns] - [pos NVSTR: %.2fns] < [Tser: %.2fns]", t_nvstr_fall, t_nvstr_sera_rise, `Tser);
            wrong_timing = 1'b1;
         end 
//Macro Erase Tmer
         if ((mase_latch == 1'b1) && ((t_nvstr_fall - t_nvstr_mase_rise) < `Tmer))
         begin
            $display("ERROR! @%.2fns : Tmer(NVSTR high pulse width condition violated in Macro Erase",$realtime); 
            $display("[neg NVSTR: %.2fns] - [pos NVSTR: %.2fns] < [Tmer: %.2fns]", t_nvstr_fall, t_nvstr_mase_rise, `Tmer);
            wrong_timing = 1'b1;
         end 
      end

//Test mode timing Tmry, Tmh
       if(nvstr == 1'b1)
       begin
          if ( (t_nvstr_rise - t_tmr_fall) < `Tmry) 
          begin
             $display("ERROR! @%.2fns : Tmry violated",$realtime);
             $display("[pos NVSTR: %.2fns] - [neg TMR: %.2fns] < [Tmry: %.2fns]", t_nvstr_rise, t_tmr_fall, `Tmry);
             wrong_timing = 1'b1;
          end
       end
       else //(nvstr == 1'b0)
       begin
          if ( (t_nvstr_fall - t_tmr_fall) < `Tmh) 
          begin
             $display("ERROR! @%.2fns : Tmh violated",$realtime);
             $display("[neg NVSTR: %.2fns] - [neg TMR: %.2fns] < [Tmh: %.2fns]", t_nvstr_fall, t_tmr_fall, `Tmh);
             wrong_timing = 1'b1;
          end
       end
   end
   
   
//Sector Erase Th
    always @(sera)
    if ($realtime > `InitTime) 
    begin					 
	   if(sera == 1'b1)  t_sera_rise = $realtime;
       else              t_sera_fall = $realtime;

	   if((sera == 1'b0) && (ae == 1'b1))
       begin
          if ( (t_sera_fall - t_ae_rise) < `Th) 
          begin
             $display("ERROR! @%.2fns : tH hold time violated in Sector Erase",$realtime);
             $display("[neg SERA: %.2fns] - [pos AE: %.2fns] < [Th: %.2fns]", t_sera_fall, t_ae_rise, `Th);
             wrong_timing = 1'b1;
          end
       end
//Test mode timing Tmry, Tmh
       if(sera == 1'b1)
       begin
          if ( (t_sera_rise - t_tmr_fall) < `Tmry) 
          begin
             $display("ERROR! @%.2fns : Tmry violated",$realtime);
             $display("[pos SERA: %.2fns] - [neg TMR: %.2fns] < [Tmry: %.2fns]", t_sera_rise, t_tmr_fall, `Tmry);
             wrong_timing = 1'b1;
          end
       end
       else //(sera == 1'b0)
       begin
          if ( (t_sera_fall - t_tmr_fall) < `Tmh) 
          begin
             $display("ERROR! @%.2fns : Tmh violated",$realtime);
             $display("[neg SERA: %.2fns] - [neg TMR: %.2fns] < [Tmh: %.2fns]", t_sera_fall, t_tmr_fall, `Tmh);
             wrong_timing = 1'b1;
          end
       end
    end
//Macro Erase Th
    always @(mase)
    if ($realtime > `InitTime) 
    begin
       if(mase == 1'b1)  t_mase_rise = $realtime;
       else              t_mase_fall = $realtime;

       if((mase == 1'b0) && (ae == 1'b1))
       begin
          if ( (t_mase_fall - t_ae_rise) < `Th) 
          begin
             $display("ERROR! @%.2fns : tH hold time violated in Macro Erase",$realtime);
             $display("[neg MASE: %.2fns] - [pos AE: %.2fns] < [Th: %.2fns]", t_mase_fall, t_ae_rise, `Th);
             wrong_timing = 1'b1;
          end
       end
//Test mode timing Tmry, Tmh
       if(mase == 1'b1)
       begin
          if ( (t_mase_rise - t_tmr_fall) < `Tmry) 
          begin
             $display("ERROR! @%.2fns : Tmry violated",$realtime);
             $display("[pos MASE: %.2fns] - [neg TMR: %.2fns] < [Tmry: %.2fns]", t_mase_rise, t_tmr_fall, `Tmry);
             wrong_timing = 1'b1;
          end
       end
       else //(mase == 1'b0)
       begin
          if ( (t_mase_fall - t_tmr_fall) < `Tmh) 
          begin
             $display("ERROR! @%.2fns : Tmh violated",$realtime);
             $display("[neg MASE: %.2fns] - [neg TMR: %.2fns] < [Tmh: %.2fns]", t_mase_fall, t_tmr_fall, `Tmh);
             wrong_timing = 1'b1;
          end
       end
    end
   
   //--------------------------------------------------
   // Test Mode	
   // Tcme, Tmer, Ttmr, Tmry, Tms, Ttmr, Tmh
   //--------------------------------------------------
//Test mode timing Tcme
    always @(tme)
    if ($realtime > `InitTime) 
    begin					 
	   if(tme == 1'b1)  t_tme_rise = $realtime;

	   if((tme == 1'b1) && (cs == 1'b1))
       begin
          if ( (t_tme_rise - t_cs_rise) < `Tcme) 
          begin
             $display("ERROR! @%.2fns : Tcme setup time violated in Test Mode",$realtime);
             $display("[pos TME: %.2fns] - [pos CS: %.2fns] < [Tcme: %.2fns]", t_tme_rise, t_cs_rise, `Tcme);
          end
       end
    end

//Test mode timing Tmer, Tms
    always @(tmr)
    if ($realtime > `InitTime) 
    begin					 
       if(tmr == 1'b1)  t_tmr_rise = $realtime;
       else             t_tmr_fall = $realtime;

       if(tmr == 1'b1)
       begin
//Test mode Tmertm
          if ( (t_tmr_rise - t_tme_rise) < `Tmertm) 
          begin
             $display("ERROR! @%.2fns : Tmer violated in Test Mode",$realtime);
             $display("[pos TMR: %.2fns] - [pos TME: %.2fns] < [Tmer: %.2fns]", t_tmr_rise, t_tme_rise, `Tmertm);
          end
//Test mode Tms
          if ( (t_tmr_rise - t_nvstr_rise) < `Tms) 
          begin
             $display("ERROR! @%.2fns : Tms violated in Test Mode",$realtime);
             $display("[pos TMR: %.2fns] - [pos NVSTR: %.2fns] < [Tms: %.2fns]", t_tmr_rise, t_nvstr_rise, `Tms);
          end
          if ( (t_tmr_rise - t_prog_rise) < `Tms) 
          begin
             $display("ERROR! @%.2fns : Tms violated in Test Mode",$realtime);
             $display("[pos TMR: %.2fns] - [pos PROG: %.2fns] < [Tms: %.2fns]", t_tmr_rise, t_prog_rise, `Tms);
          end
          if ( (t_tmr_rise - t_sera_rise) < `Tms) 
          begin
             $display("ERROR! @%.2fns : Tms violated in Test Mode",$realtime);
             $display("[pos TMR: %.2fns] - [pos SERA: %.2fns] < [Tms: %.2fns]", t_tmr_rise, t_sera_rise, `Tms);
          end
          if ( (t_tmr_rise - t_mase_rise) < `Tms) 
          begin
             $display("ERROR! @%.2fns : Tms violated in Test Mode",$realtime);
             $display("[pos TMR: %.2fns] - [pos MASE: %.2fns] < [Tms: %.2fns]", t_tmr_rise, t_mase_rise, `Tms);
          end
       end
       else  // TMR == 1'b0
//Test mode Ttmr
       begin
          if ( (t_tmr_fall - t_tmr_rise) < `Ttmr) 
          begin
             $display("ERROR! @%.2fns : Ttmr violated in Test Mode",$realtime);
             $display("[neg TMR: %.2fns] - [pos TMR: %.2fns] < [Ttmr: %.2fns]", t_tmr_fall, t_tmr_rise, `Ttmr);
          end
       end
    end

//Tlast_max during fastp mode
    always @(fastp)
    if ($realtime > `InitTime) 
    begin					 
	   if(fastp == 1'b0)  t_fastp_fall = $realtime;

          if ( (t_fastp_fall - t_busy_rise) > `Tlast_max) 
          begin
             $display("ERROR! @%.2fns : Tlast_max timing violated in FASTP Mode",$realtime);
             $display("[neg FASTP: %.2fns] - [pos BUSY: %.2fns] > [Tlast_max: %.2fns]", t_fastp_fall, t_busy_rise, `Tlast_max);
          end
          if ( (t_fastp_fall - t_busy_rise) < `Tlast_min) 
          begin
             $display("ERROR! @%.2fns : Tlast_min timing violated in FASTP Mode",$realtime);
             $display("[neg FASTP: %.2fns] - [pos BUSY: %.2fns] > [Tlast_min: %.2fns]", t_fastp_fall, t_busy_rise, `Tlast_min);
          end
    end

    always @(busy)
    if ($realtime > `InitTime) 
    begin					 
	   if(busy == 1'b1)  t_busy_rise = $realtime;
    end


endmodule


// This program implement the core logic for PF64AK32EI40
// These Verilog HDL models are provided "as is" without warranty
// of any kind, included but not limited to, implied warranty
// of merchantability and fitness for a particular purpose.
module pf64ak32ei40_core(cs, oe, ae, porst, ifren, nvstr, prog, sera, mase, tbit, tmr, tme, byte_1, oscen, osc, fastp, busy,  
				 prog_latch, sera_latch, mase_latch, outen, addr, addr_1, din, dout, wrong_timing, gangpgm, sg_stress, bl_stress, extpe, quad_pgm, ae_delay);

    input cs, oe, ae, porst, ifren, nvstr, prog, sera, mase, tmr, tme, byte_1, addr_1, oscen, fastp;
    input [(`BIT_ADDR-1):0] addr;
    input [(`BIT_DATA-1):0] din;
    input wrong_timing;	  
    input ae_delay;
    input gangpgm, sg_stress, bl_stress, extpe, quad_pgm;

    output [(`BIT_DATA-1):0] dout;	
    output prog_latch, sera_latch, mase_latch, outen;
	  output tbit, osc, busy;

    reg [(`BIT_ADDR-1):0] addr_latch;
    reg [(`BIT_DATA-1):0] din_latch;
    reg ifren_latch;
    reg tbit;
    reg [(`BIT_DATA-1):0] dout;
    reg addr_1_latch, read_addr_1;

    reg   prog_latch, mase_latch, sera_latch;

    reg [(`BIT_ADDR-1):0] read_addr;  

    reg  nvstr_latch;
    wire prog_csm, sera_csm, mase_csm;  				
    wire pos_aeoe;
    reg  pst7;
    wire pst7_porst;
    wire read_mode, program_mode, sector_erase_mode, macro_erase_mode, fastp_mode;
    wire pos_aeoe_fastp;

    reg [255:0] ALLFF256, ALLXX256, ALLZZ256, ALL00256;  
    initial begin
      ALLFF256 = 256'HFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF;
      ALLXX256 = 256'HXXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XXXX;
      ALLZZ256 = 256'HZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ_ZZZZ;
      ALL00256 = 256'H0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    end


//--------------------------------------------------
// OSC generation
// tOP, tOC
//--------------------------------------------------
   reg  oscen_real, clk_osc;
   reg[19:0]  osc_cnt;

   initial begin
      osc_cnt = 20'b0;
      oscen_real = 1'b0;
      clk_osc    = 1'b0;
      #100;
      oscen_real = 1'b1;
   end

//   always @(oscen) 
//   begin
//      if(oscen == 1'b1) #`Top_max oscen_real = 1'b1;
//      else              #`Tpst_max oscen_real = 1'b0;
//   end

   always #`Toc_typical  clk_osc  =  ~clk_osc;
   
   assign  osc = ~(clk_osc & oscen_real) && ( (prog_csm == 1'b1) || (sera_csm == 1'b1) || (mase_csm == 1'b1) );

//address and data input behavioral
   initial begin
      addr_latch   = ALL00256[(`BIT_ADDR-1):0];
      ifren_latch  = 1'b0;
      din_latch    = ALL00256[(`BIT_DATA-1):0];
      read_addr    = ALL00256[(`BIT_ADDR-1):0];
      addr_1_latch=1'b0;
      read_addr_1 = 1'b0;
   end

   always @(posedge ae_delay or wrong_timing) 
   begin
      if((cs == 1'b1) && (wrong_timing == 1'b0))
      begin
         addr_latch = addr;
         ifren_latch = ifren;
         addr_1_latch = addr_1;
         if((prog == 1'b1) || (fastp == 1'b1) && (mase == 1'b0) && (sera == 1'b0))
            din_latch = din;											   
         if((prog == 1'b0) && (mase == 1'b0) && (sera == 1'b0))
         begin
            read_addr = addr_latch;
            read_addr_1 = addr_1_latch;
         end
      end				//address setup&hold timing meet spec.
      else if(wrong_timing == 1'b1) 
      begin
         read_addr   = ALLXX256[(`BIT_ADDR-1):0];	
         addr_latch  = ALLXX256[(`BIT_ADDR-1):0];
         ifren_latch = 1'bx;
         din_latch   = ALLXX256[(`BIT_DATA-1):0];
         addr_1_latch  = 1'bx;
         read_addr_1   = 1'bx;
      end			//address setup&hold timing violate spec.
  end
  

//------------------------------------------------------------------
//     Operation latch and TBIT Generation
//-------------------------------------------------------------------
  initial begin
     tbit = 1'b0;
     pst7 = 1'b0;					  
     nvstr_latch = 1'b0;
     prog_latch = 1'b0;
     sera_latch = 1'b0;
     mase_latch = 1'b0;
  end
  
  assign  pos_aeoe = ae & (!oe);
  assign  prog_csm = prog_latch & nvstr_latch;
  assign  sera_csm = sera_latch & nvstr_latch;
  assign  mase_csm = mase_latch & nvstr_latch;

  assign  pst7_porst = pst7 || porst;

  always @(posedge pos_aeoe or posedge pst7_porst)
  begin
     if(pst7_porst == 1'b1)
     begin
//        #0.1 // delay for ac-dc check
        prog_latch = 1'b0;
        mase_latch = 1'b0;
        sera_latch = 1'b0;
     end
     else if(pos_aeoe == 1'b1) 
     begin
        prog_latch = prog;// & (!tme);
        mase_latch = mase;// & (!tme);
        sera_latch = sera;// & (!tme);
     end
  end

  always @(prog_csm or sera_csm or mase_csm)
     tbit = prog_csm || sera_csm || mase_csm;

  always @(posedge nvstr or posedge pst7_porst)
  begin
     if(pst7_porst == 1'b1)
        nvstr_latch = 1'b0;
     else if(nvstr == 1'b1)
        nvstr_latch = prog_latch || sera_latch || mase_latch || fastp;
  end
  
//  always @(posedge pst7_porst or posedge osc or posedge nvstr_latch or posedge pos_aeoe_fastp or prog_csm or sera_csm or mase_csm or gangpgm or negedge nvstr or sg_stress or bl_stress or extpe or quad_pgm or fastp)
  always @(posedge pst7_porst or posedge osc )
  begin
     if(pst7_porst == 1'b1) 
     begin
        osc_cnt = 20'b0;
        #10
		pst7 = 1'b0; 
     end
// normal pgm/ers mode
  	 else if(((prog_csm == 1'b1) || (sera_csm == 1'b1) || (mase_csm == 1'b1)) && (!((fastp == 1'b1) || (gangpgm == 1'b1) || (sg_stress == 1'b1) || (bl_stress == 1'b1) || (extpe == 1'b1) || (quad_pgm == 1'b1))))
//  	 else if(((prog_csm == 1'b1) || (sera_csm == 1'b1) || (mase_csm == 1'b1)) && (!((fastp == 1'b1) || (gangpgm == 1'b1) || (sg_stress == 1'b1) || (bl_stress == 1'b1) || (extpe == 1'b1) || (quad_pgm == 1'b1))))
     begin
        if(((prog_csm == 1'b1) && (osc_cnt == `Tprog_cnt)) || ((sera_csm == 1'b1) && (osc_cnt == `Tser_cnt)) || ((mase_csm == 1'b1) && (osc_cnt == `Tmer_cnt)))
          begin
             pst7 = 1'b1; 
             #`Trv pst7 = 1'b0;
             osc_cnt = 20'b0;
          end
        else
          begin
             osc_cnt = osc_cnt + 1'b1;
          end
  	 end
// test mode
  	 else if((gangpgm == 1'b1) || (sg_stress == 1'b1) || (bl_stress == 1'b1) || (extpe == 1'b1) || (quad_pgm == 1'b1))
  	 begin
        if(nvstr == 1'b0 & tbit == 1'b1) 
        begin
           if(macro_erase_mode == 1'b1)
           begin
              #`Tbt_mase;
              tbit = 1'b0;
              pst7 = 1'b1;
           end
           else if(sector_erase_mode == 1'b1)
           begin
              #`Tbt_sera;
              tbit = 1'b0;
              pst7 = 1'b1;
           end
           else if(program_mode == 1'b1)
           begin
              #`Tbt_prog;
              tbit = 1'b0;
              pst7 = 1'b1;
           end
           #`Ttr pst7 = 1'b0;
        end
        if(prog_csm == 1'b1 || sera_csm == 1'b1 || mase_csm == 1'b1)
        begin
           tbit = 1'b1; 
        end
  	 end
// fastp mode
  	 else 
  	 begin
        if(nvstr == 1'b0 & tbit == 1'b1) 
        begin
           if(nvstr_latch == 1'b1)
           begin
              #`Tbt_prog;
              tbit = 1'b0;
              pst7 = 1'b1;
           #`Ttr pst7 = 1'b0;
           end
        end
        else if(nvstr_latch == 1'b1) 
           tbit = 1'b1;
  	 end
  end
  
  
//data output behavioral
  // manual trigger oe for sim,
  // oe can keep high when read mode, but it cann't trigger sensitive list when initial '1' in sim tool, so mannual setting
  reg oe_i;
  wire oe_o;
  initial begin
  oe_i = 1'b0; 
  #`InitTime;
  #50;
  oe_i = 1'b1;
  end
  assign  oe_o = oe_i & oe;
  
  reg ae_outen, oe_outen ;
  initial oe_outen=1'b0;	
  initial ae_outen=1'b0;	

  always @(ae)
  begin
     if(ae == 1'b1)
     begin 
       #`Tao ae_outen = 1'b0;
       #(`Tac-`Tao) ae_outen = 1'b1;
     end
  end

  always @(oe_o)
  begin
     if(oe_o == 1'b1)
        #`Toe oe_outen = oe_o;
     else
        oe_outen = oe_o;
  end
  assign outen = oe_outen;
  
//------------------------------------------------------------------
// initialisation of memory array using either one of the following method
//	1. initialize memory with specified data file 
//	2. using initial statement to set array to erase state
//------------------------------------------------------------------
   reg [(`BIT_DATA - 1):0] content [(`MEM_SIZE-1):0];
   reg [(`BIT_DATA - 1):0] content_info [(`INFO_SIZE-1):0];
   reg [(`BIT_DATA - 1):0] data_rd_temp;

   reg [`BIT_ADDR:0] i; 

//------------------------------------------------------------------
// initialisation of memory array using either one of the following method
//	1. initialize memory with specified data file 
//	2. using initial statement to set array to erase state
//------------------------------------------------------------------

/*
//	--------------- initialisation method 1 ------------------
	initial $readmemh (mem_file, content) ;
	initial $readmemh (info_file, content_info) ;
    $display("method1 Initial Load End"); 
*/
//   initial begin
//      content[0] = 8'h0f;
//      content[1] = 8'h12;
//      content[2] = 8'h23;
//      content[3] = 8'h34;
//      content[4] = 8'h45;
//      content[5] = 8'h56;
//   end
//	--------------- initialisation method 2 ------------------
    initial
    begin
      $display("Initial content to erase: all 1"); 
      for(i = 0; i < `MEM_SIZE; i = i + 1)
         content[i] = ALLFF256[(`BIT_DATA-1):0]; 
//         content[i] = `BIT_DATA'hFFFF_FFFF+i+32'h12345678; 
      for(i = 0; i < `INFO_SIZE; i = i + 1)
         content_info[i] = ALLFF256[(`BIT_DATA-1):0];
      $display("method2 Initial Load End"); 
    end

//------------------------------------------------------------------
//                Read MEMORY
//-------------------------------------------------------------------
//   Mode     CS  AE     OE  PROG  SERA  MASE  NVSTR   DIN   DOUT   ADDR  
//  Standby   L   X      X   X     X     X     X       X     Z      X
//  Read      H   L->H   H   L     L     L     L       X     Data   Valid
//  Program   H   L->H   L   H     L     L     H       Data  Z      Valid			              
//  Erase     H   L->H   L   L     H (or)H     H       X     Z      X

  assign  read_mode = cs & (!prog) & (!sera) & (!mase) & (!prog_latch) & (!sera_latch) & (!mase_latch) & (!fastp);// & (!tbit);
  assign  program_mode = cs & (!oe) & prog_latch & (!sera) & (!mase) & (!fastp) & (!porst);
  assign  sector_erase_mode = cs & (!oe) & (!prog) & sera_latch & (!mase) & (!fastp) & (!porst);
  assign  macro_erase_mode = cs & (!oe) & (!prog) & (!sera) & mase_latch & (!fastp) & (!porst);
  assign  fastp_mode = cs & (!oe) & (!prog) & (!sera) & (!mase) & fastp & (!porst);


//------------------------------------------------------------------
//                Illegal Read Operation Check
//-------------------------------------------------------------------
   always @(posedge pos_aeoe) 
   if ($time > `InitTime)
   begin
      if(tbit == 1'b1 && fastp == 1'b0)
      begin
         $display("                                "); 
         $display("                                "); 
         $display("!!!!!!Fatal error @%.2fns !!!!!!", $realtime); 
         $display("                                "); 
         $display("when tbit=1, read will cause unknown data out and program/erase failure.");
         $display("                                "); 
         $display("                                "); 
         #1000; // delay for time scale
         $stop;
         $finish;
         dout = `BIT_DATA'bxxxx_xxxx;
      end
   end

//------------------------------------------------------------------
//                Read MEMORY
//-------------------------------------------------------------------
  always @(ae_outen) 
   if ($time > `InitTime)
   begin
      if(cs == 1'b0) dout = ALL00256[(`BIT_DATA-1):0];
      else if(read_mode == 1'b0)
         dout = ALLXX256[(`BIT_DATA-1):0];
      else
      begin
         if((prog_latch == 1'b1) || (sera_latch == 1'b1) || (mase_latch == 1'b1))
            dout = ALLXX256[(`BIT_DATA-1):0];
         else
         begin
//-- when OE, AE setup, Dout output 'x'
            if(ae_outen == 1'b0)
               dout = ALLXX256[(`BIT_DATA-1):0];
//               dout = 32'habcd;

            else if((ae_outen == 1'b1) && (oe_outen == 1'b1) && (read_mode == 1'b1))
            begin
//Byte Mode
               if(byte_1 == 1'b1)
               begin
                  //read main memory
                  if(ifren_latch == 1'b0) 
					 begin
                     data_rd_temp = content[read_addr];
					 end
                  //read info memory
                  else if((ifren_latch == 1'b1) && (addr_latch[`BIT_ADDR-1:0]<`INFO_SIZE))
					 begin
                     data_rd_temp = content_info[read_addr[`INFO_BIT_ADDR-1:0]];
					 end
                  if(read_addr_1 == 1'b0)
					 begin
                     dout = {ALLXX256[(`BYTEWIDTH-1):0],data_rd_temp[(`BYTEWIDTH-1):0]}; 
					 end
                  else	 
					 begin
                     dout = {ALLXX256[(`BYTEWIDTH-1):0],data_rd_temp[(`WORDWIDTH-1):`BYTEWIDTH]};
					 end
               end
//Byte Mode
               else if(byte_1 == 1'b0)
               begin
                  //read main memory
                  if(ifren_latch == 1'b0)  
					 begin
                     dout = content[read_addr];	 
					 end
                  //read info memory
                  else if((ifren_latch == 1'b1) && (addr_latch[`BIT_ADDR-1:0]<`INFO_SIZE))
					 begin
                     dout = content_info[read_addr[`INFO_BIT_ADDR-1:0]];  
					 end
               end
            end
         end
      end  
   end

//------------------------------------------------------------------
//                Program Byte to  MEMORY
//   1. test mode gang program, only re-simulate can quit test mode after in test mode
//   2. normal program
//   Gang Program :addr [3:0] [7:4] [15:8]
//   [3:0]:  decide 8'h01/8'h11 or 8'h00/8'h10
//   [7:4]:  decided by circuit design
//   [15:8]: decide row, gang program in different row
//------------------------------------------------------------------
//------------------------------------------------------------------
   wire [(`BIT_DATA - 1):0] data_temp, data_temp_byte0, data_temp_byte1;
   wire [(`BIT_DATA - 1):0] data_temp_info, data_temp_info_byte0, data_temp_info_byte1;
   assign  data_temp            = content[addr_latch] & din_latch;
   assign  data_temp_byte0      = content[addr_latch] & {ALLFF256[(`BYTEWIDTH-1):0],din_latch[(`BYTEWIDTH-1):0]};
   assign  data_temp_byte1      = content[addr_latch] & {din_latch[(`BYTEWIDTH-1):0],ALLFF256[(`BYTEWIDTH-1):0]};
   assign  data_temp_info       = content_info[addr_latch[`INFO_BIT_ADDR-1:0]] & din_latch;
   assign  data_temp_info_byte0 = content_info[addr_latch[`INFO_BIT_ADDR-1:0]] & {ALLFF256[(`BYTEWIDTH-1):0],din_latch[(`BYTEWIDTH-1):0]};
   assign  data_temp_info_byte1 = content_info[addr_latch[`INFO_BIT_ADDR-1:0]] & {din_latch[(`BYTEWIDTH-1):0],ALLFF256[(`BYTEWIDTH-1):0]};

   always @(posedge prog_csm)
   if ($time >`InitTime)
   begin
      if(program_mode == 1'b1) 
      begin	
// x16 mode
         if(byte_1 == 1'b1)
         begin 
            if(addr_1_latch == 1'b0)
            begin 
				 //program main memory
                 if((ifren_latch==1'b0) && (program_mode == 1'b1))
                 content[addr_latch] = data_temp_byte0; 
				 //program info memory
                 if((ifren_latch==1'b1) && (program_mode == 1'b1))
                 content_info[addr_latch[`INFO_BIT_ADDR-1:0]] = data_temp_info_byte0;
            end 
            else
            begin
				  //program main memory
                 if((ifren_latch==1'b0) && (program_mode == 1'b1))
                 content[addr_latch] = data_temp_byte1; 
				 //program info memory
                 if((ifren_latch==1'b1) && (program_mode == 1'b1))
                 content_info[addr_latch[`INFO_BIT_ADDR-1:0]] = data_temp_info_byte1;
            end
         end
// x32 mode
		 else
		 begin
			 //program main memory
            if((ifren_latch==1'b0) && (program_mode == 1'b1))
            content[addr_latch] = data_temp;

            //program info memory
            if((ifren_latch==1'b1) && (program_mode == 1'b1))
            content_info[addr_latch[`INFO_BIT_ADDR-1:0]] = data_temp_info;
		 end
      end
   end



//------------------------------------------------------------------
//               Fastp Program Byte to  MEMORY
//------------------------------------------------------------------
   reg [`BIT_ADDR-1:8] addr_ftemp;
   reg busy;
   reg [7:0] fastp_cnt;
   
    initial
    begin
       busy = 1'b0; 
       fastp_cnt = 8'b0;
       addr_ftemp = 10'b0;
    end

   always @(posedge pos_aeoe_fastp or nvstr_latch)
   if ($time >`InitTime)
   begin
      if((fastp_mode == 1'b1) && (nvstr_latch == 1'b1) && (fastp_cnt == 8'b0))
      begin
         busy = 1'b1;
         #`Tprog;
         busy = 1'b0;
         fastp_cnt = 8'b1;
         addr_ftemp = addr_latch[`BIT_ADDR-1:8];
      end
      else if((fastp_mode == 1'b1) && (nvstr_latch == 1'b1) && (fastp_cnt != 8'b0))
      begin
         if(addr_ftemp != addr_latch[`BIT_ADDR-1:8])
         begin
            $display("                                "); 
            $display("Fatal ERROR! @%.2fns : ADDR[17:8] changed during FASTP mode",$realtime);
            $display("                                "); 
            $stop;
            $finish;
         end

         busy = 1'b1;
         #`Tfastp;
         busy = 1'b0;
         fastp_cnt = fastp_cnt + 1;

      end
   end
   
   reg [(`BIT_ADDR - 1):0] addr_fastp;
   always @(addr_latch)
   if ($time >`InitTime)
   begin
      addr_fastp = addr_latch; 
   end

   assign  pos_aeoe_fastp = pos_aeoe & fastp;

   always @(posedge pos_aeoe_fastp or nvstr_latch)
   if ($time >`InitTime)
   begin
      if((fastp_mode == 1'b1) && (nvstr_latch == 1'b1))
      begin
         //program main memory
         if(ifren_latch==1'b0)
         begin
//Byte Mode
            if(byte_1 == 1'b1)
            begin
               if(addr_1_latch == 1'b0)
               begin
                  content[addr_fastp] = data_temp_byte0;
               end
               else
               begin
                  content[addr_fastp] = data_temp_byte1;
               end
            end
//Double Byte Mode
            else
            begin
                  content[addr_fastp] = data_temp;
            end
         end

         //program info memory
         if((ifren_latch==1'b1) && (fastp_mode == 1'b1))
         begin
//Byte Mode
            if(byte_1 == 1'b1)
            begin
               if(addr_1_latch == 1'b0)
               begin
                  content_info[addr_fastp[(`INFO_BIT_ADDR-1):0]] = data_temp_info_byte0;
               end
               else
               begin
                  content_info[addr_fastp[(`INFO_BIT_ADDR-1):0]] = data_temp_info_byte1;
               end
            end
//Double Byte Mode
            else
            begin
                  content_info[addr_fastp[(`INFO_BIT_ADDR-1):0]] = data_temp_info;
            end
         end
      end
   end

   
//------------------------------------------------------------------
//                MEMORY Sector Erase
//------------------------------------------------------------------
   always @(posedge sera_csm)	 
//   if ($time >`InitTime)
   begin
         //main memory sector erase
         if((ifren_latch==1'b0) && (sector_erase_mode == 1'b1))
         begin
            for (i = 0; i < `SEC_SIZE; i=i+1)
               content[(addr_latch[(`BIT_ADDR-1):`SEC_BIT_ADDR]*`SEC_SIZE)+i] = ALLFF256[(`BIT_DATA-1):0];
         end			 

         if((ifren_latch==1'b1) && (sector_erase_mode == 1'b1))
         begin
            for (i = 0; i < `INFO_SEC_SIZE; i=i+1)
               content_info[(addr_latch[(`INFO_BIT_ADDR-1):`INFO_SEC_BIT_ADDR]*`INFO_SEC_SIZE)+i] = ALLFF256[(`BIT_DATA-1):0];
         end			 
   end

//------------------------------------------------------------------
//                Chip Erase
//------------------------------------------------------------------
   always @(posedge mase_csm)	 
   if ($time >`InitTime)
   begin
         //main memory sector erase
         if((ifren_latch==1'b0) && (macro_erase_mode == 1'b1))
         begin
            for (i = 0; i < `MEM_SIZE; i=i+1)
               content[i] = ALLFF256[(`BIT_DATA-1):0];
         end			 

         if((ifren_latch==1'b1) && (macro_erase_mode == 1'b1))
         begin
            for (i = 0; i < `INFO_SIZE; i=i+1)
               content_info[i] = ALLFF256[(`BIT_DATA-1):0];
            for (i = 0; i < `MEM_SIZE; i=i+1)
               content[i] = ALLFF256[(`BIT_DATA-1):0];
         end			 
   end
endmodule


/************************************************/
/*  test mode function                          */
/*  gang program                                */
/*  16 Bits on each I/O in a same row can		*/
/*  be programmed                               */ 
/************************************************/

module testmode_pf64ak32ei40(addr, din, 
                cs, oe, nvstr, prog, sera, mase,	 
                tme, tmr, vpp, vnn, gangpgm, sg_stress, bl_stress, extpe, quad_pgm);

    input [(`BIT_ADDR-1):0] addr;
    input cs, oe, nvstr, prog, sera, mase;
    input [(`BIT_DATA-1):0] din;
    input tme, tmr, vpp, vnn;
    output gangpgm, sg_stress, bl_stress, extpe, quad_pgm;

    reg         fsm_flag;
	reg         gangpgm;
	reg         margin_read, sg_stress, bl_stress, main_cell, ref_cell, extpe, quad_pgm;
	
    initial begin
       fsm_flag  = 1'b0;
       gangpgm = 1'b0;
       margin_read = 1'b0;
       sg_stress = 1'b0;
       bl_stress = 1'b0;
       main_cell = 1'b0;
       ref_cell = 1'b0;
       extpe = 1'b0;
       quad_pgm = 1'b0;
    end

   always @(posedge tmr or negedge tme)
   begin
      if(tme == 1'b0) 
      begin
         margin_read = 1'b0;
         gangpgm = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("quit TEST MODE because tme goes low"); 
      end
// gang program
      else if(cs && !oe && tme && nvstr && prog && !sera && !mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b1;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("Gang Program begin! in TEST MODE"); 
      end
// margin read
      else if(cs && !oe && tme && !nvstr && !prog && !sera && mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b1;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("Margin Read begin! in TEST MODE"); 
      end
// sg_stress
      else if(cs && !oe && tme && !nvstr && !prog && sera && !mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b1;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("SG Stress begin! in TEST MODE"); 
      end
// bl_stress
      else if(cs && !oe && tme && !nvstr && !prog && sera && mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b1;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("BL stress begin! in TEST MODE"); 
      end
// extpe
      else if(cs && !oe && tme && nvstr && !prog && sera && !mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b1;
         quad_pgm = 1'b0;
         $display("External program/erase begin! in TEST MODE"); 
      end
// main_cell
      else if(cs && !oe && tme && !nvstr && prog && !sera && mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b1;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("Main cell current begin! in TEST MODE"); 
      end
// ref_cell
      else if(cs && !oe && tme && !nvstr && prog && sera && !mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b1;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("Reference cell current begin! in TEST MODE"); 
      end
// quad_pgm
      else if(cs && !oe && tme && nvstr && prog && !sera && mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b1;
         $display("Quad program begin! in TEST MODE"); 
      end
// test mode exit
      else if(cs && !oe && tme && !nvstr && !prog && !sera && !mase && fsm_flag == 1'b1) 
      begin
         gangpgm = 1'b0;
         margin_read = 1'b0;
         fsm_flag  = 1'b0;  
         sg_stress = 1'b0;
         bl_stress = 1'b0;
         main_cell = 1'b0;
         ref_cell = 1'b0;
         extpe = 1'b0;
         quad_pgm = 1'b0;
         $display("TEST MODE Exit!!"); 
      end
//
      else if(cs && !oe && tme && !nvstr && !prog && !sera && !mase) 
      begin
         fsm_flag = 1'b1;
      end
      else
         fsm_flag = 1'b0;
   end
endmodule

//__________________________________________________________________
//
//  Module:        eflash_stb_top
//
//  Description:   Top-level module for E-Flash Serial Test Bus (STB)
//
//  Created:       09/30/2008
//
//  Revision:      1.1 -- byte mode ADDR mux error line 353  2008/10/24
//                 1.2 -- add Fast whole array read verify mode  2008/10/24
//                     -- add 2 more bits address to 18 bits address A17:A0 or A16:A0:AZ
//                 1.3 -- update Fast whole array read function  2008/12/08
//__________________________________________________________________

`timescale 1ns/1ps

//______________________________________________________________________________
//
// included modules / headers:
//______________________________________________________________________________

module eflash_stb_top (

    // eflash ip spi interface 
    SCLK, 
    SMTEN,
    SCE,  
//    SIO,  
       SIO_I,  
       SIO_O,  
       SIO_OEN,  //active low, when low, enable output from sio_o to PAD

    // eflash interface from asic
    IFREN, 
    ADDR,  
    DIN,   
    CS,    
    AE,    
    OE,    
    NVSTR, 
    PROG,  
    SERA,  
    MASE,  
    TME,   
    TMR,   
    DOUT,  
    TBIT,  

    // eflash ip interface to real macro

    // hidden pin for stb interface configuration
    i_eflash_porst, 
    i_eflash_byte,  
    o_eflash_addrz,

    // general pin for stb interface configuration
    o_eflash_ifren,
    o_eflash_addr,
    o_eflash_din,
    o_eflash_cs,
    o_eflash_ae,
    o_eflash_oe,
    o_eflash_nvstr,
    o_eflash_prog,
    o_eflash_sera,
    o_eflash_mase,
    o_eflash_tme,
    o_eflash_tmr,
    i_eflash_dout,
    i_eflash_tbit

);

//______________________________________________________________________________
//
// Parameter definitions
//______________________________________________________________________________

// macro size definitions
parameter EFLASH_ADDR_BITS =             'd14;
parameter EFLASH_DATA_BITS =             'd32;

// serial protocol definitions
parameter STB_INST_BITS =                'd8;
parameter STB_ADDR_BITS =                'd24;
parameter STATUS_REG_BITS =              'd8;
parameter STB_CONFIG_BITS =              'd32;  

// instruction codes
parameter STB_READ_I =                   8'h03;
parameter STB_PROG_I =                   8'h02;
parameter STB_SERASE_I =                 8'hD7;
parameter STB_MERASE_I =                 8'hC7;
parameter STB_READ_STATUS_REG_I =        8'h05;
parameter STB_EXIT_TM_I =                8'hA1;
parameter STB_BURST_PROG_I =             8'h0B;
parameter STB_MARGIN_READ_I =            8'h56;
parameter STB_GANG_PROG_I =              8'h54;
parameter STB_QUAT_ARRAY_PROG_I =        8'h58;
parameter STB_EXT_PROG_I =               8'h51;
parameter STB_EXT_SERASE_I =             8'h52;
parameter STB_EXT_MERASE_I =             8'h53;
parameter STB_EXIT_NVSTR_MODE_I =        8'hA2;
parameter STB_SG_STRESS_I =              8'h55;
parameter STB_BITLINE_STRESS_I =         8'h57;
parameter STB_MAIN_CELL_CURRENT_I =      8'hA3;
parameter STB_REF_CELL_CURRENT_I =       8'hA5;
parameter STB_DISABLE_INT_PUMP_I =       8'hA7;
parameter STB_BURST_GANG_PROG_I =        8'hA8;
parameter STB_QUAT_SECTOR_PROG_I =       8'hA4;
parameter STB_REF_OPT_I         =        8'hA6;
parameter STB_FAST_READ_I       =        8'h07;

// main fsm state parameters
parameter STB_STATE_BITS =               3;      
parameter STB_IDLE_STATE =               3'h0;       // stb idle state												  6
parameter STB_INSTRUCTION_STATE =        3'h1;       // stb input instruction phase
parameter STB_ADDRESS_STATE =            3'h2;       // stb input address phase
parameter STB_DATA_STATE =               3'h3;       // stb input data phase
parameter STB_TM_CONFIG_STATE =          3'h4;       // stb test mode configuration phase
parameter STB_READ_STATE =               3'h5;       // stb read state
parameter STB_DELAY_STATE =              3'h6;       // stb general delay state
parameter STB_FASTREAD_STATE =           3'h7;       // stb fast read state 

// main fsm timing parameters
parameter STB_TIMING_BITS =              4;
parameter STB_TM_CONFIG_CYCLES =         4'h8;       // duration of stb test mode configuration phase
parameter STB_PROG_CONFIG_CYCLES =       4'h8;       // duration of stb program configuration phase
parameter STB_ERASE_CONFIG_CYCLES =      4'h8;       // duration of stb (sector/mass) erase configuration phase

// eflash fsm state parameters
parameter EFLASH_STATE_BITS =            4;      
parameter EFLASH_IDLE_STATE =            4'h0;       // eflash idle state
parameter EFLASH_PROG_SETUP1_STATE =     4'h1;       // eflash program setup state 1
parameter EFLASH_PROG_SETUP2_STATE =     4'h2;       // eflash program setup state 2
parameter EFLASH_PROG_ACTIVE_STATE =     4'h3;       // eflash program active state
parameter EFLASH_PROG_POST_DELAY_STATE = 4'h4;       // eflash program post delay state
parameter EFLASH_PROG_BURST_INC_STATE =  4'h5;       // eflash burst program transition state
parameter EFLASH_ERASE_SETUP1_STATE =    4'h6;       // eflash erase setup state 1
parameter EFLASH_ERASE_SETUP2_STATE =    4'h7;       // eflash erase setup state 2
parameter EFLASH_ERASE_ACTIVE_STATE =    4'h8;       // eflash erase active state
parameter EFLASH_ERASE_TPRC_STATE =      4'h9;       // eflash erase tPRC delay state
parameter EFLASH_MEASURE_SETUP1_STATE =  4'hA;       // eflash measure setup state
parameter EFLASH_MEASURE_ACTIVE_STATE =  4'hB;       // eflash measure active state

// eflash fsm timing parameters
parameter EFLASH_TIMING_BITS =           1;

// Fast whole array read verify mode DATA_BITS
parameter STB_FASTREAD_DATA_BITS  =      'd32;

// stb test passphrase
parameter STB_TEST_AMTEN =               32'haa_55_a0_0a;

// stb macro tprc, tprog
parameter EFLASH_TPRC_CYCLES =           1'h1;
//______________________________________________________________________________
//
// Port definitions
//______________________________________________________________________________

// stb pads
input                           SCLK;      // stb clock
input                           SCE;       // stb chip select (active low)
input                           SMTEN;     // stb macro test enable
//inout                           SIO;       // stb macro bi-direction IO
input                           SIO_I;  
output                          SIO_O;  
output                          SIO_OEN;  //active low, when low, enable output from sio_o to PAD

// eflash interface from ASIC
input                           IFREN;     // eflash information block enable
input  [EFLASH_ADDR_BITS-1:0]   ADDR;      // eflash address bus
input  [EFLASH_DATA_BITS-1:0]   DIN;       // eflash input data
input                           CS;        // eflash macro select
input                           AE;        // eflash address enable
input                           OE;        // eflash input  enable
input                           NVSTR;     // eflash non-volatile store signal
input                           PROG;      // eflash program control signal
input                           SERA;      // eflash page erase control signal
input                           MASE;      // eflash mass erase control signal
input                           TME;       // eflash test mode enable
input                           TMR;       // eflash test mode signal
output [EFLASH_DATA_BITS-1:0]   DOUT;      // eflash output data
output                          TBIT;      // eflash indicator of program/erase completion

// eflash interface to IP macro
input                           i_eflash_porst;        // eflash power on reset, active high
input                           i_eflash_byte;         // eflash x8 / x16 mode option, 1: x8; 0: x16
output                          o_eflash_addrz;        // eflash x8 mode lowest address

output                          o_eflash_ifren;       // eflash information block enable
output [EFLASH_ADDR_BITS-1:0]   o_eflash_addr;        // eflash address bus
output [EFLASH_DATA_BITS-1:0]   o_eflash_din;         // eflash outputdata
output                          o_eflash_cs;          // eflash macro select
output                          o_eflash_ae;          // eflash address enable
output                          o_eflash_oe;          // eflash output enable
output                          o_eflash_nvstr;       // eflash non-volatile store signal
output                          o_eflash_prog;        // eflash program control signal
output                          o_eflash_sera;        // eflash page erase control signal
output                          o_eflash_mase;        // eflash mass erase control signal
output                          o_eflash_tme;         // eflash test mode enable
output                          o_eflash_tmr;         // eflash test mode signal
input  [EFLASH_DATA_BITS-1:0]   i_eflash_dout;        // eflash input  data
input                           i_eflash_tbit;        // eflash indicator of program/erase completion

//______________________________________________________________________________
//
// Internal signals
//______________________________________________________________________________

// pad output registers
reg                             stb_pad_data_oe_q;

// eflash output registers
reg     [EFLASH_DATA_BITS-1:0]  eflash_din_q; 
reg                             eflash_ae_q;  
reg                             eflash_pre_ae_q;  
reg                             eflash_oe_q;  
reg                             eflash_nvstr_q;
reg                             eflash_prog_q;
reg                             eflash_sera_q;
reg                             eflash_mase_q;
reg                             eflash_tme_q; 
reg                             eflash_tmr_q; 

// state machine signals
reg     [STB_STATE_BITS-1:0]    stb_state_current_q;        // stb fsm current state
reg     [STB_STATE_BITS-1:0]    stb_state_next;             // stb fsm next state
reg     [EFLASH_STATE_BITS-1:0] eflash_state_next;          // eflash fsm next state
reg     [EFLASH_STATE_BITS-1:0] eflash_state_current_q;     // eflash fsm current state
reg     [STB_TIMING_BITS-1:0]   stb_state_timer_q;          // timer determines how long to stay in the same stb fsm state
reg     [STB_TIMING_BITS-1:0]   stb_state_timer_next;       // stb fsm next timer value
reg                             eflash_state_timer_q;      // timer determines how long to stay in the same eflash fsm state
reg                             eflash_state_timer_next;   // eflash fsm next timer value

wire                            stb_arstn;
wire                            stb_active;

reg     [STB_INST_BITS-1:0]     instruction_q;
reg     [4:0]                   instruction_bit_count_q;
reg                             instruction_bit_enable_next;
reg                             first_instruction_bit_next;
wire                            concurrent_instruction;

reg     [STB_CONFIG_BITS-1:0]   config_vector_q;
wire    [31:0]                  stb_test_pass_phrase;

reg     [STB_ADDR_BITS-1:0]     address_q;
reg     [4:0]                   address_bit_count_q;
reg                             address_bit_enable_next;
reg                             first_address_bit_next;
wire                            address_phase_next;
wire                            address_inc_next;

reg     [EFLASH_DATA_BITS-1:0]  eflash_dout_q;
wire                            eflash_serial_dout;
reg                             read_trigger_next;
reg     [4:0]                   read_cycle_count_q_dummy;
reg     [4:0]                   read_cycle_count_q;
reg     [4:0]                   read_cycle_count_del_q;
reg     [4:0]                   read_cycle_count_del_q_dummy;
wire    [4:0]                   read_vector_length;
wire                            eflash_read_instruction;
wire                            eflash_fastread_instruction;

wire                            data_phase_next;
//reg     [EFLASH_DATA_BITS-1:0]  pre_data_in_q;
reg[STB_FASTREAD_DATA_BITS-1:0] pre_data_in_q;
reg     [4:0]                   data_bit_count_q;
reg                             program_trigger_next;
reg                             erase_trigger_next;
reg                             data_bit_enable_next;
reg                             first_data_bit_next;
reg                             current_measure_trigger_next;

wire    [STATUS_REG_BITS-1:0]   stb_status;
wire                            stb_serial_status;
reg                             flag_bit_q;
reg                             set_flag_bit_next;
wire                            clr_flag_bit_next;

wire                            set_tme_next;
wire                            clr_tme_next;
wire                            set_tmr_next;
wire                            clr_tmr_next;

wire                            set_tm_code_next;
wire                            clr_tm_code_next;
reg                             tm_code_phase_next_q;
reg     [3:0]                   tm_config_code;
wire                            inst_tm_config_phase_next;
wire                            data_tm_config_phase_next;

wire                            stb_pad_clk_buf;
wire                            stb_clk;
wire                            stb_inv_clk; // used for negedge triggered flops

// additional signal
reg                             stb_soft_smten_q;
wire                            eflash_to_stb_mux;
wire                            porstn;
wire    [5:0]                   eflash_data_bit_count;
wire    [EFLASH_ADDR_BITS-1:0]  eflash_addr_byte;
wire                            stb_state_rstn;
wire                            eflash_fast_read_ae;
wire                            fastread_cmp_out_x8_next;
wire                            fastread_cmp_out_x16_next;
wire                            fastread_cmp_out_next;
reg                             fastread_cmp_out_q;

wire                            i_stb_pad_data_in;  // stb serial data input
wire                            o_stb_pad_data_out; // stb serial data output
wire                            o_stb_pad_data_oen; // stb data output enable
//________________________________________________
//
// stb and eflash IO mux structure
//________________________________________________

//        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//        ~     SCE	SCLK SIO  SMTEN                               ~
//        ~     |    |    |	  |                                  ~
//        ~    |----------------|            |------------|      ~
//        ~    |       STB      |----------->|   MACRO    |      ~
//        ~    |    interface   | o_flash_ae |   ARRAY    |      ~
//        ~    |----------------|            |------------|      ~
//        ~     |     | NVSTR|                                   ~
//        ~     | PROG|      |                                   ~
//        ~   AE|     |      |                                   ~
//        ~     |     |      |          pFusion with STB         ~
//        ~ ~~~~|~~~~~|~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//            |----------------|
//            |      ASIC      |
//            |                |
//            |----------------|

//______________________________________________________________________________
//
// Output Assignments
//______________________________________________________________________________

//______________________________________________________________________________
//
// SIO high-Z IO buffer
//______________________________________________________________________________

// gate library model
//PAD_Z    SIO_buf (.I (o_stb_pad_data_out), .OEN (o_stb_pad_data_oen), .PAD (SIO), .O (i_stb_pad_data_in));

assign  i_stb_pad_data_in    = SIO_I;
assign  SIO_O                = o_stb_pad_data_out;
assign  SIO_OEN              = o_stb_pad_data_oen;

// stb pads
assign  o_stb_pad_data_oen    = ~stb_pad_data_oe_q;

//assign  eflash_data_bit_count = eflash_fastread_instruction  ? 'd32: (i_eflash_byte ? 'd8 : 'd16);	  
assign  eflash_data_bit_count = eflash_fastread_instruction  ? 'd32: (i_eflash_byte ? 'd16 : 'd32);	  

assign  o_stb_pad_data_out    = eflash_fastread_instruction ? fastread_cmp_out_q :
                                (eflash_read_instruction ? eflash_serial_dout :
                                (instruction_q == STB_READ_STATUS_REG_I) ? stb_serial_status : 1'h0);
// eflash interface
assign  o_eflash_cs           = eflash_to_stb_mux ? stb_arstn : CS;
assign  o_eflash_ae           = eflash_to_stb_mux ? 
                                (eflash_fastread_instruction  ? eflash_fast_read_ae : eflash_ae_q) : AE; 

assign  o_eflash_oe           = eflash_to_stb_mux ? eflash_oe_q : OE;         
assign  o_eflash_ifren        = eflash_to_stb_mux ? address_q[STB_ADDR_BITS-1] : IFREN;

assign  eflash_addr_byte      = eflash_to_stb_mux ? address_q[EFLASH_ADDR_BITS-1:0] : ADDR[EFLASH_ADDR_BITS-1:0];
assign  o_eflash_addr         = i_eflash_byte ? {1'b0,eflash_addr_byte[EFLASH_ADDR_BITS-1:1]} : eflash_addr_byte[EFLASH_ADDR_BITS-1:0];
assign  o_eflash_addrz        = i_eflash_byte ? eflash_addr_byte[0] : 1'b0;

assign  o_eflash_din          = eflash_to_stb_mux ? eflash_din_q : DIN;
assign  o_eflash_nvstr        = eflash_to_stb_mux ? eflash_nvstr_q : NVSTR;
assign  o_eflash_prog         = eflash_to_stb_mux ? eflash_prog_q : PROG;
assign  o_eflash_sera         = eflash_to_stb_mux ? eflash_sera_q : SERA;
assign  o_eflash_mase         = eflash_to_stb_mux ? eflash_mase_q : MASE;
assign  o_eflash_tme          = eflash_to_stb_mux ? eflash_tme_q : TME;
assign  o_eflash_tmr          = eflash_to_stb_mux ? eflash_tmr_q : TMR;

assign  DOUT                  = i_eflash_dout;
assign  TBIT                  = i_eflash_tbit;

//______________________________________________________________________________
//
// Fast Read Logic
//______________________________________________________________________________

assign  eflash_fast_read_ae   = ((stb_state_next == STB_FASTREAD_STATE) && eflash_oe_q) ? stb_inv_clk : 1'b0;
assign  fastread_cmp_out_x8_next = ((address_q[1:0]==3'b00) && (i_eflash_dout[7:0]==pre_data_in_q[7:0])) ||
                                   ((address_q[1:0]==3'b01) && (i_eflash_dout[7:0]==pre_data_in_q[15:8])) ||
                                   ((address_q[1:0]==3'b10) && (i_eflash_dout[7:0]==pre_data_in_q[23:16])) ||
                                   ((address_q[1:0]==3'b11) && (i_eflash_dout[7:0]==pre_data_in_q[31:24]));
assign  fastread_cmp_out_x16_next = ((address_q[0]==1'b0) && (i_eflash_dout==pre_data_in_q[15:0])) ||
                                    ((address_q[0]==1'b1) && (i_eflash_dout==pre_data_in_q[31:16]));
assign  fastread_cmp_out_next	  = i_eflash_byte ? fastread_cmp_out_x8_next : fastread_cmp_out_x16_next;

always @(posedge stb_inv_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    fastread_cmp_out_q <= 1'b0;
  else 
    if (fastread_cmp_out_next)
      fastread_cmp_out_q <= 1'b1;
    else
      fastread_cmp_out_q <= 1'b0;
end
//________________________________________________
//
// stb status logic
//________________________________________________

assign  stb_active =            ~SCE; //~i_stb_pad_csn;
// status update for customer SPI interface check.
assign  stb_status =            {1'b1, //eflash_tme_q, 
                                 1'b0, //eflash_tmr_q, 
                                 1'b1, //eflash_nvstr_q, 
                                 1'b0, //eflash_prog_q, 
                                 1'b1, //eflash_sera_q, 
                                 1'b0, //eflash_mase_q, 
                                flag_bit_q, 
                                i_eflash_tbit};

assign  stb_serial_status = stb_status >> (STATUS_REG_BITS - 1'b1 - read_cycle_count_del_q_dummy);

//________________________________________________
//
// eflash addressing logic
//________________________________________________

assign  address_phase_next =    (instruction_q == STB_READ_I) || 
                                (instruction_q == STB_PROG_I) ||
                                (instruction_q == STB_SERASE_I) || 
                                (instruction_q == STB_MERASE_I) || 
                                (instruction_q == STB_GANG_PROG_I) ||
                                (instruction_q == STB_QUAT_ARRAY_PROG_I) || 
                                (instruction_q == STB_EXT_PROG_I) ||
                                (instruction_q == STB_EXT_SERASE_I) || 
                                (instruction_q == STB_EXT_MERASE_I) || 
                                (instruction_q == STB_SG_STRESS_I) ||
                                (instruction_q == STB_QUAT_SECTOR_PROG_I ) ||
                                (instruction_q == STB_BITLINE_STRESS_I) || 
                                (instruction_q == STB_REF_OPT_I) ||
                                (instruction_q == STB_MAIN_CELL_CURRENT_I) ||
                                (instruction_q == STB_REF_CELL_CURRENT_I) ||
                                (instruction_q == STB_FAST_READ_I);

assign  address_inc_next =      (eflash_read_instruction && eflash_ae_q) ||
                                (eflash_fastread_instruction && (stb_state_current_q==STB_FASTREAD_STATE)) ||
                                ((eflash_state_current_q == EFLASH_PROG_BURST_INC_STATE) && 
                                (eflash_state_next == EFLASH_PROG_SETUP1_STATE));
                                
always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
  begin  
    address_bit_count_q <= 5'h0;
    address_q <= {STB_ADDR_BITS{1'h0}};
  end
  else if (address_bit_enable_next)
  begin
    if (first_address_bit_next)
    begin
      address_bit_count_q <= 5'h0;
      address_q <= {{(STB_ADDR_BITS-1){1'h0}}, i_stb_pad_data_in};
    end
    else
    begin
      address_bit_count_q <= address_bit_count_q + 1'h1;
      address_q <= {address_q[STB_ADDR_BITS-2:0], i_stb_pad_data_in};
    end
  end
  else if (address_inc_next)
    {address_q[STB_ADDR_BITS-1], address_q[EFLASH_ADDR_BITS-1:0]} <= {address_q[STB_ADDR_BITS-1], address_q[EFLASH_ADDR_BITS-1:0]} + 1'h1;
end

//________________________________________________
//
// eflash test mode configuration logic
//________________________________________________

// Test mode configuration state cycles:
//
// TME         ______|------------------------------------------
//
// TMR         ____________|-----|___________|-----|____________
//
// TM_CODE     ________________________|=================|______
//
// TIMER_NEXT  |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |
//

assign inst_tm_config_phase_next = (instruction_q == STB_MARGIN_READ_I) || 
                                   (instruction_q == STB_EXIT_TM_I) ||
                                   (instruction_q == STB_DISABLE_INT_PUMP_I);

assign data_tm_config_phase_next = (instruction_q == STB_GANG_PROG_I) || 
                                   (instruction_q == STB_BURST_GANG_PROG_I) || 
                                   (instruction_q == STB_QUAT_ARRAY_PROG_I) ||
                                   (instruction_q == STB_EXT_PROG_I) ||
                                   (instruction_q == STB_SG_STRESS_I) ||
                                   (instruction_q == STB_QUAT_SECTOR_PROG_I ) ||
                                   (instruction_q == STB_BITLINE_STRESS_I) ||
                                   (instruction_q == STB_REF_OPT_I) ||
                                   (instruction_q == STB_MAIN_CELL_CURRENT_I) ||
                                   (instruction_q == STB_REF_CELL_CURRENT_I);

assign set_tme_next = (stb_state_next == STB_TM_CONFIG_STATE) && (stb_state_timer_next == 'h8);
assign clr_tme_next = (instruction_q == STB_EXIT_TM_I);

assign set_tmr_next = (!i_eflash_tbit) && (stb_state_next == STB_TM_CONFIG_STATE) && ((stb_state_timer_next == 'h7) || (stb_state_timer_next == 'h4));
assign clr_tmr_next = ((stb_state_next == STB_TM_CONFIG_STATE) && ((stb_state_timer_next == 'h6) || (stb_state_timer_next == 'h3))) ||
                      (stb_state_next == STB_IDLE_STATE) || (instruction_q == STB_EXIT_TM_I);

assign set_tm_code_next = (stb_state_next == STB_TM_CONFIG_STATE) && (stb_state_timer_next == 'h6);    
assign clr_tm_code_next = ((stb_state_next == STB_TM_CONFIG_STATE) && (stb_state_timer_next == 'h3)) ||
                          (stb_state_next == STB_IDLE_STATE);                                                                     

always @(instruction_q)
begin
  tm_config_code = 4'b0;
  case (instruction_q)
    STB_EXIT_TM_I:              tm_config_code = 4'b0000;
    STB_MARGIN_READ_I:          tm_config_code = 4'b0001;
    STB_GANG_PROG_I:            tm_config_code = 4'b1100;
    STB_QUAT_ARRAY_PROG_I:      tm_config_code = 4'b1101;
    STB_EXT_PROG_I:             tm_config_code = 4'b1010;
    STB_EXT_SERASE_I:           tm_config_code = 4'b1010;
    STB_EXT_MERASE_I:           tm_config_code = 4'b1010;
    STB_SG_STRESS_I:            tm_config_code = 4'b0010;
    STB_BITLINE_STRESS_I:       tm_config_code = 4'b0011;
    STB_MAIN_CELL_CURRENT_I:    tm_config_code = 4'b0101;
    STB_REF_CELL_CURRENT_I:     tm_config_code = 4'b0110;
    STB_DISABLE_INT_PUMP_I:     tm_config_code = 4'b1001;
    STB_BURST_GANG_PROG_I:      tm_config_code = 4'b1100;
    STB_QUAT_SECTOR_PROG_I:     tm_config_code = 4'b1000;
    STB_REF_OPT_I:              tm_config_code = 4'b1011;
  endcase
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    eflash_tme_q <= 1'h0;
  else
  if (clr_tme_next)
    eflash_tme_q <= 1'h0;
  else
  if (set_tme_next)
    eflash_tme_q <= 1'h1;
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    eflash_tmr_q <= 1'h0;
  else
  if (clr_tmr_next)
    eflash_tmr_q <= 1'h0;
  else
  if (set_tmr_next)
    eflash_tmr_q <= 1'h1;
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    tm_code_phase_next_q <= 1'h0;
  else
  if (clr_tm_code_next)
    tm_code_phase_next_q <= 1'h0;
  else
  if (set_tm_code_next)
    tm_code_phase_next_q <= 1'h1;
end

//________________________________________________
//
// eflash read logic
//________________________________________________

assign read_vector_length = (instruction_q == STB_READ_STATUS_REG_I) ? STATUS_REG_BITS : eflash_data_bit_count;
assign eflash_read_instruction = (instruction_q == STB_READ_I) || (instruction_q == STB_MARGIN_READ_I);
assign eflash_fastread_instruction = (instruction_q == STB_FAST_READ_I);

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
  begin
    eflash_ae_q <= 1'h0;
    eflash_oe_q <= 1'h0;
  end
  else
  begin
    eflash_ae_q <= 1'h0;
    eflash_oe_q <= 1'h0;
    if ((stb_state_next == STB_READ_STATE) && eflash_read_instruction)
    begin
      eflash_oe_q <= 1'h1;
      if (read_trigger_next)
        eflash_ae_q <= 1'h1;
    end
    else if (eflash_pre_ae_q)
      eflash_ae_q <= 1'h1;
    else if ((stb_state_next == STB_FASTREAD_STATE) && eflash_fastread_instruction)
      eflash_oe_q <= 1'h1;
  end
end

//always @(posedge stb_clk or negedge stb_arstn)
always @(posedge stb_clk or negedge stb_state_rstn)
begin
  if (!stb_state_rstn)
    stb_pad_data_oe_q <= 1'h0;
  else
  begin
    if (stb_state_next == STB_READ_STATE)	 
      begin
        if(read_cycle_count_q_dummy == 5'h07)
          stb_pad_data_oe_q <= 1'h1;
      end
    else
      stb_pad_data_oe_q <= 1'h0;
  end
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    read_cycle_count_q <= 5'h0;
  else 
  if (stb_state_next == STB_READ_STATE)
  begin
    if (read_trigger_next)
      read_cycle_count_q <= 5'h0;
    else
      read_cycle_count_q <= read_cycle_count_q + 1'h1;
  end
  else
      read_cycle_count_q <= 5'h0;
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    read_cycle_count_q_dummy <= 5'h0;
  else 
  if (stb_state_next == STB_READ_STATE)
  begin
      begin
      if (read_cycle_count_q_dummy != 5'h07)
        read_cycle_count_q_dummy <= read_cycle_count_q_dummy + 1'h1;
      end
  end
  else
      read_cycle_count_q_dummy <= 5'h0;
end

always @(posedge stb_inv_clk or negedge stb_arstn)    // sensitive to falling edge
begin
  if (!stb_arstn)
    read_cycle_count_del_q <= 5'h0;
  else 
  begin
    if (read_trigger_next)
      read_cycle_count_del_q <= 5'h0;
    else
      read_cycle_count_del_q <= read_cycle_count_q + 1'h1;
  end
end

always @(posedge stb_inv_clk)
begin
  read_cycle_count_del_q_dummy <= read_cycle_count_del_q;
end

always @(posedge stb_inv_clk or negedge stb_arstn)    // sensitive to falling edge
begin
  if (!stb_arstn)
    eflash_dout_q <= {EFLASH_DATA_BITS{1'h0}};
  else
  if (read_trigger_next)
    eflash_dout_q <= i_eflash_dout;
end

assign  eflash_serial_dout    = eflash_dout_q >> (eflash_data_bit_count - 1'b1 - read_cycle_count_del_q);

//________________________________________________
//
// instruction logic
//________________________________________________

assign concurrent_instruction = (instruction_q == STB_EXIT_TM_I) ||
                                (instruction_q == STB_READ_STATUS_REG_I) ||
                                (instruction_q == STB_BURST_PROG_I) ||
                                (instruction_q == STB_BURST_GANG_PROG_I) ||
                                (instruction_q == STB_EXIT_NVSTR_MODE_I);

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
  begin  
    instruction_bit_count_q <= 3'h0;
    instruction_q <= 8'h0;
  end
  else if (instruction_bit_enable_next)
  begin
    if (first_instruction_bit_next)
    begin
      instruction_bit_count_q <= 3'h0;
      instruction_q <= {7'h0, i_stb_pad_data_in};
    end
    else
    begin
      instruction_bit_count_q <= instruction_bit_count_q + 1'h1;
      instruction_q <= {instruction_q[6:0], i_stb_pad_data_in};
    end
  end
end

//________________________________________________
//
// passphrase, timing and erase_t configuration logic
//________________________________________________

always @(posedge stb_clk or negedge porstn)
begin
  if (!porstn)
  begin  
    config_vector_q <= 32'h0;
  end
  else if (stb_active)
  begin
    config_vector_q <= {config_vector_q[30:0], i_stb_pad_data_in};
  end
end

assign  stb_test_pass_phrase            = config_vector_q[31:0];

//________________________________________________
//
// data input logic
//________________________________________________

assign  data_phase_next =       (instruction_q == STB_PROG_I) || 
                                (instruction_q == STB_BURST_PROG_I) ||
                                (instruction_q == STB_GANG_PROG_I) ||
                                (instruction_q == STB_BURST_GANG_PROG_I) ||
                                (instruction_q == STB_QUAT_ARRAY_PROG_I) ||
                                (instruction_q == STB_EXT_PROG_I) ||
                                (instruction_q == STB_QUAT_SECTOR_PROG_I ) ||
                                (instruction_q == STB_SG_STRESS_I) ||
                                (instruction_q == STB_BITLINE_STRESS_I) ||
                                (instruction_q == STB_REF_OPT_I) ||
                                (instruction_q == STB_MAIN_CELL_CURRENT_I) ||
                                (instruction_q == STB_REF_CELL_CURRENT_I) ||
                                (instruction_q == STB_FAST_READ_I);
                                
always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
  begin  
    data_bit_count_q <= 5'h0;
    pre_data_in_q <= {STB_FASTREAD_DATA_BITS{1'h0}};
  end
  else if (data_bit_enable_next)
  begin
    if (first_data_bit_next)
    begin
      data_bit_count_q <= 5'h0;
      pre_data_in_q <= {{(STB_FASTREAD_DATA_BITS-1){1'h0}}, i_stb_pad_data_in};
    end
    else
    begin
      data_bit_count_q <= data_bit_count_q + 1'h1;
      pre_data_in_q <= {pre_data_in_q[STB_FASTREAD_DATA_BITS-2:0], i_stb_pad_data_in};
    end
  end
end

//________________________________________________
//
// main fsm logic
//________________________________________________

assign stb_state_rstn = !((!stb_arstn) || (!stb_active));
always @(posedge stb_clk or negedge stb_state_rstn)
begin
  if (!stb_state_rstn)      stb_state_current_q   <= STB_IDLE_STATE;
  else                     stb_state_current_q   <= stb_state_next;
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    stb_state_timer_q <= 'h0;
  else if (stb_state_timer_next)
    stb_state_timer_q <= stb_state_timer_next - 'h1;
  else
    stb_state_timer_q <= 'h0;
end


always @(stb_state_current_q or stb_state_timer_q or 
         stb_active or instruction_bit_count_q or instruction_q or eflash_state_current_q or
         concurrent_instruction or address_phase_next or inst_tm_config_phase_next or eflash_fastread_instruction or
         address_bit_count_q or eflash_read_instruction or data_phase_next or data_bit_count_q or
         data_tm_config_phase_next or read_cycle_count_q or read_vector_length or eflash_data_bit_count)
begin
  // default values
  stb_state_next = stb_state_current_q;
  stb_state_timer_next = stb_state_timer_q;
  first_instruction_bit_next = 1'b0;
  instruction_bit_enable_next = 1'b0;
  first_address_bit_next = 1'b0;
  address_bit_enable_next = 1'b0;
  read_trigger_next = 1'b0;
  first_data_bit_next = 1'b0;
  data_bit_enable_next = 1'b0;
  program_trigger_next = 1'b0;
  erase_trigger_next = 1'b0;
  set_flag_bit_next = 1'b0;
  current_measure_trigger_next = 1'b0;

  case (stb_state_current_q)

  // idle state
  STB_IDLE_STATE:
  begin
    if (stb_active)
    begin
      stb_state_next = STB_INSTRUCTION_STATE;
      instruction_bit_enable_next = 1'b1;
      first_instruction_bit_next = 1'b1;
    end
  end

  // instruction input phase
  STB_INSTRUCTION_STATE:
  begin
    if (stb_active)
    begin
      if (instruction_bit_count_q != (STB_INST_BITS-1))
        instruction_bit_enable_next = 1'b1;
      else
      begin
        if ((eflash_state_current_q != EFLASH_IDLE_STATE) && !concurrent_instruction)
          stb_state_next = STB_IDLE_STATE; // eflash macro is busy. access denied.
        else
        begin
          if (address_phase_next)
          begin
            stb_state_next = STB_ADDRESS_STATE;
            address_bit_enable_next = 1'b1;
            first_address_bit_next = 1'b1;
          end
          else 
          if (inst_tm_config_phase_next) 
          begin
            stb_state_next = STB_TM_CONFIG_STATE;
            stb_state_timer_next = STB_TM_CONFIG_CYCLES;
          end
          else
          if (instruction_q == STB_READ_STATUS_REG_I) 
          begin
          $display("Read SPI status register! @%.2fns",$realtime); // 2011.07.08
            read_trigger_next = 1'b1;  
            stb_state_next = STB_READ_STATE;
          end
          else
          if ((instruction_q == STB_BURST_PROG_I) || (instruction_q == STB_BURST_GANG_PROG_I))
          begin
            if (eflash_state_current_q == EFLASH_IDLE_STATE)
            begin
              stb_state_next = STB_ADDRESS_STATE;
              address_bit_enable_next = 1'b1;
              first_address_bit_next = 1'b1;
            end
            else
            begin
              stb_state_next = STB_DATA_STATE;
              data_bit_enable_next = 1'b1;
              first_data_bit_next = 1'b1;
            end
          end
          else
            stb_state_next = STB_IDLE_STATE;
        end
      end
//      else
//        stb_state_next = STB_IDLE_STATE;
    end
    else
      stb_state_next = STB_IDLE_STATE;
  end

  // address input phase
  STB_ADDRESS_STATE:
  begin
    if (stb_active)
    begin
      if (address_bit_count_q != (STB_ADDR_BITS-1))  // modified by Zico
        address_bit_enable_next = 1'b1;
      else
      begin

        // ---------------------------------------

        if (eflash_read_instruction)
        begin
          read_trigger_next = 1'b1;  
          stb_state_next = STB_READ_STATE;
        end
        else
        if (data_phase_next)
        begin
          stb_state_next = STB_DATA_STATE;
          data_bit_enable_next = 1'b1;
          first_data_bit_next = 1'b1;
        end
        else
        if ((instruction_q == STB_SERASE_I) || (instruction_q == STB_MERASE_I))
        begin
          erase_trigger_next = 1'b1;
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_ERASE_CONFIG_CYCLES;
        end
        else
        if ((instruction_q == STB_EXT_SERASE_I) || (instruction_q == STB_EXT_MERASE_I))
        begin
          stb_state_next = STB_TM_CONFIG_STATE;
          stb_state_timer_next = STB_TM_CONFIG_CYCLES;
        end
        else
          stb_state_next = STB_IDLE_STATE;

        // ---------------------------------------

      end
    end
    else
      stb_state_next = STB_IDLE_STATE;
  end

  // data input phase
  STB_DATA_STATE:
  begin
    if (stb_active)
    begin
      if (data_bit_count_q != (eflash_data_bit_count-1))
        data_bit_enable_next = 1'b1;
      else
      begin

        // ---------------------------------------

        if (eflash_fastread_instruction)
        begin
          read_trigger_next = 1'b1;  
          stb_state_next = STB_FASTREAD_STATE;
        end
        else
        if ((instruction_q == STB_PROG_I) || (instruction_q == STB_BURST_PROG_I))
        begin
          if (eflash_state_current_q == EFLASH_PROG_ACTIVE_STATE)
            set_flag_bit_next = 1'b1;
          else
          begin
            if (eflash_state_current_q == EFLASH_IDLE_STATE)
              program_trigger_next = 1'b1;
          end
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_PROG_CONFIG_CYCLES;
        end
        else
        if (data_tm_config_phase_next)
        begin
		  begin
          stb_state_next = STB_TM_CONFIG_STATE;
          stb_state_timer_next = STB_TM_CONFIG_CYCLES;
		  end
        end
        else
          stb_state_next = STB_IDLE_STATE;

        // ---------------------------------------

      end
    end
    else
      stb_state_next = STB_IDLE_STATE;
  end

  // test mode configuration phase
  STB_TM_CONFIG_STATE:
  begin
    if (stb_active)
    begin
      if (!stb_state_timer_q)
      begin
        if (instruction_q == STB_MARGIN_READ_I)
        begin
          stb_state_next = STB_ADDRESS_STATE;
          address_bit_enable_next = 1'b1;
          first_address_bit_next = 1'b1;
        end
        else
        if ((instruction_q == STB_GANG_PROG_I) || (instruction_q == STB_BURST_GANG_PROG_I))
        begin
          if (eflash_state_current_q == EFLASH_PROG_ACTIVE_STATE)
            set_flag_bit_next = 1'b1;
          else
          begin
            if (eflash_state_current_q == EFLASH_IDLE_STATE)
              program_trigger_next = 1'b1;
          end
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_PROG_CONFIG_CYCLES;
        end
        else
        if ((instruction_q == STB_QUAT_ARRAY_PROG_I) || (instruction_q == STB_EXT_PROG_I) ||
            (instruction_q == STB_SG_STRESS_I) || (instruction_q == STB_BITLINE_STRESS_I) || (instruction_q == STB_QUAT_SECTOR_PROG_I ))
        begin 
          program_trigger_next = 1'b1;
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_PROG_CONFIG_CYCLES;
        end
        else
        if ((instruction_q == STB_EXT_SERASE_I) || (instruction_q == STB_EXT_MERASE_I))
        begin
          erase_trigger_next = 1'b1;
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_ERASE_CONFIG_CYCLES;
        end
        else
        if ((instruction_q == STB_MAIN_CELL_CURRENT_I) || (instruction_q == STB_REF_CELL_CURRENT_I)|| (instruction_q == STB_REF_OPT_I))
        begin
          current_measure_trigger_next = 1'b1;
          stb_state_next = STB_DELAY_STATE;
          stb_state_timer_next = STB_ERASE_CONFIG_CYCLES;
        end
        else
          stb_state_next = STB_IDLE_STATE;
      end
    end
    else
      stb_state_next = STB_IDLE_STATE;
  end
    
  // read state
  STB_READ_STATE:
  begin
    if (stb_active)
    begin
      if (read_cycle_count_q == (read_vector_length - 1'b1))
        read_trigger_next = 1'b1;
    end
    else
      stb_state_next = STB_IDLE_STATE;
  end

  // delay state
  STB_DELAY_STATE:
  begin
      if (!stb_state_timer_q)
        stb_state_next = STB_IDLE_STATE;
  end

  // fast read state
  STB_FASTREAD_STATE:    
  begin
      stb_state_next = STB_FASTREAD_STATE;
  end

  // invalid state. return to idle state and give synthesis tools some flexibility with non state variables
  default:
  begin
    stb_state_next = STB_IDLE_STATE;
    stb_state_timer_next = 'hx;
  end

  endcase

end

//________________________________________________
//
// eflash fsm logic (controls program/erase ops.)
//________________________________________________

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn) 
    eflash_state_current_q <= EFLASH_IDLE_STATE;
  else 
  begin
    if (instruction_q == STB_EXIT_NVSTR_MODE_I)
      eflash_state_current_q <= EFLASH_PROG_POST_DELAY_STATE;
    else if (instruction_q == STB_EXIT_TM_I)
      eflash_state_current_q <= EFLASH_IDLE_STATE;
    else 
      eflash_state_current_q <= eflash_state_next;
  end
end

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    eflash_state_timer_q <= 'h0;
  else if (eflash_state_timer_next)
    eflash_state_timer_q <= eflash_state_timer_next - 'h1;
  else
    eflash_state_timer_q <= 'h0;
end

always @(eflash_state_current_q or eflash_state_timer_q or
         program_trigger_next or instruction_q or erase_trigger_next or current_measure_trigger_next or
         i_eflash_tbit or
         flag_bit_q) 
begin
  // default values
  eflash_state_next = eflash_state_current_q;
  eflash_state_timer_next = eflash_state_timer_q;

  case (eflash_state_current_q)

  // idle state
  EFLASH_IDLE_STATE:
  begin
    if (program_trigger_next)
    begin
      eflash_state_next = EFLASH_PROG_SETUP1_STATE;
    end
    else
    if (erase_trigger_next)
    begin
      eflash_state_next = EFLASH_ERASE_SETUP1_STATE;
    end
    else
    if (current_measure_trigger_next)
    begin
      eflash_state_next = EFLASH_MEASURE_SETUP1_STATE;
    end
  end

  // --------------------------------------------
  
  // program setup state 1
  EFLASH_PROG_SETUP1_STATE:
  begin
    eflash_state_next = EFLASH_PROG_SETUP2_STATE;
  end

  // program setup state 2
  EFLASH_PROG_SETUP2_STATE:
  begin
    eflash_state_next = EFLASH_PROG_ACTIVE_STATE;
  end

  // eflash program active state          
  EFLASH_PROG_ACTIVE_STATE:
  begin
    if (!i_eflash_tbit) // A1 exit command may also be used for external modes
    begin
      eflash_state_next = EFLASH_PROG_POST_DELAY_STATE;
      eflash_state_timer_next = EFLASH_TPRC_CYCLES;
    end
  end



  // eflash program post delay state          
  EFLASH_PROG_POST_DELAY_STATE:
  begin

    // tbit checked at burst gang program (discharge phase)
    // counter checked following any other program command (Tprc phase)

    if (!eflash_state_timer_q && !i_eflash_tbit) 
      eflash_state_next = EFLASH_PROG_BURST_INC_STATE;
  end

  // eflash burst program transition state
  EFLASH_PROG_BURST_INC_STATE:
  begin
    if (flag_bit_q)
      eflash_state_next = EFLASH_PROG_SETUP1_STATE;
    else
    begin
      eflash_state_next = EFLASH_IDLE_STATE;
    end
  end

  // --------------------------------------------
  
  // erase setup state 1
  EFLASH_ERASE_SETUP1_STATE:
  begin
    eflash_state_next = EFLASH_ERASE_SETUP2_STATE;
  end

  // erase setup state 2
  EFLASH_ERASE_SETUP2_STATE:
  begin
    eflash_state_next = EFLASH_ERASE_ACTIVE_STATE;
  end
  
  // eflash erase active state          
  EFLASH_ERASE_ACTIVE_STATE:
  begin
    if (!i_eflash_tbit) // A1 exit command may also be used for external modes
    begin
      eflash_state_next = EFLASH_ERASE_TPRC_STATE;
      eflash_state_timer_next = EFLASH_TPRC_CYCLES;
    end
  end
  
  // eflash erase tPRC state          
  EFLASH_ERASE_TPRC_STATE:
  begin
    if (!eflash_state_timer_q)
      eflash_state_next = EFLASH_IDLE_STATE;
  end

  // --------------------------------------------
  
  // current measure setup state 1
  EFLASH_MEASURE_SETUP1_STATE:
  begin
    eflash_state_next = EFLASH_MEASURE_ACTIVE_STATE;
  end

  // eflash measure active state          
  EFLASH_MEASURE_ACTIVE_STATE:
  begin
    eflash_state_next = EFLASH_MEASURE_ACTIVE_STATE; // A1 or A2 exit commands should be used to exit this mode
  end
  
  // --------------------------------------------
  
  // invalid state. return to idle state and give synthesis tools some flexibility with non state variables
  default:
  begin
    eflash_state_next = EFLASH_IDLE_STATE;
    eflash_state_timer_next = 'hx;
  end

  endcase
end

// Program setup states ////////////////////
//
// DIN         XXXXXXX|=============|XXXXXXX
//
// PROG        _______|-------------|_______
//
// PRE_AE      _______|------|______________
// 
// AE          ______________|------|_______
//
// NVSTR       _____________________|-------
//
// PROG_STATE  | IDLE | SET1 | SET2 | ACTV |


// Erase setup states /////////////////////
//
// SERA/MASE   _______|-------------|_______
//
// PRE_AE      _______|------|______________
// 
// AE          ______________|------|_______
//
// NVSTR       _____________________|-------
//
// PROG_STATE  | IDLE | SET1 | SET2 | ACTV |

//________________________________________________
//
// controls signals to the flash based on state
//________________________________________________

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_PROG_SETUP1_STATE)
  begin
    eflash_din_q <= pre_data_in_q[EFLASH_DATA_BITS-1:0];
    eflash_pre_ae_q <= 1'b1;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b1;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_PROG_SETUP2_STATE)
  begin
    eflash_din_q <= pre_data_in_q[EFLASH_DATA_BITS-1:0];
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b1;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_PROG_ACTIVE_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b1;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_PROG_POST_DELAY_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_PROG_BURST_INC_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_ERASE_SETUP1_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b1;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    if ((instruction_q == STB_SERASE_I) || (instruction_q == STB_EXT_SERASE_I))
      eflash_sera_q <= 1'b1;
    else
      eflash_sera_q <= 1'b0;
    if ((instruction_q == STB_MERASE_I) || (instruction_q == STB_EXT_MERASE_I))
      eflash_mase_q <= 1'b1;
    else
      eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_ERASE_SETUP2_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    if ((instruction_q == STB_SERASE_I) || (instruction_q == STB_EXT_SERASE_I))
      eflash_sera_q <= 1'b1;
    else
      eflash_sera_q <= 1'b0;
    if ((instruction_q == STB_MERASE_I) || (instruction_q == STB_EXT_MERASE_I))
      eflash_mase_q <= 1'b1;
    else
      eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_ERASE_ACTIVE_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b1;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_ERASE_TPRC_STATE)
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_MEASURE_SETUP1_STATE)
  begin
    eflash_din_q <= pre_data_in_q[EFLASH_DATA_BITS-1:0];
    eflash_pre_ae_q <= 1'b1;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (eflash_state_next == EFLASH_MEASURE_ACTIVE_STATE)
  begin
    if (i_stb_pad_data_in)
      eflash_din_q <= pre_data_in_q[EFLASH_DATA_BITS-1:0];
    eflash_pre_ae_q <= 1'b0; 
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
  else if (tm_code_phase_next_q)
  begin
    eflash_din_q <= pre_data_in_q[EFLASH_DATA_BITS-1:0];
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= tm_config_code[3];
    eflash_prog_q <= tm_config_code[2];
    eflash_sera_q <= tm_config_code[1];
    eflash_mase_q <= tm_config_code[0];
  end
  else
  begin
    eflash_din_q <= {EFLASH_DATA_BITS{1'h0}};
    eflash_pre_ae_q <= 1'b0;
    eflash_nvstr_q <= 1'b0;
    eflash_prog_q <= 1'b0;
    eflash_sera_q <= 1'b0;
    eflash_mase_q <= 1'b0;
  end
end

//________________________________________________

assign  clr_flag_bit_next = (eflash_state_next == EFLASH_IDLE_STATE) || 
//                            (eflash_state_current_q == EFLASH_PROG_BURST_INC_STATE);
                            (eflash_state_current_q == EFLASH_PROG_SETUP2_STATE);

always @(posedge stb_clk or negedge stb_arstn)
begin
  if (!stb_arstn)
    flag_bit_q <= 1'b0;
  else
  begin
    if (clr_flag_bit_next)
      flag_bit_q <= 1'b0;
    else
    if (set_flag_bit_next)
      flag_bit_q <= 1'b1;
  end
end

//______________________________________________________________________________
//
// Reset generation
//______________________________________________________________________________

assign porstn = !i_eflash_porst;
assign stb_arstn = !(i_eflash_porst || (!(SMTEN || stb_soft_smten_q)));

always @(posedge stb_inv_clk or negedge porstn)
begin
  if (!porstn)
    stb_soft_smten_q <= 1'b0;
  else
  begin
    if (stb_test_pass_phrase == STB_TEST_AMTEN)
      stb_soft_smten_q <= 1'b1;
  end
end

assign  eflash_to_stb_mux =       stb_soft_smten_q || SMTEN;

//______________________________________________________________________________
//
// Clock generation
//______________________________________________________________________________

clk_buf_cell stb_clk_buf (
    .out     (stb_clk), //stb_pad_clk_buf),
    .in      (SCLK) //i_stb_pad_clk)
);

//assign stb_clk = stb_pad_clk_buf;

assign stb_inv_clk = ~stb_clk;


endmodule


//______________________________________________________________________________
//
// Clock buffer
//______________________________________________________________________________

module clk_buf_cell (out, in);
input  in;
output out;

// synopsys dc_script_begin
// set_dont_touch find (cell, clk_buf)
// synopsys dc_script_end

// synthesis by library
//BUF8CK    clk_buf (.A (in), .Z (out));  // Gate level clock driver
// simulation by EDA tool
  assign  out = in;  // Gate level clock driver

endmodule

//module PAD_Z (I, OEN, PAD, O);
//    input I, OEN;
//    inout PAD;
//    output O;
//
//    bufif0	(PAD, I, OEN);
//    buf		(O, PAD);
//
//endmodule
//______________________________________________________________________________


module FULLCHIP_STB(ADDR, DIN, DOUT, ADDR_1, 
                CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE, TBIT, 	 
                PORST, BYTE, FASTP, BUSY, 
                VDD, VSS, TME, TMR, 
                VPP, VNN, RESETB);

    input [(`BIT_ADDR-1):0] ADDR;
    input CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE, PORST, ADDR_1, RESETB, FASTP;
    input [(`BIT_DATA-1):0] DIN;
    output [(`BIT_DATA-1):0] DOUT;
    output TBIT, BUSY;
    input  BYTE;

    inout VDD, VSS;

    input TME, TMR;
    input VPP, VNN;

    supply0 VSS, vss;
    supply1 VDD, Vdd;
   
    wire prog_latch, sera_latch, mase_latch;
    wire wrong_timing;
	wire ae_delay;

    wire gangpgm;

    wire [(`BIT_DATA-1):0] din; 
    wire [(`BIT_DATA-1):0] dout; 

  //IO buffer
  wire [(`BIT_ADDR-1):0] ADDR_int;
  wire [(`BIT_DATA-1):0] DIN_buf;
  wire CS_buf, AE_buf, OE_buf, IFREN_buf, NVSTR_buf, PROG_buf, SERA_buf, MASE_buf, ADDR_1_buf;	
  wire [19:0] AllCS;
//  wire BYTE;		

  buf (CS_buf , CS );
  buf (IFREN_buf , IFREN );
  assign  AllCS = {CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS,CS};
  assign  ADDR_int[(`BIT_ADDR-1):0] = ADDR[(`BIT_ADDR-1):0] & AllCS[(`BIT_ADDR-1):0];
  assign  ADDR_1_buf  = ADDR_1 & CS;
  assign  DIN_buf[(`BIT_DATA-1):0] = DIN[(`BIT_DATA-1):0];
  assign  AE_buf     = AE & CS;
  assign  OE_buf     = OE & CS;
  assign  NVSTR_buf  = NVSTR & CS;
  assign  PROG_buf   = PROG & CS;
  assign  SERA_buf   = SERA & CS;
  assign  MASE_buf   = MASE & CS;
  assign  TME_buf    = TME & CS;
  assign  TMR_buf    = TMR & CS;
  
   //--------------------------------------------
   // Map 
   //--------------------------------------------
  pf64ak32ei40_core pf64ak32ei40_core(
                  .porst            (PORST),
                  .cs               (CS_buf),
                  .oe               (OE_buf),
                  .ae               (AE_buf),
                  .ifren            (IFREN_buf),
                  .nvstr            (NVSTR_buf),
                  .prog             (PROG_buf),
                  .sera             (SERA_buf),
                  .mase             (MASE_buf),
                  .fastp            (FASTP),
                  .busy             (BUSY),
                  .tbit             (TBIT),
                  .byte_1           (BYTE),
                  .prog_latch       (prog_latch),
                  .sera_latch       (sera_latch),
                  .mase_latch       (mase_latch),
                  .outen            (outen),
                  .addr             (ADDR_int),
                  .addr_1           (ADDR_1_buf),
                  .din              (DIN_buf),
                  .dout             (DOUT),
                  .oscen            (1'b0),
                  .osc              (osc),
                  .tmr              (TMR_buf),
                  .tme              (TME_buf),
                  .wrong_timing     (wrong_timing),	
                  .ae_delay         (ae_delay),
                  .gangpgm          (gangpgm),
                  .sg_stress        (sg_stress),
                  .bl_stress        (bl_stress),
                  .extpe            (extpe),
                  .quad_pgm         (quad_pgm)
                  );


  acdc_check_pf64ak32ei40  acdc_check_pf64ak32ei40(
                            .prog         (PROG_buf),
                            .mase         (MASE_buf),
                            .sera         (SERA_buf),
                            .cs           (CS_buf),
                            .ae           (AE_buf),
                            .oe           (OE_buf),
                            .nvstr        (NVSTR_buf),
                            .ifren        (IFREN_buf),
                            .fastp        (FASTP_buf),
                            .busy         (BUSY),
                            .tbit         (TBIT),
                            .tmr          (TMR_buf),
                            .tme          (TME_buf),
                            .prog_latch   (prog_latch),
                            .sera_latch   (sera_latch),
                            .mase_latch   (mase_latch),
                            .addr         (ADDR_int),
                            .din          (DIN_buf),
                            .wrong_timing (wrong_timing),
                            .ae_delay     (ae_delay),
							.resetb		  (RESETB)
                            );

  testmode_pf64ak32ei40  testmode_pf64ak32ei40(
                            .addr         (ADDR_int),
                            .din          (DIN_buf),
                            .cs           (CS_buf),
                            .oe           (OE_buf),
                            .prog         (PROG_buf),
                            .mase         (MASE_buf),
                            .sera         (SERA_buf),
                            .nvstr        (NVSTR_buf),
                            .tme          (TME_buf),
                            .tmr          (TMR_buf),
                            .vpp          (1'b1),
                            .vnn          (1'b0),
                            .gangpgm      (gangpgm),
                            .sg_stress    (sg_stress),
                            .bl_stress    (bl_stress),
                            .extpe        (extpe),
                            .quad_pgm     (quad_pgm)
                            );


  endmodule

  
/************************************************/
/*                                              */
/*  VERILOG MODEL FOR PF64AK32Ei40 FLASH MEMORY */
/*                                              */
/*      Chingis Technology  Corp.               */
/*   1350 Ridder Park Dr., San Jose, CA 95131   */
/*   Phone: (408)452-1888  Fax: (408)452-1989   */
/*                                              */
/*                                              */
/*   Creation Date: 03-08-2003                  */
/*                                              */
/*   Verified With: Cadence Verilog-XL          */
/*                                              */
/*   Date     : 1/22/2019                       */                                     
/*   Version  : v0.4.3                          */
/*                                              */
/*  Version history:                            */
/*  V0_0: add TME logic                         */
/*        add test mode flag                    */
/*        update program/erase CSM state table  */
/*        update test mode timing check         */

/*        update gangpgm with 'data_temp'       */
/*        update Tprc behavior in test mode     */
/*        update Tbit behavior in test mode     */
/*        add quad program operation            */
/*        update NVSTR-Tbit discharge time      */
/*        update CSM-NVSTR negedge trigger      */
/*        move xx_mode wire definition line     */
/*        add pst7 posedge                      */
/*        add Tael timing check                 */
/*                                              */
/*        remove Tprc timing                    */
/*        remove useless address out warning    */
/*        info_bit_addr in sector erase         */
/*        info size changed from 128 to 512     */
/*        info bit address adjust accordingly   */
/*        update behavior if tbit=1             */
/*        Ttr = 100ns, NSTR -> TBIT rising edge */
/*          read_mode=0 dout=xxxx               */
/*        Dout for 5ns if 2nd AE rising & oe=1  */
/*        oe_outen behavior update              */
/*        Update PORSTB                         */
/*        Update SPI read status register       */
/*        Remove 'Hi-Z' output                  */
/*        Tac=Taad=40ns                         */
/*        Info array is divided into 4 pages    */
/*        Update Tcs = 2ns instead of 5ns       */
/*        Update Ts/Th = 2/5ns instead of 5/2ns */
/*        Update Tser  = 1ms                    */
/*        Update Ouf of range warning           */
/*        Update Tser  = 2ms                    */
/*        line 3334 error fix 3'b11 to 2'b11    */
/*        Fix with sector erase decode '-1'     */
/*        Update STB with read dummy 32-clk     */
/*        add addr_1 latch                      */
/*  V0_0: Original release                      */
/*  V0_1: OE block program/erase                */
/*  V0_2: Add Trv                               */ 
/*        read operation                        */ 
/*  V0.4.1: Update tH, remove tHZ               */	
/*  V0.4.2: Update tAS/tAH timing check         */
/*  V0.4.3: ae behavior update 	                */
/*   							                       				*/
/*  initialisation of memory array using either */
/*  one of the following method                 */
/* 1. initialize memory with specified data file*/ 
/* 2. using initial statement to set array      */
/************************************************/
module PF64AK32EI40_MODEL(ADDR, DIN, DOUT,
                CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE, TBIT, 
                ADDR_1, WORD,
                RESETB, 
                VDD, VSS, VPP, VNN,
                SMTEN, SCE, SCLK, SIO_OEN, SIO_O, SIO_I );

// macro size definitions
parameter EFLASH_ADDR_BITS =             'd14;
parameter EFLASH_DATA_BITS =             'd32;

    input [(`BIT_ADDR-1):0] ADDR;
    input CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE; 
    input ADDR_1, WORD;
    input RESETB;
    input [(`BIT_DATA-1):0] DIN;
    output [(`BIT_DATA-1):0] DOUT;
    output TBIT;

    inout VDD, VSS;
    input VPP, VNN;

// stb pads
    input                           SCLK;      // stb clock
    input                           SCE;       // stb chip select (active low)
    input                           SMTEN;     // stb macro test enable
//inout                           SIO;       // stb macro bi-direction IO
    input                           SIO_I;  
    output                          SIO_O;  
    output                          SIO_OEN;  //active low, when low, enable output from sio_o to PAD

    wire PORST, WORD;
    //wire [(EFLASH_DATA_BITS-`BIT_DATA-1):0] dummy_dout;

// eflash interface to IP macro
    wire                           i_eflash_porst;        // eflash power on reset, active high
    wire                           i_eflash_byte;         // eflash x8 / x16 mode option, 1: x8; 0: x16
    wire                           o_eflash_addrz;        // eflash x8 mode lowest address
						    
    wire                           o_eflash_ifren;       // eflash information block enable
    wire [EFLASH_ADDR_BITS-1:0]    o_eflash_addr;        // eflash address bus
    wire [EFLASH_DATA_BITS-1:0]    o_eflash_din;         // eflash     wiredata
    wire                           o_eflash_cs;          // eflash macro select
    wire                           o_eflash_ae;          // eflash address enable
    wire                           o_eflash_oe;          // eflash     wire enable
    wire                           o_eflash_nvstr;       // eflash non-volatile store signal
    wire                           o_eflash_prog;        // eflash program control signal
    wire                           o_eflash_sera;        // eflash page erase control signal
    wire                           o_eflash_mase;        // eflash mass erase control signal
    wire                           o_eflash_tme;         // eflash test mode enable
    wire                           o_eflash_tmr;         // eflash test mode signal
    wire  [EFLASH_DATA_BITS-1:0]   i_eflash_dout;        // eflash     wire  data
    wire                           i_eflash_tbit;        // eflash indicator of program/erase completion

    reg  porst_int;
    wire porst;

    //reg PORST; reset state machine when PORST=1.
    initial begin
       porst_int=1'b0;
       #5;
       porst_int=1'b1;
       #5;
       porst_int=1'b0;
    end

    assign  porst = porst_int  || (!RESETB);

eflash_stb_top eflash_stb_top (

    // stb pads
    .SCLK                      (SCLK),
    .SMTEN                     (SMTEN),
    .SCE                       (SCE),
//    .SIO                       (SIO),
    .SIO_I                     (SIO_I),
    .SIO_O                     (SIO_O),
    .SIO_OEN                   (SIO_OEN),

    // eflash interface
    .i_eflash_porst            (porst),
    .i_eflash_byte             (1'b0),
    .o_eflash_addrz            (o_eflash_addrz),

    // eflash interface
    .o_eflash_ifren            (o_eflash_ifren),
    .o_eflash_addr             (o_eflash_addr),
    .o_eflash_din              (o_eflash_din),
    .o_eflash_cs               (o_eflash_cs),
    .o_eflash_ae               (o_eflash_ae),
    .o_eflash_oe               (o_eflash_oe),
    .o_eflash_nvstr            (o_eflash_nvstr),
    .o_eflash_prog             (o_eflash_prog),
    .o_eflash_sera             (o_eflash_sera),
    .o_eflash_mase             (o_eflash_mase),
    .o_eflash_tme              (o_eflash_tme),
    .o_eflash_tmr              (o_eflash_tmr), 
//    .i_eflash_dout             (i_eflash_dout),
    .i_eflash_dout             (i_eflash_dout),
    .i_eflash_tbit             (i_eflash_tbit),

    // eflash interface from asic
    .IFREN                     (IFREN), 
    .ADDR                      ({`DIF_ADDR_BITS'b0, ADDR}),  
    .DIN                       (DIN),   
    .CS                        (CS),   
    .AE                        (AE),   
    .OE                        (OE),   
    .NVSTR                     (NVSTR),   
    .PROG                      (PROG),   
    .SERA                      (SERA),   
    .MASE                      (MASE),   
    .TME                       (1'b0),   
    .TMR                       (1'b0),   
    .DOUT                      (DOUT),   
    .TBIT                      (TBIT)

);

  FULLCHIP_STB FULLCHIP_STB(
                  .CS               (o_eflash_cs),
                  .OE               (o_eflash_oe), 
                  .RESETB           (RESETB), 
                  .AE               (o_eflash_ae),
                  .IFREN            (o_eflash_ifren),
                  .NVSTR            (o_eflash_nvstr),
                  .PROG             (o_eflash_prog),
                  .SERA             (o_eflash_sera),
                  .MASE             (o_eflash_mase),
                  .TBIT             (i_eflash_tbit),
                  .ADDR             (o_eflash_addr[`BIT_ADDR-1:0]),
                  .ADDR_1           (ADDR_1),  
                  .DIN              (o_eflash_din[`BIT_DATA-1:0]),
                  .DOUT             (i_eflash_dout[`BIT_DATA-1:0]),
                  .PORST            (porst),
                  .BYTE             (WORD),
                  .FASTP            (1'b0),
                  .BUSY             (BUSY),
                  .VPP              (),
                  .VNN              (),
                  .VDD              (),
                  .VSS              (),
                  .TME              (o_eflash_tme),
                  .TMR              (o_eflash_tmr)
                  );


endmodule
  
