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


#include "drv_wdt.h"
#include "utils.h"
#include "proton.h"


wdt_dev_t* const WDT = (wdt_dev_t*)WDT_BASE_ADDR;


void wdt_init(void)
{
    // todo: enable clock
    CGREG |= CG_WDT;    
}

void wdt_deinit(void)
{
    // todo: disable clock
    CGREG &= ~CG_WDT;    
}

void wdt_start(uint32_t timeout)
{
    WDT->svr = timeout;
    WDT->wer = WDT_EN;
}

void wdt_keep_alive(void)
{
    WDT->fwr = WDT_KA;
}

void wdt_reset_mcu(void)
{
    WDT->svr = (uint32_t)0x3;
    WDT->wer = WDT_EN;
    while (1);   
}

