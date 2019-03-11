/*******************************************************************************
________________________________________________________________________________________________


             Synchronous Pcode(Implant) ROM Compiler 

                   UMC 0.11um EEPROM AL Process 

________________________________________________________________________________________________

              
        Copyright (C) 2019 Faraday Technology Corporation. All Rights Reserved.       
               
        This source code is an unpublished work belongs to Faraday Technology Corporation       
        It is considered a trade secret and is not to be divulged or       
        used by parties who have not received written authorization from       
        Faraday Technology Corporation       
               
        Faraday's home page can be found at: http://www.faraday-tech.com/       
               
________________________________________________________________________________________________

       IP Name            :  FSR0A_A_SK                                
       IP Version         :  0.3.0                                     
       IP Release Status  :  Active                                    
       Word               :  512                                       
       Bit                :  32                                        
       Mux                :  1                                         
       Rom Code Version   :  A                                         
       Rom Code Format    :  hex                                       
       Rom Code File      :  /NIS_home/fei.liu/memlib/boot_rom_dat.sv  
       Output Loading     :  0.01                                      
       Clock Input Slew   :  0.016                                     
       Data Input Slew    :  0.016                                     
       Ring Type          :  Ringless Model                            
       Ring Width         :  0                                         
       Bus Format         :  0                                         
       Memaker Path       :  /NIS_home/fei.liu/memlib                  
       GUI Version        :  m20130120                                 
       Date               :  2019/02/21 14:15:36                       
________________________________________________________________________________________________


   Notice on usage: Fixed delay or timing data are given in this model.
                    It supports SDF back-annotation, please generate SDF file
                    by EDA tools to get the accurate timing.

 |-----------------------------------------------------------------------------|

   Warning : If customer's design viloate the set-up time or hold time criteria 
   of synchronous SRAM, it's possible to hit the meta-stable point of 
   latch circuit in the decoder and cause the data loss in the memory bitcell.
   So please follow the memory IP's spec to design your product.

 *******************************************************************************/

`resetall
`timescale 10ps/1ps


