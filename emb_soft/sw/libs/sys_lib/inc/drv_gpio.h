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
 

#ifndef __DRV_GPIO_H__
#define __DRV_GPIO_H__


#include "proton.h"
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define GPIO_INSTALL_INT_EN     (0)         /* 0: disable, 1: enable */

#define	IOMUX_BASE_ADDR			(0x1B005000)
#define	PORTA_BASE_ADDR			(0x1A101004)
#define	PORTB_BASE_ADDR			(0x1A101044)

#define GPIO_EVT                (((uint32_t)0x1) << 19)

typedef struct _iomux_dev
{
	volatile uint32_t iomcr[5];			
    volatile uint32_t cfg_out[2];
    volatile uint32_t cfg_in[2];
    volatile uint32_t cfg_pu1[2];
    volatile uint32_t cfg_pu2[2];
    volatile uint32_t cfg_od[2];			
} __attribute__((packed, aligned(4))) iomux_dev_t;

typedef struct _gpio_dev
{
	volatile uint32_t padin;			
    volatile uint32_t padout;
    volatile uint32_t inten;
    volatile uint32_t inttype0;
    volatile uint32_t inttype1;
    volatile uint32_t intstatus;			
} __attribute__((packed, aligned(4))) gpio_dev_t;

#define FUNC0_I2C0_SCL              ((uint32_t)0x0)     /* GPIO0 */
#define FUNC0_I2C0_SDA              ((uint32_t)0x0)     /* GPIO1 */
#define FUNC0_UART0_TX              ((uint32_t)0x0)     /* GPIO2 */
#define FUNC0_UART0_RX              ((uint32_t)0x0)     /* GPIO3 */
#define FUNC0_SPIS0_CLK             ((uint32_t)0x0)     /* GPIO4 */
#define FUNC0_SPIS0_CS              ((uint32_t)0x0)     /* GPIO5 */
#define FUNC0_SPIS0_SDIO0           ((uint32_t)0x0)     /* GPIO6 */
#define FUNC0_SPIS0_SDIO1           ((uint32_t)0x0)     /* GPIO7 */
#define FUNC0_SPIS0_MODE0           ((uint32_t)0x0)     /* GPIO8 */
#define FUNC0_SPIS0_MODE1           ((uint32_t)0x0)     /* GPIO9 */
#define FUNC0_SPIS0_SDIO2           ((uint32_t)0x0)     /* GPIO10 */
#define FUNC0_SPIS0_SDIO3           ((uint32_t)0x0)     /* GPIO11 */
#define FUNC0_I2C1_SCL              ((uint32_t)0x0)     /* GPIO12 */
#define FUNC0_I2C1_SDA              ((uint32_t)0x0)     /* GPIO13 */
#define FUNC0_UART1_TX              ((uint32_t)0x0)     /* GPIO14 */
#define FUNC0_UART1_RX              ((uint32_t)0x0)     /* GPIO15 */
#define FUNC0_SPIM0_CLK             ((uint32_t)0x0)     /* GPIO16 */
#define FUNC0_SPIM0_CS0             ((uint32_t)0x0)     /* GPIO17 */
#define FUNC0_SPIM0_SDIO0           ((uint32_t)0x0)     /* GPIO18 */
#define FUNC0_SPIM0_SDIO1           ((uint32_t)0x0)     /* GPIO19 */
#define FUNC0_I2C2_SCL              ((uint32_t)0x0)     /* GPIO20 */
#define FUNC0_I2C2_SDA              ((uint32_t)0x0)     /* GPIO21 */
#define FUNC0_UART2_TX              ((uint32_t)0x0)     /* GPIO22 */
#define FUNC0_UART2_RX              ((uint32_t)0x0)     /* GPIO23 */
#define FUNC0_SPIM0_CS1             ((uint32_t)0x0)     /* GPIO24 */
#define FUNC0_SPIM0_CS2             ((uint32_t)0x0)     /* GPIO25 */
#define FUNC0_SPIM0_CS3             ((uint32_t)0x0)     /* GPIO26 */
#define FUNC0_SPIM0_MODE0           ((uint32_t)0x0)     /* GPIO27 */
#define FUNC0_SPIM0_MODE1           ((uint32_t)0x0)     /* GPIO28 */
#define FUNC0_SPIM0_SDIO2           ((uint32_t)0x0)     /* GPIO29 */
#define FUNC0_SPIM0_SDIO3           ((uint32_t)0x0)     /* GPIO30 */
#define FUNC0_UART3_TX              ((uint32_t)0x0)     /* GPIO31 */
#define FUNC0_UART3_RX              ((uint32_t)0x0)     /* GPIO32 */
#define FUNC0_UART4_TX              ((uint32_t)0x0)     /* GPIO33 */
#define FUNC0_UART4_RX              ((uint32_t)0x0)     /* GPIO34 */
#define FUNC0_XTAL_IN               ((uint32_t)0x0)     /* GPIO35 */
#define FUNC0_XTAL_OUT              ((uint32_t)0x0)     /* GPIO36 */

