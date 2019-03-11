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
module READONLY_LVISION_MEM0_INTERFACE_MISR_STRAP (
    MISR_IN,
    MISR_INB,
    MISR_SIGNATURE
    );
input  [31:0] MISR_IN;
input  [31:0] MISR_INB;
output [31:0] MISR_SIGNATURE;
 
assign MISR_SIGNATURE[0] = MISR_IN[0];      
assign MISR_SIGNATURE[1] = MISR_IN[1];      
assign MISR_SIGNATURE[2] = MISR_IN[2];      
assign MISR_SIGNATURE[3] = MISR_IN[3];      
assign MISR_SIGNATURE[4] = MISR_IN[4];      
assign MISR_SIGNATURE[5] = MISR_IN[5];      
assign MISR_SIGNATURE[6] = MISR_INB[6];      
assign MISR_SIGNATURE[7] = MISR_INB[7];      
assign MISR_SIGNATURE[8] = MISR_INB[8];      
assign MISR_SIGNATURE[9] = MISR_INB[9];      
assign MISR_SIGNATURE[10] = MISR_IN[10];      
assign MISR_SIGNATURE[11] = MISR_INB[11];      
assign MISR_SIGNATURE[12] = MISR_INB[12];      
assign MISR_SIGNATURE[13] = MISR_IN[13];      
assign MISR_SIGNATURE[14] = MISR_INB[14];      
assign MISR_SIGNATURE[15] = MISR_INB[15];      
assign MISR_SIGNATURE[16] = MISR_INB[16];      
assign MISR_SIGNATURE[17] = MISR_IN[17];      
assign MISR_SIGNATURE[18] = MISR_INB[18];      
assign MISR_SIGNATURE[19] = MISR_IN[19];      
assign MISR_SIGNATURE[20] = MISR_INB[20];      
assign MISR_SIGNATURE[21] = MISR_IN[21];      
assign MISR_SIGNATURE[22] = MISR_IN[22];      
assign MISR_SIGNATURE[23] = MISR_IN[23];      
assign MISR_SIGNATURE[24] = MISR_IN[24];      
assign MISR_SIGNATURE[25] = MISR_IN[25];      
assign MISR_SIGNATURE[26] = MISR_INB[26];      
assign MISR_SIGNATURE[27] = MISR_INB[27];      
assign MISR_SIGNATURE[28] = MISR_INB[28];      
assign MISR_SIGNATURE[29] = MISR_IN[29];      
assign MISR_SIGNATURE[30] = MISR_INB[30];      
assign MISR_SIGNATURE[31] = MISR_IN[31];      
endmodule
