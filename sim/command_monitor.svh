
class command_monitor extends uvm_component;

  `uvm_component_utils(command_monitor)

  tinyalu_agent_config config_h;

  uvm_analysis_port #(command_transaction) ap;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(tinyalu_agent_config)::get(this, "", "config", this.config_h))
      `uvm_fatal("COMMAND_MONITOR", "Failed to get agent configuration.")

    this.config_h.bfm.command_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase

  function void write_to_monitor(byte unsigned A, byte unsigned B, operation_t op);

    command_transaction command;

    command = new("command");

    command.A = A;
    command.B = B;
    command.op = op;

    ap.write(command);

  endfunction

endclass
