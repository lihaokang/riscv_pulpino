// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#include <stdio.h>
#include "proton.h"
#include "uart.h"
#include "gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"


void check_uart(testresult_t *result, void (*start)(), void (*stop)());
void check_uart_basic(testresult_t *result, void (*start)(), void (*stop)());

testcase_t testcases[] = {
  // { .name = "uart_basic",            .test = check_uart_basic           },
  { .name = "uart",                  .test = check_uart                 },
  {0, 0}
};

int main()
{
	//return run_suite(testcases);
	void uart_test(void);
	void uart_int_test(void);
	uart_test();
	uart_int_test();

	return 0;
}
void check_uart_basic(testresult_t *result, void (*start)(), void (*stop)()) {
    char c;

    // *(volatile unsigned int*)(UART_REG_FCR) = 0x00; // disable 16byte FIFO and clear FIFOs
    uart_send("a", 1);

    uart_wait_tx_done();

    c = uart_getchar();
    if (c != 'a')
      result->errors++;

    // test clearing fifos
    return;
}

void check_uart(testresult_t *result, void (*start)(), void (*stop)()) {
  int i;
  int j;
  char c;
  // *(volatile unsigned int*)(UART_REG_FCR) = 0x00; // disable 16byte FIFO and clear FIFOs


  for (j = 0; j < 10; j++) {
    uart_wait_tx_done();
    uart_send("01234567", 8);

   for (i = 0; i < 8; i++) {
      c = uart_getchar();

      if (c != '0' + i) {
        result->errors++;
        printf("Error: act: %c; exp: %c\n", c, '0' + i);
        return;
      }
    }
  }
}


void uart_test(void)
{
	int i;
	int j;
	char c;
	// *(volatile unsigned int*)(UART_REG_FCR) = 0x00; // disable 16byte FIFO and clear FIFOs

	//uart_set_cfg(0, 129); // (129 + 1) * 16 * 9600 = 19.968MHz
	//uart_set_cfg(0, 10); // (10 + 1) * 16 * 115200 = 20.2752MHz
	uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz

	for (j = 0; j < 10; j++) 
	{
    	uart_wait_tx_done();
    	uart_send("01234567", 8);
	}
}


volatile unsigned char uart_buf[64];
volatile int uart_pos;
volatile int uart_flag;

volatile int timer_triggered = 0;

#define LED			(0)

#include "gpio.h"


void uart_int_test(void)
{
	// Configure ISRs
	int_enable();

	EER = (0x1 << 24);
	IER = (0x1 << 24);

	*(volatile unsigned int*)(UART_REG_IER) = 0x01;

	set_pin_function(LED, FUNC_GPIO);
	set_gpio_pin_direction(LED, DIR_OUT);

	/*while (1)
	{
		char c = uart_getchar();
		uart_send(&c, 1);
	}*/

	uart_pos = 0;
	uart_flag = 0;

	while (uart_flag == 0)
	{
		volatile int d = 5000000;
		printf("counter = %d\n", timer_triggered);
		while (--d);
	}

	uart_wait_tx_done();  
	uart_send(uart_buf, uart_pos);
}


void ISR_UART(void)
{
	char c;
	unsigned int status;

	ICP = (0x1 << 24);

	status = *(volatile unsigned int *) UART_REG_LSR;
	if (status & 0x01)
	{
		timer_triggered++;
		if (timer_triggered & 0x1)
		{
			set_gpio_pin_value(LED, 1);
		}
		else
		{
			set_gpio_pin_value(LED, 0);
		}

		c = (unsigned char)(*(volatile int*) UART_REG_RBR);
		uart_send(&c, 1);
	}

	if (status & 0x20)
	{
	}
}
