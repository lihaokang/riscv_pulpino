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


#include "drv_timer.h"
#include "utils.h"
#include "proton.h"


timer_dev_t* const TIMER0 = (timer_dev_t*)TIMER0_BASE_ADDR;
timer_dev_t* const TIMER1 = (timer_dev_t*)TIMER1_BASE_ADDR;
timer_dev_t* const TIMER2 = (timer_dev_t*)TIMER2_BASE_ADDR;
timer_dev_t* const TIMER3 = (timer_dev_t*)TIMER3_BASE_ADDR;


int timer_deinit(timer_dev_t *timer)
{
    if (timer == NULL) return -1;

    // todo: enable clock
    CGREG |= CG_TIMER;
    
    timer->ctrl = 0;
    timer->counter = 0;

    return 0;
}

int timer_init(timer_dev_t *timer)
{
    if (timer == NULL) return -1;

    timer->ctrl = 0;
    timer->counter = 0;

    // todo: enable clock
    CGREG &= ~CG_TIMER;

    return 0;
}

int timer_int_enable(timer_dev_t *timer)
{
    if (timer == NULL) return -1; 

    if (timer == TIMER0)
    {
	    EER |= TIMER0_EVT;  
	    IER |= TIMER0_EVT;          
    }
    else if (timer == TIMER1)
    {
	    EER |= TIMER1_EVT;  
	    IER |= TIMER1_EVT; 
    }
    else if (timer == TIMER2)
    {
	    EER |= TIMER2_EVT;  
	    IER |= TIMER2_EVT; 
    }
    else if (timer == TIMER3)
    {
	    EER |= TIMER3_EVT;  
	    IER |= TIMER3_EVT; 
    }

    return 0;  
}

int timer_int_disable(timer_dev_t *timer)
{
    if (timer == NULL) return -1; 

    if (timer == TIMER0)
    {
	    EER &= ~TIMER0_EVT;  
	    IER &= ~TIMER0_EVT;          
    }
    else if (timer == TIMER1)
    {
	    EER &= ~TIMER1_EVT;  
	    IER &= ~TIMER1_EVT; 
    }
    else if (timer == TIMER2)
    {
	    EER &= ~TIMER2_EVT;  
	    IER &= ~TIMER2_EVT; 
    }
    else if (timer == TIMER3)
    {
	    EER &= ~TIMER3_EVT;  
	    IER &= ~TIMER3_EVT; 
    }

    return 0;  
}

int timer_int_reset(timer_dev_t *timer)
{
    if (timer == NULL) return -1; 

    if (timer == TIMER0)
    {
	    ICP = TIMER0_EVT;  
	    ECP = TIMER0_EVT;          
    }
    else if (timer == TIMER1)
    {
	    ICP = TIMER1_EVT;  
	    ECP = TIMER1_EVT; 
    }
    else if (timer == TIMER2)
    {
	    ICP = TIMER2_EVT;  
	    ECP = TIMER2_EVT; 
    }
    else if (timer == TIMER3)
    {
	    ICP = TIMER3_EVT;  
	    ECP = TIMER3_EVT; 
    }

    return 0;
}

int timer_set_prescaler(timer_dev_t *timer, uint32_t prescaler)
{
    if (timer == NULL) return -1;
    if (prescaler > 7) 
        prescaler = 7;
    
    timer->ctrl = (prescaler << 3);

    return 0;  
}

int timer_reset(timer_dev_t *timer)
{
    if (timer == NULL) return -1;
    
    timer->counter = 0;

    return 0;
}

int timer_start(timer_dev_t *timer)
{
    if (timer == NULL) return -1;
    
    timer->ctrl |= 0x1;

    return 0;
}

int timer_stop(timer_dev_t *timer)
{
    if (timer == NULL) return -1;
    
    timer->ctrl &= ~0x1;

    return 0;
}

uint32_t timer_get_count(timer_dev_t *timer)
{
    if (timer == NULL) return 0;
    
    return timer->counter;
}

int timer_set_output_cmp(timer_dev_t *timer, uint32_t cmp)
{
    if (timer == NULL) return -1;
    
    timer->output_cmp = cmp;

    return 0;
}


