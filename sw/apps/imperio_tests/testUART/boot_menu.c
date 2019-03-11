#include <stdio.h>
#include "uart.h"

#include "bootmenu_config.h"
#include "bootmenu.h"
#include "ymodem.h"
//#include "common.h"
#include "string.h"

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "semphr.h"
#include "clock.h"
#include "int.h"
#include "timer.h"


pFunction Jump_To_Application;
uint32_t JumpAddress;
uint32_t BlockNbr = 0, UserMemoryMask = 0;
uint32_t FlashProtection = 0;
uint8_t tab_1024[1024] = {0};
uint16_t bootFlag = 0;
/* Common routines */
#define IS_AF(c)  ((c >= 'A') && (c <= 'F'))
#define IS_af(c)  ((c >= 'a') && (c <= 'f'))
#define IS_09(c)  ((c >= '0') && (c <= '9'))
#define ISVALIDHEX(c)  IS_AF(c) || IS_af(c) || IS_09(c)
#define ISVALIDDEC(c)  IS_09(c)
#define CONVERTDEC(c)  (c - '0')

#define CONVERTHEX_alpha(c)  (IS_AF(c) ? (c - 'A'+10) : (c - 'a'+10))
#define CONVERTHEX(c)   (IS_09(c) ? (c - '0') : CONVERTHEX_alpha(c))

extern void set_gpio_values( unsigned int gpio_masks, unsigned int value );

void jump_and_run(volatile int *ptr)
{
#ifdef __riscv__
  asm("jalr x0, %0\n"
      "nop\n"
      "nop\n"
      "nop\n"
      : : "r" (ptr) );
#else
  asm("l.jr\t%0\n"
      "l.nop\n"
      "l.nop\n"
      "l.nop\n"
      : : "r" (ptr) );
#endif
}

/************************************************************************/
void Int2Str(char* str, int32_t intnum)
{

	unsigned int j, tmp;
	unsigned int value = (unsigned int)intnum;

	for( j = 0; j < 8; j++)
	{
		tmp = (value >> (4 * j)) & 0x0f;
		if( tmp >= 10 )
			str[9-j] = (tmp-10) + 'A';
		else
			str[9-j] = tmp + '0';
	}

	str[0] = '0';
	str[1] = 'x';
	str[2+j] = ' ';
	str[3+j] = 0;
}
uint32_t Str2Int(char *inputstr, int32_t *intnum)
{
	unsigned int i = 0, res = 0;
	unsigned int val = 0;

	if( inputstr == 0 || intnum == 0) 
		return 0;
	
	if (inputstr[0] == '0' && (inputstr[1] == 'x' || inputstr[1] == 'X'))
	{
		if (inputstr[2] == '\0')
		{
			return 0;
		}
		for (i = 2; i < 11; i++)
		{
			if (inputstr[i] == '\0')
			{
				*intnum = val;
				/* return 1; */
				res = 1;
				break;
			}
			if (ISVALIDHEX(inputstr[i]))
			{
				val = (val << 4) + CONVERTHEX(inputstr[i]);
			}
			else
			{
				/* return 0, Invalid input */
				res = 0;
				*intnum = val;
				break;
			}
		}
		/* over 8 digit hex --invalid */
		if (i >= 11)
		{
			res = 0;
		}
	}
	else /* max 10-digit decimal input */
	{
		for (i = 0;i < 11;i++)
		{
			if (inputstr[i] == '\0')
			{
				*intnum = val;
				/* return 1 */
				res = 1;
				break;
			}
			else if ((inputstr[i] == 'k' || inputstr[i] == 'K') && (i > 0))
			{
				val = val << 10;
				*intnum = val;
				res = 1;
				break;
			}
			else if ((inputstr[i] == 'm' || inputstr[i] == 'M') && (i > 0))
			{
				val = val << 20;
				*intnum = val;
				res = 1;
				break;
			}
			else if (ISVALIDDEC(inputstr[i]))
			{
				val = val * 10 + CONVERTDEC(inputstr[i]);
			}
			else
			{
				/* return 0, Invalid input */
				res = 0;
				*intnum = val;
				break;
			}
		}
		/* Over 10 digit decimal --invalid */
		if (i >= 11)
		{
			res = 0;
		}
	}

	return res;
}

