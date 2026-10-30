class dual_test extends uvm_test;

  env env_h;

  `uvm_component_utils(dual_test)

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  virtual function void build_phase(uvm_phase phase);


    virtual tinyalu_bfm class_bfm, module_bfm;

    env_config env_config_h;


    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "class_bfm", class_bfm))
      `uvm_fatal("DUAL_TEST", "Failed to get class BFM.")

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "module_bfm", module_bfm))
      `uvm_fatal("DUAL_TEST", "Failed to get module BFM.")

    env_config_h = new(class_bfm, module_bfm);

    uvm_config_db#(env_config)::set(this, "env_h*", "env_config_h", env_config_h);

    this.env_h = env::type_id::create("env_h", this);

  endfunction : build_phase


endclass
