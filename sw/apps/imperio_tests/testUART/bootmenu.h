#ifndef __BootMenu_H__
#define __BootMenu_H__

/* Exported types ------------------------------------------------------------*/
typedef  void (*pFunction)(void);

extern pFunction Jump_To_Application;
extern uint32_t JumpAddress;


extern void BootMenu_Init(void);
extern uint16_t BootMenu_ReadFlag(void);
extern void BootMenu_WriteFlag(uint16_t flag);
extern int8_t BootMenu_RunApp(void);
extern void BootMenu_Main_Menu(void);
extern int8_t BootMenu_Update(void);
extern int8_t BootMenu_Upload(void);
extern int8_t BootMenu_Erase(void);
extern void BootMenu(void);
extern void SerialPutString( char *str );






#endif
