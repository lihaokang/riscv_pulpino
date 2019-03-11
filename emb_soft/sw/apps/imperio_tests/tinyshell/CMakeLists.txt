#add_application(testShell testShell.c xprintf.c LABELS "imperio_tests")

set(SH_SOURCES main.c xprintf.c tools.c shell.c fifo.c)

include_directories(. )

add_application(tinyshell "${SH_SOURCES}" LABELS "imperio_tests")
