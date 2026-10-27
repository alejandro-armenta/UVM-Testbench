
class driver extends uvm_component;

  `uvm_component_utils(driver)

  virtual tinyalu_bfm bfm;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase();

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))

      $fatal(2, "Couldnt get pointer to bfm");

  endfunction

  

endclass
