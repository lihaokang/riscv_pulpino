/*
----------------------------------------------------------------------------------
-                                                                                -
-  Copyright Mentor Graphics Corporation                                         -
-  All Rights Reserved                                                           -
-                                                                                -
-  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY                               -
-  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS                          -
-  CORPORATION OR ITS LICENSORS AND IS SUBJECT                                   -
-  TO LICENSE TERMS.                                                             -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: membistipGenerate                                            -
-          Version: 2017.1                                                       -
-       Created on: Fri Feb  1 13:44:01 CST 2019                                 -
----------------------------------------------------------------------------------


*/
module SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY (
    BIST_CLK,
    CSB,
    OE,
    WEB3,
    WEB2,
    WEB1,
    WEB0,
    DVS3,
    DVS2,
    DVS1,
    DVS0,
    DVSE,
    A11,
    A10,
    A9,
    A8,
    A7,
    A6,
    A5,
    A4,
    A3,
    A2,
    A1,
    A0,
    DI31,
    DI30,
    DI29,
    DI28,
    DI27,
    DI26,
    DI25,
    DI24,
    DI23,
    DI22,
    DI21,
    DI20,
    DI19,
    DI18,
    DI17,
    DI16,
    DI15,
    DI14,
    DI13,
    DI12,
    DI11,
    DI10,
    DI9,
    DI8,
    DI7,
    DI6,
    DI5,
    DI4,
    DI3,
    DI2,
    DI1,
    DI0,
    DO31,
    DO30,
    DO29,
    DO28,
    DO27,
    DO26,
    DO25,
    DO24,
    DO23,
    DO22,
    DO21,
    DO20,
    DO19,
    DO18,
    DO17,
    DO16,
    DO15,
    DO14,
    DO13,
    DO12,
    DO11,
    DO10,
    DO9,
    DO8,
    DO7,
    DO6,
    DO5,
    DO4,
    DO3,
    DO2,
    DO1,
    DO0
, BIST_SHIFT , BIST_HOLD , BIST_SETUP2 , BIST_SETUP , MBISTPG_TESTDATA_SELECT 
, TCK_MODE 
, TCK , LV_TM , MBISTPG_ALGO_MODE , MBISTPG_MEM_RST 
, MBISTPG_REDUCED_ADDR_CNT_EN 
, MBISTPG_ASYNC_RESETN , BIST_SI , MBISTPG_SO , MBISTPG_EN , MBISTPG_DONE 
, MBISTPG_GO 
, MBISTPG_DIAG_EN , FL_CNT_MODE , MBISTPG_CMP_STAT_ID_SEL );
  input[5:0]  MBISTPG_CMP_STAT_ID_SEL;
  input[1:0]  FL_CNT_MODE;
  wire[1:0]  FL_CNT_MODE;
  input  MBISTPG_DIAG_EN;
  output  MBISTPG_GO;
  output  MBISTPG_DONE;
  input  MBISTPG_EN;
  output  MBISTPG_SO;
  input  BIST_SI;
  input  MBISTPG_ASYNC_RESETN;
  input  MBISTPG_REDUCED_ADDR_CNT_EN;
  input  MBISTPG_MEM_RST;
  input[1:0]  MBISTPG_ALGO_MODE;
  input  LV_TM;
  input  TCK;
  input  TCK_MODE;
  input  MBISTPG_TESTDATA_SELECT;
  input[1:0]  BIST_SETUP;
  wire[1:0]  BIST_SETUP;
  input  BIST_SETUP2;
  input  BIST_HOLD;
  input  BIST_SHIFT;
