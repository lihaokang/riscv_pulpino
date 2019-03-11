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


#ifndef __DRV_CLOCK_H__
#define __DRV_CLOCK_H__


#include "proton.h"
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	CLOCK_BASE_ADDR			(0x1B003200)

typedef struct _clock_dev
{
	volatile uint32_t scs;			
	volatile uint32_t lcs;			
	volatile uint32_t acs;			
	volatile uint32_t hcm;			
	volatile uint32_t css;			
	volatile uint32_t sio;
    volatile uint32_t ecs;
    volatile uint32_t tcs;
} __attribute__((packed, aligned(4))) clock_dev_t; 


#define EXT_CLOCK_FREQ       	((uint32_t)32768)	// !!!

#define EXT_CLOCK_SOURCE_XTAL	((uint32_t)0x0)
#define EXT_CLOCK_SOURCE_AC		((uint32_t)0x1)

#define LF_CLOCK_SOURCE_32K    	((uint32_t)0x0)
#define LF_CLOCK_SOURCE_EXT    	((uint32_t)0x1)

#define SYSCLK_FREQ_32M   		((uint32_t)0x0)
#define SYSCLK_FREQ_16M   		((uint32_t)0x1)
#define SYSCLK_FREQ_8M    		((uint32_t)0x2)
#define SYSCLK_FREQ_4M    		((uint32_t)0x3)
#define SYSCLK_FREQ_2M    		((uint32_t)0x4)
#define SYSCLK_FREQ_1M    		((uint32_t)0x5)
#define SYSCLK_FREQ_32K    		((uint32_t)0x6)
#define SYSCLK_FREQ_EXT    		((uint32_t)0x7)

#define ADCCLK_FREQ_32M   		((uint32_t)0x0)
#define ADCCLK_FREQ_16M   		((uint32_t)0x1)
#define ADCCLK_FREQ_8M    		((uint32_t)0x2)
#define ADCCLK_FREQ_4M    		((uint32_t)0x3)
#define ADCCLK_FREQ_2M    		((uint32_t)0x4)
#define ADCCLK_FREQ_1M    		((uint32_t)0x5)

#define HF_CLOCK_IS_READY()     (clock_status_get() & ((uint32_t)0x1))
#define LF_CLOCK_IS_READY()     (clock_status_get() & ((uint32_t)0x2))
#define EXT_CLOCK_IS_READY()    (clock_status_get() & ((uint32_t)0x4))

int system_clock_set(uint32_t freq);
uint32_t system_clock_get(void);

int lf_clock_select(uint32_t source);
void hf_clock_enable(uint32_t enable);
void ext_clock_enable(uint32_t source, uint32_t enable);

int adc_clock_select(uint32_t freq);
uint32_t clock_status_get(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_CLOCK_H__ */
