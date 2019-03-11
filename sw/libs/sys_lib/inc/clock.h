/**
 * @file
 * @brief Clock library.
 *
 * Provides Clock helper function like setting
 * control registers and reading/writing over
 * the serial interface.
 *
 */
#ifndef _CLOCK_H
#define _CLOCK_H

#include "pulpino.h"
#include <stdint.h>

#define CLOCK_BASE_ADDR 0x1b003200

#define CLOCK_REG_SCS (CLOCK_BASE_ADDR+0x0)
#define CLOCK_REG_LCS (CLOCK_BASE_ADDR+0x4)
#define CLOCK_REG_ACS (CLOCK_BASE_ADDR+0x8)
#define CLOCK_REG_HCM (CLOCK_BASE_ADDR+0xC)
#define CLOCK_REG_CSS (CLOCK_BASE_ADDR+0x10)
#define CLOCK_REG_SIO (CLOCK_BASE_ADDR+0x14)
#define CLOCK_REG_ECS (CLOCK_BASE_ADDR+0x18)
#define CLOCK_REG_TCS (CLOCK_BASE_ADDR+0x1C)


#define SCS_CLOCK REG(CLOCK_REG_SCS)
#define LCS_CLOCK REG(CLOCK_REG_LCS)
#define ACS_CLOCK REG(CLOCK_REG_ACS)
#define HCM_CLOCK REG(CLOCK_REG_HCM)
#define CSS_CLOCK REG(CLOCK_REG_CSS)
#define SIO_CLOCK REG(CLOCK_REG_SIO)
#define ECS_CLOCK REG(CLOCK_REG_ECS)
#define TCS_CLOCK REG(CLOCK_REG_TCS)

enum {
	SYSCLK_SOURCE_32MHZ = 0,
	SYSCLK_SOURCE_16MHZ,
	SYSCLK_SOURCE_8MHZ,
	SYSCLK_SOURCE_4MHZ,
	SYSCLK_SOURCE_2MHZ,
	SYSCLK_SOURCE_1MHZ,
	SYSCLK_SOURCE_32KHZ,
	SYSCLK_SOURCE_EXT,
	SYSCLK_SOURCE_NUM,
}SYSCLK_SROUCE;

enum {
	LCSCLK_SOURCE_32KHZ = 0,
	LCSCLK_SOURCE_EXT,
	LCSCLK_SOURCE_NUM,
}LCSCLK_SOURCE;

enum {
	ACSCLK_SOURCE_32MHZ = 0,
	ACSCLK_SOURCE_16MHZ,
	ACSCLK_SOURCE_8MHZ,
	ACSCLK_SOURCE_4MHZ,
	ACSCLK_SOURCE_2MHZ,
	ACSCLK_SOURCE_1MHZ,
	ACSCLK_SOURCE_2MHZ_2,
	ACSCLK_SOURCE_1MHZ_2,
	ACSCLK_SOURCE_NUM,
}ACSCLK_SOURCE;

enum {
	ECSCLK_SOURCE_DISABLE = 0,
	ECSCLK_SOURCE_DISABLE_2,
	ECSCLK_SOURCE_EXTCLK,
	ECSCLK_SOURCE_CRYSTAL_32K,
	ECSCLK_SOURCE_NUM,
}ECSCLK_SOURCE;

#define CSS_STATE_RC32M_READY 0x1
#define CSS_STATE_RC32K_READY 0x2
#define CSS_STATE_EXT_READY 0x4
#define CSS_STATE_RC32M_PDR 0x8


unsigned int clock_get_status();
int clock_config_lsclk( int source );
int clock_config_extclk( int source );
int clock_powerdown_32mclk( int powerdown );
int clock_switch_sysclk( int source );
int clock_config_adcclk( int source );
unsigned int clock_get_sysclk_config();

#endif

