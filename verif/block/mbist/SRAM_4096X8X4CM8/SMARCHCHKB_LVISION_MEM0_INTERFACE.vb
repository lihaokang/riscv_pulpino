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
-       Created on: Fri Feb  1 13:43:54 CST 2019                                 -
----------------------------------------------------------------------------------


*/
`timescale 100 ps / 10 ps

/*------------------------------------------------------------------------------
     Module      :  SMARCHCHKB_LVISION_MEM0_INTERFACE
 
     Description :  This module contains the interface logic for the memory
                    module SHAA110_4096X8X4CM8
 
--------------------------------------------------------------------------------
     Interface Options in Effect
 
     BistDataPipelineStages        : 0;
     BitGrouping                   : 1;
     BitSliceWidth                 : 1;
     ConcurrentWrite               : OFF 
     ConcurrentRead                : OFF 
     ControllerType                : PROG;
     DataOutStage                  : NONE;
     DefaultAlgorithm              : SMARCHCHKB;
     DefaultOperationSet           : SYNC;
     InternalScanLogic             : OFF;
     LocalComparators              : OFF; 
     MemoryType                    : RAM;
     ObservationLogic              : ON;
     OutputEnableControl           : SYSTEM;
     PipelineSerialDataOut         : OFF;
     ScanWriteThru                 : OFF;
     ShadowRead                    : OFF;
     ShadowWrite                   : OFF;
     Stop-On-Error Limit           : 4096;
     TransparentMode               : SYNCMUX (Tri-state mux);
 
-------------------------------------------------------- (c) Mentor Graphics */

module SMARCHCHKB_LVISION_MEM0_INTERFACE (
                      CSB_IN,
                      CSB,
                      OE_IN,
                      OE,
                      WEB3_IN,
                      WEB3,
                      WEB2_IN,
                      WEB2,
                      WEB1_IN,
                      WEB1,
                      WEB0_IN,
                      WEB0,
                      A11_IN,
                      A11,
                      A10_IN,
                      A10,
                      A9_IN,
                      A9,
                      A8_IN,
                      A8,
                      A7_IN,
                      A7,
                      A6_IN,
                      A6,
                      A5_IN,
                      A5,
                      A4_IN,
                      A4,
                      A3_IN,
                      A3,
                      A2_IN,
                      A2,
                      A1_IN,
                      A1,
                      A0_IN,
                      A0,
                      DI31_IN,
                      DI31,
                      DI30_IN,
                      DI30,
                      DI29_IN,
                      DI29,
                      DI28_IN,
                      DI28,
                      DI27_IN,
                      DI27,
                      DI26_IN,
                      DI26,
                      DI25_IN,
                      DI25,
                      DI24_IN,
                      DI24,
                      DI23_IN,
                      DI23,
                      DI22_IN,
                      DI22,
                      DI21_IN,
                      DI21,
                      DI20_IN,
                      DI20,
                      DI19_IN,
                      DI19,
                      DI18_IN,
                      DI18,
                      DI17_IN,
                      DI17,
                      DI16_IN,
                      DI16,
                      DI15_IN,
                      DI15,
                      DI14_IN,
                      DI14,
                      DI13_IN,
                      DI13,
                      DI12_IN,
                      DI12,
                      DI11_IN,
                      DI11,
                      DI10_IN,
                      DI10,
                      DI9_IN,
                      DI9,
                      DI8_IN,
                      DI8,
                      DI7_IN,
                      DI7,
                      DI6_IN,
                      DI6,
                      DI5_IN,
                      DI5,
                      DI4_IN,
                      DI4,
                      DI3_IN,
                      DI3,
                      DI2_IN,
                      DI2,
                      DI1_IN,
                      DI1,
                      DI0_IN,
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
                      DO0,
                      SCAN_OBS_FLOPS,
                      BIST_SELECT,
                      BIST_OUTPUTENABLE,
                      BIST_WRITEENABLE,
                      BIST_COL_ADD,
                      BIST_ROW_ADD,
                      BIST_TESTDATA_SELECT_TO_COLLAR,
                      BIST_WRITE_DATA,
                      BIST_CLK,
                      BIST_ASYNC_RESETN,                // Asynchronous reset enable (active low)
                      BIST_SHIFT_COLLAR,
                      BIST_COLLAR_SETUP,
                      BIST_COLLAR_HOLD,
                      BIST_SETUP0,
                      BIST_CLEAR_DEFAULT,
                      BIST_CLEAR,
                      BIST_DATA_FROM_MEM,
                      LV_TM,
                      TCK_MODE,
                      CHKBCI_PHASE,
                      BIST_COLLAR_EN,
                      RESET_REG_SETUP2            ,
                      BIST_EN
);


input                CSB_IN;
output               CSB;
input                OE_IN;
output               OE;
input                WEB3_IN;
output               WEB3;
input                WEB2_IN;
output               WEB2;
input                WEB1_IN;
output               WEB1;
input                WEB0_IN;
output               WEB0;
input                A11_IN;
output               A11;
input                A10_IN;
output               A10;
input                A9_IN;
output               A9;
input                A8_IN;
output               A8;
input                A7_IN;
output               A7;
input                A6_IN;
output               A6;
input                A5_IN;
output               A5;
input                A4_IN;
output               A4;
input                A3_IN;
output               A3;
input                A2_IN;
output               A2;
input                A1_IN;
output               A1;
input                A0_IN;
output               A0;
input                DI31_IN;
output               DI31;
input                DI30_IN;
output               DI30;
input                DI29_IN;
output               DI29;
input                DI28_IN;
output               DI28;
input                DI27_IN;
output               DI27;
input                DI26_IN;
output               DI26;
input                DI25_IN;
output               DI25;
input                DI24_IN;
output               DI24;
input                DI23_IN;
output               DI23;
input                DI22_IN;
output               DI22;
input                DI21_IN;
output               DI21;
input                DI20_IN;
output               DI20;
input                DI19_IN;
output               DI19;
input                DI18_IN;
output               DI18;
input                DI17_IN;
output               DI17;
input                DI16_IN;
output               DI16;
input                DI15_IN;
output               DI15;
input                DI14_IN;
output               DI14;
input                DI13_IN;
output               DI13;
input                DI12_IN;
output               DI12;
input                DI11_IN;
output               DI11;
input                DI10_IN;
output               DI10;
input                DI9_IN;
output               DI9;
input                DI8_IN;
output               DI8;
input                DI7_IN;
output               DI7;
input                DI6_IN;
output               DI6;
input                DI5_IN;
output               DI5;
input                DI4_IN;
output               DI4;
input                DI3_IN;
output               DI3;
input                DI2_IN;
output               DI2;
input                DI1_IN;
output               DI1;
input                DI0_IN;
output               DI0;
inout                DO31;
inout                DO30;
inout                DO29;
inout                DO28;
inout                DO27;
inout                DO26;
inout                DO25;
inout                DO24;
inout                DO23;
inout                DO22;
inout                DO21;
inout                DO20;
inout                DO19;
inout                DO18;
inout                DO17;
inout                DO16;
inout                DO15;
inout                DO14;
inout                DO13;
inout                DO12;
inout                DO11;
inout                DO10;
inout                DO9;
inout                DO8;
inout                DO7;
inout                DO6;
inout                DO5;
inout                DO4;
inout                DO3;
inout                DO2;
inout                DO1;
inout                DO0;
output [4:0]         SCAN_OBS_FLOPS;
input                BIST_SELECT;
input                BIST_OUTPUTENABLE;
input                BIST_WRITEENABLE;
input  [2:0]         BIST_COL_ADD;
input  [8:0]         BIST_ROW_ADD;
input  [1:0]         BIST_WRITE_DATA;
wire   [31:0]        BIST_WRITE_DATA_REP;
wire   [31:0]        BIST_WRITE_DATA_INT;
input                CHKBCI_PHASE;
input                BIST_EN;
input                BIST_TESTDATA_SELECT_TO_COLLAR;
input                BIST_ASYNC_RESETN;
reg                  BIST_INPUT_SELECT;
wire                 BIST_EN_RETIME1_IN;
wire                 BIST_EN_RETIME1;
reg                  BIST_EN_RETIME1_TCK_MODE;
wire                 BIST_EN_RETIME2_IN;
reg                  BIST_EN_RETIME2;
wire                 BIST_ON_INT;
wire                 BIST_INPUT_SELECT_RST;
wire                 BIST_EN_RST;
wire                 BIST_EN_RST_TCK_MODE;
wire                 TCK_MODE_INT;
input                BIST_CLK;
wire                 BIST_CLK_INT;
input                BIST_SHIFT_COLLAR;
 
input                BIST_COLLAR_SETUP;
input                BIST_COLLAR_HOLD;
input                BIST_CLEAR_DEFAULT;
input                BIST_CLEAR;
output [31:0]        BIST_DATA_FROM_MEM;
input                BIST_SETUP0;
input                LV_TM;
input                TCK_MODE;
wire                 BIST_ON;
input                BIST_COLLAR_EN;
wire                 STATUS_SO;
input                RESET_REG_SETUP2;
wire                 COLLAR_STATUS_SI;
wire                 BIST_INPUT_SELECT_INT;
wire [0:0] ERROR,ERROR_R;
reg    [4:0]         SCAN_OBS_FLOPS;
wire   [31:0]        DATA_TO_MEM;
wire   [31:0]        DATA_FROM_MEM;
wire   [31:0]        DATA_FROM_MEM_EXP;
wire                 CSB_TEST_IN;
reg                  CSB_NOT_GATED;
wire                 CSB_TO_MUX;
wire                 OE_TEST_IN;
reg                  OE_NOT_GATED;
wire                 OE_TO_MUX;
wire                 WEB3_TEST_IN;
reg                  WEB3_NOT_GATED;
wire                 WEB3_TO_MUX;
wire                 WEB2_TEST_IN;
reg                  WEB2_NOT_GATED;
wire                 WEB2_TO_MUX;
wire                 WEB1_TEST_IN;
reg                  WEB1_NOT_GATED;
wire                 WEB1_TO_MUX;
wire                 WEB0_TEST_IN;
reg                  WEB0_NOT_GATED;
wire                 WEB0_TO_MUX;
wire                 A11_TEST_IN;
reg                  A11;
wire                 A10_TEST_IN;
reg                  A10;
wire                 A9_TEST_IN;
reg                  A9;
wire                 A8_TEST_IN;
reg                  A8;
wire                 A7_TEST_IN;
reg                  A7;
wire                 A6_TEST_IN;
reg                  A6;
wire                 A5_TEST_IN;
reg                  A5;
wire                 A4_TEST_IN;
reg                  A4;
wire                 A3_TEST_IN;
reg                  A3;
wire                 A2_TEST_IN;
reg                  A2;
wire                 A1_TEST_IN;
reg                  A1;
wire                 A0_TEST_IN;
reg                  A0;
wire                 DI31_DIN_OBS;
wire                 DI30_DIN_OBS;
wire                 DI29_DIN_OBS;
wire                 DI28_DIN_OBS;
wire                 DI27_DIN_OBS;
wire                 DI26_DIN_OBS;
wire                 DI25_DIN_OBS;
wire                 DI24_DIN_OBS;
wire                 DI23_DIN_OBS;
wire                 DI22_DIN_OBS;
wire                 DI21_DIN_OBS;
wire                 DI20_DIN_OBS;
wire                 DI19_DIN_OBS;
wire                 DI18_DIN_OBS;
wire                 DI17_DIN_OBS;
wire                 DI16_DIN_OBS;
wire                 DI15_DIN_OBS;
wire                 DI14_DIN_OBS;
wire                 DI13_DIN_OBS;
wire                 DI12_DIN_OBS;
wire                 DI11_DIN_OBS;
wire                 DI10_DIN_OBS;
wire                 DI9_DIN_OBS;
wire                 DI8_DIN_OBS;
wire                 DI7_DIN_OBS;
wire                 DI6_DIN_OBS;
wire                 DI5_DIN_OBS;
wire                 DI4_DIN_OBS;
wire                 DI3_DIN_OBS;
wire                 DI2_DIN_OBS;
wire                 DI1_DIN_OBS;
wire                 DI0_DIN_OBS;
wire                 DO31_TO_BYPASS;
wire                 DO31_FROM_BYPASS;
wire                 DO30_TO_BYPASS;
wire                 DO30_FROM_BYPASS;
wire                 DO29_TO_BYPASS;
wire                 DO29_FROM_BYPASS;
wire                 DO28_TO_BYPASS;
wire                 DO28_FROM_BYPASS;
wire                 DO27_TO_BYPASS;
wire                 DO27_FROM_BYPASS;
wire                 DO26_TO_BYPASS;
wire                 DO26_FROM_BYPASS;
wire                 DO25_TO_BYPASS;
wire                 DO25_FROM_BYPASS;
wire                 DO24_TO_BYPASS;
wire                 DO24_FROM_BYPASS;
wire                 DO23_TO_BYPASS;
wire                 DO23_FROM_BYPASS;
wire                 DO22_TO_BYPASS;
wire                 DO22_FROM_BYPASS;
wire                 DO21_TO_BYPASS;
wire                 DO21_FROM_BYPASS;
wire                 DO20_TO_BYPASS;
wire                 DO20_FROM_BYPASS;
wire                 DO19_TO_BYPASS;
wire                 DO19_FROM_BYPASS;
wire                 DO18_TO_BYPASS;
wire                 DO18_FROM_BYPASS;
wire                 DO17_TO_BYPASS;
wire                 DO17_FROM_BYPASS;
wire                 DO16_TO_BYPASS;
wire                 DO16_FROM_BYPASS;
wire                 DO15_TO_BYPASS;
wire                 DO15_FROM_BYPASS;
wire                 DO14_TO_BYPASS;
wire                 DO14_FROM_BYPASS;
wire                 DO13_TO_BYPASS;
wire                 DO13_FROM_BYPASS;
wire                 DO12_TO_BYPASS;
wire                 DO12_FROM_BYPASS;
wire                 DO11_TO_BYPASS;
wire                 DO11_FROM_BYPASS;
wire                 DO10_TO_BYPASS;
wire                 DO10_FROM_BYPASS;
wire                 DO9_TO_BYPASS;
wire                 DO9_FROM_BYPASS;
wire                 DO8_TO_BYPASS;
wire                 DO8_FROM_BYPASS;
wire                 DO7_TO_BYPASS;
wire                 DO7_FROM_BYPASS;
wire                 DO6_TO_BYPASS;
wire                 DO6_FROM_BYPASS;
wire                 DO5_TO_BYPASS;
wire                 DO5_FROM_BYPASS;
wire                 DO4_TO_BYPASS;
wire                 DO4_FROM_BYPASS;
wire                 DO3_TO_BYPASS;
wire                 DO3_FROM_BYPASS;
wire                 DO2_TO_BYPASS;
wire                 DO2_FROM_BYPASS;
wire                 DO1_TO_BYPASS;
wire                 DO1_FROM_BYPASS;
wire                 DO0_TO_BYPASS;
wire                 DO0_FROM_BYPASS;
reg                  DI31;
wire                 DI31_TEST_IN;
reg                  DI30;
wire                 DI30_TEST_IN;
reg                  DI29;
wire                 DI29_TEST_IN;
reg                  DI28;
wire                 DI28_TEST_IN;
reg                  DI27;
wire                 DI27_TEST_IN;
reg                  DI26;
wire                 DI26_TEST_IN;
reg                  DI25;
wire                 DI25_TEST_IN;
reg                  DI24;
wire                 DI24_TEST_IN;
reg                  DI23;
wire                 DI23_TEST_IN;
reg                  DI22;
wire                 DI22_TEST_IN;
reg                  DI21;
wire                 DI21_TEST_IN;
reg                  DI20;
wire                 DI20_TEST_IN;
reg                  DI19;
wire                 DI19_TEST_IN;
reg                  DI18;
wire                 DI18_TEST_IN;
reg                  DI17;
wire                 DI17_TEST_IN;
reg                  DI16;
wire                 DI16_TEST_IN;
reg                  DI15;
wire                 DI15_TEST_IN;
reg                  DI14;
wire                 DI14_TEST_IN;
reg                  DI13;
wire                 DI13_TEST_IN;
reg                  DI12;
wire                 DI12_TEST_IN;
reg                  DI11;
wire                 DI11_TEST_IN;
reg                  DI10;
wire                 DI10_TEST_IN;
reg                  DI9;
wire                 DI9_TEST_IN;
reg                  DI8;
wire                 DI8_TEST_IN;
reg                  DI7;
wire                 DI7_TEST_IN;
reg                  DI6;
wire                 DI6_TEST_IN;
reg                  DI5;
wire                 DI5_TEST_IN;
reg                  DI4;
wire                 DI4_TEST_IN;
reg                  DI3;
wire                 DI3_TEST_IN;
reg                  DI2;
wire                 DI2_TEST_IN;
reg                  DI1;
wire                 DI1_TEST_IN;
reg                  DI0;
wire                 DI0_TEST_IN;
reg                  DO31_SCAN_IN;
reg                  DO30_SCAN_IN;
reg                  DO29_SCAN_IN;
reg                  DO28_SCAN_IN;
reg                  DO27_SCAN_IN;
reg                  DO26_SCAN_IN;
reg                  DO25_SCAN_IN;
reg                  DO24_SCAN_IN;
reg                  DO23_SCAN_IN;
reg                  DO22_SCAN_IN;
reg                  DO21_SCAN_IN;
reg                  DO20_SCAN_IN;
reg                  DO19_SCAN_IN;
reg                  DO18_SCAN_IN;
reg                  DO17_SCAN_IN;
reg                  DO16_SCAN_IN;
reg                  DO15_SCAN_IN;
reg                  DO14_SCAN_IN;
reg                  DO13_SCAN_IN;
reg                  DO12_SCAN_IN;
reg                  DO11_SCAN_IN;
reg                  DO10_SCAN_IN;
reg                  DO9_SCAN_IN;
reg                  DO8_SCAN_IN;
reg                  DO7_SCAN_IN;
reg                  DO6_SCAN_IN;
reg                  DO5_SCAN_IN;
reg                  DO4_SCAN_IN;
reg                  DO3_SCAN_IN;
reg                  DO2_SCAN_IN;
reg                  DO1_SCAN_IN;
reg                  DO0_SCAN_IN;
wire                 LOGIC_HIGH = 1'b1;
wire                 USE_DEFAULTS;
 
wire                 BIST_COLLAR_HOLD_INT;
wire                 BIST_SETUP0_SYNC;


//---------------------------
// Memory Interface Main Code
//---------------------------
    assign BIST_CLK_INT             = BIST_CLK;
//----------------------
//-- BIST_ON Sync-ing --
//----------------------
    assign BIST_SETUP0_SYNC         = BIST_SETUP0 & BIST_ON;

//----------------------
//-- BIST_EN Retiming --
//----------------------
    assign BIST_EN_RST              = ~BIST_ASYNC_RESETN;
    assign BIST_EN_RETIME1_IN       = BIST_EN;
 
    // Posedge retiming cell for non-TCK mode
    SMARCHCHKB_LVISION_MBISTPG_RETIMING_CELL MBIST_NTC_RETIMING_CELL ( 
        .CLK                        ( BIST_CLK_INT                ), // i
        .R                          ( ~BIST_ASYNC_RESETN          ), // i
        .RETIME_IN                  ( BIST_EN_RETIME1_IN          ), // i
        .RETIME_OUT                 ( BIST_EN_RETIME1             )  // o
    ); 
 
    // synopsys async_set_reset "BIST_EN_RST_TCK_MODE"
    assign BIST_EN_RST_TCK_MODE     = (~TCK_MODE | LV_TM) | BIST_EN_RST;
    // Negedge retiming flop for TCK mode
    // synopsys async_set_reset "BIST_EN_RST_TCK_MODE"
    always @ (negedge BIST_CLK_INT or posedge BIST_EN_RST_TCK_MODE) begin
        if (BIST_EN_RST_TCK_MODE)
            BIST_EN_RETIME1_TCK_MODE               <= 1'b0;
        else
            BIST_EN_RETIME1_TCK_MODE               <= BIST_EN_RETIME1_IN;
    end
 
    assign TCK_MODE_INT             = TCK_MODE & ~LV_TM;
 
    assign BIST_EN_RETIME2_IN       = (TCK_MODE_INT) ? BIST_EN_RETIME1_TCK_MODE : BIST_EN_RETIME1;
 
    // Posedge stage
    //synopsys async_set_reset "BIST_EN_RST"
    always @ (posedge BIST_CLK_INT or posedge BIST_EN_RST) begin
        if (BIST_EN_RST)
            BIST_EN_RETIME2         <= 1'b0;
        else
        if (~LV_TM)
            BIST_EN_RETIME2         <= BIST_EN_RETIME2_IN;
    end
 
    // Retimed BIST_EN
    assign BIST_ON_INT              = BIST_EN_RETIME2;
    assign BIST_ON   = BIST_ON_INT; 
 
    assign BIST_INPUT_SELECT_RST    = ~BIST_TESTDATA_SELECT_TO_COLLAR & ~LV_TM & ~BIST_EN_RETIME2_IN;

    // synopsys async_set_reset "BIST_ASYNC_RESETN"
    //synopsys sync_set_reset "BIST_INPUT_SELECT_RST"
    always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
       if (~BIST_ASYNC_RESETN)
        BIST_INPUT_SELECT <= 1'b0;
       else 
       if (BIST_INPUT_SELECT_RST) begin
          BIST_INPUT_SELECT <= 1'b0;
       end else begin
          BIST_INPUT_SELECT         <= BIST_ON | BIST_INPUT_SELECT;
       end
    end

    assign #(10.0) BIST_INPUT_SELECT_INT = BIST_INPUT_SELECT;
    assign USE_DEFAULTS = ~BIST_SETUP0_SYNC | LV_TM;
 
    assign BIST_COLLAR_HOLD_INT = BIST_COLLAR_HOLD;
//-----------------------
//-- Observation Logic --
//-----------------------
  // synopsys async_set_reset "BIST_ASYNC_RESETN"
  always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
    if (~BIST_ASYNC_RESETN)
      SCAN_OBS_FLOPS    <= 5'b00000;
    else
      SCAN_OBS_FLOPS    <= {
                          CSB_NOT_GATED        ^ OE_NOT_GATED         ^ WEB3_NOT_GATED       ^ WEB2_NOT_GATED       ,
                          WEB1_NOT_GATED       ^ WEB0_NOT_GATED       ^ A11                  ^ A10                  ,
                          A9                   ^ A8                   ^ A7                   ^ A6                   ,
                          A5                   ^ A4                   ^ A3                   ^ A2                   ,
                          A1                   ^ A0                   
                           };
  end
 
//--------------------------
//-- Replicate Write Data --
//--------------------------
   assign BIST_WRITE_DATA_REP      = {
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA,
                                       BIST_WRITE_DATA
                                     };
 
//-----------------------
//-- Checkerboard Data --
//-----------------------
   assign BIST_WRITE_DATA_INT       = ~(CHKBCI_PHASE) ? BIST_WRITE_DATA_REP : ({32{BIST_WRITE_DATA_REP[0]}} ^ {32{BIST_COL_ADD[0]}});
   assign DATA_TO_MEM              = BIST_WRITE_DATA_INT;
 
 
 
 
 
 

//--------------------------
//-- Memory Control Ports --
//--------------------------

   // Port: CSB LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( CSB_IN or CSB_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : CSB_NOT_GATED = CSB_IN;
      1'b1 : CSB_NOT_GATED = CSB_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign CSB                       = CSB_NOT_GATED | LV_TM;

   // Control logic during memory test
   assign #(10.0) CSB_TEST_IN       = ~(BIST_COLLAR_EN & CSB_TO_MUX);
   assign CSB_TO_MUX                = BIST_SELECT;

   // Port: CSB }}}

   // Port: OE LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( OE_IN or OE_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : OE_NOT_GATED = OE_IN;
      1'b1 : OE_NOT_GATED = OE_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign OE                        = OE_NOT_GATED & ~LV_TM ;

   // Control logic during memory test
   assign #(10.0) OE_TEST_IN        = OE_TO_MUX;
   assign OE_TO_MUX                 = BIST_OUTPUTENABLE;

   // Port: OE }}}

   // Port: WEB3 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( WEB3_IN or WEB3_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : WEB3_NOT_GATED = WEB3_IN;
      1'b1 : WEB3_NOT_GATED = WEB3_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign WEB3                      = WEB3_NOT_GATED | LV_TM;

   // Control logic during memory test
   assign #(10.0) WEB3_TEST_IN      = ~(BIST_COLLAR_EN & WEB3_TO_MUX);
   assign WEB3_TO_MUX               = BIST_WRITEENABLE;

   // Port: WEB3 }}}

   // Port: WEB2 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( WEB2_IN or WEB2_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : WEB2_NOT_GATED = WEB2_IN;
      1'b1 : WEB2_NOT_GATED = WEB2_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign WEB2                      = WEB2_NOT_GATED | LV_TM;

   // Control logic during memory test
   assign #(10.0) WEB2_TEST_IN      = ~(BIST_COLLAR_EN & WEB2_TO_MUX);
   assign WEB2_TO_MUX               = BIST_WRITEENABLE;

   // Port: WEB2 }}}

   // Port: WEB1 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( WEB1_IN or WEB1_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : WEB1_NOT_GATED = WEB1_IN;
      1'b1 : WEB1_NOT_GATED = WEB1_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign WEB1                      = WEB1_NOT_GATED | LV_TM;

   // Control logic during memory test
   assign #(10.0) WEB1_TEST_IN      = ~(BIST_COLLAR_EN & WEB1_TO_MUX);
   assign WEB1_TO_MUX               = BIST_WRITEENABLE;

   // Port: WEB1 }}}

   // Port: WEB0 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( WEB0_IN or WEB0_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : WEB0_NOT_GATED = WEB0_IN;
      1'b1 : WEB0_NOT_GATED = WEB0_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign WEB0                      = WEB0_NOT_GATED | LV_TM;

   // Control logic during memory test
   assign #(10.0) WEB0_TEST_IN      = ~(BIST_COLLAR_EN & WEB0_TO_MUX);
   assign WEB0_TO_MUX               = BIST_WRITEENABLE;

   // Port: WEB0 }}}

//--------------------------
//-- Memory Address Ports --
//--------------------------

   // Port: A11 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A11_IN or A11_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A11 = A11_IN;
      1'b1 : A11 = A11_TEST_IN;
      endcase
   end
   // Address logic during memory test
   wire   [2:0]                     BIST_COL_ADD_SHADOW_A;
   wire   [8:0]                     BIST_ROW_ADD_SHADOW_A;
   assign BIST_ROW_ADD_SHADOW_A[8] = BIST_ROW_ADD[8];
   assign #(10.0) A11_TEST_IN       = BIST_ROW_ADD_SHADOW_A[8];

   // Port: A11 }}}

   // Port: A10 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A10_IN or A10_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A10 = A10_IN;
      1'b1 : A10 = A10_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[7] = BIST_ROW_ADD[7];
   assign #(10.0) A10_TEST_IN       = BIST_ROW_ADD_SHADOW_A[7];

   // Port: A10 }}}

   // Port: A9 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A9_IN or A9_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A9 = A9_IN;
      1'b1 : A9 = A9_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[6] = BIST_ROW_ADD[6];
   assign #(10.0) A9_TEST_IN        = BIST_ROW_ADD_SHADOW_A[6];

   // Port: A9 }}}

   // Port: A8 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A8_IN or A8_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A8 = A8_IN;
      1'b1 : A8 = A8_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[5] = BIST_ROW_ADD[5];
   assign #(10.0) A8_TEST_IN        = BIST_ROW_ADD_SHADOW_A[5];

   // Port: A8 }}}

   // Port: A7 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A7_IN or A7_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A7 = A7_IN;
      1'b1 : A7 = A7_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[4] = BIST_ROW_ADD[4];
   assign #(10.0) A7_TEST_IN        = BIST_ROW_ADD_SHADOW_A[4];

   // Port: A7 }}}

   // Port: A6 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A6_IN or A6_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A6 = A6_IN;
      1'b1 : A6 = A6_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[3] = BIST_ROW_ADD[3];
   assign #(10.0) A6_TEST_IN        = BIST_ROW_ADD_SHADOW_A[3];

   // Port: A6 }}}

   // Port: A5 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A5_IN or A5_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A5 = A5_IN;
      1'b1 : A5 = A5_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[2] = BIST_ROW_ADD[2];
   assign #(10.0) A5_TEST_IN        = BIST_ROW_ADD_SHADOW_A[2];

   // Port: A5 }}}

   // Port: A4 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A4_IN or A4_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A4 = A4_IN;
      1'b1 : A4 = A4_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[1] = BIST_ROW_ADD[1];
   assign #(10.0) A4_TEST_IN        = BIST_ROW_ADD_SHADOW_A[1];

   // Port: A4 }}}

   // Port: A3 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A3_IN or A3_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A3 = A3_IN;
      1'b1 : A3 = A3_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[0] = BIST_ROW_ADD[0];
   assign #(10.0) A3_TEST_IN        = BIST_ROW_ADD_SHADOW_A[0];

   // Port: A3 }}}

   // Port: A2 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A2_IN or A2_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A2 = A2_IN;
      1'b1 : A2 = A2_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_COL_ADD_SHADOW_A[2] = BIST_COL_ADD[2];
   assign #(10.0) A2_TEST_IN        = BIST_COL_ADD_SHADOW_A[2];

   // Port: A2 }}}

   // Port: A1 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A1_IN or A1_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A1 = A1_IN;
      1'b1 : A1 = A1_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_COL_ADD_SHADOW_A[1] = BIST_COL_ADD[1];
   assign #(10.0) A1_TEST_IN        = BIST_COL_ADD_SHADOW_A[1];

   // Port: A1 }}}

   // Port: A0 LogicalPort: A Type: READWRITE {{{

   // Intercept functional signal with test mux
   always @( A0_IN or A0_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A0 = A0_IN;
      1'b1 : A0 = A0_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_COL_ADD_SHADOW_A[0] = BIST_COL_ADD[0];
   assign #(10.0) A0_TEST_IN        = BIST_COL_ADD_SHADOW_A[0];

   // Port: A0 }}}

//--------------------
//-- Data To Memory --
//--------------------


   // Intercept functional signal with test mux
   always @( DI31_IN or DI31_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI31 = DI31_IN;
      1'b1 : DI31 = DI31_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI31_TEST_IN      = DATA_TO_MEM[31];
   // External memory bypass during logic test
   assign DI31_DIN_OBS              = DI31;


   // Intercept functional signal with test mux
   always @( DI30_IN or DI30_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI30 = DI30_IN;
      1'b1 : DI30 = DI30_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI30_TEST_IN      = DATA_TO_MEM[30];
   // External memory bypass during logic test
   assign DI30_DIN_OBS              = DI30;


   // Intercept functional signal with test mux
   always @( DI29_IN or DI29_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI29 = DI29_IN;
      1'b1 : DI29 = DI29_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI29_TEST_IN      = DATA_TO_MEM[29];
   // External memory bypass during logic test
   assign DI29_DIN_OBS              = DI29;


   // Intercept functional signal with test mux
   always @( DI28_IN or DI28_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI28 = DI28_IN;
      1'b1 : DI28 = DI28_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI28_TEST_IN      = DATA_TO_MEM[28];
   // External memory bypass during logic test
   assign DI28_DIN_OBS              = DI28;


   // Intercept functional signal with test mux
   always @( DI27_IN or DI27_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI27 = DI27_IN;
      1'b1 : DI27 = DI27_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI27_TEST_IN      = DATA_TO_MEM[27];
   // External memory bypass during logic test
   assign DI27_DIN_OBS              = DI27;


   // Intercept functional signal with test mux
   always @( DI26_IN or DI26_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI26 = DI26_IN;
      1'b1 : DI26 = DI26_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI26_TEST_IN      = DATA_TO_MEM[26];
   // External memory bypass during logic test
   assign DI26_DIN_OBS              = DI26;


   // Intercept functional signal with test mux
   always @( DI25_IN or DI25_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI25 = DI25_IN;
      1'b1 : DI25 = DI25_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI25_TEST_IN      = DATA_TO_MEM[25];
   // External memory bypass during logic test
   assign DI25_DIN_OBS              = DI25;


   // Intercept functional signal with test mux
   always @( DI24_IN or DI24_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI24 = DI24_IN;
      1'b1 : DI24 = DI24_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI24_TEST_IN      = DATA_TO_MEM[24];
   // External memory bypass during logic test
   assign DI24_DIN_OBS              = DI24;


   // Intercept functional signal with test mux
   always @( DI23_IN or DI23_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI23 = DI23_IN;
      1'b1 : DI23 = DI23_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI23_TEST_IN      = DATA_TO_MEM[23];
   // External memory bypass during logic test
   assign DI23_DIN_OBS              = DI23;


   // Intercept functional signal with test mux
   always @( DI22_IN or DI22_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI22 = DI22_IN;
      1'b1 : DI22 = DI22_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI22_TEST_IN      = DATA_TO_MEM[22];
   // External memory bypass during logic test
   assign DI22_DIN_OBS              = DI22;


   // Intercept functional signal with test mux
   always @( DI21_IN or DI21_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI21 = DI21_IN;
      1'b1 : DI21 = DI21_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI21_TEST_IN      = DATA_TO_MEM[21];
   // External memory bypass during logic test
   assign DI21_DIN_OBS              = DI21;


   // Intercept functional signal with test mux
   always @( DI20_IN or DI20_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI20 = DI20_IN;
      1'b1 : DI20 = DI20_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI20_TEST_IN      = DATA_TO_MEM[20];
   // External memory bypass during logic test
   assign DI20_DIN_OBS              = DI20;


   // Intercept functional signal with test mux
   always @( DI19_IN or DI19_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI19 = DI19_IN;
      1'b1 : DI19 = DI19_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI19_TEST_IN      = DATA_TO_MEM[19];
   // External memory bypass during logic test
   assign DI19_DIN_OBS              = DI19;


   // Intercept functional signal with test mux
   always @( DI18_IN or DI18_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI18 = DI18_IN;
      1'b1 : DI18 = DI18_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI18_TEST_IN      = DATA_TO_MEM[18];
   // External memory bypass during logic test
   assign DI18_DIN_OBS              = DI18;


   // Intercept functional signal with test mux
   always @( DI17_IN or DI17_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI17 = DI17_IN;
      1'b1 : DI17 = DI17_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI17_TEST_IN      = DATA_TO_MEM[17];
   // External memory bypass during logic test
   assign DI17_DIN_OBS              = DI17;


   // Intercept functional signal with test mux
   always @( DI16_IN or DI16_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI16 = DI16_IN;
      1'b1 : DI16 = DI16_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI16_TEST_IN      = DATA_TO_MEM[16];
   // External memory bypass during logic test
   assign DI16_DIN_OBS              = DI16;


   // Intercept functional signal with test mux
   always @( DI15_IN or DI15_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI15 = DI15_IN;
      1'b1 : DI15 = DI15_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI15_TEST_IN      = DATA_TO_MEM[15];
   // External memory bypass during logic test
   assign DI15_DIN_OBS              = DI15;


   // Intercept functional signal with test mux
   always @( DI14_IN or DI14_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI14 = DI14_IN;
      1'b1 : DI14 = DI14_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI14_TEST_IN      = DATA_TO_MEM[14];
   // External memory bypass during logic test
   assign DI14_DIN_OBS              = DI14;


   // Intercept functional signal with test mux
   always @( DI13_IN or DI13_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI13 = DI13_IN;
      1'b1 : DI13 = DI13_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI13_TEST_IN      = DATA_TO_MEM[13];
   // External memory bypass during logic test
   assign DI13_DIN_OBS              = DI13;


   // Intercept functional signal with test mux
   always @( DI12_IN or DI12_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI12 = DI12_IN;
      1'b1 : DI12 = DI12_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI12_TEST_IN      = DATA_TO_MEM[12];
   // External memory bypass during logic test
   assign DI12_DIN_OBS              = DI12;


   // Intercept functional signal with test mux
   always @( DI11_IN or DI11_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI11 = DI11_IN;
      1'b1 : DI11 = DI11_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI11_TEST_IN      = DATA_TO_MEM[11];
   // External memory bypass during logic test
   assign DI11_DIN_OBS              = DI11;


   // Intercept functional signal with test mux
   always @( DI10_IN or DI10_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI10 = DI10_IN;
      1'b1 : DI10 = DI10_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI10_TEST_IN      = DATA_TO_MEM[10];
   // External memory bypass during logic test
   assign DI10_DIN_OBS              = DI10;


   // Intercept functional signal with test mux
   always @( DI9_IN or DI9_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI9 = DI9_IN;
      1'b1 : DI9 = DI9_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI9_TEST_IN       = DATA_TO_MEM[9];
   // External memory bypass during logic test
   assign DI9_DIN_OBS               = DI9;


   // Intercept functional signal with test mux
   always @( DI8_IN or DI8_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI8 = DI8_IN;
      1'b1 : DI8 = DI8_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI8_TEST_IN       = DATA_TO_MEM[8];
   // External memory bypass during logic test
   assign DI8_DIN_OBS               = DI8;


   // Intercept functional signal with test mux
   always @( DI7_IN or DI7_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI7 = DI7_IN;
      1'b1 : DI7 = DI7_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI7_TEST_IN       = DATA_TO_MEM[7];
   // External memory bypass during logic test
   assign DI7_DIN_OBS               = DI7;


   // Intercept functional signal with test mux
   always @( DI6_IN or DI6_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI6 = DI6_IN;
      1'b1 : DI6 = DI6_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI6_TEST_IN       = DATA_TO_MEM[6];
   // External memory bypass during logic test
   assign DI6_DIN_OBS               = DI6;


   // Intercept functional signal with test mux
   always @( DI5_IN or DI5_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI5 = DI5_IN;
      1'b1 : DI5 = DI5_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI5_TEST_IN       = DATA_TO_MEM[5];
   // External memory bypass during logic test
   assign DI5_DIN_OBS               = DI5;


   // Intercept functional signal with test mux
   always @( DI4_IN or DI4_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI4 = DI4_IN;
      1'b1 : DI4 = DI4_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI4_TEST_IN       = DATA_TO_MEM[4];
   // External memory bypass during logic test
   assign DI4_DIN_OBS               = DI4;


   // Intercept functional signal with test mux
   always @( DI3_IN or DI3_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI3 = DI3_IN;
      1'b1 : DI3 = DI3_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI3_TEST_IN       = DATA_TO_MEM[3];
   // External memory bypass during logic test
   assign DI3_DIN_OBS               = DI3;


   // Intercept functional signal with test mux
   always @( DI2_IN or DI2_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI2 = DI2_IN;
      1'b1 : DI2 = DI2_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI2_TEST_IN       = DATA_TO_MEM[2];
   // External memory bypass during logic test
   assign DI2_DIN_OBS               = DI2;


   // Intercept functional signal with test mux
   always @( DI1_IN or DI1_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI1 = DI1_IN;
      1'b1 : DI1 = DI1_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI1_TEST_IN       = DATA_TO_MEM[1];
   // External memory bypass during logic test
   assign DI1_DIN_OBS               = DI1;


   // Intercept functional signal with test mux
   always @( DI0_IN or DI0_TEST_IN or BIST_INPUT_SELECT_INT ) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : DI0 = DI0_IN;
      1'b1 : DI0 = DI0_TEST_IN;
      endcase
   end
   // Write data during memory test
   assign #(10.0) DI0_TEST_IN       = DATA_TO_MEM[0];
   // External memory bypass during logic test
   assign DI0_DIN_OBS               = DI0;
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO31                      = (LV_TM & OE_IN) ? DO31_FROM_BYPASS : 1'bz;
   assign DO31_FROM_BYPASS          = DO31_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO31_SCAN_IN                  <= 1'b0;
   else
      DO31_SCAN_IN                  <= DO31_TO_BYPASS;
   end
 
   assign DO31_TO_BYPASS = DI31_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO30                      = (LV_TM & OE_IN) ? DO30_FROM_BYPASS : 1'bz;
   assign DO30_FROM_BYPASS          = DO30_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO30_SCAN_IN                  <= 1'b0;
   else
      DO30_SCAN_IN                  <= DO30_TO_BYPASS;
   end
 
   assign DO30_TO_BYPASS = DI30_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO29                      = (LV_TM & OE_IN) ? DO29_FROM_BYPASS : 1'bz;
   assign DO29_FROM_BYPASS          = DO29_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO29_SCAN_IN                  <= 1'b0;
   else
      DO29_SCAN_IN                  <= DO29_TO_BYPASS;
   end
 
   assign DO29_TO_BYPASS = DI29_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO28                      = (LV_TM & OE_IN) ? DO28_FROM_BYPASS : 1'bz;
   assign DO28_FROM_BYPASS          = DO28_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO28_SCAN_IN                  <= 1'b0;
   else
      DO28_SCAN_IN                  <= DO28_TO_BYPASS;
   end
 
   assign DO28_TO_BYPASS = DI28_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO27                      = (LV_TM & OE_IN) ? DO27_FROM_BYPASS : 1'bz;
   assign DO27_FROM_BYPASS          = DO27_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO27_SCAN_IN                  <= 1'b0;
   else
      DO27_SCAN_IN                  <= DO27_TO_BYPASS;
   end
 
   assign DO27_TO_BYPASS = DI27_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO26                      = (LV_TM & OE_IN) ? DO26_FROM_BYPASS : 1'bz;
   assign DO26_FROM_BYPASS          = DO26_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO26_SCAN_IN                  <= 1'b0;
   else
      DO26_SCAN_IN                  <= DO26_TO_BYPASS;
   end
 
   assign DO26_TO_BYPASS = DI26_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO25                      = (LV_TM & OE_IN) ? DO25_FROM_BYPASS : 1'bz;
   assign DO25_FROM_BYPASS          = DO25_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO25_SCAN_IN                  <= 1'b0;
   else
      DO25_SCAN_IN                  <= DO25_TO_BYPASS;
   end
 
   assign DO25_TO_BYPASS = DI25_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO24                      = (LV_TM & OE_IN) ? DO24_FROM_BYPASS : 1'bz;
   assign DO24_FROM_BYPASS          = DO24_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO24_SCAN_IN                  <= 1'b0;
   else
      DO24_SCAN_IN                  <= DO24_TO_BYPASS;
   end
 
   assign DO24_TO_BYPASS = DI24_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO23                      = (LV_TM & OE_IN) ? DO23_FROM_BYPASS : 1'bz;
   assign DO23_FROM_BYPASS          = DO23_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO23_SCAN_IN                  <= 1'b0;
   else
      DO23_SCAN_IN                  <= DO23_TO_BYPASS;
   end
 
   assign DO23_TO_BYPASS = DI23_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO22                      = (LV_TM & OE_IN) ? DO22_FROM_BYPASS : 1'bz;
   assign DO22_FROM_BYPASS          = DO22_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO22_SCAN_IN                  <= 1'b0;
   else
      DO22_SCAN_IN                  <= DO22_TO_BYPASS;
   end
 
   assign DO22_TO_BYPASS = DI22_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO21                      = (LV_TM & OE_IN) ? DO21_FROM_BYPASS : 1'bz;
   assign DO21_FROM_BYPASS          = DO21_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO21_SCAN_IN                  <= 1'b0;
   else
      DO21_SCAN_IN                  <= DO21_TO_BYPASS;
   end
 
   assign DO21_TO_BYPASS = DI21_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO20                      = (LV_TM & OE_IN) ? DO20_FROM_BYPASS : 1'bz;
   assign DO20_FROM_BYPASS          = DO20_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO20_SCAN_IN                  <= 1'b0;
   else
      DO20_SCAN_IN                  <= DO20_TO_BYPASS;
   end
 
   assign DO20_TO_BYPASS = DI20_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO19                      = (LV_TM & OE_IN) ? DO19_FROM_BYPASS : 1'bz;
   assign DO19_FROM_BYPASS          = DO19_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO19_SCAN_IN                  <= 1'b0;
   else
      DO19_SCAN_IN                  <= DO19_TO_BYPASS;
   end
 
   assign DO19_TO_BYPASS = DI19_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO18                      = (LV_TM & OE_IN) ? DO18_FROM_BYPASS : 1'bz;
   assign DO18_FROM_BYPASS          = DO18_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO18_SCAN_IN                  <= 1'b0;
   else
      DO18_SCAN_IN                  <= DO18_TO_BYPASS;
   end
 
   assign DO18_TO_BYPASS = DI18_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO17                      = (LV_TM & OE_IN) ? DO17_FROM_BYPASS : 1'bz;
   assign DO17_FROM_BYPASS          = DO17_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO17_SCAN_IN                  <= 1'b0;
   else
      DO17_SCAN_IN                  <= DO17_TO_BYPASS;
   end
 
   assign DO17_TO_BYPASS = DI17_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO16                      = (LV_TM & OE_IN) ? DO16_FROM_BYPASS : 1'bz;
   assign DO16_FROM_BYPASS          = DO16_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO16_SCAN_IN                  <= 1'b0;
   else
      DO16_SCAN_IN                  <= DO16_TO_BYPASS;
   end
 
   assign DO16_TO_BYPASS = DI16_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO15                      = (LV_TM & OE_IN) ? DO15_FROM_BYPASS : 1'bz;
   assign DO15_FROM_BYPASS          = DO15_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO15_SCAN_IN                  <= 1'b0;
   else
      DO15_SCAN_IN                  <= DO15_TO_BYPASS;
   end
 
   assign DO15_TO_BYPASS = DI15_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO14                      = (LV_TM & OE_IN) ? DO14_FROM_BYPASS : 1'bz;
   assign DO14_FROM_BYPASS          = DO14_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO14_SCAN_IN                  <= 1'b0;
   else
      DO14_SCAN_IN                  <= DO14_TO_BYPASS;
   end
 
   assign DO14_TO_BYPASS = DI14_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO13                      = (LV_TM & OE_IN) ? DO13_FROM_BYPASS : 1'bz;
   assign DO13_FROM_BYPASS          = DO13_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO13_SCAN_IN                  <= 1'b0;
   else
      DO13_SCAN_IN                  <= DO13_TO_BYPASS;
   end
 
   assign DO13_TO_BYPASS = DI13_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO12                      = (LV_TM & OE_IN) ? DO12_FROM_BYPASS : 1'bz;
   assign DO12_FROM_BYPASS          = DO12_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO12_SCAN_IN                  <= 1'b0;
   else
      DO12_SCAN_IN                  <= DO12_TO_BYPASS;
   end
 
   assign DO12_TO_BYPASS = DI12_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO11                      = (LV_TM & OE_IN) ? DO11_FROM_BYPASS : 1'bz;
   assign DO11_FROM_BYPASS          = DO11_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO11_SCAN_IN                  <= 1'b0;
   else
      DO11_SCAN_IN                  <= DO11_TO_BYPASS;
   end
 
   assign DO11_TO_BYPASS = DI11_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO10                      = (LV_TM & OE_IN) ? DO10_FROM_BYPASS : 1'bz;
   assign DO10_FROM_BYPASS          = DO10_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO10_SCAN_IN                  <= 1'b0;
   else
      DO10_SCAN_IN                  <= DO10_TO_BYPASS;
   end
 
   assign DO10_TO_BYPASS = DI10_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO9                       = (LV_TM & OE_IN) ? DO9_FROM_BYPASS : 1'bz;
   assign DO9_FROM_BYPASS           = DO9_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO9_SCAN_IN                   <= 1'b0;
   else
      DO9_SCAN_IN                   <= DO9_TO_BYPASS;
   end
 
   assign DO9_TO_BYPASS = DI9_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO8                       = (LV_TM & OE_IN) ? DO8_FROM_BYPASS : 1'bz;
   assign DO8_FROM_BYPASS           = DO8_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO8_SCAN_IN                   <= 1'b0;
   else
      DO8_SCAN_IN                   <= DO8_TO_BYPASS;
   end
 
   assign DO8_TO_BYPASS = DI8_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO7                       = (LV_TM & OE_IN) ? DO7_FROM_BYPASS : 1'bz;
   assign DO7_FROM_BYPASS           = DO7_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO7_SCAN_IN                   <= 1'b0;
   else
      DO7_SCAN_IN                   <= DO7_TO_BYPASS;
   end
 
   assign DO7_TO_BYPASS = DI7_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO6                       = (LV_TM & OE_IN) ? DO6_FROM_BYPASS : 1'bz;
   assign DO6_FROM_BYPASS           = DO6_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO6_SCAN_IN                   <= 1'b0;
   else
      DO6_SCAN_IN                   <= DO6_TO_BYPASS;
   end
 
   assign DO6_TO_BYPASS = DI6_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO5                       = (LV_TM & OE_IN) ? DO5_FROM_BYPASS : 1'bz;
   assign DO5_FROM_BYPASS           = DO5_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO5_SCAN_IN                   <= 1'b0;
   else
      DO5_SCAN_IN                   <= DO5_TO_BYPASS;
   end
 
   assign DO5_TO_BYPASS = DI5_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO4                       = (LV_TM & OE_IN) ? DO4_FROM_BYPASS : 1'bz;
   assign DO4_FROM_BYPASS           = DO4_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO4_SCAN_IN                   <= 1'b0;
   else
      DO4_SCAN_IN                   <= DO4_TO_BYPASS;
   end
 
   assign DO4_TO_BYPASS = DI4_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO3                       = (LV_TM & OE_IN) ? DO3_FROM_BYPASS : 1'bz;
   assign DO3_FROM_BYPASS           = DO3_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO3_SCAN_IN                   <= 1'b0;
   else
      DO3_SCAN_IN                   <= DO3_TO_BYPASS;
   end
 
   assign DO3_TO_BYPASS = DI3_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO2                       = (LV_TM & OE_IN) ? DO2_FROM_BYPASS : 1'bz;
   assign DO2_FROM_BYPASS           = DO2_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO2_SCAN_IN                   <= 1'b0;
   else
      DO2_SCAN_IN                   <= DO2_TO_BYPASS;
   end
 
   assign DO2_TO_BYPASS = DI2_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO1                       = (LV_TM & OE_IN) ? DO1_FROM_BYPASS : 1'bz;
   assign DO1_FROM_BYPASS           = DO1_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO1_SCAN_IN                   <= 1'b0;
   else
      DO1_SCAN_IN                   <= DO1_TO_BYPASS;
   end
 
   assign DO1_TO_BYPASS = DI1_DIN_OBS;
 
//-------------------
//-- Memory Bypass --
//-------------------
 
   assign DO0                       = (LV_TM & OE_IN) ? DO0_FROM_BYPASS : 1'bz;
   assign DO0_FROM_BYPASS           = DO0_SCAN_IN;
   // synopsys async_set_reset "BIST_ASYNC_RESETN"
   always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
   if (~BIST_ASYNC_RESETN)
      DO0_SCAN_IN                   <= 1'b0;
   else
      DO0_SCAN_IN                   <= DO0_TO_BYPASS;
   end
 
   assign DO0_TO_BYPASS = DI0_DIN_OBS;
 

//----------------------
//-- Data From Memory --
//----------------------
 
   assign DATA_FROM_MEM             = {
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
                                      };
 

//-----------------------
//-- Shared Comparator --
//-----------------------
 
   assign BIST_DATA_FROM_MEM[31]    = DATA_FROM_MEM[31];
   assign BIST_DATA_FROM_MEM[30]    = DATA_FROM_MEM[30];
   assign BIST_DATA_FROM_MEM[29]    = DATA_FROM_MEM[29];
   assign BIST_DATA_FROM_MEM[28]    = DATA_FROM_MEM[28];
   assign BIST_DATA_FROM_MEM[27]    = DATA_FROM_MEM[27];
   assign BIST_DATA_FROM_MEM[26]    = DATA_FROM_MEM[26];
   assign BIST_DATA_FROM_MEM[25]    = DATA_FROM_MEM[25];
   assign BIST_DATA_FROM_MEM[24]    = DATA_FROM_MEM[24];
   assign BIST_DATA_FROM_MEM[23]    = DATA_FROM_MEM[23];
   assign BIST_DATA_FROM_MEM[22]    = DATA_FROM_MEM[22];
   assign BIST_DATA_FROM_MEM[21]    = DATA_FROM_MEM[21];
   assign BIST_DATA_FROM_MEM[20]    = DATA_FROM_MEM[20];
   assign BIST_DATA_FROM_MEM[19]    = DATA_FROM_MEM[19];
   assign BIST_DATA_FROM_MEM[18]    = DATA_FROM_MEM[18];
   assign BIST_DATA_FROM_MEM[17]    = DATA_FROM_MEM[17];
   assign BIST_DATA_FROM_MEM[16]    = DATA_FROM_MEM[16];
   assign BIST_DATA_FROM_MEM[15]    = DATA_FROM_MEM[15];
   assign BIST_DATA_FROM_MEM[14]    = DATA_FROM_MEM[14];
   assign BIST_DATA_FROM_MEM[13]    = DATA_FROM_MEM[13];
   assign BIST_DATA_FROM_MEM[12]    = DATA_FROM_MEM[12];
   assign BIST_DATA_FROM_MEM[11]    = DATA_FROM_MEM[11];
   assign BIST_DATA_FROM_MEM[10]    = DATA_FROM_MEM[10];
   assign BIST_DATA_FROM_MEM[9]     = DATA_FROM_MEM[9];
   assign BIST_DATA_FROM_MEM[8]     = DATA_FROM_MEM[8];
   assign BIST_DATA_FROM_MEM[7]     = DATA_FROM_MEM[7];
   assign BIST_DATA_FROM_MEM[6]     = DATA_FROM_MEM[6];
   assign BIST_DATA_FROM_MEM[5]     = DATA_FROM_MEM[5];
   assign BIST_DATA_FROM_MEM[4]     = DATA_FROM_MEM[4];
   assign BIST_DATA_FROM_MEM[3]     = DATA_FROM_MEM[3];
   assign BIST_DATA_FROM_MEM[2]     = DATA_FROM_MEM[2];
   assign BIST_DATA_FROM_MEM[1]     = DATA_FROM_MEM[1];
   assign BIST_DATA_FROM_MEM[0]     = DATA_FROM_MEM[0];
  
 
 
 
 
 
endmodule // SMARCHCHKB_LVISION_MEM0_INTERFACE



