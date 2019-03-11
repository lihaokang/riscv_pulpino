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
 * 2019-02-14     lgq          the first version
 */


#ifndef __DRV_TIMER_H__
#define __DRV_TIMER_H__


#include "proton.h"
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	TIMER0_BASE_ADDR			(0x1A103000)
#define	TIMER1_BASE_ADDR			(0x1A103010)
#define	TIMER2_BASE_ADDR			(0x1A103020)
#define	TIMER3_BASE_ADDR			(0x1A103030)

#define TIMER0_EVT                  (((uint32_t)0x1) << 24)
#define TIMER1_EVT                  (((uint32_t)0x1) << 25)
#define TIMER2_EVT                  (((uint32_t)0x1) << 26)
#define TIMER3_EVT                  (((uint32_t)0x1) << 27)

typedef struct _timer_dev
{
	volatile uint32_t counter;			
    volatile uint32_t ctrl;
    volatile uint32_t output_cmp;			
} __attribute__((packed, aligned(4))) timer_dev_t;

extern timer_dev_t* const TIMER0;
extern timer_dev_t* const TIMER1; 
extern timer_dev_t* const TIMER2; 
extern timer_dev_t* const TIMER3; 

#define TMR0_CMP                    (*(volatile uint32_t *)(TIMER0_BASE_ADDR + 0x8))
#define TMR0_CTL                    (*(volatile uint32_t *)(TIMER0_BASE_ADDR + 0x4))


#define TIMER0_INT_RESET()          do { ECP = TIMER0_EVT; ICP = TIMER0_EVT; } while(0)
#define TIMER1_INT_RESET()          do { ECP = TIMER1_EVT; ICP = TIMER1_EVT; } while(0)
#define TIMER2_INT_RESET()          do { ECP = TIMER2_EVT; ICP = TIMER2_EVT; } while(0)
#define TIMER3_INT_RESET()          do { ECP = TIMER3_EVT; ICP = TIMER3_EVT; } while(0)


int timer_deinit(timer_dev_t *timer);
int timer_init(timer_dev_t *timer);

int timer_int_enable(timer_dev_t *timer);
int timer_int_disable(timer_dev_t *timer);
int timer_int_reset(timer_dev_t *timer);

int timer_set_prescaler(timer_dev_t *timer, uint32_t prescaler);
int timer_reset(timer_dev_t *timer);
int timer_start(timer_dev_t *timer);
int timer_stop(timer_dev_t *timer);
uint32_t timer_get_count(timer_dev_t *timer);
int timer_set_output_cmp(timer_dev_t *timer, uint32_t cmp);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_TIMER_H__ */
