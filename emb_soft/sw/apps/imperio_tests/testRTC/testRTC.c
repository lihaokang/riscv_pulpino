


#include "drv_rtc.h"
#include "string_lib.h"
#include "uart.h"

#if 0
int main(void)
{
	volatile uint32_t delay;
	int year, month, day, hour, min, sec;

	uart_set_cfg(0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	rtc_deinit();
	rtc_init();
	//rtc_set_time(2019, 2, 28, 23, 58, 10);
	//rtc_set_time(2020, 2, 28, 23, 58, 10);
	rtc_set_time(2020, 2, 29, 23, 58, 10);
	rtc_enable();

	while (1)
	{
		rtc_get_time((uint32_t *)&year, (uint32_t *)&month, (uint32_t *)&day, (uint32_t *)&hour, (uint32_t *)&min, (uint32_t *)&sec);
		printf("year=%d, month=%d, day=%d, hour=%d, min=%d, sec=%d\n", year, month, day, hour, min, sec);
		delay = 16000000;
		while (--delay);
	}

	return 0;
}
#else


int main(void)
{
	volatile uint32_t delay;
	int year, month, day, hour, min, sec;

	uart_set_cfg(0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	rtc_deinit();
	rtc_init();
	rtc_set_time(2020, 2, 29, 23, 58, 59);
	rtc_enable();

	rtc_set_alarm(6, 29, 23, 59, 1, 1, 1, 1);
	rtc_alarm_enable();
	rtc_alarm_int_enable();
	int_enable();


	while (1)
	{
		rtc_get_time((uint32_t *)&year, (uint32_t *)&month, (uint32_t *)&day, (uint32_t *)&hour, (uint32_t *)&min, (uint32_t *)&sec);
		printf("year=%d, month=%d, day=%d, hour=%d, min=%d, sec=%d\n", year, month, day, hour, min, sec);
		delay = 16000000;
		while (--delay);
	}

	return 0;
}

#endif



void ISR_RTC(void)
{
	int year, month, day, hour, min, sec;

	printf("rtc int\n\n\n\n");
	
	rtc_get_time((uint32_t *)&year, (uint32_t *)&month, (uint32_t *)&day, (uint32_t *)&hour, (uint32_t *)&min, (uint32_t *)&sec);
	printf("year=%d, month=%d, day=%d, hour=%d, min=%d, sec=%d\n", year, month, day, hour, min, sec);

	rtc_alarm_reset();
	
	ICP = RTC_EVT;
	ECP = RTC_EVT;	
}
