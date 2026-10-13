
virtual class svm_object;

endclass

virtual class svm_component extends svm_object;

  protected svm_component children[string];
  string name;

  function new(string name);
    this.name = name;
  endfunction

  pure virtual task run_test();

endclass

virtual class svm_object_wrapper;

  pure virtual function string get_type_name();
  pure virtual function svm_object create_object(string name);

endclass
