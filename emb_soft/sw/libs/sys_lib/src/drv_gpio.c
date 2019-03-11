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


#include "drv_gpio.h"
#include "utils.h"
#include "proton.h"


iomux_dev_t* const IOMUX = (iomux_dev_t*)IOMUX_BASE_ADDR;
gpio_dev_t* const PORT[2] = 
{
    (gpio_dev_t*)PORTA_BASE_ADDR,
    (gpio_dev_t*)PORTB_BASE_ADDR,
};


int gpio_func_set(uint32_t gpio, uint32_t func)
{
    if (gpio >= GPIO_NR) return -1;
    if ((func > 2) && (func != 6)) return -1;   /* 0, 1, 2, 6 */
    
    IOMUX->iomcr[gpio >> 3] &= ~((uint32_t)0xf << ((gpio & (uint32_t)0x7) << 2));
    IOMUX->iomcr[gpio >> 3] |=  (func << ((gpio & (uint32_t)0x7) << 2));

    return 0;
}

int gpio_mode_set(uint32_t gpio, uint32_t mode)
{
    if (gpio >= GPIO_NR) return -1;

    switch (mode)
    {
        case GPIO_MODE_IN_FLOATING:
        {
            IOMUX->cfg_out[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu1[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu2[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_od[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_in[gpio >> 5]  |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_MODE_IN_PULL_UP_WEAK:    /* 50kohm */
        {
            IOMUX->cfg_out[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu1[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu2[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_od[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_in[gpio >> 5]  |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_MODE_IN_PULL_UP:          /* 20kohm */
        {
            IOMUX->cfg_out[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu1[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_pu2[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_od[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_in[gpio >> 5]  |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_MODE_OUT_OD:
        {
            IOMUX->cfg_in[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_pu1[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_pu2[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_od[gpio >> 5]  |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_out[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_MODE_OUT_PP:
        {
            IOMUX->cfg_in[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_pu1[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            // IOMUX->cfg_pu2[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_od[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            IOMUX->cfg_out[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        default:
        {
            return -1;
        }
    }

    return 0;
}

int gpio_direction_set(uint32_t gpio, uint32_t direction)
{
    if (gpio >= GPIO_NR) return -1;

    if (direction)
    {
        IOMUX->cfg_in[gpio >> 5]  &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
        IOMUX->cfg_out[gpio >> 5] |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }
    else
    {
        IOMUX->cfg_out[gpio >> 5] &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
        IOMUX->cfg_in[gpio >> 5]  |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }

    return 0;
}

int gpio_set_pin_value(uint32_t gpio, uint32_t value) 
{
    if (gpio >= GPIO_NR) return -1;

    if (value)
    {
        PORT[gpio >> 5]->padout |= ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }
    else
    {
        PORT[gpio >> 5]->padout &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }
    
    return 0;
}

uint32_t gpio_get_pin_value(uint32_t gpio) 
{
    if (gpio >= GPIO_NR) return 0xffffffff;

    if ( (PORT[gpio >> 5]->padin) & ((uint32_t)0x1 << (gpio & (uint32_t)0x1f)) )
        return (uint32_t)0x1;

    return (uint32_t)0x0;
}

int gpio_set_port_value(uint32_t port, uint32_t value) 
{
    if (port >= PORT_NR) return -1;

    PORT[port]->padout |= value;
    
    return 0;
}

int gpio_reset_port_value(uint32_t port, uint32_t value) 
{
    if (port >= PORT_NR) return -1;

    PORT[port]->padout &= ~value;
    
    return 0;
}

uint32_t gpio_get_port_value(uint32_t port) 
{
    if (port >= PORT_NR) return 0xffffffff;

    return PORT[port]->padin;
}

int gpio_set_pin_int_enable(uint32_t gpio, uint32_t enable) 
{
    if (gpio >= GPIO_NR) return -1;

    if (enable)
    {
        PORT[gpio >> 5]->inten |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }
    else
    {
        PORT[gpio >> 5]->inten &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
    }
    
    return 0;
}

int gpio_set_pin_int_type(uint32_t gpio, uint32_t type) 
{
    if (gpio >= GPIO_NR) return -1;

    switch (type)
    {
        case GPIO_IRQ_FALL:
        {
            PORT[gpio >> 5]->inttype0 |= ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            PORT[gpio >> 5]->inttype1 |= ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_IRQ_RISE:
        {
            PORT[gpio >> 5]->inttype0 &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            PORT[gpio >> 5]->inttype1 |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_IRQ_HIGH_LEVEL:
        {
            PORT[gpio >> 5]->inttype0 |=  ((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            PORT[gpio >> 5]->inttype1 &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        case GPIO_IRQ_LOW_LEVEL:
        {
            PORT[gpio >> 5]->inttype0 &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            PORT[gpio >> 5]->inttype1 &= ~((uint32_t)0x1 << (gpio & (uint32_t)0x1f));
            break ;
        }

        default:
        {
            return -1;
        }
    }
    
    return 0;
}

uint32_t gpio_get_int_status(uint32_t port) 
{
    if (port >= PORT_NR) return (uint32_t)0xffffffff;

    return PORT[port]->intstatus;
}

int gpio_global_int_enable(void)
{
    EER |= GPIO_EVT;
    IER |= GPIO_EVT;
    
    return 0;
}

int gpio_global_int_disable(void)
{
    EER &= ~GPIO_EVT;
    IER &= ~GPIO_EVT;
    
    return 0;
}

#if (GPIO_INSTALL_INT_EN > 0)

static gpio_int_handler_t gpio_isr_tab[37] = {NULL};

int gpio_install_int_handler(int gpio, gpio_int_handler_t handler)
{
    if (gpio >= GPIO_NR) return -1; 

    gpio_isr_tab[gpio] = handler;   
    
    return 0;
}

void ISR_GPIO(void)
{
    int i;
    volatile uint32_t status;
    gpio_int_handler_t handler;

    ICP = GPIO_EVT;
    ECP = GPIO_EVT;
    
    status = PORT[0]->intstatus;
    if (status)
    {
        for (i=0; i<32; i++)
        {
            if ( ((status >> i) & 0x1) && (gpio_isr_tab[i] != NULL) )
            {
                handler = gpio_isr_tab[i];
                handler();
            }
        }
    }

    status = PORT[1]->intstatus;
    if (status)
    {
        for (i=0; i<5; i++)
        {
            if ( ((status >> i) & 0x1) && (gpio_isr_tab[i + 32] != NULL) )
            {
                handler = gpio_isr_tab[i + 32];
                handler();
            }
        }        
    }
}

#endif
