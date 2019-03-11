//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : adc.h                    				    //
//  				Author       : huiyng cao                   				//
//  				Description  : adc comsm test head file         		    //
//  				Create Date  : 2019/02/12                 				    //
//                  Review Date  : 2019/02/12  				                    //
//==============================================================================//
#ifndef _ADC_H_
#define _ADC_H_

#include <pulpino.h>

#define ADC_CFG_REG               	( ADC_BASE_ADDR + 0x00 )
#define ADC_ROUND_NUM               ( ADC_BASE_ADDR + 0x04 )
#define ADC_FIFO_INT               	( ADC_BASE_ADDR + 0x08 )
#define ADC_CTL_REG                	( ADC_BASE_ADDR + 0x0C )
#define ADC_DOUT_REG             	( ADC_BASE_ADDR + 0x10 )
#define ADC_FIFO_STATE             	( ADC_BASE_ADDR + 0x14 )


#define CFG 				REGP(ADC_CFG_REG)
#define RNUM 				REGP(ADC_ROUND_NUM)
#define FIFOINT 			REGP(ADC_FIFO_INT)
#define CTL 				REGP(ADC_CTL_REG)
#define DOUT 				REGP(ADC_DOUT_REG)
#define FIFOSTATE 			REGP(ADC_FIFO_STATE)

#define SELECT_ONEHOT  0xA
#define SELECT_SEQ     0x9
#define SCAN_ONEHOT    0x6
#define SCAN_SEQ       0x5

#define ADC_IN7  0x80
//adc CONFIG REGISTER describe
#define ADC_CFG_DEAFAULT 0xA0000 //slect-onehot_adcin7=1
//adc control register describe
#define ADC_CTL_RST 		0x0 
#define ADC_CTL_CLEAR 		0x1
#define ADC_CTL_STR 		0x3
#define ADC_FIFO_OVERFLOW 	0x4

void apb_adc_write(int address, int data);
int  *apb_adc_read(int address,int number,int data[number]);
void adc_cfg_default();
void adc_delay(int number);
void adc_cfg_slect_onehot(int operation);

#endif // _ADC_H_
