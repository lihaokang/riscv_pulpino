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


#ifndef __DRV_CONSOLE_H__
#define __DRV_CONSOLE_H__


#include "drv_uart.h"
#include "utils.h"
#include "proton.h"


#ifdef __cplusplus
extern "C" {
#endif


void console_init(uint32_t baudrate);
void console_send(const char* str, uint32_t len);
void console_send_char(const char c);
char console_get_char(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_CONSOLE_H__ */
