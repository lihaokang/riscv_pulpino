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


#include "drv_power.h"


power_ctrl_t *const pwr_ctrl = (power_ctrl_t *)POWER_BASE_ADDR;

static const uint32_t vol_tab[16] = 
{
	PVD_1P75V,
	PVD_2P00V,
	PVD_2P25V,
	PVD_2P50V,
	PVD_2P75V,
	PVD_3P00V,
	PVD_3P25V,
	PVD_3P50V,
	PVD_3P75V,
	PVD_4P00V,
	PVD_4P25V,
	PVD_4P50V,
	PVD_4P75V,
	PVD_5P00V,
	PVD_5P25V,
	PVD_5P50V,
};

int power_core_1p5v_set(uint32_t enable)
{
	pwr_ctrl->pd15 = ((enable > 0) ? 0x0 : 0x1);

	return 0;
}

uint32_t power_core_1p5v_get(void)
{
	return ((pwr_ctrl->pd15 & 0x01) ? 0 : 1);
} 

uint32_t power_core_1p5v_is_ready(void)
{
	return (pwr_ctrl->vcs & 0x01);
}

int power_bais_powerdown_set(uint32_t enable)
{
	pwr_ctrl->pdv2i = ((enable > 0) ? 0x1 : 0x0);

	return 0;
}

uint32_t power_bais_powerdown_get(void)
{
	return (pwr_ctrl->pdv2i & 0x1);
}

int power_pvd_powerdown_set(uint32_t enable)
{
	pwr_ctrl->pdpvd = ((enable > 0) ? 0x1 : 0x0);

	return 0;
}

uint32_t power_pvd_powerdown_get(void)
{
	return (pwr_ctrl->pdpvd & 0x1);
}

int power_pvd_threshold_set(uint32_t vol)
{
	if (vol > 0xF)
		return -1;
	
	pwr_ctrl->pvdsl = (vol & 0xF);

	return 0;
}

uint32_t power_pvd_threshold_get(void)
{
	return (pwr_ctrl->pvdsl & 0xF);
}

uint32_t power_pvd_status_get(void)
{
	return (pwr_ctrl->pvdin & 0x1);
}

uint32_t power_vcc_value_get(void)
{
	volatile int delay;
	int i;

	for (i=sizeof(vol_tab)/sizeof(vol_tab[0])-1; i>=0; i--)
	{
		power_pvd_threshold_set(vol_tab[i]);
		delay = 5000;
		while (--delay);
		if (power_pvd_status_get() > 0)
			break;
	}

	if (i < 0)
		return vol_tab[0];

	return vol_tab[i];
}

