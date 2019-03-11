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


#include "drv_eflash.h"
#include "utils.h"
#include "proton.h"


eflash_dev_t* const EFLASH = (eflash_dev_t*)EFLASH_CTRL_BASE;


int eflash_erase_chip(void)
{
    volatile uint32_t delay;
    
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }
    
    EFLASH->ctrl = KEY_ERASE_ALL;

    while (EFLASH->ctrl & EFLASH_STATUS_MASK)
    {
        delay = 0xff;
        while (--delay);
    }

    return 0;
}

int eflash_erase_main_pages(void)
{
    volatile uint32_t delay;
    
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }

    EFLASH->ctrl = KEY_ERASE_MAIN;

    while (EFLASH->ctrl & EFLASH_STATUS_MASK)
    {
        delay = 0xff;
        while (--delay);
    }

    return 0;
}

int eflash_erase_page(uint32_t page)
{
    volatile uint32_t delay;

    if (page >= EFLASH_PAGE_COUNT) return -1;
 
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }
    
    EFLASH->ctrl = KEY_ERASE_PAGE(page);

    while (EFLASH->ctrl & EFLASH_STATUS_MASK)
    {
        delay = 0xff;
        while (--delay);
    }

    return 0;
}

int eflash_erase_info_pages(void)
{
    eflash_erase_page(64);
    eflash_erase_page(65);

    return 0;
}

int eflash_program_page(uint32_t page, uint32_t *buf)
{
    uint32_t *ptr;
    volatile uint32_t delay;

    if (page >= EFLASH_PAGE_COUNT) return -1;
 
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }

    ptr = (uint32_t *)(EFLASH_MAIN_BASE + (page << 10));
    for (int i=0; i<256; i++)
    {
       *ptr++ = *buf++;
    }

    return 0;
}

int eflash_program_word(uint32_t page, uint32_t offset, uint32_t *buf)
{
    uint32_t *ptr;
    volatile uint32_t delay;

    if (page >= EFLASH_PAGE_COUNT) return -1;
 
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }

    ptr = (uint32_t *)(EFLASH_MAIN_BASE + (page << 10) + offset);
    *ptr = *buf;
 
    return 0;
}

int eflash_read_word(uint32_t page, uint32_t offset, uint32_t *buf)
{
    uint32_t *ptr;
    volatile uint32_t delay;

    if (page >= EFLASH_PAGE_COUNT) return -1;
 
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }

    ptr = (uint32_t *)(EFLASH_MAIN_BASE + (page << 10) + offset);

    *buf++ = *ptr++;

    return 0;
}

int eflash_write_page(uint32_t page, const uint32_t *buf)
{
    int r;
    
    r = eflash_erase_page(page);
    if (r) return r;
    r = eflash_program_page(page, buf);
    if (r) return r;

    return 0;
}

int eflash_read_page(uint32_t page, uint32_t *buf)
{
    uint32_t *ptr;
    volatile uint32_t delay;

    if (page >= EFLASH_PAGE_COUNT) return -1;
 
    while ((EFLASH->ctrl & EFLASH_ACTIVE_MASK) == 0x0)
    {
        delay = 0xf;
        while (--delay);
    }

    ptr = (uint32_t *)(EFLASH_MAIN_BASE + (page << 10));
    for (int i=0; i<256; i++)
    {
       *buf++ = *ptr++;
    }

    return 0;
}

int eflash_write_main_page(uint32_t page, const uint32_t *buf)
{
    if (page >= EFLASH_MAIN_PAGE_COUNT) return -1;
    
    return eflash_write_page(page, buf);
}

int eflash_write_info_page(uint32_t page, const uint32_t *buf)
{
    if (page >= EFLASH_INFO_PAGE_COUNT) return -1;

    return eflash_write_page((page + 64), buf);
}

int eflash_read_main_page(uint32_t page, uint32_t *buf)
{
    if (page >= EFLASH_MAIN_PAGE_COUNT) return -1;
    
    return eflash_read_page(page, buf);
}

int eflash_read_info_page(uint32_t page, uint32_t *buf)
{
    if (page >= EFLASH_INFO_PAGE_COUNT) return -1;

    return eflash_read_page((page + 64), buf);
}




