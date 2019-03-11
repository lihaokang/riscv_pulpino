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
#include "gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"
#include "drv_uart.h"
#include "xprintf.h"


#define PROTON_USING_INT

#ifdef PROTON_USING_INT
char buf[128];
int get_line(char *buf, int size);
void uart_int_init(void);
#endif


void xprintf_init(void)
{
	uartx_set_cfg(UART0, 0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz
	
	uart_int_init();
}


char uart_getc(void)
{
	return uartx_get_char(UART0);
}


void uart_putc(char c)
{
	uartx_wait_tx_done(UART0);
    uartx_send(UART0, &c, 1);
}


int main(void)
{
	void xprintf_demo(void);
	
	xdev_out(uart_putc);
	xdev_in(uart_getc);
	
	xprintf_demo();

	return 0;
}


static char menu[] = 
	"\n"
	"+-------------------------------colelink---------------------------------+\n"
	"| command      -+ syntax                         -+ function             |\n"
	"| write         | w 0x00103FFC 0x12345678         | write register       |\n"
	"| read          | r 0x00103FFC                    | read register        |\n"
	"+------------------------------------------------------------------------+\n";


void xprintf_demo(void)
{
	int r;
	long addr;
	long value;
	char *ptr;
	
	xprintf_init();
	
	xprintf(menu);
	
	while (1)
	{
		xprintf("proton$ ");
	
#ifdef PROTON_USING_INT
		r = get_line(buf, 64);
#else
		r = xgets(buf, 64);
#endif
		
		switch (buf[0])
		{
			case 'r':
			case 'R':
			{
				ptr = &buf[2];
				xatoi(*ptr, &addr);
				xprintf("[0x%08X] = 0x%08X\n", addr, *(volatile int *)addr);
				break ;
			}
			
			case 'w':
			case 'W':
			{
				ptr = &buf[2];
				xatoi((buf+2), &addr);
				ptr = &buf[13];
				xatoi(*ptr, &value);
				*(volatile int *)addr = value;
				xprintf("[0x%08X] = 0x%08X\n", addr, value);
				break ;
			}
			
			case '?':
			{
				xprintf(menu);
				break ;
			}
			
			default:
				break ;
		}
	}
}


#ifdef PROTON_USING_INT

volatile char uart_buf[128];
volatile int uart_oft = 0;
volatile int uart_flag = 0;


int get_line(char *buf, int size)
{
	int i;
	int r;
	
	while (uart_flag == 0);
	
	for (i=0; i<uart_oft+1; i++)
		buf[i] = uart_buf[i];
	
	uart_flag = 0;
	r = uart_oft + 1;
	uart_oft = 0;
	
	return r;
}



void uart_int_init(void)
{
	// Configure ISRs
	int_enable();

	EER = (0x1 << 24);
	IER = (0x1 << 24);

	UART0->ier = 0x01;


	uart_oft = 0;
	uart_flag = 0;
}


void ISR_UART(void)
{
	char c;
	unsigned int status;

	ICP = (0x1 << 24);

	status = UART0->lsr;
	if (status & 0x01)
	{
		c = UART0->rbr;
		uart_putc(c);
		
		if (c == '\r')
		{
			uart_buf[uart_oft] = 0;
			uart_oft++;
			uart_flag = 1;
		}
		else if (c == '\n')
		{
		}
		else
		{
			uart_buf[uart_oft] = c;
			uart_oft++;
		}
	}

	if (status & 0x20)
	{
	}
}

#endif







