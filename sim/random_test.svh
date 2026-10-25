
// this extends from uvm_component

class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  virtual tinyalu_bfm bfm;

  function new(string name, uvm_component parent);

    super.new(name, parent);

    // es una funcion puntero
    void'(uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm));


  endfunction

endclass
