
class fibonacci_test extends tinyalu_base_test;

  `uvm_component_utils(fibonacci_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);

    virtual tinyalu_bfm bfm;

    env_config env_config_h;

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      `uvm_fatal("DUAL_TEST", "Failed to get class BFM.")

    env_config_h = new(bfm, null);

    uvm_config_db#(env_config)::set(this, "env_h*", "env_config_h", env_config_h);

    super.build_phase(phase);

  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);

    super.end_of_elaboration_phase(phase);

  endfunction : end_of_elaboration_phase


  task run_phase(uvm_phase phase);

    fibonacci_sequence fib;

    fib = new("fibonacci");

    phase.raise_objection(this);

    // se le manda el secuenciador a la secuencia y supongo que se ha de utilizar en start_item o end_item

    fib.start(this.sequencer_h);

    phase.drop_objection(this);

  endtask

endclass