input           BIST_CLK;
input           CSB;
input           OE;
input           WEB3;
input           WEB2;
input           WEB1;
input           WEB0;
input           DVS3;
input           DVS2;
input           DVS1;
input           DVS0;
input           DVSE;
input           A11;
input           A10;
input           A9;
input           A8;
input           A7;
input           A6;
input           A5;
input           A4;
input           A3;
input           A2;
input           A1;
input           A0;
input           DI31;
input           DI30;
input           DI29;
input           DI28;
input           DI27;
input           DI26;
input           DI25;
input           DI24;
input           DI23;
input           DI22;
input           DI21;
input           DI20;
input           DI19;
input           DI18;
input           DI17;
input           DI16;
input           DI15;
input           DI14;
input           DI13;
input           DI12;
input           DI11;
input           DI10;
input           DI9;
input           DI8;
input           DI7;
input           DI6;
input           DI5;
input           DI4;
input           DI3;
input           DI2;
input           DI1;
input           DI0;
output          DO31;
output          DO30;
output          DO29;
output          DO28;
output          DO27;
output          DO26;
output          DO25;
output          DO24;
output          DO23;
output          DO22;
output          DO21;
output          DO20;
output          DO19;
output          DO18;
output          DO17;
output          DO16;
output          DO15;
output          DO14;
output          DO13;
output          DO12;
output          DO11;
output          DO10;
output          DO9;
output          DO8;
output          DO7;
output          DO6;
output          DO5;
output          DO4;
output          DO3;
output          DO2;
output          DO1;
output          DO0;
// [start] : AUT Instance
SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST (
    .CK         ( BIST_CLK  ),
    .CSB        ( CSB  ),
    .OE         ( OE  ),
    .WEB3       ( WEB3  ),
    .WEB2       ( WEB2  ),
    .WEB1       ( WEB1  ),
    .WEB0       ( WEB0  ),
    .DVS3       ( DVS3  ),
    .DVS2       ( DVS2  ),
    .DVS1       ( DVS1  ),
    .DVS0       ( DVS0  ),
    .DVSE       ( DVSE  ),
    .A11        ( A11  ),
    .A10        ( A10  ),
    .A9         ( A9  ),
    .A8         ( A8  ),
    .A7         ( A7  ),
    .A6         ( A6  ),
    .A5         ( A5  ),
    .A4         ( A4  ),
    .A3         ( A3  ),
    .A2         ( A2  ),
    .A1         ( A1  ),
    .A0         ( A0  ),
    .DI31       ( DI31  ),
    .DI30       ( DI30  ),
    .DI29       ( DI29  ),
    .DI28       ( DI28  ),
    .DI27       ( DI27  ),
    .DI26       ( DI26  ),
    .DI25       ( DI25  ),
    .DI24       ( DI24  ),
    .DI23       ( DI23  ),
    .DI22       ( DI22  ),
    .DI21       ( DI21  ),
    .DI20       ( DI20  ),
    .DI19       ( DI19  ),
    .DI18       ( DI18  ),
    .DI17       ( DI17  ),
    .DI16       ( DI16  ),
    .DI15       ( DI15  ),
    .DI14       ( DI14  ),
    .DI13       ( DI13  ),
    .DI12       ( DI12  ),
    .DI11       ( DI11  ),
    .DI10       ( DI10  ),
    .DI9        ( DI9  ),
    .DI8        ( DI8  ),
    .DI7        ( DI7  ),
    .DI6        ( DI6  ),
    .DI5        ( DI5  ),
    .DI4        ( DI4  ),
    .DI3        ( DI3  ),
    .DI2        ( DI2  ),
    .DI1        ( DI1  ),
    .DI0        ( DI0  ),
    .DO31       ( DO31  ),
    .DO30       ( DO30  ),
    .DO29       ( DO29  ),
    .DO28       ( DO28  ),
    .DO27       ( DO27  ),
    .DO26       ( DO26  ),
    .DO25       ( DO25  ),
    .DO24       ( DO24  ),
    .DO23       ( DO23  ),
    .DO22       ( DO22  ),
    .DO21       ( DO21  ),
    .DO20       ( DO20  ),
    .DO19       ( DO19  ),
    .DO18       ( DO18  ),
    .DO17       ( DO17  ),
    .DO16       ( DO16  ),
    .DO15       ( DO15  ),
    .DO14       ( DO14  ),
    .DO13       ( DO13  ),
    .DO12       ( DO12  ),
    .DO11       ( DO11  ),
    .DO10       ( DO10  ),
    .DO9        ( DO9  ),
    .DO8        ( DO8  ),
    .DO7        ( DO7  ),
    .DO6        ( DO6  ),
    .DO5        ( DO5  ),
    .DO4        ( DO4  ),
    .DO3        ( DO3  ),
    .DO2        ( DO2  ),
    .DO1        ( DO1  ),
    .DO0        ( DO0  )
,
	.BIST_CLK(BIST_CLK),
	.BIST_SHIFT(BIST_SHIFT),
	.BIST_HOLD(BIST_HOLD),
	.BIST_SETUP2(BIST_SETUP2),
	.BIST_SETUP({
	BIST_SETUP[1], 
	BIST_SETUP[0]
	}),
	.MBISTPG_TESTDATA_SELECT(MBISTPG_TESTDATA_SELECT),
	.TCK_MODE(TCK_MODE),
	.TCK(TCK),
	.LV_TM(LV_TM),
	.MBISTPG_ALGO_MODE({
	MBISTPG_ALGO_MODE[1], 
	MBISTPG_ALGO_MODE[0]
	}),
	.MBISTPG_MEM_RST(MBISTPG_MEM_RST),
	.MBISTPG_REDUCED_ADDR_CNT_EN(MBISTPG_REDUCED_ADDR_CNT_EN),
	.MBISTPG_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_SI(BIST_SI),
	.MBISTPG_SO(MBISTPG_SO),
	.MBISTPG_EN(MBISTPG_EN),
	.MBISTPG_DONE(MBISTPG_DONE),
	.MBISTPG_GO(MBISTPG_GO),
	.MBISTPG_DIAG_EN(MBISTPG_DIAG_EN),
	.FL_CNT_MODE({
	FL_CNT_MODE[1], 
	FL_CNT_MODE[0]
	}),
	.MBISTPG_CMP_STAT_ID_SEL({
	MBISTPG_CMP_STAT_ID_SEL[5], 
	MBISTPG_CMP_STAT_ID_SEL[4], 
	MBISTPG_CMP_STAT_ID_SEL[3], 
	MBISTPG_CMP_STAT_ID_SEL[2], 
	MBISTPG_CMP_STAT_ID_SEL[1], 
	MBISTPG_CMP_STAT_ID_SEL[0]
	}));
// [end]   : AUT Instance 

// [start] : monitor module 
`ifdef LVISION_MBIST_DUMP_MEM_SIGNAL
//synopsys translate_off
  // Instances 
  `define controllerInstPath                  SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.SMARCHCHKB_MBIST_CTRL
  `define mem0InstPathStp0                    SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST  
  `define mem0InstPath                        SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST  
  // Instances 
 
  // Controller signals 
  `define BIST_CLK                            `controllerInstPath.BIST_CLK
  `define BIST_DONE                           `controllerInstPath.BIST_DONE
  `define BIST_EN                             `controllerInstPath.MBISTPG_EN
  `define BIST_COL_ADD                        `controllerInstPath.BIST_COL_ADD
  `define BIST_ROW_ADD                        `controllerInstPath.BIST_ROW_ADD
  `define BIST_WRITEENABLE                    `controllerInstPath.BIST_WRITEENABLE
  `define LAST_STATE_DONE                     `controllerInstPath.LAST_STATE_DONE
  `define SETUP_PULSE1                        `controllerInstPath.MBISTPG_FSM.SETUP_PULSE1
  `define SETUP_PULSE2                        `controllerInstPath.MBISTPG_FSM.SETUP_PULSE2
  `define NEXT_ALGO                           `controllerInstPath.MBISTPG_FSM.NEXT_ALGO
  `define ALGO_DONE                           `controllerInstPath.LAST_STATE_DONE
  `define LAST_STEP                           1'b1
  `define LAST_PORT                           1'b1
  `define INST_POINTER                        `controllerInstPath.MBISTPG_POINTER_CNTRL.INST_POINTER
  `define LOOP_A_CNTR                         `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.LOOP_A_CNTR
  `define LOOP_B_CNTR                         `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.LOOP_B_CNTR
  `define CNTR_A_MAX                          `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.CNTR_A_MAX
  `define CNTR_B_MAX                          `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.CNTR_B_MAX
  `define BIST_COLLAR_EN0                     `controllerInstPath.BIST_COLLAR_EN0
  `define CMP_EN0                             `controllerInstPath.BIST_CMP
  // Controller signals 
 
  // Internal signals 
  integer addMapFile;                         // Address mapping output file
  integer stepEnable0;                        // Step 0 started flag
  integer algoCycleCount0;                    // Step 0 algorithm cycle count
  integer compareCount0;                      // Step 0 compare count
  integer algoCycleCount0_subtotal;           // Step 0 algorithm cycle count after adjustment
  integer compareCount0_subtotal;             // Step 0 compare count after adjustment
  integer algoCycleCount_total;               // Overall algorithm cycle count
  integer compareCount_total;                 // Overall compare count after
  reg [4:0] PHASE_SMARCHCHKB;
  reg [2:0] SUB_PHASE_SMARCHCHKB;
  // Internal signals 
 
  // Initialize variables 
  initial
  begin
    stepEnable0 = 0;
    algoCycleCount0 = 0;
    compareCount0 = 0;
    algoCycleCount0_subtotal = 0;
    compareCount0_subtotal = 0;
    algoCycleCount_total = 0;
    compareCount_total = 0;
    PHASE_SMARCHCHKB = 1;
    SUB_PHASE_SMARCHCHKB = 0;
    addMapFile = $fopen("SMARCHCHKB_physical_logical_address.txt","w");
  end
  // Initialize variables 
 
