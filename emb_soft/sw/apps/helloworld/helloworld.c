// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#if 0
#include <stdio.h>


int main()
{
	printf("Hello World!!!!!\n");
	return 0;
}


#else

#include <string_lib.h>

#include "proton.h"
#include "uart.h"

int main()
{
  	//uart_set_cfg(0, 129); // (129 + 1) * 16 * 9600 = 19.968MHz
	//uart_set_cfg(0, 10); // (10 + 1) * 16 * 115200 = 20.2752MHz

	uart_set_cfg(0, 3333); // (162+ 1) * 16 * 9600 = 25.0368MHz

	printf("Hello World!!!!!\n");
  	return 0;
}

#endif
