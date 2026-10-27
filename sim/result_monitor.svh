
class result_monitor extends uvm_component;

  `uvm_component_utils(result_monitor)

  uvm_analysis_port #(shortint unsigned) ap;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    virtual tinyalu_bfm bfm;

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      $fatal(2, "Couldnt get pointer to bfm");

    bfm.result_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase

  function void write_to_monitor(shortint unsigned r);
    ap.write(r);
  endfunction

endclass
