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
module READONLY_LVISION_MBISTPG_RETIMING_CELL (
                    CLK,
                    R,      // Asynchronous reset enable (active high)
                    RETIME_IN,
                    RETIME_OUT
);
  
// ----------------
// I/O Declarations
// ----------------
input               CLK;
input               R;
input               RETIME_IN;
output              RETIME_OUT;
  
reg                 RETIME_REG;
reg                 LV_PERSISTENT_MBIST_NTC_RETIMING_CELL;
 
// ----------------
// Retiming Stages
// ----------------
assign RETIME_OUT   = RETIME_REG;
 
// synopsys async_set_reset "R"
always @(posedge CLK or posedge R) begin
  if (R) begin
    RETIME_REG <= 1'b0;
    LV_PERSISTENT_MBIST_NTC_RETIMING_CELL <= 1'b0;
  end else begin
    RETIME_REG <= LV_PERSISTENT_MBIST_NTC_RETIMING_CELL;
    LV_PERSISTENT_MBIST_NTC_RETIMING_CELL <= RETIME_IN;
  end
end
  
endmodule
