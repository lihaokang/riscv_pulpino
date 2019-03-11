// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#include <spi.h>
#include <uart.h>
#include <utils.h>
#include <proton.h>


// #define BOOT_DBG

#define EFLASH_CODE_BASE	0x00110000
#define EFLASH_DATA_BASE	0x00118000

#define CODE_RAM_BASE		0x00000000
#define DATA_RAM_BASE		0x00100000

#define CODE_SIZE			0x8000
#define DATA_SIZE			0x3000

#define REG32(a)			(*(volatile unsigned int *)(a))	
#define BOOT_SEL_REG		REG32(0x1A10700C)				

const char g_numbers[] = 
{
	'0', '1', '2', '3', '4', '5', '6', '7',
	'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
};

int check_spi_flash(void);
void jump_and_start(volatile int *ptr);
#ifdef BOOT_DBG
void uart_send_block_done(unsigned int i);
#endif

int boot_from_eflash(void);
int boot_from_spiflash(void);
int boot_from_eflash_xip(void);

unsigned int swap_endian(unsigned int v)
{
	v = ( ((v << 8) & 0xff00ff00) | ((v >> 8) & 0x00ff00ff) );

	return ( (v << 16) | (v >> 16) );
}

int main(void)
{
	volatile int delay = 0xffff;
	
	while (--delay);
	
	switch (BOOT_SEL_REG)
	{
		case 0x0:
		{
			boot_from_eflash();
			break ;
		}
		
		case 0x1:
		{
			boot_from_eflash_xip();
			break ;
		}
		
		case 0x2:
		{
			boot_from_spiflash();
			break ;
		}
		
		default:
		{
			boot_from_spiflash();
			break ;
		}
	}	

	return 0;
}

int boot_from_eflash(void)
{
	int *from;
	int *to;

	from = (int *)EFLASH_CODE_BASE;
	to   = (int *)CODE_RAM_BASE;
	for (int i=0; i<CODE_SIZE/4; i++)
	{
		*to++ = *from++;
	}

	from = (int *)EFLASH_DATA_BASE;
	to   = (int *)DATA_RAM_BASE;
	for (int i=0; i<DATA_SIZE/4; i++)
	{
		*to++ = *from++;
	}

	//-----------------------------------------------------------
	// Set new boot address -> exceptions/interrupts/events rely
	// on that information
	//-----------------------------------------------------------

	BOOTREG = CODE_RAM_BASE;

	//-----------------------------------------------------------
	// Done jump to main program
	//-----------------------------------------------------------

	//jump to program start address (instruction base address)
	jump_and_start((volatile int *)(CODE_RAM_BASE + 0x80));	

	return 0;
}

int boot_from_eflash_xip(void)
{
	int *from;
	int *to;

	from = (int *)EFLASH_DATA_BASE;
	to   = (int *)DATA_RAM_BASE;
	for (int i=0; i<DATA_SIZE/4; i++)
	{
		*to++ = *from++;
	}

	//-----------------------------------------------------------
	// Set new boot address -> exceptions/interrupts/events rely
	// on that information
	//-----------------------------------------------------------

	BOOTREG = EFLASH_CODE_BASE;

	//-----------------------------------------------------------
	// Done jump to main program
	//-----------------------------------------------------------

	//jump to program start address (instruction base address)
	jump_and_start((volatile int *)(EFLASH_CODE_BASE + 0x80));	

	return 0;
}

