
class env extends uvm_env;

  `uvm_component_utils(env)


  // base_tester tester_h;




  coverage coverage_h;
  scoreboard scoreboard_h;

  command_monitor command_monitor_h;
  result_monitor result_monitor_h;

  driver driver_h;
  tester tester_h;

  uvm_tlm_fifo #(command_transaction) command_f;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  virtual function void build_phase(uvm_phase phase);

    this.tester_h = tester::type_id::create("tester_h", this);

    this.coverage_h = coverage::type_id::create("coverage_h", this);

    this.scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);

    this.command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);

    this.result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);

    this.driver_h = driver::type_id::create("driver_h", this);

    this.command_f = new("command_f", this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);

    result_monitor_h.ap.connect(scoreboard_h.analysis_export);

    command_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export);

    command_monitor_h.ap.connect(coverage_h.analysis_export);

    // aqui se conecta de manera diferente 

    tester_h.command_port.connect(command_f.put_export);

    driver_h.command_port.connect(command_f.get_export);

  endfunction


  // function void final_phase(uvm_phase phase);

  //   command_monitor_h.ap.debug_connected_to();

  //   result_monitor_h.ap.debug_connected_to();

  // endfunction : final_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    // scoreboard_h.set_report_verbosity_level_hier(UVM_HIGH);
  endfunction

endclass
