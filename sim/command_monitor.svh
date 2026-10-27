
class command_monitor extends uvm_component;

  `uvm_component_utils(command_monitor)

  uvm_analysis_port #(command_s) ap;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  // separo el resultado del comando y los operandos

  function void build_phase(uvm_phase phase);

    virtual tinyalu_bfm bfm;

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      $fatal(2, "Couldnt get pointer to bfm");

    bfm.command_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase



endclass
