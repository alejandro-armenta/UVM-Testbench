class sequence_item extends uvm_sequence_item;

  `uvm_object_utils(sequence_item)

  function new(string name = "");
    super.new(name);
  endfunction

  rand byte unsigned A;

  rand byte unsigned B;

  rand operation_t   op;

  shortint unsigned  result;

  constraint op_con {

    op dist {
      no_op := 1,

      add_op := 5,
      mul_op := 5,
      and_op := 5,
      xor_op := 5,

      rst_op := 1
    };

  }

  constraint data {

    A dist {
      8'h00 := 1,
      [8'h01 : 8'hFE] :/ 1,
      8'hFF := 1
    };

    B dist {
      8'h00 := 1,
      [8'h01 : 8'hFE] :/ 1,
      8'hFF := 1
    };
  }

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);

    sequence_item rhs_transaction;

    bit same;

    if (rhs == null) `uvm_fatal(get_type_name(), "Tried to do a comparison to a null pointer.")

    if (!$cast(rhs_transaction, rhs)) return same;

    same = (super.do_compare(rhs_transaction, comparer) && (this.A == rhs_transaction.A) &&
            (this.B == rhs_transaction.B) && (this.op == rhs_transaction.op) &&
            (this.result == rhs_transaction.result));

    return same;

  endfunction : do_compare


  function void do_copy(uvm_object rhs);

    sequence_item rhs_transaction;

    if (rhs == null) `uvm_fatal(get_type_name(), "Tried to copy from a null pointer.")

    if (!$cast(rhs_transaction, rhs))
      `uvm_fatal(get_type_name(), "Tried to copy from the wrong type.")

    super.do_copy(rhs_transaction);

    this.A = rhs_transaction.A;

    this.B = rhs_transaction.B;

    this.op = rhs_transaction.op;

    this.result = rhs_transaction.result;

  endfunction : do_copy


  function string convert2string();

    string a;

    a = $sformatf("A: %2h B: %2h op: %s result: %4h", this.A, this.B, this.op.name(), this.result);

    return a;

  endfunction : convert2string


endclass