void SerialPutString( char *str )
{
	uart_wait_tx_done();
	uart_send(str, strlen(str));
}

static uint8_t echo_uart = 1;
#define ECHO_CHAR(c) if(echo_uart) uart_sendchar(c)
void GetInputString (uint8_t * buffP)
{
	uint32_t bytes_read = 0;
	uint32_t loopcnt = 0;
	unsigned char c = 0;
	uart_wait_tx_done();
	uart_send("\r\n#", 3);
	do
	{
#if 1	
		c = uart_getchar();	
#else		
		while( !uart_key_pressed(&c) )
		{
			loopcnt++;
			if( loopcnt > 100 )
			{
				taskYIELD();
				loopcnt = 0;
			}
			
		}
#endif		
		if (c == '\n' ||c == '\r'  )
		{
			if( bytes_read == 0 )
			{
				if( c == '\r' )
					SerialPutString("\r\n#");
				continue;
			}
			else
				break;
		}
		
		if (c == '\b') /* Backspace */
		{
			if (bytes_read > 0)
			{
				bytes_read --;				
				ECHO_CHAR(c);
				ECHO_CHAR(' ');
				ECHO_CHAR(c);
			}
			continue;
		}		
		
		if (bytes_read >= CMD_STRING_SIZE )
		{
			SerialPutString(" Cmd size over.\r\n");
			bytes_read = 0;
			continue;
		}
		if ((c >= 0x20 && c <= 0x7E) )
		{
			buffP[bytes_read++] = c;
			ECHO_CHAR(c);
		}
	}while (1);
	SerialPutString("\r\n");
	buffP[bytes_read] = '\0';
}

static void FLASH_DisableWriteProtectionPages(void)
{

}

uint8_t EraseSomePages(uint32_t size, uint8_t outPutCont)
{
	uint32_t EraseCounter = 0x0;
	uint32_t NbrOfPage = size / 1024;
	char erase_cont[3] = {0};
	//FLASH_Status FLASHStatus = FLASH_COMPLETE;
	
	//NbrOfPage = FLASH_PagesMask(size);

	/* Erase the FLASH pages */
	//FLASH_Unlock();
	for (EraseCounter = 0; (EraseCounter < NbrOfPage) /*&& (FLASHStatus == FLASH_COMPLETE)*/; EraseCounter++)
	{
		//FLASHStatus = FLASH_ErasePage(ApplicationAddress + (PAGE_SIZE * EraseCounter));
		if(outPutCont == 1)
		{
			Int2Str(erase_cont, EraseCounter + 1);
			SerialPutString(erase_cont);
			SerialPutString("@");
		}
	}
	//FLASH_Lock();
	if((EraseCounter != NbrOfPage) /*|| (FLASHStatus != FLASH_COMPLETE)*/)
	{
		return 0;
	}
	return 1;
}


/************************************************************************/
void BootMenu_WriteFlag(uint16_t flag)
{
	bootFlag = flag;
}

/************************************************************************/
uint16_t BootMenu_ReadFlag(void)
{
	return bootFlag;
}


/************************************************************************/
void BootMenu_USART_Init(void)
{
    
}

void BootMenu_Init(void)
{
}
/************************************************************************/
int8_t BootMenu_RunApp(void)
{
	if (((*(uint32_t*)ApplicationAddress) & 0x2FFE0000 ) == 0x20000000)
	{   
		SerialPutString("\r\n Run to app.\r\n");
		JumpAddress = (INSTR_RAM_START_ADDR);
		jump_and_run((volatile int *)(JumpAddress));
	return 0;
	}
	else
	{
		SerialPutString("\r\n Run to app error.\r\n");
		return -1;
	}
}

/*The return string is ended with a space ' ' or '\0' */
char* BootMenu_GetArg( char *arg, int argc)
{
	int i = 0, cnts = 0;
	char *argv = NULL;
	while( arg[i] == ' ') i++;

	argv = &arg[i];
	for( cnts = 0; cnts < argc; cnts++)
	{
		if(arg[i] == 0 )
		{
			break;
		}
		
		while( arg[i] != ' ') i++;
		while( arg[i] == ' ') i++;
		argv = &arg[i];
	}
	if( cnts == argc )
		return argv;

	return NULL;
}
static unsigned int sp = 0;
static unsigned int exception_sp = 0x103ffc;
static	unsigned int mepc = 0xFFFFFFFF;

