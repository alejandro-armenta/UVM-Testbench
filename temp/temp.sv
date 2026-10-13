`ifndef TEST_REGISTRY_SV
`define TEST_REGISTRY_SV

`include "Transaction.sv"

typedef class TestRegistry;

// 1. Introduce a non-parameterized base class for the registry to hold
virtual class TestComponent;
  pure virtual task run_test();
endclass

// 2. Derive your parameterized test base from the non-parameterized class
virtual class TestBase #(
  type T = Transaction
) extends TestComponent;

  Environment #(T) env;

  function new();
    env = new();
  endfunction
endclass

class TestSimple #(
  type T = Transaction
) extends TestBase #(T);

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

TestSimple #(Transaction) TestSimple_handle = new();

class TestBad #(
  type T = Transaction
) extends TestBase #(T);

  function new();
    super.new();
    TestRegistry::register("TestBad", this);
  endfunction

  virtual task run_test();
    $display("%m");
    env.build();
    env.run();
    env.wrap_up();
  endtask
endclass

// Instantiating with a different type now safely upcasts to TestComponent
TestBad #(BadTransaction) TestBad_Handle = new();

// 3. Update Registry to use the non-parameterized type
class TestRegistry;
  static TestComponent registry[string];

  static function void register(string name, TestComponent t);
    registry[name] = t;
  endfunction

  static function TestComponent get_test();
    string name;
    if (!$value$plusargs("TESTNAME=%s", name)) begin
      $display("Error no TESTNAME switch found");
      $finish;
    end
    return registry[name];
  endfunction
endclass

`endif
