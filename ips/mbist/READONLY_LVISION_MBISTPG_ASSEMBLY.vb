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
-       Created on: Sat Feb 23 20:09:41 CST 2019                                 -
----------------------------------------------------------------------------------


*/
module READONLY_LVISION_MBISTPG_ASSEMBLY (
    BIST_CLK,
    CS,
    OE,
    DVS3,
    DVS2,
    DVS1,
    DVS0,
    DVSE,
    A8,
    A7,
    A6,
    A5,
    A4,
    A3,
    A2,
    A1,
    A0,
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
, TCK , LV_TM , MBISTPG_MEM_RST , MBISTPG_REDUCED_ADDR_CNT_EN 
, MBISTPG_ASYNC_RESETN 
, BIST_SI , MBISTPG_SO , MBISTPG_EN , MBISTPG_DONE , MBISTPG_GO );
  output  MBISTPG_GO;
  output  MBISTPG_DONE;
  input  MBISTPG_EN;
  output  MBISTPG_SO;
  input  BIST_SI;
  input  MBISTPG_ASYNC_RESETN;
  input  MBISTPG_REDUCED_ADDR_CNT_EN;
  input  MBISTPG_MEM_RST;
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
input           CS;
input           OE;
input           DVS3;
input           DVS2;
input           DVS1;
input           DVS0;
input           DVSE;
input           A8;
input           A7;
input           A6;
input           A5;
input           A4;
input           A3;
input           A2;
input           A1;
input           A0;
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
READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST (
    .CK         ( BIST_CLK  ),
    .CS         ( CS  ),
    .OE         ( OE  ),
    .DVS3       ( DVS3  ),
    .DVS2       ( DVS2  ),
    .DVS1       ( DVS1  ),
    .DVS0       ( DVS0  ),
    .DVSE       ( DVSE  ),
    .A8         ( A8  ),
    .A7         ( A7  ),
    .A6         ( A6  ),
    .A5         ( A5  ),
    .A4         ( A4  ),
    .A3         ( A3  ),
    .A2         ( A2  ),
    .A1         ( A1  ),
    .A0         ( A0  ),
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
	.MBISTPG_MEM_RST(MBISTPG_MEM_RST),
	.MBISTPG_REDUCED_ADDR_CNT_EN(MBISTPG_REDUCED_ADDR_CNT_EN),
	.MBISTPG_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_SI(BIST_SI),
	.MBISTPG_SO(MBISTPG_SO),
	.MBISTPG_EN(MBISTPG_EN),
	.MBISTPG_DONE(MBISTPG_DONE),
	.MBISTPG_GO(MBISTPG_GO));
// [end]   : AUT Instance 