unsigned int magic_number = 0xa1b2c3d4;


unsigned int *cur_sp = &sp;

extern void *pxCurrentTCB;

#define SP_OFFSET -16

void check_stop(int a0, int a1)
{
	asm volatile ("csrc mstatus, 8");
	asm volatile ("sw sp, %0": "=m" (sp));
	asm volatile ("csrr %0, mepc": "=r" (mepc));
	asm volatile ("lw sp, %0": :"m" (exception_sp) );
	printf("sp current: 0x%08x, 0x%08x(%08x,%08x)\r\n", sp-SP_OFFSET, pxCurrentTCB,a0,a1);
	BootMenu_Main_Menu();
}

char* BootMenu_RunCmd( char *cmdstr)
{
	int i, cnts;
	char *cmd = BootMenu_GetArg(cmdstr,1);
	char result[32];
	if( strncmp(cmd, "testw", 5) == 0 )
	{
		int32_t address = 0x00107000, length = 16, pattern = 0x55555555, cnt = 10000;
		int32_t cur_pattern, value;
		int i, j;
		Str2Int (BootMenu_GetArg(cmdstr,2), &address);		
		Str2Int (BootMenu_GetArg(cmdstr,3), &length);
		Str2Int (BootMenu_GetArg(cmdstr,4), &pattern);
		Str2Int (BootMenu_GetArg(cmdstr,5), &cnt);

		cur_pattern = pattern;

		for( j = 0; j < cnt; j++ )
		{
			cur_pattern = ~cur_pattern;

			//int_disable();
			for( i = 0; i < length; i++)
			{
				*(volatile unsigned int*)(address+4*i) = cur_pattern;
				//*(volatile unsigned int*)(address+4*i) = cur_pattern;
			}

			for( i = 0; i < length; i++)
			{
				value = *(volatile unsigned int*)(address+4*i);
				//value = *(volatile unsigned int*)(address+4*i);
				if(  value != cur_pattern )
				{
					uart_wait_tx_done();
					SerialPutString("test write failed at addr: ");
					uart_wait_tx_done();
					Int2Str(result, address+4*i);					
					SerialPutString(result);

					uart_wait_tx_done();
					SerialPutString(" cnt: ");
					Int2Str(result, j);
					uart_wait_tx_done();
					SerialPutString(result);

					uart_wait_tx_done();
					SerialPutString(" value: ");
					Int2Str(result, value);
					uart_wait_tx_done();
					SerialPutString(result);
					
					return NULL;				
				}
			}
			//int_enable();	
		}
		SerialPutString("test write OK\r\n");
		return NULL;
			
	}
	else if( strncmp(cmd, "testr", 5) == 0 )
	{
		int32_t address = 0x00107000, length = 16, pattern = 0x55555555;
		int i, value;
		Str2Int (BootMenu_GetArg(cmdstr,2), &address);		
		Str2Int (BootMenu_GetArg(cmdstr,3), &length);
		Str2Int (BootMenu_GetArg(cmdstr,4), &pattern);


		for( i = 0; i < length; i++)
		{
			//int_disable();
			value = *(volatile unsigned int*)(address);
			//int_enable();
			
			if(  value != pattern )
			{
				uart_wait_tx_done();
				SerialPutString("test read failed at: ");
				Int2Str(result, i);
				uart_wait_tx_done();
				SerialPutString(result);
				return NULL;				
			}
		}	
		SerialPutString("test read OK");
		return NULL;	
	}
	else if( strncmp(cmd, "bd", 2) == 0 )
	{
		int32_t ra = 0;
		Str2Int (BootMenu_GetArg(cmdstr,2), &ra);
		if( ra < 300 )
			ra = 300;
		uart_set_cfg(0, UART_BAUDRATE(32000000,ra));		
	}
	else if( strncmp(cmd, "uint", 4) == 0 )
	{
		int32_t addr = 0;
		Str2Int (BootMenu_GetArg(cmdstr,2), &addr);
		if( addr == 0 || addr == 1 )
		{
			int interface = 0;
			if( BootMenu_GetArg(cmdstr, 3) != NULL )
			{
				Str2Int (BootMenu_GetArg(cmdstr,3), &interface);
				uart_enable_rxint_interface( interface, addr);
			}
			else
				uart_enable_rxint(addr);
		}
		else if (addr == 2 )
			int_enable();
		else if( addr == 3 )
			int_disable();
		else if( addr == 4 )
		{
			int mstatus;
  			asm volatile ("csrr %0, mstatus": "=r" (mstatus));
			Int2Str( result, mstatus );
			SerialPutString( "mstatus = ");
			SerialPutString( result );
			SerialPutString( "\r\n" );

			asm volatile ("csrr %0, mcause": "=r" (mstatus));
			Int2Str( result, mstatus );
			SerialPutString( "mcause = ");
			SerialPutString( result );
			SerialPutString( "\r\n" );

			asm volatile ("csrr %0, mepc": "=r" (mstatus));
			Int2Str( result, mstatus );
			SerialPutString( "mepc = ");
			SerialPutString( result );
			SerialPutString( "\r\n" );

			asm volatile ("sw sp, %0": "=m" (mstatus));
			Int2Str( result, mstatus );
			SerialPutString( "sp = ");
			SerialPutString( result );
			SerialPutString( "\r\n" );

			Int2Str( result, IPR );
			SerialPutString( "IPR = ");
			SerialPutString( result );
			SerialPutString( "\r\n" );
			return 0;
		}
		else if( addr == 5 )
		{
			int mstatus = 0;  			
			Str2Int( BootMenu_GetArg(cmdstr,3), &mstatus );			
			asm volatile ("csrw mstatus, %0" : /* no output */ : "r" (mstatus));
			//SerialPutString( "set mstatus \r\n ");
			//sleep_busy(32000000*2);
			return 0;
		}
		else if( addr == 6 )
		{
			extern void wdt_enable( int sec );

			int sec = 1;  			
			Str2Int( BootMenu_GetArg(cmdstr,3), &sec );	

			wdt_enable(sec);
		}
		else if( addr == 7 )
		{
			int hz = 1;  
			int num = 0;
			Str2Int( BootMenu_GetArg(cmdstr,3), &num );			
			Str2Int( BootMenu_GetArg(cmdstr,4), &hz );
			if( num > 3 ) num = 3;

			__PT__(0x8+num*0x10) = 32000000/hz;
    			__PT__(0x4+num*0x10)  = 0x7; /* Timer A - enable interrupts, start timer */
			IER |= (1 << (ISR_NUM_TMR0 + num) );
		}
		else if( addr == 8 )
		{
			int mstatus = 1;  			
			Str2Int( BootMenu_GetArg(cmdstr,3), &mstatus );	
			asm volatile ("csrc mstatus, 8");		
			//asm volatile ("csrc mstatus, %0" : /* no output */ : "r" (mstatus));
				
			return 0;
		}
		else if( addr == 9 )
		{
			int mstatus = 1;  			
			Str2Int( BootMenu_GetArg(cmdstr,3), &mstatus );			
			asm volatile ("csrs mstatus, 8");
			//asm volatile ("csrs mstatus, %0" : /* no output */ : "r" (mstatus));			
			return 0;
		}
		else if( addr == 10 )
		{
			int interface = 0;  			
			Str2Int( BootMenu_GetArg(cmdstr,3), &interface );
			if( interface > 0 && interface < 6 )
			{
				set_gpio_values(0x00f80000, 0x1 << (interface-1+19) );
				cancel_uart_loop_test();
			}
			else
				set_gpio_values(0x00f80000, 0x0 );
						
			uart_set_interface(interface, 0, UART_BAUDRATE(32000000,921600));
			//asm volatile ("csrs mstatus, %0" : /* no output */ : "r" (mstatus));			
			return 0;
		}
		else
		{
			extern void print_tick();
			print_tick();
		}
	}
	else if( strncmp(cmd, "cl32k", 5) == 0 )
	{
		int32_t addr = 0;
		Str2Int (BootMenu_GetArg(cmdstr,2), &addr);		
		if( 0 == clock_switch_sysclk(SYSCLK_SOURCE_32KHZ) )
		{
			uart_set_cfg(0, UART_BAUDRATE(32768,300) );
			SerialPutString("set to 32K ok ");

			if( addr == 1 )
			{
				clock_powerdown_32mclk(1);
				sleep_busy(10);
				if( (CSS_CLOCK & CSS_STATE_RC32M_PDR) )
				{
					SerialPutString(" powerdown 32M ok\r\n");
				}
				else
				{
					SerialPutString(" powerdown 32M failed\r\n");
				}
			}
			else if( addr == 2 )
			{
				clock_powerdown_32mclk(0);
				sleep_busy(10);
				if( (CSS_CLOCK & CSS_STATE_RC32M_PDR) )
				{
					SerialPutString(" powerup 32M failed\r\n");
				}
				else
				{
					SerialPutString(" powerup 32M ok\r\n");
				}
			}
		}
		else
			SerialPutString("set to 32K failed ");

	}
	else if( strncmp(cmd, "cl32m", 5) == 0 )
	{
		int32_t addr = 0;		
		if( 0 == clock_switch_sysclk(SYSCLK_SOURCE_32MHZ) )
		{
			uart_set_cfg(0, UART_BAUDRATE(32000000,9600) );
			SerialPutString("set to 32M ok ");
		}
		else
			SerialPutString("set to 32M failed ");
	}
	else if( strncmp(cmd, "clock", 5) == 0 )
	{
		int32_t addr = 0;		
		check_clock(0,0,0);
	}
	else if( strncmp(cmd, "adc", 3) == 0 )
	{
		int32_t addr = 0;		
		check_adc(0,0,0);
	}
	else if( strncmp(cmd, "rtc", 3) == 0 )
	{	
		int32_t addr = 0;
		Str2Int (BootMenu_GetArg(cmdstr,2), &addr);
		if( addr == 0 )
			check_rtc(0,0,0);
		else if( addr == 1 )
			show_rtc();
		else
		{
			int32_t timev[6] = {2019,2,19,16,25,30};
			int i = -1;
			if( addr & 0x2 )
			{
				for( i = 0; i < 6; i++ )
					Str2Int (BootMenu_GetArg(cmdstr,3+i), &timev[i]);
			}
			if( addr & 0x4 )
				int_disable();

			if( addr & 0x8 )		
				i = rtc_set_timev(timev);
			else
				i = -1;

			if( addr & 0x4 )
				int_enable();

			SerialPutString(cmdstr);
#if 0
			SerialPutString("result: ");
			Int2Str(result, i);
			SerialPutString(result);
			SerialPutString("\r\n");
#endif
		}
		
		
	}
	else if( strncmp(cmd, "d", 1) == 0 )
	{
		int32_t addr = 0;
		int32_t len = 16;
		int32_t value = 0;

		Str2Int (BootMenu_GetArg(cmdstr,2), &addr);
		if( BootMenu_GetArg(cmdstr,3) != NULL )
		{
			Str2Int (BootMenu_GetArg(cmdstr,3), &len);
		}
		SerialPutString("\r\n");
		Int2Str((char*)result, (addr) );
		SerialPutString(result);
		SerialPutString(": ");
		for( i = 0; i < len; i++ )
		{
			value = *(volatile int32_t*)(addr + 4*i);
		#if 1
			Int2Str((char*)result,  value);
			SerialPutString(result);
		#else
			uart_wait_tx_done();
			printf("0x%08x ",  value);
		#endif
			if( (i & 3) == 3 )
			{
				SerialPutString("\r\n");
				Int2Str((char*)result, (addr + 4*i+4) );
				SerialPutString(result);
				SerialPutString(": ");
			}
		}			
	}
	else if( strncmp(cmd, "w", 1) == 0 )
	{
		int32_t addr = 0;
		int32_t value = 0;
		Str2Int (BootMenu_GetArg(cmdstr,2), &addr);
		Str2Int (BootMenu_GetArg(cmdstr,3), &value);

		if( NULL == BootMenu_GetArg(cmdstr,3) )
		{
			SerialPutString("Invalid parameter\r\n");
			return NULL;			
		}

		*(volatile int32_t*)addr = value;
	}

	SerialPutString("\r\n");
	return NULL;
}




