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


#ifndef __DRV_CLOCKCAL_H__
#define __DRV_CLOCKCAL_H__


#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define CLOCKCAL_BASE_ADDR		(0x1B002000)

typedef struct _clockcal
{
	volatile uint32_t scd_hf;
	volatile uint32_t scd_lf;
	volatile uint32_t scv_hf;
	volatile uint32_t scv_lf;
	volatile uint32_t fcv_hf;
	volatile uint32_t fcv_lf;
	volatile uint32_t svs_hf;
	volatile uint32_t svs_lf;
	volatile uint32_t int_hf;
	volatile uint32_t int_lf;
	volatile uint32_t sco;
} __attribute__((packed, aligned(4))) clockcal_t;

int clockcal_calibrate(void);
int clockcal_write_factor_to_memory(uint32_t svs_hf, uint32_t svs_lf);
int clockcal_read_factor_from_memory(uint32_t *svs_hf, uint32_t *svs_lf);
int clockcal_read_factor_register(uint32_t *svs_hf, uint32_t *svs_lf);
int clockcal_write_factor_register(uint32_t svs_hf, uint32_t svs_lf);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_CLOCKCAL_H__ */
