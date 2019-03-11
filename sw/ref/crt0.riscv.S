// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include "pulpino.h"

#define EXCEPTION_STACK_SIZE 96

.global vPortFreeRTOSInterruptWrapper

.macro portDisableIntNest
	csrc mstatus, 8
	.endm

.macro portRestoreInt
	/*csrs mstatus, 8*/
	/*addi   x10, x10, 0*/
	.endm

.global BootMenu_Main_Menu

/* ========================================================= [ entry ] === */
  .section .text

reset_handler:

  /* set 0 in mtvec (base for IVT) */
  csrrw x0, mtvec, x0

  /* set all registers to zero */
  mv  x1, x0
  mv  x2, x1
  mv  x3, x1
  mv  x4, x1
  mv  x5, x1
  mv  x6, x1
  mv  x7, x1
  mv  x8, x1
  mv  x9, x1
  mv x10, x1
  mv x11, x1
  mv x12, x1
  mv x13, x1
  mv x14, x1
  mv x15, x1
  mv x16, x1
  mv x17, x1
  mv x18, x1
  mv x19, x1
  mv x20, x1
  mv x21, x1
  mv x22, x1
  mv x23, x1
  mv x24, x1
  mv x25, x1
  mv x26, x1
  mv x27, x1
  mv x28, x1
  mv x29, x1
  mv x30, x1
  mv x31, x1

  /* stack initilization */
  la   x2, _stack_start

_start:
  .global _start

  /* clear BSS */
  la x26, _bss_start
  la x27, _bss_end

  bge x26, x27, zero_loop_end

zero_loop:
  sw x0, 0(x26)
  addi x26, x26, 4
  ble x26, x27, zero_loop
zero_loop_end:

  /* Run global initialization functions */
  call    __libc_init_array

main_entry:
  addi   x10, x0, 0
  addi   x11, x0, 0x1
  jal  uart_set_cfg;

  /* jump to main program entry point (argc = argv = 0) */
  addi x10, x0, 0
  addi x11, x0, 0
  jal x1, main
  mv s0, a0
  jal  uart_wait_tx_done;
  mv a0, s0
  /* if program exits call exit routine from library */
  jal  x1, exit
  

/* ========================================== [ 2. I2C5 handler ] === */
ISR_I2C5_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C5

/* ========================================== [ 3. I2C4 handler ] === */
ISR_I2C4_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C4

/* ========================================== [ 4. I2C3 handler ] === */
ISR_I2C3_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C3

/* ========================================== [ 5. I2C2 handler ] === */
ISR_I2C2_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C2

/* ========================================== [ 6. I2C1 handler ] === */
ISR_I2C1_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C1

/* ========================================== [ 7. I2C0 handler ] === */
ISR_I2C0_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_I2C0
 
/* ========================================== [ 8. adc_half handler ] === */
ISR_ADCH_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_ADCH 

/* ========================================== [ 9. adc_full handler ] === */
ISR_ADCF_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_ADCF 

/* ========================================== [ 10. rtc handler ] === */
ISR_RTC_ASM:
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_RTC 

/* ========================================== [ 11. cal32m handler ] === */
ISR_CAL32M_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_CAL32M 

/* ========================================== [ 12. cal32k handler ] === */
ISR_CAL32K_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_CAL32K 
 
/* ========================================== [ 13. UART5 handler ] === */
ISR_UART5_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART5

/* ========================================== [ 14. UART4 handler ] === */
ISR_UART4_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART4

/* ========================================== [ 15. UART3 handler ] === */
ISR_UART3_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART3

/* ========================================== [ 16. UART2 handler ] === */
ISR_UART2_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART2

/* ========================================== [ 17. UART1 handler ] === */
ISR_UART1_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART1

/* ========================================== [ 18. UART0 handler ] === */
ISR_UART0_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_UART0

/* ========================================== [ 19. GPIO handler ] === */
ISR_GPIO_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_GPIO

