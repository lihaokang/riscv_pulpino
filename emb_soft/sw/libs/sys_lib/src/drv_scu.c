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


#include "drv_scu.h"
#include "utils.h"
#include "proton.h"


scu_dev_t* const SCU = (scu_dev_t*)SCU_BASE_ADDR;


void scu_reset_mcu(void)
{
    SCU->srw = RESET_KEY;
    while (1);
}

uint32_t scu_get_reset_reason(void)
{
    return SCU->rrs;
}
