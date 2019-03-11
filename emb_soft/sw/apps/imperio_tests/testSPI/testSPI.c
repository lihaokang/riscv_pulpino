// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.





#include <utils.h>
//#include <stdio.h>
#include <drv_spi.h>
//#include <spi.h>
#include <drv_uart.h>
#include <proton.h>
#include "string_lib.h"
#include "gpio.h"


//#define SPI_SOFT_CS

int tx_buf[8];
int buf[256];
int main(void)
{
	volatile int k;	
	int id;
	int len;
	char id_buf[32];
	char str_buf[32];
	char *ptr;

	// waste some time and wait for flash to power up
	for (int i = 0; i < 33333; i++) k = 0;

	uartx_set_cfg(UART0, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz

	uartx_wait_tx_done(UART0);
    uartx_send(UART0, "spitest\n", 8);

	//SPI_CLKDIV = 0x04;
	SPI0->clkdiv = 0x4;

	spi_setup_master(1); //sets direction for SPI master pins with only one CS

	uartx_send(UART0, "resetchip\n", 10);

#ifndef SPI_SOFT_CS
	spix_setup_cmd_addr(SPI0, 0xff, 8, 0, 0);	// reset chip
	spix_set_datalen(SPI0, 0);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_WR, SPI_CSN0);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);
#else
	ptr = (char *)tx_buf;
	ptr[0] = 0xff;
	spix_write_direct(SPI0, 0, tx_buf, 1);
#endif
	uartx_send(UART0, "writedisable\n", 13);

#ifndef SPI_SOFT_CS
	spix_setup_cmd_addr(SPI0, 0x04, 8, 0, 0);	// write disable
	spix_set_datalen(SPI0, 0);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_WR, SPI_CSN0);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);
#else
	ptr = (char *)tx_buf;
	ptr[0] = 0x04;
	spix_write_direct(SPI0, 0, tx_buf, 1);
#endif
	uartx_send(UART0, "readflashid\n", 12);

	//reads flash ID
	while (1)
	{

#ifndef SPI_SOFT_CS
	id = 0;
 	spix_setup_cmd_addr(SPI0, 0x9F, 8, 0, 0);
	spix_set_datalen(SPI0, 24);
	spix_setup_dummy(SPI0, 0, 0);
	spix_start_transaction(SPI0, SPI_CMD_RD, SPI_CSN0);
	spix_read_fifo(SPI0, &id, 24);
	while ((spix_get_status(SPI0) & 0xFFFF) != 1);

#else

	ptr = (char *)tx_buf;
	ptr[0] = 0x9f;
	spix_write_then_read_direct(SPI0, 0, tx_buf, 1, &id, 3);
#endif
	{
		uartx_wait_tx_done(UART0);
		uartx_send(UART0, "flashid\n", 8); 
		uartx_wait_tx_done(UART0);
		printf("0x%X\n", id);
	}

	volatile uint32_t d = 16000000; while (--d);

	}

	return 0;
}


