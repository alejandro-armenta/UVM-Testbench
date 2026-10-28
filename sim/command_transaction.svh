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


  function new(string name = "");

    super.new(name);

  endfunction : new

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

  endfunction : do_copy

  function command_transaction clone_me();
    // moocow

    // desde mi y el otro empieza desde otro objeto

    command_transaction b;

    uvm_object a;

    a = this.clone();

    // safacast 

    $cast(b, a);

    return b;

  endfunction : clone_me

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);

    command_transaction rhs_transaction;

    bit same;

    if (rhs == null)
      `uvm_fatal("COMMAND_TRANSACTION", "Tried to do a comparison to a null pointer.")

    if ($cast(rhs_transaction, rhs)) return same;

    // deep compare 

    same = super.do_compare(rhs, comparer) && (this.A == rhs_transaction.A) &&
        (this.B == rhs_transaction.B) && (this.op == rhs_transaction.op);

    return same;

  endfunction : do_compare

  function string convert2string();

    string a;

    a = $sformatf("A: %2h B: %2h op: %s", this.A, this.B, this.op.name());

    return a;

  endfunction : convert2string

endclass









