// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "xprintf.h"

#include "proton.h"
#include "int.h"
#include "drv_timer.h"
#include "drv_console.h"
#include "drv_gpio.h"
#include "drv_pwm.h"
#include "drv_rtc.h"
#include "drv_wdt.h"
#include "drv_clock.h"


volatile uint32_t count[4] = {0, 0, 0, 0};
volatile uint32_t reg;
volatile uint32_t ret;
volatile uint32_t i; 

void ISR_TIMER1(void) 
{
	/*reg = 0;
	for (i=1; i<1024; i++)
	{
		reg = i;
		ret = reg;
		if (ret != i)
		{
			xprintf("memory bist error\n\n\n\n\n\n");
		}
	}*/

	TIMER1_INT_RESET();
	count[1]++;
}

void ISR_TIMER2(void) 
{
	TIMER2_INT_RESET();
	count[2]++;
}

void ISR_TIMER3(void) 
{
	TIMER3_INT_RESET();
	count[3]++;
}


int timer_set(void) 
{
	timer_deinit(TIMER1);
	timer_set_prescaler(TIMER1, 1);
	timer_set_output_cmp(TIMER1, 16000);	/* 1mS */
	timer_start(TIMER1);
	timer_int_enable(TIMER1);

	timer_deinit(TIMER2);
	timer_set_prescaler(TIMER2, 1);
	timer_set_output_cmp(TIMER2, 16000);	/* 1mS */
	timer_start(TIMER2);
	timer_int_enable(TIMER2);

	timer_deinit(TIMER3);
	timer_set_prescaler(TIMER3, 1);
	timer_set_output_cmp(TIMER3, 16000);	/* 1mS */
	timer_start(TIMER3);
	timer_int_enable(TIMER3);

	return 0;
}

char uart_getc(void)
{
	return console_get_char();
}

void uart_putc(char c)
{
	console_send_char(c);
}

void xprintf_init(void)
{
	xdev_out(uart_putc);
	xdev_in(uart_getc);
}

void prvSetupHardware(void)
{
	system_clock_set(SYSCLK_FREQ_32M);
	
	console_init(115200);

	xprintf_init();
	timer_set();
	int_enable();
}

void task1(void *pvParameters) 
{
	while (1) 
	{
		xprintf("Task 1\n");

		vTaskDelay( 1 * configTICK_RATE_HZ );
	}

	vTaskDelete(NULL);
}

void task2(void *pvParameters) 
{
	while (1) 
	{
		xprintf("Task 2\n");

		vTaskDelay( 1 * configTICK_RATE_HZ );
	}

	vTaskDelete(NULL);
}

void led_task(void *pvParameters) 
{
	gpio_func_set(0, FUNC2_GPIO);
	gpio_mode_set(0, GPIO_MODE_OUT_PP);
	gpio_func_set(1, FUNC2_GPIO);
	gpio_mode_set(1, GPIO_MODE_OUT_PP);
	gpio_func_set(2, FUNC2_GPIO);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	gpio_func_set(3, FUNC2_GPIO);
	gpio_mode_set(3, GPIO_MODE_OUT_PP);
	gpio_func_set(4, FUNC2_GPIO);
	gpio_mode_set(4, GPIO_MODE_OUT_PP);
	gpio_func_set(5, FUNC2_GPIO);
	gpio_mode_set(5, GPIO_MODE_OUT_PP);
	gpio_func_set(6, FUNC2_GPIO);
	gpio_mode_set(6, GPIO_MODE_OUT_PP);
	gpio_func_set(7, FUNC2_GPIO);
	gpio_mode_set(7, GPIO_MODE_OUT_PP);
	gpio_func_set(8, FUNC2_GPIO);
	gpio_mode_set(8, GPIO_MODE_OUT_PP);
	gpio_func_set(9, FUNC2_GPIO);
	gpio_mode_set(9, GPIO_MODE_OUT_PP);
	gpio_func_set(10, FUNC2_GPIO);
	gpio_mode_set(10, GPIO_MODE_OUT_PP);
	gpio_func_set(11, FUNC2_GPIO);
	gpio_mode_set(11, GPIO_MODE_OUT_PP);

	while (1) 
	{
		/*xprintf("count[1] = %d\n", count[1]);
		xprintf("count[2] = %d\n", count[2]);
		xprintf("count[3] = %d\n", count[3]);*/

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x001);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x002);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x004);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x00f);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x017);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x027);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x07f);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x0bf);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x13f);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x3ff);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x5ff);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0x9ff);
		vTaskDelay( 1 * configTICK_RATE_HZ );

		gpio_reset_port_value(0, 0xfff);
		gpio_set_port_value(0, 0xfff);
		vTaskDelay( 1 * configTICK_RATE_HZ );
	}

	vTaskDelete(NULL);
}

void task4(void *pvParameters) 
{
	while (1) 
	{
		xprintf("Task 4A\n");

		taskYIELD();

		xprintf("Task 4B\n");

		vTaskDelay( 1 * configTICK_RATE_HZ );
	}

	vTaskDelete(NULL);
}

void pwm_task(void *pvParameters) 
{
	int i;
	
	pwm_init();

	pwm_disable_channel(0);
	pwm_disable_channel(7);
	pwm_set_channel(0, 32000000, 1000000 * 1, 0);
	pwm_set_channel(7, 32000000, 1000000 * 1, 1);
	pwm_enable_channel(0);
	pwm_enable_channel(7);
	
	while (1) 
	{
		for (i=1; i<16; i++)
		{
			vTaskDelay( 5 * configTICK_RATE_HZ );
			
			pwm_set_channel(0, 32000000, 2000000 * i, 0);
			pwm_set_channel(7, 32000000, 2000000 * i, 1);
		}
	}

	vTaskDelete(NULL);
}

void rtc_task(void *pvParameters)
{
	int year, month, day, hour, min, sec;

	rtc_deinit();
	rtc_init();
	rtc_set_time(2019, 3, 8, 10, 10, 10);
	rtc_enable();

	while (1)
	{
		rtc_get_time((uint32_t *)&year, (uint32_t *)&month, (uint32_t *)&day, (uint32_t *)&hour, (uint32_t *)&min, (uint32_t *)&sec);
		xprintf("time: %04d-%02d-%02d, %02d:%02d:%02d\n", year, month, day, hour, min, sec);
		vTaskDelay( 10 * configTICK_RATE_HZ );
	}

	vTaskDelete(NULL);
}

void wdt_task(void *pvParameters)
{
	wdt_start(10 * 32768);

	while (1)
	{
		vTaskDelay( 8 * configTICK_RATE_HZ );
		wdt_keep_alive();
	}

	vTaskDelete(NULL);
}


void shell_task(void *pvParameters);
void oled_task(void *pvParameters);


int main(void)
{
	prvSetupHardware();

	xTaskCreate(oled_task, "Task 2", 200, NULL, 2, NULL);
	xTaskCreate(shell_task, "Task 3", 200, NULL, 3, NULL);

 	xTaskCreate(led_task, "Task 4", 120, NULL, 4, NULL);
	xTaskCreate(pwm_task, "Task 5", 120, NULL, 5, NULL);
	xTaskCreate(rtc_task, "Task 6", 120, NULL, 6, NULL);
	xTaskCreate(wdt_task, "Task 7", 120, NULL, 6, NULL);

	vTaskStartScheduler();

	return 0;
}
