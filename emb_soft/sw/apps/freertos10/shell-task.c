/* Copyright (c) 2019-2020, corelink inc., www.corelink.vip
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * Change Logs:
 * Date           Author       Notes
 * 2019-02-28     lgq          the first version
 */


#include <stdio.h>
#include "proton.h"
#include "drv_gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"
#include "drv_uart.h"
#include "drv_console.h"
#include "drv_scu.h"
#include "drv_spi.h"
#include "xprintf.h"

#include <fifo.h>
#include <tools.h>
#include <shell.h>

#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"


#define FIFO_BUFFER_SIZE	240			// note: FIFO_BUFFER_SIZE < 256 !!!

static uint8_t inbuf[FIFO_BUFFER_SIZE];

FIFO fifo_in;
FIFO *in;


void shell_io_init(void) 
{
    in = &fifo_in;
    fifo_init(in, inbuf, sizeof(inbuf));
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

	v = R32(a);
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

	R32(a) = v;
	xprintf("[%08X] = 0x%08X\n", a, v);
	
	return 0;
}

int dump(uint8_t *arg1, uint8_t *arg2)
{
	int i;
	long a;
	long n;
	char *ptr;
	volatile uint32_t *p;
	
	ptr = arg1;
	xatoi(&ptr, &a);
	ptr = arg2;
	xatoi(&ptr, &n);

	p = ((volatile uint32_t *)a);

	for (i=0; i<n; i++)
	{
		xprintf("[0x%08X] = 0x%08X\n", (uint32_t)p, *p);
		p++;
	}

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

	gpio_func_set((uint32_t)gpio, (uint32_t)func);
	dump("0x1B005000", "15");

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

	gpio_mode_set((uint32_t)gpio, (uint32_t)mode);
	dump("0x1B005000", "15");

	return 0;
}

int reboot(void)
{
	scu_reset_mcu();
	return 0;
}


uint32_t tx_buf[8];
uint32_t buf[16];

#if (SPI_HW_CS_EN == 1)

int spi0_demo(void)
{
	uint32_t id = 0;
	char *ptr;

	gpio_direction_set(29, GPIO_MODE_OUT_PP);
	gpio_set_pin_value(29, 0);

    // xprintf("spi setup\n");
	spix_setup_master(SPI0); //sets direction for SPI master 
	spix_set_max_speed(SPI0, 2000000);
	spix_attach_chip_select(SPI0, SPI_CSN0);

	// xprintf("reset chip\n");
	spix_setup_cmd_addr(SPI0, 0xff, 8, 0, 0);	// reset chip
	spix_set_datalen(SPI0, 0);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_WR, SPI_CSN0);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);

	// xprintf("write disable\n");
	spix_setup_cmd_addr(SPI0, 0x04, 8, 0, 0);	// write disable
	spix_set_datalen(SPI0, 0);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_WR, SPI_CSN0);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);

	// xprintf("read flashid\n");
 	spix_setup_cmd_addr(SPI0, 0x9F, 8, 0, 0);
	spix_set_datalen(SPI0, 24);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_RD, SPI_CSN0);
	spix_read_fifo(SPI0, &id, 24);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);

	id &= 0xffffff;
	xprintf("flashid = 0x%X\n", id);

	return 0;
}

#else

int spi0_demo(void)
{	
	uint32_t id;
	char *ptr;

	gpio_direction_set(29, GPIO_MODE_OUT_PP);
	gpio_set_pin_value(29, 0);

    // xprintf("spi setup\n");
	spix_setup_master(SPI0); //sets direction for SPI master 
	spix_set_max_speed(SPI0, 2000000);
	spix_attach_chip_select(SPI0, SPI_CSN0);

	// xprintf("reset chip\n");
	ptr = (char *)tx_buf;
	ptr[0] = 0xff;
	spix_write_direct(SPI0, 0, tx_buf, 1);

	// xprintf("writedisable\n");
	//ptr = (char *)tx_buf;
	ptr[0] = 0x04;
	spix_write_direct(SPI0, 0, tx_buf, 1);

	// xprintf("read flashid\n");
	//ptr = (char *)tx_buf;
	ptr[0] = 0x9f;
	spix_write_then_read_direct(SPI0, 0, tx_buf, 1, &id, 3);

	id &= 0xffffff;
	xprintf("flashid = 0x%X\n", id);

	return 0;
}

#endif

int spi1_demo(void)
{	
	uint32_t id;
	char *ptr;

	gpio_direction_set(29, GPIO_MODE_OUT_PP);
	gpio_set_pin_value(29, 1);

    // xprintf("spi setup\n");
	spix_setup_master(SPI1); //sets direction for SPI master 
	spix_set_max_speed(SPI1, 2000000);
	spix_attach_chip_select(SPI1, 0);

	// xprintf("reset chip\n");
	ptr = (char *)tx_buf;
	ptr[0] = 0xff;
	spix_write_direct(SPI1, 0, tx_buf, 1);

	// xprintf("writedisable\n");
	//ptr = (char *)tx_buf;
	ptr[0] = 0x04;
	spix_write_direct(SPI1, 0, tx_buf, 1);

	// xprintf("read flashid\n");
	//ptr = (char *)tx_buf;
	ptr[0] = 0x9f;
	spix_write_then_read_direct(SPI1, 0, tx_buf, 1, &id, 3);

	id &= 0xffffff;
	xprintf("flashid = 0x%X\n", id);

	return 0;
}

char cmd_list[] = 
			"list\n"
			"hello\n"
			"printk\n"
			"read\n"
			"write\n"
			"dump\n"
			"set_func\n"
			"set_mode\n"
			"reboot\n"
			"spi0_demo\n"
			"spi1_demo\n";

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
	{"dump", 		dump,			2,},
	{"set_func", 	set_func,		2,},
	{"set_mode", 	set_mode,		2,},
	{"reboot", 		reboot,			0,},
	{"spi0_demo", 	spi0_demo,		0,},
	{"spi1_demo", 	spi1_demo,		0,},
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
		vTaskDelay(configTICK_RATE_HZ / 50);
	}
}

void shell_task (void *pvParameters) 
{
	tiny_shell_run();

	return ;
}


void ISR_UART0(void)
{
	volatile char c;

	UART0_INT_RESET();
	
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
}
