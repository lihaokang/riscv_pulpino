// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#if 1

#include <string.h>
#include "utils.h"
#include "uart.h"
#include "event.h"
#include "timer.h"
#include "int.h"
#include "bench.h"
#include "gpio.h"



volatile int timer_triggered = 0;

#define LED			(0)
#define LED2		(3)


#define TMR_PRE		(1)
#define TMR_EN		(1)



/*

void ISR_TA_CMP(void) 
{
	ECP = ((1 << 28) | (1 << 29));
	ICP = ((1 << 28) | (1 << 29));
	timer_triggered++;
	if (timer_triggered & 0x1)
	{
		set_gpio_pin_value(LED, 1);
	}
	else
	{
		set_gpio_pin_value(LED, 0);
	}

	SCR = 0x00;

	printf("a cmp\n");
}


int main() 
{
	// Configure ISRs
	int_enable();

	EER = 0xF0000000; // enable all timer events;
	IER = 0xF0000000; // enable all timer interrupts

	uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz

	printf("timer test\n");

	set_pin_function(LED, FUNC_GPIO);
	set_gpio_pin_direction(LED, DIR_OUT);

	// Setup Timer A
	TOCRA = 12500000;
	//TOCRA = 12500;
	//TPRA  = 5; // set prescaler, enable interrupts and start timer.
	TPRA = (((TMR_PRE & 0x07) << 3) | TMR_EN);

	while (1) 
	{
    	static int count = 0;

		printf("Loop Counter: %d\n", timer_triggered);
    	//sleep();

		{
			volatile d = 5000000;
			while (--d);
		}

		if (count++ >= 10)
		{
			break ;
		}		
	}

	while (1) 
	{
    	printf("Loop Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}

*/


void ISR_TB_CMP(void) 
{
	ECP = (1 << 30);
	ICP = (1 << 30);
	timer_triggered++;
	if (timer_triggered & 0x1)
	{
		set_gpio_pin_value(LED, 1);
	}
	else
	{
		set_gpio_pin_value(LED, 0);
	}

	//SCR = 0x00;

	printf("b cmp\n");
}


void ISR_TB_OVF(void) 
{
	ECP = (1 << 31);
	ICP = (1 << 31);

	timer_triggered++;
	if (timer_triggered & 0x1)
	{
		set_gpio_pin_value(LED1, 1);
	}
	else
	{
		set_gpio_pin_value(LED1, 0);
	}

	//SCR = 0x00;

	printf("b ovf\n");
}



int main() 
{
	// Configure ISRs
	int_enable();

	EER = 0x40000000; // enable all timer events;
	IER = 0x40000000; // enable all timer interrupts

	uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz

	printf("timer test\n");

	set_pin_function(LED, FUNC_GPIO);
	set_gpio_pin_direction(LED, DIR_OUT);

	set_pin_function(LED2, FUNC_GPIO);
	set_gpio_pin_direction(LED2, DIR_OUT);

	/* Setup Timer B */
	TOCRB = 12500000;
	TPRB = (((TMR_PRE & 0x07) << 3) | TMR_EN);

	while (1) 
	{
    	static int count = 0;

		printf("cmp Counter: %d\n", timer_triggered);
    	//sleep();

		{
			volatile d = 5000000;
			while (--d);
		}

		if (count++ >= 10)
		{
			break ;
		}		
	}

	EER = 0x80000000; // enable all timer events;
	IER = 0x80000000; // enable all timer interrupts

	TPRB = 0;
	TOCRB = 0;

	while (1) 
	{
    	printf("ovf Counter: %d\n", timer_triggered);
    	sleep();
	}

	int_disable();

	return 0;
}


#endif



#if 0



#include <string.h>
#include "utils.h"
#include "uart.h"
#include "event.h"
#include "timer.h"
#include "int.h"
#include "bench.h"
#include "gpio.h"

volatile int timer_triggered = 0;


void ISR_TA_CMP(void) {
  ICP = (1 << 29);
  timer_triggered++;
}


int main() {
  // Configure ISRs
  int_enable();

  EER = 0xF0000000; // enable all timer events;
  IER = 0xF0000000; // enable all timer interrupts

  /* Setup Timer A */
  TOCRA = 0x80;
  TPRA  = 0x3F; // set prescaler, enable interrupts and start timer.

  while (timer_triggered < 5) {
    printf("Loop Counter: %d\n", timer_triggered);
    sleep();
  }

  set_gpio_pin_value(0, 0);
  int_disable();

  print_summary(0);
  return 0;
}


#endif