/************************************************************************/
void BootMenu_Main_Menu(void)
{
	uint8_t cmdStr[CMD_STRING_SIZE+1] = {0};
	//int_enable();
	SerialPutString("\r\n Corelink Menu v0.1.0\r\n");
	SerialPutString(" update\r\n");
	SerialPutString(" menu\r\n");
	SerialPutString(" mem\r\n");

	BootMenu_RunCmd("mem uint 4 \n");
	//test_memw();
	while (1)
	{
		
		
		GetInputString(cmdStr);

		if(strcmp((char *)cmdStr, CMD_UPDATE_STR) == 0)
		{
			BootMenu_WriteFlag(UPDATE_FLAG_DATA);
			return;
		}	
		else if(strcmp((char *)cmdStr, CMD_MENU_STR) == 0)
		{
			BootMenu_WriteFlag(INIT_FLAG_DATA);
		}
		else if(strcmp((char *)cmdStr, CMD_RUNAPP_STR) == 0)
		{
			BootMenu_WriteFlag(APPRUN_FLAG_DATA);
			return;
		}
		else if(strncmp((char *)cmdStr, CMD_MEM_STR, strlen(CMD_MEM_STR) ) == 0)
		{
			BootMenu_RunCmd((char *)cmdStr);
		}
		else
		{
			SerialPutString(" Invalid CMD !\r\n");
			BootMenu_WriteFlag(INIT_FLAG_DATA);
		}

	}
}


