class env extends uvm_env;

  `uvm_component_utils(env)

  tinyalu_agent agent_h;

  tinyalu_agent_config config_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);

    env_config env_config_h;

    if (!uvm_config_db#(env_config)::get(this, "", "env_config_h", env_config_h))
      `uvm_fatal("ENV", "FAILED to get env config.");

    this.config_h = new(.bfm(env_config_h.class_bfm), .is_active(UVM_ACTIVE));

    uvm_config_db#(tinyalu_agent_config)::set(this, "agent_h*", "config", this.config_h);

    this.agent_h = new("agent_h", this);

  endfunction : build_phase

endclass
