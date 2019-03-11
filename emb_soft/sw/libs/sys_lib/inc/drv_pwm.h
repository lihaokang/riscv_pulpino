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
 

#ifndef __DRV_PWM_H__
#define __DRV_PWM_H__


#include <proton.h>
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	PWM_BASE_ADDR			(0x1A102000)

typedef struct _pwm_dev
{
	volatile uint32_t pwm_prop[16];
    volatile uint32_t pwm_reverse;	
    volatile uint32_t pwm_ctrl;							
} __attribute__((packed, aligned(4))) pwm_dev_t; 

#define PWM_CHANNEL_NR          (8)
#define PWM_CH0                 ((uint32_t)0x00)
#define PWM_CH1                 ((uint32_t)0x01)
#define PWM_CH2                 ((uint32_t)0x02)
#define PWM_CH3                 ((uint32_t)0x03)
#define PWM_CH4                 ((uint32_t)0x04)
#define PWM_CH5                 ((uint32_t)0x05)
#define PWM_CH6                 ((uint32_t)0x06)
#define PWM_CH7                 ((uint32_t)0x07)
#define PWM_CH0_MASK            ((uint32_t)0x01)
#define PWM_CH1_MASK            ((uint32_t)0x02)
#define PWM_CH2_MASK            ((uint32_t)0x04)
#define PWM_CH3_MASK            ((uint32_t)0x08)
#define PWM_CH4_MASK            ((uint32_t)0x10)
#define PWM_CH5_MASK            ((uint32_t)0x20)
#define PWM_CH6_MASK            ((uint32_t)0x40)
#define PWM_CH7_MASK            ((uint32_t)0x80)

int pwm_init(void);
int pwm_deinit(void);
int pwm_set_channel(uint32_t channel, uint32_t period, uint32_t pulse, uint32_t polarity);
int pwm_enable_channel(uint32_t channel);
int pwm_disable_channel(uint32_t channel);
int pwm_enable_all_channel(void);
int pwm_disable_all_channel(void);
int pwm_enable_multi_channel(uint32_t channel_mask);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_PWM_H__ */
