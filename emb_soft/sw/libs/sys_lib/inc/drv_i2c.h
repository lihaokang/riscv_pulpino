/* Copyright (c) 2019-2020, corelink inc., www.corelink.vip
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * Change Logs:
 * Date           Author       Notes
 * 2019-01-27     lgq          the first version
 */
 

#ifndef __DRV_I2C_H__
#define __DRV_I2C_H__


#include <proton.h>
#include <stdint.h>
#include <stddef.h>


#ifdef __cplusplus
extern "C" {
#endif


#define	I2C0_BASE_ADDR			(0x1A126000)
#define	I2C1_BASE_ADDR			(0x1A127000)
#define	I2C2_BASE_ADDR			(0x1A128000)
#define	I2C3_BASE_ADDR			(0x1A129000)
#define	I2C4_BASE_ADDR			(0x1A12A000)
#define	I2C5_BASE_ADDR			(0x1A12B000)

#define I2C_START       		((uint32_t)0x80)
#define I2C_STOP        		((uint32_t)0x40)
#define I2C_READ        		((uint32_t)0x20)
#define I2C_WRITE       		((uint32_t)0x10)
#define I2C_CLR_INT     		((uint32_t)0x01)
#define I2C_START_READ  		((uint32_t)0xA0)
#define I2C_STOP_READ   		((uint32_t)0x60)
#define I2C_START_WRITE 		((uint32_t)0x90)
#define I2C_STOP_WRITE  		((uint32_t)0x50)

#define I2C_CTR_EN        		((uint32_t)0x80) 	// enable only
#define I2C_CTR_INTEN     		((uint32_t)0x40) 	// interrupt enable only
#define I2C_CTR_EN_INTEN  		((uint32_t)0xC0)	// enable i2c and interrupts

typedef struct _i2c_dev
{
	volatile uint32_t pre;			
	volatile uint32_t ctr;			
	volatile uint32_t rx;			
	volatile uint32_t status;			
	volatile uint32_t tx;			
	volatile uint32_t cmd;
} __attribute__((packed, aligned(4))) i2c_dev_t; 

extern i2c_dev_t* const I2C0;
extern i2c_dev_t* const I2C1;
extern i2c_dev_t* const I2C2;
extern i2c_dev_t* const I2C3;
extern i2c_dev_t* const I2C4;
extern i2c_dev_t* const I2C5;
          
#define I2C_STATUS_RXACK 		((uint32_t)0x80)
#define I2C_STATUS_BUSY  		((uint32_t)0x40)
#define I2C_STATUS_AL    		((uint32_t)0x20)
#define I2C_STATUS_TIP   		((uint32_t)0x02)
#define I2C_STATUS_IF    		((uint32_t)0x01)

#define I2C_FLAG_WR				((uint8_t)0x01)
#define I2C_FLAG_RD				((uint8_t)0x02)
#define I2C_FLAG_NO_START		((uint8_t)0x04)
#define I2C_FLAG_IGNORE_NACK	((uint8_t)0x08)

typedef struct _i2c_msg
{
	uint8_t addr;			
	uint8_t flag;			
	uint16_t len;			
	uint8_t *buf;			
} i2c_msg_t; 


int i2cx_init(i2c_dev_t *i2c);
int i2cx_deinit(i2c_dev_t *i2c);

int i2cx_setup_adapter(i2c_dev_t *i2c, uint32_t speed);

int i2cx_send_data(i2c_dev_t *i2c, uint32_t value);
int i2cx_send_command(i2c_dev_t *i2c, uint32_t value);
uint32_t i2cx_get_status(i2c_dev_t *i2c);
uint32_t i2cx_get_data(i2c_dev_t *i2c);
uint32_t i2cx_get_ack(i2c_dev_t *i2c);
uint32_t i2cx_busy(i2c_dev_t *i2c);

/* Easy API */
int i2cx_xfer(i2c_dev_t *i2c, i2c_msg_t msgs[], uint32_t num);


#ifdef __cplusplus
}
#endif


#endif	/* #ifndef __DRV_I2C_H__ */
