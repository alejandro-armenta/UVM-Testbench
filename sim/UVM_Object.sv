`ifndef SVM_OBJECTS
`define SVM_OBJECTS

`include "Environment.sv"

typedef class svm_factory;

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

// esa clase no existe hasta que el compilador la espcecializa

class svm_component_registry #(
    type T = svm_component,
    string Tname = "<unknown>"
) extends svm_object_wrapper;

  typedef svm_component_registry#(T, Tname) some_type;

  virtual function string get_type_name();
    return Tname;
  endfunction

  // este se registra en la factoria y se crea instantaneamente al inicio del programa antes del int
  local static some_type me = get();

  static function some_type get();

    $display("%m");

    if (me == null) begin

      // get statico de singleton de factory()
      svm_factory f = svm_factory::get();

      me = new();

      f.register(me);

    end

    return me;

  endfunction

  virtual function svm_object create_object(string name);

    T obj;

    obj = new(name);

    return obj;

  endfunction


endclass

class svm_factory;

  static svm_object_wrapper m_type_names[string];

  static svm_factory m_inst;

  static function svm_factory get();

    if (m_inst == null) m_inst = new();

    return m_inst;

  endfunction

  static function void register(svm_object_wrapper c);

    m_type_names[c.get_type_name()] = c;

  endfunction

  static function svm_component get_test();

    svm_object_wrapper test_wrapper;

    svm_component test_comp;

    string name;

    if (!$value$plusargs("SVM_TESTNAME=%s", name)) begin
      $display("Fatal: no test name found in command line");
      $finish;
    end

    if (!m_type_names.exists(name)) begin
      $display("Fatal: no test found with that name in factory.");
      $finish;
    end

    test_wrapper = m_type_names[name];

    // downcast to test_comp since default is svm_object;
    $cast(test_comp, test_wrapper.create_object(name));

    return test_comp;


  endfunction

  static function void display();

    // aqui estoy imprimiendo el proxy

    foreach (m_type_names[key]) $display("%s %s", key, $typename(m_type_names[key]));

  endfunction

endclass

// typedef define un tipo y ese se instancia estaticamente
`define svm_component_utils(T) \
typedef svm_component_registry#(T, `"T`") type_id;\
virtual function string get_type_name();\
  return `"T`";\
endfunction


// se creo una instancia estatica de esto 
class TestBase extends svm_component;

  Environment env;

  // this instances an object because of specialization
  `svm_component_utils(TestBase)

  function new(string name);
    super.new(name);
    env = new();
  endfunction

  virtual task run_test();

    $display("%m");

  endtask

endclass

`endif
