
class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  env env_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    this.env_h = env::type_id::create("env_h", this);

  endfunction

endclass
