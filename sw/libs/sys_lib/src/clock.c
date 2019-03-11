#include "utils.h"
#include "clock.h"
#include "pulpino.h"
#include "int.h"

static void clock_config_sysclk( int source )
{
	int states = disable_cpu_int();
	int_disable();
	SCS_CLOCK = source;
	sleep_busy(1000);
	int_enable();
	enable_cpu_int(states);		
}

int clock_config_adcclk( int source )
{
	int ret = 0;
	switch( source )
	{
	case ACSCLK_SOURCE_32MHZ:
	case ACSCLK_SOURCE_16MHZ:
	case ACSCLK_SOURCE_8MHZ:
	case ACSCLK_SOURCE_4MHZ:
	case ACSCLK_SOURCE_2MHZ:
	case ACSCLK_SOURCE_1MHZ:
		if( CSS_CLOCK & CSS_STATE_RC32M_READY )
		{
			ACS_CLOCK = source;
		}
		else
		{
			ret = -1;
		}
		break;
	
	default:
		ret = -1;
	}
	return ret;
}

int clock_config_lsclk( int source )
{
	int ret = -1;
	if( source == 0)
	{
		if( CSS_CLOCK & CSS_STATE_RC32K_READY )
		{
			LCS_CLOCK = 0;
			ret = 0;
		}
	}
	else if( source == 1)
	{
		if( CSS_CLOCK & CSS_STATE_EXT_READY )
		{
			LCS_CLOCK = 1;
			ret = 0;
		}
	}
	return ret;
}

int clock_config_extclk( int source )
{
	int ret = -1;
	if( source < ECSCLK_SOURCE_NUM)
	{
		ECS_CLOCK = source;
		ret = 0;
	}
	
	if( ECS_CLOCK != source)
		ret = -1;
	
	return ret;
}


/*
 0 - power up
 1 - power down
*/
int clock_powerdown_32mclk( int powerdown )
{
	int ret = 0;
	if( powerdown )
	{
		if( (SCS_CLOCK & 0x7) <= SYSCLK_SOURCE_1MHZ )
		{
			ret = -1;
		}
		else
		{
			HCM_CLOCK = 0x31415926;
		}
	}
	else
	{
		if( (CSS_CLOCK & CSS_STATE_RC32M_PDR) )
		{
			HCM_CLOCK = 0x12345678;
		}
	}
	return ret;
}

int clock_switch_sysclk( int source )
{
	unsigned int timeout = 32000000;
	unsigned int loop = 0;
	int ret = -1;
	
	if( source <= SYSCLK_SOURCE_1MHZ )
	{
		if( (CSS_CLOCK & CSS_STATE_RC32M_PDR))
			clock_powerdown_32mclk(0);
		
		while( !(CSS_CLOCK & CSS_STATE_RC32M_READY) && loop++ < timeout )
			__asm volatile 	( " nop " );

		if( (CSS_CLOCK & CSS_STATE_RC32M_READY) )
		{
			clock_config_sysclk(source);
			ret = 0;
		}			
	}
	else if( source == SYSCLK_SOURCE_32KHZ)
	{
		while( !(CSS_CLOCK & CSS_STATE_RC32K_READY) && loop++ < timeout )
			__asm volatile 	( " nop " );

		if( (CSS_CLOCK & CSS_STATE_RC32K_READY) )
		{
			clock_config_sysclk(source);
			ret = 0;
		}	
	}
	else if( source == SYSCLK_SOURCE_EXT)
	{
		if( (ECS_CLOCK & 0x2) == 0x2 ) /*only Enabled*/
		{
			while( !(CSS_CLOCK & CSS_STATE_EXT_READY) && loop++ < timeout )
				__asm volatile 	( " nop " );

			if( (CSS_CLOCK & CSS_STATE_EXT_READY) )
			{
				clock_config_sysclk(source);
				ret = 0;
			}	
		}
	}
	if( ret == 0 && (SCS_CLOCK != source) )
		ret = -1;

	
	return ret;
}

unsigned int clock_get_status()
{
	return CSS_CLOCK;
}

unsigned int clock_get_sysclk_config()
{
	return SCS_CLOCK;
}
