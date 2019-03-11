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
 * 2019-01-27     lgq          the first version
 */


#include <drv_spi.h>
#include <drv_gpio.h>


spi_dev_t* const SPI0 = (spi_dev_t*)SPI0_BASE_ADDR;
spi_dev_t* const SPI1 = (spi_dev_t*)SPI1_BASE_ADDR;


void spix_init(spi_dev_t *spi)
{
	// todo: enable clock
}

void spix_deinit(spi_dev_t *spi)
{
	// todo: enable clock
}

void spix_setup_master(spi_dev_t *spi) 
{
	if (spi == SPI0)
	{
		gpio_func_set(SPI0_CLK, FUNC0_SPIM0_CLK);
		gpio_func_set(SPI0_SDIO0_MOSI, FUNC0_SPIM0_SDIO0);
		gpio_func_set(SPI0_SDIO1_MISO, FUNC0_SPIM0_SDIO1);
		gpio_func_set(SPI0_SDIO2, FUNC0_SPIM0_SDIO2);
		gpio_func_set(SPI0_SDIO3, FUNC0_SPIM0_SDIO3);

		gpio_mode_set(SPI0_CLK, GPIO_MODE_OUT_PP);
		gpio_mode_set(SPI0_SDIO0_MOSI, GPIO_MODE_OUT_PP);
		gpio_mode_set(SPI0_SDIO1_MISO, GPIO_MODE_IN_FLOATING);
	}
	else /* if (spi == SPI1) */
	{
		gpio_func_set(SPI1_CLK,  FUNC1_SPIM1_CLK);
		gpio_func_set(SPI1_SDIO0_MOSI,  FUNC1_SPIM1_SDIO0);
		gpio_func_set(SPI1_SDIO1_MISO,  FUNC1_SPIM1_SDIO1);
		gpio_func_set(SPI1_SDIO2, FUNC1_SPIM1_SDIO2);
		gpio_func_set(SPI1_SDIO3, FUNC1_SPIM1_SDIO3);

		gpio_mode_set(SPI1_CLK, GPIO_MODE_OUT_PP);
		gpio_mode_set(SPI1_SDIO0_MOSI, GPIO_MODE_OUT_PP);
		gpio_mode_set(SPI1_SDIO1_MISO, GPIO_MODE_IN_FLOATING);		
	}
}

int spix_set_max_speed(spi_dev_t *spi, uint32_t speed)
{
	/* max_speed = system_clock / (2 * (divider + 1)) */
	uint32_t divider;
	uint32_t clock;
	
	if (spi == NULL) return -1;
	
	clock = system_clock_get();
	if (clock < (2 * speed)) return -1;

	divider = (clock / (2 * speed)) - 1;
	spi->clkdiv = divider;

	return 0;
}

void spix_attach_chip_select(spi_dev_t *spi, uint32_t cs)
{
    if (spi == SPI0)
	{
	#if (SPI_HW_CS_EN > 0)
		if (cs == 0)
			gpio_func_set(SPI0_HWCS0_PIN, FUNC0_SPIM0_CS0);
		else if (cs == 1)
			gpio_func_set(SPI0_HWCS1_PIN, FUNC0_SPIM0_CS1);
		else if (cs == 2)
			gpio_func_set(SPI0_HWCS2_PIN, FUNC0_SPIM0_CS2);
		else /* if (cs == 3) */
			gpio_func_set(SPI0_HWCS3_PIN, FUNC0_SPIM0_CS3);
	#else
		if (cs == 0)
		{
			gpio_func_set(SPI0_CS0_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI0_CS0_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI0_CS0_PIN, 1);
		}
		else if (cs == 1)
		{
			gpio_func_set(SPI0_CS1_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI0_CS1_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI0_CS1_PIN, 1);
		}
		else if (cs == 2)
		{
			gpio_func_set(SPI0_CS2_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI0_CS2_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI0_CS2_PIN, 1);
		}
		else /* if (cs == 3) */
		{
			gpio_func_set(SPI0_CS3_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI0_CS3_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI0_CS3_PIN, 1);
		}			
	#endif
	}
	else /* if (spi == SPI1) */
	{
		gpio_func_set(0,  FUNC1_SPIM1_CLK);
		gpio_func_set(2,  FUNC1_SPIM1_SDIO0);
		gpio_func_set(3,  FUNC1_SPIM1_SDIO1);
		gpio_func_set(23, FUNC1_SPIM1_SDIO2);
		gpio_func_set(35, FUNC1_SPIM1_SDIO3);
		
	#if (SPI_HW_CS_EN > 0)
		if (cs == 0)
			gpio_func_set(SPI1_HWCS0_PIN, FUNC1_SPIM1_CS0);
		else if (cs == 1)
			gpio_func_set(SPI1_HWCS1_PIN, FUNC1_SPIM1_CS1);
		else if (cs == 2)
			gpio_func_set(SPI1_HWCS2_PIN, FUNC1_SPIM1_CS2);
		else /* if (cs == 3) */
			gpio_func_set(SPI1_HWCS3_PIN, FUNC1_SPIM1_CS3);
	#else
		if (cs == 0)
		{
			gpio_func_set(SPI1_CS0_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI1_CS0_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI1_CS0_PIN, 1);
		}
		else if (cs == 1)
		{
			gpio_func_set(SPI1_CS1_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI1_CS1_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI1_CS1_PIN, 1);
		}
		else if (cs == 2)
		{
			gpio_func_set(SPI1_CS2_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI1_CS2_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI1_CS2_PIN, 1);
		}
		else /* if (cs == 3) */
		{
			gpio_func_set(SPI1_CS3_PIN, FUNC2_GPIO);
			gpio_mode_set(SPI1_CS3_PIN, GPIO_MODE_OUT_PP);
			gpio_set_pin_value(SPI1_CS3_PIN, 1);
		}			
	#endif
	}
}

