#add_application(testShell testShell.c xprintf.c LABELS "imperio_tests")

set(SHELL_SOURCES testShell.c xprintf.c)

include_directories(. )

add_application(testShell "${SHELL_SOURCES}" LABELS "imperio_tests")