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


#include "drv_clockcal.h"


clockcal_t *const cal = (clockcal_t *)CLOCKCAL_BASE_ADDR;

int clockcal_calibrate(void)
{
	cal->scd_hf = 0x00000001;
	cal->scd_lf = 0x00000400;

	cal->scv_hf = 0x000003D0;
	cal->scv_lf = 0x00000400;

	cal->sco = 0x00000003;

	while (!(cal->int_hf & 0x1));
	while (!(cal->int_lf & 0x1));

	return 0;
}

int clockcal_write_factor_to_memory(uint32_t svs_hf, uint32_t svs_lf)
{
	/* todo: */
	return 0;
}

int clockcal_read_factor_from_memory(uint32_t *svs_hf, uint32_t *svs_lf)
{
	/* todo: */
	return 0;
}

int clockcal_read_factor_register(uint32_t *svs_hf, uint32_t *svs_lf)
{
	if ((svs_hf == NULL) || (svs_lf == NULL))
		return -1;
	
	*svs_hf = cal->svs_hf;
	*svs_lf = cal->svs_lf;

	return 0;
}

int clockcal_write_factor_register(uint32_t svs_hf, uint32_t svs_lf)
{
	cal->svs_hf = svs_hf;
	cal->svs_lf = svs_lf;

	return 0;
}
