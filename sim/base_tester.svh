virtual class base_tester extends uvm_component;

  `uvm_component_utils(base_tester);

  uvm_put_port #(command_s) command_port;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  pure virtual function operation_t get_op();

  pure virtual function byte get_data();

  function void build_phase(uvm_phase phase);

    this.command_port = new("command_port", this);

  endfunction : build_phase


  // va a correr esta funcion pero con sus funciones polimorficas

  task run_phase(uvm_phase phase);

    byte unsigned A;
    byte unsigned B;
    operation_t op_set;

    command_s command;

    phase.raise_objection(this);

    command.op = rst_op;
    command_port.put(command);

    repeat (1000) begin : random_loop

      command.op = get_op();
      command.A  = get_data();
      command.B  = get_data();

      command_port.put(command);

    end : random_loop

    #500;

    phase.drop_objection(this);

  endtask : run_phase


endclass