void spix_setup_cmd_addr(spi_dev_t *spi, uint32_t cmd, uint32_t cmdlen, uint32_t addr, uint32_t addrlen) 
{
    int cmd_reg;
	
    cmd_reg = cmd << (32 - cmdlen);
    spi->spicmd = cmd_reg;
    spi->spiadr = addr;
    spi->spilen = (cmdlen & 0x3F) | ((addrlen << 8) & 0x3F00);
}

void spix_setup_dummy(spi_dev_t *spi, uint32_t dummy_rd, uint32_t dummy_wr) 
{
    spi->spidum = ((dummy_wr << 16) & 0xFFFF0000) | (dummy_rd & 0xFFFF);
}

void spix_set_datalen(spi_dev_t *spi, uint32_t datalen) 
{
    volatile uint32_t old_len;
	
    old_len = spi->spilen;
    old_len = ((datalen << 16) & 0xFFFF0000) | (old_len & 0xFFFF);
    spi->spilen = old_len;
}

void spix_start_transaction(spi_dev_t *spi, uint32_t trans_type, uint32_t cs) 
{
    spi->status = ((1 << (cs + 8)) & 0xF00) | ((1 << trans_type) & 0xFF);
}

int spix_get_status(spi_dev_t *spi) 
{
    volatile int status;
	
    status = spi->status;
	
    return status;
}

void spix_write_fifo(spi_dev_t *spi, uint32_t *data, uint32_t datalen) 
{
    volatile uint32_t num_words, i;

    num_words = (datalen >> 5) & 0x7FF;

    if ( (datalen & 0x1F) != 0)
        num_words++;

    for (i = 0; i < num_words; i++) 
	{
        while ((((spi->status) >> 24) & 0xFF) >= 8);
        spi->txfifo = data[i];
    }
}

void spix_read_fifo(spi_dev_t *spi, uint32_t *data, uint32_t datalen) 
{
    volatile uint32_t num_words, i;

    num_words = (datalen >> 5) & 0x7FF;

    if ( (datalen & 0x1F) != 0)
        num_words++;

    for (i = 0; i < num_words; i++) 
	{
        while ((((spi->status) >> 16) & 0xFF) == 0);
        data[i] = spi->rxfifo;
    }
}

#if (SPI_HW_CS_EN == 0)

uint32_t swap_endian(uint32_t v)
{
	v = ( ((v << 8) & 0xff00ff00) | ((v >> 8) & 0x00ff00ff) );

	return ( (v << 16) | (v >> 16) );
}
	
void spix_setup_chip_select(spi_dev_t *spi, uint32_t cs) 
{
    if (spi == SPI0)
	{
		if (cs == 0)
			gpio_set_pin_value(SPI0_CS0_PIN, 0);
		if (cs == 1)
			gpio_set_pin_value(SPI0_CS1_PIN, 0);
		if (cs == 2)
			gpio_set_pin_value(SPI0_CS2_PIN, 0);
		if (cs == 3)
			gpio_set_pin_value(SPI0_CS3_PIN, 0);
	}
	else /* if (spi == SPI1) */
	{
		if (cs == 0)
			gpio_set_pin_value(SPI1_CS0_PIN, 0);
		if (cs == 1)
			gpio_set_pin_value(SPI1_CS1_PIN, 0);
		if (cs == 2)
			gpio_set_pin_value(SPI1_CS2_PIN, 0);
		if (cs == 3)
			gpio_set_pin_value(SPI1_CS3_PIN, 0);
	}
}

