# Replace "MyUvmTest" with your actual UVM test class name
set UVM_TEST "MyUvmTest"

if {[catch { exec xsim $SNAPSHOT_NAME -cov_db_name $COV_NAME -cov_db_dir $COV_DIR -R -sv_seed $dynamic_seed -testplusarg UVM_TESTNAME=$UVM_TEST } sim_out]} { 
    puts $sim_out 
    error "ERROR: Simulation failed or exited with an error." 
} else { 
    puts $sim_out 
    puts "Simulation completed successfully." 
}
