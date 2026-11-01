
virtual class tinyalu_base_test extends uvm_test;

  `uvm_component_utils(tinyalu_base_test)

  env env_h;

  sequencer sequencer_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);

    virtual tinyalu_bfm bfm;

    env_config env_config_h;

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      `uvm_fatal("DUAL_TEST", "Failed to get class BFM.")

    env_config_h = new(bfm, null);

    uvm_config_db#(env_config)::set(this, "env_h*", "env_config_h", env_config_h);

    this.env_h = env::type_id::create("env_h", this);

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);

    // aqui ya esta terminado el agente

    this.sequencer_h = this.env_h.agent_h.sequencer_h;

  endfunction


endclass
