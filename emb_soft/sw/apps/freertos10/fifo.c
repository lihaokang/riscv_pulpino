/* $Id$ */

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#include <fifo.h>
#include <tools.h>

void fifo_init(FIFO *fifo, uint8_t * buffer, uint8_t buffer_len) {
    if (fifo && buffer) {
        memset((void **)buffer, 0, buffer_len);
        fifo->buffer_len = buffer_len;
        fifo->buffer = buffer;
        fifo->head = 0;
        fifo->tail = 0;
    }
}

uint8_t fifo_count(const FIFO *fifo) {
    if (fifo) {
        return (fifo->head - fifo->tail);
        /*
        if (fifo->head >= fifo->tail)
           return (fifo->head - fifo->tail);
        else
            return (fifo->tail - fifo->head);
         */
    }
    return 0;
}

int fifo_full(const FIFO *fifo) {
    if (fifo) {
        return (fifo_count(fifo) == fifo->buffer_len);
    }
    return 1;
}

int fifo_empty(const FIFO *fifo) {
    if (fifo) {
        return (fifo_count(fifo) == 0);
    }
    return 1;
}

uint8_t fifo_peek(const FIFO *fifo) {
    uint8_t data = 0;

    if (!fifo_empty(fifo)) {
        data = fifo->buffer[fifo->tail % fifo->buffer_len];
    }
    return data;
}

int fifo_back(FIFO *fifo) {
    if (!fifo_empty(fifo)) {
        fifo->head--;
        return 1;
    }
    return 0;
}

uint8_t fifo_getc(FIFO *fifo) {
    uint8_t data = 0;

    if (!fifo_empty(fifo)) {
        data = fifo->buffer[fifo->tail % fifo->buffer_len];
        fifo->tail++;
    }
    return data;
}

int fifo_putc(FIFO *fifo, uint8_t data) {
    int status = 0;

    if (fifo) {
        if (!fifo_full(fifo)) {
            fifo->buffer[fifo->head % fifo->buffer_len] = data;
            fifo->head++;
            status = 1;
        }
    }
    return status;
}

uint8_t fifo_puts(FIFO *fifo, uint8_t * string) {
    if (fifo) {
        for (uint8_t i = 0; i < str_len(string); i++) {
            if (!fifo_putc(fifo, string[i]))
                return i;
        }
    }
    return 0;
}

int fifo_scanc(FIFO *fifo, uint8_t c) {
    if (fifo) {
        if (!fifo_empty(fifo)) {
            uint8_t tail = fifo->tail;

            for (uint8_t i = 0; i < fifo_count(fifo); i++) {
                uint8_t data = fifo->buffer[tail % fifo->buffer_len];

                if (data == c) {
                    return 1;
                }
                tail++;
            }
        }
        return 0;
    }
    return 0;
}

uint8_t fifo_get_token(FIFO *fifo, uint8_t * str, uint8_t len, uint8_t term) {
    if (fifo) {
        memset((void *)str, 0, len);

        if (fifo_scanc(fifo, term) && str) {
            uint8_t i = 0, c = 0;

            while ((c = fifo_getc(fifo)) != 0 && c != term && i < len) {
                str[i] = c;
                i++;
            }
            return i;
        }
        return 0;
    }
    return 0;
}

/* EOF */
