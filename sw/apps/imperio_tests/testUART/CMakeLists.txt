set(TESTUART_SOURCES testUART.c boot_menu.c ymodem.c)

include_directories(. ../../freertos/ ../../freertos/Source/include ../../freertos/Source/portable/GCC/RI5CY Source/include)

add_application(testUART "${TESTUART_SOURCES}" LABELS "imperio_tests" LIBS frtos)



