// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/* Scheduler include files. */
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "proton.h"
#include "uart.h"
#include "gpio.h"
#include "utils.h"
#include "bench.h"
#include "int.h"


void prvSetupHardware(void)
{
	uart_set_cfg(0, 3333);
	uart_send("Starting FreeRTOS\r\n", 20);
	uart_wait_tx_done();
}


void task1 (void *pvParameters) 
{
	while (1) 
	{
		uart_send("Task 1\n", 7);
		uart_wait_tx_done();

		vTaskDelay(100);
	}

	vTaskDelete(NULL);
}

void task2 (void *pvParameters) 
{
	while (1) 
	{
		uart_send("Task 2\n", 7);
		uart_wait_tx_done();

		vTaskDelay(200);
	}

	vTaskDelete(NULL);
}


void task3 (void *pvParameters) 
{
	while (1) 
	{
		uart_send("Task 3\n", 7);
		uart_wait_tx_done();

		vTaskDelay(300);
	}

	vTaskDelete(NULL);
}


void task4 (void *pvParameters) 
{
	while (1) 
	{
		uart_send("Task 4\n", 7);
		uart_wait_tx_done();

		taskYIELD();

		uart_send("Task 5\n", 7);
		uart_wait_tx_done();

		vTaskDelay(10);
	}

	vTaskDelete(NULL);
}


int main( void )
{
	prvSetupHardware();

	xTaskCreate(task1, "Task 1", 200, NULL, 2, NULL);
 	xTaskCreate(task2, "Task 2", 200, NULL, 3, NULL);
 	xTaskCreate(task3, "Task 3", 200, NULL, 4, NULL);
	xTaskCreate(task4, "Task 4", 200, NULL, 5, NULL);

	vTaskStartScheduler();

	return 0;
}
