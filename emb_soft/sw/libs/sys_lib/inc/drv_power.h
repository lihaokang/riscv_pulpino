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


#ifndef __DRV_POWER_H__
#define __DRV_POWER_H__


#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define POWER_BASE_ADDR			(0x12000000)

#define PVD_1P75V				((uint32_t)0x0)
#define PVD_2P00V				((uint32_t)0x1)
#define PVD_2P25V				((uint32_t)0x2)
#define PVD_2P50V				((uint32_t)0x3)
#define PVD_2P75V				((uint32_t)0x4)
#define PVD_3P00V				((uint32_t)0x5)
#define PVD_3P25V				((uint32_t)0x6)
#define PVD_3P50V				((uint32_t)0x7)
#define PVD_3P75V				((uint32_t)0x8)
#define PVD_4P00V				((uint32_t)0x9)
#define PVD_4P25V				((uint32_t)0xA)
#define PVD_4P50V				((uint32_t)0xB)
#define PVD_4P75V				((uint32_t)0xC)
#define PVD_5P00V				((uint32_t)0xD)
#define PVD_5P25V				((uint32_t)0xE)
#define PVD_5P50V				((uint32_t)0xF)

typedef struct _power_ctrl
{
	volatile uint32_t pd15;
	volatile uint32_t vcs;
	volatile uint32_t pdv2i;
	volatile uint32_t pdpvd;
	volatile uint32_t pvdsl;
	volatile uint32_t pvdin;
} __attribute__((packed, aligned(4))) power_ctrl_t;

int power_core_1p5v_set(uint32_t enable);
uint32_t power_core_1p5v_get(void); 
uint32_t power_core_1p5v_is_ready(void);

int power_bais_powerdown_set(uint32_t enable);
uint32_t power_bais_powerdown_get(void);

int power_pvd_powerdown_set(uint32_t enable);
uint32_t power_pvd_powerdown_get(void);
int power_pvd_threshold_set(uint32_t vol);
uint32_t power_pvd_threshold_get(void);
uint32_t power_pvd_status_get(void);
uint32_t power_vcc_value_get(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_POWER_H__ */

