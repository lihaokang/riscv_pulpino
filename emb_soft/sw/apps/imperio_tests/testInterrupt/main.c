// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.



#include <string.h>
#include "utils.h"
#include "drv_uart.h"
#include "event.h"
#include "drv_timer.h"
#include "int.h"
#include "bench.h"
#include "drv_gpio.h"


#define TIMER_INDEX		(2)

volatile int timer_triggered = 0;

/*
void ISR_TIMER6(void) 
{
	ECP = TIMER6_EVT;
	ICP = TIMER6_EVT;

	timer_triggered++;
	
	uartx_send(UART0, "timer6\n", 7);
	uartx_wait_tx_done(UART0);
}

int main(void) 
{
	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	uartx_set_cfg(UART0, 0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_send(UART0, "timer6-test\n", 12);
	uartx_wait_tx_done(UART0);

	// Configure ISRs
	int_enable();

	EER = TIMER6_EVT; // enable all timer events;
	IER = TIMER6_EVT; // enable all timer interrupts

	timer_deinit(TIMER6);
	timer_set_prescaler(TIMER6, 1);
	timer_set_output_cmp(TIMER6, 16000000);
	timer_start(TIMER6);

	while (1) 
	{
    	printf("cmp Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}
*/



#if (TIMER_INDEX == 0)

void ISR_TIMER0(void) 
{
	ECP = TIMER0_EVT;
	ICP = TIMER0_EVT;

	timer_triggered++;
	
	uartx_send(UART0, "timer0\n", 7);
	uartx_wait_tx_done(UART0);
}

int main(void) 
{
	// Configure ISRs
	int_enable();

	EER = TIMER0_EVT; // enable all timer events;
	IER = TIMER0_EVT; // enable all timer interrupts

	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	uartx_set_cfg(UART0, 0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_send(UART0, "timer0-test\n", 12);
	uartx_wait_tx_done(UART0);

	timer_deinit(TIMER0);
	timer_set_prescaler(TIMER0, 1);
	timer_set_output_cmp(TIMER0, 16000000);
	timer_start(TIMER0);

	while (1) 
	{
    	printf("cmp Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}

#elif (TIMER_INDEX == 1)

void ISR_TIMER1(void) 
{
	ECP = TIMER1_EVT;
	ICP = TIMER1_EVT;

	timer_triggered++;
	
	uartx_send(UART0, "timer1\n", 7);
	uartx_wait_tx_done(UART0);
}

int main(void) 
{
	// Configure ISRs
	int_enable();

	EER = TIMER1_EVT; // enable all timer events;
	IER = TIMER1_EVT; // enable all timer interrupts

	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	uartx_set_cfg(UART0, 0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_send(UART0, "timer1-test\n", 12);
	uartx_wait_tx_done(UART0);

	timer_deinit(TIMER1);
	timer_set_prescaler(TIMER1, 1);
	timer_set_output_cmp(TIMER1, 16000000);
	timer_start(TIMER1);

	while (1) 
	{
    	printf("cmp Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}

#elif (TIMER_INDEX == 2)

void ISR_TIMER2(void) 
{
	ECP = TIMER2_EVT;
	ICP = TIMER2_EVT;

	timer_triggered++;
	
	uartx_send(UART0, "timer2\n", 7);
	uartx_wait_tx_done(UART0);
}

int main(void) 
{
	// Configure ISRs
	int_enable();

	EER = TIMER2_EVT; // enable all timer events;
	IER = TIMER2_EVT; // enable all timer interrupts

	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	uartx_set_cfg(UART0, 0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_send(UART0, "timer2-test\n", 12);
	uartx_wait_tx_done(UART0);

	timer_deinit(TIMER2);
	timer_set_prescaler(TIMER2, 1);
	timer_set_output_cmp(TIMER2, 16000000);
	timer_start(TIMER2);

	while (1) 
	{
    	printf("cmp Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}

#elif (TIMER_INDEX == 3)

void ISR_TIMER3(void) 
{
	ECP = TIMER3_EVT;
	ICP = TIMER3_EVT;

	timer_triggered++;
	
	uartx_send(UART0, "timer3\n", 7);
	uartx_wait_tx_done(UART0);
}

int main(void) 
{
	// Configure ISRs
	int_enable();

	EER = TIMER3_EVT; // enable all timer events;
	IER = TIMER3_EVT; // enable all timer interrupts

	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	uartx_set_cfg(UART0, 0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_send(UART0, "timer3-test\n", 12);
	uartx_wait_tx_done(UART0);

	timer_deinit(TIMER3);
	timer_set_prescaler(TIMER3, 1);
	timer_set_output_cmp(TIMER3, 16000000);
	timer_start(TIMER3);

	while (1) 
	{
    	printf("ovf Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}

#endif


