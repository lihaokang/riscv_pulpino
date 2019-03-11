


#include "drv_eflash.h"
#include "string_lib.h"
#include "uart.h"


uint32_t buf[256];

int main(void)
{
	volatile uint32_t delay;
	int year, month, day, hour, min, sec;

	uart_set_cfg(0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	printf("eflash test\n");

	printf("[0x00110080]=0x%08X\n", *((volatile unsigned int *)0x00110080));
	///*
	buf[0] = 0x12345678;
	eflash_write_main_page(48, (const uint32_t *)buf);
	printf("st1\n");
	buf[0] = 0;
	eflash_read_main_page(48, buf);
	printf("st2\n");
	if (buf[0] == 0x12345678)
		printf("main page pass\n");
	else
		printf("main page error\n");

	printf("[0x00110080]=0x%08X\n", *((volatile unsigned int *)0x00110080) );
/*
	buf[0] = 0xaa5555aa;
	eflash_write_info_page(0, (const uint32_t *)buf);
	printf("st3\n");
	buf[0] = 0;
	eflash_read_info_page(0, buf);
	printf("st4\n");
	if (buf[0] == 0xaa5555aa)
		printf("info page pass\n");
	else
		printf("info page error\n");
	*/
	printf("[0x00110080]=0x%08X\n", *((volatile unsigned int *)0x00110080));
	while (1)
	{
	}

	return 0;
}

