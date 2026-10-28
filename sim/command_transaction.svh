
// uvm_transaction extends uvm_object

class command_transaction extends uvm_transaction;

  `uvm_object_utils(command_transaction)
  // un objecto no tiene fases

  rand byte unsigned A;

  rand byte unsigned B;

  rand operation_t   op;

  constraint data {

    A dist {
      8'h00 := 1,
      [8'h01 : 8'hFE] := 1,
      8'hFF := 1
    };

    B dist {
      8'h00 := 1,
      [8'h01 : 8'hFE] := 1,
      8'hFF := 1
    };
  }

  function void do_copy(uvm_object rhs);

    command_transaction rhs_transaction;

    if (rhs == null) `uvm_fatal("COMMAND_TRANSACTION", "Tried to copy from a null pointer.")

    if (!$cast(rhs_transaction, rhs))
      `uvm_fatal("COMMAND_TRANSACTION", "Tried to copy from the wrong type.")

    // aqui copias el nombre de tu transaction

    super.do_copy(rhs_transaction);

    this.A  = rhs_transaction.A;

    this.B  = rhs_transaction.B;

    this.op = rhs_transaction.op;

  endfunction

  function new(string name = "");

    super.new(name);

  endfunction

endclass
