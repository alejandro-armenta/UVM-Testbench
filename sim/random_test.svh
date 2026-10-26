
class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  virtual tinyalu_bfm bfm;

  random_tester tester_h;

  coverage coverage_h;

  scoreboard scoreboard_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    // todos estos son components

    tester_h = new("tester_h", this);

    coverage_h = new("coverage_h", this);

    scoreboard_h = new("scoreboard_h", this);

  endfunction

  // for join none metido ahi en el run_phase para que se ejecuten en paralelo

endclass