// [start] : monitor module 
`ifdef LVISION_MBIST_DUMP_MEM_SIGNAL
//synopsys translate_off
  // Instances 
  `define controllerInstPath                  READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.READONLY_MBIST_CTRL
  `define mem0InstPathStp0                    READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST  
  `define mem0InstPath                        READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST  
  // Instances 
 
  // Controller signals 
  `define BIST_CLK                            `controllerInstPath.BIST_CLK
  `define BIST_DONE                           `controllerInstPath.BIST_DONE
  `define BIST_EN                             `controllerInstPath.MBISTPG_EN
  `define BIST_COL_ADD                        `controllerInstPath.BIST_COL_ADD
  `define BIST_ROW_ADD                        `controllerInstPath.BIST_ROW_ADD
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
  reg [4:0] PHASE_READONLY;
  reg [2:0] SUB_PHASE_READONLY;
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
    PHASE_READONLY = 1;
    SUB_PHASE_READONLY = 0;
    addMapFile = $fopen("READONLY_physical_logical_address.txt","w");
  end
  // Initialize variables 
 
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
        $display("[[ Starting memory signal dump for Step 0 Test Port 0 of Controller READONLY");
        $display("[[");
    
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// Starting address signal dump for Step 0 Test Port 0 of Controller READONLY\n");
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// MemoryID   : %s\n", "MEM0 (SKAA110_512X32BM1A)");
        $fwrite(addMapFile,"// MemoryType : %s\n", "ROM");
        $fwrite(addMapFile,"// Address    : %s\n", "A8 A7 A6 A5 A4 A3 A2 A1 A0");
        $fwrite(addMapFile,"// Data       : %s\n", "DO31 DO30 DO29 DO28 DO27 DO26 DO25 DO24 DO23 DO22 DO21 DO20 DO19 DO18 DO17 DO16 DO15 DO14 DO13 DO12 DO11 DO10 DO9 DO8 DO7 DO6 DO5 DO4 DO3 DO2 DO1 DO0");
        $fwrite(addMapFile,"// Algorithm  : %s\n", "READONLY");
        $fwrite(addMapFile,"// Phase      : %s\n", "2.0");
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
        $display("[[ Summary for Controller READONLY");
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
                " %s",                  "READONLY",
                " PHASE=%d.%d ;",       PHASE_READONLY, SUB_PHASE_READONLY,
                " INST=%d ;",           `INST_POINTER,
                " LOOPA=%d ;",          `LOOP_A_CNTR,
                " LOOPB=%d ;",          `LOOP_B_CNTR,
                " %s",                  "MEM0",
                " A8=%h", `mem0InstPath.A8,
                " A7=%h", `mem0InstPath.A7,
                " A6=%h", `mem0InstPath.A6,
                " A5=%h", `mem0InstPath.A5,
                " A4=%h", `mem0InstPath.A4,
                " A3=%h", `mem0InstPath.A3,
                " A2=%h", `mem0InstPath.A2,
                " A1=%h", `mem0InstPath.A1,
                " A0=%h", `mem0InstPath.A0,
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
                " CS=%h", `mem0InstPath.CS,
                " OE=%h", `mem0InstPath.OE,
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
      `CMP_EN0 == 1'b1 &&
      `INST_POINTER == 2'b01 && `CNTR_A_MAX == 1'b0) begin
    $fwrite(addMapFile,
                " %s", "-",
                " %b", `BIST_ROW_ADD, 
                " %b", `BIST_COL_ADD, 

                " ",
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
                "%b", `mem0InstPath.DO31,
                "%b", `mem0InstPath.DO30,
                "%b", `mem0InstPath.DO29,
                "%b", `mem0InstPath.DO28,
                "%b", `mem0InstPath.DO27,
                "%b", `mem0InstPath.DO26,
                "%b", `mem0InstPath.DO25,
                "%b", `mem0InstPath.DO24,
                "%b", `mem0InstPath.DO23,
                "%b", `mem0InstPath.DO22,
                "%b", `mem0InstPath.DO21,
                "%b", `mem0InstPath.DO20,
                "%b", `mem0InstPath.DO19,
                "%b", `mem0InstPath.DO18,
                "%b", `mem0InstPath.DO17,
                "%b", `mem0InstPath.DO16,
                "%b", `mem0InstPath.DO15,
                "%b", `mem0InstPath.DO14,
                "%b", `mem0InstPath.DO13,
                "%b", `mem0InstPath.DO12,
                "%b", `mem0InstPath.DO11,
                "%b", `mem0InstPath.DO10,
                "%b", `mem0InstPath.DO9,
                "%b", `mem0InstPath.DO8,
                "%b", `mem0InstPath.DO7,
                "%b", `mem0InstPath.DO6,
                "%b", `mem0InstPath.DO5,
                "%b", `mem0InstPath.DO4,
                "%b", `mem0InstPath.DO3,
                "%b", `mem0InstPath.DO2,
                "%b", `mem0InstPath.DO1,
                "%b", `mem0InstPath.DO0,

                " \n"
    ); // $fwrite
  end
end
// Address map file 
// Step 0 

