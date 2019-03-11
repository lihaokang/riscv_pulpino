################################################################################
# Tools setup
################################################################################

# gnu toolchain  setting
export PATH=/home/share/soc/riscv-tools/bin:$PATH

# pathon2.7 for IP update tools
export PATH=/usr/local/bin:$PATH

# eda tools license
export LM_LICENSE_FILE="27010@etxLicenseServer:27020@etxLicenseServer:27030@etxLicenseServer"
export MGLS_LICENSE_FILE="27030@etxLicenseServer"
export SNPSLMD_LICENSE_FILE="27020@etxLicenseServer"

# eda tools path
export VCS_HOME="/tools/Synopsys/vcs-mx-N-2017.12-SP1"
export VERDI_HOME="/tools/Synopsys/Verdi_N-2017.12-SP1"
export EDI_HOME="/tools/Cadence/EDI1421"
export Modelsim_HOME="/tools/Mentor/modelsim10.6"
export DC_HOME="/tools/Synopsys/syn_vM-2016.12-SP5/syn/M-2016.12-SP5"
export FM_HOME="/tools/Synopsys/fm-N-2017.09"
export TX_HOME="/tools/Synopsys/tx_vM-2016.12-SP5/txs-M-2016.12-SP5"
export SPYGLASS_HOME="/tools/Synopsys/SpyGlass_vM-2017.03-SP1-1/SPYGLASS_HOME"
export PT_HOME="/tools/Synopsys/pts-M-2017.06-SP1"
export ICC_HOME="/home/tools/Synopsys/icc-M-2016.12-SP2"

export MMSIM_HOME="/home/tools/Cadence/SPECTRE171"
export INCISIVE_HOME="/home/tools/Cadence/INCISIVE152"
export XCELIUM_HOME="/home/tools/Cadence/XCELIUM1710"
export Catapult_102a_HOME="/home/tools/Mentor/Catapult10.2a"
export Catapult_103b_HOME="/home/tools/Mentor/Catapult10.3b"

export PATH="$VCS_HOME/bin/":$PATH
export PATH="$VCS_HOME/amd64/bin/":$PATH
export PATH="$VERDI_HOME/bin/":$PATH
export PATH="$EDI_HOME/bin/":$PATH
export PATH="$Modelsim_HOME/modeltech/bin/":$PATH
export PATH="$DC_HOME/amd64/syn/bin/":$PATH
export PATH="$DC_HOME/lib/lib_compiler_vM-2017.06-SP1/lc/M-2017.06-SP1/bin/":$PATH
export PATH="$FM_HOME/linux64/fm/bin/":$PATH
export PATH="$TX_HOME/bin":$PATH
export PATH="$SPYGLASS_HOME/bin":$PATH
export PATH="$PT_HOME/bin":$PATH
export PATH="$ICC_HOME/bin":$PATH

export PATH="$MMSIM_HOME/bin/":$PATH
export PATH="$MMSIM_HOME/tools/bin/":$PATH
export PATH="$MMSIM_HOME/tools/dfII/bin/":$PATH
export PATH="$MMSIM_HOME/tools/spectre/bin/":$PATH

export PATH="$INCISIVE_HOME/bin/":$PATH
export PATH="$INCISIVE_HOME/tools/bin/":$PATH
export PATH="$INCISIVE_HOME/tools/bin/64bit/":$PATH
export PATH="$INCISIVE_HOME/tools.lnx86/inca/bin/64bit/":$PATH

export PATH="$XCELIUM_HOME/bin/":$PATH
export PATH="$XCELIUM_HOME/tools/bin/":$PATH
export PATH="$XCELIUM_HOME/tools/bin/64bit/":$PATH
export PATH="$XCELIUM_HOME/tools.lnx86/inca/bin/64bit/":$PATH

#export PATH="$Catapult_102a_HOME/bin/":$PATH
export PATH="$Catapult_103b_HOME/bin/":$PATH

################################################################################
# workspace setup
################################################################################
export PULP_GIT_DIRECTORY=`git rev-parse --show-toplevel`
export WS_ROOT=$PULP_GIT_DIRECTORY
export RTL_DIR=$WS_ROOT/rtl
export IPS_DIR=$WS_ROOT/ips
export SIM_DIRECTORY="$PULP_GIT_DIRECTORY/vsim"

################################################################################
# Architecture
################################################################################
# support compressed instructions
export RVC=1

# use zero-riscvy
export USE_ZERO_RISCY=1

# Floating Point extensions. riscy only
export RISCY_RV32F=0

# zeroriscy with the multiplier
export ZERO_RV32M=1

# zeroriscy with only 16 registers
export ZERO_RV32E=0

# gcc architecture
export GCC_MARCH="rv32imc"

################################################################################
# FPGA setup
################################################################################

# setup for FPGA board
export BOARD=artyboard
export XILINX_PART=xc7a35ticsg324-1L
export XILINX_BOARD=digilentinc.com:arty:part0:1.1

# setup for vivado
hostname=$(hostname -f)
if [ "$hostname" = "corelink218" ]; then
  source /tools/Vivado/2018.2/settings64.sh
else
  source /home/opt/Xilinx/2018.2/Vivado/2018.2/settings64.sh
fi

################################################################################
# Synthesis setup
################################################################################

# file list
export SIM_FILELIST=$WS_ROOT/verif/chip/include/vlog_filelist_zeroriscy.vc
export DESIGN_TOP="pulpino_top"

# libraries
export TARGET_LIB_DIR="/home/share/soc/backend/UMC/110nm_eFlash/110nm_pFlash/IP_Category/UMA11LSCEF15BDRLL/synopsys /home/weijie.chen/backend/database/DKT_HJ110SIOPF50MVIHCAA_A_0.3_20190301/synopsys /home/weijie.chen/backend/database/eFlash /home/weijie.chen/backend/database/analog/HXMCU_LIB_20190227/ANA_TOP/lib "
export SYMBOL_LIB_DIR="/home/share/soc/backend/UMC/110nm_eFlash/110nm_pFlash/IP_Category/UMA11LSCEF15BDRLL/symbol"
export MEM_LIB_DIR="/home/share/soc/flow/memlib/prom_512x32/SKAA110_512X32BM1A /home/share/soc/flow/memlib/sp_ram_8192x32/SHAA110_8192X8X4CM8 /home/share/soc/flow/memlib/sp_ram_4096x32/SHAA110_4096X8X4CM8"
export SYNTHETIC_LIB_DIR="/tools/Synopsys/syn_vM-2016.12-SP5/syn/M-2016.12-SP5/libraries/syn/"
export SYMBOL_LIB="ua11lscef15bdrll.sdb"
export TARGET_LIB="ua11lscef15bdrll_150c25_tt.db SHAA110_4096X8X4CM8_tt1p5v25c.db  SHAA110_8192X8X4CM8_tt1p5v25c.db SKAA110_512X32BM1A_tt1p5v25c.db hj110siopf50mvihcaa_50_150c25_tc.db PF64AK32EI40_V0.4.1.db ANA_TOP_typ0p9v85.db"
export SYNTHETIC_LIB="dw_foundation.sldb"

# clocks
export TARGET_CLK_FREQ_MHZ=32
export CLK_UNCERTAINTY=0.1
export CLK_TRANSITION=0.5
export CLK_LATENCY=1

# area
export TARGET_AREA=450000
export MAX_FANOUT=50

# wire load model
export WIRE_LOAD_MODEL=wl10
