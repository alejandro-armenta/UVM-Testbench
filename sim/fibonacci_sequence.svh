class fibonacci_sequence extends uvm_sequence #(sequence_item);

  `uvm_object_utils(fibonacci_sequence)

  function new(string name = "");

    super.new(name);

  endfunction

  task body();

    byte unsigned n_minus_2 = 0;
    byte unsigned n_minus_1 = 1;

    sequence_item command;

    command = sequence_item::type_id::create("command");

    start_item(command);

    command.op = rst_op;

    finish_item(command);

    `uvm_info("FIBONACCI", "Fib = 00", UVM_MEDIUM)
    `uvm_info("FIBONACCI", "Fib = 01", UVM_MEDIUM)

    for (int ff = 3; ff <= 14; ++ff) begin

      start_item(command);

      // A + B   result
      //     A + B

      command.A  = n_minus_2;
      command.B  = n_minus_1;

      command.op = add_op;

      finish_item(command);

      n_minus_2 = n_minus_1;
      n_minus_1 = command.result;

    end

  endtask

endclass
