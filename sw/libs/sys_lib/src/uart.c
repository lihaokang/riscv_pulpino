// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include "uart.h"
#include "utils.h"
#include "uart.h"
#include "pulpino.h"
#include "int.h"

#define UART_RCV_BUF_LEN   32
#define UART_MAX_INTERFACE 6
static unsigned char uart_rx_buf[UART_MAX_INTERFACE][UART_RCV_BUF_LEN+1];
static unsigned int rx_head[UART_MAX_INTERFACE] = {0};
static unsigned int rx_tail[UART_MAX_INTERFACE] = {0};
static unsigned int uart_rx_mode[UART_MAX_INTERFACE] = {0}; /* 0 polling or 1 - interrupt*/
static unsigned int uart_isr_ent[UART_MAX_INTERFACE] = {0};

#define UART_RCV_BUF_FULL   ((((rx_tail[interface]+1)&(UART_RCV_BUF_LEN-1)) == rx_head[interface])?1:0)
#define UART_RCV_BUF_EMPTY   ((rx_tail[interface] == rx_head[interface]) ? 1 : 0)

static int g_uart_interface = 0;

int uart_get_interface_offset()
{
	return g_uart_interface * 0x1000;
}
void uart_set_interface( int interface, int parity, int clock_div )
{
	if( interface >= 6 || interface < 0 )
		interface = 0;

	if( interface < 6 )
	{
		g_uart_interface = interface;
		uart_set_cfg_interface(interface, parity, clock_div);	
	}
		
}
void uart_rx_isr_interface (int interface)	
{  
	int dummy;
	int cnt = 0;
	if( uart_isr_ent[interface] == 1 )
	{
		printf("U%d",interface);
		//uart_isr_ent[interface] = 0;
	}

	while((*((volatile int*)UART_REG_LSR) & 0x1) == 0x1)
	{
		dummy = *((volatile int*)UART_REG_RBR);
		if( dummy == '\n' )
			uart_isr_ent[interface] = 0;

		if( !UART_RCV_BUF_FULL )
		{
			uart_rx_buf[interface][rx_tail[interface]] = dummy;
			rx_tail[interface] ++;
			if( rx_tail[interface] >= UART_RCV_BUF_LEN)
				rx_tail[interface] = 0;
		}
		if( cnt++ > UART_RCV_BUF_LEN )
			break;		
	}
	if( cnt > UART_RCV_BUF_LEN )
		uart_sendchar_interface(g_uart_interface,'#');

	*(volatile unsigned int*)UART_REG_ICR = 0x2;
	*(volatile unsigned int*)UART_REG_ICR = 0x0;
	ICP = (1<<(ISR_NUM_UART0-interface)); 
}

void uart_rx_isr()
{
	uart_rx_isr_interface(g_uart_interface);
}


static void uart_int_enable_interface(int interface, int en )
{	
	if( en && uart_rx_mode[interface] )
	{
		IER |= (1 << (ISR_NUM_UART0-interface));
	}
	else
	{
		IER &= ~(1 << (ISR_NUM_UART0-interface));
	}
}
static void uart_int_enable(int en )
{	
	uart_int_enable_interface(g_uart_interface, en);
}

void uart_enable_rxint_interface(int interface, unsigned char en)
{
	uart_rx_mode[interface] = en;
	rx_head[interface] = 0;
	rx_tail[interface] = 0;
	uart_isr_ent[interface] = 1;
	*(volatile unsigned int*)UART_REG_ICR = 0x2;
	*(volatile unsigned int*)UART_REG_ICR = 0x0;
	if( en )
	{
		IER |= (1 << (ISR_NUM_UART0-interface));
		EER |= (1 << (ISR_NUM_UART0-interface));
		*(volatile unsigned int*)(UART_REG_IER) |= 0x10;
		//*(volatile unsigned int*)(UART_REG_IER) = ((*(volatile unsigned int*)(UART_REG_IER)) & 0x00) | 0x1; // set IER (interrupt enable register) on UART

	}
	else
	{
		IER &= ~(1 << (ISR_NUM_UART0-interface));
		EER &= ~(1 << (ISR_NUM_UART0-interface));
		*(volatile unsigned int*)(UART_REG_IER) = 0x0;
		//*(volatile unsigned int*)(UART_REG_IER) = ((*(volatile unsigned int*)(UART_REG_IER)) & 0x00) | 0x0; // set IER (interrupt enable register) on UART		
	}
}
void uart_enable_rxint(unsigned char en)
{
	uart_enable_rxint_interface(g_uart_interface, en);
}

/**
 * Setup UART. The UART defaults to 8 bit character mode with 1 stop bit.
 *
 * parity       Enable/disable parity mode
 * clk_counter  Clock counter value that is used to derive the UART clock.
 *              It has to be in the range of 1..2^16.
 *              There is a prescaler in place that already divides the SoC
 *              clock by 16.  Since this is a counter, a value of 1 means that
 *              the SoC clock divided by 16*2 = 32 is used. A value of 31 would mean
 *              that we use the SoC clock divided by 16*32 = 512.
 */
