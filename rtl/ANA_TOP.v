module ANA_TOP ( 
  output PVD_OUT,
  input PD_PVD,
  output RING32K_CLK_RDY,
  input ADC_RESETB,
  input PD_LDO15,
  input ADC_CLKIN,
  input  [1:0] ATEST_SEL,
  input SHORTXIXO,
  output RING32M_CLK,
  inout XI,//spad
  input  [3:0] FREQ_SEL_RING32K,
  output XTAL32K_CLK,
  output ADC_CKOUT,
  inout XO,//spad
  output RING32K_CLK,
  input  [3:0] PVD_SEL,
  input  [7:0] FREQ_SEL_RING32M,
  //inout VOUT_LDO,//VDD
  input EN_XTAL32K,
  inout ANA_TOP_TP,//spad
  input PD_RING32M,
  inout ADC_VRP_EXT,//spad
  output  [9:0] ADC_DOUT,
  output RESETB,
  input ADC_START,
  //inout VCC,//VCC
  input  [15:0] ADC_REG_IN_0,
  input ATEST_EN,
  input EXT_EN_XTAL32K,
  inout [7:0] ADC_IN,
  //inout ADC_IN_7,//spad
  //inout ADC_IN_6,//spad
  //inout ADC_IN_5,//spad
  //inout ADC_IN_4,//spad
  //inout ADC_IN_3,//spad
  //inout ADC_IN_2,//spad
  //inout ADC_IN_1,//spad
  //inout ADC_IN_0,//spad
  input  [15:0]ADC_REG_IN_1,
  output RING32M_CLK_RDY,
  //inout AVSS,//VSS
  input PD_V2I,
  inout ADC_VRM_EXT//spad
);
endmodule