//------------------------------
//--        SMarchCHKB        --
//------------------------------
    // [start] : SMarchCHKB 
always @ (`INST_POINTER or `CNTR_A_MAX or `CNTR_B_MAX) begin
  case(`INST_POINTER) 
    5'b00000 : begin
      PHASE_SMARCHCHKB=1 ;
      SUB_PHASE_SMARCHCHKB=0;
    end
   5'b00001 : PHASE_SMARCHCHKB=2 ;
   5'b00010 : PHASE_SMARCHCHKB=2 ;
   5'b00011 : PHASE_SMARCHCHKB=3 ;
   5'b00100 : PHASE_SMARCHCHKB=3 ;
   5'b00101 : PHASE_SMARCHCHKB=4 ;
   5'b00110 : PHASE_SMARCHCHKB=5 ;
   5'b00111 : PHASE_SMARCHCHKB=6 ;
   5'b01000 : PHASE_SMARCHCHKB=7 ;
   5'b01001 : PHASE_SMARCHCHKB=8 ;
   5'b01010: PHASE_SMARCHCHKB=9 ;
   5'b01011: PHASE_SMARCHCHKB=9 ;
   5'b01100: PHASE_SMARCHCHKB=10;
   5'b01101:
     case(`CNTR_A_MAX )
     1'b0: begin
       PHASE_SMARCHCHKB=11;
     end
     1'b1: begin
       PHASE_SMARCHCHKB=12;
     end
     endcase
   5'b01110:
     case(`CNTR_A_MAX )
     1'b0: begin
       PHASE_SMARCHCHKB=11;
     end
     1'b1: begin
       PHASE_SMARCHCHKB=12;
     end
     endcase
   5'b01111:
     case(`CNTR_B_MAX )
     1'b0: begin
       PHASE_SMARCHCHKB=13;
     end
     1'b1: begin
       PHASE_SMARCHCHKB=14;
     end
     endcase
   5'b10000:
     case(`CNTR_B_MAX )
     1'b0: begin
       PHASE_SMARCHCHKB=13;
     end
     1'b1: begin
       PHASE_SMARCHCHKB=14;
     end
     endcase
   5'b10001: PHASE_SMARCHCHKB=15;
   5'b10010: PHASE_SMARCHCHKB=15;
   endcase
end
    // [end]   : SMarchCHKB 

//--------------------
//--  Step 0  --
//--------------------
// Step 0 
always @ (posedge `BIST_CLK) begin
  if (`BIST_EN) begin
    if (stepEnable0 == 0) begin
      if (`BIST_COLLAR_EN0 && `SETUP_PULSE2) begin // Next cycle is RUN state
        stepEnable0 = 1;
        $display("[[");
        $display("[[ Starting memory signal dump for Step 0 Test Port 0 of Controller SMARCHCHKB");
        $display("[[");
    
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// Starting address signal dump for Step 0 Test Port 0 of Controller SMARCHCHKB\n");
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// MemoryID   : %s\n", "MEM0 (SHAA110_4096X8X4CM8)");
        $fwrite(addMapFile,"// MemoryType : %s\n", "SRAM");
        $fwrite(addMapFile,"// Address    : %s\n", "A11 A10 A9 A8 A7 A6 A5 A4 A3 A2 A1 A0");
        $fwrite(addMapFile,"// Data       : %s\n", "DI31 DI30 DI29 DI28 DI27 DI26 DI25 DI24 DI23 DI22 DI21 DI20 DI19 DI18 DI17 DI16 DI15 DI14 DI13 DI12 DI11 DI10 DI9 DI8 DI7 DI6 DI5 DI4 DI3 DI2 DI1 DI0");
        $fwrite(addMapFile,"// Algorithm  : %s\n", "SMARCHCHKB");
        $fwrite(addMapFile,"// Phase      : %s\n", "5.0");
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// Bank Row Column | Address | Data \n");
        $fwrite(addMapFile,"//\n");

      end
    end else begin
      if (`ALGO_DONE && `LAST_PORT) begin // Step 0 algorithm done
        stepEnable0 = 0;
        // Adjust step total
        algoCycleCount0_subtotal  = algoCycleCount0;
        compareCount0_subtotal    = compareCount0;
        // Update overall total
        algoCycleCount_total    = algoCycleCount_total + algoCycleCount0_subtotal;
        compareCount_total      = compareCount_total + compareCount0_subtotal;
 
        $display("[[");
        $display("[[ Summary for Controller SMARCHCHKB");
        $display("[[");
        $display("[[ Step 0 Number of Algorithm Cycles = %d", algoCycleCount0_subtotal);
        $display("[[ Step 0 Number of Compares         = %d", compareCount0_subtotal);
        $display("[[");
        $display("[[ Total Number of Algorithm Cycles = %d", algoCycleCount_total);
        $display("[[ Total Number of Compares         = %d", compareCount_total);
        $display("[[");
      end
    end // stepEnable0
  end // BIST_EN
