
typedef svm_factory;

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

// this is a singleton
// esta cosa crea objetos de tipo generico T

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


  static function T create(string name);

    T obj;

    obj = new(name);

    return obj;

  endfunction


endclass

class svm_factory;

  static svm_object_wrapper dict[string];

  static svm_factory m_inst;

  static function svm_factory get();

    if (m_inst == null) m_inst = new();

    return m_inst;

  endfunction

  static function void register(svm_object_wrapper c);

    dict[c.get_type_name()] = c;

  endfunction

endclass
