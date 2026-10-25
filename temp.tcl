# 1. Isolate and compile package files FIRST to ensure type visibility
set pkg_files [glob -nocomplain ../src/*_pkg.sv ../sim/*_pkg.sv]
if {[llength $pkg_files] > 0} {
    puts "Compiling packages first..."
    # We pass include paths (-i) so `include statements can resolve back to the src/sim folders
    if {[catch { exec xvlog -incr -L uvm -work ale_lib -i ../src -i ../sim {*}$pkg_files } log_out]} {
        puts $log_out
        exit 1
    }
}

# 2. Compile remaining source and simulation files
set all_src_sim [glob -nocomplain ../src/*.sv ../sim/*.sv]
set remaining_files {}

# Filter out the packages we already compiled
foreach file $all_src_sim {
    if {$file {*}/= "*_pkg.sv"} {
        lappend remaining_files $file
    }
}

# Compile the rest using your robust project file procedure
# Modified the procedure internally to handle the include paths safely
proc compile_library_safe {lib_name files} {
    if {[llength $files] == 0} { return }
    set prj_filename "${lib_name}.prj"
    set prj_file [open $prj_filename w]
    
    foreach file $files {
        puts $prj_file "sv $lib_name $file"
    }
    close $prj_file
    
    puts "Compiling library $lib_name with [llength $files] files..."
    # Included search paths (-i) so code can see "tester.svh" or relative headers
    if {[catch { exec xvlog -incr -L uvm -work $lib_name -i ../src -i ../sim -prj $prj_filename } log_out]} {
        puts $log_out
        file delete -force $prj_filename
        exit 1
    }
    file delete -force $prj_filename
}

compile_library_safe "ale_lib" $remaining_files