end
 
always @ (negedge `BIST_CLK) begin
  if (stepEnable0 == 1) begin
    if (`CMP_EN0) begin
      compareCount0 = compareCount0 + 1;
    end
  end
end
 
always @ (negedge `BIST_CLK) begin
  if (stepEnable0 == 1) begin
    algoCycleCount0 = algoCycleCount0 + 1;
  end
end
 
// Display signals 
always @ (posedge `BIST_CLK) begin
  if (stepEnable0 == 1) begin
    $display(
                "[[",
                //"%d",                   $time,
                //" %d",                  algoCycleCount0,
                " %s",                  "SMARCHCHKB",
                " PHASE=%d.%d ;",       PHASE_SMARCHCHKB, SUB_PHASE_SMARCHCHKB,
                " INST=%d ;",           `INST_POINTER,
                " LOOPA=%d ;",          `LOOP_A_CNTR,
                " LOOPB=%d ;",          `LOOP_B_CNTR,
                " %s",                  "MEM0",
                " A11=%h", `mem0InstPath.A11,
                " A10=%h", `mem0InstPath.A10,
                " A9=%h", `mem0InstPath.A9,
                " A8=%h", `mem0InstPath.A8,
                " A7=%h", `mem0InstPath.A7,
                " A6=%h", `mem0InstPath.A6,
                " A5=%h", `mem0InstPath.A5,
                " A4=%h", `mem0InstPath.A4,
                " A3=%h", `mem0InstPath.A3,
                " A2=%h", `mem0InstPath.A2,
                " A1=%h", `mem0InstPath.A1,
                " A0=%h", `mem0InstPath.A0,
                " DI31=%h", `mem0InstPath.DI31,
                " DI30=%h", `mem0InstPath.DI30,
                " DI29=%h", `mem0InstPath.DI29,
                " DI28=%h", `mem0InstPath.DI28,
                " DI27=%h", `mem0InstPath.DI27,
                " DI26=%h", `mem0InstPath.DI26,
                " DI25=%h", `mem0InstPath.DI25,
                " DI24=%h", `mem0InstPath.DI24,
                " DI23=%h", `mem0InstPath.DI23,
                " DI22=%h", `mem0InstPath.DI22,
                " DI21=%h", `mem0InstPath.DI21,
                " DI20=%h", `mem0InstPath.DI20,
                " DI19=%h", `mem0InstPath.DI19,
                " DI18=%h", `mem0InstPath.DI18,
                " DI17=%h", `mem0InstPath.DI17,
                " DI16=%h", `mem0InstPath.DI16,
                " DI15=%h", `mem0InstPath.DI15,
                " DI14=%h", `mem0InstPath.DI14,
                " DI13=%h", `mem0InstPath.DI13,
                " DI12=%h", `mem0InstPath.DI12,
                " DI11=%h", `mem0InstPath.DI11,
                " DI10=%h", `mem0InstPath.DI10,
                " DI9=%h", `mem0InstPath.DI9,
                " DI8=%h", `mem0InstPath.DI8,
                " DI7=%h", `mem0InstPath.DI7,
                " DI6=%h", `mem0InstPath.DI6,
                " DI5=%h", `mem0InstPath.DI5,
                " DI4=%h", `mem0InstPath.DI4,
                " DI3=%h", `mem0InstPath.DI3,
                " DI2=%h", `mem0InstPath.DI2,
                " DI1=%h", `mem0InstPath.DI1,
                " DI0=%h", `mem0InstPath.DI0,
                " DO31=%h", `mem0InstPath.DO31,
                " DO30=%h", `mem0InstPath.DO30,
                " DO29=%h", `mem0InstPath.DO29,
                " DO28=%h", `mem0InstPath.DO28,
                " DO27=%h", `mem0InstPath.DO27,
                " DO26=%h", `mem0InstPath.DO26,
                " DO25=%h", `mem0InstPath.DO25,
                " DO24=%h", `mem0InstPath.DO24,
                " DO23=%h", `mem0InstPath.DO23,
                " DO22=%h", `mem0InstPath.DO22,
                " DO21=%h", `mem0InstPath.DO21,
                " DO20=%h", `mem0InstPath.DO20,
                " DO19=%h", `mem0InstPath.DO19,
                " DO18=%h", `mem0InstPath.DO18,
                " DO17=%h", `mem0InstPath.DO17,
                " DO16=%h", `mem0InstPath.DO16,
                " DO15=%h", `mem0InstPath.DO15,
                " DO14=%h", `mem0InstPath.DO14,
                " DO13=%h", `mem0InstPath.DO13,
                " DO12=%h", `mem0InstPath.DO12,
                " DO11=%h", `mem0InstPath.DO11,
                " DO10=%h", `mem0InstPath.DO10,
                " DO9=%h", `mem0InstPath.DO9,
                " DO8=%h", `mem0InstPath.DO8,
                " DO7=%h", `mem0InstPath.DO7,
                " DO6=%h", `mem0InstPath.DO6,
                " DO5=%h", `mem0InstPath.DO5,
                " DO4=%h", `mem0InstPath.DO4,
                " DO3=%h", `mem0InstPath.DO3,
                " DO2=%h", `mem0InstPath.DO2,
                " DO1=%h", `mem0InstPath.DO1,
                " DO0=%h", `mem0InstPath.DO0,
                " CSB=%h", `mem0InstPath.CSB,
                " OE=%h", `mem0InstPath.OE,
                " WEB3=%h", `mem0InstPath.WEB3,
                " WEB2=%h", `mem0InstPath.WEB2,
                " WEB1=%h", `mem0InstPath.WEB1,
                " WEB0=%h", `mem0InstPath.WEB0,
                " DVS3=%h", `mem0InstPath.DVS3,
                " DVS2=%h", `mem0InstPath.DVS2,
                " DVS1=%h", `mem0InstPath.DVS1,
                " DVS0=%h", `mem0InstPath.DVS0,
                " DVSE=%h", `mem0InstPath.DVSE,
                " %s",  ";",
                " "
    ); // $display
  end
