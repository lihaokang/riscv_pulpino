/**
 * @file
 * @brief Clock library.
 *
 * Provides Clock helper function like setting
 * control registers and reading/writing over
 * the serial interface.
 *
 */
#ifndef _ADC_H
#define _ADC_H

#include "pulpino.h"
#include <stdint.h>

#define ADC_BASE_ADDR 0x1b004000

#define ADC_REG_CFG (ADC_BASE_ADDR+0x0)
#define ADC_REG_ROUNDNUM (ADC_BASE_ADDR+0x4)
#define ADC_REG_FIFOINT (ADC_BASE_ADDR+0x8)
#define ADC_REG_CTL (ADC_BASE_ADDR+0xC)
#define ADC_REG_DOUT (ADC_BASE_ADDR+0x10)
#define ADC_REG_FIFOSTATE (ADC_BASE_ADDR+0x14)


#define CFG_ADC REG(ADC_REG_CFG)
#define ROUNDNUM_ADC REG(ADC_REG_ROUNDNUM)
#define FIFOINT_ADC REG(ADC_REG_FIFOINT)
#define CTL_ADC REG(ADC_REG_CTL)
#define DOUT_ADC REG(ADC_REG_DOUT)
#define FIFOSTATE_ADC REG(ADC_REG_FIFOSTATE)

#define ADC_REG_FIFOSTATE_EMPTY 0x2
#define ADC_REG_FIFOSTATE_FULL 0x1

#define ADC_REG_FIFOSTATE_NUM(val) ((val) >> 16)



#define ADC_MAX_CHANNEL 8
#define ADC_MAX_BFFER_LENTH 64

void adc_power_control( int up );
void adc_sample_control( int up );
void adc_config_analog( char vpr, char vrm, char clock_div);
void adc_config_work_mode( unsigned char ch_mode, unsigned char ch_mask, 
	unsigned char sample_mode, unsigned short roundnum );
void adc_config_int(unsigned char half_en, unsigned short half_depth,
	unsigned char full_en, unsigned short full_depth);
void adc_isr();


#endif

