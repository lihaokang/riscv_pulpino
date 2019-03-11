# Netlist Flow for Proton SoC

This flow includes syntheis(Design Compiler), formality(Dedesign Compiler), DFT(DC), STA(PT) and ATPG(TetraMAX)

## Quick Start

Make sure you are using bash or zsh shell. Other shells like CSH are not supported

```bash
source setup.bash
cd dc

# run synthesis
make compile

# run dft
make compile_dft

# run ATPG
make compile_atpg
```

## Configurations

All the configurations are set in `$WS_ROOT/setup.bash`. Synthesis related variables are:

```bash
# file list
export SIM_FILELIST=$WS_ROOT/verif/chip/include/vlog_filelist_zeroriscy.vc
# TODO: this should be a list
export EXCLUDE_FILES=random_stall

# libraries
export STD_CELL_PATH="/home/share/soc/backend/UMC/110nm_eFlash/110nm_pFlash/IP_Category/UMA11LSCEF15BDRLL"
export SYMBOL_LIB="ua11lscef15bdrll.sdb"
export TARGET_LIB="ua11lscef15bdrll_135c125_ss.db"
export DESIGN_TOP="pulpino_top"

# clocks
export TARGET_CLK_FREQ_MHZ=16
export CLK_UNCERTAINTY=0.1
export CLK_TRANSITION=0

# area
export TARGET_AREA=450000

# wire load model
export WIRE_LOAD_MODEL=wl10
```

## Flow Description

The scripts related are: `gen_filelist.js`, `compile_dc.tcl`, `compile_dft.tcl`, `compile_atpg.tcl`.

`gen_filelist.js` will parse the filelist used for simulation, and generate the filelist for synthesis. Simulation file list location is specified by parameter `SIM_FILELIST`.

`compile_dc.tcl` is the major script calling design compiler and compile the design.

`compile_dft.tcl` will take the output netlist from the previous stage, i.e. compile_dc, and insert scan-cahin. For the current design there is only 1-single scan chain.

TODO: parameterize the DFT insertion flow.

`compile_atpg` will generate atpg pattern based on the DFT-inserted RTL, and generate test-bench for simulation.

## Output Files

`WORK`: is the directory for putting temporary files.

`out`: is the directory for design information.

`rpt`: is the directory for design reports.
