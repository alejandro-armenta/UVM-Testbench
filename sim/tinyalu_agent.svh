class tinyalu_agent extends uvm_agent;

  `uvm_component_utils(tinyalu_agent)

  tinyalu_agent_config config_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  driver driver_h;
  tester tester_h;

  coverage coverage_h;
  scoreboard scoreboard_h;

  command_monitor command_monitor_h;
  result_monitor result_monitor_h;

  uvm_tlm_fifo #(command_transaction) command_f;

  uvm_analysis_port #(command_transaction) cmd_mon_ap;

  uvm_analysis_port #(result_transaction) result_ap;


  virtual function void build_phase(uvm_phase phase);






    if (get_is_active() == UVM_ACTIVE) begin

      this.command_f = new("command_f", this);

      this.tester_h  = tester::type_id::create("tester_h", this);

      this.driver_h  = driver::type_id::create("driver_h", this);

    end

    // /////////////////////////////////////////////////////////


    this.coverage_h = coverage::type_id::create("coverage_h", this);

    this.scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);

    this.command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);

    this.result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);

    // ///////////////////////////////////////////////////////

    this.cmd_mon_ap = new("cmd_mon_ap", this);

    this.result_ap = new("result_ap", this);

  endfunction : build_phase


endclass
