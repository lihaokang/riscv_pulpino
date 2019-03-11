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
 * 2019-02-16     lgq          the first version
 */


#include "drv_console.h"


void console_init(uint32_t baudrate)
{
    uartx_set_conf(UART0, baudrate, UART_8BITS, UART_PARITY_NONE, UART_STOP_1); 
    uartx_int_enable(UART0); 
}

void console_send(const char* str, uint32_t len)
{
    uartx_send(UART0, str, len); 
    uartx_wait_tx_done(UART0);   
}

void console_send_char(const char c)
{
    uartx_send_char(UART0, c);
    uartx_wait_tx_done(UART0);
}

char console_get_char(void)
{
    return uartx_get_char(UART0);
}
