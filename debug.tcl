set_param messaging.defaultLimit 0  

set dynamic_seed 54321

puts "Selected random simulation seed: $dynamic_seed"

set_property -name {xsim.simulate.xsim.more_options} -value "-sv_seed $dynamic_seed" -objects [get_filesets sim_1]

set TESTBENCH_TOP "ale_lib.top" 

set SNAPSHOT_NAME "snapshot"

set OUTPUT_DIR "./build"  

cd $OUTPUT_DIR

puts "Launching Vivado Simulator in batch mode..."

if {[catch { exec xsim $SNAPSHOT_NAME -R -sv_seed $dynamic_seed -testplusarg TESTNAME=TestBad } sim_out]} {
    puts $sim_out
    error "ERROR: Simulation failed or exited with an error."
} else {
    puts $sim_out
    puts "Simulation completed successfully."
}
