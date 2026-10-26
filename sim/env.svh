
class env extends uvm_env;

  `uvm_component_utils(env)

  coverage   coverage_h;
  scoreboard scoreboard_h;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    // create one of type derived 

    // this.base_tester = coverage::type_id::create("coverage_h", this);

    this.coverage_h   = coverage::type_id::create("coverage_h", this);

    this.scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);

  endfunction : build_phase


endclass
