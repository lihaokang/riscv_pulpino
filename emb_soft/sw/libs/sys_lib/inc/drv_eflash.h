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
 * 2019-02-20     lgq          the first version
 */
 

#ifndef __DRV_EFLASH_H__
#define __DRV_EFLASH_H__


#ifdef __cplusplus
extern "C" {
#endif


#include <proton.h>
#include <stdint.h>
#include <stddef.h>


#define EFLASH_MAIN_BASE        (0x00110000)
#define EFLASH_INFO_BASE        (0x00120000)
#define EFLASH_CTRL_BASE        (0x00120800)

#define EFLASH_PAGE_SIZE        (1024)
#define EFLASH_PAGE_COUNT       (66)
#define EFLASH_MAIN_PAGE_COUNT  (64)
#define EFLASH_INFO_PAGE_COUNT  (2)

typedef struct _eflash_dev
{
	volatile uint32_t ctrl;			
} __attribute__((packed, aligned(4))) eflash_dev_t; 

#define KEY_ERASE_ALL           ((uint32_t)0x340)
#define KEY_ERASE_MAIN          ((uint32_t)0x300)
#define KEY_ERASE_PAGE(page)    ((uint32_t)0x200 | (uint32_t)(page))

#define EFLASH_ACTIVE_MASK      ((uint32_t)0x00000400)
#define EFLASH_STATUS_MASK      ((uint32_t)0xE0000000)


int eflash_erase_chip(void);
int eflash_erase_main_pages(void);
int eflash_erase_info_pages(void);
int eflash_erase_page(uint32_t page);

int eflash_program_page(uint32_t page, uint32_t *buf);

int eflash_program_word(uint32_t page, uint32_t offset, uint32_t *buf);
int eflash_read_word(uint32_t page, uint32_t offset, uint32_t *buf);

int eflash_write_main_page(uint32_t page, const uint32_t *buf);
int eflash_read_main_page(uint32_t page, uint32_t *buf);
int eflash_write_info_page(uint32_t page, const uint32_t *buf);
int eflash_read_info_page(uint32_t page, uint32_t *buf);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_EFLASH_H__ */