#define FUNC1_SPIM1_CLK             ((uint32_t)0x1)     /* GPIO0 */
#define FUNC1_SPIM1_CS0             ((uint32_t)0x1)     /* GPIO1 */
#define FUNC1_SPIM1_SDIO0           ((uint32_t)0x1)     /* GPIO2 */
#define FUNC1_SPIM1_SDIO1           ((uint32_t)0x1)     /* GPIO3 */
#define FUNC1_I2C3_SCL              ((uint32_t)0x1)     /* GPIO4 */
#define FUNC1_I2C3_SDA              ((uint32_t)0x1)     /* GPIO5 */
#define FUNC1_I2C4_SCL              ((uint32_t)0x1)     /* GPIO6 */
#define FUNC1_I2C4_SDA              ((uint32_t)0x1)     /* GPIO7 */
#define FUNC1_UART5_TX              ((uint32_t)0x1)     /* GPIO8 */
#define FUNC1_UART5_RX              ((uint32_t)0x1)     /* GPIO9 */
#define FUNC1_I2C5_SCL              ((uint32_t)0x1)     /* GPIO10 */
#define FUNC1_I2C5_SDA              ((uint32_t)0x1)     /* GPIO11 */
#define FUNC1_SPIM1_CS1             ((uint32_t)0x1)     /* GPIO12 */
#define FUNC1_SPIM1_CS2             ((uint32_t)0x1)     /* GPIO13 */
#define FUNC1_SPIM1_CS3             ((uint32_t)0x1)     /* GPIO14 */
#define FUNC1_SPIM1_MODE0           ((uint32_t)0x1)     /* GPIO15 */
                                                        /* GPIO16 */
                                                        /* GPIO17 */
                                                        /* GPIO18 */
                                                        /* GPIO19 */
#define FUNC1_SPIM1_MODE1           ((uint32_t)0x1)     /* GPIO20 */
#define FUNC1_SPIM1_SDIO2           ((uint32_t)0x1)     /* GPIO21 */
#define FUNC1_ADC_IN7               ((uint32_t)0x1)     /* GPIO22 */
#define FUNC1_ADC_IN6               ((uint32_t)0x1)     /* GPIO23 */
#define FUNC1_ADC_IN5               ((uint32_t)0x1)     /* GPIO24 */
#define FUNC1_ADC_IN4               ((uint32_t)0x1)     /* GPIO25 */
#define FUNC1_ADC_IN3               ((uint32_t)0x1)     /* GPIO26 */
#define FUNC1_ADC_IN2               ((uint32_t)0x1)     /* GPIO27 */
#define FUNC1_ADC_IN1               ((uint32_t)0x1)     /* GPIO28 */
#define FUNC1_ADC_IN0               ((uint32_t)0x1)     /* GPIO29 */
#define FUNC1_TOP_TP                ((uint32_t)0x1)     /* GPIO30 */
#define FUNC1_VRP_EXT               ((uint32_t)0x1)     /* GPIO31 */
#define FUNC1_VRM_EXT               ((uint32_t)0x1)     /* GPIO32 */
#define FUNC1_SPIM1_SDIO3           ((uint32_t)0x1)     /* GPIO33 */
                                                        /* GPIO34 */
                                                        /* GPIO35 */
                                                        /* GPIO36 */                                                        
                                                        

#define FUNC2_GPIO                  ((uint32_t)0x2)     /* GPIO0 - GPIO36 */

                                                        /* GPIO0 - GPIO3 */
#define FUNC6_PWM0                  ((uint32_t)0x6)     /* GPIO4 */
#define FUNC6_PWM1                  ((uint32_t)0x6)     /* GPIO5 */
#define FUNC6_PWM2                  ((uint32_t)0x6)     /* GPIO6 */
#define FUNC6_PWM3                  ((uint32_t)0x6)     /* GPIO7 */
#define FUNC6_PWM4                  ((uint32_t)0x6)     /* GPIO8 */
#define FUNC6_PWM5                  ((uint32_t)0x6)     /* GPIO9 */
#define FUNC6_PWM6                  ((uint32_t)0x6)     /* GPIO10 */
#define FUNC6_PWM7                  ((uint32_t)0x6)     /* GPIO11 */
                                                        /* GPIO12 - GPIO36 */

#define GPIO_MODE_IN_FLOATING       ((uint32_t)0x0)
#define GPIO_MODE_IN_PULL_UP_WEAK   ((uint32_t)0x1)     /* 50kohm */
#define GPIO_MODE_IN_PULL_UP        ((uint32_t)0x2)     /* 20kohm */
#define GPIO_MODE_OUT_OD            ((uint32_t)0x3)
#define GPIO_MODE_OUT_PP            ((uint32_t)0x4)

#define GPIO_IRQ_FALL               ((uint32_t)0x3)
#define GPIO_IRQ_RISE               ((uint32_t)0x2)
#define GPIO_IRQ_HIGH_LEVEL         ((uint32_t)0x1)
#define GPIO_IRQ_LOW_LEVEL          ((uint32_t)0x0)

#define PORT_NR                     (2)
#define GPIO_NR                     (37)
#define GPIO_FUNC_MAX               (6)

#if (GPIO_INSTALL_INT_EN > 0)
typedef void (*gpio_int_handler_t)(void);
#endif


/* pin */
int gpio_func_set(uint32_t gpio, uint32_t func);
int gpio_mode_set(uint32_t gpio, uint32_t mode);
int gpio_direction_set(uint32_t gpio, uint32_t direction);

int gpio_set_pin_value(uint32_t gpio, uint32_t value);
uint32_t gpio_get_pin_value(uint32_t gpio);

int gpio_set_pin_int_enable(uint32_t gpio, uint32_t enable);
int gpio_set_pin_int_type(uint32_t gpio, uint32_t type);
#if (GPIO_INSTALL_INT_EN > 0)
int gpio_install_int_handler(int gpio, gpio_int_handler_t handler);
#endif

/* port */
int gpio_set_port_value(uint32_t port, uint32_t value);
int gpio_reset_port_value(uint32_t port, uint32_t value);
uint32_t gpio_get_port_value(uint32_t port);
uint32_t gpio_get_int_status(uint32_t port);

/* GPIO */
int gpio_global_int_enable(void);
int gpio_global_int_disable(void);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_GPIO_H__ */
