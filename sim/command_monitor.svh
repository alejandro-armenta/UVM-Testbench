
class command_monitor extends uvm_component;

  `uvm_component_utils(command_monitor)

  virtual tinyalu_bfm bfm;
  uvm_analysis_port #(command_transaction) ap;


  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      `uvm_fatal("COMMAND_MONITOR", "Failed to get BFM.")

    bfm.command_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase


  function void write_to_monitor(byte unsigned A, byte unsigned B, operation_t op);

    command_transaction command;

    command.A  = A;
    command.B  = B;
    command.op = op;

    ap.write(command);

  endfunction

endclass
