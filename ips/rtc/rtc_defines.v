`define RTC_BASE    32'h1B001000

`define RTC_TIME	`RTC_BASE + 32'h00	// Address 0x00
`define RTC_DATE	`RTC_BASE + 32'h04	// Address 0x04
`define RTC_TALRM	`RTC_BASE + 32'h08	// Address 0x08
`define RTC_CTRL	`RTC_BASE + 32'h0c	// Address 0x0c


// RRTC_TIME bits
`define RTC_TIME_S		3:0
`define RTC_TIME_TS		6:4
`define RTC_TIME_M		10:7
`define RTC_TIME_TM		13:11
`define RTC_TIME_H		17:14
`define RTC_TIME_TH		19:18
`define RTC_TIME_DOW	22:20

//
// RRTC_DATE bits
`define RTC_DATE_D		3:0
`define RTC_DATE_TD		5:4
`define RTC_DATE_M		9:6
`define RTC_DATE_TM		10
`define RTC_DATE_Y		14:11
`define RTC_DATE_TY		18:15
`define RTC_DATE_C		22:19
`define RTC_DATE_TC		26:23

//
// RRTC_TALRM bits

`define RTC_TALRM_M		    3:0
`define RTC_TALRM_TM		6:4
`define RTC_TALRM_H		    10:7
`define RTC_TALRM_TH		12:11
`define RTC_TALRM_D		    16:13
`define RTC_TALRM_TD		18:17
`define RTC_TALRM_DOW		21:19
`define RTC_TALRM_CM		22
`define RTC_TALRM_CH		23
`define RTC_TALRM_CD		24
`define RTC_TALRM_CDOW		25
`define RTC_TALRM_CLR		26

//
// RRTC_CTRL bits
`define RTC_CTRL_DIV		15:0
`define RTC_CTRL_INTE		16
`define RTC_CTRL_ALRM		17
`define RTC_CTRL_EN		    18

