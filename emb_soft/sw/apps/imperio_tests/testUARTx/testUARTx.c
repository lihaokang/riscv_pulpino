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
#include "proton.h"
#include "drv_gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"
#include "drv_uart.h"


#define UART_INDEX	(0)


volatile int flag_uart = 0;


#if (UART_INDEX == 0)

void uart_test(void)
{
	uartx_set_cfg(UART0, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART0);
    uartx_send(UART0, "UART0\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART0);
	uartx_send(UART0, "UART0 int test\n", 15);
	uartx_wait_tx_done(UART0);
	
	// Configure ISRs
	UART0->clr_int = 0x2;
	UART0->clr_int = 0x0;
	int_enable();
	UART0->ier = 0x10;
	IER |= UART0_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART0);
			uartx_send(UART0, "uart0 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART0(void)
{
	char c; 
	unsigned int status;

	while (UART0->rx_elm)
	{
		c = UART0->rbr;
		uartx_send(UART0, &c, 1);
		
		flag_uart = 1;
	}
	
	UART0->clr_int = 0x2;
	UART0->clr_int = 0x0;

	ICP = UART0_EVT;
}

int main(void)
{
	gpio_func_set(2, FUNC0_UART0_TX);
	gpio_func_set(3, FUNC0_UART0_RX);
	gpio_mode_set(3, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(2, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}


#elif (UART_INDEX == 1)


void uart_test(void)
{
	uartx_set_cfg(UART1, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART1);
    uartx_send(UART1, "UART1\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART1);
	uartx_send(UART1, "UART1 int test\n", 15);
	uartx_wait_tx_done(UART1);
	
	// Configure ISRs
	UART1->clr_int = 0x2;
	UART1->clr_int = 0x0;
	int_enable();
	UART1->ier = 0x10;
	IER |= UART1_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART1);
			uartx_send(UART1, "uart1 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART1(void)
{
	char c; 
	unsigned int status;
	
	while (UART1->rx_elm)
	{
		c = UART1->rbr;
		uartx_send(UART1, &c, 1);
		
		flag_uart = 1;
	}
	
	UART1->clr_int = 0x2;
	UART1->clr_int = 0x0;

	ICP = UART1_EVT;
}

int main(void)
{
	gpio_func_set(14, FUNC0_UART1_TX);
	gpio_func_set(15, FUNC0_UART1_RX);
	gpio_mode_set(15, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(14, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}


#elif (UART_INDEX == 2)


void uart_test(void)
{
	uartx_set_cfg(UART2, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART2);
    uartx_send(UART2, "UART2\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART2);
	uartx_send(UART2, "UART2 int test\n", 15);
	uartx_wait_tx_done(UART2);
	
	// Configure ISRs
	UART2->clr_int = 0x2;
	UART2->clr_int = 0x0;
	int_enable();
	UART2->ier = 0x10;
	IER |= UART2_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART2);
			uartx_send(UART2, "uart2 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART2(void)
{
	char c; 
	unsigned int status;

	while (UART2->rx_elm)
	{
		c = UART2->rbr;
		uartx_send(UART2, &c, 1);
		
		flag_uart = 1;
	}
	
	UART2->clr_int = 0x2;
	UART2->clr_int = 0x0;

	ICP = UART2_EVT;
}

int main(void)
{
	gpio_func_set(22, FUNC0_UART2_TX);
	gpio_func_set(23, FUNC0_UART2_RX);
	gpio_mode_set(23, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(22, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}


#elif (UART_INDEX == 3)


void uart_test(void)
{
	uartx_set_cfg(UART3, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART3);
    uartx_send(UART3, "UART3\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART3);
	uartx_send(UART3, "UART3 int test\n", 15);
	uartx_wait_tx_done(UART3);
	
	// Configure ISRs
	UART3->clr_int = 0x2;
	UART3->clr_int = 0x0;
	int_enable();
	UART3->ier = 0x10;
	IER |= UART3_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART3);
			uartx_send(UART3, "uart3 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART3(void)
{
	char c; 
	unsigned int status;

	while (UART3->rx_elm)
	{
		c = UART3->rbr;
		uartx_send(UART3, &c, 1);
		
		flag_uart = 1;
	}
	
	UART3->clr_int = 0x2;
	UART3->clr_int = 0x0;

	ICP = UART3_EVT;
}

int main(void)
{
	gpio_func_set(31, FUNC0_UART3_TX);
	gpio_func_set(32, FUNC0_UART3_RX);
	gpio_mode_set(32, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(31, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}



#elif (UART_INDEX == 4)


void uart_test(void)
{
	uartx_set_cfg(UART4, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART4);
    uartx_send(UART4, "UART4\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART4);
	uartx_send(UART4, "UART4 int test\n", 15);
	uartx_wait_tx_done(UART4);
	
	// Configure ISRs
	UART4->clr_int = 0x2;
	UART4->clr_int = 0x0;
	int_enable();
	UART4->ier = 0x10;
	IER |= UART4_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART4);
			uartx_send(UART4, "uart4 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART4(void)
{
	char c; 
	unsigned int status;

	while (UART4->rx_elm)
	{
		c = UART4->rbr;
		uartx_send(UART4, &c, 1);
		
		flag_uart = 1;
	}
	
	UART4->clr_int = 0x2;
	UART4->clr_int = 0x0;

	ICP = UART4_EVT;
}

int main(void)
{
	gpio_func_set(33, FUNC0_UART4_TX);
	gpio_func_set(34, FUNC0_UART4_RX);
	gpio_mode_set(34, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(33, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}


#elif (UART_INDEX == 5)


void uart_test(void)
{
	uartx_set_cfg(UART5, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

    uartx_wait_tx_done(UART5);
    uartx_send(UART5, "UART5\n", 6);
}

void uart_int_test(void)
{
	uartx_wait_tx_done(UART5);
	uartx_send(UART5, "UART5 int test\n", 15);
	uartx_wait_tx_done(UART5);
	
	// Configure ISRs
	UART5->clr_int = 0x2;
	UART5->clr_int = 0x0;
	int_enable();
	UART5->ier = 0x10;
	IER |= UART5_EVT;

	while (1)
	{		
		if (flag_uart)
		{
			uartx_wait_tx_done(UART5);
			uartx_send(UART5, "uart5 rx\n", 9);
			flag_uart = 0;
		}	
	}
}

void ISR_UART5(void)
{
	char c; 
	unsigned int status;

	while (UART5->rx_elm)
	{
		c = UART5->rbr;
		uartx_send(UART5, &c, 1);
		
		flag_uart = 1;
	}
	
	UART5->clr_int = 0x2;
	UART5->clr_int = 0x0;

	ICP = UART5_EVT;
}

int main(void)
{
	gpio_func_set(8, FUNC1_UART5_TX);
	gpio_func_set(9, FUNC1_UART5_RX);
	gpio_mode_set(9, GPIO_MODE_IN_FLOATING);
	gpio_mode_set(8, GPIO_MODE_OUT_PP);
	
	uart_test();
	uart_int_test();

	return 0;
}


#endif

