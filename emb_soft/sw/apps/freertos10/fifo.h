/* $Id$ */

#ifndef UART_H_IUI
#define UART_H_IUI

#ifndef FIFO_BUFFER_SIZE
#define FIFO_BUFFER_SIZE 128
#endif

typedef struct fifo {
    volatile uint8_t head;
    volatile uint8_t tail;
    volatile uint8_t *buffer;
    uint8_t buffer_len;
} FIFO;

void fifo_init(FIFO * b, uint8_t * buffer, uint8_t buffer_len);
uint8_t fifo_count(const FIFO * b);
int fifo_full(const FIFO * b);
int fifo_empty(const FIFO * b);
uint8_t fifo_peek(const FIFO * b);
uint8_t fifo_getc(FIFO * b);
int fifo_putc(FIFO * b, uint8_t data);
uint8_t fifo_puts(FIFO * b, uint8_t * str);
int fifo_scanc(FIFO * b, uint8_t c);
uint8_t fifo_get_token(FIFO * b, uint8_t * str, uint8_t len, uint8_t);
int fifo_back(FIFO * b);


#endif
/* EOF */
