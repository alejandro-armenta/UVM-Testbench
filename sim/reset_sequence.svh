class reset_sequence extends uvm_sequence #(sequence_item);

  `uvm_object_utils(reset_sequence)

  function new(string name = "");

    super.new(name);

  endfunction

  task body();

    sequence_item command;

    command = sequence_item::type_id::create("command");

    start_item(command);

    command.op = rst_op;

    finish_item(command);

    // aqui ya puedes ver los resultados

  endtask

endclass
