class result_transaction extends uvm_transaction;

  `uvm_object_utils(result_transaction)

  shortint result;


  function new(string name = "");
    super.new(name);
  endfunction

  function void do_copy(uvm_object rhs);


  endfunction : do_copy


  function command_transaction clone_me();


  endfunction : clone_me

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);


  endfunction : do_compare

  function string convert2string();


  endfunction : convert2string


endclass
