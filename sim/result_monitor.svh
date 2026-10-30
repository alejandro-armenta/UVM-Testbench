
class result_monitor extends uvm_component;

  `uvm_component_utils(result_monitor)


  tinyalu_agent_config config_h;

  // virtual tinyalu_bfm bfm;

  uvm_analysis_port #(result_transaction) ap;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(tinyalu_agent_config)::get(this, "", "config", this.config_h))
      $fatal(2, "Failed to get the agent configuration.");

    this.config_h.bfm.result_monitor_h = this;

    ap = new("ap", this);

  endfunction : build_phase

  // lo configuras para que sea llamado por el bfm

  function void write_to_monitor(shortint unsigned r);

    result_transaction result_t;

    result_t = new("result_t");

    result_t.result = r;

    ap.write(result_t);

  endfunction

endclass
