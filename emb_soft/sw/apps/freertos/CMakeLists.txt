set(FREERTOS_SOURCES main.c Source/list.c Source/queue.c Source/tasks.c Source/portable/GCC/RI5CY/port.c Source/portable/GCC/RI5CY/portasm.S Source/portable/MemMang/heap_1.c)

set(FREERTOS_HEADERS
    Source/include/FreeRTOS.h
    Source/include/timers.h
    Source/include/task.h
    Source/include/queue.h
    Source/include/list.h
    )

include_directories(. Source/portable/GCC/RI5CY Source/include)

add_application(freertos "${FREERTOS_SOURCES}")
add_library(frtos STATIC ${FREERTOS_SOURCES} ${FREERTOS_HEADERS})
