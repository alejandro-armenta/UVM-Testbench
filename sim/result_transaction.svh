class result_transaction extends uvm_transaction;

  `uvm_object_utils(result_transaction)

  shortint unsigned result;

  function new(string name = "");
    super.new(name);
  endfunction

  function void do_copy(uvm_object rhs);

    result_transaction rhs_transaction;

    if (rhs == null) `uvm_fatal("RESULT_TRANSACTION", "Tried to copy from a null pointer.")

    if (!$cast(rhs_transaction, rhs))
      `uvm_fatal("RESULT_TRANSACTION", "Tried to copy from the wrong type.")

    // aqui copias el nombre de tu transaction

    super.do_copy(rhs_transaction);

    this.result = rhs_transaction.result;

  endfunction : do_copy


  function result_transaction clone_me();

    result_transaction b;

    uvm_object a;

    a = this.clone();

    // safacast 

    $cast(b, a);

    return b;

  endfunction : clone_me

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);

    result_transaction rhs_transaction;

    bit same;

    if (rhs == null) `uvm_fatal("RESULT_TRANSACTION", "Tried to do a comparison to a null pointer.")

    if (!$cast(rhs_transaction, rhs)) return same;

    same = super.do_compare(rhs, comparer) && (this.result == rhs_transaction.result);

    return same;

  endfunction : do_compare

  function string convert2string();

    string a;

    a = $sformatf("result: %4h", this.result);

    return a;

  endfunction : convert2string


endclass
