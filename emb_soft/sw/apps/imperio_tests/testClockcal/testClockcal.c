


#include "drv_clockcal.h"
#include "string_lib.h"
#include "uart.h"


int main(void)
{
	int svs_hf, svs_lf;

	uart_set_cfg(0, 162); // (162+ 1) * 16 * 9600 = 25.0368MHz

	clockcal_calibrate();
	
	clockcal_read_factor_register((uint32_t *)&svs_hf, (uint32_t *)&svs_lf);
	
	printf("svs_hf=%d, svs_lf=%d\n", svs_hf, svs_lf);

	return 0;
}
