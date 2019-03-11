#!/bin/tcsh
source ${PULP_PATH}/./vsim/vcompile/setup.csh

##############################################################################
# Settings
##############################################################################

set IP=apb_event_unit

##############################################################################
# Check settings
##############################################################################

# check if environment variables are defined
if (! $?MSIM_LIBS_PATH ) then
  echo "${Red} MSIM_LIBS_PATH is not defined ${NC}"
  exit 1
endif

if (! $?IPS_PATH ) then
  echo "${Red} IPS_PATH is not defined ${NC}"
  exit 1
endif

set LIB_NAME="${IP}_lib"
set LIB_PATH="${MSIM_LIBS_PATH}/${LIB_NAME}"
set IP_PATH="${IPS_PATH}/apb/apb_event_unit"
set RTL_PATH="${RTL_PATH}"

##############################################################################
# Preparing library
##############################################################################

echo "${Green}--> Compiling ${IP}... ${NC}"

rm -rf $LIB_PATH

vlib $LIB_PATH
vmap $LIB_NAME $LIB_PATH

##############################################################################
# Compiling RTL
##############################################################################

echo "${Green}Compiling component: ${Brown} apb_event_unit ${NC}"
echo "${Red}"
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}    +incdir+${IP_PATH}/./include/ ${IP_PATH}/apb_event_unit.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}    +incdir+${IP_PATH}/./include/ ${IP_PATH}/generic_service_unit.sv || goto error
vlog -quiet -sv -suppress 2583 -work ${LIB_PATH}    +incdir+${IP_PATH}/./include/ ${IP_PATH}/sleep_unit.sv || goto error

echo "${Cyan}--> ${IP} compilation complete! ${NC}"
exit 0

##############################################################################
# Error handler
##############################################################################

error:
echo "${NC}"
exit 1
