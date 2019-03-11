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


#ifndef __DRV_RTC_H__
#define __DRV_RTC_H__


#include <stdint.h>
#include <stddef.h>
#include "pulpino.h"
#include "utils.h"
#include "int.h"


#ifdef __cplusplus
extern "C" {
#endif


#define RTC_BASE_ADDR	(0x1B001000)


typedef struct _rtc_date
{
	uint32_t date_d : 4;
	uint32_t date_td : 2;
	uint32_t date_m : 4;
	uint32_t date_tm : 1;
	uint32_t date_y : 4;
	uint32_t date_ty : 4;
	uint32_t date_c : 4;
	uint32_t date_tc : 4;
	uint32_t resv1 : 5;
} __attribute__((packed, aligned(4))) rtc_date_t;

typedef struct _rtc_time
{
	uint32_t time_s : 4;
	uint32_t time_ts : 3;
	uint32_t time_m : 4;
	uint32_t time_tm : 3;
	uint32_t time_h : 4;
	uint32_t time_th : 2;
	uint32_t time_dow : 3;
	uint32_t resv1 : 9;
} __attribute__((packed, aligned(4))) rtc_time_t;

typedef struct _rtc_alarm
{
	uint32_t alarm_m : 4;
	uint32_t alarm_tm : 3;
	uint32_t alarm_h : 4;
	uint32_t alarm_th : 2;
	uint32_t alarm_d : 4;
	uint32_t alarm_td : 2;
	uint32_t alarm_dow : 3;
	uint32_t alarm_cm : 1;
	uint32_t alarm_ch : 1;
	uint32_t alarm_cd : 1;
	uint32_t alarm_cdow : 1;
	uint32_t alarm_clr : 1;
	uint32_t resv1 : 5;
} __attribute__((packed, aligned(4))) rtc_alarm_t;

typedef struct _rtc_ctrl
{
	uint32_t ctrl_div : 16;
	uint32_t ctrl_int_en : 1;
	uint32_t ctrl_alarm : 1;
	uint32_t ctrl_en : 1;
	uint32_t resv1 : 13;
} __attribute__((packed, aligned(4))) rtc_ctrl_t;

typedef struct _rtc
{
	rtc_time_t time;
	rtc_date_t date;
	rtc_alarm_t alarm;
	rtc_ctrl_t ctrl;
} __attribute__((packed, aligned(4))) rtc_t;

#define RTC_EVT				(0x1 << 10)

int rtc_deinit(void);
int rtc_init(void);

int rtc_enable(void);
int rtc_disable(void);

int rtc_set_time(uint32_t year, uint32_t mon, uint32_t day, uint32_t hour, uint32_t min, uint32_t sec);
int rtc_set_timev(uint32_t timev[]);
int rtc_get_time(uint32_t *year, uint32_t *mon, uint32_t *day, uint32_t *hour, uint32_t *min, uint32_t *sec);

int rtc_set_alarm(uint32_t wday, uint32_t day, uint32_t hour, uint32_t min, uint32_t wday_mask, uint32_t day_mask, uint32_t hour_mask, uint32_t min_mask);
int rtc_get_alarm(uint32_t *wday, uint32_t *day, uint32_t *hour, uint32_t *min, uint32_t *wday_mask, uint32_t *day_mask, uint32_t *hour_mask, uint32_t *min_mask);

int rtc_alarm_enable(void);
int rtc_alarm_disable(void);
int rtc_alarm_int_enable(void);
int rtc_alarm_int_disable(void);

int rtc_alarm_reset(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_RTC_H__ */

