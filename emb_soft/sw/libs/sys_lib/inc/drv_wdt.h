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
 * 2019-02-19     lgq          the first version
 */
 

#ifndef __DRV_WDT_H__
#define __DRV_WDT_H__


#include <proton.h>
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	WDT_BASE_ADDR			(0x1B000000)

typedef struct _wdt_dev
{
	volatile uint32_t svr;			
	volatile uint32_t wer;			
	volatile uint32_t fwr;			
} __attribute__((packed, aligned(4))) wdt_dev_t; 

#define WDT_EN          		((uint32_t)0x1)
#define WDT_KA          		((uint32_t)0x76)


void wdt_init(void);
void wdt_deinit(void);
void wdt_start(uint32_t timeout);
void wdt_keep_alive(void);
void wdt_reset_mcu(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_WDT_H__ */