/************************************************************************/
int8_t BootMenu_Update(void)
{
	char Number[10] = "";
	int32_t Size = 0;
	Size = Ymodem_Receive(&tab_1024[0]);
	if (Size > 0)
	{
		SerialPutString("\r\n Update Over!\r\n");
		SerialPutString(" Name: ");
		SerialPutString(file_name);
		Int2Str(Number, Size);
		SerialPutString("\r\n Size: ");
		SerialPutString(Number);
		SerialPutString(" Bytes.\r\n");
		return 0;
	}
	else if (Size == -1)
	{
		SerialPutString("\r\n Image Too Big!\r\n");
		return -1;
	}
	else if (Size == -2)
	{
		SerialPutString("\r\n Update failed!\r\n");
		return -2;
	}
	else if (Size == -3)
	{
		SerialPutString("\r\n Aborted by user.\r\n");
		return -3;
	}
	else
	{
		SerialPutString(" Receive Filed.\r\n");
		return -4;
	}
}


/************************************************************************/
int8_t BootMenu_Upload(void)
{
	uint32_t status = 0; 
	SerialPutString("\n\n\rSelect Receive File ... (press any key to abort)\n\r");
	if (uart_getchar() == CRC16)
	{
		status = Ymodem_Transmit((uint8_t*)ApplicationAddress, (const uint8_t*)"UploadedFlashImage.bin", FLASH_IMAGE_SIZE);
		if (status != 0) 
		{
			SerialPutString("\n\rError Occured while Transmitting File\n\r");
			return -1;
		}
		else
		{
			SerialPutString("\n\rFile Trasmitted Successfully \n\r");
			return -2;
		}
	}
	else
	{
		SerialPutString("\r\n\nAborted by user.\n\r");  
		return 0;
	}
}


