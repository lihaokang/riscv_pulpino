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
#include "string_lib.h"
#include "bar.h"
#include "gpio.h"
#include "int.h"
#include "drv_uart.h"


#if 1


#define LED1 	(0)
#define LED2 	(3)
#define LED3 	(6)
#define LED4 	(9)

#define BTN1	(28)
#define BTN2	(29)
#define BTN3	(30)
#define BTN4	(31)


volatile int btn1 = 0;
volatile int btn2 = 0;
volatile int btn3 = 0;
volatile int btn4 = 0;


void ISR_GPIO (void)
{
	unsigned int status;

	printf("btn pressed\n");

	status = get_gpio_irq_status();
	if (status & (0x1 << BTN1))
	{
		btn1++;
	}

	if (status & (0x1 << BTN2))
	{
		btn2++;
	}

	if (status & (0x1 << BTN3))
	{
		btn3++;
	}

	if (status & (0x1 << BTN4))
	{
		btn4++;
	}


	ICP = (0x1 << 25);
	ECP = (0x1 << 25);
}


int main(void)
{
	// Configure ISRs
	int_enable();

	//EER = 0xF0000000; // enable all timer events;
	//IER = 0xF0000000; // enable all timer interrupts	
	EER = (0x1 << 25); 
	IER = (0x1 << 25); 

	//uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz

	//printf("gpio test\n");
	
	uartx_set_cfg(UART0, 0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz
	uartx_send(UART0, "gpio test2\n", 11);

	set_pin_function(LED1, FUNC_GPIO);
	set_pin_function(LED2, FUNC_GPIO);
	set_pin_function(LED3, FUNC_GPIO);
	set_pin_function(LED4, FUNC_GPIO);

	set_pin_function(BTN1, FUNC_GPIO);
	set_pin_function(BTN2, FUNC_GPIO);
	set_pin_function(BTN3, FUNC_GPIO);
	set_pin_function(BTN4, FUNC_GPIO);

	set_gpio_pin_direction(LED1, DIR_OUT);
	set_gpio_pin_direction(LED2, DIR_OUT);
	set_gpio_pin_direction(LED3, DIR_OUT);
	set_gpio_pin_direction(LED4, DIR_OUT);

	set_gpio_pin_direction(BTN1, DIR_IN);
	set_gpio_pin_direction(BTN2, DIR_IN);
	set_gpio_pin_direction(BTN3, DIR_IN);
	set_gpio_pin_direction(BTN4, DIR_IN);

	set_gpio_pin_irq_type(BTN1, GPIO_IRQ_RISE);
	set_gpio_pin_irq_type(BTN2, GPIO_IRQ_RISE);
	set_gpio_pin_irq_type(BTN3, GPIO_IRQ_RISE);
	set_gpio_pin_irq_type(BTN4, GPIO_IRQ_RISE);

	set_gpio_pin_irq_en(BTN1, 1);
	set_gpio_pin_irq_en(BTN2, 1);
	set_gpio_pin_irq_en(BTN3, 1);
	set_gpio_pin_irq_en(BTN4, 1);

	while (1)
	{
		if (btn1 & 0x1)
		{
			set_gpio_pin_value(LED1, 1);
		}
		else
		{
			set_gpio_pin_value(LED1, 0);
		}
		if (btn2 & 0x1)
		{
			set_gpio_pin_value(LED2, 1);
		}
		else
		{
			set_gpio_pin_value(LED2, 0);
		}
		if (btn3 & 0x1)
		{
			set_gpio_pin_value(LED3, 1);
		}
		else
		{
			set_gpio_pin_value(LED3, 0);
		}
		if (btn4 & 0x1)
		{
			set_gpio_pin_value(LED4, 1);
		}
		else
		{
			set_gpio_pin_value(LED4, 0);
		}

		if ( (btn1 + btn2 + btn3 + btn4) >= 20 )
		{
			btn1 = 0;
			btn2 = 0;
			btn3 = 0;
			btn4 = 0;

			break ;
		}
	}

	set_gpio_pin_irq_type(BTN1, GPIO_IRQ_LEV1);
	set_gpio_pin_irq_type(BTN2, GPIO_IRQ_LEV1);
	set_gpio_pin_irq_type(BTN3, GPIO_IRQ_LEV1);
	set_gpio_pin_irq_type(BTN4, GPIO_IRQ_LEV1);

	while (1)
	{
		if (btn1 & 0x1)
		{
			set_gpio_pin_value(LED1, 1);
		}
		else
		{
			set_gpio_pin_value(LED1, 0);
		}
		if (btn2 & 0x1)
		{
			set_gpio_pin_value(LED2, 1);
		}
		else
		{
			set_gpio_pin_value(LED2, 0);
		}
		if (btn3 & 0x1)
		{
			set_gpio_pin_value(LED3, 1);
		}
		else
		{
			set_gpio_pin_value(LED3, 0);
		}
		if (btn4 & 0x1)
		{
			set_gpio_pin_value(LED4, 1);
		}
		else
		{
			set_gpio_pin_value(LED4, 0);
		}

		if ( (btn1 + btn2 + btn3 + btn4) >= 20 )
		{
			//btn1 = 0;
			//btn2 = 0;
			//btn3 = 0;
			//btn4 = 0;

			//break ;
		}
	}

	return 0;
}


#else
int main()
{
  set_pin_function(PIN_MSPI_CSN1, FUNC_EXT2);
  if (get_pin_function(PIN_MSPI_CSN1) == FUNC_EXT2) {
     printf("Successfully enabled func 2 on PIN_MSPI_CSN1\n");
  } else {
     printf("ERROR on enabling func 2 on PIN_MSPI_CSN1\n");
  }

  set_pin_function(PIN_MSPI_CSN2, FUNC_GPIO);
  set_gpio_pin_direction(PIN_MSPI_CSN2, DIR_OUT);
  if (get_gpio_pin_direction(PIN_MSPI_CSN2) == DIR_OUT) {
     printf("Successfully set out dir on PIN_MSPI_CSN2\n");
  } else {
     printf("ERROR on setting out dir on PIN_MSPI_CSN2\n");
  }

  printf("Done!!!\n");

  return 0;
}

#endif
