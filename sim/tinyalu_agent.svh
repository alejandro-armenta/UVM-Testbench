class tinyalu_agent extends uvm_agent;

  `uvm_component_utils(tinyalu_agent)

  tinyalu_agent_config config_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  coverage coverage_h;
  scoreboard scoreboard_h;

  command_monitor command_monitor_h;
  result_monitor result_monitor_h;

  driver driver_h;
  sequencer sequencer_h;


  virtual function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(tinyalu_agent_config)::get(this, "", "config", this.config_h))
      `uvm_fatal("AGENT", "Failed to get config object.");


    is_active = this.config_h.get_is_active();


    if (get_is_active() == UVM_ACTIVE) begin

      this.sequencer_h = new("sequencer_h", this);

      this.driver_h = driver::type_id::create("driver_h", this);

    end

    this.coverage_h = coverage::type_id::create("coverage_h", this);

    this.scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);

    this.command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);

    this.result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);

    if (get_is_active() == UVM_ACTIVE) begin

      // estas mandando desde el sequencer al driver mensajes
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);

    end

    command_monitor_h.ap.connect(coverage_h.analysis_export);
    command_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export);
    result_monitor_h.ap.connect(scoreboard_h.analysis_export);

  endfunction : connect_phase


endclass
