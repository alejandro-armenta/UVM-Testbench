class maxmult_sequence extends uvm_sequence #(sequence_item);

  `uvm_object_utils(maxmult_sequence)

  function new(string name = "");

    super.new(name);

  endfunction

  task body();


    sequence_item command;

    command = sequence_item::type_id::create("command");

    start_item(command);

    command.op = mul_op;
    command.A  = 8'hFF;
    command.B  = 8'hFF;

    finish_item(command);


  endtask



endclass