void spix_release_chip_select(spi_dev_t *spi, uint32_t cs) 
{
	if (spi == SPI0)
	{
		if (cs == 0)
			gpio_set_pin_value(SPI0_CS0_PIN, 1);
		if (cs == 1)
			gpio_set_pin_value(SPI0_CS1_PIN, 1);
		if (cs == 2)
			gpio_set_pin_value(SPI0_CS2_PIN, 1);
		if (cs == 3)
			gpio_set_pin_value(SPI0_CS3_PIN, 1);
	}
	else /* if (spi == SPI1) */
	{
		if (cs == 0)
			gpio_set_pin_value(SPI1_CS0_PIN, 1);
		if (cs == 1)
			gpio_set_pin_value(SPI1_CS1_PIN, 1);
		if (cs == 2)
			gpio_set_pin_value(SPI1_CS2_PIN, 1);
		if (cs == 3)
			gpio_set_pin_value(SPI1_CS3_PIN, 1);
	}
}

void spix_write_direct(spi_dev_t *spi, uint32_t cs, uint32_t *data, uint32_t datalen)
{
	int i;
	
	for (i=0; i<((datalen+3)>>2); i++)
	{
		data[i] = swap_endian(data[i]);
	}
	
	spix_setup_cmd_addr(spi, 0, 0, 0, 0);
	spix_setup_dummy(spi, 0, 0);
	
	spix_setup_chip_select(spi, cs);
	
	spix_set_datalen(spi, datalen * 8);
	spix_start_transaction(spi, SPI_CMD_WR, cs);
	spix_write_fifo(spi, data, datalen * 8);
	while ((spix_get_status(spi) & 0xFFFF) != 1);
	
	spix_release_chip_select(spi, cs);
}

void spix_read_direct(spi_dev_t *spi, uint32_t cs, uint32_t *data, uint32_t datalen)
{
	uint32_t i;
	
	spix_setup_cmd_addr(spi, 0, 0, 0, 0);
	spix_setup_dummy(spi, 0, 0);
	
	spix_setup_chip_select(spi, cs);
	
	spix_set_datalen(spi, datalen * 8);
	spix_start_transaction(spi, SPI_CMD_RD, cs);
	spix_read_fifo(spi, data, datalen * 8);
	while ((spix_get_status(spi) & 0xFFFF) != 1);
	
	spix_release_chip_select(spi, cs);

	for (i=0; i<((datalen+3)>>2); i++)
	{
		data[i] = swap_endian(data[i]);
	}
	data[i-1] = data[i-1] >> ((4 - (datalen & 0x3)) << 3);
}

void spix_write_then_read_direct(spi_dev_t *spi, uint32_t cs, 
								uint32_t *data_wr, uint32_t datalen_wr, 
								uint32_t *data_rd, uint32_t datalen_rd)
{
	uint32_t i;

	for (i=0; i<((datalen_wr+3)>>2); i++)
	{
		data_wr[i] = swap_endian(data_wr[i]);
	}	
	
	spix_setup_chip_select(spi, cs);

	spix_setup_cmd_addr(spi, 0, 0, 0, 0);
	spix_setup_dummy(spi, 0, 0);
	spix_set_datalen(spi, datalen_wr * 8);
	spix_start_transaction(spi, SPI_CMD_WR, cs);
	spix_write_fifo(spi, data_wr, datalen_wr * 8);
	while ((spix_get_status(spi) & 0xFFFF) != 1);
	
	spix_setup_cmd_addr(spi, 0, 0, 0, 0);
	spix_setup_dummy(spi, 0, 0);
	spix_set_datalen(spi, datalen_rd * 8);
	spix_start_transaction(spi, SPI_CMD_RD, cs);
	spix_read_fifo(spi, data_rd, datalen_rd * 8);
	while ((spix_get_status(spi) & 0xFFFF) != 1);
	
	spix_release_chip_select(spi, cs);

	for (i=0; i<((datalen_rd+3)>>2); i++)
	{
		data_rd[i] = swap_endian(data_rd[i]);
	}
	data_rd[i-1] = ( data_rd[i-1] >> ((4 - (datalen_rd & 0x3)) << 3) );
}

#endif


