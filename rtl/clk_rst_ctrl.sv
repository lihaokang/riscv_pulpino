//	===============================CoreLink CO. LTD.===============================
//	Information contained in this Confidential and Proprietary work has been
//      obtained by CoreLink CO LTD
//  This Software may be used only as authorized by a licensing agreement from
//      CoreLink Limited
//
//              COPYRIGHT (C) 2017-2019 CoreLink DESIGN Limited
//                          ALL RIGHTS RESERVED
//
//	The entire notice above must be displayed on all authorized CoreLink copies.
//	Copies may be made only to the extended consent by a licensing
//		agreement from CoreLink Limited.
//
//	------------------------------------------------------------------------------
//	Project and Control Information
//	------------------------------------------------------------------------------
//	Project Name	    :       Proton-SoC
//	This module name	:       clk_rst_ctrl
//	Author          	:       weijie.chen
//	------------------------------------------------------------------------------
//	CoreLink Confidential Module(s) Information
//	UMC 0.11um Embedded Flash Process
//	------------------------------------------------------------------------------
// #############################################################################

module clk_rst_ctrl(
input logic sys_clk,
input logic sys_rstn,
input logic [31:0] clk_gating_cfg,

output logic clk_uart0,
output logic clk_uart1,
output logic clk_uart2,
output logic clk_uart3,
output logic clk_uart4,
output logic clk_uart5,

output logic clk_i2c0,
output logic clk_i2c1,
output logic clk_i2c2,
output logic clk_i2c3,
output logic clk_i2c4,
output logic clk_i2c5,

output logic clk_calib,
output logic clk_wdt,
output logic clk_adc,
output logic clk_pwm,

output logic clk_timer

);

LAGCEM8HM LAGCE_CLK_UART0 (.GCK(clk_uart0), .CK(sys_clk),  .E(clk_gating_cfg[0]));
LAGCEM8HM LAGCE_CLK_UART1 (.GCK(clk_uart1), .CK(sys_clk),  .E(clk_gating_cfg[1]));
LAGCEM8HM LAGCE_CLK_UART2 (.GCK(clk_uart2), .CK(sys_clk),  .E(clk_gating_cfg[2]));
LAGCEM8HM LAGCE_CLK_UART3 (.GCK(clk_uart3), .CK(sys_clk),  .E(clk_gating_cfg[3]));
LAGCEM8HM LAGCE_CLK_UART4 (.GCK(clk_uart4), .CK(sys_clk),  .E(clk_gating_cfg[4]));
LAGCEM8HM LAGCE_CLK_UART5 (.GCK(clk_uart5), .CK(sys_clk),  .E(clk_gating_cfg[5]));

LAGCEM8HM LAGCE_CLK_I2C0 (.GCK(clk_i2c0), .CK(sys_clk),  .E(clk_gating_cfg[6]));
LAGCEM8HM LAGCE_CLK_I2C1 (.GCK(clk_i2c1), .CK(sys_clk),  .E(clk_gating_cfg[7]));
LAGCEM8HM LAGCE_CLK_I2C2 (.GCK(clk_i2c2), .CK(sys_clk),  .E(clk_gating_cfg[8]));
LAGCEM8HM LAGCE_CLK_I2C3 (.GCK(clk_i2c3), .CK(sys_clk),  .E(clk_gating_cfg[9]));
LAGCEM8HM LAGCE_CLK_I2C4 (.GCK(clk_i2c4), .CK(sys_clk),  .E(clk_gating_cfg[10]));
LAGCEM8HM LAGCE_CLK_I2C5 (.GCK(clk_i2c5), .CK(sys_clk),  .E(clk_gating_cfg[11]));

LAGCEM8HM LAGCE_CLK_TIMER(.GCK(clk_timer),.CK(sys_clk),  .E(clk_gating_cfg[12]));

LAGCEM8HM LAGCE_CLK_CALIB(.GCK(clk_calib),.CK(sys_clk),  .E(clk_gating_cfg[13]));
LAGCEM8HM LAGCE_CLK_WDT  (.GCK(clk_wdt),  .CK(sys_clk),  .E(clk_gating_cfg[14]));
LAGCEM8HM LAGCE_CLK_ADC  (.GCK(clk_adc),  .CK(sys_clk),  .E(clk_gating_cfg[15]));
LAGCEM8HM LAGCE_CLK_PWM  (.GCK(clk_pwm),  .CK(sys_clk),  .E(clk_gating_cfg[16]));

endmodule

