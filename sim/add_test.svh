class add_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(add_test)

  env env_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);

    command_transaction::type_id::set_type_override(add_transaction::get_type());

    this.env_h = env::type_id::create("env_h", this);

  endfunction : build_phase

  // this runs after run phase
  virtual function void final_phase(uvm_phase phase);

    uvm_top.print();

  endfunction : final_phase


endclass
