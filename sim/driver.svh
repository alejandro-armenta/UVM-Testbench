


class driver extends uvm_component;

  `uvm_component_utils(driver)

  virtual tinyalu_bfm bfm;

  uvm_get_port #(command_s) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))

      $fatal(2, "Couldnt get pointer to bfm");

    command_port = new("command_port", this);

  endfunction

  task run_phase(uvm_phase phase);

    command_s command;

    forever begin
      // este hace un bloqueo aqui y ya no manda mas
      command_port.get(command);
      bfm.send_op(command.A, command.B, command.op);
    end

  endtask




endclass
