// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#include <stdio.h>
#include "pulpino.h"
#include "uart.h"
#include "gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"
#include "clock.h"
#include "adc.h"
#include "bootmenu.h"
#include "drv_rtc.h"

#define runfreertos

#ifdef runfreertos

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "semphr.h"
#include "portmacro.h"

#endif
//#include "boot_menu.c"
//#include "ymodem.c"

#define default_sysclock_rate 32000000

void check_uart(testresult_t *result, void (*start)(), void (*stop)());
void check_clock(testresult_t *result, void (*start)(), void (*stop)());
void check_adc(testresult_t *result, void (*start)(), void (*stop)());

#define assert_testcase( num, exp ) \
	if ( (exp) ) \
		printf( "test case %d passed", num ); \
	else\
		printf( "test case %d failed", num ); \

#define FORMAT_DATETIME "time: %4d-%02d-%02d %02d:%02d:%02d\r\n" 
void check_rtc(testresult_t *result, void (*start)(), void (*stop)())
{
	uint32_t year, mon, day, hour, min, sec;

	rtc_init();

	rtc_set_time(2016,2,28,23,59,58);
	//sleep_busy(10000000);
	rtc_get_time( &year, &mon, &day, &hour, &min, &sec );
	printf(FORMAT_DATETIME, year, mon, day, hour, min, sec );
	//assert_testcase( 1, (day == 29) )

	rtc_set_time(2018,2,28,23,59,58);
	//sleep_busy(32000000 * 2);
	rtc_get_time( &year, &mon, &day, &hour, &min, &sec );
	printf(FORMAT_DATETIME, year, mon, day, hour, min, sec );
	//assert_testcase( 2, ((day == 1) && (mon == 3)) )
	
}

void show_rtc()
{
	uint32_t year, mon, day, hour, min, sec;
	rtc_get_time( &year, &mon, &day, &hour, &min, &sec );
	uart_wait_tx_done();
	printf(FORMAT_DATETIME, year, mon, day, hour, min, sec );
}

void wdt_enable( int sec )
{
	*(unsigned volatile *)(0x1b000000) = (sec ) * 32768;
	*(unsigned volatile *)(0x1b000004) = 1;
}
void wdt_feed( )
{
	*(unsigned volatile *)(0x1b000008) = 0x76;
}

void set_gpio_values( unsigned int gpio_masks, unsigned int value )
{
	int i;

	int old_val = *(volatile int*) (GPIO_REG_PADOUT);
	old_val &= ~gpio_masks;

	old_val |= (gpio_masks & value);

	*(volatile int*) (GPIO_REG_PADOUT) = old_val;
#if 0
	for( i = 0; i < 32; i++ )
	{
		if( ( 0x1 << i ) & gpio_masks )
		{	
			set_pin_function(i, FUNC_GPIO);	
			set_gpio_pin_direction(i, DIR_OUT);
			set_gpio_pin_value( i, (value >> i) & 0x1 );
		}
	}
#endif
}

void check_gpio()
{
	int i;
	int max_gpios = 36;	
	set_pin_function(0, FUNC_GPIO);	
	set_gpio_pin_direction(0, DIR_OUT);
	set_pin_function(1, FUNC_GPIO); 
	set_gpio_pin_direction(1, DIR_OUT);

	while (1)
	{
		set_gpio_pin_value(0, 1);
		set_gpio_pin_value(1, 0);
		sleep_busy(1000000);

		set_gpio_pin_value(0, 0);
		set_gpio_pin_value(1, 1);
		sleep_busy(1000000);
	}
}

void check_uart_basic(testresult_t *result, void (*start)(), void (*stop)());

testcase_t testcases[] = {
  // { .name = "uart_basic",            .test = check_uart_basic           },
  { .name = "uart",                  .test = check_uart                 },
  //{ .name = "clock",                  .test = check_clock                 },
  //{ .name = "adc",                  .test = check_adc                 },
  {0, 0}
};


void ISR_UART0 (void)
{
	uart_rx_isr();
}
void ISR_UART1 (void)
{
	uart_rx_isr_interface(1);
}
void ISR_UART2 (void)
{
	uart_rx_isr_interface(2);
}
void ISR_UART3 (void)
{
	uart_rx_isr_interface(3);
}
void ISR_UART4 (void)
{
	uart_rx_isr_interface(4);
}
void ISR_UART5 (void)
{
	uart_rx_isr_interface(5);
}


