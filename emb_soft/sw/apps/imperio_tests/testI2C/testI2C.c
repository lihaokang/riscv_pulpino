// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


#include <drv_i2c.h>
#include <drv_uart.h>
#include <utils.h>
#include <bench.h>
#include <stdio.h>
#include <string.h>

#define BAUD_RATE                       100000

#define I2C_PRESCALER 0x63 //(soc_freq/(5*i2cfreq))-1 with i2cfreq = 100Khz


unsigned char tx[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
unsigned char rx[16];


#if 0
/* write page: 64byte */
int eep_write(unsigned char addr, unsigned short oft, unsigned char *buf, int size)
{
  oft = oft - (oft & 0x3f);
	size = ((size > 64) ? 64 : size);

	i2cx_send_data(I2C0, addr << 1);  
	i2cx_send_command(I2C0, I2C_START_WRITE);  
	i2cx_get_ack(I2C0);	

	i2cx_send_data(I2C0, (unsigned char)((oft & 0xFF00) >> 8)); 
	i2cx_send_command(I2C0, I2C_WRITE);
	i2cx_get_ack(I2C0);	

	i2cx_send_data(I2C0, (unsigned char)((oft & 0xFF))); 
	i2cx_send_command(I2C0, I2C_WRITE);
	i2cx_get_ack(I2C0);	

	for (int i = 0; i < size; i++) 
	{
    	i2cx_send_data(I2C0, buf[i]);           // write i-th byte into fifo
    	i2cx_send_command(I2C0, I2C_WRITE); 		// send data on the i2c bus
    	i2cx_get_ack(I2C0);               			// wait for ack
  }

	i2cx_send_command(I2C0, I2C_STOP);      		// do a stop bit, initiate eeprom write
	while (i2cx_busy(I2C0));

  	// acknowledge polling
  do 
	{
    	i2cx_send_data(I2C0, addr << 1);
    	i2cx_send_command(I2C0, I2C_START_WRITE);
  } 
	while (!i2cx_get_ack(I2C0));

	i2cx_send_command(I2C0, I2C_STOP);      		// do a stop bit, finish acknowledge polling transfer
	while (i2cx_busy(I2C0));

	return size;
}

/* read page: 64byte */
int eep_read(unsigned char addr, unsigned short oft, unsigned char *buf, int size)
{
	size = ((size > 64) ? 64 : size);

	i2cx_send_data(I2C0, addr << 1);  
	i2cx_send_command(I2C0, I2C_START_WRITE);  
	i2cx_get_ack(I2C0);	

	i2cx_send_data(I2C0, (unsigned char)((oft & 0xFF00) >> 8)); 
	i2cx_send_command(I2C0, I2C_WRITE);
	i2cx_get_ack(I2C0);	

	i2cx_send_data(I2C0, (unsigned char)((oft & 0xFF))); 
	i2cx_send_command(I2C0, I2C_WRITE);
	i2cx_get_ack(I2C0);	

	i2cx_send_data(I2C0, (addr << 1) | 0x1);  
	i2cx_send_command(I2C0, I2C_START_WRITE); 
	i2cx_get_ack(I2C0);	

	for (int i = 0; i < size; i++) 
	{
		i2cx_send_command(I2C0, I2C_READ);
		i2cx_get_ack(I2C0);
		buf[i] = i2cx_get_data(I2C0);
  }

	i2cx_send_command(I2C0, I2C_STOP);  
	while (i2cx_busy(I2C0));

	return size;
}
#else
/* write page: 64byte */
int eep_write(unsigned char addr, unsigned short oft, unsigned char *buf, int size)
{
	int i;
	i2c_msg_t msg[1];
	uint8_t _buf[72];

	oft = oft - (oft & 0x3f);
	size = ((size > 64) ? 64 : size);

	msg[0].addr = addr;
	msg[0].flag = I2C_FLAG_WR | I2C_FLAG_IGNORE_NACK;
	msg[0].len = 2;
	msg[0].buf = _buf;
	_buf[0] = (uint8_t)((oft & 0xFF00) >> 8);
	_buf[1] = (uint8_t)((oft & 0xFF)); 
	for (i=0; i<size; i++)
	{
		_buf[2+i] = buf[i];
	}
	i2cx_xfer(I2C0, msg, 1);

  	// acknowledge polling
	do 
	{
    	i2cx_send_data(I2C0, addr << 1);
    	i2cx_send_command(I2C0, I2C_START_WRITE);
	} 
	while (!i2cx_get_ack(I2C0));

	i2cx_send_command(I2C0, I2C_STOP);      		// do a stop bit, finish acknowledge polling transfer
	while (i2cx_busy(I2C0));

	return size;
}

/* read page: 64byte */
int eep_read(unsigned char addr, unsigned short oft, unsigned char *buf, int size)
{
	i2c_msg_t msg[2];
	uint8_t _buf[2];

	size = ((size > 64) ? 64 : size);
	
	msg[0].addr = addr;
	msg[0].flag = I2C_FLAG_WR | I2C_FLAG_IGNORE_NACK;
	msg[0].len = 2;
	msg[0].buf = _buf;
	_buf[0] = (uint8_t)((oft & 0xFF00) >> 8);
	_buf[1] = (uint8_t)((oft & 0xFF)); 

	msg[1].addr = addr;
	msg[1].flag = I2C_FLAG_RD | I2C_FLAG_IGNORE_NACK;
	msg[1].len = size;
	msg[1].buf = buf;

	i2cx_xfer(I2C0, msg, 2);

	return size;
}
#endif

int main(void) 
{
	uartx_set_cfg(UART0, 0, 32000000/115200); // (162+ 1) * 16 * 9600 = 25.0368MHz
	
	i2cx_setup_adapter(I2C0, 100000);

	eep_write(0x50, 0, tx, 16);
	eep_read(0x50,  0, rx, 16);

	uartx_send(UART0, rx, 16);
	uartx_wait_tx_done(UART0);
	uartx_send(UART0, "\n", 1);
	uartx_wait_tx_done(UART0);

	if (memcmp(tx, rx, 16) == 0)
	{
		uartx_send(UART0, "eeprom wr-rd test pass!\n", 24);
	}

	return 0;
}
