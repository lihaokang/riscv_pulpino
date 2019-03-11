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


#include <drv_i2c.h>
#include "drv_clock.h"


i2c_dev_t* const I2C0 = (i2c_dev_t*)I2C0_BASE_ADDR;
i2c_dev_t* const I2C1 = (i2c_dev_t*)I2C1_BASE_ADDR;
i2c_dev_t* const I2C2 = (i2c_dev_t*)I2C2_BASE_ADDR;
i2c_dev_t* const I2C3 = (i2c_dev_t*)I2C3_BASE_ADDR;
i2c_dev_t* const I2C4 = (i2c_dev_t*)I2C4_BASE_ADDR;
i2c_dev_t* const I2C5 = (i2c_dev_t*)I2C5_BASE_ADDR;


int i2cx_init(i2c_dev_t *i2c)
{
	if (i2c == NULL) return -1;
	
	if (i2c == I2C0)
	{
		CGREG |= CG_I2C0;
	}
	else if (i2c == I2C1)
	{
		CGREG |= CG_I2C1;
	}
	else if (i2c == I2C2)
	{
		CGREG |= CG_I2C2;
	}
	else if (i2c == I2C3)
	{
		CGREG |= CG_I2C3;
	}
	else if (i2c == I2C4)
	{
		CGREG |= CG_I2C4;
	}
	else if (i2c == I2C5)
	{
		CGREG |= CG_I2C5;
	}

	return 0;
}

int i2cx_deinit(i2c_dev_t *i2c)
{
	if (i2c == NULL) return -1;
	
	if (i2c == I2C0)
	{
		CGREG |= CG_I2C0;
	}
	else if (i2c == I2C1)
	{
		CGREG |= CG_I2C1;
	}
	else if (i2c == I2C2)
	{
		CGREG |= CG_I2C2;
	}
	else if (i2c == I2C3)
	{
		CGREG |= CG_I2C3;
	}
	else if (i2c == I2C4)
	{
		CGREG |= CG_I2C4;
	}
	else if (i2c == I2C5)
	{
		CGREG |= CG_I2C5;
	}

	return 0;
}

int i2cx_setup_adapter(i2c_dev_t *i2c, uint32_t speed) 
{
    uint32_t prescaler;

    if ((speed != 100000) && (speed != 400000)) return -1;

    prescaler = ((system_clock_get() / (5 * speed)) - 1);
    i2c->pre = prescaler;
    i2c->ctr = I2C_CTR_EN;

    return 0;
}

uint32_t i2cx_get_status(i2c_dev_t *i2c) 
{
	if (i2c == NULL) return 0xffffffff;
	
	return i2c->status;
}

uint32_t i2cx_get_ack(i2c_dev_t *i2c) 
{
    volatile uint32_t t;

	if (i2c == NULL) return 0xffffffff;

    t = 0;
    while ((i2cx_get_status(i2c) & I2C_STATUS_TIP) == 0) 	// need TIP go to 1
    {
        if (t++ > 0xffff) break ;
    }
    t = 0;
    while ((i2cx_get_status(i2c) & I2C_STATUS_TIP) != 0) 	// and then go back to 0
    {
        if (t++ > 0xffff) break ;
    }
    
    return !(i2cx_get_status(i2c) & I2C_STATUS_RXACK); 		// invert since signal is active low
}

int i2cx_send_data(i2c_dev_t *i2c, uint32_t value) 
{
    if (i2c == NULL) return -1;
	
	i2c->tx = value;

	return 0;
}

int i2cx_send_command(i2c_dev_t *i2c, uint32_t value) 
{
    if (i2c == NULL) return -1;
	
	i2c->cmd = value;

	return 0;
}

uint32_t i2cx_get_data(i2c_dev_t *i2c) 
{
	if (i2c == NULL) return 0xffffffff;
	
	return i2c->rx;
}

uint32_t i2cx_busy(i2c_dev_t *i2c) 
{
    if (i2c == NULL) return 0xffffffff;
	
	return ((i2cx_get_status(i2c) & I2C_STATUS_BUSY) == I2C_STATUS_BUSY);
}

int i2cx_xfer(i2c_dev_t *i2c, i2c_msg_t msgs[], uint32_t num)
{
	int ret;
	uint32_t i;
	uint32_t j;
	i2c_msg_t *msg;

	if (i2c == NULL) return -1;
	if (msgs == NULL) return -1;

	for (i=0; i<num; i++)
	{
		msg = &msgs[i];

		if ( (i == 0) || (!(msg->flag & I2C_FLAG_NO_START)) )
		{
			i2cx_send_data(i2c, (msg->addr << 1));  
			i2cx_send_command(i2c, I2C_START_WRITE);  
			ret = i2cx_get_ack(i2c);
			if ( (ret != 0) && (!(msg->flag & I2C_FLAG_IGNORE_NACK)) )
				goto __out;
		}

		if (msg->flag & I2C_FLAG_RD)
		{
			for (j=0; j<msg->len; j++)
			{
				i2cx_send_command(i2c, I2C_READ);
				i2cx_get_ack(i2c);	
				msg->buf[j] = i2cx_get_data(i2c);
			}

			ret = 0;
		} 

		if (msg->flag & I2C_FLAG_WR)
		{
			for (j=0; j<msg->len; j++)
			{
				i2cx_send_data(i2c, msg->buf[j]); 
				i2cx_send_command(i2c, I2C_WRITE);
				ret = i2cx_get_ack(i2c);	
				if ( (ret != 0) && (!(msg->flag & I2C_FLAG_IGNORE_NACK)) )
					goto __out;
			}
		} 	
	}

	i2cx_send_command(i2c, I2C_STOP); 	
	while (i2cx_busy(i2c));

	return 0;

__out:
	return -1;
}

