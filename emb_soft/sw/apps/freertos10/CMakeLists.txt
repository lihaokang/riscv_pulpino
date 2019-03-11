set(FREERTOS10_SOURCES main.c Source/list.c Source/queue.c Source/tasks.c Source/portable/GCC/RI5CY/port.c Source/portable/GCC/RI5CY/portasm.S Source/portable/MemMang/heap_4.c fifo.c tools.c xprintf.c shell.c shell-task.c oled-task.c)

set(FREERTOS10_HEADERS
    Source/include/FreeRTOS.h
    Source/include/timers.h
    Source/include/task.h
    Source/include/queue.h
    Source/include/list.h
    )

include_directories(. Source/portable/GCC/RI5CY Source/include)

add_application(freertos10 "${FREERTOS10_SOURCES}")
add_library(freertos10.1.1 STATIC ${FREERTOS10_SOURCES} ${FREERTOS10_HEADERS})