void gen_isr( int isrnum )
{
	ICP |= (0x1 << isrnum);
}
#ifdef runfreertos
extern void TIMER_CMP_INT( void );
void ISR_TIMER0(void) {
  ICP = (1 << ISR_NUM_TMR0);  
  //TIMER_CMP_INT();
  asm volatile ("jal x0, TIMER_CMP_INT");
  //ICP = (1 << ISR_NUM_TMR0);
}

void print_tick()
{
	char result[32] = {0};
	int tick = xTaskGetTickCount();
	Int2Str( result, tick );
	SerialPutString( "----Tick: " );
	SerialPutString( result );
	SerialPutString( "\r\n" );
}

static int g_uart_loop_test = 1;
void cancel_uart_loop_test()
{
	g_uart_loop_test = 0;
}

void idle_tasks (void *pvParameters) {
	int val = 0;
	int_enable();

	char *test_string = "a-zAXYZ67890:;xQpT78'\n";
	char rcvStr[64] = {0};
	int tx_interface = 1;
	int rx_interface = 2;
	int loopcnt = 0;
	while(1) {

		vTaskDelay(3);

		wdt_feed();

		if( g_uart_loop_test )
		{
			uart_wait_tx_done_interface(tx_interface);
			uart_send_interface( tx_interface, test_string, strlen(test_string) );

			uart_receive_interface(rx_interface, rcvStr, 60);

			if( memcmp( test_string, rcvStr, strlen(test_string) ) != 0 )
				printf(" rx wrong str : %d, %s\r\n", rx_interface,  rcvStr );
			else if( loopcnt ++ >= 10000 )
			{
				printf(" rx str : %d, %s\r\n", rx_interface,  rcvStr );
				loopcnt = 0;
			}
			tx_interface++;
			if( tx_interface > 5 )
				tx_interface = 1;
			rx_interface = tx_interface + 1;
			if( rx_interface > 5 )
				rx_interface = 1;
		}
		//print_tick();

		taskYIELD();
		
		vPortYield();

		for(int i = 0; i < 1000; i++)
			portNOP();
	}

	vTaskDelete(NULL);

}


extern void *pxCurrentTCB;
TaskHandle_t taskHandle[2] = {0};
void run_test()
{
	char result[32] = {0};	
	xTaskCreate(idle_tasks, "Idle", 768, NULL, 1, &taskHandle[0]);
 	xTaskCreate(BootMenu, "scli", 768, NULL, 1, &taskHandle[1]);
	uart_wait_tx_done();
	printf(" -------Idle 0x%x scli 0x%x cur 0x%x\r\n", taskHandle[0], taskHandle[1], &pxCurrentTCB);
	sleep_busy(1000);
	vTaskStartScheduler();
}
void set_schedule(int enable)
{
	if( enable )
		IER |= 0x20000000;
	else
	{
		IER &= ~0x20000000;
		ICP = 0xFFFFFFFF;
	}
}
#else
void ISR_TIMER0 (void) // 29: timer A compare
{	
	ICP |= (1 << ISR_NUM_TMR0);
	//uart_sendchar('.');
}


void print_tick()
{
}

void set_schedule(int enable)
{
}
#define run_test BootMenu_Main_Menu

//#define run_test run_test2

void test_memw()
{
#if 1
	
	int32_t address = 0x00103000, length = 1, pattern = 0xa1b2c3d4, cnt = 1000010;
	int32_t cur_pattern, value;
	int i, j;
	char result[32];
	
	cur_pattern = pattern;

	for( j = 0; j < cnt; j++ )
	{
		cur_pattern = ~cur_pattern;

		for( i = 0; i < length; i++)
		{
			*(volatile unsigned int*)(address+4*i) = cur_pattern;
		}

		for( i = 0; i < length; i++)
		{
			value = *(volatile unsigned int*)(address+4*i);
			if(  value != cur_pattern )
			{
				uart_wait_tx_done();
				SerialPutString("test write failed at addr: ");
				uart_wait_tx_done();
				Int2Str(result, address+4*i);					
				SerialPutString(result);

				uart_wait_tx_done();
				SerialPutString(" cnt: ");
				Int2Str(result, j);
				uart_wait_tx_done();
				SerialPutString(result);

				uart_wait_tx_done();
				SerialPutString(" value: ");
				Int2Str(result, value);
				uart_wait_tx_done();
				SerialPutString(result);
				return ;	
				//break;			
			}
		}	
	}
	if( j >= cnt )
		SerialPutString("test write OK");
#endif
}
void run_test2()
{
	
	int_enable();

	__PT__(0x8+1*0x10) = 32000000/1000;
    	__PT__(0x4+1*0x10)  = 0x7; /* Timer A - enable interrupts, start timer */
	IER |= (1 << (ISR_NUM_TMR0 + 1) );

	int cnt = 32000000;

	while( --cnt >= 0 ) ;

	BootMenu_Main_Menu();
}