module SKAA110_512X32BM1A (A0,A1,A2,A3,A4,A5,A6,A7,A8,DO0,DO1,DO2,DO3,DO4,
                           DO5,DO6,DO7,DO8,DO9,DO10,DO11,DO12,DO13,DO14,
                           DO15,DO16,DO17,DO18,DO19,DO20,DO21,DO22,
                           DO23,DO24,DO25,DO26,DO27,DO28,DO29,DO30,
                           DO31,DVSE,DVS3,DVS2,DVS1,DVS0,VCC, GND, CK,CS,OE);
  `define    TRUE                 (1'b1)              
  `define    FALSE                (1'b0)              

  parameter  SYN_CS               = `TRUE;            
  parameter  NO_SER_TOH           = `FALSE;           
  parameter  ROMCODE              = "/home/share/soc/flow/memlib/prom_512x32/boot_rom_dat.sv";
  parameter  DVSize               = 4;                
  parameter  AddressSize          = 9;                
  parameter  Bits                 = 32;               
  parameter  Words                = 512;              
  parameter  AspectRatio          = 1;                
  parameter  TOH                  = (80.7:129.1:232.0);

  output     DO0,DO1,DO2,DO3,DO4,DO5,DO6,DO7,DO8,
             DO9,DO10,DO11,DO12,DO13,DO14,DO15,DO16,DO17,DO18,
             DO19,DO20,DO21,DO22,DO23,DO24,DO25,DO26,DO27,DO28,
             DO29,DO30,DO31;
  input      A0,A1,A2,A3,A4,A5,A6,A7,A8;
  input      DVSE;                                    
  input      DVS0,DVS1,DVS2,DVS3;
  input      OE;                                      
  input      CK;                                      
  input      CS;                                      
  input      VCC;                                     
  input      GND;                                     
`ifndef SYNTHESIS

`protect
  reg        [Bits-1:0]           Memory [Words-1:0];           

  wire       [Bits-1:0]           DO_;                
  wire       [AddressSize-1:0]    A_;                 
  wire                            OE_;                
  wire                            CK_;                
  wire                            CS_;                


  wire                            VCC_;               
  wire                            GND_;               



  wire                            con_A;              
  wire                            con_CK;             

  reg        [AddressSize-1:0]    Latch_A;            
  reg                             Latch_CS;           

  reg        [AddressSize-1:0]    A_i;                
  reg                             CS_i;               


  reg                             n_flag_A0;          
  reg                             n_flag_A1;          
  reg                             n_flag_A2;          
  reg                             n_flag_A3;          
  reg                             n_flag_A4;          
  reg                             n_flag_A5;          
  reg                             n_flag_A6;          
  reg                             n_flag_A7;          
  reg                             n_flag_A8;          
  reg                             n_flag_CS;          
  reg                             n_flag_CK_PER;      
  reg                             n_flag_CK_MINH;     
  reg                             n_flag_CK_MINL;     
  reg                             LAST_n_flag_CS;     
  reg                             LAST_n_flag_CK_PER; 
  reg                             LAST_n_flag_CK_MINH;
  reg                             LAST_n_flag_CK_MINL;
  reg        [AddressSize-1:0]    NOT_BUS_A;          
  reg        [AddressSize-1:0]    LAST_NOT_BUS_A;     


  reg        [AddressSize-1:0]    last_A;             
  reg        [AddressSize-1:0]    latch_last_A;       

  reg        [Bits-1:0]           DO_i;               

  reg        [Bits-1:0]           DO_VCC_i;           
  reg        [Bits-1:0]           DO_GND_i;           

  reg                             LastClkEdge;        

  reg                             flag_A_x;           
  reg                             flag_CS_x;          
  reg                             NODELAY;            
  reg        [Bits-1:0]           DO_tmp;             
  event                           EventTOHDO;         
  event                           EventNegCS;         
`ifdef MEM_VERIFY
  reg                             taa_verify;         
`else
`endif
`ifdef power_function
  assign     DO_                  = GND ? DO_GND_i : (VCC ? DO_i : DO_VCC_i);  
`else
  assign     DO_                  = {DO_i};
`endif
  assign     con_A                = CS_;
  assign     con_CK               = CS_;
  bufif1     ido0            (DO0, DO_[0], OE_);           
  bufif1     ido1            (DO1, DO_[1], OE_);           
  bufif1     ido2            (DO2, DO_[2], OE_);           
  bufif1     ido3            (DO3, DO_[3], OE_);           
  bufif1     ido4            (DO4, DO_[4], OE_);           
  bufif1     ido5            (DO5, DO_[5], OE_);           
  bufif1     ido6            (DO6, DO_[6], OE_);           
  bufif1     ido7            (DO7, DO_[7], OE_);           
  bufif1     ido8            (DO8, DO_[8], OE_);           
  bufif1     ido9            (DO9, DO_[9], OE_);           
  bufif1     ido10           (DO10, DO_[10], OE_);         
  bufif1     ido11           (DO11, DO_[11], OE_);         
  bufif1     ido12           (DO12, DO_[12], OE_);         
  bufif1     ido13           (DO13, DO_[13], OE_);         
  bufif1     ido14           (DO14, DO_[14], OE_);         
  bufif1     ido15           (DO15, DO_[15], OE_);         
  bufif1     ido16           (DO16, DO_[16], OE_);         
  bufif1     ido17           (DO17, DO_[17], OE_);         
  bufif1     ido18           (DO18, DO_[18], OE_);         
  bufif1     ido19           (DO19, DO_[19], OE_);         
  bufif1     ido20           (DO20, DO_[20], OE_);         
  bufif1     ido21           (DO21, DO_[21], OE_);         
  bufif1     ido22           (DO22, DO_[22], OE_);         
  bufif1     ido23           (DO23, DO_[23], OE_);         
  bufif1     ido24           (DO24, DO_[24], OE_);         
  bufif1     ido25           (DO25, DO_[25], OE_);         
  bufif1     ido26           (DO26, DO_[26], OE_);         
  bufif1     ido27           (DO27, DO_[27], OE_);         
  bufif1     ido28           (DO28, DO_[28], OE_);         
  bufif1     ido29           (DO29, DO_[29], OE_);         
  bufif1     ido30           (DO30, DO_[30], OE_);         
  bufif1     ido31           (DO31, DO_[31], OE_);         
  buf        ick0            (CK_, CK);                    
  buf        ia0             (A_[0], A0);                  
  buf        ia1             (A_[1], A1);                  
  buf        ia2             (A_[2], A2);                  
  buf        ia3             (A_[3], A3);                  
  buf        ia4             (A_[4], A4);                  
  buf        ia5             (A_[5], A5);                  
  buf        ia6             (A_[6], A6);                  
  buf        ia7             (A_[7], A7);                  
  buf        ia8             (A_[8], A8);                  
  buf        ics0            (CS_, CS);                    
  buf        ioe0            (OE_, OE);                    

  buf        ivcc0           (VCC_, VCC);                  
  buf        ignd0           (GND_, GND);                  


  initial begin
    $timeformat (-12, 0, " ps", 20);
    flag_A_x = `FALSE;
    NODELAY = 1'b0;
    LastClkEdge = 1'b0;
  `ifdef MEM_VERIFY
    taa_verify = 0;
  `else
  `endif
  end

  initial
    begin
      if (ROMCODE != "")
        begin
          $readmemh(ROMCODE,Memory);
        end
      else
        begin
          $display("** MEM_Error: No proper input file name is available.\n");
          $finish;
        end
    end

  always @(negedge CS_) begin
    if (SYN_CS == `FALSE) begin
       ->EventNegCS;
    end
  end
  always @(posedge CS_) begin
    if (SYN_CS == `FALSE) begin
       disable NegCS;
    end
  end


`ifdef power_function
  always @(negedge GND_) begin
    if (GND_ === 1'bx) begin
       pin_unknow;
`ifdef NO_MEM_MSG
`else
       ErrorMessage(7);
`endif
    end else begin
        latch_last_A = 1'bx;
        DO_i = DO_GND_i;
    end
  end

  always @(posedge VCC_) begin
    if (VCC_ === 1'bx) begin
       pin_unknow;
`ifdef NO_MEM_MSG
`else
       ErrorMessage(7);
`endif
    end else begin
        latch_last_A = 1'bx;
        DO_i = DO_VCC_i;
    end
  end

  always @(posedge GND_) begin
    if (GND_ === 1'bx) begin
       pin_unknow;
`ifdef NO_MEM_MSG
`else
       ErrorMessage(7);
`endif
    end else begin
       disable TOHDO;
       NODELAY = 1'b1;
       DO_GND_i = {Bits{1'bX}};
    end
  end


  always @(negedge VCC_) begin
    if (VCC_ === 1'bx) begin
       pin_unknow;
`ifdef NO_MEM_MSG
`else
       ErrorMessage(7);
`endif
    end
    else if (VCC_ === 1'b0) begin
       disable TOHDO;
       NODELAY = 1'b1;
       DO_VCC_i = {Bits{1'bX}};
    end
  end
`else
`endif

  always @(CK_) begin
    casez ({LastClkEdge,CK_})
      2'b01:
`ifdef power_function
        if (VCC_=== 1'bx || GND_ === 1'bx) begin
          pin_unknow;
`ifdef NO_MEM_MSG
`else
          ErrorMessage(7);
`endif
        end else if (VCC_ === 1'b0 || GND_ === 1'b1) begin
          pin_unknow;
        end else begin
           last_A = latch_last_A;
           CS_monitor;
           pre_latch_data;
           memory_function;
           latch_last_A = A_;
        end
`else
         begin
           last_A = latch_last_A;
           CS_monitor;
           pre_latch_data;
           memory_function;
           latch_last_A = A_;
         end
`endif
      2'b?x:
         begin
           ErrorMessage(0);
           #0 disable TOHDO;
           DO_i = {Bits{1'bX}};
         end
    endcase
    LastClkEdge = CK_;
  end

  always @(
           n_flag_A0 or
           n_flag_A1 or
           n_flag_A2 or
           n_flag_A3 or
           n_flag_A4 or
           n_flag_A5 or
           n_flag_A6 or
           n_flag_A7 or
           n_flag_A8 or
           n_flag_CS or
           n_flag_CK_PER or
           n_flag_CK_MINH or
           n_flag_CK_MINL
          )
     begin
       timingcheck_violation;
     end


  always @(EventTOHDO)
    begin:TOHDO
      #TOH
      NODELAY <= 1'b0;
      DO_i              =  {Bits{1'bX}};
      DO_i              <= DO_tmp;
  end

  always @(EventNegCS)
    begin:NegCS
      #TOH
      disable TOHDO;
      NODELAY = 1'b0;
      DO_i              =  {Bits{1'bX}};
  end


  task timingcheck_violation;
    integer i;
    begin
      if ((n_flag_CK_PER  !== LAST_n_flag_CK_PER)  ||
          (n_flag_CK_MINH !== LAST_n_flag_CK_MINH) ||
          (n_flag_CK_MINL !== LAST_n_flag_CK_MINL)) begin
          if (CS_ !== 1'b0) begin
             #0 disable TOHDO;
             NODELAY = 1'b1;
             DO_i = {Bits{1'bX}};
          end
      end
      else begin
          NOT_BUS_A  = {
                         n_flag_A8,
                         n_flag_A7,
                         n_flag_A6,
                         n_flag_A5,
                         n_flag_A4,
                         n_flag_A3,
                         n_flag_A2,
                         n_flag_A1,
                         n_flag_A0};

          for (i=0; i<AddressSize; i=i+1) begin
             Latch_A[i] = (NOT_BUS_A[i] !== LAST_NOT_BUS_A[i]) ? 1'bx : Latch_A[i];
          end
          Latch_CS  =  (n_flag_CS  !== LAST_n_flag_CS)  ? 1'bx : Latch_CS;
          memory_function;
      end

      LAST_NOT_BUS_A                 = NOT_BUS_A;
      LAST_n_flag_CS                 = n_flag_CS;
      LAST_n_flag_CK_PER             = n_flag_CK_PER;
      LAST_n_flag_CK_MINH            = n_flag_CK_MINH;
      LAST_n_flag_CK_MINL            = n_flag_CK_MINL;
    end
  endtask // end timingcheck_violation;

  task pre_latch_data;
    begin
      Latch_A                        = A_;
      Latch_CS                       = CS_;
    end
  endtask //end pre_latch_data
  task memory_function;
    begin
      A_i                            = Latch_A;
      CS_i                           = Latch_CS;

      if (CS_ == 1'b1) A_monitor;

      casez(CS_i)
        1'b1: begin
           if (AddressRangeCheck(A_i)) begin
              if (NO_SER_TOH == `TRUE) begin
                if (A_i !== last_A) begin
                   NODELAY = 1'b1;
                   DO_tmp = Memory[A_i];
                   ->EventTOHDO;
                `ifdef MEM_VERIFY
		   taa_verify = 0;
                `else
                `endif   
                end else begin
                   NODELAY = 1'b0;
                   DO_tmp  = Memory[A_i];
                   DO_i    = DO_tmp;
                `ifdef MEM_VERIFY
		   taa_verify = 1;
                `else
                `endif
                end
              end else begin
                NODELAY = 1'b1;
                DO_tmp = Memory[A_i];
                ->EventTOHDO;
             `ifdef MEM_VERIFY
		taa_verify = 0;
             `else
             `endif
              end
           end
           else begin
                #0 disable TOHDO;
                NODELAY = 1'b1;
                DO_i = {Bits{1'bX}};
             `ifdef MEM_VERIFY
		taa_verify = 0;
             `else
             `endif
           end
        end
        1'bx: begin
           #0 disable TOHDO;
           NODELAY = 1'b1;
           DO_i = {Bits{1'bX}};
        end
      endcase
  end
  endtask //memory_function;

  task pin_unknow;
     begin
      #0 disable TOHDO;
      NODELAY = 1'b1;
      DO_tmp = {Bits{1'bX}};
      DO_i    = DO_tmp;
     end
  endtask


  task A_monitor;
     begin
       if (^(A_) !== 1'bX) begin
          flag_A_x = `FALSE;
       end
       else begin
          if (flag_A_x == `FALSE) begin
              flag_A_x = `TRUE;
              ErrorMessage(2);
          end
       end
     end
  endtask //end A_monitor;

  task CS_monitor;
     begin
       if (^(CS_) !== 1'bX) begin
          flag_CS_x = `FALSE;
       end
       else begin
          if (flag_CS_x == `FALSE) begin
              flag_CS_x = `TRUE;
              ErrorMessage(3);
          end
       end
     end
  endtask //end CS_monitor;

  task ErrorMessage;
     input error_type;
     integer error_type;

     begin
       case (error_type)
         0: $display("** MEM_Error: Abnormal transition occurred (%t) in Clock of %m",$time);
         1: $display("** MEM_Error: Read and Write the same Address, DO is unknown (%t) in clock of %m",$time);
         2: $display("** MEM_Error: Unknown value occurred (%t) in Address of %m",$time);
         3: $display("** MEM_Error: Unknown value occurred (%t) in ChipSelect of %m",$time);
         4: $display("** MEM_Error: Port A and B write the same Address, core is unknown (%t) in clock of %m",$time);
         5: $display("** MEM_Error: Clear all memory core to unknown (%t) in clock of %m",$time);
         7: $display("** MEM_Error: VCC or GND are unknown, so DO is unknown, all memory core is unknown %m",$time);
       endcase
     end
  endtask

  function AddressRangeCheck;
      input  [AddressSize-1:0] AddressItem;
      reg    UnaryResult;
      begin
        UnaryResult = ^AddressItem;
        if(UnaryResult!==1'bX) begin
           if (AddressItem >= Words) begin
              $display("** MEM_Error: Out of range occurred (%t) in Address of %m",$time);
              AddressRangeCheck = `FALSE;
           end else begin
              AddressRangeCheck = `TRUE;
           end
        end
        else begin
           AddressRangeCheck = `FALSE;
        end
      end
  endfunction //end AddressRangeCheck;

   specify
      specparam TAA    = (119.6:191.9:350.5);
      specparam TRC  = (154.8:247.4:446.2);
      specparam THPW = (51.6:82.5:148.7);
      specparam TLPW = (51.6:82.5:148.7);
      specparam TAS  = (25.6:39.3:68.0);
      specparam TAH  = (0.0:0.0:0.0);
      specparam TCSS = (14.8:23.7:42.5);
      specparam TCSH = (0.0:0.0:0.0);
      specparam TOE  = (33.2:49.9:83.5);
      specparam TOZ  = (30.1:44.0:71.8);

      $setuphold ( posedge CK &&& con_A,          posedge A0, TAS,     TAH,     n_flag_A0      );
      $setuphold ( posedge CK &&& con_A,          negedge A0, TAS,     TAH,     n_flag_A0      );
      $setuphold ( posedge CK &&& con_A,          posedge A1, TAS,     TAH,     n_flag_A1      );
      $setuphold ( posedge CK &&& con_A,          negedge A1, TAS,     TAH,     n_flag_A1      );
      $setuphold ( posedge CK &&& con_A,          posedge A2, TAS,     TAH,     n_flag_A2      );
      $setuphold ( posedge CK &&& con_A,          negedge A2, TAS,     TAH,     n_flag_A2      );
      $setuphold ( posedge CK &&& con_A,          posedge A3, TAS,     TAH,     n_flag_A3      );
      $setuphold ( posedge CK &&& con_A,          negedge A3, TAS,     TAH,     n_flag_A3      );
      $setuphold ( posedge CK &&& con_A,          posedge A4, TAS,     TAH,     n_flag_A4      );
      $setuphold ( posedge CK &&& con_A,          negedge A4, TAS,     TAH,     n_flag_A4      );
      $setuphold ( posedge CK &&& con_A,          posedge A5, TAS,     TAH,     n_flag_A5      );
      $setuphold ( posedge CK &&& con_A,          negedge A5, TAS,     TAH,     n_flag_A5      );
      $setuphold ( posedge CK &&& con_A,          posedge A6, TAS,     TAH,     n_flag_A6      );
      $setuphold ( posedge CK &&& con_A,          negedge A6, TAS,     TAH,     n_flag_A6      );
      $setuphold ( posedge CK &&& con_A,          posedge A7, TAS,     TAH,     n_flag_A7      );
      $setuphold ( posedge CK &&& con_A,          negedge A7, TAS,     TAH,     n_flag_A7      );
      $setuphold ( posedge CK &&& con_A,          posedge A8, TAS,     TAH,     n_flag_A8      );
      $setuphold ( posedge CK &&& con_A,          negedge A8, TAS,     TAH,     n_flag_A8      );
      $setuphold ( posedge CK,                    posedge CS, TCSS,    TCSH,    n_flag_CS      );
      $setuphold ( posedge CK,                    negedge CS, TCSS,    TCSH,    n_flag_CS      );
      $period    ( posedge CK &&& con_CK,         TRC,                       n_flag_CK_PER  );
      $width     ( posedge CK &&& con_CK,         THPW,    0,                n_flag_CK_MINH );
      $width     ( negedge CK &&& con_CK,         TLPW,    0,                n_flag_CK_MINL );


      if (NODELAY == 0)  (posedge CK => (DO0 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO1 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO2 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO3 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO4 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO5 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO6 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO7 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO8 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO9 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO10 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO11 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO12 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO13 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO14 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO15 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO16 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO17 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO18 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO19 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO20 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO21 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO22 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO23 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO24 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO25 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO26 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO27 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO28 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO29 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO30 :1'bx)) = TAA  ;
      if (NODELAY == 0)  (posedge CK => (DO31 :1'bx)) = TAA  ;


      (OE => DO0) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO1) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO2) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO3) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO4) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO5) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO6) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO7) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO8) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO9) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO10) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO11) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO12) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO13) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO14) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO15) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO16) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO17) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO18) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO19) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO20) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO21) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO22) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO23) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO24) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO25) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO26) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO27) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO28) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO29) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO30) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
      (OE => DO31) = (TOE,  TOE,  TOZ,  TOE,  TOZ,  TOE  );
   endspecify

`endprotect
`endif//SYNTHESIS
endmodule
