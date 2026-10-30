class driver extends uvm_component;

  `uvm_component_utils(driver)

  tinyalu_agent_config config_h;

  uvm_get_port #(command_transaction) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  function void build_phase(uvm_phase phase);

    // entonces no solo se reutiliza arriba se reutiliza abajo 

    if (!uvm_config_db#(tinyalu_agent_config)::get(this, "", "config", this.config_h))
      `uvm_fatal("DRIVER", "Failed to get Agent Configuration.")

    command_port = new("command_port", this);

  endfunction

  task run_phase(uvm_phase phase);

    command_transaction command;

    forever begin

      command_port.get(command);

      this.config_h.bfm.send_op(command.A, command.B, command.op);

    end

  endtask

endclass