/* ========================================== [ 20. SPI1 Master end of transmission handler ] === */
ISR_SPIM1_0_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_SPIM1_0

/* ========================================== [ 21. SPI1 Master receive/transmit finish handler ] === */
ISR_SPIM1_1_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_SPIM1_1

/* ========================================== [ 22. SPI0 Master end of transmission handler ] === */
ISR_SPIM0_0_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_SPIM0_0

/* ========================================== [ 23. SPI0 Master receive/transmit finish handler ] === */
ISR_SPIM0_1_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_SPIM0_1

/* ========================================== [ 24. Timer 0 handler ] === */
ISR_TIMER0_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  //jal x0, TIMER_CMP_INT
  jal x0, ISR_TIMER0

/* ========================================== [ 25. Timer 1 handler ] === */
ISR_TIMER1_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER1

/* ========================================== [ 26. Timer 2 handler ] === */
ISR_TIMER2_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER2

/* ========================================== [ 27. Timer 3 handler ] === */
ISR_TIMER3_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER3

/* ========================================== [ 28. Timer 4 handler ] === */
ISR_TIMER4_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER4

/* ========================================== [ 29. Timer 5 handler ] === */
ISR_TIMER5_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER5

/* ========================================== [ 30. Timer 6 handler ] === */
ISR_TIMER6_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER6

/* ========================================== [ 31. Timer 7 handler ] === */
ISR_TIMER7_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ISR_TIMER7

/* ========================================== [ 31. Timer 7 handler ] === */
ISR_GEN_ASM:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  csrr    a0,mcause
  andi    a0,a0,0x1f
  la x1, end_except
  jal x0, gen_isr

/* ================================= [ illegal instruction handler] === */
illegal_insn_handler:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, illegal_insn_handler_c

/* ================================= [ ecall instruction handler] === */
ecall_insn_handler:
  portDisableIntNest
  addi x2, x2, -EXCEPTION_STACK_SIZE
  sw x1, 0x5C(x2)
  jal x1, store_regs
  la x1, end_except
  jal x0, ecall_insn_handler_c

// saves all caller-saved registers (except return address)
store_regs:   
  sw  x3, 0x00(x2)  // gp
  sw  x4, 0x04(x2)  // tp
  sw  x5, 0x08(x2)  // t0
  sw  x6, 0x0c(x2)  // t1
  sw  x7, 0x10(x2)  // t2
  sw x10, 0x14(x2)  // a0
  sw x11, 0x18(x2)  // a1
  sw x12, 0x1c(x2)  // a2
  sw x13, 0x20(x2)  // a3
  sw x14, 0x24(x2)  // a4
  sw x15, 0x28(x2)  // a5
  sw x16, 0x2c(x2)  // a6
  sw x17, 0x30(x2)  // a7
  sw x28, 0x34(x2)  // t3
  sw x29, 0x38(x2)  // t4
  sw x30, 0x3c(x2)  // t5
  sw x31, 0x40(x2)  // t6
  csrr x28, 0x7B0
  csrr x29, 0x7B1
  csrr x30, 0x7B2
  sw x28, 0x44(x2)  // lpstart[0]
  sw x29, 0x48(x2)  // lpend[0]
  sw x30, 0x4C(x2)  // lpcount[0]
  csrr x28, 0x7B4
  csrr x29, 0x7B5
  csrr x30, 0x7B6
  sw x28, 0x50(x2)  // lpstart[1]
  sw x29, 0x54(x2)  // lpend[1]
  sw x30, 0x58(x2)  // lpcount[1]
  jalr x0, x1

