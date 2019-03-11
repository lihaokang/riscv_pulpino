caseName=helloworld

verdi:
	verdi -nologo -sverilog -top tb -f ./include/vlog_filelist_zeroriscy.vc &

verdi_syn:
	verdi -nologo -sverilog -top tb +define+SYNTHESIS -f ./include/vlog_filelist_zeroriscy.vc &

verdi_eflash:
	verdi -nologo -sverilog -top tb +define+VCS_SIMULATOR+EFLASH_MODEL -f ./include/vlog_filelist_zeroriscy.vc &

verdi_dgt:
	verdi -nologo -sverilog -top tb +define+VCS_SIMULATOR+EFLASH_EN+DIGITAL_IP -f ./include/vlog_filelist_zeroriscy.vc &

vcs_cmp_check_timing:
	vcs -full64 -sverilog +v2k -timescale=1ps/1ps -debug_access+all +error+1000 -top tb +define+VCS_SIMULATOR -f ./include/vlog_filelist_zeroriscy.vc -l vcs.comp_log

vcs_cmp:
	vcs -full64 -sverilog +v2k -timescale=1ps/1ps +notimingcheck -debug_access+all +error+1000 -top tb +define+VCS_SIMULATOR+FUNCTIONAL -f ./include/vlog_filelist_zeroriscy.vc -l vcs.comp_log

vcs_cmp_eflash:
	vcs -full64 -sverilog +v2k -timescale=1ps/1ps +notimingcheck -debug_access+all +error+1000 -top tb +define+VCS_SIMULATOR+EFLASH_MODEL -f ./include/vlog_filelist_zeroriscy.vc -l vcs.comp_log

vcs_cmp_dgt:
	vcs -full64 -sverilog +v2k -timescale=1ps/1ps +notimingcheck -debug_access+all +error+1000 -top tb +define+VCS_SIMULATOR+EFLASH_EN+DIGITAL_IP -f ./include/vlog_filelist_zeroriscy.vc -l vcs.dgt.comp_log

vcs_run:
	./simv  +caseName=${caseName} -l vcs.run_log

all:
	make vcs_cmp
	./simv  +caseName=${caseName} -l vcs.run_log

vcs_run_spi:
	./simv +MEMLOAD=SPI +caseName=${caseName} -l vcs.spi.run_log

vcs_run_jtag:
	./simv +MEMLOAD=JTAG +caseName=${caseName} -l vcs.spi.run_log

vcs_run_jtag_eflash:
	./simv +MEMLOAD=JTAG +EFLASH_LOAD=EFLASH +caseName=${caseName} -l vcs.jtag.eflash.run_log


#fpga-emu
vcs_run_adc:
	./simv +adc_case=${caseName} -l vcs.adc.run_log
vcs_run_wdt:
	./simv +wdt_case=${caseName} -l vcs.wdt.run_log
vcs_run_scu:
	./simv +scu_case=${caseName} -l vcs.scu.run_log
vcs_run_calib:
	./simv +calib_case=${caseName} -l vcs.calib.run_log
vcs_run_rtc:
	./simv +rtc_case=${caseName} -l vcs.rtc.run_log



clean:
	rm -rf work simv* csrc 

