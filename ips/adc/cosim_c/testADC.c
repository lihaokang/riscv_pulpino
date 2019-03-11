//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : testADC.c                  				    //
//  				Author       : huiyng cao                   				//
//  				Description  : adc comsm test file         				    //
//  				Create Date  : 2019/02/12                 				    //
//                  Review Date  : 2019/02/12  				                    //
//==============================================================================//


#include "utils.h"
#include "string_lib.h"
#include "bar.h"
#include "adc.h"

int main()
{

  // apb_adc_write(CFG,ADC_CFG_DEAFAULT);
  // apb_adc_write(CTL,ADC_CTL_STR);
  // printf("Start Smaple!\n");
  // apb_adc_read(ADC_DOUT_REG);
  // adc_cfg_default();
  adc_cfg_slect_onehot(2);
  printf("Don!!!!!\n");
  
  return 0;
}
