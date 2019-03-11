`ifndef SYNTHESIS
`include  "SHAA110_4096X8X4CM8.v" // 16kB RAM
`endif

module sp_ram_bank_16KB
(
  input logic BIST_SHIFT,
  input logic BIST_HOLD,
  input logic BIST_SETUP2,
  input logic BIST_SI,

  input logic MBISTPG_MEM_RST,
  input logic MBISTPG_ASYNC_RESETN,
  input logic MBISTPG_TESTDATA_SELECT,
  input logic [1:0] MBISTPG_ALGO_MODE,
  input logic MBISTPG_REDUCED_ADDR_CNT_EN,
  input logic MBISTPG_DIAG_EN,

  input logic TCK,
  input logic TCK_MODE,
  input logic [1:0] FL_CNT_MODE,

  input logic LV_TM,
  input logic [1:0] BIST_SETUP,
  input logic MBISTPG_EN,
  input logic [5:0] MBISTPG_CMP_STAT_ID_SEL,
  output logic MBISTPG_GO,
  output logic MBISTPG_SO,
  output logic MBISTPG_DONE,

  input  logic CK,
  input  logic [11:0] A,
  input  logic [31:0] DI,
  input  logic [3:0] WEB,
  output logic [31:0] DO
);

`ifndef MBIST_DISABLE
SMARCHCHKB_LVISION_MBISTPG_ASSEMBLY sp_ram_bank_16KB_mem(
    .BIST_CLK                    (CK                         ),

    .BIST_SHIFT                  (BIST_SHIFT                 ),
    .BIST_HOLD                   (BIST_HOLD                  ),
    .BIST_SETUP2                 (BIST_SETUP2                ),
    .BIST_SETUP                  (BIST_SETUP                 ),
    .MBISTPG_TESTDATA_SELECT     (MBISTPG_TESTDATA_SELECT    ),
    .TCK_MODE                    (TCK_MODE                   ),
    .TCK                         (TCK                        ),
    .LV_TM                       (LV_TM                      ),
    .MBISTPG_ALGO_MODE           (MBISTPG_ALGO_MODE          ),
    .MBISTPG_MEM_RST             (MBISTPG_MEM_RST            ),
    .MBISTPG_REDUCED_ADDR_CNT_EN (MBISTPG_REDUCED_ADDR_CNT_EN),
    .MBISTPG_ASYNC_RESETN        (MBISTPG_ASYNC_RESETN       ),
    .BIST_SI                     (BIST_SI                    ),
    .MBISTPG_EN                  (MBISTPG_EN                 ),
    .MBISTPG_DIAG_EN             (MBISTPG_DIAG_EN            ),
    .FL_CNT_MODE                 (FL_CNT_MODE                ),
    .MBISTPG_CMP_STAT_ID_SEL     (MBISTPG_CMP_STAT_ID_SEL    ),

    .MBISTPG_GO                  (MBISTPG_GO                 ),
    .MBISTPG_SO                  (MBISTPG_SO                 ),
    .MBISTPG_DONE                (MBISTPG_DONE               ),

  .A0(A[0]),.A1(A[1]),.A2(A[2]),.A3(A[3]),.A4(A[4]),.A5(A[5]),.A6(A[6]),.A7(A[7]),.A8(A[8]),.A9(A[9]),.A10(A[10]),.A11(A[11]),.DO0(DO[0]),.DO1(DO[1]),
  .DO2(DO[2]),.DO3(DO[3]),.DO4(DO[4]),.DO5(DO[5]),.DO6(DO[6]),.DO7(DO[7]),.DO8(DO[8]),.DO9(DO[9]),.DO10(DO[10]),.DO11(DO[11]),
  .DO12(DO[12]),.DO13(DO[13]),.DO14(DO[14]),.DO15(DO[15]),.DO16(DO[16]),.DO17(DO[17]),.DO18(DO[18]),.DO19(DO[19]),
  .DO20(DO[20]),.DO21(DO[21]),.DO22(DO[22]),.DO23(DO[23]),.DO24(DO[24]),.DO25(DO[25]),.DO26(DO[26]),.DO27(DO[27]),
  .DO28(DO[28]),.DO29(DO[29]),.DO30(DO[30]),.DO31(DO[31]),.DI0(DI[0]),.DI1(DI[1]),.DI2(DI[2]),.DI3(DI[3]),.DI4(DI[4]),
  .DI5(DI[5]),.DI6(DI[6]),.DI7(DI[7]),.DI8(DI[8]),.DI9(DI[9]),.DI10(DI[10]),.DI11(DI[11]),.DI12(DI[12]),.DI13(DI[13]),.DI14(DI[14]),
  .DI15(DI[15]),.DI16(DI[16]),.DI17(DI[17]),.DI18(DI[18]),.DI19(DI[19]),.DI20(DI[20]),.DI21(DI[21]),.DI22(DI[22]),
  .DI23(DI[23]),.DI24(DI[24]),.DI25(DI[25]),.DI26(DI[26]),.DI27(DI[27]),.DI28(DI[28]),.DI29(DI[29]),.DI30(DI[30]),
  .DI31(DI[31]),.WEB0(WEB[0]),.WEB1(WEB[1]),.WEB2(WEB[2]),.WEB3(WEB[3]),.DVSE(1'b0),.DVS0(1'b0),.DVS1(1'b0),
  .DVS2(1'b0),.DVS3(1'b0),.CSB(1'b0),.OE(1'b1)
);

`else
`ifndef SYNTHESIS
SHAA110_4096X8X4CM8 mem(
  .A0(A[0]),.A1(A[1]),.A2(A[2]),.A3(A[3]),.A4(A[4]),.A5(A[5]),.A6(A[6]),.A7(A[7]),.A8(A[8]),.A9(A[9]),.A10(A[10]),.A11(A[11]),.DO0(DO[0]),.DO1(DO[1]),
  .DO2(DO[2]),.DO3(DO[3]),.DO4(DO[4]),.DO5(DO[5]),.DO6(DO[6]),.DO7(DO[7]),.DO8(DO[8]),.DO9(DO[9]),.DO10(DO[10]),.DO11(DO[11]),
  .DO12(DO[12]),.DO13(DO[13]),.DO14(DO[14]),.DO15(DO[15]),.DO16(DO[16]),.DO17(DO[17]),.DO18(DO[18]),.DO19(DO[19]),
  .DO20(DO[20]),.DO21(DO[21]),.DO22(DO[22]),.DO23(DO[23]),.DO24(DO[24]),.DO25(DO[25]),.DO26(DO[26]),.DO27(DO[27]),
  .DO28(DO[28]),.DO29(DO[29]),.DO30(DO[30]),.DO31(DO[31]),.DI0(DI[0]),.DI1(DI[1]),.DI2(DI[2]),.DI3(DI[3]),.DI4(DI[4]),
  .DI5(DI[5]),.DI6(DI[6]),.DI7(DI[7]),.DI8(DI[8]),.DI9(DI[9]),.DI10(DI[10]),.DI11(DI[11]),.DI12(DI[12]),.DI13(DI[13]),.DI14(DI[14]),
  .DI15(DI[15]),.DI16(DI[16]),.DI17(DI[17]),.DI18(DI[18]),.DI19(DI[19]),.DI20(DI[20]),.DI21(DI[21]),.DI22(DI[22]),
  .DI23(DI[23]),.DI24(DI[24]),.DI25(DI[25]),.DI26(DI[26]),.DI27(DI[27]),.DI28(DI[28]),.DI29(DI[29]),.DI30(DI[30]),
  .DI31(DI[31]),.VCC(1'b1),.GND(1'b0),.WEB0(WEB[0]),.WEB1(WEB[1]),.WEB2(WEB[2]),.WEB3(WEB[3]),.DVSE(1'b0),.DVS0(1'b0),.DVS1(1'b0),
  .DVS2(1'b0),.DVS3(1'b0),.CK(CK),.CSB(1'b0),.OE(1'b1)
);
`else
SHAA110_4096X8X4CM8 mem(
  .A0(A[0]),.A1(A[1]),.A2(A[2]),.A3(A[3]),.A4(A[4]),.A5(A[5]),.A6(A[6]),.A7(A[7]),.A8(A[8]),.A9(A[9]),.A10(A[10]),.A11(A[11]),.DO0(DO[0]),.DO1(DO[1]),
  .DO2(DO[2]),.DO3(DO[3]),.DO4(DO[4]),.DO5(DO[5]),.DO6(DO[6]),.DO7(DO[7]),.DO8(DO[8]),.DO9(DO[9]),.DO10(DO[10]),.DO11(DO[11]),
  .DO12(DO[12]),.DO13(DO[13]),.DO14(DO[14]),.DO15(DO[15]),.DO16(DO[16]),.DO17(DO[17]),.DO18(DO[18]),.DO19(DO[19]),
  .DO20(DO[20]),.DO21(DO[21]),.DO22(DO[22]),.DO23(DO[23]),.DO24(DO[24]),.DO25(DO[25]),.DO26(DO[26]),.DO27(DO[27]),
  .DO28(DO[28]),.DO29(DO[29]),.DO30(DO[30]),.DO31(DO[31]),.DI0(DI[0]),.DI1(DI[1]),.DI2(DI[2]),.DI3(DI[3]),.DI4(DI[4]),
  .DI5(DI[5]),.DI6(DI[6]),.DI7(DI[7]),.DI8(DI[8]),.DI9(DI[9]),.DI10(DI[10]),.DI11(DI[11]),.DI12(DI[12]),.DI13(DI[13]),.DI14(DI[14]),
  .DI15(DI[15]),.DI16(DI[16]),.DI17(DI[17]),.DI18(DI[18]),.DI19(DI[19]),.DI20(DI[20]),.DI21(DI[21]),.DI22(DI[22]),
  .DI23(DI[23]),.DI24(DI[24]),.DI25(DI[25]),.DI26(DI[26]),.DI27(DI[27]),.DI28(DI[28]),.DI29(DI[29]),.DI30(DI[30]),
  .DI31(DI[31]),.WEB0(WEB[0]),.WEB1(WEB[1]),.WEB2(WEB[2]),.WEB3(WEB[3]),.DVSE(1'b0),.DVS0(1'b0),.DVS1(1'b0),
  .DVS2(1'b0),.DVS3(1'b0),.CK(CK),.CSB(1'b0),.OE(1'b1)
);
`endif
`endif//MBIST_DISABLE

endmodule
