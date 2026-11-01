class random_sequence extends uvm_sequence #(sequence_item);

  `uvm_object_utils(random_sequence)

  function new(string name = "");

    super.new(name);

  endfunction

  task body();


    sequence_item command;

    repeat (1000) begin

      command = sequence_item::type_id::create("command");

      start_item(command);

      assert (command.randomize());

      finish_item(command);

    end


  endtask


endclass
