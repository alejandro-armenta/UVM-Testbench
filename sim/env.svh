

class env extends uvm_env;

  `uvm_component_utils(env)

  tinyalu_agent class_agent_h, module_agent_h;

  tinyalu_agent_config class_config_h, module_config_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);

    env_config env_config_h;

    if (!uvm_config_db#(env_config)::get(this, "", "env_config_h", env_config_h))
      `uvm_fatal("ENV", "FAILED to get env config.");

    this.class_config_h  = new(.bfm(env_config_h.class_bfm), .is_active(UVM_ACTIVE));

    this.module_config_h = new(.bfm(env_config_h.module_bfm), .is_active(UVM_PASSIVE));

    // aqui estas diciendo el clase agente solo puede ver esa instancia

    // aqui configuras que clase puede ver que configuracion 

    uvm_config_db#(tinyalu_agent_config)::set(this, "class_agent_h*", "config",
                                              this.class_config_h);

    uvm_config_db#(tinyalu_agent_config)::set(this, "module_agent_h*", "config",
                                              this.module_config_h);

    // aqui se instancian las clases 

    this.class_agent_h  = new(.name("class_agent_h"), .parent(this));

    this.module_agent_h = new(.name("module_agent_h"), .parent(this));

  endfunction : build_phase

endclass
