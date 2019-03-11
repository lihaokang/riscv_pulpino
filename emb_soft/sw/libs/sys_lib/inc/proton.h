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
 * 2019-03-01     lgq          the first version
 */


#ifndef __PROTON_H__
#define __PROTON_H__


#ifdef __cplusplus
extern "C" {
#endif


/* legacy definition, for compatibility: 2019-03-01, begin */

/** SOC PERIPHERALS */
#define GPIO_BASE_ADDR              ( 0x1A101000 )  /* alias: GPIOA */ 
#define TIMER_BASE_ADDR             ( 0x1A103000 )  /* alias: TIMER0 */
#define EVENT_UNIT_BASE_ADDR        ( 0x1A104000 )   
#define SOC_CTRL_BASE_ADDR          ( 0x1A107000 )

#define UART_BASE_ADDR              ( 0x1A120000 )  /* alias: UART0 */
#define I2C_BASE_ADDR               ( 0x1A126000 )  /* alias: I2C0 */
#define SPI_BASE_ADDR               ( 0x1A12C000 )  /* alias: SPI0 */

/** STDOUT */
#define STDOUT_BASE_ADDR            ( 0x1A110000 )
#define FPUTCHAR_BASE_ADDR          ( STDOUT_BASE_ADDR + 0x1000 )
#define FILE_CMD_BASE_ADDR          ( STDOUT_BASE_ADDR + 0x2000 )
#define STREAM_BASE_ADDR            ( STDOUT_BASE_ADDR + 0x3000 )

/* legacy definition, for compatibility: 2019-03-01, end */

/** Code RAM */
#define INSTR_RAM_BASE_ADDR         ( 0x00       )
#define INSTR_RAM_START_ADDR        ( 0x80       )

/** ROM */
#define ROM_BASE_ADDR               ( 0x8000     )

/** Data RAM */
#define DATA_RAM_BASE_ADDR          ( 0x00100000 )

/** Registers and pointers */
#define REGP(x)                     ((volatile unsigned int*)(x))
#define REG(x)                      (*((volatile unsigned int*)(x)))
#define REGP_8(x)                   (((volatile uint8_t*)(x)))
#define R32(x)                      (*((volatile unsigned int*)(x)))

/* pointer to mem of apb proton unit - PointerSocCtrl */
#define __PSC__(a)                  *(unsigned volatile int*) (SOC_CTRL_BASE_ADDR + a)

/** Peripheral Clock gating */
#define CGREG                       __PSC__(0x04)

/* legacy definition: 2019-03-01, begin */

/** Clock gate SPI */
#define CGSPI                       0x00
/** Clock gate UART */
#define CGUART                      0x01
/** Clock gate GPIO */
#define CGGPIO                      0x02
/** Clock gate SPI Master */
#define CGGSPIM                     0x03
/** Clock gate Timer */
#define CGTIM                       0x04
/** Clock gate Event Unit */
#define CGEVENT                     0x05
/** Clock gate I2C */
#define CGGI2C                      0x06
/** Clock gate FLL */
#define CGFLL                       0x07

/* legacy definition, for compatibility: 2019-03-01, end */

/* new definition: 2019-03-01, begin */

#define CG_UART0                    (((uint32_t)0x01) << 0) 
#define CG_UART1                    (((uint32_t)0x01) << 1) 
#define CG_UART2                    (((uint32_t)0x01) << 2) 
#define CG_UART3                    (((uint32_t)0x01) << 3) 
#define CG_UART4                    (((uint32_t)0x01) << 4) 
#define CG_UART5                    (((uint32_t)0x01) << 5) 
#define CG_I2C0                     (((uint32_t)0x01) << 6)
#define CG_I2C1                     (((uint32_t)0x01) << 7)
#define CG_I2C2                     (((uint32_t)0x01) << 8)
#define CG_I2C3                     (((uint32_t)0x01) << 9)
#define CG_I2C4                     (((uint32_t)0x01) << 10)
#define CG_I2C5                     (((uint32_t)0x01) << 11)
#define CG_TIMER                    (((uint32_t)0x01) << 12)
#define CG_CLOCK_CAL                (((uint32_t)0x01) << 13)
#define CG_WDT                      (((uint32_t)0x01) << 14)
#define CG_ADC                      (((uint32_t)0x01) << 15)
#define CG_PWM                      (((uint32_t)0x01) << 16)

/* new definition: 2019-03-01, end */

/** Boot address register */
#define BOOTREG                     __PSC__(0x08)
#define RES_STATUS                  __PSC__(0x14)


#ifdef __cplusplus
}
#endif


#endif  /* #ifndef __PROTON_H__ */