// load back registers from stack
end_except:
  lw x28, 0x50(x2)  // lpstart[1]
  lw x29, 0x54(x2)  // lpend[1]
  lw x30, 0x58(x2)  // lpcount[1]
  csrrw x0, 0x7B4, x28
  csrrw x0, 0x7B5, x29
  csrrw x0, 0x7B6, x30
  lw x28, 0x44(x2)  // lpstart[0]
  lw x29, 0x48(x2)  // lpend[0]
  lw x30, 0x4C(x2)  // lpcount[0]
  csrrw x0, 0x7B0, x28
  csrrw x0, 0x7B1, x29
  csrrw x0, 0x7B2, x30
  lw  x3, 0x00(x2)
  lw  x4, 0x04(x2)
  lw  x5, 0x08(x2)
  lw  x6, 0x0c(x2)
  lw  x7, 0x10(x2)
  lw x10, 0x14(x2)
  lw x11, 0x18(x2)
  lw x12, 0x1c(x2)
  lw x13, 0x20(x2)
  lw x14, 0x24(x2)
  lw x15, 0x28(x2)
  lw x16, 0x2c(x2)
  lw x17, 0x30(x2)
  lw x28, 0x34(x2)
  lw x29, 0x38(x2)
  lw x30, 0x3c(x2)
  lw x31, 0x40(x2)
  lw  x1, 0x5C(x2)
  addi x2, x2, EXCEPTION_STACK_SIZE
  portRestoreInt
  mret

  .global _init
  .global _fini
_init:
_fini:
  # These don't have to do anything since we use init_array/fini_array.
  ret

/* =================================================== [ exceptions ] === */
/* This section has to be down here, since we have to disable rvc for it  */

  .section .vectors, "ax"
  .option norvc;

  // external interrupts are handled by the same callback
  // until compiler supports IRQ routines
  .org 0x00
  .rept 2
  nop                       // unused
  .endr

  jal x0, ISR_I2C5_ASM 	        // 2: i2c5
  jal x0, ISR_I2C4_ASM 	        // 3: i2c4
  jal x0, ISR_I2C3_ASM 	        // 4: i2c3
  jal x0, ISR_I2C2_ASM 	        // 5: i2c2
  jal x0, ISR_I2C1_ASM 	        // 6: i2c1
  jal x0, ISR_I2C0_ASM 	        // 7: i2c0
  jal x0, ISR_ADCH_ASM 	        // 8: adc_half
  jal x0, ISR_ADCF_ASM 	        // 9: adc_full
  jal x0, ISR_RTC_ASM 	        // 10: rtc
  jal x0, ISR_CAL32M_ASM 	      // 11: cal32m
  jal x0, ISR_CAL32K_ASM 	      // 12: cal32k
  jal x0, ISR_UART5_ASM         // 13: uart5
  jal x0, ISR_UART4_ASM         // 14: uart4
  jal x0, ISR_UART3_ASM         // 15: uart3
  jal x0, ISR_UART2_ASM         // 16: uart2
  jal x0, ISR_UART1_ASM         // 17: uart1
  jal x0, ISR_UART0_ASM         // 18: uart0
  jal x0, ISR_GPIO_ASM          // 19: gpio
  jal x0, ISR_SPIM1_0_ASM       // 20: spi1	end of transmission
  jal x0, ISR_SPIM1_1_ASM       // 21: spi1 R/T finished
  jal x0, ISR_SPIM0_0_ASM       // 22: spi0	end of transmission
  jal x0, ISR_SPIM0_1_ASM       // 23: spi0 R/T finished
  jal x0, TIMER_CMP_INT        // 24: timer 0
  jal x0, ISR_TIMER1_ASM        // 25: timer 1
  jal x0, ISR_TIMER2_ASM        // 26: timer 2
  jal x0, ISR_TIMER3_ASM        // 27: timer 3
  jal x0, ISR_TIMER4_ASM        // 28: timer 4
  jal x0, ISR_TIMER5_ASM        // 29: timer 5
  jal x0, ISR_TIMER6_ASM        // 30: timer 6
  jal x0, ISR_TIMER7_ASM        // 31: timer 7


  // reset vector
  .org 0x80
  jal x0, reset_handler

  // illegal instruction exception
  .org 0x84
  jal x0, illegal_insn_handler

  // ecall handler
  .org 0x88
  jal x0, ecall_insn_handler