/************************************************************************/
int8_t BootMenu_Erase(void)
{
	char erase_cont[3] = {0};
	Int2Str(erase_cont, FLASH_IMAGE_SIZE / PAGE_SIZE);
	SerialPutString(" @");
	SerialPutString(erase_cont);
	SerialPutString("@");
	if(EraseSomePages(FLASH_IMAGE_SIZE, 1))
		return 0;
	else
		return -1;
}
	
void BootMenu(void)	
{
	BootMenu_Init();
	int_enable();
	
	while(1)
	{
		switch(BootMenu_ReadFlag())
		{
			case APPRUN_FLAG_DATA://jump to app
				if( BootMenu_RunApp())
					BootMenu_WriteFlag(INIT_FLAG_DATA);
				break;
			case INIT_FLAG_DATA://initialze state (blank mcu)
				BootMenu_Main_Menu();
				break;
			case UPDATE_FLAG_DATA:// download app state 			
				if( 0 /*!BootMenu_Update()*/) 
					BootMenu_WriteFlag(APPRUN_FLAG_DATA);
				else
					BootMenu_WriteFlag(INIT_FLAG_DATA);
				break;
			case ERASE_FLAG_DATA:// erase app state
				BootMenu_Erase();
				BootMenu_WriteFlag(INIT_FLAG_DATA);
				break;
			default:
				break;
		}
	}
}

