class tester extends uvm_component;

  `uvm_component_utils(tester);

  uvm_put_port #(command_transaction) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    this.command_port = new("command_port", this);

  endfunction : build_phase

  function void verify_command(command_transaction command);

    assert(
    
    command.op == no_op ||
    
    command.op == add_op ||
    
    command.op == and_op ||
    
    command.op == xor_op ||
    
    command.op == mul_op ||
    
    command.op == rst_op || 
    
    (command.A >= 8'h00 && command.A <= 8'hFF) ||
    
    (command.B >= 8'h00 && command.B <= 8'hFF)
    
    )

    else `uvm_fatal("TESTER", "invalid stimulus.")

  endfunction

  task run_phase(uvm_phase phase);

    command_transaction command;

    phase.raise_objection(this);

    command = new("command");
    command.op = rst_op;
    command_port.put(command);

    repeat (1000) begin : random_loop

      command = command_transaction::type_id::create("command");

      assert (command.randomize());

      verify_command(command);

      command_port.put(command);

    end : random_loop

    #500;

    phase.drop_objection(this);

  endtask : run_phase

endclass
