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


#include "proton.h"
#include "drv_rtc.h"


rtc_t *const rtc = (rtc_t *)RTC_BASE_ADDR;


static uint32_t rtc_get_wday(uint32_t year, uint32_t mon, uint32_t day)
{
	/* magic method to get weekday */
	uint32_t weekday  = (day += mon < 3 ? year-- : year - 2, 23 * mon / 9 + day + 4 + year / 4 - year / 100 + year / 400) % 7;
	return weekday;
}

int rtc_deinit(void)
{
	volatile int delay = 5 * 1000;

	rtc->ctrl.ctrl_en = (uint32_t)0x0;
	while (--delay);

	return 0;
}

int rtc_init(void)
{
	volatile int delay = 5 * 1000;
	
	rtc->ctrl.ctrl_div = (uint32_t)0x7fff;
	while (--delay);

	return 0;
}

int rtc_enable(void)
{
	volatile int delay = 5 * 1000;
	
	rtc->ctrl.ctrl_en = (uint32_t)0x1;
	while (--delay);

	return 0;
}

int rtc_disable(void)
{
	return rtc_deinit();
}

int rtc_set_time(uint32_t year, uint32_t mon, uint32_t day, uint32_t hour, uint32_t min, uint32_t sec)
{
	rtc_time_t time;
	rtc_date_t date;

	if ((year < 2000) || (year > 2100)) return -1;
	if ((mon == 0) || (mon > 12)) return -1;
	if ((day == 0) || (day > 31)) return -1;
	if (hour > 23) return -1;
	if (min > 59) return -1;
	if (sec > 59) return -1;

	date.date_d = day % 10;
	date.date_td = day / 10;
	date.date_m = mon % 10;
	date.date_tm = mon / 10;
	date.date_y = (year % 100) % 10;
	date.date_ty = (year % 100) / 10;
	date.date_c = (year / 100) % 10;
	date.date_tc = (year / 100) / 10;

	time.time_s = sec % 10;
	time.time_ts = sec / 10;
	time.time_m = min % 10;
	time.time_tm = min / 10;
	time.time_h = hour % 10;
	time.time_th = hour / 10;
	time.time_dow = rtc_get_wday(year, mon, day) + 1;

	rtc->date = date;
	rtc->time = time;

	return 0;
}

int rtc_get_time(uint32_t *year, uint32_t *mon, uint32_t *day, uint32_t *hour, uint32_t *min, uint32_t *sec)
{
	rtc_time_t time;
	rtc_date_t date;

	time = rtc->time;
	date = rtc->date;

	if (day != NULL)
		*day = date.date_td * 10 + date.date_d;
	if (mon != NULL)
		*mon = date.date_tm * 10 + date.date_m;
	if (year != NULL)
		*year = (date.date_ty * 10 + date.date_y) + (date.date_tc * 10 + date.date_c) * 100;

	if (hour != NULL)
		*hour = time.time_th * 10 + time.time_h;
	if (min != NULL)
		*min = time.time_tm * 10 + time.time_m;
	if (sec != NULL)
		*sec = time.time_ts * 10 + time.time_s;

	return 0;
}

int rtc_set_alarm(uint32_t wday, uint32_t day, uint32_t hour, uint32_t min, uint32_t wday_mask, uint32_t day_mask, uint32_t hour_mask, uint32_t min_mask)
{
	rtc_alarm_t alarm;

	if (wday > 6) return -1;
	if (day > 31) return -1;
	if (hour > 23) return -1;
	if (min > 59) return -1;

	alarm.alarm_m = min % 10;
	alarm.alarm_tm = min / 10;
	alarm.alarm_h = hour % 10;
	alarm.alarm_th = hour / 10;
	alarm.alarm_d = day % 10;
	alarm.alarm_td = day / 10;
	alarm.alarm_dow = (wday + 1);
 
	if (min_mask)
		alarm.alarm_cm = (uint32_t)0x1;
	else
		alarm.alarm_cm = (uint32_t)0x0;
	if (hour_mask)
		alarm.alarm_ch = (uint32_t)0x1;
	else
		alarm.alarm_ch = (uint32_t)0x0;
	if (day_mask)
		alarm.alarm_cd = (uint32_t)0x1;
	else
		alarm.alarm_cd = (uint32_t)0x0;
	if (wday_mask)
		alarm.alarm_cdow = (uint32_t)0x1;
	else
		alarm.alarm_cdow = (uint32_t)0x0;

	rtc->alarm = alarm;

	return 0;
}

int rtc_get_alarm(uint32_t *wday, uint32_t *day, uint32_t *hour, uint32_t *min, uint32_t *wday_mask, uint32_t *day_mask, uint32_t *hour_mask, uint32_t *min_mask)
{
	rtc_alarm_t alarm;

	alarm = rtc->alarm;

	if (wday != NULL)
		*wday = alarm.alarm_dow - 1;
	if (day != NULL)
		*day = alarm.alarm_td * 10 + alarm.alarm_d;
	if (hour != NULL)
		*hour = alarm.alarm_th * 10 + alarm.alarm_h;
	if (min != NULL)
		*min = alarm.alarm_tm * 10 + alarm.alarm_m;

	if (wday_mask != NULL)
		*wday_mask = alarm.alarm_cdow;
	if (day_mask != NULL)
		*day_mask = alarm.alarm_cd;
	if (hour_mask != NULL)
		*hour_mask = alarm.alarm_ch;
	if (min_mask != NULL)
		*min_mask = alarm.alarm_cm;

	return 0;
}

int rtc_alarm_enable(void)
{
	volatile int delay = 5 * 1000;
	
	rtc->ctrl.ctrl_alarm = (uint32_t)0x1;
	while (--delay);

	return 0;
}

int rtc_alarm_disable(void)
{
	volatile int delay = 5 * 1000;
	
	rtc->ctrl.ctrl_alarm = (uint32_t)0x1;
	while (--delay);

	return 0;
}

int rtc_alarm_int_enable(void)
{ 
	volatile int delay = 5 * 1000;
	
	IER |= RTC_EVT; 
	EER |= RTC_EVT; 

	rtc->ctrl.ctrl_int_en = (uint32_t)0x1;
	while (--delay);

	return 0;
}

int rtc_alarm_int_disable(void)
{
	volatile int delay = 5 * 1000;
	
	IER &= ~RTC_EVT; 
	EER &= ~RTC_EVT; 

	rtc->ctrl.ctrl_int_en = (uint32_t)0x0;
	while (--delay);

	return 0;
}

int rtc_alarm_reset(void)
{
	volatile int delay = 5 * 1000;

	if (rtc->ctrl.ctrl_alarm)
		rtc->alarm.alarm_clr = (uint32_t)0x1;
	while (--delay);

	return 0;
}

