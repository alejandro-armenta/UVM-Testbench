
class env extends uvm_env;

  `uvm_component_utils(env)

  tinyalu_agent class_agent_h, module_agent_h;

  tinyalu_agent_config class_config_h, module_config_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);


  endfunction : build_phase

endclass
