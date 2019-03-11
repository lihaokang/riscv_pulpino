// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
/**
 * @file
 * @brief Interrupt library for PULPino.
 *
 * Contains various interrupt manipulating functions.
 *
 * @author Florian Zaruba
 *
 * @version 1.0
 *
 * @date 11/9/2015
 *
 */

#ifndef _INT_H_
#define _INT_H_

#ifndef __riscv__
#include "spr-defs.h"
#endif

#include "event.h"

/* Number of interrupt handlers - really depends on PIC width in OR1200*/
#define MAX_INT_HANDLERS  32


/**
 * \brief Disables interrupts globally.
 * \param void
 * \return void
 *
 * By writing 1 to the ie (interruptenable) bit
 * interrupts are globally disable.
 */
static inline void int_disable(void) {
#ifdef __riscv__
  // read-modify-write
  int mstatus;
  asm volatile ("csrr %0, mstatus": "=r" (mstatus));
  mstatus &= 0xFFFFFFF7;
  asm volatile ("csrw mstatus, %0" : /* no output */ : "r" (mstatus));
  asm("csrw 0x300, %0" : : "r" (0x0) );
#else
  mtspr(SPR_SR, mfspr(SPR_SR) & (~SPR_SR_IEE));
#endif
}



/**
 * \brief Enables interrupts globally.
 * \param void
 * \return void
 *
 * By writing 1 to the ie (interruptenable) bit
 * interrupts are globally enabled.
 */
static inline void int_enable(void) {
#ifdef __riscv__
  // read-modify-write
  int mstatus;
  asm volatile ("csrr %0, mstatus": "=r" (mstatus));
  mstatus |= 0x08;
  asm volatile ("csrw mstatus, %0" : /* no output */ : "r" (mstatus));
#else
  mtspr(SPR_SR, mfspr(SPR_SR) | (SPR_SR_IEE));
#endif
}

static inline int disable_cpu_int()
{
	int state = IER;
	IER = 0;
	ICP = 0xFFFFFFFF;
	return state;
}

static inline void enable_cpu_int( int state)
{
	IER |= state;
}


//declearing all interrupt handelrs
//these functions can be redefined by users
void ISR_ADCH (void);
void ISR_ADCF (void);


void ISR_I2C (void);	// 23: i2c
void ISR_UART (void);	// 23: i2c
void ISR_GPIO (void); 	// 25: gpio
void ISR_SPIM0 (void);  // 26: spim end of transmission
void ISR_SPIM1 (void);  // 27: spim R/T finished
void ISR_TA_OVF (void); // 28: timer A overflow
void ISR_TA_CMP (void); // 29: timer A compare
void ISR_TB_OVR (void); // 30: timer B overflow
void ISR_TB_CMP (void); // 31: timer B compare

// 2: i2c5
#define ISR_NUM_I2C5 2
void ISR_I2C5 (void);

// 3: i2c4
#define ISR_NUM_I2C4 3
void ISR_I2C4 (void);

// 4: i2c3
#define ISR_NUM_I2C3 4
void ISR_I2C3 (void);

// 5: i2c2
#define ISR_NUM_I2C2 5
void ISR_I2C2 (void);

// 6: i2c1
#define ISR_NUM_I2C1 6
void ISR_I2C1 (void);

// 7: i2c0
#define ISR_NUM_I2C0 7
void ISR_I2C0 (void);

// 8: adch
#define ISR_NUM_ADCH 8
void ISR_ADCH (void);

// 9: adcf
#define ISR_NUM_ADCF 9
void ISR_ADCF (void);

// 10: rtc
#define ISR_NUM_RTC 10
void ISR_RTC (void);

// 11: cal32m
#define ISR_NUM_CAL32M 11
void ISR_CAL32M (void);

// 12: cal32k
#define ISR_NUM_CAL32K 12
void ISR_CAL32K (void);

// 13: uart5
#define ISR_NUM_UART5 13
void ISR_UART5 (void);

// 14: uart4
#define ISR_NUM_UART4 14
void ISR_UART4 (void);

// 15: uart3
#define ISR_NUM_UART3 15
void ISR_UART3 (void);

// 16: uart2
#define ISR_NUM_UART2 16
void ISR_UART2 (void);

// 17: uart1
#define ISR_NUM_UART1 17
void ISR_UART1 (void);

// 18: uart0
#define ISR_NUM_UART0 18
void ISR_UART0 (void);

// 19: gpio
#define ISR_NUM_GPIO 19
void ISR_GPIO (void);

// 20: spim1
#define ISR_NUM_SPIM1_0 20
void ISR_SPIM1_0 (void);

// 21: spim1
#define ISR_NUM_SPIM1_1 21
void ISR_SPIM1_1 (void);
// 22: spim0
#define ISR_NUM_SPIM0_0 22
void ISR_SPIM0_0 (void);

// 23: spim0
#define ISR_NUM_SPIM0_1 23
void ISR_SPIM0_1 (void);

// 24: timer 0 
#define ISR_NUM_TMR0 24
void ISR_TIMER0(void);

// 25: timer 1 
#define ISR_NUM_TMR1 25
void ISR_TIMER1(void);

// 26: timer 2 
#define ISR_NUM_TMR2 26
void ISR_TIMER2(void);

// 27: timer 3 
#define ISR_NUM_TMR3 27
void ISR_TIMER3(void);

// 28: timer 4 
#define ISR_NUM_TMR4 28
void ISR_TIMER4(void);

// 29: timer 5 
#define ISR_NUM_TMR5 29
void ISR_TIMER5(void);

// 30: timer 6 
#define ISR_NUM_TMR6 30
void ISR_TIMER6(void);

// 31: timer 7 
#define ISR_NUM_TMR7 31
void ISR_TIMER7(void);

void gen_isr(int ins_num);

void TIMER_CMP_INT(void);

void vPortFreeRTOSInterruptWrapper(void);
#endif // _INT_H_
