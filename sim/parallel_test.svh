
class parallel_test extends tinyalu_base_test;

  `uvm_component_utils(parallel_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);

  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);

    super.end_of_elaboration_phase(phase);

  endfunction : end_of_elaboration_phase

  task run_phase(uvm_phase phase);

    runall_sequence runall;

    runall = new("runall");

    phase.raise_objection(this);

    runall.start(null);

    phase.drop_objection(this);

  endtask


endclass
