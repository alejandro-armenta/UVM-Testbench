set_param messaging.defaultLimit 0  

set dynamic_seed 54321

puts "Selected random simulation seed: $dynamic_seed"

set_property -name {xsim.simulate.xsim.more_options} -value "-sv_seed $dynamic_seed" -objects [get_filesets sim_1]

set TESTBENCH_TOP "ale_lib.top" 

set SNAPSHOT_NAME "snapshot"

set OUTPUT_DIR "./build"  

if {[file exists $OUTPUT_DIR]} {
    file delete -force $OUTPUT_DIR
}

file mkdir $OUTPUT_DIR

cd $OUTPUT_DIR

# Function to generate a .prj file and compile it safely
proc compile_library {lib_name files} {
    if {[llength $files] == 0} { return }
    
    set prj_filename "${lib_name}.prj"

    set prj_file [open $prj_filename w]
    
    # Write files into the project structure cleanly
    foreach file $files {
        puts $prj_file "sv $lib_name $file"
    }

    close $prj_file
    
    # Run the compiler via the project file
    puts "Compiling library $lib_name with [llength $files] files..."
    
    if {[catch { exec xvlog -incr -L uvm -work $lib_name -prj $prj_filename } log_out]} {
        puts $log_out
        file delete -force $prj_filename
        exit 1
    }
    
    # Clean up the temporary project file
    file delete -force $prj_filename
}

set all_files [glob -nocomplain ../src/*.sv ../sim/*.sv]

# puts $all_files

set pkg_files [lsearch -all -inline $all_files "*_pkg.sv"]

# puts $pkg_files

set remaining_files [lsearch -all -inline -not $all_files "*_pkg.sv"]

# puts $remaining_files

set files_to_compile [concat $pkg_files $remaining_files]

# puts $files_to_compile

compile_library "ale_lib" $files_to_compile


puts "Elaborating design top: $TESTBENCH_TOP into snapshot: $SNAPSHOT_NAME"

set COV_NAME "DB1"

set COV_DIR "./xsim.covdata"

# set COV_DIR "./xsim.covdb"

set elab_output [exec xelab -O0 -incr -debug off -L uvm -L ale_lib -top $TESTBENCH_TOP -snapshot $SNAPSHOT_NAME -cov_db_name $COV_NAME -cov_db_dir $COV_DIR -cc_type sbct]  

set output_lines [split $elab_output "\n"]  

set local_fail 0

foreach line $output_lines {      
    if {[regexp "ERROR:" $line]} {         puts $line; set local_fail 1 }           
    if {[regexp "WARNING:" $line] && ![regexp "XSIM 43-3431" $line]} { puts $line; set local_fail 1 } 
}

if {$local_fail} { error "ERROR: xelab finished with errors or strict warnings." }


