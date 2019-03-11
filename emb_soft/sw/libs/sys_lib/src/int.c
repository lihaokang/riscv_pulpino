// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include "utils.h"
#include "int.h"
#include "string_lib.h"
#include "uart.h"
#include "event.h"


//defining all interrupt handelrs
//these functions can be redefined by users

// 2: i2c5
__attribute__ ((weak))
void ISR_I2C5(void){ for(;;); }

// 3: i2c4
__attribute__ ((weak))
void ISR_I2C4(void){ for(;;); }

// 4: i2c3
__attribute__ ((weak))
void ISR_I2C3(void){ for(;;); }

// 5: i2c2
__attribute__ ((weak))
void ISR_I2C2(void){ for(;;); }

// 6: i2c1
__attribute__ ((weak))
void ISR_I2C1(void){ for(;;); }

// 7: i2c0
__attribute__ ((weak))
void ISR_I2C0(void){ for(;;); }

// 8: adch
__attribute__ ((weak))
void ISR_ADCH(void){ for(;;); }

// 9: adcf
__attribute__ ((weak))
void ISR_ADCF(void){ for(;;); }

// 10: rtc
__attribute__ ((weak))
void ISR_RTC(void){ for(;;); }

// 11: cal32m
__attribute__ ((weak))
void ISR_CAL32M(void){ for(;;); }

// 12: cal32k
__attribute__ ((weak))
void ISR_CAL32K(void){ for(;;); }

// 13: uart5
__attribute__ ((weak))
void ISR_UART5(void){ for(;;); } 

// 14: uart4
__attribute__ ((weak))
void ISR_UART4(void){ for(;;); } 

// 15: uart3
__attribute__ ((weak))
void ISR_UART3(void){ for(;;); } 

// 16: uart2
__attribute__ ((weak))
void ISR_UART2(void){ for(;;); } 

// 17: uart1
__attribute__ ((weak))
void ISR_UART1(void){ for(;;); } 

// 18: uart0
__attribute__ ((weak))
void ISR_UART0(void){ for(;;); } 

// 19: gpio
__attribute__ ((weak))
void ISR_GPIO(void){ for(;;); } 

// 20: spim1
__attribute__ ((weak))
void ISR_SPIM1_0(void){ for(;;); } 

// 21: spim1
__attribute__ ((weak))
void ISR_SPIM1_1(void){ for(;;); } 

// 22: spim0
__attribute__ ((weak))
void ISR_SPIM0_0(void){ for(;;); } 

// 23: spim0
__attribute__ ((weak))
void ISR_SPIM0_1(void){ for(;;); }  

// 24: timer 0 
__attribute__ ((weak))
void ISR_TIMER0(void){ for(;;); }

// 25: timer 1 
__attribute__ ((weak))
void ISR_TIMER1(void){ for(;;); }

// 26: timer 2 
__attribute__ ((weak))
void ISR_TIMER2(void){ for(;;); }

// 27: timer 3 
__attribute__ ((weak))
void ISR_TIMER3(void){ for(;;); }

// 28~31 
__attribute__ ((weak))
void ISR_UNKNOWN(void){ for(;;); }

// systick 
__attribute__ ((weak))
void freertos_proton_systick_hander(void){ for(;;); }

