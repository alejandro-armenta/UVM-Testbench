
class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  env env_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function void build_phase(uvm_phase phase);

    base_tester::type_id::set_type_override(random_tester::get_type());

    this.env_h = env::type_id::create("env_h", this);

  endfunction : build_phase

  // this runs after run phase
  virtual function void final_phase(uvm_phase phase);

    $display("SUCCESS");

    uvm_top.print();

  endfunction : final_phase

endclass
