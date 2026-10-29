


class driver extends uvm_component;

  `uvm_component_utils(driver)

  virtual tinyalu_bfm bfm;

  uvm_get_port #(command_transaction) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      `uvm_fatal("DRIVER", "Failed to get BFM")

    command_port = new("command_port", this);

  endfunction

  task run_phase(uvm_phase phase);

    command_transaction command;

    forever begin

      command_port.get(command);

      bfm.send_op(command.A, command.B, command.op);

    end

  endtask

endclass
