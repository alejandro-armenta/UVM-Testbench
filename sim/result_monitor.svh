
class result_monitor extends uvm_component;

  `uvm_component_utils(result_monitor)

  virtual tinyalu_bfm bfm;

  uvm_analysis_port #(result_transaction) ap;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      $fatal(2, "Couldnt get pointer to bfm");

    bfm.result_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase

  function void write_to_monitor(shortint unsigned r);

    result_transaction result_t;

    // porque este nunca lo quieres cambiar 

    result_t = new("result_t");

    result_t.result = r;

    ap.write(result_t);

  endfunction

endclass