void uart_set_cfg_interface(int interface, int parity, uint16_t clk_counter) {
  unsigned int i;
  CGREG |= (1 << CGUART); // don't clock gate UART
  *(volatile unsigned int*)(UART_REG_LCR) = 0x83; //sets 8N1 and set DLAB to 1
  *(volatile unsigned int*)(UART_REG_DLM) = (clk_counter >> 8) & 0xFF;
  *(volatile unsigned int*)(UART_REG_DLL) =  clk_counter       & 0xFF;
  *(volatile unsigned int*)(UART_REG_FCR) = 0xA7; //enables 16byte FIFO and clear FIFOs
  *(volatile unsigned int*)(UART_REG_LCR) = 0x03; //sets 8N1 and set DLAB to 0
  
  *(volatile unsigned int*)(UART_REG_IER) = ((*(volatile unsigned int*)(UART_REG_IER)) & 0x00) | 0x0; // set IER (interrupt enable register) on UART
  uart_enable_rxint_interface(interface, uart_rx_mode[interface]);
}

void uart_set_cfg(int parity, uint16_t clk_counter) {
	uart_set_cfg_interface(g_uart_interface, parity, clk_counter);  
}

void uart_send_interface(int interface, const char* str, unsigned int len) {
  unsigned int i;

  while(len > 0) {
    // process this in batches of 16 bytes to actually use the FIFO in the UART

     
    //for(i = 0; (i < UART_FIFO_DEPTH) && (len > 0); i++) 
    {	
	
	// wait until there is space in the fifo
	while( (*(volatile unsigned int*)(UART_REG_LSR) & 0x20) == 0);

	// load FIFO
	*(volatile unsigned int*)(UART_REG_THR) = *str++;
	len--;
    }
  }
}

void uart_send(const char* str, unsigned int len) {
  uart_send_interface(g_uart_interface, str, len);  
}


char uart_key_pressed_interface(int interface, unsigned char *key)
{

	if( uart_rx_mode[interface])
	{
		if( rx_tail[interface] == rx_head[interface] )
			return 0;
		if( key )
		{
				*key = uart_rx_buf[interface][rx_head[interface]];
				uart_int_enable_interface(interface, 0);
				rx_head[interface] ++;
				if( rx_head[interface] >= UART_RCV_BUF_LEN)
					rx_head[interface] = 0;
				uart_int_enable_interface(interface, 1);
		}
		return 1;
	}
	else
	{
		if ( ( *((volatile int*)UART_REG_LSR) & 0x1) == 0x1)
		{
			if( key )
				*key = *(volatile int*)UART_REG_RBR;
			return 1;
		}
		else
		{
			return 0;
		}
	}
}

char uart_key_pressed(unsigned char *key)
{
	uart_key_pressed_interface( g_uart_interface, key );
}

char uart_getchar_interface(int interface) {
	char key;
	if( uart_rx_mode[interface])
	{
		while( rx_tail[interface] == rx_head[interface] ) 
			__asm volatile 	( " nop " );
		
		key = uart_rx_buf[interface][rx_head[interface]];
		uart_int_enable_interface(interface, 0);
		rx_head[interface] ++;
		if( rx_head[interface] >= UART_RCV_BUF_LEN)
			rx_head[interface] = 0;
		uart_int_enable_interface(interface, 1);
		return key;				
	}
	else
	{
		while((*((volatile int*)UART_REG_LSR) & 0x1) != 0x1);
		return *(volatile int*)UART_REG_RBR;
	}
}

char uart_getchar() {
	return uart_getchar_interface(g_uart_interface);
}

int uart_receive_interface(int interface, char *str, int size) {
	int i = 0;
	while( i < size )
	{
		str[i++] = uart_getchar_interface(interface);
		if( str[i-1] == '\n' )
			break;
	}
	return i;
}
void uart_sendchar_interface(int interface, const char c) {
  // wait until there is space in the fifo
  while( (*(volatile unsigned int*)(UART_REG_LSR) & 0x20) == 0);

  // load FIFO
  *(volatile unsigned int*)(UART_REG_THR) = c;
}
void uart_sendchar(const char c) {
	uart_sendchar_interface(g_uart_interface,c); 
}

void uart_wait_tx_done_interface(int interface) {
  // wait until there is space in the fifo
  int cnt = 10000;
  while( (*(volatile unsigned int*)(UART_REG_LSR) & 0x40) == 0 && --cnt > 0);
}

void uart_wait_tx_done(void) {
  // wait until there is space in the fifo
  uart_wait_tx_done_interface(g_uart_interface);
}

