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
#include "xprintf.h"

#include <fifo.h>
#include <tools.h>
#include <shell.h>


#define FIFO_BUFFER_SIZE	240			// note: FIFO_BUFFER_SIZE < 256

static uint8_t inbuf[FIFO_BUFFER_SIZE];
// static uint8_t outbuf[FIFO_BUFFER_SIZE];

FIFO fifo_in, fifo_out;
FIFO *in, *out;


void shell_io_init(void) 
{
    in = &fifo_in;
    // out = &fifo_out;

    fifo_init(in, inbuf, sizeof(inbuf));
    // fifo_init(out, outbuf, sizeof(outbuf));
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

void xprintf_init(void)
{
	uartx_set_cfg(UART0, 0, 3333); // 3333 * 9600 = 31.9968MHz

	// Configure ISRs
	UART0->clr_int = 0x2;
	UART0->clr_int = 0x0;
	UART0->ier = 0x10;
	IER |= UART0_EVT;
	int_enable();

	xdev_out(uart_putc);
	xdev_in(uart_getc);
}

int hello(void)
{
	xputs("hello world\n");
	return 0;
}

int printk(uint8_t *arg1)
{
	xprintf("%s\n", arg1);
	return 0;
}

int read(uint8_t *arg1)
{
	long a;
	long v;
	char *ptr;
	
	ptr = arg1;
	xatoi(&ptr, &a);

	v = (*(volatile uint32_t *)a);

	xprintf("[%08X] = 0x%08X\n", a, v);
	
	return 0;
}

int write(uint8_t *arg1, uint8_t *arg2)
{
	long a;
	long v;
	char *ptr;
	
	ptr = arg1;
	xatoi(&ptr, &a);
	ptr = arg2;
	xatoi(&ptr, &v);

	(*(volatile uint32_t *)a) = v;

	xprintf("[%08X] = 0x%08X\n", a, v);
	
	return 0;
}

int set_func(uint8_t *arg1, uint8_t *arg2)
{
	long gpio;
	long func;
	char *ptr;
	
	ptr = arg1;
	xatoi(&ptr, &gpio);
	ptr = arg2;
	xatoi(&ptr, &func);

	xprintf("gpio=%d, func=%d\n", gpio, func);
	xprintf( "reg_oft=%d, value=0x%08X\n", ((uint32_t)gpio >> 3), ((uint32_t)func << (((uint32_t)gpio & (uint32_t)0x7) << 2)) );

	gpio_func_set((uint32_t)gpio, (uint32_t)func);

	xprintf("[0x1B005000] = 0x%08X\n", *((volatile uint32_t *)0x1B005000));
	xprintf("[0x1B005004] = 0x%08X\n", *((volatile uint32_t *)0x1B005004));
	xprintf("[0x1B005008] = 0x%08X\n", *((volatile uint32_t *)0x1B005008));
	xprintf("[0x1B00500C] = 0x%08X\n", *((volatile uint32_t *)0x1B00500C));
	xprintf("[0x1B005010] = 0x%08X\n", *((volatile uint32_t *)0x1B005010));
	xprintf("[0x1B005014] = 0x%08X\n", *((volatile uint32_t *)0x1B005014));
	xprintf("[0x1B005018] = 0x%08X\n", *((volatile uint32_t *)0x1B005018));
	xprintf("[0x1B00501C] = 0x%08X\n", *((volatile uint32_t *)0x1B00501C));
	xprintf("[0x1B005020] = 0x%08X\n", *((volatile uint32_t *)0x1B005020));
	xprintf("[0x1B005024] = 0x%08X\n", *((volatile uint32_t *)0x1B005024));
	xprintf("[0x1B005028] = 0x%08X\n", *((volatile uint32_t *)0x1B005028));
	xprintf("[0x1B00502C] = 0x%08X\n", *((volatile uint32_t *)0x1B00502C));
	xprintf("[0x1B005030] = 0x%08X\n", *((volatile uint32_t *)0x1B005030));
	xprintf("[0x1B005034] = 0x%08X\n", *((volatile uint32_t *)0x1B005034));
	xprintf("[0x1B005038] = 0x%08X\n", *((volatile uint32_t *)0x1B005038));

	return 0;
}

int set_mode(uint8_t *arg1, uint8_t *arg2)
{
	long gpio;
	long mode;
	char *ptr;
	
	ptr = arg1;
	xatoi(&ptr, &gpio);
	ptr = arg2;
	xatoi(&ptr, &mode);

	xprintf("gpio=%d, mode=%d\n", gpio, mode);
	xprintf( "reg_oft=%d, value=0x%08X\n", (gpio >> 5), ((uint32_t)0x1 << (gpio & (uint32_t)0x1f)) );
	gpio_mode_set((uint32_t)gpio, (uint32_t)mode);

	xprintf("[0x1B005000] = 0x%08X\n", *((volatile uint32_t *)0x1B005000));
	xprintf("[0x1B005004] = 0x%08X\n", *((volatile uint32_t *)0x1B005004));
	xprintf("[0x1B005008] = 0x%08X\n", *((volatile uint32_t *)0x1B005008));
	xprintf("[0x1B00500C] = 0x%08X\n", *((volatile uint32_t *)0x1B00500C));
	xprintf("[0x1B005010] = 0x%08X\n", *((volatile uint32_t *)0x1B005010));
	xprintf("[0x1B005014] = 0x%08X\n", *((volatile uint32_t *)0x1B005014));
	xprintf("[0x1B005018] = 0x%08X\n", *((volatile uint32_t *)0x1B005018));
	xprintf("[0x1B00501C] = 0x%08X\n", *((volatile uint32_t *)0x1B00501C));
	xprintf("[0x1B005020] = 0x%08X\n", *((volatile uint32_t *)0x1B005020));
	xprintf("[0x1B005024] = 0x%08X\n", *((volatile uint32_t *)0x1B005024));
	xprintf("[0x1B005028] = 0x%08X\n", *((volatile uint32_t *)0x1B005028));
	xprintf("[0x1B00502C] = 0x%08X\n", *((volatile uint32_t *)0x1B00502C));
	xprintf("[0x1B005030] = 0x%08X\n", *((volatile uint32_t *)0x1B005030));
	xprintf("[0x1B005034] = 0x%08X\n", *((volatile uint32_t *)0x1B005034));
	xprintf("[0x1B005038] = 0x%08X\n", *((volatile uint32_t *)0x1B005038));

	return 0;
}

char cmd_list[] = 
			"list\n"
			"hello\n"
			"printk\n"
			"read\n"
			"write\n"
			"set_func\n"
			"set_mode\n";

int list(void)
{
	xputs(cmd_list);
	
	return 0;
}

act_t shell_act[] = 
{
	{"help", 		list,			0,},
	{"hello",		hello, 			0,},
	{"printk", 		printk,			1,},
	{"read", 		read,			1,},
	{"write", 		write,			2,},
	{"set_func", 	set_func,		2,},
	{"set_mode", 	set_mode,		2,},
};

void tiny_shell_run(void)
{
	#define MAX_CMD_LEN 128

	char prompt[] = "proton>";
	uint8_t str[MAX_CMD_LEN];

	shell_io_init();
	xputs((char *)"www.corelink.vip\n");
	xputs(prompt);
	
	while (1)
	{
		while (fifo_get_token(in, str, MAX_CMD_LEN, '\r') > 0) 
		{
            int8_t ret_code = shell(str, shell_act, sizeof(shell_act) / sizeof(shell_act[0]));
            if (ret_code == SH_CMD_NOTFND)
                xputs((char *) "COMMAND NOT FOUND\r\n");
            xputs(prompt);
        }
	}
}

int main(void)
{
	xprintf_init();
	
	tiny_shell_run();

	return 0;
}

void ISR_UART0(void)
{
	volatile char c;

	while (UART0->rx_elm)
	{
		c = UART0->rbr;

		if (c == '\n') 
		{
			fifo_putc(in, ' ');
		}
		else
		{
			fifo_putc(in, c);
		}
	}

	UART0->clr_int = 0x2;
	UART0->clr_int = 0x0;
	ICP = UART0_EVT;
}
