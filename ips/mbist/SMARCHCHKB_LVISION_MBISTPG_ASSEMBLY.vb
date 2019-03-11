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
-       Created on: Fri Feb 22 16:55:45 CST 2019                                 -
----------------------------------------------------------------------------------


*/
module SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY (
    BIST_CLK,
    MEM0_CSB,
    MEM0_OE,
    MEM0_WEB3,
    MEM0_WEB2,
    MEM0_WEB1,
    MEM0_WEB0,
    MEM0_DVS3,
    MEM0_DVS2,
    MEM0_DVS1,
    MEM0_DVS0,
    MEM0_DVSE,
    MEM0_A11,
    MEM0_A10,
    MEM0_A9,
    MEM0_A8,
    MEM0_A7,
    MEM0_A6,
    MEM0_A5,
    MEM0_A4,
    MEM0_A3,
    MEM0_A2,
    MEM0_A1,
    MEM0_A0,
    MEM0_DI31,
    MEM0_DI30,
    MEM0_DI29,
    MEM0_DI28,
    MEM0_DI27,
    MEM0_DI26,
    MEM0_DI25,
    MEM0_DI24,
    MEM0_DI23,
    MEM0_DI22,
    MEM0_DI21,
    MEM0_DI20,
    MEM0_DI19,
    MEM0_DI18,
    MEM0_DI17,
    MEM0_DI16,
    MEM0_DI15,
    MEM0_DI14,
    MEM0_DI13,
    MEM0_DI12,
    MEM0_DI11,
    MEM0_DI10,
    MEM0_DI9,
    MEM0_DI8,
    MEM0_DI7,
    MEM0_DI6,
    MEM0_DI5,
    MEM0_DI4,
    MEM0_DI3,
    MEM0_DI2,
    MEM0_DI1,
    MEM0_DI0,
    MEM0_DO31,
    MEM0_DO30,
    MEM0_DO29,
    MEM0_DO28,
    MEM0_DO27,
    MEM0_DO26,
    MEM0_DO25,
    MEM0_DO24,
    MEM0_DO23,
    MEM0_DO22,
    MEM0_DO21,
    MEM0_DO20,
    MEM0_DO19,
    MEM0_DO18,
    MEM0_DO17,
    MEM0_DO16,
    MEM0_DO15,
    MEM0_DO14,
    MEM0_DO13,
    MEM0_DO12,
    MEM0_DO11,
    MEM0_DO10,
    MEM0_DO9,
    MEM0_DO8,
    MEM0_DO7,
    MEM0_DO6,
    MEM0_DO5,
    MEM0_DO4,
    MEM0_DO3,
    MEM0_DO2,
    MEM0_DO1,
    MEM0_DO0,
    MEM1_CSB,
    MEM1_OE,
    MEM1_WEB3,
    MEM1_WEB2,
    MEM1_WEB1,
    MEM1_WEB0,
    MEM1_DVS3,
    MEM1_DVS2,
    MEM1_DVS1,
    MEM1_DVS0,
    MEM1_DVSE,
    MEM1_A12,
    MEM1_A11,
    MEM1_A10,
    MEM1_A9,
    MEM1_A8,
    MEM1_A7,
    MEM1_A6,
    MEM1_A5,
    MEM1_A4,
    MEM1_A3,
    MEM1_A2,
    MEM1_A1,
    MEM1_A0,
    MEM1_DI31,
    MEM1_DI30,
    MEM1_DI29,
    MEM1_DI28,
    MEM1_DI27,
    MEM1_DI26,
    MEM1_DI25,
    MEM1_DI24,
    MEM1_DI23,
    MEM1_DI22,
    MEM1_DI21,
    MEM1_DI20,
    MEM1_DI19,
    MEM1_DI18,
    MEM1_DI17,
    MEM1_DI16,
    MEM1_DI15,
    MEM1_DI14,
    MEM1_DI13,
    MEM1_DI12,
    MEM1_DI11,
    MEM1_DI10,
    MEM1_DI9,
    MEM1_DI8,
    MEM1_DI7,
    MEM1_DI6,
    MEM1_DI5,
    MEM1_DI4,
    MEM1_DI3,
    MEM1_DI2,
    MEM1_DI1,
    MEM1_DI0,
    MEM1_DO31,
    MEM1_DO30,
    MEM1_DO29,
    MEM1_DO28,
    MEM1_DO27,
    MEM1_DO26,
    MEM1_DO25,
    MEM1_DO24,
    MEM1_DO23,
    MEM1_DO22,
    MEM1_DO21,
    MEM1_DO20,
    MEM1_DO19,
    MEM1_DO18,
    MEM1_DO17,
    MEM1_DO16,
    MEM1_DO15,
    MEM1_DO14,
    MEM1_DO13,
    MEM1_DO12,
    MEM1_DO11,
    MEM1_DO10,
    MEM1_DO9,
    MEM1_DO8,
    MEM1_DO7,
    MEM1_DO6,
    MEM1_DO5,
    MEM1_DO4,
    MEM1_DO3,
    MEM1_DO2,
    MEM1_DO1,
    MEM1_DO0
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
input           MEM0_CSB;
input           MEM0_OE;
input           MEM0_WEB3;
input           MEM0_WEB2;
input           MEM0_WEB1;
input           MEM0_WEB0;
input           MEM0_DVS3;
input           MEM0_DVS2;
input           MEM0_DVS1;
input           MEM0_DVS0;
input           MEM0_DVSE;
input           MEM0_A11;
input           MEM0_A10;
input           MEM0_A9;
input           MEM0_A8;
input           MEM0_A7;
input           MEM0_A6;
input           MEM0_A5;
input           MEM0_A4;
input           MEM0_A3;
input           MEM0_A2;
input           MEM0_A1;
input           MEM0_A0;
input           MEM0_DI31;
input           MEM0_DI30;
input           MEM0_DI29;
input           MEM0_DI28;
input           MEM0_DI27;
input           MEM0_DI26;
input           MEM0_DI25;
input           MEM0_DI24;
input           MEM0_DI23;
input           MEM0_DI22;
input           MEM0_DI21;
input           MEM0_DI20;
input           MEM0_DI19;
input           MEM0_DI18;
input           MEM0_DI17;
input           MEM0_DI16;
input           MEM0_DI15;
input           MEM0_DI14;
input           MEM0_DI13;
input           MEM0_DI12;
input           MEM0_DI11;
input           MEM0_DI10;
input           MEM0_DI9;
input           MEM0_DI8;
input           MEM0_DI7;
input           MEM0_DI6;
input           MEM0_DI5;
input           MEM0_DI4;
input           MEM0_DI3;
input           MEM0_DI2;
input           MEM0_DI1;
input           MEM0_DI0;
output          MEM0_DO31;
output          MEM0_DO30;
output          MEM0_DO29;
output          MEM0_DO28;
output          MEM0_DO27;
output          MEM0_DO26;
output          MEM0_DO25;
output          MEM0_DO24;
output          MEM0_DO23;
output          MEM0_DO22;
output          MEM0_DO21;
output          MEM0_DO20;
output          MEM0_DO19;
output          MEM0_DO18;
output          MEM0_DO17;
output          MEM0_DO16;
output          MEM0_DO15;
output          MEM0_DO14;
output          MEM0_DO13;
output          MEM0_DO12;
output          MEM0_DO11;
output          MEM0_DO10;
output          MEM0_DO9;
output          MEM0_DO8;
output          MEM0_DO7;
output          MEM0_DO6;
output          MEM0_DO5;
output          MEM0_DO4;
output          MEM0_DO3;
output          MEM0_DO2;
output          MEM0_DO1;
output          MEM0_DO0;
input           MEM1_CSB;
input           MEM1_OE;
input           MEM1_WEB3;
input           MEM1_WEB2;
input           MEM1_WEB1;
input           MEM1_WEB0;
input           MEM1_DVS3;
input           MEM1_DVS2;
input           MEM1_DVS1;
input           MEM1_DVS0;
input           MEM1_DVSE;
input           MEM1_A12;
input           MEM1_A11;
input           MEM1_A10;
input           MEM1_A9;
input           MEM1_A8;
input           MEM1_A7;
input           MEM1_A6;
input           MEM1_A5;
input           MEM1_A4;
input           MEM1_A3;
input           MEM1_A2;
input           MEM1_A1;
input           MEM1_A0;
input           MEM1_DI31;
input           MEM1_DI30;
input           MEM1_DI29;
input           MEM1_DI28;
input           MEM1_DI27;
input           MEM1_DI26;
input           MEM1_DI25;
input           MEM1_DI24;
input           MEM1_DI23;
input           MEM1_DI22;
input           MEM1_DI21;
input           MEM1_DI20;
input           MEM1_DI19;
input           MEM1_DI18;
input           MEM1_DI17;
input           MEM1_DI16;
input           MEM1_DI15;
input           MEM1_DI14;
input           MEM1_DI13;
input           MEM1_DI12;
input           MEM1_DI11;
input           MEM1_DI10;
input           MEM1_DI9;
input           MEM1_DI8;
input           MEM1_DI7;
input           MEM1_DI6;
input           MEM1_DI5;
input           MEM1_DI4;
input           MEM1_DI3;
input           MEM1_DI2;
input           MEM1_DI1;
input           MEM1_DI0;
output          MEM1_DO31;
output          MEM1_DO30;
output          MEM1_DO29;
output          MEM1_DO28;
output          MEM1_DO27;
output          MEM1_DO26;
output          MEM1_DO25;
output          MEM1_DO24;
output          MEM1_DO23;
output          MEM1_DO22;
output          MEM1_DO21;
output          MEM1_DO20;
output          MEM1_DO19;
output          MEM1_DO18;
output          MEM1_DO17;
output          MEM1_DO16;
output          MEM1_DO15;
output          MEM1_DO14;
output          MEM1_DO13;
output          MEM1_DO12;
output          MEM1_DO11;
output          MEM1_DO10;
output          MEM1_DO9;
output          MEM1_DO8;
output          MEM1_DO7;
output          MEM1_DO6;
output          MEM1_DO5;
output          MEM1_DO4;
output          MEM1_DO3;
output          MEM1_DO2;
output          MEM1_DO1;
output          MEM1_DO0;
// [start] : AUT Instance 
SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST (
    .MEM0_CK    ( BIST_CLK  ),
    .MEM0_CSB   ( MEM0_CSB  ),
    .MEM0_OE    ( MEM0_OE  ),
    .MEM0_WEB3  ( MEM0_WEB3  ),
    .MEM0_WEB2  ( MEM0_WEB2  ),
    .MEM0_WEB1  ( MEM0_WEB1  ),
    .MEM0_WEB0  ( MEM0_WEB0  ),
    .MEM0_DVS3  ( MEM0_DVS3  ),
    .MEM0_DVS2  ( MEM0_DVS2  ),
    .MEM0_DVS1  ( MEM0_DVS1  ),
    .MEM0_DVS0  ( MEM0_DVS0  ),
    .MEM0_DVSE  ( MEM0_DVSE  ),
    .MEM0_A11   ( MEM0_A11  ),
    .MEM0_A10   ( MEM0_A10  ),
    .MEM0_A9    ( MEM0_A9  ),
    .MEM0_A8    ( MEM0_A8  ),
    .MEM0_A7    ( MEM0_A7  ),
    .MEM0_A6    ( MEM0_A6  ),
    .MEM0_A5    ( MEM0_A5  ),
    .MEM0_A4    ( MEM0_A4  ),
    .MEM0_A3    ( MEM0_A3  ),
    .MEM0_A2    ( MEM0_A2  ),
    .MEM0_A1    ( MEM0_A1  ),
    .MEM0_A0    ( MEM0_A0  ),
    .MEM0_DI31  ( MEM0_DI31  ),
    .MEM0_DI30  ( MEM0_DI30  ),
    .MEM0_DI29  ( MEM0_DI29  ),
    .MEM0_DI28  ( MEM0_DI28  ),
    .MEM0_DI27  ( MEM0_DI27  ),
    .MEM0_DI26  ( MEM0_DI26  ),
    .MEM0_DI25  ( MEM0_DI25  ),
    .MEM0_DI24  ( MEM0_DI24  ),
    .MEM0_DI23  ( MEM0_DI23  ),
    .MEM0_DI22  ( MEM0_DI22  ),
    .MEM0_DI21  ( MEM0_DI21  ),
    .MEM0_DI20  ( MEM0_DI20  ),
    .MEM0_DI19  ( MEM0_DI19  ),
    .MEM0_DI18  ( MEM0_DI18  ),
    .MEM0_DI17  ( MEM0_DI17  ),
    .MEM0_DI16  ( MEM0_DI16  ),
    .MEM0_DI15  ( MEM0_DI15  ),
    .MEM0_DI14  ( MEM0_DI14  ),
    .MEM0_DI13  ( MEM0_DI13  ),
    .MEM0_DI12  ( MEM0_DI12  ),
    .MEM0_DI11  ( MEM0_DI11  ),
    .MEM0_DI10  ( MEM0_DI10  ),
    .MEM0_DI9   ( MEM0_DI9  ),
    .MEM0_DI8   ( MEM0_DI8  ),
    .MEM0_DI7   ( MEM0_DI7  ),
    .MEM0_DI6   ( MEM0_DI6  ),
    .MEM0_DI5   ( MEM0_DI5  ),
    .MEM0_DI4   ( MEM0_DI4  ),
    .MEM0_DI3   ( MEM0_DI3  ),
    .MEM0_DI2   ( MEM0_DI2  ),
    .MEM0_DI1   ( MEM0_DI1  ),
    .MEM0_DI0   ( MEM0_DI0  ),
    .MEM0_DO31  ( MEM0_DO31  ),
    .MEM0_DO30  ( MEM0_DO30  ),
    .MEM0_DO29  ( MEM0_DO29  ),
    .MEM0_DO28  ( MEM0_DO28  ),
    .MEM0_DO27  ( MEM0_DO27  ),
    .MEM0_DO26  ( MEM0_DO26  ),
    .MEM0_DO25  ( MEM0_DO25  ),
    .MEM0_DO24  ( MEM0_DO24  ),
    .MEM0_DO23  ( MEM0_DO23  ),
    .MEM0_DO22  ( MEM0_DO22  ),
    .MEM0_DO21  ( MEM0_DO21  ),
    .MEM0_DO20  ( MEM0_DO20  ),
    .MEM0_DO19  ( MEM0_DO19  ),
    .MEM0_DO18  ( MEM0_DO18  ),
    .MEM0_DO17  ( MEM0_DO17  ),
    .MEM0_DO16  ( MEM0_DO16  ),
    .MEM0_DO15  ( MEM0_DO15  ),
    .MEM0_DO14  ( MEM0_DO14  ),
    .MEM0_DO13  ( MEM0_DO13  ),
    .MEM0_DO12  ( MEM0_DO12  ),
    .MEM0_DO11  ( MEM0_DO11  ),
    .MEM0_DO10  ( MEM0_DO10  ),
    .MEM0_DO9   ( MEM0_DO9  ),
    .MEM0_DO8   ( MEM0_DO8  ),
    .MEM0_DO7   ( MEM0_DO7  ),
    .MEM0_DO6   ( MEM0_DO6  ),
    .MEM0_DO5   ( MEM0_DO5  ),
    .MEM0_DO4   ( MEM0_DO4  ),
    .MEM0_DO3   ( MEM0_DO3  ),
    .MEM0_DO2   ( MEM0_DO2  ),
    .MEM0_DO1   ( MEM0_DO1  ),
    .MEM0_DO0   ( MEM0_DO0  ),
    .MEM1_CK    ( BIST_CLK  ),
    .MEM1_CSB   ( MEM1_CSB  ),
    .MEM1_OE    ( MEM1_OE  ),
    .MEM1_WEB3  ( MEM1_WEB3  ),
    .MEM1_WEB2  ( MEM1_WEB2  ),
    .MEM1_WEB1  ( MEM1_WEB1  ),
    .MEM1_WEB0  ( MEM1_WEB0  ),
    .MEM1_DVS3  ( MEM1_DVS3  ),
    .MEM1_DVS2  ( MEM1_DVS2  ),
    .MEM1_DVS1  ( MEM1_DVS1  ),
    .MEM1_DVS0  ( MEM1_DVS0  ),
    .MEM1_DVSE  ( MEM1_DVSE  ),
    .MEM1_A12   ( MEM1_A12  ),
    .MEM1_A11   ( MEM1_A11  ),
    .MEM1_A10   ( MEM1_A10  ),
    .MEM1_A9    ( MEM1_A9  ),
    .MEM1_A8    ( MEM1_A8  ),
    .MEM1_A7    ( MEM1_A7  ),
    .MEM1_A6    ( MEM1_A6  ),
    .MEM1_A5    ( MEM1_A5  ),
    .MEM1_A4    ( MEM1_A4  ),
    .MEM1_A3    ( MEM1_A3  ),
    .MEM1_A2    ( MEM1_A2  ),
    .MEM1_A1    ( MEM1_A1  ),
    .MEM1_A0    ( MEM1_A0  ),
    .MEM1_DI31  ( MEM1_DI31  ),
    .MEM1_DI30  ( MEM1_DI30  ),
    .MEM1_DI29  ( MEM1_DI29  ),
    .MEM1_DI28  ( MEM1_DI28  ),
    .MEM1_DI27  ( MEM1_DI27  ),
    .MEM1_DI26  ( MEM1_DI26  ),
    .MEM1_DI25  ( MEM1_DI25  ),
    .MEM1_DI24  ( MEM1_DI24  ),
    .MEM1_DI23  ( MEM1_DI23  ),
    .MEM1_DI22  ( MEM1_DI22  ),
    .MEM1_DI21  ( MEM1_DI21  ),
    .MEM1_DI20  ( MEM1_DI20  ),
    .MEM1_DI19  ( MEM1_DI19  ),
    .MEM1_DI18  ( MEM1_DI18  ),
    .MEM1_DI17  ( MEM1_DI17  ),
    .MEM1_DI16  ( MEM1_DI16  ),
    .MEM1_DI15  ( MEM1_DI15  ),
    .MEM1_DI14  ( MEM1_DI14  ),
    .MEM1_DI13  ( MEM1_DI13  ),
    .MEM1_DI12  ( MEM1_DI12  ),
    .MEM1_DI11  ( MEM1_DI11  ),
    .MEM1_DI10  ( MEM1_DI10  ),
    .MEM1_DI9   ( MEM1_DI9  ),
    .MEM1_DI8   ( MEM1_DI8  ),
    .MEM1_DI7   ( MEM1_DI7  ),
    .MEM1_DI6   ( MEM1_DI6  ),
    .MEM1_DI5   ( MEM1_DI5  ),
    .MEM1_DI4   ( MEM1_DI4  ),
    .MEM1_DI3   ( MEM1_DI3  ),
    .MEM1_DI2   ( MEM1_DI2  ),
    .MEM1_DI1   ( MEM1_DI1  ),
    .MEM1_DI0   ( MEM1_DI0  ),
    .MEM1_DO31  ( MEM1_DO31  ),
    .MEM1_DO30  ( MEM1_DO30  ),
    .MEM1_DO29  ( MEM1_DO29  ),
    .MEM1_DO28  ( MEM1_DO28  ),
    .MEM1_DO27  ( MEM1_DO27  ),
    .MEM1_DO26  ( MEM1_DO26  ),
    .MEM1_DO25  ( MEM1_DO25  ),
    .MEM1_DO24  ( MEM1_DO24  ),
    .MEM1_DO23  ( MEM1_DO23  ),
    .MEM1_DO22  ( MEM1_DO22  ),
    .MEM1_DO21  ( MEM1_DO21  ),
    .MEM1_DO20  ( MEM1_DO20  ),
    .MEM1_DO19  ( MEM1_DO19  ),
    .MEM1_DO18  ( MEM1_DO18  ),
    .MEM1_DO17  ( MEM1_DO17  ),
    .MEM1_DO16  ( MEM1_DO16  ),
    .MEM1_DO15  ( MEM1_DO15  ),
    .MEM1_DO14  ( MEM1_DO14  ),
    .MEM1_DO13  ( MEM1_DO13  ),
    .MEM1_DO12  ( MEM1_DO12  ),
    .MEM1_DO11  ( MEM1_DO11  ),
    .MEM1_DO10  ( MEM1_DO10  ),
    .MEM1_DO9   ( MEM1_DO9  ),
    .MEM1_DO8   ( MEM1_DO8  ),
    .MEM1_DO7   ( MEM1_DO7  ),
    .MEM1_DO6   ( MEM1_DO6  ),
    .MEM1_DO5   ( MEM1_DO5  ),
    .MEM1_DO4   ( MEM1_DO4  ),
    .MEM1_DO3   ( MEM1_DO3  ),
    .MEM1_DO2   ( MEM1_DO2  ),
    .MEM1_DO1   ( MEM1_DO1  ),
    .MEM1_DO0   ( MEM1_DO0  )
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
  `define mem1InstPathStp1                    SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM1_MEM_INST  
  `define mem1InstPath                        SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM1_MEM_INST  
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
  `define ALGO_DONE                           `controllerInstPath.ALGO_DONE
  `define STEP_COUNTER                        `controllerInstPath.MBISTPG_STEP_COUNTER.STEP_COUNTER
  `define LAST_STEP                           `controllerInstPath.MBISTPG_STEP_COUNTER.LAST_STEP
  `define NEXT_STEP                           `controllerInstPath.MBISTPG_STEP_COUNTER.NEXT_STEP
  `define LAST_PORT                           1'b1
  `define INST_POINTER                        `controllerInstPath.MBISTPG_POINTER_CNTRL.INST_POINTER
  `define LOOP_A_CNTR                         `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.LOOP_A_CNTR
  `define LOOP_B_CNTR                         `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.LOOP_B_CNTR
  `define CNTR_A_MAX                          `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.CNTR_A_MAX
  `define CNTR_B_MAX                          `controllerInstPath.MBISTPG_REPEAT_LOOP_CNTRL.CNTR_B_MAX
  `define BIST_COLLAR_EN0                     `controllerInstPath.BIST_COLLAR_EN0
  `define CMP_EN0                             `controllerInstPath.BIST_CMP
  `define BIST_COLLAR_EN1                     `controllerInstPath.BIST_COLLAR_EN1
  `define CMP_EN1                             `controllerInstPath.BIST_CMP
  // Controller signals 
 
  // Internal signals 
  integer addMapFile;                         // Address mapping output file
  integer stepEnable0;                        // Step 0 started flag
  integer algoCycleCount0;                    // Step 0 algorithm cycle count
  integer compareCount0;                      // Step 0 compare count
  integer algoCycleCount0_subtotal;           // Step 0 algorithm cycle count after adjustment
  integer compareCount0_subtotal;             // Step 0 compare count after adjustment
  integer stepEnable1;                        // Step 1 started flag
  integer algoCycleCount1;                    // Step 1 algorithm cycle count
  integer compareCount1;                      // Step 1 compare count
  integer algoCycleCount1_subtotal;           // Step 1 algorithm cycle count after adjustment
  integer compareCount1_subtotal;             // Step 1 compare count after adjustment
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
    stepEnable1 = 0;
    algoCycleCount1 = 0;
    compareCount1 = 0;
    algoCycleCount1_subtotal = 0;
    compareCount1_subtotal = 0;
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

//--------------------
//--  Step 1  --
//--------------------
// Step 1 
always @ (posedge `BIST_CLK) begin
  if (`BIST_EN) begin
    if (stepEnable1 == 0) begin
      if (`BIST_COLLAR_EN1 && `SETUP_PULSE2) begin // Next cycle is RUN state
        stepEnable1 = 1;
        $display("[[");
        $display("[[ Starting memory signal dump for Step 1 Test Port 0 of Controller SMARCHCHKB");
        $display("[[");
    
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// Starting address signal dump for Step 1 Test Port 0 of Controller SMARCHCHKB\n");
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// MemoryID   : %s\n", "MEM1 (SHAA110_8192X8X4CM8)");
        $fwrite(addMapFile,"// MemoryType : %s\n", "SRAM");
        $fwrite(addMapFile,"// Address    : %s\n", "A12 A11 A10 A9 A8 A7 A6 A5 A4 A3 A2 A1 A0");
        $fwrite(addMapFile,"// Data       : %s\n", "DI31 DI30 DI29 DI28 DI27 DI26 DI25 DI24 DI23 DI22 DI21 DI20 DI19 DI18 DI17 DI16 DI15 DI14 DI13 DI12 DI11 DI10 DI9 DI8 DI7 DI6 DI5 DI4 DI3 DI2 DI1 DI0");
        $fwrite(addMapFile,"// Algorithm  : %s\n", "SMARCHCHKB");
        $fwrite(addMapFile,"// Phase      : %s\n", "5.0");
        $fwrite(addMapFile,"//\n");
        $fwrite(addMapFile,"// Bank Row Column | Address | Data \n");
        $fwrite(addMapFile,"//\n");

      end
    end else begin
      if (`ALGO_DONE && `LAST_PORT) begin // Step 1 algorithm done
        stepEnable1 = 0;
        // Adjust step total
        algoCycleCount1_subtotal  = algoCycleCount1;
        compareCount1_subtotal    = compareCount1;
        // Update overall total
        algoCycleCount_total    = algoCycleCount_total + algoCycleCount1_subtotal;
        compareCount_total      = compareCount_total + compareCount1_subtotal;
 
        $display("[[");
        $display("[[ Summary for Controller SMARCHCHKB");
        $display("[[");
        $display("[[ Step 0 Number of Algorithm Cycles = %d", algoCycleCount0_subtotal);
        $display("[[ Step 0 Number of Compares         = %d", compareCount0_subtotal);
        $display("[[ Step 1 Number of Algorithm Cycles = %d", algoCycleCount1_subtotal);
        $display("[[ Step 1 Number of Compares         = %d", compareCount1_subtotal);
        $display("[[");
        $display("[[ Total Number of Algorithm Cycles = %d", algoCycleCount_total);
        $display("[[ Total Number of Compares         = %d", compareCount_total);
        $display("[[");
      end
    end // stepEnable1
  end // BIST_EN
end
 
always @ (negedge `BIST_CLK) begin
  if (stepEnable1 == 1) begin
    if (`CMP_EN1) begin
      compareCount1 = compareCount1 + 1;
    end
  end
end
 
always @ (negedge `BIST_CLK) begin
  if (stepEnable1 == 1) begin
    algoCycleCount1 = algoCycleCount1 + 1;
  end
end
 
// Display signals 
always @ (posedge `BIST_CLK) begin
  if (stepEnable1 == 1) begin
    $display(
                "[[",
                //"%d",                   $time,
                //" %d",                  algoCycleCount1,
                " %s",                  "SMARCHCHKB",
                " PHASE=%d.%d ;",       PHASE_SMARCHCHKB, SUB_PHASE_SMARCHCHKB,
                " INST=%d ;",           `INST_POINTER,
                " LOOPA=%d ;",          `LOOP_A_CNTR,
                " LOOPB=%d ;",          `LOOP_B_CNTR,
                " %s",                  "MEM1",
                " A12=%h", `mem1InstPath.A12,
                " A11=%h", `mem1InstPath.A11,
                " A10=%h", `mem1InstPath.A10,
                " A9=%h", `mem1InstPath.A9,
                " A8=%h", `mem1InstPath.A8,
                " A7=%h", `mem1InstPath.A7,
                " A6=%h", `mem1InstPath.A6,
                " A5=%h", `mem1InstPath.A5,
                " A4=%h", `mem1InstPath.A4,
                " A3=%h", `mem1InstPath.A3,
                " A2=%h", `mem1InstPath.A2,
                " A1=%h", `mem1InstPath.A1,
                " A0=%h", `mem1InstPath.A0,
                " DI31=%h", `mem1InstPath.DI31,
                " DI30=%h", `mem1InstPath.DI30,
                " DI29=%h", `mem1InstPath.DI29,
                " DI28=%h", `mem1InstPath.DI28,
                " DI27=%h", `mem1InstPath.DI27,
                " DI26=%h", `mem1InstPath.DI26,
                " DI25=%h", `mem1InstPath.DI25,
                " DI24=%h", `mem1InstPath.DI24,
                " DI23=%h", `mem1InstPath.DI23,
                " DI22=%h", `mem1InstPath.DI22,
                " DI21=%h", `mem1InstPath.DI21,
                " DI20=%h", `mem1InstPath.DI20,
                " DI19=%h", `mem1InstPath.DI19,
                " DI18=%h", `mem1InstPath.DI18,
                " DI17=%h", `mem1InstPath.DI17,
                " DI16=%h", `mem1InstPath.DI16,
                " DI15=%h", `mem1InstPath.DI15,
                " DI14=%h", `mem1InstPath.DI14,
                " DI13=%h", `mem1InstPath.DI13,
                " DI12=%h", `mem1InstPath.DI12,
                " DI11=%h", `mem1InstPath.DI11,
                " DI10=%h", `mem1InstPath.DI10,
                " DI9=%h", `mem1InstPath.DI9,
                " DI8=%h", `mem1InstPath.DI8,
                " DI7=%h", `mem1InstPath.DI7,
                " DI6=%h", `mem1InstPath.DI6,
                " DI5=%h", `mem1InstPath.DI5,
                " DI4=%h", `mem1InstPath.DI4,
                " DI3=%h", `mem1InstPath.DI3,
                " DI2=%h", `mem1InstPath.DI2,
                " DI1=%h", `mem1InstPath.DI1,
                " DI0=%h", `mem1InstPath.DI0,
                " DO31=%h", `mem1InstPath.DO31,
                " DO30=%h", `mem1InstPath.DO30,
                " DO29=%h", `mem1InstPath.DO29,
                " DO28=%h", `mem1InstPath.DO28,
                " DO27=%h", `mem1InstPath.DO27,
                " DO26=%h", `mem1InstPath.DO26,
                " DO25=%h", `mem1InstPath.DO25,
                " DO24=%h", `mem1InstPath.DO24,
                " DO23=%h", `mem1InstPath.DO23,
                " DO22=%h", `mem1InstPath.DO22,
                " DO21=%h", `mem1InstPath.DO21,
                " DO20=%h", `mem1InstPath.DO20,
                " DO19=%h", `mem1InstPath.DO19,
                " DO18=%h", `mem1InstPath.DO18,
                " DO17=%h", `mem1InstPath.DO17,
                " DO16=%h", `mem1InstPath.DO16,
                " DO15=%h", `mem1InstPath.DO15,
                " DO14=%h", `mem1InstPath.DO14,
                " DO13=%h", `mem1InstPath.DO13,
                " DO12=%h", `mem1InstPath.DO12,
                " DO11=%h", `mem1InstPath.DO11,
                " DO10=%h", `mem1InstPath.DO10,
                " DO9=%h", `mem1InstPath.DO9,
                " DO8=%h", `mem1InstPath.DO8,
                " DO7=%h", `mem1InstPath.DO7,
                " DO6=%h", `mem1InstPath.DO6,
                " DO5=%h", `mem1InstPath.DO5,
                " DO4=%h", `mem1InstPath.DO4,
                " DO3=%h", `mem1InstPath.DO3,
                " DO2=%h", `mem1InstPath.DO2,
                " DO1=%h", `mem1InstPath.DO1,
                " DO0=%h", `mem1InstPath.DO0,
                " CSB=%h", `mem1InstPath.CSB,
                " OE=%h", `mem1InstPath.OE,
                " WEB3=%h", `mem1InstPath.WEB3,
                " WEB2=%h", `mem1InstPath.WEB2,
                " WEB1=%h", `mem1InstPath.WEB1,
                " WEB0=%h", `mem1InstPath.WEB0,
                " DVS3=%h", `mem1InstPath.DVS3,
                " DVS2=%h", `mem1InstPath.DVS2,
                " DVS1=%h", `mem1InstPath.DVS1,
                " DVS0=%h", `mem1InstPath.DVS0,
                " DVSE=%h", `mem1InstPath.DVSE,
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
  if (stepEnable1 == 1 &&
      `BIST_WRITEENABLE &&
      PHASE_SMARCHCHKB == 5 && SUB_PHASE_SMARCHCHKB == 0) begin
    $fwrite(addMapFile,
                " %s", "-",
                " %b", `BIST_ROW_ADD, 
                " %b", `BIST_COL_ADD, 

                " ",
                "%b", `mem1InstPath.A12,
                "%b", `mem1InstPath.A11,
                "%b", `mem1InstPath.A10,
                "%b", `mem1InstPath.A9,
                "%b", `mem1InstPath.A8,
                "%b", `mem1InstPath.A7,
                "%b", `mem1InstPath.A6,
                "%b", `mem1InstPath.A5,
                "%b", `mem1InstPath.A4,
                "%b", `mem1InstPath.A3,
                "%b", `mem1InstPath.A2,
                "%b", `mem1InstPath.A1,
                "%b", `mem1InstPath.A0,
                " ",
                "%b", `mem1InstPath.DI31,
                "%b", `mem1InstPath.DI30,
                "%b", `mem1InstPath.DI29,
                "%b", `mem1InstPath.DI28,
                "%b", `mem1InstPath.DI27,
                "%b", `mem1InstPath.DI26,
                "%b", `mem1InstPath.DI25,
                "%b", `mem1InstPath.DI24,
                "%b", `mem1InstPath.DI23,
                "%b", `mem1InstPath.DI22,
                "%b", `mem1InstPath.DI21,
                "%b", `mem1InstPath.DI20,
                "%b", `mem1InstPath.DI19,
                "%b", `mem1InstPath.DI18,
                "%b", `mem1InstPath.DI17,
                "%b", `mem1InstPath.DI16,
                "%b", `mem1InstPath.DI15,
                "%b", `mem1InstPath.DI14,
                "%b", `mem1InstPath.DI13,
                "%b", `mem1InstPath.DI12,
                "%b", `mem1InstPath.DI11,
                "%b", `mem1InstPath.DI10,
                "%b", `mem1InstPath.DI9,
                "%b", `mem1InstPath.DI8,
                "%b", `mem1InstPath.DI7,
                "%b", `mem1InstPath.DI6,
                "%b", `mem1InstPath.DI5,
                "%b", `mem1InstPath.DI4,
                "%b", `mem1InstPath.DI3,
                "%b", `mem1InstPath.DI2,
                "%b", `mem1InstPath.DI1,
                "%b", `mem1InstPath.DI0,

                " \n"
    ); // $fwrite
  end
end
// Address map file 
// Step 1 

//synopsys translate_on
`endif
// [end]   : monitor module 

 
 
endmodule // SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_ASSEMBLY

// [start] : AUT module 
module SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST (
    MEM0_CK,
    MEM0_CSB,
    MEM0_OE,
    MEM0_WEB3,
    MEM0_WEB2,
    MEM0_WEB1,
    MEM0_WEB0,
    MEM0_DVS3,
    MEM0_DVS2,
    MEM0_DVS1,
    MEM0_DVS0,
    MEM0_DVSE,
    MEM0_A11,
    MEM0_A10,
    MEM0_A9,
    MEM0_A8,
    MEM0_A7,
    MEM0_A6,
    MEM0_A5,
    MEM0_A4,
    MEM0_A3,
    MEM0_A2,
    MEM0_A1,
    MEM0_A0,
    MEM0_DI31,
    MEM0_DI30,
    MEM0_DI29,
    MEM0_DI28,
    MEM0_DI27,
    MEM0_DI26,
    MEM0_DI25,
    MEM0_DI24,
    MEM0_DI23,
    MEM0_DI22,
    MEM0_DI21,
    MEM0_DI20,
    MEM0_DI19,
    MEM0_DI18,
    MEM0_DI17,
    MEM0_DI16,
    MEM0_DI15,
    MEM0_DI14,
    MEM0_DI13,
    MEM0_DI12,
    MEM0_DI11,
    MEM0_DI10,
    MEM0_DI9,
    MEM0_DI8,
    MEM0_DI7,
    MEM0_DI6,
    MEM0_DI5,
    MEM0_DI4,
    MEM0_DI3,
    MEM0_DI2,
    MEM0_DI1,
    MEM0_DI0,
    MEM0_DO31,
    MEM0_DO30,
    MEM0_DO29,
    MEM0_DO28,
    MEM0_DO27,
    MEM0_DO26,
    MEM0_DO25,
    MEM0_DO24,
    MEM0_DO23,
    MEM0_DO22,
    MEM0_DO21,
    MEM0_DO20,
    MEM0_DO19,
    MEM0_DO18,
    MEM0_DO17,
    MEM0_DO16,
    MEM0_DO15,
    MEM0_DO14,
    MEM0_DO13,
    MEM0_DO12,
    MEM0_DO11,
    MEM0_DO10,
    MEM0_DO9,
    MEM0_DO8,
    MEM0_DO7,
    MEM0_DO6,
    MEM0_DO5,
    MEM0_DO4,
    MEM0_DO3,
    MEM0_DO2,
    MEM0_DO1,
    MEM0_DO0,
    MEM1_CK,
    MEM1_CSB,
    MEM1_OE,
    MEM1_WEB3,
    MEM1_WEB2,
    MEM1_WEB1,
    MEM1_WEB0,
    MEM1_DVS3,
    MEM1_DVS2,
    MEM1_DVS1,
    MEM1_DVS0,
    MEM1_DVSE,
    MEM1_A12,
    MEM1_A11,
    MEM1_A10,
    MEM1_A9,
    MEM1_A8,
    MEM1_A7,
    MEM1_A6,
    MEM1_A5,
    MEM1_A4,
    MEM1_A3,
    MEM1_A2,
    MEM1_A1,
    MEM1_A0,
    MEM1_DI31,
    MEM1_DI30,
    MEM1_DI29,
    MEM1_DI28,
    MEM1_DI27,
    MEM1_DI26,
    MEM1_DI25,
    MEM1_DI24,
    MEM1_DI23,
    MEM1_DI22,
    MEM1_DI21,
    MEM1_DI20,
    MEM1_DI19,
    MEM1_DI18,
    MEM1_DI17,
    MEM1_DI16,
    MEM1_DI15,
    MEM1_DI14,
    MEM1_DI13,
    MEM1_DI12,
    MEM1_DI11,
    MEM1_DI10,
    MEM1_DI9,
    MEM1_DI8,
    MEM1_DI7,
    MEM1_DI6,
    MEM1_DI5,
    MEM1_DI4,
    MEM1_DI3,
    MEM1_DI2,
    MEM1_DI1,
    MEM1_DI0,
    MEM1_DO31,
    MEM1_DO30,
    MEM1_DO29,
    MEM1_DO28,
    MEM1_DO27,
    MEM1_DO26,
    MEM1_DO25,
    MEM1_DO24,
    MEM1_DO23,
    MEM1_DO22,
    MEM1_DO21,
    MEM1_DO20,
    MEM1_DO19,
    MEM1_DO18,
    MEM1_DO17,
    MEM1_DO16,
    MEM1_DO15,
    MEM1_DO14,
    MEM1_DO13,
    MEM1_DO12,
    MEM1_DO11,
    MEM1_DO10,
    MEM1_DO9,
    MEM1_DO8,
    MEM1_DO7,
    MEM1_DO6,
    MEM1_DO5,
    MEM1_DO4,
    MEM1_DO3,
    MEM1_DO2,
    MEM1_DO1,
    MEM1_DO0
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
  wire  MEM1_INTERF_INST_A0;
  wire  MEM1_INTERF_INST_A1;
  wire  MEM1_INTERF_INST_A2;
  wire  MEM1_INTERF_INST_A3;
  wire  MEM1_INTERF_INST_A4;
  wire  MEM1_INTERF_INST_A5;
  wire  MEM1_INTERF_INST_A6;
  wire  MEM1_INTERF_INST_A7;
  wire  MEM1_INTERF_INST_A8;
  wire  MEM1_INTERF_INST_A9;
  wire  A10_LV_1;
  wire  A11_LV_1;
  wire  A12;
  wire  WEB0_LV_1;
  wire  WEB1_LV_1;
  wire  WEB2_LV_1;
  wire  WEB3_LV_1;
  wire  MEM1_INTERF_INST_OE;
  wire  CSB_LV_1;
  wire  DI0;
  wire  DI1;
  wire  DI2;
  wire  DI3;
  wire  DI4;
  wire  DI5;
  wire  DI6;
  wire  DI7;
  wire  DI8;
  wire  DI9;
  wire  DI10;
  wire  DI11;
  wire  DI12;
  wire  DI13;
  wire  DI14;
  wire  DI15;
  wire  DI16;
  wire  DI17;
  wire  DI18;
  wire  DI19;
  wire  DI20;
  wire  DI21;
  wire  DI22;
  wire  DI23;
  wire  DI24;
  wire  DI25;
  wire  DI26;
  wire  DI27;
  wire  DI28;
  wire  DI29;
  wire  DI30;
  wire  DI31;
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
  wire  A10;
  wire  A11;
  wire  WEB0;
  wire  WEB1;
  wire  WEB2;
  wire  WEB3;
  wire  MEM0_INTERF_INST_OE;
  wire  CSB;
  wire[31:0]  BIST_DATA_FROM_MEM1;
  wire  BIST_COLLAR_EN_LV_1;
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
  wire[9:0]  BIST_ROW_ADD_LV_1;
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
input                                         MEM0_CK;
input                                         MEM0_CSB;
input                                         MEM0_OE;
input                                         MEM0_WEB3;
input                                         MEM0_WEB2;
input                                         MEM0_WEB1;
input                                         MEM0_WEB0;
input                                         MEM0_DVS3;
input                                         MEM0_DVS2;
input                                         MEM0_DVS1;
input                                         MEM0_DVS0;
input                                         MEM0_DVSE;
input                                         MEM0_A11;
input                                         MEM0_A10;
input                                         MEM0_A9;
input                                         MEM0_A8;
input                                         MEM0_A7;
input                                         MEM0_A6;
input                                         MEM0_A5;
input                                         MEM0_A4;
input                                         MEM0_A3;
input                                         MEM0_A2;
input                                         MEM0_A1;
input                                         MEM0_A0;
input                                         MEM0_DI31;
input                                         MEM0_DI30;
input                                         MEM0_DI29;
input                                         MEM0_DI28;
input                                         MEM0_DI27;
input                                         MEM0_DI26;
input                                         MEM0_DI25;
input                                         MEM0_DI24;
input                                         MEM0_DI23;
input                                         MEM0_DI22;
input                                         MEM0_DI21;
input                                         MEM0_DI20;
input                                         MEM0_DI19;
input                                         MEM0_DI18;
input                                         MEM0_DI17;
input                                         MEM0_DI16;
input                                         MEM0_DI15;
input                                         MEM0_DI14;
input                                         MEM0_DI13;
input                                         MEM0_DI12;
input                                         MEM0_DI11;
input                                         MEM0_DI10;
input                                         MEM0_DI9;
input                                         MEM0_DI8;
input                                         MEM0_DI7;
input                                         MEM0_DI6;
input                                         MEM0_DI5;
input                                         MEM0_DI4;
input                                         MEM0_DI3;
input                                         MEM0_DI2;
input                                         MEM0_DI1;
input                                         MEM0_DI0;
output                                        MEM0_DO31;
output                                        MEM0_DO30;
output                                        MEM0_DO29;
output                                        MEM0_DO28;
output                                        MEM0_DO27;
output                                        MEM0_DO26;
output                                        MEM0_DO25;
output                                        MEM0_DO24;
output                                        MEM0_DO23;
output                                        MEM0_DO22;
output                                        MEM0_DO21;
output                                        MEM0_DO20;
output                                        MEM0_DO19;
output                                        MEM0_DO18;
output                                        MEM0_DO17;
output                                        MEM0_DO16;
output                                        MEM0_DO15;
output                                        MEM0_DO14;
output                                        MEM0_DO13;
output                                        MEM0_DO12;
output                                        MEM0_DO11;
output                                        MEM0_DO10;
output                                        MEM0_DO9;
output                                        MEM0_DO8;
output                                        MEM0_DO7;
output                                        MEM0_DO6;
output                                        MEM0_DO5;
output                                        MEM0_DO4;
output                                        MEM0_DO3;
output                                        MEM0_DO2;
output                                        MEM0_DO1;
output                                        MEM0_DO0;
input                                         MEM1_CK;
input                                         MEM1_CSB;
input                                         MEM1_OE;
input                                         MEM1_WEB3;
input                                         MEM1_WEB2;
input                                         MEM1_WEB1;
input                                         MEM1_WEB0;
input                                         MEM1_DVS3;
input                                         MEM1_DVS2;
input                                         MEM1_DVS1;
input                                         MEM1_DVS0;
input                                         MEM1_DVSE;
input                                         MEM1_A12;
input                                         MEM1_A11;
input                                         MEM1_A10;
input                                         MEM1_A9;
input                                         MEM1_A8;
input                                         MEM1_A7;
input                                         MEM1_A6;
input                                         MEM1_A5;
input                                         MEM1_A4;
input                                         MEM1_A3;
input                                         MEM1_A2;
input                                         MEM1_A1;
input                                         MEM1_A0;
input                                         MEM1_DI31;
input                                         MEM1_DI30;
input                                         MEM1_DI29;
input                                         MEM1_DI28;
input                                         MEM1_DI27;
input                                         MEM1_DI26;
input                                         MEM1_DI25;
input                                         MEM1_DI24;
input                                         MEM1_DI23;
input                                         MEM1_DI22;
input                                         MEM1_DI21;
input                                         MEM1_DI20;
input                                         MEM1_DI19;
input                                         MEM1_DI18;
input                                         MEM1_DI17;
input                                         MEM1_DI16;
input                                         MEM1_DI15;
input                                         MEM1_DI14;
input                                         MEM1_DI13;
input                                         MEM1_DI12;
input                                         MEM1_DI11;
input                                         MEM1_DI10;
input                                         MEM1_DI9;
input                                         MEM1_DI8;
input                                         MEM1_DI7;
input                                         MEM1_DI6;
input                                         MEM1_DI5;
input                                         MEM1_DI4;
input                                         MEM1_DI3;
input                                         MEM1_DI2;
input                                         MEM1_DI1;
input                                         MEM1_DI0;
output                                        MEM1_DO31;
output                                        MEM1_DO30;
output                                        MEM1_DO29;
output                                        MEM1_DO28;
output                                        MEM1_DO27;
output                                        MEM1_DO26;
output                                        MEM1_DO25;
output                                        MEM1_DO24;
output                                        MEM1_DO23;
output                                        MEM1_DO22;
output                                        MEM1_DO21;
output                                        MEM1_DO20;
output                                        MEM1_DO19;
output                                        MEM1_DO18;
output                                        MEM1_DO17;
output                                        MEM1_DO16;
output                                        MEM1_DO15;
output                                        MEM1_DO14;
output                                        MEM1_DO13;
output                                        MEM1_DO12;
output                                        MEM1_DO11;
output                                        MEM1_DO10;
output                                        MEM1_DO9;
output                                        MEM1_DO8;
output                                        MEM1_DO7;
output                                        MEM1_DO6;
output                                        MEM1_DO5;
output                                        MEM1_DO4;
output                                        MEM1_DO3;
output                                        MEM1_DO2;
output                                        MEM1_DO1;
output                                        MEM1_DO0;

SHAA110_4096X8X4CM8 MEM0_MEM_INST ( // 
        // Clock ports
            .CK                               ( MEM0_CK ),
	.CSB(CSB),
	.OE(MEM0_INTERF_INST_OE),
	.WEB3(WEB3),
	.WEB2(WEB2),
	.WEB1(WEB1),
	.WEB0(WEB0), // i
        // Functional ports
            .DVS3                             ( MEM0_DVS3 ), // i
            .DVS2                             ( MEM0_DVS2 ), // i
            .DVS1                             ( MEM0_DVS1 ), // i
            .DVS0                             ( MEM0_DVS0 ), // i
            .DVSE                             ( MEM0_DVSE ),
	.A11(A11),
	.A10(A10),
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
	.DI31(DI31),
	.DI30(DI30),
	.DI29(DI29),
	.DI28(DI28),
	.DI27(DI27),
	.DI26(DI26),
	.DI25(DI25),
	.DI24(DI24),
	.DI23(DI23),
	.DI22(DI22),
	.DI21(DI21),
	.DI20(DI20),
	.DI19(DI19),
	.DI18(DI18),
	.DI17(DI17),
	.DI16(DI16),
	.DI15(DI15),
	.DI14(DI14),
	.DI13(DI13),
	.DI12(DI12),
	.DI11(DI11),
	.DI10(DI10),
	.DI9(DI9),
	.DI8(DI8),
	.DI7(DI7),
	.DI6(DI6),
	.DI5(DI5),
	.DI4(DI4),
	.DI3(DI3),
	.DI2(DI2),
	.DI1(DI1),
	.DI0(DI0), // i
            .DO31                             ( MEM0_DO31 ), // o
            .DO30                             ( MEM0_DO30 ), // o
            .DO29                             ( MEM0_DO29 ), // o
            .DO28                             ( MEM0_DO28 ), // o
            .DO27                             ( MEM0_DO27 ), // o
            .DO26                             ( MEM0_DO26 ), // o
            .DO25                             ( MEM0_DO25 ), // o
            .DO24                             ( MEM0_DO24 ), // o
            .DO23                             ( MEM0_DO23 ), // o
            .DO22                             ( MEM0_DO22 ), // o
            .DO21                             ( MEM0_DO21 ), // o
            .DO20                             ( MEM0_DO20 ), // o
            .DO19                             ( MEM0_DO19 ), // o
            .DO18                             ( MEM0_DO18 ), // o
            .DO17                             ( MEM0_DO17 ), // o
            .DO16                             ( MEM0_DO16 ), // o
            .DO15                             ( MEM0_DO15 ), // o
            .DO14                             ( MEM0_DO14 ), // o
            .DO13                             ( MEM0_DO13 ), // o
            .DO12                             ( MEM0_DO12 ), // o
            .DO11                             ( MEM0_DO11 ), // o
            .DO10                             ( MEM0_DO10 ), // o
            .DO9                              ( MEM0_DO9 ), // o
            .DO8                              ( MEM0_DO8 ), // o
            .DO7                              ( MEM0_DO7 ), // o
            .DO6                              ( MEM0_DO6 ), // o
            .DO5                              ( MEM0_DO5 ), // o
            .DO4                              ( MEM0_DO4 ), // o
            .DO3                              ( MEM0_DO3 ), // o
            .DO2                              ( MEM0_DO2 ), // o
            .DO1                              ( MEM0_DO1 ), // o
            .DO0                              ( MEM0_DO0 )  // o
); // 
 
SHAA110_8192X8X4CM8 MEM1_MEM_INST ( // 
        // Clock ports
            .CK                               ( MEM1_CK ),
	.CSB(CSB_LV_1),
	.OE(MEM1_INTERF_INST_OE),
	.WEB3(WEB3_LV_1),
	.WEB2(WEB2_LV_1),
	.WEB1(WEB1_LV_1),
	.WEB0(WEB0_LV_1), // i
        // Functional ports
            .DVS3                             ( MEM1_DVS3 ), // i
            .DVS2                             ( MEM1_DVS2 ), // i
            .DVS1                             ( MEM1_DVS1 ), // i
            .DVS0                             ( MEM1_DVS0 ), // i
            .DVSE                             ( MEM1_DVSE ),
	.A12(A12),
	.A11(A11_LV_1),
	.A10(A10_LV_1),
	.A9(MEM1_INTERF_INST_A9),
	.A8(MEM1_INTERF_INST_A8),
	.A7(MEM1_INTERF_INST_A7),
	.A6(MEM1_INTERF_INST_A6),
	.A5(MEM1_INTERF_INST_A5),
	.A4(MEM1_INTERF_INST_A4),
	.A3(MEM1_INTERF_INST_A3),
	.A2(MEM1_INTERF_INST_A2),
	.A1(MEM1_INTERF_INST_A1),
	.A0(MEM1_INTERF_INST_A0),
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
            .DO31                             ( MEM1_DO31 ), // o
            .DO30                             ( MEM1_DO30 ), // o
            .DO29                             ( MEM1_DO29 ), // o
            .DO28                             ( MEM1_DO28 ), // o
            .DO27                             ( MEM1_DO27 ), // o
            .DO26                             ( MEM1_DO26 ), // o
            .DO25                             ( MEM1_DO25 ), // o
            .DO24                             ( MEM1_DO24 ), // o
            .DO23                             ( MEM1_DO23 ), // o
            .DO22                             ( MEM1_DO22 ), // o
            .DO21                             ( MEM1_DO21 ), // o
            .DO20                             ( MEM1_DO20 ), // o
            .DO19                             ( MEM1_DO19 ), // o
            .DO18                             ( MEM1_DO18 ), // o
            .DO17                             ( MEM1_DO17 ), // o
            .DO16                             ( MEM1_DO16 ), // o
            .DO15                             ( MEM1_DO15 ), // o
            .DO14                             ( MEM1_DO14 ), // o
            .DO13                             ( MEM1_DO13 ), // o
            .DO12                             ( MEM1_DO12 ), // o
            .DO11                             ( MEM1_DO11 ), // o
            .DO10                             ( MEM1_DO10 ), // o
            .DO9                              ( MEM1_DO9 ), // o
            .DO8                              ( MEM1_DO8 ), // o
            .DO7                              ( MEM1_DO7 ), // o
            .DO6                              ( MEM1_DO6 ), // o
            .DO5                              ( MEM1_DO5 ), // o
            .DO4                              ( MEM1_DO4 ), // o
            .DO3                              ( MEM1_DO3 ), // o
            .DO2                              ( MEM1_DO2 ), // o
            .DO1                              ( MEM1_DO1 ), // o
            .DO0                              ( MEM1_DO0 )  // o
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
	.BIST_ROW_ADD({
	BIST_ROW_ADD_LV_1[9], 
	BIST_ROW_ADD[8], 
	BIST_ROW_ADD[7], 
	BIST_ROW_ADD[6], 
	BIST_ROW_ADD[5], 
	BIST_ROW_ADD[4], 
	BIST_ROW_ADD[3], 
	BIST_ROW_ADD[2], 
	BIST_ROW_ADD[1], 
	BIST_ROW_ADD[0]
	}),
	.BIST_COLLAR_EN0(BIST_COLLAR_EN),
	.BIST_WRITE_DATA(BIST_WRITE_DATA),
	.CHKBCI_PHASE(CHKBCI_PHASE),
	.BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR),
	.BIST_COLLAR_SETUP(BIST_COLLAR_SETUP),
	.BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT),
	.BIST_CLEAR(BIST_CLEAR),
	.BIST_COLLAR_HOLD(BIST_COLLAR_HOLD),
	.BIST_DATA_FROM_MEM0(BIST_DATA_FROM_MEM0),
	.MBISTPG_RESET_REG_SETUP2(RESET_REG_SETUP2),
	.BIST_COLLAR_EN1(BIST_COLLAR_EN_LV_1),
	.BIST_DATA_FROM_MEM1(BIST_DATA_FROM_MEM1));

SMARCHCHKB_LVISION_MEM0_INTERFACE MEM0_INTERF_INST
   ( .SCAN_OBS_FLOPS(),
	.CSB_IN(MEM0_CSB),
	.OE_IN(MEM0_OE),
	.WEB3_IN(MEM0_WEB3),
	.WEB2_IN(MEM0_WEB2),
	.WEB1_IN(MEM0_WEB1),
	.WEB0_IN(MEM0_WEB0),
	.A11_IN(MEM0_A11),
	.A10_IN(MEM0_A10),
	.A9_IN(MEM0_A9),
	.A8_IN(MEM0_A8),
	.A7_IN(MEM0_A7),
	.A6_IN(MEM0_A6),
	.A5_IN(MEM0_A5),
	.A4_IN(MEM0_A4),
	.A3_IN(MEM0_A3),
	.A2_IN(MEM0_A2),
	.A1_IN(MEM0_A1),
	.A0_IN(MEM0_A0),
	.DI31_IN(MEM0_DI31),
	.DI30_IN(MEM0_DI30),
	.DI29_IN(MEM0_DI29),
	.DI28_IN(MEM0_DI28),
	.DI27_IN(MEM0_DI27),
	.DI26_IN(MEM0_DI26),
	.DI25_IN(MEM0_DI25),
	.DI24_IN(MEM0_DI24),
	.DI23_IN(MEM0_DI23),
	.DI22_IN(MEM0_DI22),
	.DI21_IN(MEM0_DI21),
	.DI20_IN(MEM0_DI20),
	.DI19_IN(MEM0_DI19),
	.DI18_IN(MEM0_DI18),
	.DI17_IN(MEM0_DI17),
	.DI16_IN(MEM0_DI16),
	.DI15_IN(MEM0_DI15),
	.DI14_IN(MEM0_DI14),
	.DI13_IN(MEM0_DI13),
	.DI12_IN(MEM0_DI12),
	.DI11_IN(MEM0_DI11),
	.DI10_IN(MEM0_DI10),
	.DI9_IN(MEM0_DI9),
	.DI8_IN(MEM0_DI8),
	.DI7_IN(MEM0_DI7),
	.DI6_IN(MEM0_DI6),
	.DI5_IN(MEM0_DI5),
	.DI4_IN(MEM0_DI4),
	.DI3_IN(MEM0_DI3),
	.DI2_IN(MEM0_DI2),
	.DI1_IN(MEM0_DI1),
	.DI0_IN(MEM0_DI0),
	.BIST_CLK(BIST_CLK),
	.TCK_MODE(TCK_MODE),
	.LV_TM(LV_TM),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_WRITEENABLE(BIST_WRITEENABLE),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD({
	BIST_ROW_ADD[8], 
	BIST_ROW_ADD[7], 
	BIST_ROW_ADD[6], 
	BIST_ROW_ADD[5], 
	BIST_ROW_ADD[4], 
	BIST_ROW_ADD[3], 
	BIST_ROW_ADD[2], 
	BIST_ROW_ADD[1], 
	BIST_ROW_ADD[0]
	}),
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
	.CSB(CSB),
	.OE(MEM0_INTERF_INST_OE),
	.WEB3(WEB3),
	.WEB2(WEB2),
	.WEB1(WEB1),
	.WEB0(WEB0),
	.A11(A11),
	.A10(A10),
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
	.DI31(DI31),
	.DI30(DI30),
	.DI29(DI29),
	.DI28(DI28),
	.DI27(DI27),
	.DI26(DI26),
	.DI25(DI25),
	.DI24(DI24),
	.DI23(DI23),
	.DI22(DI22),
	.DI21(DI21),
	.DI20(DI20),
	.DI19(DI19),
	.DI18(DI18),
	.DI17(DI17),
	.DI16(DI16),
	.DI15(DI15),
	.DI14(DI14),
	.DI13(DI13),
	.DI12(DI12),
	.DI11(DI11),
	.DI10(DI10),
	.DI9(DI9),
	.DI8(DI8),
	.DI7(DI7),
	.DI6(DI6),
	.DI5(DI5),
	.DI4(DI4),
	.DI3(DI3),
	.DI2(DI2),
	.DI1(DI1),
	.DI0(DI0),
	.DO31(MEM0_DO31),
	.DO30(MEM0_DO30),
	.DO29(MEM0_DO29),
	.DO28(MEM0_DO28),
	.DO27(MEM0_DO27),
	.DO26(MEM0_DO26),
	.DO25(MEM0_DO25),
	.DO24(MEM0_DO24),
	.DO23(MEM0_DO23),
	.DO22(MEM0_DO22),
	.DO21(MEM0_DO21),
	.DO20(MEM0_DO20),
	.DO19(MEM0_DO19),
	.DO18(MEM0_DO18),
	.DO17(MEM0_DO17),
	.DO16(MEM0_DO16),
	.DO15(MEM0_DO15),
	.DO14(MEM0_DO14),
	.DO13(MEM0_DO13),
	.DO12(MEM0_DO12),
	.DO11(MEM0_DO11),
	.DO10(MEM0_DO10),
	.DO9(MEM0_DO9),
	.DO8(MEM0_DO8),
	.DO7(MEM0_DO7),
	.DO6(MEM0_DO6),
	.DO5(MEM0_DO5),
	.DO4(MEM0_DO4),
	.DO3(MEM0_DO3),
	.DO2(MEM0_DO2),
	.DO1(MEM0_DO1),
	.DO0(MEM0_DO0));

SMARCHCHKB_LVISION_MEM1_INTERFACE MEM1_INTERF_INST
   ( .SCAN_OBS_FLOPS(),
	.CSB_IN(MEM1_CSB),
	.OE_IN(MEM1_OE),
	.WEB3_IN(MEM1_WEB3),
	.WEB2_IN(MEM1_WEB2),
	.WEB1_IN(MEM1_WEB1),
	.WEB0_IN(MEM1_WEB0),
	.A12_IN(MEM1_A12),
	.A11_IN(MEM1_A11),
	.A10_IN(MEM1_A10),
	.A9_IN(MEM1_A9),
	.A8_IN(MEM1_A8),
	.A7_IN(MEM1_A7),
	.A6_IN(MEM1_A6),
	.A5_IN(MEM1_A5),
	.A4_IN(MEM1_A4),
	.A3_IN(MEM1_A3),
	.A2_IN(MEM1_A2),
	.A1_IN(MEM1_A1),
	.A0_IN(MEM1_A0),
	.DI31_IN(MEM1_DI31),
	.DI30_IN(MEM1_DI30),
	.DI29_IN(MEM1_DI29),
	.DI28_IN(MEM1_DI28),
	.DI27_IN(MEM1_DI27),
	.DI26_IN(MEM1_DI26),
	.DI25_IN(MEM1_DI25),
	.DI24_IN(MEM1_DI24),
	.DI23_IN(MEM1_DI23),
	.DI22_IN(MEM1_DI22),
	.DI21_IN(MEM1_DI21),
	.DI20_IN(MEM1_DI20),
	.DI19_IN(MEM1_DI19),
	.DI18_IN(MEM1_DI18),
	.DI17_IN(MEM1_DI17),
	.DI16_IN(MEM1_DI16),
	.DI15_IN(MEM1_DI15),
	.DI14_IN(MEM1_DI14),
	.DI13_IN(MEM1_DI13),
	.DI12_IN(MEM1_DI12),
	.DI11_IN(MEM1_DI11),
	.DI10_IN(MEM1_DI10),
	.DI9_IN(MEM1_DI9),
	.DI8_IN(MEM1_DI8),
	.DI7_IN(MEM1_DI7),
	.DI6_IN(MEM1_DI6),
	.DI5_IN(MEM1_DI5),
	.DI4_IN(MEM1_DI4),
	.DI3_IN(MEM1_DI3),
	.DI2_IN(MEM1_DI2),
	.DI1_IN(MEM1_DI1),
	.DI0_IN(MEM1_DI0),
	.BIST_CLK(BIST_CLK),
	.TCK_MODE(TCK_MODE),
	.LV_TM(LV_TM),
	.BIST_SELECT(BIST_SELECT),
	.BIST_OUTPUTENABLE(BIST_OUTPUTENABLE),
	.BIST_WRITEENABLE(BIST_WRITEENABLE),
	.BIST_COL_ADD(BIST_COL_ADD),
	.BIST_ROW_ADD({
	BIST_ROW_ADD_LV_1[9], 
	BIST_ROW_ADD[8], 
	BIST_ROW_ADD[7], 
	BIST_ROW_ADD[6], 
	BIST_ROW_ADD[5], 
	BIST_ROW_ADD[4], 
	BIST_ROW_ADD[3], 
	BIST_ROW_ADD[2], 
	BIST_ROW_ADD[1], 
	BIST_ROW_ADD[0]
	}),
	.BIST_EN(MBISTPG_EN),
	.BIST_COLLAR_EN(BIST_COLLAR_EN_LV_1),
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
	.BIST_DATA_FROM_MEM(BIST_DATA_FROM_MEM1),
	.RESET_REG_SETUP2(RESET_REG_SETUP2),
	.CSB(CSB_LV_1),
	.OE(MEM1_INTERF_INST_OE),
	.WEB3(WEB3_LV_1),
	.WEB2(WEB2_LV_1),
	.WEB1(WEB1_LV_1),
	.WEB0(WEB0_LV_1),
	.A12(A12),
	.A11(A11_LV_1),
	.A10(A10_LV_1),
	.A9(MEM1_INTERF_INST_A9),
	.A8(MEM1_INTERF_INST_A8),
	.A7(MEM1_INTERF_INST_A7),
	.A6(MEM1_INTERF_INST_A6),
	.A5(MEM1_INTERF_INST_A5),
	.A4(MEM1_INTERF_INST_A4),
	.A3(MEM1_INTERF_INST_A3),
	.A2(MEM1_INTERF_INST_A2),
	.A1(MEM1_INTERF_INST_A1),
	.A0(MEM1_INTERF_INST_A0),
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
	.DO31(MEM1_DO31),
	.DO30(MEM1_DO30),
	.DO29(MEM1_DO29),
	.DO28(MEM1_DO28),
	.DO27(MEM1_DO27),
	.DO26(MEM1_DO26),
	.DO25(MEM1_DO25),
	.DO24(MEM1_DO24),
	.DO23(MEM1_DO23),
	.DO22(MEM1_DO22),
	.DO21(MEM1_DO21),
	.DO20(MEM1_DO20),
	.DO19(MEM1_DO19),
	.DO18(MEM1_DO18),
	.DO17(MEM1_DO17),
	.DO16(MEM1_DO16),
	.DO15(MEM1_DO15),
	.DO14(MEM1_DO14),
	.DO13(MEM1_DO13),
	.DO12(MEM1_DO12),
	.DO11(MEM1_DO11),
	.DO10(MEM1_DO10),
	.DO9(MEM1_DO9),
	.DO8(MEM1_DO8),
	.DO7(MEM1_DO7),
	.DO6(MEM1_DO6),
	.DO5(MEM1_DO5),
	.DO4(MEM1_DO4),
	.DO3(MEM1_DO3),
	.DO2(MEM1_DO2),
	.DO1(MEM1_DO1),
	.DO0(MEM1_DO0));

endmodule // SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST
// [end]   : AUT module 

