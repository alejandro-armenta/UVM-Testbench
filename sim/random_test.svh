
// this extends from uvm_component

class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  virtual tinyalu_bfm bfm;

  function new(string name, uvm_component parent);

    super.new(name, parent);

    // es una funcion puntero
    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      $fatal(2, "Couldnt get pointer to bfm");

  endfunction

  task run_phase(uvm_phase phase);

    random_tester random_tester_h;

    coverage coverage_h;

    phase.raise_objection(this);

    random_tester_h = new(bfm);

    coverage_h = new(bfm);

    fork

      // forever
      coverage_h.execute();

    join_none

    random_tester_h.execute();

    phase.drop_objection(this);

  endtask

endclass
