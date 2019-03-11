//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : adc.c                    				    //
//  				Author       : huiyng cao                   				//
//  				Description  : adc comsm test function file         		//
//  				Create Date  : 2019/02/12                 				    //
//                  Review Date  : 2019/02/12  				                    //
//==============================================================================//

#include <adc.h>

void adc_delay(int number){
	volatile int i;
	for (i=number;i>0;i--);
}

void apb_adc_write(int address,int data) {
    *(volatile int*) (address) = data;
}

int *apb_adc_read(int address,int number,int data[number]) {
	volatile int i;
	for(i=0;i<number;i=i+1){
	data[i] = *(volatile int*) (address);}
    return data;
}

void adc_cfg_default() {
	apb_adc_write(ADC_CFG_REG,ADC_CFG_DEAFAULT);
	apb_adc_write(ADC_CTL_REG,ADC_CTL_STR);
	adc_delay(5);
	apb_adc_write(ADC_CTL_REG,ADC_CTL_CLEAR);
	adc_delay(5);
	apb_adc_read(ADC_DOUT_REG,1,0); 
}

void adc_cfg_slect_onehot(int operation) {
	volatile char adc_in_ini=0x80;
	volatile int adc_cfg_slect_onehot=0x0;
	adc_cfg_slect_onehot &=(~(0xff<<1));
	adc_cfg_slect_onehot |= (adc_in_ini<<1);
	adc_cfg_slect_onehot &=(~(0xf<<16));
	adc_cfg_slect_onehot |= (SELECT_ONEHOT<<16);
	volatile char i;
	if(operation==1){
		for(i=0;i<8;i=i+1){
			adc_delay(5);
			apb_adc_write(ADC_CFG_REG,adc_cfg_slect_onehot);
			adc_delay(5);
			apb_adc_write(ADC_CTL_REG,ADC_CTL_STR);
			adc_delay(5);
			apb_adc_write(ADC_CTL_REG,ADC_CTL_CLEAR);
			adc_in_ini=adc_in_ini>>1;
			adc_cfg_slect_onehot &=(~(0xff<<1));
			adc_cfg_slect_onehot |= (adc_in_ini<<1);}}
	else if(operation==2){
		for(i=0;i<255;i=i+1){
			adc_delay(5);
			apb_adc_write(ADC_CFG_REG,adc_cfg_slect_onehot);
			adc_delay(5);
			apb_adc_write(ADC_CTL_REG,ADC_CTL_STR);
			adc_delay(5);
			apb_adc_write(ADC_CTL_REG,ADC_CTL_CLEAR);
			adc_in_ini=adc_in_ini+1;
			adc_cfg_slect_onehot &=(~(0xff<<1));
			adc_cfg_slect_onehot |= (adc_in_ini<<1);}
			apb_adc_read(ADC_DOUT_REG,16,0);}
	else{}
}
