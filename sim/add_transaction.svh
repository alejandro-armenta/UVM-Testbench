class add_transaction extends command_transaction;

  `uvm_object_utils(add_transaction)

  function new(string name = "");

    super.new(name);

  endfunction

  // entonces no lo borra

  constraint add_only {op == add_op;}

endclass

// esto es perfecto
