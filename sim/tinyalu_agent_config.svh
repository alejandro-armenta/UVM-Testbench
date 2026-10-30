class tinyalu_agent_config;

  virtual tinyalu_bfm bfm;

  uvm_active_passive_enum is_active;

  function new(virtual tinyalu_bfm bfm, uvm_active_passive_enum is_active);

    this.bfm = bfm;

    this.is_active = is_active;

  endfunction


  function uvm_active_passive_enum get_is_active();

    return this.is_active;

  endfunction

endclass
