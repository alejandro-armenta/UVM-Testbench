set_param messaging.defaultLimit 0  

set dynamic_seed 54321

puts "Selected random simulation seed: $dynamic_seed"

set_property -name {xsim.simulate.xsim.more_options} -value "-sv_seed $dynamic_seed" -objects [get_filesets sim_1]

set TESTBENCH_TOP "ale_lib.top" 

set SNAPSHOT_NAME "snapshot"

set OUTPUT_DIR "./build"  

cd $OUTPUT_DIR

set COV_NAME "DB1"

set COV_DIR "./xsim.covdata"

set UVM_TEST "dual_test"

puts "Launching Vivado Simulator in batch mode..."

if {[catch { exec xsim $SNAPSHOT_NAME -cov_db_name $COV_NAME -cov_db_dir $COV_DIR -R -sv_seed $dynamic_seed -testplusarg UVM_TESTNAME=$UVM_TEST } sim_out]} {
    puts $sim_out
    error "ERROR: Simulation failed or exited with an error."
} else {
    puts $sim_out
    puts "Simulation completed successfully."
}

puts "Generating visual coverage dashboard..."

set ABS_COV_DIR [file normalize "$COV_DIR"]

if {[catch { exec xcrg -dir $ABS_COV_DIR -db_name $COV_NAME -report_dir ./coverage_html -report_format html } report_out]} {
    puts "Report Generation Failed: $report_out"
} else {
    puts $report_out
    # Display the explicit global path so you can copy/paste it directly into your file manager
    puts "Done! Open this path in your browser: [file normalize ./coverage_html/dashboard.html]"
}