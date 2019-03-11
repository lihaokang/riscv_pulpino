#include "adc.h"
#include "utils.h"
#include "int.h"

unsigned short adcsamplebuffer[ADC_MAX_CHANNEL][ADC_MAX_BFFER_LENTH] = {0};
unsigned char adcsamplecnt[ADC_MAX_CHANNEL] = {0};

void adc_power_control( int up )
{
	unsigned int val = CFG_ADC;
	if( up )
	{
		CFG_ADC = val & ~0x1;
	}
	else
	{
		CFG_ADC = val | 0x1;
	}
}

void adc_reset_control( int up )
{
	unsigned int val = CTL_ADC;
	int i,j;	
#if 1
	CTL_ADC = val | 0x1;
	sleep_busy(1000);
	if( up )
	{			
		CTL_ADC = val & ~0x1;
	}
#endif	
	for( i = 0; i < ADC_MAX_CHANNEL; i ++ )
	{
		for( j = 0; j < ADC_MAX_BFFER_LENTH; j++ )
		{
			adcsamplebuffer[i][j] = 0;
		}
		
		adcsamplecnt[i] = 0;
	}

	
}

void adc_sample_control( int up )
{
	unsigned int val = CTL_ADC;

	CTL_ADC = (val & ~0x2);

	CTL_ADC = (up) ? (val | 0x2) : (val & ~0x2);
}


void adc_config_analog( char vpr, char vrm, char clock_div)
{
	unsigned int val = CFG_ADC;
	val &= ~((0x3 <<9) | (0x1<<11) | (0x3 << 13) );
	val |= ( (vpr & 0x3) << 9) | ((vrm & 0x1) << 11) | ((clock_div & 0x3) << 13);

	CFG_ADC = val;
}

/*
ch_mode: 0 - single channel model, 1 - scan mode/multi-channels mode
ch_mask: the working channels
sample_mode: single sampling  or r  sequence sampling mode
roundnum: the number of sample per channel when sequence mode
*/
void adc_config_work_mode( unsigned char ch_mode, unsigned char ch_mask, 
	unsigned char sample_mode, unsigned short roundnum )
{
	unsigned int val = CFG_ADC;
	val &= ~((0x3 << 18) | (0x3<<16) | (0xff << 1) );

	val |= (ch_mode == 0 ) ? (0x1 << 19) : (0x1 << 18);
	val |= (ch_mask & 0xff) << 1;

	val |= (sample_mode == 0 ) ? (0x1 << 17) : (0x1 << 16);

	ROUNDNUM_ADC = roundnum;

	CFG_ADC = val;
}

void adc_config_int(unsigned char half_en, unsigned short half_depth,
	unsigned char full_en, unsigned short full_depth)
{	
	unsigned int val = CTL_ADC;
	val &= ~0xc;
	val |= (half_en ? 0x4 : 0x0);
	val |= (full_en ? 0x8 : 0x0);
	
	FIFOINT_ADC = (full_depth << 16) | half_depth;
	CTL_ADC = val;

	IER |= (0x1<<ISR_NUM_ADCH) | (0x1<<ISR_NUM_ADCF);
	
}

unsigned short adc_read_data( )
{
	unsigned short val = DOUT_ADC;

	return val;
}

unsigned short adc_read_chdata( )
{
	unsigned short val = DOUT_ADC;

	return val;
}


void adc_isr()
{
	unsigned int val, state;
	unsigned char ch;
	int cnt = 0;
	
	ICP = (1 << ISR_NUM_ADCH) | ( 1 << ISR_NUM_ADCF);

	state = FIFOSTATE_ADC;
	while( ADC_REG_FIFOSTATE_NUM(state) > 0 )
	{
		val = DOUT_ADC;
		ch = (val >>10) & 0xf;
		if( ch > 0 && ch <= ADC_MAX_CHANNEL )
		{
			ch = ch -1;
			if( adcsamplecnt[ch] < ADC_MAX_BFFER_LENTH )
			{
				adcsamplebuffer[ch][adcsamplecnt[ch]] = val & 0x3ff;
				adcsamplecnt[ch]++;	
			}		
		}
		
		/*if( adcsamplecnt[ch]>=ADC_MAX_BFFER_LENTH)
			adcsamplecnt[ch] = 0;*/
		state = FIFOSTATE_ADC;
		if( ++cnt > 1024 )
		{
			uart_wait_tx_done();
			uart_send(" adc_isr timeout\r\n", 17);
			break;
		}		
	}
#if 0
	uart_wait_tx_done();
	if( cnt < 10 )
		uart_sendchar( cnt + '0');
	else
		uart_sendchar( (cnt&0x1f) - 10 + 'a');
	uart_wait_tx_done();
#endif
	//ICP = (1 << ISR_NUM_ADCH) | ( 1 << ISR_NUM_ADCF);
}