end
// Display signals 
 
// Address map file 
always @ (posedge `BIST_CLK) begin
    // Note:
    // The map file only contains the address and data
    // values for the first memory in each controller step.
  if (stepEnable0 == 1 &&
      `BIST_WRITEENABLE &&
      PHASE_SMARCHCHKB == 5 && SUB_PHASE_SMARCHCHKB == 0) begin
    $fwrite(addMapFile,
                " %s", "-",
                " %b", `BIST_ROW_ADD, 
                " %b", `BIST_COL_ADD, 

                " ",
                "%b", `mem0InstPath.A11,
                "%b", `mem0InstPath.A10,
                "%b", `mem0InstPath.A9,
                "%b", `mem0InstPath.A8,
                "%b", `mem0InstPath.A7,
                "%b", `mem0InstPath.A6,
                "%b", `mem0InstPath.A5,
                "%b", `mem0InstPath.A4,
                "%b", `mem0InstPath.A3,
                "%b", `mem0InstPath.A2,
                "%b", `mem0InstPath.A1,
                "%b", `mem0InstPath.A0,
                " ",
                "%b", `mem0InstPath.DI31,
                "%b", `mem0InstPath.DI30,
                "%b", `mem0InstPath.DI29,
                "%b", `mem0InstPath.DI28,
                "%b", `mem0InstPath.DI27,
                "%b", `mem0InstPath.DI26,
                "%b", `mem0InstPath.DI25,
                "%b", `mem0InstPath.DI24,
                "%b", `mem0InstPath.DI23,
                "%b", `mem0InstPath.DI22,
                "%b", `mem0InstPath.DI21,
                "%b", `mem0InstPath.DI20,
                "%b", `mem0InstPath.DI19,
                "%b", `mem0InstPath.DI18,
                "%b", `mem0InstPath.DI17,
                "%b", `mem0InstPath.DI16,
                "%b", `mem0InstPath.DI15,
                "%b", `mem0InstPath.DI14,
                "%b", `mem0InstPath.DI13,
                "%b", `mem0InstPath.DI12,
                "%b", `mem0InstPath.DI11,
                "%b", `mem0InstPath.DI10,
                "%b", `mem0InstPath.DI9,
                "%b", `mem0InstPath.DI8,
                "%b", `mem0InstPath.DI7,
                "%b", `mem0InstPath.DI6,
                "%b", `mem0InstPath.DI5,
                "%b", `mem0InstPath.DI4,
                "%b", `mem0InstPath.DI3,
                "%b", `mem0InstPath.DI2,
                "%b", `mem0InstPath.DI1,
                "%b", `mem0InstPath.DI0,

                " \n"
    ); // $fwrite
  end
end
// Address map file 
// Step 0 