#endif

void check_adc_power_control()
{
	clock_config_adcclk(0);	 //32M
	ROUNDNUM_ADC = 0x8;
	CFG_ADC = 0xA000E;
	FIFOINT_ADC = 0x00100004;
	adc_power_control(0);
	adc_power_control(1);
	if( CFG_ADC != 0xA0000 || FIFOINT_ADC != 0x00100008 || ROUNDNUM_ADC != 0x1 )
	{
		uart_wait_tx_done();
		uart_send("adc power test failed\r\n", 30);
	}
	else
	{
		uart_wait_tx_done();
		uart_send("adc power test ok\r\n", 25);
	}
}
int main()
{
	int ret, total,clockrate;
	IER = 0;
	EER = 0;
	ICP = 0xffffffff;
	ECP = 0xffffffff;

	sleep_busy(100000);

	for( total = 5; total >=1; total-- )
	{
		uart_set_interface(total, 0, UART_BAUDRATE(32000000,115200));
		uart_enable_rxint_interface(total, 1);
	}
	uart_set_interface(0, 0, UART_BAUDRATE(32000000,921600));
	uart_enable_rxint_interface(0, 1);
	uart_wait_tx_done();
	uart_send("uart test\r\n", 11);

	//int_enable();

	//ret = run_suite(testcases);
	//check_adc(NULL,NULL,NULL);

	//check_clock(NULL,NULL,NULL);
	//BootMenu();
	//BootMenu_Main_Menu();
	
	//while(1);
	//check_adc_power_control();
	run_test();
	
	while(1);
	
	uart_enable_rxint(1);
	while(1) 
	{
		GetInputString();
	}

	run_test();
  return ret;
}
void check_uart_basic(testresult_t *result, void (*start)(), void (*stop)()) {
    char c;

    // *(volatile unsigned int*)(UART_REG_FCR) = 0x00; // disable 16byte FIFO and clear FIFOs
    uart_send("a", 1);

    uart_wait_tx_done();

    c = uart_getchar();
    if (c != 'a')
      result->errors++;

    // test clearing fifos
    return;
}

void check_uart(testresult_t *result, void (*start)(), void (*stop)()) {
  int i;
  int j;
  char c;
  // *(volatile unsigned int*)(UART_REG_FCR) = 0x00; // disable 16byte FIFO and clear FIFOs

  for (j = 0; j < 10; j++) {
    uart_wait_tx_done();
    uart_send("01234567", 8);
/*
    for (i = 0; i < 8; i++) {
      c = uart_getchar();

      if (c != '0' + i) {
        result->errors++;
        printf("Error: act: %c; exp: %c\n", c, '0' + i);
        return;
      }
    }*/
  }
}


