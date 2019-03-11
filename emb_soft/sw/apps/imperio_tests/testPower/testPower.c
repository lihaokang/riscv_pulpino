


#include "drv_power.h"
#include "string_lib.h"
#include "uart.h"


int main(void)
{
	int vcc;
	
	uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz
	
	power_pvd_powerdown_set(0);
	
	vcc = power_vcc_value_get();
	
	printf("vcc=%d\n", vcc);

	return 0;
}
