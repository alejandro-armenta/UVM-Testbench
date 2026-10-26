
class random_test extends uvm_test;

  // esta madre se registra en el mapa the proxies 
  `uvm_component_utils(random_test)

  virtual tinyalu_bfm bfm;

  random_tester tester_h;

  coverage coverage_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    tester_h   = new("tester_h", this);

    coverage_h = new("coverage_h", this);


  endfunction


  // task run_phase(uvm_phase phase);

  //   random_tester random_tester_h;

  //   coverage coverage_h;

  //   scoreboard scoreboard_h;

  //   phase.raise_objection(this);

  //   random_tester_h = new(bfm);

  //   coverage_h = new(bfm);

  //   scoreboard_h = new(bfm);

  //   fork

  //     // forever

  //     coverage_h.execute();

  //     scoreboard_h.execute();

  //   join_none

  //   random_tester_h.execute();

  //   phase.drop_objection(this);

  // endtask

endclass