void check_clock(testresult_t *result, void (*start)(), void (*stop)()) {
	int ret, i;
	int fail_cnt = 0;

	uart_wait_tx_done();
    	printf("clock testing started\r\n");
	sleep_busy(10000);

	ret = clock_switch_sysclk(SYSCLK_SOURCE_32MHZ);
	uart_set_cfg(0, UART_BAUDRATE(32000000,9600) );
	uart_wait_tx_done();
    	printf("set sysclk to 32M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);

	uart_wait_tx_done();
	ret = clock_switch_sysclk(SYSCLK_SOURCE_16MHZ);
	uart_set_cfg(0, UART_BAUDRATE(16000000,9600) );
    	printf("set sysclk to 16M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);

	uart_wait_tx_done();
	ret = clock_switch_sysclk(SYSCLK_SOURCE_8MHZ);
	uart_set_cfg(0, UART_BAUDRATE(8000000,9600) );
    	printf("set sysclk to 8M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);

	uart_wait_tx_done();
	ret = clock_switch_sysclk(SYSCLK_SOURCE_4MHZ);
	uart_set_cfg(0, UART_BAUDRATE(4000000,9600) );
    	printf("set sysclk to 4M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);

	uart_wait_tx_done();
	ret = clock_switch_sysclk(SYSCLK_SOURCE_2MHZ);
	uart_set_cfg(0, UART_BAUDRATE(2000000,9600) );
    	printf("set sysclk to 2M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);

	uart_wait_tx_done();
	ret = clock_switch_sysclk(SYSCLK_SOURCE_1MHZ);
	uart_set_cfg(0, UART_BAUDRATE(1000000,9600) );
    	printf("set sysclk to 1M done %d\r\n", ret);
	fail_cnt += (ret < 0);
	sleep_busy(100000);		

	for( i = 0; i < ACSCLK_SOURCE_NUM; i++)
	{
		uart_wait_tx_done();
		ret = clock_config_adcclk(ACSCLK_SOURCE_2MHZ);
	    	printf("set adcclk to %d done %d\r\n", i, ret);
		sleep_busy(100000);
	}

	uart_wait_tx_done();
	printf("fail cnt %d\r\n",fail_cnt);
	sleep_busy(100000);

	
}

void adc_sample( int cnt )
{
	int i = 0;
	do
	{
		sleep_busy(1000000);
		//adc_isr();
		i++;
	} while( i < cnt );
}

extern unsigned short adcsamplebuffer[ADC_MAX_CHANNEL][ADC_MAX_BFFER_LENTH];
extern unsigned char adcsamplecnt[ADC_MAX_CHANNEL];
void adc_show_sample_buffer()
{
	int i, j;

	//adc_isr();

	for( i = 0; i < ADC_MAX_CHANNEL; i ++ )
	{
		uart_wait_tx_done();
		printf("\r\nadc %d: ", i);
		for( j = 0; j < adcsamplecnt[i]; j++ )
		{
			uart_wait_tx_done();
			printf("%03x ",adcsamplebuffer[i][j]);
		}		
	}
	uart_wait_tx_done();
	printf("\r\n");
}

/* 0, OK, others failed*/
int adc_check_sample_result(unsigned char bitmask, int datacnt )
{
	int i, j;
	int ret = 0;
	for( i = 0; i < ADC_MAX_CHANNEL; i ++ )
	{
		if( bitmask & (0x1 << i) )
		{
			for( j = 0; j < ADC_MAX_BFFER_LENTH; j++ )
			{
				if( (j < datacnt && adcsamplebuffer[i][j] != ((i << 7) | ((adcsamplebuffer[i][0] + j) & 0x7f) ) ) ||
				    (j >= datacnt && adcsamplebuffer[i][j] != 0) )
					ret++;
				
			}
		}
	}
	if( ret == 0 )
	{
		uart_wait_tx_done();
		printf("\r\n sub case succeed! ");
	}
	return ret;
}
void ISR_ADCH (void)
{
	//uart_wait_tx_done();
	//uart_sendchar('H');
	adc_isr();
	//BootMenu_RunCmd("mem uint 4 \r\n");
}

void ISR_ADCF(void)
{
	//uart_wait_tx_done();
	//uart_sendchar('F');
	adc_isr();
	//BootMenu_RunCmd("mem uint 4 \r\n");
}

void check_adc(testresult_t *result, void (*start)(), void (*stop)()){
	int i, j;
	int failed = 0;
	
	clock_config_adcclk(0);	 //32M
	adc_power_control(0);
	adc_power_control(1);
	uart_wait_tx_done();
	
	/*case 1: single ch, seq output */
	uart_wait_tx_done();
	printf("\r\nadc test 1: single ch, seq output");
	for( j = 1; j <= 16; j++ )
	{
		printf("\r\ncnt %d: ", j);
		adc_reset_control(1);
		for( i = 0; i < ADC_MAX_CHANNEL; i++ )
		{
			adc_sample_control(0);
			adc_config_analog(0, 0, 0); // 16 div	
			adc_config_work_mode(0, 0x1<<i, 1, j);
			adc_config_int( 1, 1, 1, 16);
			adc_sample_control(1);
			//sleep_busy(1000000);
			adc_sample(1);
		}	
		adc_show_sample_buffer();
		if( adc_check_sample_result(0xff,j) )
		{
			failed ++;
			uart_wait_tx_done();
			printf ("test failed \r\n");
		}
	}	

	printf("\r\ncnt 32: ");
	adc_reset_control(1);
	for( i = 0; i < ADC_MAX_CHANNEL; i++ )
	{
		adc_sample_control(0);
		adc_config_analog(0, 0, 0); // 16 div	
		adc_config_work_mode(0, 0x1<<i, 1, 32);
		adc_config_int( 1, 1, 1, 16);
		adc_sample_control(1);
		//sleep_busy(1000000);
		adc_sample(2);
	}	
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,32) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	printf("\r\ncnt 64: ");
	adc_reset_control(1);
	for( i = 0; i < ADC_MAX_CHANNEL; i++ )
	{
		adc_sample_control(0);
		adc_config_analog(0, 0, 0); // 16 div	
		adc_config_work_mode(0, 0x1<<i, 1, 64);
		adc_config_int( 1, 1, 1, 16);
		adc_sample_control(1);
		//sleep_busy(1000000);
		adc_sample(4);
	}	
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,64) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}
	/*case 2: single ch, onehot output */
	uart_wait_tx_done();
	printf("\r\nadc test 2: single ch, onehot output");
	adc_reset_control(1);	
	for( i = 0; i < ADC_MAX_CHANNEL; i++ )
	{	
		adc_sample_control(0);
		adc_config_analog(0, 0, 3); // 96 div	
		adc_config_work_mode(0, 0x1 << i, 0, 1);
		adc_config_int( 1, 1, 1, 3);
		adc_sample_control(1);
		//sleep_busy(1000000);
		adc_sample(1);
	}
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,1) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	/*case 3: multi ch, onehot output */	
	uart_wait_tx_done();
	printf("\r\nadc test 3: multi ch, onhot output");
	printf("\r\n channels 0xDA:"); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 1); // 32 div	
	adc_config_work_mode(1, 0xDA, 0, 1);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(1000000);
	adc_sample(1);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xDA,1) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	printf("\r\n channels 0x25:"); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 1); // 32 div	
	adc_config_work_mode(1, 0x25, 0, 1);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(1000000);
	adc_sample(1);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0x25,1) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	printf("\r\n channels 0xff:"); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 1); // 32 div	
	adc_config_work_mode(1, 0xff, 0, 1);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(1000000);
	adc_sample(1);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,1) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	/*case 4: multi ch, multiple output */	
	uart_wait_tx_done();
	printf("\r\nadc test 4: multi ch, multiple output");
	for( j = 1; j <=16; j++ )
	{
		printf("\r\n channels 0x7B:%d ", j); 
		adc_reset_control(1);
		adc_config_analog(0, 0, 2); // 64div	
		adc_config_work_mode(1, 0x7B, 1, j);
		adc_config_int( 1, 1, 1, 16);
		adc_sample_control(1);
		//sleep_busy(10000000);
		adc_sample(j/2);
		adc_show_sample_buffer();
		if( adc_check_sample_result(0x7B,j) )
		{
			failed ++;
			uart_wait_tx_done();
			printf ("test failed \r\n");
		}
	}
	printf("\r\n channels 0x84:3 "); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 2); // 64div	
	adc_config_work_mode(1, 0x84, 1, 3);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(10000000);
	adc_sample(6);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0x84,3) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	/*case 5: all ch, multiple output */
	uart_wait_tx_done();
	printf("\r\nadc test 5: all ch, multiple output 2");
	adc_reset_control(1);
	adc_config_analog(0, 0, 0); // 16div	
	adc_config_work_mode(1, 0xff, 1, 2);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(10000000);
	adc_sample(2);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,2) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	printf("\r\nadc test 5: all ch, multiple output 64");
	adc_reset_control(1);
	adc_config_analog(0, 0, 0); // 16div	
	adc_config_work_mode(1, 0xff, 1, 64);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(10000000);
	adc_sample(32);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0xff,64) )
	{
		failed ++;
		uart_wait_tx_done();
		printf ("test failed \r\n");
	}

	/*case 6: multi ch, multiple output */
	uart_wait_tx_done();
	printf("\r\nadc test 6: multi ch, multiple output");
	printf("\r\n channels 0x6E:28 "); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 0); // 16div	
	adc_config_work_mode(1, 0x6E, 1, 28);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(10000000);
	adc_sample(10);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0x6E,28) )
	{
		uart_wait_tx_done();
		failed ++;
		printf ("test failed \r\n");
	}

	if( failed > 0 )
	{
		uart_wait_tx_done();
		printf ("adc test failed \r\n");
	}

	printf("\r\n channels 0x91:64 "); 
	adc_reset_control(1);
	adc_config_analog(0, 0, 0); // 16div	
	adc_config_work_mode(1, 0x91, 1, 64);
	adc_config_int( 1, 1, 1, 16);
	adc_sample_control(1);
	//sleep_busy(10000000);
	adc_sample(2);
	adc_show_sample_buffer();
	if( adc_check_sample_result(0x91,64) )
	{
		uart_wait_tx_done();
		failed ++;
		printf ("test failed \r\n");
	}

	if( failed > 0 )
	{
		uart_wait_tx_done();
		printf ("adc test failed: %d \r\n", failed);
	}
	else
	{
		printf ("adc test passed\r\n");
	}
	
}

