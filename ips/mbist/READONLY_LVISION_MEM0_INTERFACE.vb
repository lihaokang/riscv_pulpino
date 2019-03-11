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
-       Created on: Sat Feb 23 20:09:40 CST 2019                                 -
----------------------------------------------------------------------------------


*/
`timescale 100 ps / 10 ps

/*------------------------------------------------------------------------------
     Module      :  READONLY_LVISION_MEM0_INTERFACE
 
     Description :  This module contains the interface logic for the memory
                    module SKAA110_512X32BM1A
 
--------------------------------------------------------------------------------
     Interface Options in Effect
 
     BistDataPipelineStages        : 0;
     BitGrouping                   : 1;
     BitSliceWidth                 : 1;
     ConcurrentWrite               : OFF 
     ConcurrentRead                : OFF 
     ControllerType                : PROG;
     DataOutStage                  : NONE;
     DefaultAlgorithm              : READONLY;
     DefaultOperationSet           : ROM;
     InternalScanLogic             : OFF;
     LocalComparators              : ON;
     MemoryType                    : ROM;
     ObservationLogic              : ON;
     OutputEnableControl           : SYSTEM;
     PipelineSerialDataOut         : OFF;
     ScanWriteThru                 : OFF;
     ShadowRead                    : OFF;
     ShadowWrite                   : OFF;
     Stop-On-Error Limit           : 4096;
     TransparentMode               : NONE;
 
-------------------------------------------------------- (c) Mentor Graphics */

module READONLY_LVISION_MEM0_INTERFACE (
                      CS_IN,
                      CS,
                      OE_IN,
                      OE,
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
                      BIST_CMP,
                      BIST_SELECT,
                      BIST_OUTPUTENABLE,
                      BIST_COL_ADD,
                      BIST_ROW_ADD,
                      BIST_TESTDATA_SELECT_TO_COLLAR,
                      BIST_CLK,
                      BIST_ASYNC_RESETN,                // Asynchronous reset enable (active low)
                      BIST_SHIFT_COLLAR,
                      BIST_SO,
                      BIST_SI,
                      BIST_COLLAR_SETUP,
                      BIST_COLLAR_HOLD,
                      BIST_SETUP0,
                      BIST_CLEAR_DEFAULT,
                      BIST_CLEAR,
                      BIST_GO,
                      LV_TM,
                      TCK_MODE,
                      MBISTPG_COMPARE_MISR        ,
                      BIST_COLLAR_EN,
                      RESET_REG_SETUP2            ,
                      BIST_EN
);


input MBISTPG_COMPARE_MISR;
 
wire [31:0] BIST_PORT0_MISR_Q;
wire [31:0] BIST_PORT0_MISR_QB;
wire [31:0] BIST_PORT0_MISR_SIGNATURE;
reg  MISR_SIGNATURE;
wire MISR_GO_INT;
reg  MISR_GO_R;
input                CS_IN;
output               CS;
input                OE_IN;
output               OE;
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
input                DO31;
input                DO30;
input                DO29;
input                DO28;
input                DO27;
input                DO26;
input                DO25;
input                DO24;
input                DO23;
input                DO22;
input                DO21;
input                DO20;
input                DO19;
input                DO18;
input                DO17;
input                DO16;
input                DO15;
input                DO14;
input                DO13;
input                DO12;
input                DO11;
input                DO10;
input                DO9;
input                DO8;
input                DO7;
input                DO6;
input                DO5;
input                DO4;
input                DO3;
input                DO2;
input                DO1;
input                DO0;
output [2:0]         SCAN_OBS_FLOPS;
input                BIST_CMP;
wire                 CMP_EN;
input                BIST_SELECT;
input                BIST_OUTPUTENABLE;
input  [3:0]         BIST_COL_ADD;
input  [4:0]         BIST_ROW_ADD;
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
input                BIST_SI;
output               BIST_SO;
 
input                BIST_COLLAR_SETUP;
input                BIST_COLLAR_HOLD;
input                BIST_CLEAR_DEFAULT;
input                BIST_CLEAR;
output               BIST_GO;
input                BIST_SETUP0;
input                LV_TM;
input                TCK_MODE;
wire                 BIST_ON;
input                BIST_COLLAR_EN;
wire                 STATUS_SO;
input                RESET_REG_SETUP2;
wire                 BIST_MISR_PORT0_SO;
wire                 BIST_MISR_PORT0_STB;
wire                 BIST_INPUT_SELECT_INT;
wire [0:0] ERROR,ERROR_R;
reg    [2:0]         SCAN_OBS_FLOPS;
wire   [31:0]        DATA_TO_MEM;
wire   [31:0]        DATA_FROM_MEM;
wire   [31:0]        DATA_FROM_MEM_EXP;
wire                 CS_TEST_IN;
reg                  CS_NOT_GATED;
wire                 CS_TO_MUX;
wire                 OE_TEST_IN;
reg                  OE;
wire                 OE_TO_MUX;
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
wire                 DO31;
wire                 DO31_SCAN_IN;
wire                 DO30;
wire                 DO30_SCAN_IN;
wire                 DO29;
wire                 DO29_SCAN_IN;
wire                 DO28;
wire                 DO28_SCAN_IN;
wire                 DO27;
wire                 DO27_SCAN_IN;
wire                 DO26;
wire                 DO26_SCAN_IN;
wire                 DO25;
wire                 DO25_SCAN_IN;
wire                 DO24;
wire                 DO24_SCAN_IN;
wire                 DO23;
wire                 DO23_SCAN_IN;
wire                 DO22;
wire                 DO22_SCAN_IN;
wire                 DO21;
wire                 DO21_SCAN_IN;
wire                 DO20;
wire                 DO20_SCAN_IN;
wire                 DO19;
wire                 DO19_SCAN_IN;
wire                 DO18;
wire                 DO18_SCAN_IN;
wire                 DO17;
wire                 DO17_SCAN_IN;
wire                 DO16;
wire                 DO16_SCAN_IN;
wire                 DO15;
wire                 DO15_SCAN_IN;
wire                 DO14;
wire                 DO14_SCAN_IN;
wire                 DO13;
wire                 DO13_SCAN_IN;
wire                 DO12;
wire                 DO12_SCAN_IN;
wire                 DO11;
wire                 DO11_SCAN_IN;
wire                 DO10;
wire                 DO10_SCAN_IN;
wire                 DO9;
wire                 DO9_SCAN_IN;
wire                 DO8;
wire                 DO8_SCAN_IN;
wire                 DO7;
wire                 DO7_SCAN_IN;
wire                 DO6;
wire                 DO6_SCAN_IN;
wire                 DO5;
wire                 DO5_SCAN_IN;
wire                 DO4;
wire                 DO4_SCAN_IN;
wire                 DO3;
wire                 DO3_SCAN_IN;
wire                 DO2;
wire                 DO2_SCAN_IN;
wire                 DO1;
wire                 DO1_SCAN_IN;
wire                 DO0;
wire                 DO0_SCAN_IN;
wire                 LOGIC_HIGH = 1'b1;
wire                 USE_DEFAULTS;
 
wire                 BIST_COLLAR_HOLD_INT;
reg                  BIST_COLLAR_EN_REG;
wire                 BIST_SETUP0_SYNC;


//---------------------------
// Memory Interface Main Code
//---------------------------
    assign BIST_CLK_INT             = BIST_CLK;
//----------------------
//-- BIST_ON Sync-ing --
//----------------------
    assign BIST_SETUP0_SYNC         = BIST_SETUP0 & BIST_ON;

//-------------------
//-- Collar Enable --
//-------------------
    // synopsys async_set_reset "BIST_ASYNC_RESETN"
    always @ (posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
        if (~BIST_ASYNC_RESETN) begin
            BIST_COLLAR_EN_REG      <= 1'b0;
        end else begin
            BIST_COLLAR_EN_REG      <= BIST_COLLAR_EN;
        end
    end
//----------------------
//-- BIST_EN Retiming --
//----------------------
    assign BIST_EN_RST              = ~BIST_ASYNC_RESETN;
    assign BIST_EN_RETIME1_IN       = BIST_EN;
 
    // Posedge retiming cell for non-TCK mode
    READONLY_LVISION_MBISTPG_RETIMING_CELL MBIST_NTC_RETIMING_CELL ( 
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
      SCAN_OBS_FLOPS    <= 3'b000;
    else
      SCAN_OBS_FLOPS    <= {
                          CS_NOT_GATED         ^ OE                   ^ A8                   ^ A7                   ,
                          A6                   ^ A5                   ^ A4                   ^ A3                   ,
                          A2                   ^ A1                   ^ A0                   
                           };
  end
 
 
 
 
 
 
 

//--------------------------
//-- Memory Control Ports --
//--------------------------

   // Port: CS LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( CS_IN or CS_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : CS_NOT_GATED = CS_IN;
      1'b1 : CS_NOT_GATED = CS_TEST_IN;
      endcase
   end

   // Disable memory port during logic test
   assign CS                        = CS_NOT_GATED & ~LV_TM ;

   // Control logic during memory test
   assign #(10.0) CS_TEST_IN        = (BIST_COLLAR_EN & CS_TO_MUX);
   assign CS_TO_MUX                 = BIST_SELECT;

   // Port: CS }}}

   // Port: OE LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( OE_IN or OE_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : OE = OE_IN;
      1'b1 : OE = OE_TEST_IN;
      endcase
   end

   // Control logic during memory test
   assign #(10.0) OE_TEST_IN        = OE_TO_MUX;
   assign OE_TO_MUX                 = BIST_OUTPUTENABLE;

   // Port: OE }}}

//--------------------------
//-- Memory Address Ports --
//--------------------------

   // Port: A8 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A8_IN or A8_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A8 = A8_IN;
      1'b1 : A8 = A8_TEST_IN;
      endcase
   end
   // Address logic during memory test
   wire   [3:0]                     BIST_COL_ADD_SHADOW_A;
   wire   [4:0]                     BIST_ROW_ADD_SHADOW_A;
   assign BIST_ROW_ADD_SHADOW_A[4] = BIST_ROW_ADD[4];
   assign #(10.0) A8_TEST_IN        = BIST_ROW_ADD_SHADOW_A[4];

   // Port: A8 }}}

   // Port: A7 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A7_IN or A7_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A7 = A7_IN;
      1'b1 : A7 = A7_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[3] = BIST_ROW_ADD[3];
   assign #(10.0) A7_TEST_IN        = BIST_ROW_ADD_SHADOW_A[3];

   // Port: A7 }}}

   // Port: A6 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A6_IN or A6_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A6 = A6_IN;
      1'b1 : A6 = A6_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[2] = BIST_ROW_ADD[2];
   assign #(10.0) A6_TEST_IN        = BIST_ROW_ADD_SHADOW_A[2];

   // Port: A6 }}}

   // Port: A5 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A5_IN or A5_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A5 = A5_IN;
      1'b1 : A5 = A5_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[1] = BIST_ROW_ADD[1];
   assign #(10.0) A5_TEST_IN        = BIST_ROW_ADD_SHADOW_A[1];

   // Port: A5 }}}

   // Port: A4 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A4_IN or A4_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A4 = A4_IN;
      1'b1 : A4 = A4_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_ROW_ADD_SHADOW_A[0] = BIST_ROW_ADD[0];
   assign #(10.0) A4_TEST_IN        = BIST_ROW_ADD_SHADOW_A[0];

   // Port: A4 }}}

   // Port: A3 LogicalPort: A Type: READ {{{

   // Intercept functional signal with test mux
   always @( A3_IN or A3_TEST_IN or BIST_INPUT_SELECT_INT) begin
      case (BIST_INPUT_SELECT_INT) // synopsys infer_mux
      1'b0 : A3 = A3_IN;
      1'b1 : A3 = A3_TEST_IN;
      endcase
   end
   // Address logic during memory test
   assign BIST_COL_ADD_SHADOW_A[3] = BIST_COL_ADD[3];
   assign #(10.0) A3_TEST_IN        = BIST_COL_ADD_SHADOW_A[3];

   // Port: A3 }}}

   // Port: A2 LogicalPort: A Type: READ {{{

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

   // Port: A1 LogicalPort: A Type: READ {{{

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

   // Port: A0 LogicalPort: A Type: READ {{{

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
 
assign CMP_EN = BIST_CMP;
  
 
 
wire CLEAR_MISR;
wire COMPARE_MISR;
 
assign BIST_MISR_PORT0_STB = BIST_CMP;
 
assign CLEAR_MISR = BIST_CLEAR;
 
assign COMPARE_MISR = MBISTPG_COMPARE_MISR & BIST_COLLAR_EN_REG;
 
READONLY_LVISION_MEM0_INTERFACE_MISR MBISTPG_PORT0_MISR (
        .DOUT              ( DATA_FROM_MEM        ) ,
        .BIST_CLK          ( BIST_CLK_INT         ) ,
        .BIST_SHIFT        ( BIST_SHIFT_COLLAR    ) ,
        .BIST_HOLD         ( BIST_COLLAR_HOLD_INT ) ,
        .BIST_ON           ( BIST_ON              ) ,
        .BIST_SI           ( BIST_SI         ) , 
        .BIST_MISR_STB     ( BIST_MISR_PORT0_STB ) ,
        .BIST_COLLAR_EN    ( BIST_COLLAR_EN   ) , 
        .BIST_CLEAR        ( CLEAR_MISR           ) ,
        .MISR_Q            ( BIST_PORT0_MISR_Q  ) ,
        .MISR_QB           ( BIST_PORT0_MISR_QB ) ,
        .BIST_ASYNC_RESETN ( BIST_ASYNC_RESETN    ),
        .BIST_SO           ( BIST_MISR_PORT0_SO ) 
);
 
READONLY_LVISION_MEM0_INTERFACE_MISR_STRAP MEM0_PORT0_MISR_STRAP (
        .MISR_IN            ( BIST_PORT0_MISR_Q              ) ,
        .MISR_INB           ( BIST_PORT0_MISR_QB             ) ,
        .MISR_SIGNATURE     ( BIST_PORT0_MISR_SIGNATURE      )
);
 
always @( COMPARE_MISR or MISR_GO_R or BIST_PORT0_MISR_SIGNATURE ) begin
    if ( MISR_GO_R ) begin
        if ( COMPARE_MISR ) begin
            MISR_SIGNATURE = MISR_GO_R & (&BIST_PORT0_MISR_SIGNATURE);
        end else begin
            MISR_SIGNATURE = MISR_GO_R ;
        end
    end else begin
        MISR_SIGNATURE = 1'b0;
    end
end
assign MISR_GO_INT = COMPARE_MISR ? MISR_SIGNATURE : MISR_GO_R;
 
always @(posedge BIST_CLK_INT or negedge BIST_ASYNC_RESETN) begin
    if ( ~ BIST_ASYNC_RESETN ) 
        MISR_GO_R <= 1'b0;
    else
    if ( CLEAR_MISR ) 
        MISR_GO_R <= 1'b1;
    else 
        MISR_GO_R <= BIST_ON & MISR_GO_R & MISR_GO_INT; 
end
 
assign BIST_GO = MISR_GO_R;
 
assign STATUS_SO = BIST_MISR_PORT0_SO;
    
assign BIST_SO                      = STATUS_SO;
 
 
 
endmodule // READONLY_LVISION_MEM0_INTERFACE



module READONLY_LVISION_MEM0_INTERFACE_MISR (
    DOUT,
    BIST_CLK,
    BIST_SHIFT,
    BIST_HOLD,
    BIST_SI,
    BIST_MISR_STB,
    BIST_COLLAR_EN,
    BIST_CLEAR,
    BIST_ON,
    MISR_Q,
    MISR_QB,
    BIST_ASYNC_RESETN,
    BIST_SO
    );
input BIST_CLK;
input BIST_SHIFT;
input BIST_HOLD;
input BIST_ON;
input BIST_SI;
input BIST_MISR_STB;
input BIST_COLLAR_EN;
input BIST_CLEAR;
input BIST_ASYNC_RESETN;
input [31:0] DOUT;
output BIST_SO;
output [31:0] MISR_Q;
output [31:0] MISR_QB;
wire CAPTURE_MISR;
reg [31:0] MISR_SEG0;
reg [31:0] MISR_SEG0_INT;
 
assign MISR_Q = {
                MISR_SEG0[31:0]
                };
assign MISR_QB = ~MISR_Q;
 
assign CAPTURE_MISR = BIST_MISR_STB & BIST_COLLAR_EN;
 
 
always @(DOUT or CAPTURE_MISR or MISR_SEG0 ) begin
    if (CAPTURE_MISR) begin
        MISR_SEG0_INT[0]            = DOUT[0] ^ MISR_SEG0[31];
        MISR_SEG0_INT[1]            = DOUT[1] ^ MISR_SEG0[0] ^ MISR_SEG0[31]; 
        MISR_SEG0_INT[2]            = DOUT[2] ^ MISR_SEG0[1]; 
        MISR_SEG0_INT[3]            = DOUT[3] ^ MISR_SEG0[2]; 
        MISR_SEG0_INT[4]            = DOUT[4] ^ MISR_SEG0[3]; 
        MISR_SEG0_INT[5]            = DOUT[5] ^ MISR_SEG0[4]; 
        MISR_SEG0_INT[6]            = DOUT[6] ^ MISR_SEG0[5]; 
        MISR_SEG0_INT[7]            = DOUT[7] ^ MISR_SEG0[6]; 
        MISR_SEG0_INT[8]            = DOUT[8] ^ MISR_SEG0[7]; 
        MISR_SEG0_INT[9]            = DOUT[9] ^ MISR_SEG0[8]; 
        MISR_SEG0_INT[10]           = DOUT[10] ^ MISR_SEG0[9]; 
        MISR_SEG0_INT[11]           = DOUT[11] ^ MISR_SEG0[10]; 
        MISR_SEG0_INT[12]           = DOUT[12] ^ MISR_SEG0[11]; 
        MISR_SEG0_INT[13]           = DOUT[13] ^ MISR_SEG0[12]; 
        MISR_SEG0_INT[14]           = DOUT[14] ^ MISR_SEG0[13]; 
        MISR_SEG0_INT[15]           = DOUT[15] ^ MISR_SEG0[14]; 
        MISR_SEG0_INT[16]           = DOUT[16] ^ MISR_SEG0[15]; 
        MISR_SEG0_INT[17]           = DOUT[17] ^ MISR_SEG0[16]; 
        MISR_SEG0_INT[18]           = DOUT[18] ^ MISR_SEG0[17]; 
        MISR_SEG0_INT[19]           = DOUT[19] ^ MISR_SEG0[18]; 
        MISR_SEG0_INT[20]           = DOUT[20] ^ MISR_SEG0[19]; 
        MISR_SEG0_INT[21]           = DOUT[21] ^ MISR_SEG0[20]; 
        MISR_SEG0_INT[22]           = DOUT[22] ^ MISR_SEG0[21]; 
        MISR_SEG0_INT[23]           = DOUT[23] ^ MISR_SEG0[22]; 
        MISR_SEG0_INT[24]           = DOUT[24] ^ MISR_SEG0[23]; 
        MISR_SEG0_INT[25]           = DOUT[25] ^ MISR_SEG0[24]; 
        MISR_SEG0_INT[26]           = DOUT[26] ^ MISR_SEG0[25]; 
        MISR_SEG0_INT[27]           = DOUT[27] ^ MISR_SEG0[26] ^ MISR_SEG0[31]; 
        MISR_SEG0_INT[28]           = DOUT[28] ^ MISR_SEG0[27] ^ MISR_SEG0[31]; 
        MISR_SEG0_INT[29]           = DOUT[29] ^ MISR_SEG0[28]; 
        MISR_SEG0_INT[30]           = DOUT[30] ^ MISR_SEG0[29]; 
        MISR_SEG0_INT[31]           = DOUT[31] ^ MISR_SEG0[30]; 
    end else begin
        MISR_SEG0_INT = MISR_SEG0; 
    end
end
 
// synopsys sync_set_reset "BIST_CLEAR"
// synopsys async_set_reset "BIST_ASYNC_RESETN"
always @(posedge BIST_CLK or negedge BIST_ASYNC_RESETN) begin
  if ( ~ BIST_ASYNC_RESETN ) begin
      MISR_SEG0 <= 32'd0;
  end else begin
    if ( BIST_SHIFT ) begin
        MISR_SEG0 <= {BIST_SI, MISR_SEG0[31:1]};
    end else begin
        if ( BIST_CLEAR ) begin
            MISR_SEG0 <= 32'b00000000000000000000000000000000;
        end else begin
            if ( ~BIST_HOLD & BIST_COLLAR_EN ) begin
                MISR_SEG0 <= MISR_SEG0_INT;
            end
        end
    end
  end
end
 
assign BIST_SO = MISR_SEG0[0];
 
endmodule // READONLY_LVISION_MEM0_INTERFACE_MISR


