// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/**
 * @file
 * @brief 16750 UART library.
 *
 * Provides UART helper function like setting
 * control registers and reading/writing over
 * the serial interface.
 *
 */
#ifndef _UART_H
#define _UART_H

#include "pulpino.h"
#include <stdint.h>

#define UART_INTERFACE_OFFSET ((interface) * 0x1000)
#define UART_REG_RBR ( UART_BASE_ADDR + 0x00 + UART_INTERFACE_OFFSET) // Receiver Buffer Register (Read Only)
#define UART_REG_DLL ( UART_BASE_ADDR + 0x00 + UART_INTERFACE_OFFSET) // Divisor Latch (LS)
#define UART_REG_THR ( UART_BASE_ADDR + 0x00 + UART_INTERFACE_OFFSET) // Transmitter Holding Register (Write Only)
#define UART_REG_DLM ( UART_BASE_ADDR + 0x04 + UART_INTERFACE_OFFSET) // Divisor Latch (MS)
#define UART_REG_IER ( UART_BASE_ADDR + 0x04 + UART_INTERFACE_OFFSET) // Interrupt Enable Register
#define UART_REG_IIR ( UART_BASE_ADDR + 0x08 + UART_INTERFACE_OFFSET) // Interrupt Identity Register (Read Only)
#define UART_REG_FCR ( UART_BASE_ADDR + 0x08 + UART_INTERFACE_OFFSET) // FIFO Control Register (Write Only)
#define UART_REG_LCR ( UART_BASE_ADDR + 0x0C + UART_INTERFACE_OFFSET) // Line Control Register
#define UART_REG_MCR ( UART_BASE_ADDR + 0x10 + UART_INTERFACE_OFFSET) // MODEM Control Register
#define UART_REG_LSR ( UART_BASE_ADDR + 0x14 + UART_INTERFACE_OFFSET) // Line Status Register
#define UART_REG_MSR ( UART_BASE_ADDR + 0x18 + UART_INTERFACE_OFFSET) // MODEM Status Register
#define UART_REG_SCR ( UART_BASE_ADDR + 0x1C + UART_INTERFACE_OFFSET) // Scratch Register
#define UART_REG_ICR ( UART_BASE_ADDR + 0x20 + UART_INTERFACE_OFFSET) // Interrupt Clear Register

#if 0
#define RBR_UART REGP_8(UART_REG_RBR)
#define DLL_UART REGP_8(UART_REG_DLL)
#define THR_UART REGP_8(UART_REG_THR)
#define DLM_UART REGP_8(UART_REG_DLM)
#define IER_UART REGP_8(UART_REG_IER)
#define IIR_UART REGP_8(UART_REG_IIR)
#define FCR_UART REGP_8(UART_REG_FCR)
#define LCR_UART REGP_8(UART_REG_LCR)
#define MCR_UART REGP_8(UART_REG_MCR)
#define LSR_UART REGP_8(UART_REG_LSR)
#define MSR_UART REGP_8(UART_REG_MSR)
#define SCR_UART REGP_8(UART_REG_SCR)
#define ICR_UART REGP_8(UART_REG_ICR)
#endif

#define DLAB 1<<7 	//DLAB bit in LCR reg
#define ERBFI 1 	//ERBFI bit in IER reg
#define ETBEI 1<<1 	//ETBEI bit in IER reg
#define PE 1<<2 	//PE bit in LSR reg
#define THRE 1<<5 	//THRE bit in LSR reg
#define DR 1	 	//DR bit in LSR reg


#define UART_FIFO_DEPTH 64

//UART_FIFO_DEPTH but to be compatible with Arduino_libs and also if in future designs it differed
#define SERIAL_RX_BUFFER_SIZE UART_FIFO_DEPTH
#define SERIAL_TX_BUFFER_SIZE UART_FIFO_DEPTH

#if 1
#define UART_BAUDRATE(clkrate, baudrate) (((clkrate)/(baudrate)) > 1 ? ((clkrate)/(baudrate)-1):0)
#else
#define UART_BAUDRATE(clkrate, baudrate) 162
#endif

void uart_set_cfg(int parity, uint16_t clk_counter);

void uart_send(const char* str, unsigned int len);
void uart_sendchar(const char c);

char uart_getchar();
char uart_key_pressed(unsigned char *key);

void uart_wait_tx_done(void);
void uart_enable_rxint(unsigned char en);

void uart_rx_isr (void)	;

int uart_get_interface_offset();

void uart_set_interface( int interface, int parity, int clock_div );
void uart_set_cfg_interface(int interface, int parity, uint16_t clk_counter);

void uart_send_interface(int interface,const char* str, unsigned int len);
void uart_sendchar_interface(int interface, const char c);

char uart_getchar_interface(int interface);
char uart_key_pressed_interface(int interface,unsigned char *key);

void uart_wait_tx_done_interface(int interface);
void uart_enable_rxint_interface(int interface,unsigned char en);

void uart_rx_isr_interface(int interface);
int uart_receive_interface(int interface, char *str, int maxsize);



#endif