//synopsys translate_on
`endif
// [end]   : monitor module 

 
 
endmodule // READONLY_LVISION_MBISTPG_ASSEMBLY_ASSEMBLY

// [start] : AUT module 
module READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST (
    CK,
    CS,
    OE,
    DVS3,
    DVS2,
    DVS1,
    DVS0,
    DVSE,
    A8,
    A7,
    A6,
    A5,
    A4,
    A3,
    A2,
    A1,
    A0,
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
, TCK_MODE , TCK , LV_TM , MBISTPG_MEM_RST , MBISTPG_REDUCED_ADDR_CNT_EN 
, MBISTPG_ASYNC_RESETN 
, BIST_SI , MBISTPG_SO , MBISTPG_EN , MBISTPG_DONE , MBISTPG_GO );
  wire  MEM0_INTERF_INST_A0;
  wire  MEM0_INTERF_INST_A1;
  wire  MEM0_INTERF_INST_A2;
  wire  MEM0_INTERF_INST_A3;
  wire  MEM0_INTERF_INST_A4;
  wire  MEM0_INTERF_INST_A5;
  wire  MEM0_INTERF_INST_A6;
  wire  MEM0_INTERF_INST_A7;
  wire  MEM0_INTERF_INST_A8;
  wire  MEM0_INTERF_INST_OE;
  wire  MEM0_INTERF_INST_CS;
  wire  BIST_GO;
  wire  BIST_COLLAR_HOLD;
  wire  BIST_CLEAR;
  wire  BIST_CLEAR_DEFAULT;
  wire  BIST_COLLAR_SETUP;
  wire  BIST_SO;
  wire  BIST_SI_LV_1;
  wire  BIST_SHIFT_COLLAR;
  wire  BIST_COLLAR_EN;
  wire[4:0]  BIST_ROW_ADD;
  wire[3:0]  BIST_COL_ADD;
  wire  BIST_CMP;
  wire  BIST_OUTPUTENABLE;
  wire  BIST_SELECT;
  wire  MBISTPG_COMPARE_MISR;
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
input                                         CS;
input                                         OE;
input                                         DVS3;
input                                         DVS2;
input                                         DVS1;
input                                         DVS0;
input                                         DVSE;
input                                         A8;
input                                         A7;
input                                         A6;
input                                         A5;
input                                         A4;
input                                         A3;
input                                         A2;
input                                         A1;
input                                         A0;
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

SKAA110_512X32BM1A MEM0_MEM_INST ( // 
        // Clock ports
            .CK                               ( CK ),
	.CS(MEM0_INTERF_INST_CS),
	.OE(MEM0_INTERF_INST_OE), // i
        // Functional ports
            .DVS3                             ( DVS3 ), // i
            .DVS2                             ( DVS2 ), // i
            .DVS1                             ( DVS1 ), // i
            .DVS0                             ( DVS0 ), // i
            .DVSE                             ( DVSE ),
	.A8(MEM0_INTERF_INST_A8),
	.A7(MEM0_INTERF_INST_A7),
	.A6(MEM0_INTERF_INST_A6),
	.A5(MEM0_INTERF_INST_A5),
	.A4(MEM0_INTERF_INST_A4),
	.A3(MEM0_INTERF_INST_A3),
	.A2(MEM0_INTERF_INST_A2),
	.A1(MEM0_INTERF_INST_A1),
	.A0(MEM0_INTERF_INST_A0), // i
        // Data ports
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
 
 
READONLY_LVISION_MBISTPG_CTRL READONLY_MBIST_CTRL
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
	.MBISTPG_MEM_RST(MBISTPG_MEM_RST),
	.MBISTPG_REDUCED_ADDR_CNT_EN(MBISTPG_REDUCED_ADDR_CNT_EN),
	.MBISTPG_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_SI(BIST_SI),
	.MBISTPG_SO(MBISTPG_SO),
	.MBISTPG_EN(MBISTPG_EN),
	.MBISTPG_DONE(MBISTPG_DONE),
	.MBISTPG_GO(MBISTPG_GO),
	.MBISTPG_COMPARE_MISR(MBISTPG_COMPARE_MISR),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_CMP(BIST_CMP),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD(BIST_ROW_ADD),
	.BIST_COLLAR_EN0(BIST_COLLAR_EN),
	.BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR),
	.MEM0_BIST_COLLAR_SI(BIST_SI_LV_1),
	.MEM0_BIST_COLLAR_SO(BIST_SO),
	.BIST_COLLAR_SETUP(BIST_COLLAR_SETUP),
	.BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT),
	.BIST_CLEAR(BIST_CLEAR),
	.BIST_COLLAR_HOLD(BIST_COLLAR_HOLD),
	.BIST_COLLAR_GO(BIST_GO));

READONLY_LVISION_MEM0_INTERFACE MEM0_INTERF_INST
   ( .SCAN_OBS_FLOPS(),
	.CS_IN(CS),
	.OE_IN(OE),
	.A8_IN(A8),
	.A7_IN(A7),
	.A6_IN(A6),
	.A5_IN(A5),
	.A4_IN(A4),
	.A3_IN(A3),
	.A2_IN(A2),
	.A1_IN(A1),
	.A0_IN(A0),
	.BIST_CLK(BIST_CLK),
	.TCK_MODE(TCK_MODE),
	.LV_TM(LV_TM),
	.MBISTPG_COMPARE_MISR(MBISTPG_COMPARE_MISR),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_CMP(BIST_CMP),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD(BIST_ROW_ADD),
	.BIST_EN(MBISTPG_EN),
	.BIST_COLLAR_EN(BIST_COLLAR_EN),
	.BIST_ASYNC_RESETN(MBISTPG_ASYNC_RESETN),
	.BIST_TESTDATA_SELECT_TO_COLLAR(MBISTPG_TESTDATA_SELECT),
	.BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR),
	.BIST_SI(BIST_SI_LV_1),
	.BIST_SO(BIST_SO),
	.BIST_COLLAR_SETUP(BIST_COLLAR_SETUP),
	.BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT),
	.BIST_CLEAR(BIST_CLEAR),
	.BIST_SETUP0(BIST_SETUP[0]),
	.BIST_COLLAR_HOLD(BIST_COLLAR_HOLD),
	.BIST_GO(BIST_GO),
	.CS(MEM0_INTERF_INST_CS),
	.OE(MEM0_INTERF_INST_OE),
	.A8(MEM0_INTERF_INST_A8),
	.A7(MEM0_INTERF_INST_A7),
	.A6(MEM0_INTERF_INST_A6),
	.A5(MEM0_INTERF_INST_A5),
	.A4(MEM0_INTERF_INST_A4),
	.A3(MEM0_INTERF_INST_A3),
	.A2(MEM0_INTERF_INST_A2),
	.A1(MEM0_INTERF_INST_A1),
	.A0(MEM0_INTERF_INST_A0),
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

endmodule // READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST
// [end]   : AUT module 

