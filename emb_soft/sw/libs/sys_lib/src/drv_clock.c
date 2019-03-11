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


#include "drv_clock.h"


clock_dev_t* const CLOCK = (clock_dev_t*)CLOCK_BASE_ADDR;


int system_clock_set(uint32_t freq)
{
    if (freq > 7) return -1;

    CLOCK->scs = freq;

    return 0;
}

uint32_t system_clock_get(void)
{
    uint32_t clock;
    
    switch(CLOCK->scs)
    {
        case SYSCLK_FREQ_32M:
            clock = 32000000;
            break ;
        case SYSCLK_FREQ_16M:
            clock = 16000000;
            break ;
        case SYSCLK_FREQ_8M:
            clock = 8000000;
            break ;
        case SYSCLK_FREQ_4M:
            clock = 4000000;
            break ;
        case SYSCLK_FREQ_2M:
            clock = 2000000;
            break ;
        case SYSCLK_FREQ_1M:
            clock = 1000000;
            break ;
        case SYSCLK_FREQ_32K:
            clock = 32768;
            break ;
        case SYSCLK_FREQ_EXT:
            clock = EXT_CLOCK_FREQ;
            break ;
        default:
            clock = 32000000;
            break ;
    }

    return clock;
}

int lf_clock_select(uint32_t source)
{
    if (source > 0x1) return -1;

    CLOCK->lcs = source;

    return 0;
}

int adc_clock_select(uint32_t freq)
{
    if (freq > 0x5) return -1;

    CLOCK->lcs = freq;
    
    return 0;
}

void hf_clock_enable(uint32_t enable)
{
    if (enable)
    {
        CLOCK->hcm = 0x12345678;
    }
    else
    {
        CLOCK->hcm = 0x31415926;
    }
}

uint32_t clock_status_get(void)
{
    return CLOCK->css; 
}

void ext_clock_enable(uint32_t source, uint32_t enable)
{
    if (enable)
    {
        if (source == EXT_CLOCK_SOURCE_XTAL)
        {
            CLOCK->ecs = 0x2;
        }
        else
        {
            CLOCK->ecs = 0x3;
        }
    }
    else
    {
        CLOCK->ecs = 0;
    }
}
