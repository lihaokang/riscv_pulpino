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
 

#ifndef __DRV_SCU_H__
#define __DRV_SCU_H__


#include <proton.h>
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	SCU_BASE_ADDR			(0x1B003000)

typedef struct _scu_dev
{
	volatile uint32_t srw;	
	volatile uint32_t rrs;						
} __attribute__((packed, aligned(4))) scu_dev_t; 

#define RESET_KEY          		((uint32_t)0x20190114)

#define RESET_POR				((uint32_t)0x1)
#define RESET_EXT				((uint32_t)0x2)
#define RESET_WDT				((uint32_t)0x4)
#define RESET_SW				((uint32_t)0x8)

void scu_reset_mcu(void);
uint32_t scu_get_reset_reason(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_SCU_H__ */
