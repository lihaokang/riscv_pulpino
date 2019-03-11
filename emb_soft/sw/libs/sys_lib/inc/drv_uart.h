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
 * 2019-01-26     lgq          the first version
 */
 

#ifndef __DRV_UART_H__
#define __DRV_UART_H__


#include "proton.h"
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	UART0_BASE_ADDR			(0x1A120000)
#define	UART1_BASE_ADDR			(0x1A121000)
#define	UART2_BASE_ADDR			(0x1A122000)
#define	UART3_BASE_ADDR			(0x1A123000)
#define	UART4_BASE_ADDR			(0x1A124000)
#define	UART5_BASE_ADDR			(0x1A125000)

#define UART0_EVT				(((uint32_t)0x1) << 18)	
#define UART1_EVT				(((uint32_t)0x1) << 17)	
#define UART2_EVT				(((uint32_t)0x1) << 16)	
#define UART3_EVT				(((uint32_t)0x1) << 15)	
#define UART4_EVT				(((uint32_t)0x1) << 14)	
#define UART5_EVT				(((uint32_t)0x1) << 13)	

typedef struct _uart_dev
{
	union 
	{
		volatile uint32_t rbr;		// Receiver Buffer Register (Read Only)
		volatile uint32_t dll;		// Divisor Latch (LS)
		volatile uint32_t thr;		// Transmitter Holding Register (Write Only)
	};
	union 
	{
		volatile uint32_t dlm;		// Divisor Latch (MS)
		volatile uint32_t ier;		// Interrupt Enable Register
	};
	union
	{
		volatile uint32_t iir;		// Interrupt Identity Register (Read Only)
		volatile uint32_t fcr;		// FIFO Control Register (Write Only)
	};
	volatile uint32_t lcr;			// Line Control Register
	volatile uint32_t mcr;			// MODEM Control Register
	volatile uint32_t lsr;			// Line Status Register
	volatile uint32_t msr;			// MODEM Status Register
	volatile uint32_t scr;			// Scratch Register
	volatile uint32_t clr_int;
	volatile uint32_t rx_elm;		// 
} __attribute__((packed, aligned(4))) uart_dev_t;

typedef enum _uart_databits
{
	UART_5BITS = 5,
	UART_6BITS = 6,
	UART_7BITS = 7,
	UART_8BITS = 8,
} uart_databits_t;

typedef enum _uart_stopbits
{
	UART_STOP_1 = 0,
	UART_STOP_1_5,
	UART_STOP_2,
} uart_stopbits_t;

typedef enum _uart_parity
{
	UART_PARITY_NONE = 0,
	UART_PARITY_ODD  = 1,
	//UART_PARITY_EVEN = 2,
} uart_parity_t;

extern uart_dev_t* const UART0;
extern uart_dev_t* const UART1;
extern uart_dev_t* const UART2;
extern uart_dev_t* const UART3;
extern uart_dev_t* const UART4;
extern uart_dev_t* const UART5;

#define DLAB 					(((uint32_t)0x1) << 7) 	// DLAB bit in LCR reg
#define ERBFI 					((uint32_t)0x1) 		// ERBFI bit in IER reg
#define ETBEI 					(((uint32_t)0x1) << 1) 	// ETBEI bit in IER reg
#define PE 						(((uint32_t)0x1) << 2) 	// PE bit in LSR reg
#define THRE 					(((uint32_t)0x1) << 5) 	// THRE bit in LSR reg
#define DR 						((uint32_t)0x1)	 		// DR bit in LSR reg


#define UART0_INT_RESET()		do { UART0->clr_int = 0x2; UART0->clr_int = 0x0;\
									ICP = UART0_EVT; ECP = UART0_EVT;} while(0)
#define UART1_INT_RESET()		do { UART1->clr_int = 0x2; UART1->clr_int = 0x0;\
									ICP = UART1_EVT; ECP = UART1_EVT;} while(0)
#define UART2_INT_RESET()		do { UART2->clr_int = 0x2; UART2->clr_int = 0x0;\
									ICP = UART2_EVT; ECP = UART2_EVT;} while(0)
#define UART3_INT_RESET()		do { UART3->clr_int = 0x2; UART3->clr_int = 0x0;\
									ICP = UART3_EVT; ECP = UART3_EVT;} while(0)
#define UART4_INT_RESET()		do { UART4->clr_int = 0x2; UART4->clr_int = 0x0;\
									ICP = UART4_EVT; ECP = UART4_EVT;} while(0)
#define UART5_INT_RESET()		do { UART5->clr_int = 0x2; UART5->clr_int = 0x0;\
									ICP = UART5_EVT; ECP = UART5_EVT;} while(0)

int uartx_init(uart_dev_t *uart);
int uartx_deinit(uart_dev_t *uart);

/* legacy API */
void uartx_set_cfg(uart_dev_t *uart, int parity, uint16_t clk_counter);
/* new API */
int uartx_set_conf(uart_dev_t *uart, uint32_t baudrate, 
					uart_databits_t databits, uart_stopbits_t stopbits, uart_parity_t parity);

int uartx_int_enable(uart_dev_t *uart);
int uartx_int_disable(uart_dev_t *uart);
int uartx_int_reset(uart_dev_t *uart);

int uartx_send(uart_dev_t *uart, const char *str, uint32_t len);
int uartx_send_char(uart_dev_t *uart, const char c);
char uartx_get_char(uart_dev_t *uart);
int uartx_wait_tx_done(uart_dev_t *uart);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_UART_H__ */
