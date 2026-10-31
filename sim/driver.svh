
class driver extends uvm_driver #(sequence_item);
  `uvm_component_utils(driver)
  tinyalu_agent_config config_h;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(tinyalu_agent_config)::get(this, "", "config", this.config_h))
      `uvm_fatal("DRIVER", "Failed to get Agent Configuration.")
  endfunction

  task run_phase(uvm_phase phase);

    sequence_item command;

    forever begin

      shortint unsigned result;

      seq_item_port.get_next_item(command);

      this.config_h.bfm.send_op(command.A, command.B, command.op, result);

      command.result = result;

      seq_item_port.item_done();

    end

  endtask

endclass