int boot_from_spiflash(void)
{
	#define SPI_CLK			(16)
	#define SPI_CS			(17)
	#define SPI_MOSI		(18)
	#define SPI_MISO		(19)

	#define UART_TX			(2)
	#define UART_RX			(3)
	
	/* sets direction for SPI master pins with only one CS */
#ifdef BOOT_DBG
	/* uart function */
	R32(0x1B005000) &= ~0x0000ff00;
	/* uart cfg_out */
	R32(0x1B005014) |=  (0x1 << UART_TX);
	/* uart cfg_in */
	R32(0x1B00501C) &= ~(0x1 << UART_TX);
	/* uart cfg_in */
	R32(0x1B00501C) |=  (0x1 << UART_RX);
	/* uart cfg_out */
	R32(0x1B005014) &= ~(0x1 << UART_RX);
#endif

	/* spi function */
	R32(0x1B005008) &= ~0x0000ffff;
	/* spi cfg_out */
	R32(0x1B005014) |=  ((0x1 << SPI_CLK) | (0x1 << SPI_CS) | (0x1 << SPI_MOSI));
	/* spi cfg_in */
	R32(0x1B00501C) &= ~((0x1 << SPI_CLK) | (0x1 << SPI_CS) | (0x1 << SPI_MOSI));
	/* spi cfg_in */
	R32(0x1B00501C) |=  (0x1 << SPI_MISO);
	/* spi cfg_out */
	R32(0x1B005014) &= ~(0x1 << SPI_MISO);

	// spi_setup_master(1);
#ifdef BOOT_DBG
	uart_set_cfg(0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz
#endif

	/* divide sys clock by (4 + 1) * 2 */
	*(volatile int*) (SPI_REG_CLKDIV) = 0x4;

	/*
	if (check_spi_flash()) 
	{
    	uart_send("ERROR: w25q64 SPI flash not found\n", 36);
    	while (1);
	}
	*/
#ifdef BOOT_DBG
	uart_send("Loading from SPI\n", 17);
	uart_wait_tx_done();
#endif

	// sends reset chip command
	spi_setup_cmd_addr(0xFF, 8, 0, 0);
	spi_setup_dummy(0, 0);
	spi_set_datalen(0);
	spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
	while ((spi_get_status() & 0xFFFF) != 1);

	// sends write disable command
	spi_setup_cmd_addr(0x04, 8, 0, 0);
	spi_setup_dummy(0, 0);
	spi_set_datalen(0);
	spi_start_transaction(SPI_CMD_WR, SPI_CSN0);
	while ((spi_get_status() & 0xFFFF) != 1);

	//-----------------------------------------------------------
	// Read header
	//-----------------------------------------------------------

	int header_ptr[8];
	int addr = 0;

	/*
	spi_setup_dummy(0, 0);
	// cmd 0x03 read, needs 0 dummy cycles
	spi_setup_cmd_addr(0x03, 8, ((addr & 0xFFFFFF) << 8), 24);
	spi_set_datalen(8 * 32);
	spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
	spi_read_fifo(header_ptr, 8 * 32);
	*/

	int instr_start = 0x0000;
	int *instr = (int *)0x0000;
	int instr_size =  CODE_SIZE;
	int instr_blocks = (CODE_SIZE >> 12);

	int data_start = 0x8000;
	int *data = (int *)0x100000;
	int data_size = (DATA_SIZE >> 12);
	int data_blocks = 3;

	//-----------------------------------------------------------
	// Read Instruction RAM
	//-----------------------------------------------------------
#ifdef BOOT_DBG
	uart_send("Copying Instructions\n", 21);
	uart_wait_tx_done();
#endif

	addr = instr_start;
	for (int i = 0; i < instr_blocks; i++) 	// reads 8 4KB blocks
	{ 
		// cmd 0x03 fast read, needs 0 dummy cycles
    	spi_setup_cmd_addr(0x03, 8, ((addr & 0xFFFFFF) << 8), 24);
		spi_setup_dummy(0, 0);
		spi_set_datalen(4096 * 8);
		spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
		spi_read_fifo(instr, 4096 * 8);

		for (int j = 0; j < 0x400; j++)
		{
			instr[j] = swap_endian(instr[j]);
		}

		instr += 0x400;  // new address = old address + 1024 words
		addr  += 0x1000; // new address = old address + 4KB
#ifdef BOOT_DBG
		uart_send_block_done(i);
#endif
	}

	while ((spi_get_status() & 0xFFFF) != 1);

	//-----------------------------------------------------------
	// Read Data RAM
	//-----------------------------------------------------------
#ifdef BOOT_DBG
	uart_send("Copying Data\n", 13);
	uart_wait_tx_done();
#endif

	addr = data_start;
	for (int i = 0; i < data_blocks; i++) 	//reads 3 4KB blocks
	{ 
    	// cmd 0x03 read, needs 0 dummy cycles
    	spi_setup_cmd_addr(0x03, 8, ((addr & 0xFFFFFF) << 8), 24);
		spi_setup_dummy(0, 0);
    	spi_set_datalen(4096 * 8);
    	spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
    	spi_read_fifo(data, 4096 * 8);

		for (int j = 0; j < 0x400; j++)
		{
			data[j] = swap_endian(data[j]);
		}

    	data += 0x400;  // new address = old address + 1024 words
    	addr += 0x1000; // new address = old address + 4KB

#ifdef BOOT_DBG
    	uart_send_block_done(i);
#endif
	}

#ifdef BOOT_DBG
	uart_send("Done, jumping to Instruction RAM.\n", 34);
	uart_wait_tx_done();
#endif

	//-----------------------------------------------------------
	// Set new boot address -> exceptions/interrupts/events rely
	// on that information
	//-----------------------------------------------------------

	BOOTREG = 0x00;

	//-----------------------------------------------------------
	// Done jump to main program
	//-----------------------------------------------------------

	//jump to program start address (instruction base address)
	jump_and_start((volatile int *)(INSTR_RAM_START_ADDR));

	return 0;
}

int check_spi_flash(void) 
{
	int err = 0;
	int rd_id;

	// reads flash ID
	spi_setup_cmd_addr(0x9F, 8, 0, 0);
	spi_set_datalen(3 * 8);
	spi_setup_dummy(0, 0);
	spi_start_transaction(SPI_CMD_RD, SPI_CSN0);
	spi_read_fifo(&rd_id, 3 * 8);

	// id should be 0xEF4017
	if ( (rd_id & 0xFFFFFF) != 0xEF4017 )
		err++;

	return err;
}

void jump_and_start(volatile int *ptr)
{
  asm("jalr x0, %0\n"
      "nop\n"
      "nop\n"
      "nop\n"
      : : "r" (ptr) );
}

#ifdef BOOT_DBG
void uart_send_block_done(unsigned int i) 
{ 
	unsigned int low  = i & 0xF;
	unsigned int high = i >>  4; // /16

	uart_send("Block ", 6);

	uart_send(&g_numbers[high], 1);
	uart_send(&g_numbers[low], 1);

	uart_send(" done\n", 6);

	uart_wait_tx_done();
}
#endif


