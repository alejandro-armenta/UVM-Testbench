class tester extends uvm_component;

  `uvm_component_utils(tester);

  uvm_put_port #(command_transaction) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    this.command_port = new("command_port", this);

  endfunction : build_phase

  task run_phase(uvm_phase phase);

    command_transaction command;

    phase.raise_objection(this);

    // la diferencia esq este no se puede desconfigurar a otro tipo y el otro si

    command = new("command");
    command.op = rst_op;
    command_port.put(command);

    repeat (1000) begin : random_loop

      command = command_transaction::type_id::create("command");

      assert (command.randomize());

      command_port.put(command);

    end : random_loop

    #500;

    phase.drop_objection(this);

  endtask : run_phase



endclass
