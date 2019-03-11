
//	===============================CoreLink CO. LTD.===============================
//	Information contained in this Confidential and Proprietary work has been
//          obtained by CoreLink CO LTD
//      This Software may be used only as authorized by a licensing agreement from
//          CoreLink Limited
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
//	This module name	:       memory bist
//	Author          	:       weijie.chen
//	------------------------------------------------------------------------------
//	CoreLink Confidential Module(s) Information
//	UMC 0.11um Embedded Flash Process
//	------------------------------------------------------------------------------
// #############################################################################
//`define ROM_INSTR_ADDR_WIDTH      12
//`define ROM_START_ADDR      32'h8000
module mbist#(
  parameter INSTR_RAM_SIZE   = 32768,                //in bytes
  parameter INSTR_ADDR_WIDTH = $clog2(INSTR_RAM_SIZE) + 1, //one bit more than necessary, for the boot rom
  parameter DATA_RAM_SIZE   = 16384,              // in bytes
  parameter DATA_ADDR_WIDTH = $clog2(DATA_RAM_SIZE),
  parameter DATA_WIDTH = 32  
)
(

  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    testmode_i,//bypass_en_i

  input  logic                        instr_mem_en,//en_i
  input  logic [INSTR_ADDR_WIDTH-1:0] instr_mem_addr,//addr_i
  input  logic [DATA_WIDTH-1:0]       instr_mem_wdata,//wdata_i
  output logic [DATA_WIDTH-1:0]       instr_mem_rdata,//rdata_o
  input  logic                        instr_mem_we,//we_i
  input  logic [DATA_WIDTH/8-1:0]     instr_mem_be,//be_i
  input  logic                        data_mem_en,//en_i
  input  logic [DATA_ADDR_WIDTH-1:0]  data_mem_addr,//addr_i
  input  logic [DATA_WIDTH-1:0]       data_mem_wdata,//wdata_i
  output logic [DATA_WIDTH-1:0]       data_mem_rdata,//rdata_o
  input  logic                        data_mem_we,//we_i
  input  logic [DATA_WIDTH/8-1:0]     data_mem_be,//be_i

  output logic      ROM_MBISTPG_GO,
  output logic      ROM_MBISTPG_DONE,
  output logic      ROM_MBISTPG_SO,
  input logic       ROM_MBISTPG_EN,
  input logic       ROM_BIST_SI,
  input logic       ROM_MBISTPG_ASYNC_RESETN,
  input logic       ROM_MBISTPG_REDUCED_ADDR_CNT_EN,
  input logic       ROM_MBISTPG_MEM_RST,
  input logic       ROM_LV_TM,
  input logic       ROM_TCK,
  input logic       ROM_TCK_MODE,
  input logic       ROM_MBISTPG_TESTDATA_SELECT,
  input logic[1:0]  ROM_BIST_SETUP,
  input logic       ROM_BIST_SETUP2,
  input logic       ROM_BIST_HOLD,
  input logic       ROM_BIST_SHIFT,
  input logic       ROM_BIST_CLK,

  output logic      RAM_MBISTPG_GO,
  output logic      RAM_MBISTPG_DONE,
  output logic      RAM_MBISTPG_SO,
  input logic[5:0]  RAM_MBISTPG_CMP_STAT_ID_SEL,
  input logic[1:0]  RAM_FL_CNT_MODE,
  input logic       RAM_MBISTPG_DIAG_EN,
  input logic       RAM_MBISTPG_EN,
  input logic       RAM_BIST_SI,
  input logic       RAM_MBISTPG_ASYNC_RESETN,
  input logic       RAM_MBISTPG_REDUCED_ADDR_CNT_EN,
  input logic       RAM_MBISTPG_MEM_RST,
  input logic[1:0]  RAM_MBISTPG_ALGO_MODE,
  input logic       RAM_LV_TM,
  input logic       RAM_TCK,
  input logic       RAM_TCK_MODE,
  input logic       RAM_MBISTPG_TESTDATA_SELECT,
  input logic[1:0]  RAM_BIST_SETUP,
  input logic       RAM_BIST_SETUP2,
  input logic       RAM_BIST_HOLD,
  input logic       RAM_BIST_SHIFT,
  input logic       RAM_BIST_CLK
);

  logic is_boot, is_boot_q;
  logic [DATA_WIDTH-1:0] instr_boot_rdata;
  logic [DATA_WIDTH-1:0] instr_ram_rdata;

  assign is_boot = (instr_mem_addr[INSTR_ADDR_WIDTH-1] == 1'b1);
  assign instr_mem_rdata = (is_boot_q == 1'b1) ? instr_boot_rdata : instr_ram_rdata;

  // Delay the boot signal for one clock cycle to correctly select the rdata from boot rom vs normal ram
  always_ff @(posedge clk, negedge rst_n)
  begin
    if (rst_n == 1'b0)
      is_boot_q <= 1'b0;
    else
      is_boot_q <= is_boot;
  end

  logic [DATA_WIDTH/8-1:0] instr_mem_web;
  logic [DATA_WIDTH/8-1:0] data_mem_web;
  assign instr_mem_web = ~(instr_mem_be & {4{instr_mem_we}} & {4{instr_mem_en}} & {4{~testmode_i}});
  assign data_mem_web  = ~(data_mem_be & {4{data_mem_we}} & {4{data_mem_en}} & {4{~testmode_i}});

READONLY_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST rom_bist(
  .CK   (clk), 
  .CS   (1'b1), 
  .OE   (1'b1), 
  .DVS3 (1'b0), 
  .DVS2 (1'b0), 
  .DVS1 (1'b0), 
  .DVS0 (1'b0), 
  .DVSE (1'b0), 
  .A8   (instr_mem_addr[10]), 
  .A7   (instr_mem_addr[9] ), 
  .A6   (instr_mem_addr[8] ), 
  .A5   (instr_mem_addr[7] ), 
  .A4   (instr_mem_addr[6] ), 
  .A3   (instr_mem_addr[5] ), 
  .A2   (instr_mem_addr[4] ), 
  .A1   (instr_mem_addr[3] ), 
  .A0   (instr_mem_addr[2] ), 
  .DO31 (instr_boot_rdata[31]), 
  .DO30 (instr_boot_rdata[30]), 
  .DO29 (instr_boot_rdata[29]), 
  .DO28 (instr_boot_rdata[28]), 
  .DO27 (instr_boot_rdata[27]), 
  .DO26 (instr_boot_rdata[26]), 
  .DO25 (instr_boot_rdata[25]), 
  .DO24 (instr_boot_rdata[24]), 
  .DO23 (instr_boot_rdata[23]), 
  .DO22 (instr_boot_rdata[22]), 
  .DO21 (instr_boot_rdata[21]), 
  .DO20 (instr_boot_rdata[20]), 
  .DO19 (instr_boot_rdata[19]), 
  .DO18 (instr_boot_rdata[18]), 
  .DO17 (instr_boot_rdata[17]), 
  .DO16 (instr_boot_rdata[16]), 
  .DO15 (instr_boot_rdata[15]), 
  .DO14 (instr_boot_rdata[14]), 
  .DO13 (instr_boot_rdata[13]), 
  .DO12 (instr_boot_rdata[12]), 
  .DO11 (instr_boot_rdata[11]), 
  .DO10 (instr_boot_rdata[10]), 
  .DO9  (instr_boot_rdata[9] ), 
  .DO8  (instr_boot_rdata[8] ), 
  .DO7  (instr_boot_rdata[7] ), 
  .DO6  (instr_boot_rdata[6] ), 
  .DO5  (instr_boot_rdata[5] ), 
  .DO4  (instr_boot_rdata[4] ), 
  .DO3  (instr_boot_rdata[3] ), 
  .DO2  (instr_boot_rdata[2] ), 
  .DO1  (instr_boot_rdata[1] ), 
  .DO0  (instr_boot_rdata[0] ), 
  .MBISTPG_GO                    (ROM_MBISTPG_GO                 ),
  .MBISTPG_DONE                  (ROM_MBISTPG_DONE               ),
  .MBISTPG_SO                    (ROM_MBISTPG_SO                 ),
  .MBISTPG_EN                    (ROM_MBISTPG_EN                 ),
  .BIST_SI                       (ROM_BIST_SI                    ),
  .MBISTPG_ASYNC_RESETN          (ROM_MBISTPG_ASYNC_RESETN       ),
  .MBISTPG_REDUCED_ADDR_CNT_EN   (ROM_MBISTPG_REDUCED_ADDR_CNT_EN),
  .MBISTPG_MEM_RST               (ROM_MBISTPG_MEM_RST            ),
  .LV_TM                         (ROM_LV_TM                      ),
  .TCK                           (ROM_TCK                        ),
  .TCK_MODE                      (ROM_TCK_MODE                   ),
  .MBISTPG_TESTDATA_SELECT       (ROM_MBISTPG_TESTDATA_SELECT    ),
  .BIST_SETUP                    (ROM_BIST_SETUP                 ),
  .BIST_SETUP2                   (ROM_BIST_SETUP2                ),
  .BIST_HOLD                     (ROM_BIST_HOLD                  ),
  .BIST_SHIFT                    (ROM_BIST_SHIFT                 ),
  .BIST_CLK                      (ROM_BIST_CLK                   )
);

//MEM0, 16KB
//MEM1, 32KB
SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST sram_bist(
  .MEM0_CK   (clk),
  .MEM0_CSB  (1'b0),
  .MEM0_OE   (1'b1),
  .MEM0_WEB3 (data_mem_web[3]),
  .MEM0_WEB2 (data_mem_web[2]),
  .MEM0_WEB1 (data_mem_web[1]),
  .MEM0_WEB0 (data_mem_web[0]),
  .MEM0_DVS3 (1'b0),
  .MEM0_DVS2 (1'b0),
  .MEM0_DVS1 (1'b0),
  .MEM0_DVS0 (1'b0),
  .MEM0_DVSE (1'b0),
  .MEM0_A11  (data_mem_addr[13]),
  .MEM0_A10  (data_mem_addr[12]),
  .MEM0_A9   (data_mem_addr[11]),
  .MEM0_A8   (data_mem_addr[10]),
  .MEM0_A7   (data_mem_addr[9] ),
  .MEM0_A6   (data_mem_addr[8] ),
  .MEM0_A5   (data_mem_addr[7] ),
  .MEM0_A4   (data_mem_addr[6] ),
  .MEM0_A3   (data_mem_addr[5] ),
  .MEM0_A2   (data_mem_addr[4] ),
  .MEM0_A1   (data_mem_addr[3] ),
  .MEM0_A0   (data_mem_addr[2] ),
  .MEM0_DI31 (data_mem_wdata[31]),
  .MEM0_DI30 (data_mem_wdata[30]),
  .MEM0_DI29 (data_mem_wdata[29]),
  .MEM0_DI28 (data_mem_wdata[28]),
  .MEM0_DI27 (data_mem_wdata[27]),
  .MEM0_DI26 (data_mem_wdata[26]),
  .MEM0_DI25 (data_mem_wdata[25]),
  .MEM0_DI24 (data_mem_wdata[24]),
  .MEM0_DI23 (data_mem_wdata[23]),
  .MEM0_DI22 (data_mem_wdata[22]),
  .MEM0_DI21 (data_mem_wdata[21]),
  .MEM0_DI20 (data_mem_wdata[20]),
  .MEM0_DI19 (data_mem_wdata[19]),
  .MEM0_DI18 (data_mem_wdata[18]),
  .MEM0_DI17 (data_mem_wdata[17]),
  .MEM0_DI16 (data_mem_wdata[16]),
  .MEM0_DI15 (data_mem_wdata[15]),
  .MEM0_DI14 (data_mem_wdata[14]),
  .MEM0_DI13 (data_mem_wdata[13]),
  .MEM0_DI12 (data_mem_wdata[12]),
  .MEM0_DI11 (data_mem_wdata[11]),
  .MEM0_DI10 (data_mem_wdata[10]),
  .MEM0_DI9  (data_mem_wdata[9] ),
  .MEM0_DI8  (data_mem_wdata[8] ),
  .MEM0_DI7  (data_mem_wdata[7] ),
  .MEM0_DI6  (data_mem_wdata[6] ),
  .MEM0_DI5  (data_mem_wdata[5] ),
  .MEM0_DI4  (data_mem_wdata[4] ),
  .MEM0_DI3  (data_mem_wdata[3] ),
  .MEM0_DI2  (data_mem_wdata[2] ),
  .MEM0_DI1  (data_mem_wdata[1] ),
  .MEM0_DI0  (data_mem_wdata[0] ),
  .MEM0_DO31 (data_mem_rdata[31]),
  .MEM0_DO30 (data_mem_rdata[30]),
  .MEM0_DO29 (data_mem_rdata[29]),
  .MEM0_DO28 (data_mem_rdata[28]),
  .MEM0_DO27 (data_mem_rdata[27]),
  .MEM0_DO26 (data_mem_rdata[26]),
  .MEM0_DO25 (data_mem_rdata[25]),
  .MEM0_DO24 (data_mem_rdata[24]),
  .MEM0_DO23 (data_mem_rdata[23]),
  .MEM0_DO22 (data_mem_rdata[22]),
  .MEM0_DO21 (data_mem_rdata[21]),
  .MEM0_DO20 (data_mem_rdata[20]),
  .MEM0_DO19 (data_mem_rdata[19]),
  .MEM0_DO18 (data_mem_rdata[18]),
  .MEM0_DO17 (data_mem_rdata[17]),
  .MEM0_DO16 (data_mem_rdata[16]),
  .MEM0_DO15 (data_mem_rdata[15]),
  .MEM0_DO14 (data_mem_rdata[14]),
  .MEM0_DO13 (data_mem_rdata[13]),
  .MEM0_DO12 (data_mem_rdata[12]),
  .MEM0_DO11 (data_mem_rdata[11]),
  .MEM0_DO10 (data_mem_rdata[10]),
  .MEM0_DO9  (data_mem_rdata[9] ),
  .MEM0_DO8  (data_mem_rdata[8] ),
  .MEM0_DO7  (data_mem_rdata[7] ),
  .MEM0_DO6  (data_mem_rdata[6] ),
  .MEM0_DO5  (data_mem_rdata[5] ),
  .MEM0_DO4  (data_mem_rdata[4] ),
  .MEM0_DO3  (data_mem_rdata[3] ),
  .MEM0_DO2  (data_mem_rdata[2] ),
  .MEM0_DO1  (data_mem_rdata[1] ),
  .MEM0_DO0  (data_mem_rdata[0] ),

//VCC
//GND
  .MEM1_CK   (clk),
  .MEM1_CSB  (1'b0),
  .MEM1_OE   (1'b1),
  .MEM1_WEB3 (instr_mem_web[3]),
  .MEM1_WEB2 (instr_mem_web[2]),
  .MEM1_WEB1 (instr_mem_web[1]),
  .MEM1_WEB0 (instr_mem_web[0]),
  .MEM1_DVS3 (1'b0),
  .MEM1_DVS2 (1'b0),
  .MEM1_DVS1 (1'b0),
  .MEM1_DVS0 (1'b0),
  .MEM1_DVSE (1'b0),
  .MEM1_A12  (instr_mem_addr[14]),
  .MEM1_A11  (instr_mem_addr[13]),
  .MEM1_A10  (instr_mem_addr[12]),
  .MEM1_A9   (instr_mem_addr[11]),
  .MEM1_A8   (instr_mem_addr[10]),
  .MEM1_A7   (instr_mem_addr[9] ),
  .MEM1_A6   (instr_mem_addr[8] ),
  .MEM1_A5   (instr_mem_addr[7] ),
  .MEM1_A4   (instr_mem_addr[6] ),
  .MEM1_A3   (instr_mem_addr[5] ),
  .MEM1_A2   (instr_mem_addr[4] ),
  .MEM1_A1   (instr_mem_addr[3] ),
  .MEM1_A0   (instr_mem_addr[2] ),
  .MEM1_DI31 (instr_mem_wdata[31]),
  .MEM1_DI30 (instr_mem_wdata[30]),
  .MEM1_DI29 (instr_mem_wdata[29]),
  .MEM1_DI28 (instr_mem_wdata[28]),
  .MEM1_DI27 (instr_mem_wdata[27]),
  .MEM1_DI26 (instr_mem_wdata[26]),
  .MEM1_DI25 (instr_mem_wdata[25]),
  .MEM1_DI24 (instr_mem_wdata[24]),
  .MEM1_DI23 (instr_mem_wdata[23]),
  .MEM1_DI22 (instr_mem_wdata[22]),
  .MEM1_DI21 (instr_mem_wdata[21]),
  .MEM1_DI20 (instr_mem_wdata[20]),
  .MEM1_DI19 (instr_mem_wdata[19]),
  .MEM1_DI18 (instr_mem_wdata[18]),
  .MEM1_DI17 (instr_mem_wdata[17]),
  .MEM1_DI16 (instr_mem_wdata[16]),
  .MEM1_DI15 (instr_mem_wdata[15]),
  .MEM1_DI14 (instr_mem_wdata[14]),
  .MEM1_DI13 (instr_mem_wdata[13]),
  .MEM1_DI12 (instr_mem_wdata[12]),
  .MEM1_DI11 (instr_mem_wdata[11]),
  .MEM1_DI10 (instr_mem_wdata[10]),
  .MEM1_DI9  (instr_mem_wdata[9] ), 
  .MEM1_DI8  (instr_mem_wdata[8] ),
  .MEM1_DI7  (instr_mem_wdata[7] ),
  .MEM1_DI6  (instr_mem_wdata[6] ),
  .MEM1_DI5  (instr_mem_wdata[5] ),
  .MEM1_DI4  (instr_mem_wdata[4] ),
  .MEM1_DI3  (instr_mem_wdata[3] ),
  .MEM1_DI2  (instr_mem_wdata[2] ),
  .MEM1_DI1  (instr_mem_wdata[1] ),
  .MEM1_DI0  (instr_mem_wdata[0] ),
  .MEM1_DO31 (instr_ram_rdata[31]),
  .MEM1_DO30 (instr_ram_rdata[30]),
  .MEM1_DO29 (instr_ram_rdata[29]),
  .MEM1_DO28 (instr_ram_rdata[28]),
  .MEM1_DO27 (instr_ram_rdata[27]),
  .MEM1_DO26 (instr_ram_rdata[26]),
  .MEM1_DO25 (instr_ram_rdata[25]),
  .MEM1_DO24 (instr_ram_rdata[24]),
  .MEM1_DO23 (instr_ram_rdata[23]),
  .MEM1_DO22 (instr_ram_rdata[22]),
  .MEM1_DO21 (instr_ram_rdata[21]),
  .MEM1_DO20 (instr_ram_rdata[20]),
  .MEM1_DO19 (instr_ram_rdata[19]),
  .MEM1_DO18 (instr_ram_rdata[18]),
  .MEM1_DO17 (instr_ram_rdata[17]),
  .MEM1_DO16 (instr_ram_rdata[16]),
  .MEM1_DO15 (instr_ram_rdata[15]),
  .MEM1_DO14 (instr_ram_rdata[14]),
  .MEM1_DO13 (instr_ram_rdata[13]),
  .MEM1_DO12 (instr_ram_rdata[12]),
  .MEM1_DO11 (instr_ram_rdata[11]),
  .MEM1_DO10 (instr_ram_rdata[10]),
  .MEM1_DO9  (instr_ram_rdata[9] ),
  .MEM1_DO8  (instr_ram_rdata[8] ),
  .MEM1_DO7  (instr_ram_rdata[7] ),
  .MEM1_DO6  (instr_ram_rdata[6] ),
  .MEM1_DO5  (instr_ram_rdata[5] ),
  .MEM1_DO4  (instr_ram_rdata[4] ),
  .MEM1_DO3  (instr_ram_rdata[3] ),
  .MEM1_DO2  (instr_ram_rdata[2] ),
  .MEM1_DO1  (instr_ram_rdata[1] ),
  .MEM1_DO0  (instr_ram_rdata[0] ),

  .MBISTPG_CMP_STAT_ID_SEL        (RAM_MBISTPG_CMP_STAT_ID_SEL    ),
  .FL_CNT_MODE                    (RAM_FL_CNT_MODE                ),
  .MBISTPG_DIAG_EN                (RAM_MBISTPG_DIAG_EN            ),
  .MBISTPG_EN                     (RAM_MBISTPG_EN                 ),
  .BIST_SI                        (RAM_BIST_SI                    ),
  .MBISTPG_ASYNC_RESETN           (RAM_MBISTPG_ASYNC_RESETN       ),
  .MBISTPG_REDUCED_ADDR_CNT_EN    (RAM_MBISTPG_REDUCED_ADDR_CNT_EN),
  .MBISTPG_MEM_RST                (RAM_MBISTPG_MEM_RST            ),
  .MBISTPG_ALGO_MODE              (RAM_MBISTPG_ALGO_MODE          ),
  .LV_TM                          (RAM_LV_TM                      ),
  .TCK                            (RAM_TCK                        ),
  .TCK_MODE                       (RAM_TCK_MODE                   ),
  .MBISTPG_TESTDATA_SELECT        (RAM_MBISTPG_TESTDATA_SELECT    ),
  .BIST_SETUP                     (RAM_BIST_SETUP                 ),
  .BIST_SETUP2                    (RAM_BIST_SETUP2                ),
  .BIST_HOLD                      (RAM_BIST_HOLD                  ),
  .BIST_SHIFT                     (RAM_BIST_SHIFT                 ),
  .BIST_CLK                       (RAM_BIST_CLK                   ),
  .MBISTPG_GO                     (RAM_MBISTPG_GO                 ),
  .MBISTPG_DONE                   (RAM_MBISTPG_DONE               ),
  .MBISTPG_SO                     (RAM_MBISTPG_SO                 )
);

endmodule