//synopsys translate_on
`endif
// [end]   : monitor module 

 
 
endmodule // SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_ASSEMBLY

// [start] : AUT module 
module SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST (
    CK,
    CSB,
    OE,
    WEB3,
    WEB2,
    WEB1,
    WEB0,
    DVS3,
    DVS2,
    DVS1,
    DVS0,
    DVSE,
    A11,
    A10,
    A9,
    A8,
    A7,
    A6,
    A5,
    A4,
    A3,
    A2,
    A1,
    A0,
    DI31,
    DI30,
    DI29,
    DI28,
    DI27,
    DI26,
    DI25,
    DI24,
    DI23,
    DI22,
    DI21,
    DI20,
    DI19,
    DI18,
    DI17,
    DI16,
    DI15,
    DI14,
    DI13,
    DI12,
    DI11,
    DI10,
    DI9,
    DI8,
    DI7,
    DI6,
    DI5,
    DI4,
    DI3,
    DI2,
    DI1,
    DI0,
    DO31,
    DO30,
    DO29,
    DO28,
    DO27,
    DO26,
    DO25,
    DO24,
    DO23,
    DO22,
    DO21,
    DO20,
    DO19,
    DO18,
    DO17,
    DO16,
    DO15,
    DO14,
    DO13,
    DO12,
    DO11,
    DO10,
    DO9,
    DO8,
    DO7,
    DO6,
    DO5,
    DO4,
    DO3,
    DO2,
    DO1,
    DO0
, BIST_CLK , BIST_SHIFT , BIST_HOLD , BIST_SETUP2 , BIST_SETUP 
, MBISTPG_TESTDATA_SELECT 
, TCK_MODE , TCK , LV_TM , MBISTPG_ALGO_MODE , MBISTPG_MEM_RST 
, MBISTPG_REDUCED_ADDR_CNT_EN 
, MBISTPG_ASYNC_RESETN , BIST_SI , MBISTPG_SO , MBISTPG_EN , MBISTPG_DONE 
, MBISTPG_GO 
, MBISTPG_DIAG_EN , FL_CNT_MODE , MBISTPG_CMP_STAT_ID_SEL );
  wire  DI0_LV_1;
  wire  DI1_LV_1;
  wire  DI2_LV_1;
  wire  DI3_LV_1;
  wire  DI4_LV_1;
  wire  DI5_LV_1;
  wire  DI6_LV_1;
  wire  DI7_LV_1;
  wire  DI8_LV_1;
  wire  DI9_LV_1;
  wire  DI10_LV_1;
  wire  DI11_LV_1;
  wire  DI12_LV_1;
  wire  DI13_LV_1;
  wire  DI14_LV_1;
  wire  DI15_LV_1;
  wire  DI16_LV_1;
  wire  DI17_LV_1;
  wire  DI18_LV_1;
  wire  DI19_LV_1;
  wire  DI20_LV_1;
  wire  DI21_LV_1;
  wire  DI22_LV_1;
  wire  DI23_LV_1;
  wire  DI24_LV_1;
  wire  DI25_LV_1;
  wire  DI26_LV_1;
  wire  DI27_LV_1;
  wire  DI28_LV_1;
  wire  DI29_LV_1;
  wire  DI30_LV_1;
  wire  DI31_LV_1;
  wire  MEM0_INTERF_INST_A0;
  wire  MEM0_INTERF_INST_A1;
  wire  MEM0_INTERF_INST_A2;
  wire  MEM0_INTERF_INST_A3;
  wire  MEM0_INTERF_INST_A4;
  wire  MEM0_INTERF_INST_A5;
  wire  MEM0_INTERF_INST_A6;
  wire  MEM0_INTERF_INST_A7;
  wire  MEM0_INTERF_INST_A8;
  wire  MEM0_INTERF_INST_A9;
  wire  A10_LV_1;
  wire  A11_LV_1;
  wire  WEB0_LV_1;
  wire  WEB1_LV_1;
  wire  WEB2_LV_1;
  wire  WEB3_LV_1;
  wire  MEM0_INTERF_INST_OE;
  wire  CSB_LV_1;
  wire  RESET_REG_SETUP2;
  wire[31:0]  BIST_DATA_FROM_MEM0;
  wire  BIST_COLLAR_HOLD;
  wire  BIST_CLEAR;
  wire  BIST_CLEAR_DEFAULT;
  wire  BIST_COLLAR_SETUP;
  wire  BIST_SHIFT_COLLAR;
  wire  CHKBCI_PHASE;
  wire[1:0]  BIST_WRITE_DATA;
  wire  BIST_COLLAR_EN;
  wire[8:0]  BIST_ROW_ADD;
  wire[2:0]  BIST_COL_ADD;
  wire  BIST_WRITEENABLE;
  wire  BIST_OUTPUTENABLE;
  wire  BIST_SELECT;
  input[5:0]  MBISTPG_CMP_STAT_ID_SEL;
  wire[5:0]  MBISTPG_CMP_STAT_ID_SEL;
  input[1:0]  FL_CNT_MODE;
  wire[1:0]  FL_CNT_MODE;
  input  MBISTPG_DIAG_EN;
  wire  MBISTPG_DIAG_EN;
  output  MBISTPG_GO;
  wire  MBISTPG_GO;
  output  MBISTPG_DONE;
  wire  MBISTPG_DONE;
  input  MBISTPG_EN;
  wire  MBISTPG_EN;
  output  MBISTPG_SO;
  wire  MBISTPG_SO;
  input  BIST_SI;
  wire  BIST_SI;
  input  MBISTPG_ASYNC_RESETN;
  wire  MBISTPG_ASYNC_RESETN;
  input  MBISTPG_REDUCED_ADDR_CNT_EN;
  wire  MBISTPG_REDUCED_ADDR_CNT_EN;
  input  MBISTPG_MEM_RST;
  wire  MBISTPG_MEM_RST;
  input[1:0]  MBISTPG_ALGO_MODE;
  wire[1:0]  MBISTPG_ALGO_MODE;
  input  LV_TM;
  wire  LV_TM;
  input  TCK;
  wire  TCK;
  input  TCK_MODE;
  wire  TCK_MODE;
  input  MBISTPG_TESTDATA_SELECT;
  wire  MBISTPG_TESTDATA_SELECT;
  input[1:0]  BIST_SETUP;
  wire[1:0]  BIST_SETUP;
  input  BIST_SETUP2;
  wire  BIST_SETUP2;
  input  BIST_HOLD;
  wire  BIST_HOLD;
  input  BIST_SHIFT;
  wire  BIST_SHIFT;
  input  BIST_CLK;
  wire  BIST_CLK;
input                                         CK;
input                                         CSB;
input                                         OE;
input                                         WEB3;
input                                         WEB2;
input                                         WEB1;
input                                         WEB0;
input                                         DVS3;
input                                         DVS2;
input                                         DVS1;
input                                         DVS0;
input                                         DVSE;
input                                         A11;
input                                         A10;
input                                         A9;
input                                         A8;
input                                         A7;
input                                         A6;
input                                         A5;
input                                         A4;
input                                         A3;
input                                         A2;
input                                         A1;
input                                         A0;
input                                         DI31;
input                                         DI30;
input                                         DI29;
input                                         DI28;
input                                         DI27;
input                                         DI26;
input                                         DI25;
input                                         DI24;
input                                         DI23;
input                                         DI22;
input                                         DI21;
input                                         DI20;
input                                         DI19;
input                                         DI18;
input                                         DI17;
input                                         DI16;
input                                         DI15;
input                                         DI14;
input                                         DI13;
input                                         DI12;
input                                         DI11;
input                                         DI10;
input                                         DI9;
input                                         DI8;
input                                         DI7;
input                                         DI6;
input                                         DI5;
input                                         DI4;
input                                         DI3;
input                                         DI2;
input                                         DI1;
input                                         DI0;
output                                        DO31;
output                                        DO30;
output                                        DO29;
output                                        DO28;
output                                        DO27;
output                                        DO26;
output                                        DO25;
output                                        DO24;
output                                        DO23;
output                                        DO22;
output                                        DO21;
output                                        DO20;
output                                        DO19;
output                                        DO18;
output                                        DO17;
output                                        DO16;
output                                        DO15;
output                                        DO14;
output                                        DO13;
output                                        DO12;
output                                        DO11;
output                                        DO10;
output                                        DO9;
output                                        DO8;
output                                        DO7;
output                                        DO6;
output                                        DO5;
output                                        DO4;
output                                        DO3;
output                                        DO2;
output                                        DO1;
output                                        DO0;

SHAA110_4096X8X4CM8 MEM0_MEM_INST ( // 
        // Clock ports
            .CK                               ( CK ),
	.CSB(CSB_LV_1),
	.OE(MEM0_INTERF_INST_OE),
	.WEB3(WEB3_LV_1),
	.WEB2(WEB2_LV_1),
	.WEB1(WEB1_LV_1),
	.WEB0(WEB0_LV_1), // i
        // Functional ports
            .DVS3                             ( DVS3 ), // i
            .DVS2                             ( DVS2 ), // i
            .DVS1                             ( DVS1 ), // i
            .DVS0                             ( DVS0 ), // i
            .DVSE                             ( DVSE ),
	.A11(A11_LV_1),
	.A10(A10_LV_1),
	.A9(MEM0_INTERF_INST_A9),
	.A8(MEM0_INTERF_INST_A8),
	.A7(MEM0_INTERF_INST_A7),
	.A6(MEM0_INTERF_INST_A6),
	.A5(MEM0_INTERF_INST_A5),
	.A4(MEM0_INTERF_INST_A4),
	.A3(MEM0_INTERF_INST_A3),
	.A2(MEM0_INTERF_INST_A2),
	.A1(MEM0_INTERF_INST_A1),
	.A0(MEM0_INTERF_INST_A0),
	.DI31(DI31_LV_1),
	.DI30(DI30_LV_1),
	.DI29(DI29_LV_1),
	.DI28(DI28_LV_1),
	.DI27(DI27_LV_1),
	.DI26(DI26_LV_1),
	.DI25(DI25_LV_1),
	.DI24(DI24_LV_1),
	.DI23(DI23_LV_1),
	.DI22(DI22_LV_1),
	.DI21(DI21_LV_1),
	.DI20(DI20_LV_1),
	.DI19(DI19_LV_1),
	.DI18(DI18_LV_1),
	.DI17(DI17_LV_1),
	.DI16(DI16_LV_1),
	.DI15(DI15_LV_1),
	.DI14(DI14_LV_1),
	.DI13(DI13_LV_1),
	.DI12(DI12_LV_1),
	.DI11(DI11_LV_1),
	.DI10(DI10_LV_1),
	.DI9(DI9_LV_1),
	.DI8(DI8_LV_1),
	.DI7(DI7_LV_1),
	.DI6(DI6_LV_1),
	.DI5(DI5_LV_1),
	.DI4(DI4_LV_1),
	.DI3(DI3_LV_1),
	.DI2(DI2_LV_1),
	.DI1(DI1_LV_1),
	.DI0(DI0_LV_1), // i
            .DO31                             ( DO31 ), // o
            .DO30                             ( DO30 ), // o
            .DO29                             ( DO29 ), // o
            .DO28                             ( DO28 ), // o
            .DO27                             ( DO27 ), // o
            .DO26                             ( DO26 ), // o
            .DO25                             ( DO25 ), // o
            .DO24                             ( DO24 ), // o
            .DO23                             ( DO23 ), // o
            .DO22                             ( DO22 ), // o
            .DO21                             ( DO21 ), // o
            .DO20                             ( DO20 ), // o
            .DO19                             ( DO19 ), // o
            .DO18                             ( DO18 ), // o
            .DO17                             ( DO17 ), // o
            .DO16                             ( DO16 ), // o
            .DO15                             ( DO15 ), // o
            .DO14                             ( DO14 ), // o
            .DO13                             ( DO13 ), // o
            .DO12                             ( DO12 ), // o
            .DO11                             ( DO11 ), // o
            .DO10                             ( DO10 ), // o
            .DO9                              ( DO9 ), // o
            .DO8                              ( DO8 ), // o
            .DO7                              ( DO7 ), // o
            .DO6                              ( DO6 ), // o
            .DO5                              ( DO5 ), // o
            .DO4                              ( DO4 ), // o
            .DO3                              ( DO3 ), // o
            .DO2                              ( DO2 ), // o
            .DO1                              ( DO1 ), // o
            .DO0                              ( DO0 )  // o
); // 
 
 
SMARCHCHKB_LVISION_MBISTPG_CTRL SMARCHCHKB_MBIST_CTRL
   (
	.BIST_CLK(BIST_CLK),
	.BIST_SHIFT(BIST_SHIFT),
	.BIST_HOLD(BIST_HOLD),
	.BIST_SETUP2(BIST_SETUP2),
	.BIST_SETUP({
	BIST_SETUP[1], 
	BIST_SETUP[0]
	}),
	.MBISTPG_TESTDATA_SELECT(MBISTPG_TESTDATA_SELECT),
	.TCK_MODE(TCK_MODE),
	.TCK(TCK),
	.LV_TM(LV_TM),
	.MBISTPG_ALGO_MODE({
	MBISTPG_ALGO_MODE[1], 
	MBISTPG_ALGO_MODE[0]
	}),
	.MBISTPG_MEM_RST(MBISTPG_MEM_RST),
	.MBISTPG_REDUCED_ADDR_CNT_EN(MBISTPG_REDUCED_ADDR_CNT_EN),
	.MBISTPG_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_SI(BIST_SI),
	.MBISTPG_SO(MBISTPG_SO),
	.MBISTPG_EN(MBISTPG_EN),
	.MBISTPG_DONE(MBISTPG_DONE),
	.MBISTPG_GO(MBISTPG_GO),
	.MBISTPG_DIAG_EN(MBISTPG_DIAG_EN),
	.FL_CNT_MODE({
	FL_CNT_MODE[1], 
	FL_CNT_MODE[0]
	}),
	.MBISTPG_CMP_STAT_ID_SEL({
	MBISTPG_CMP_STAT_ID_SEL[5], 
	MBISTPG_CMP_STAT_ID_SEL[4], 
	MBISTPG_CMP_STAT_ID_SEL[3], 
	MBISTPG_CMP_STAT_ID_SEL[2], 
	MBISTPG_CMP_STAT_ID_SEL[1], 
	MBISTPG_CMP_STAT_ID_SEL[0]
	}),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_WRITEENABLE(BIST_WRITEENABLE),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD(BIST_ROW_ADD),
	.BIST_COLLAR_EN0(BIST_COLLAR_EN),
	.BIST_WRITE_DATA(BIST_WRITE_DATA),
	.CHKBCI_PHASE(CHKBCI_PHASE),
	.BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR),
	.BIST_COLLAR_SETUP(BIST_COLLAR_SETUP),
	.BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT),
	.BIST_CLEAR(BIST_CLEAR),
	.BIST_COLLAR_HOLD(BIST_COLLAR_HOLD),
	.BIST_DATA_FROM_MEM0(BIST_DATA_FROM_MEM0),
	.MBISTPG_RESET_REG_SETUP2(RESET_REG_SETUP2));

SMARCHCHKB_LVISION_MEM0_INTERFACE MEM0_INTERF_INST
   ( .SCAN_OBS_FLOPS(),
	.CSB_IN(CSB),
	.OE_IN(OE),
	.WEB3_IN(WEB3),
	.WEB2_IN(WEB2),
	.WEB1_IN(WEB1),
	.WEB0_IN(WEB0),
	.A11_IN(A11),
	.A10_IN(A10),
	.A9_IN(A9),
	.A8_IN(A8),
	.A7_IN(A7),
	.A6_IN(A6),
	.A5_IN(A5),
	.A4_IN(A4),
	.A3_IN(A3),
	.A2_IN(A2),
	.A1_IN(A1),
	.A0_IN(A0),
	.DI31_IN(DI31),
	.DI30_IN(DI30),
	.DI29_IN(DI29),
	.DI28_IN(DI28),
	.DI27_IN(DI27),
	.DI26_IN(DI26),
	.DI25_IN(DI25),
	.DI24_IN(DI24),
	.DI23_IN(DI23),
	.DI22_IN(DI22),
	.DI21_IN(DI21),
	.DI20_IN(DI20),
	.DI19_IN(DI19),
	.DI18_IN(DI18),
	.DI17_IN(DI17),
	.DI16_IN(DI16),
	.DI15_IN(DI15),
	.DI14_IN(DI14),
	.DI13_IN(DI13),
	.DI12_IN(DI12),
	.DI11_IN(DI11),
	.DI10_IN(DI10),
	.DI9_IN(DI9),
	.DI8_IN(DI8),
	.DI7_IN(DI7),
	.DI6_IN(DI6),
	.DI5_IN(DI5),
	.DI4_IN(DI4),
	.DI3_IN(DI3),
	.DI2_IN(DI2),
	.DI1_IN(DI1),
	.DI0_IN(DI0),
	.BIST_CLK(BIST_CLK),
	.TCK_MODE(TCK_MODE),
	.LV_TM(LV_TM),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_WRITEENABLE(BIST_WRITEENABLE),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD(BIST_ROW_ADD),
	.BIST_EN(MBISTPG_EN),
	.BIST_COLLAR_EN(BIST_COLLAR_EN),
	.BIST_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_TESTDATA_SELECT_TO_COLLAR(MBISTPG_TESTDATA_SELECT),
	.BIST_WRITE_DATA(BIST_WRITE_DATA),
	.CHKBCI_PHASE(CHKBCI_PHASE),
	.BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR),
	.BIST_COLLAR_SETUP(BIST_COLLAR_SETUP),
	.BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT),
	.BIST_CLEAR(BIST_CLEAR),
	.BIST_SETUP0(BIST_SETUP[0]),
	.BIST_COLLAR_HOLD(BIST_COLLAR_HOLD),
	.BIST_DATA_FROM_MEM(BIST_DATA_FROM_MEM0),
	.RESET_REG_SETUP2(RESET_REG_SETUP2),
	.CSB(CSB_LV_1),
	.OE(MEM0_INTERF_INST_OE),
	.WEB3(WEB3_LV_1),
	.WEB2(WEB2_LV_1),
	.WEB1(WEB1_LV_1),
	.WEB0(WEB0_LV_1),
	.A11(A11_LV_1),
	.A10(A10_LV_1),
	.A9(MEM0_INTERF_INST_A9),
	.A8(MEM0_INTERF_INST_A8),
	.A7(MEM0_INTERF_INST_A7),
	.A6(MEM0_INTERF_INST_A6),
	.A5(MEM0_INTERF_INST_A5),
	.A4(MEM0_INTERF_INST_A4),
	.A3(MEM0_INTERF_INST_A3),
	.A2(MEM0_INTERF_INST_A2),
	.A1(MEM0_INTERF_INST_A1),
	.A0(MEM0_INTERF_INST_A0),
	.DI31(DI31_LV_1),
	.DI30(DI30_LV_1),
	.DI29(DI29_LV_1),
	.DI28(DI28_LV_1),
	.DI27(DI27_LV_1),
	.DI26(DI26_LV_1),
	.DI25(DI25_LV_1),
	.DI24(DI24_LV_1),
	.DI23(DI23_LV_1),
	.DI22(DI22_LV_1),
	.DI21(DI21_LV_1),
	.DI20(DI20_LV_1),
	.DI19(DI19_LV_1),
	.DI18(DI18_LV_1),
	.DI17(DI17_LV_1),
	.DI16(DI16_LV_1),
	.DI15(DI15_LV_1),
	.DI14(DI14_LV_1),
	.DI13(DI13_LV_1),
	.DI12(DI12_LV_1),
	.DI11(DI11_LV_1),
	.DI10(DI10_LV_1),
	.DI9(DI9_LV_1),
	.DI8(DI8_LV_1),
	.DI7(DI7_LV_1),
	.DI6(DI6_LV_1),
	.DI5(DI5_LV_1),
	.DI4(DI4_LV_1),
	.DI3(DI3_LV_1),
	.DI2(DI2_LV_1),
	.DI1(DI1_LV_1),
	.DI0(DI0_LV_1),
	.DO31(DO31),
	.DO30(DO30),
	.DO29(DO29),
	.DO28(DO28),
	.DO27(DO27),
	.DO26(DO26),
	.DO25(DO25),
	.DO24(DO24),
	.DO23(DO23),
	.DO22(DO22),
	.DO21(DO21),
	.DO20(DO20),
	.DO19(DO19),
	.DO18(DO18),
	.DO17(DO17),
	.DO16(DO16),
	.DO15(DO15),
	.DO14(DO14),
	.DO13(DO13),
	.DO12(DO12),
	.DO11(DO11),
	.DO10(DO10),
	.DO9(DO9),
	.DO8(DO8),
	.DO7(DO7),
	.DO6(DO6),
	.DO5(DO5),
	.DO4(DO4),
	.DO3(DO3),
	.DO2(DO2),
	.DO1(DO1),
	.DO0(DO0));

endmodule // SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST
// [end]   : AUT module 

