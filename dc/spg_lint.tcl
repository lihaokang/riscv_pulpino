new_project design_lint -force

set_option language_mode verilog
set_option enableSV yes
set_option top pulpino_top
read_file -type sourcelist vlog_filelist_spg.f

current_goal Design_Read
link_design -force
run_goal                          
current_goal lint/lint_rtl
run_goal

save_project design_lint/design_lint.prj -force
