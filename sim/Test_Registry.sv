
`ifndef TEST_REGISTRY_SV
`define TEST_REGISTRY_SV


typedef class TestRegistry;


virtual class TestBase;

  Environment env;

  pure virtual task run_test();

  function new();
    env = new();
  endfunction

endclass

class TestSimple extends TestBase;

  function new();

    super.new();

    TestRegistry::register("TestSimple", this);

  endfunction

  virtual task run_test();

    $display("%m");

    env.build();
    env.run();
    env.wrap_up();

  endtask

endclass

TestSimple TestSimple_handle = new();

class TestRegistry;

  static TestBase registry[string];

  static function void register(string name, TestBase t);

    registry[name] = t;

  endfunction

  static function TestBase get_test();

    string name;

    if (!$value$plusargs("TESTNAME=%s", name)) begin
      $display("Error no TESTNAME switch found");
      $finish;
    end

    return registry[name];

  endfunction

endclass


`endif
