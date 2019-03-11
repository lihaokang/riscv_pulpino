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
 * 2019-02-22     lgq          the first version
 */


#include "drv_pwm.h"


pwm_dev_t* const PWM = (pwm_dev_t*)PWM_BASE_ADDR;


int pwm_init(void)
{
    // todo: enable clock
    CGREG |= CG_PWM;
    return 0;
}

int pwm_deinit(void)
{
    // todo: disable clock
    CGREG &= ~CG_PWM;
    return 0;
}

int pwm_set_channel(uint32_t channel, uint32_t period, uint32_t pulse, uint32_t reverse)
{
    if (channel >= PWM_CHANNEL_NR) return -1;
    if (period == 0) return -1;
    if (period <= pulse) return -1;
    
    // PWM->pwm_ctrl &= ~(((uint32_t)0x1) << channel);
    PWM->pwm_prop[channel << 1] = period;
    PWM->pwm_prop[(channel << 1) + 1] = pulse;
    if (reverse)
    {
        PWM->pwm_reverse |= (((uint32_t)0x1) << channel);
    }
    else
    {
        PWM->pwm_reverse &= ~(((uint32_t)0x1) << channel);
    }
    
    return 0;
}

int pwm_enable_channel(uint32_t channel)
{
    if (channel >= PWM_CHANNEL_NR) return -1;
    
    PWM->pwm_ctrl |= (((uint32_t)0x1) << channel);
    
    return 0;
}

int pwm_disable_channel(uint32_t channel)
{
    if (channel >= PWM_CHANNEL_NR) return -1;
    
    PWM->pwm_ctrl &= ~(((uint32_t)0x1) << channel);
    
    return 0;
}

int pwm_enable_all_channel(void)
{
    PWM->pwm_ctrl = ((uint32_t)0xff);

    return 0;
}

int pwm_disable_all_channel(void)
{
    PWM->pwm_ctrl = ((uint32_t)0x0);

    return 0;
}

int pwm_enable_multi_channel(uint32_t channel_mask)
{
    if ( channel_mask > ((uint32_t)0xff) ) return -1;

    PWM->pwm_ctrl = channel_mask;
    
    return 0;
}

