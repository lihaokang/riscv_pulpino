//==============================================================================//
//                                              				  				//
//  				Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  				//
//                                        				          				//
//------------------------------------------------------------------------------//
//  				Project Name : riscv                        				//
//  				File Name    : pulpino                    				    //
//  				Author       : huiyng cao                   				//
//  				Description  : adc comsm test system head file         		//
//  				Create Date  : 2019/02/12                 				    //
//                  Review Date  : 2019/02/12  				                    //
//==============================================================================//

#ifndef PULPINO_H
#define PULPINO_H

#define PULPINO_BASE_ADDR             0x10000000

/** SOC PERIPHERALS */
#define SOC_PERIPHERALS_BASE_ADDR     ( PULPINO_BASE_ADDR + 0xA100000 )

#define UART_BASE_ADDR                ( SOC_PERIPHERALS_BASE_ADDR + 0x0000 )
#define GPIO_BASE_ADDR                ( SOC_PERIPHERALS_BASE_ADDR + 0x1000 )
#define SPI_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x2000 )
#define TIMER_BASE_ADDR               ( SOC_PERIPHERALS_BASE_ADDR + 0x3000 )
#define EVENT_UNIT_BASE_ADDR          ( SOC_PERIPHERALS_BASE_ADDR + 0x4000 )
#define I2C_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x5000 )
#define FLL_BASE_ADDR                 ( SOC_PERIPHERALS_BASE_ADDR + 0x6000 )
#define SOC_CTRL_BASE_ADDR            ( SOC_PERIPHERALS_BASE_ADDR + 0x7000 )
#define ADC_BASE_ADDR            	  ( SOC_PERIPHERALS_BASE_ADDR + 0x8000 )
/** STDOUT */
#define STDOUT_BASE_ADDR              ( SOC_PERIPHERALS_BASE_ADDR + 0x10000 )
#define FPUTCHAR_BASE_ADDR            ( STDOUT_BASE_ADDR + 0x1000 )
#define FILE_CMD_BASE_ADDR            ( STDOUT_BASE_ADDR + 0x2000 )
#define STREAM_BASE_ADDR              ( STDOUT_BASE_ADDR + 0x3000 )

/** Instruction RAM */
#define INSTR_RAM_BASE_ADDR           ( 0x00       )
#define INSTR_RAM_START_ADDR          ( 0x80       )

/** ROM */
#define ROM_BASE_ADDR                 ( 0x8000     )

/** Data RAM */
#define DATA_RAM_BASE_ADDR            ( 0x00100000 )

/** Registers and pointers */
#define REGP(x) ((volatile unsigned int*)(x))
#define REG(x) (*((volatile unsigned int*)(x)))
#define REGP_8(x) (((volatile uint8_t*)(x)))

/* pointer to mem of apb pulpino unit - PointerSocCtrl */
#define __PSC__(a) *(unsigned volatile int*) (SOC_CTRL_BASE_ADDR + a)

/** Peripheral Clock gating */
#define CGREG __PSC__(0x04)

/** Clock gate SPI */
#define CGSPI     0x00
/** Clock gate UART */
#define CGUART    0x01
/** Clock gate GPIO */
#define CGGPIO    0x02
/** Clock gate SPI Master */
#define CGGSPIM   0x03
/** Clock gate Timer */
#define CGTIM     0x04
/** Clock gate Event Unit */
#define CGEVENT   0x05
/** Clock gate I2C */
#define CGGI2C    0x06
/** Clock gate FLL */
#define CGFLL     0x07
/** Clock gate ADC */
#define CGADC     0x08

/** Boot address register */
#define BOOTREG     __PSC__(0x08)

#define RES_STATUS  __PSC__(0x14)

#endif
