
`ifndef TEST_REGISTRY_SV
`define TEST_REGISTRY_SV

`include "Transaction.sv"

typedef class TestRegistry;

virtual class TestComponent;

  pure virtual task run_test();

endclass

class TestBase #(

    type T = Transaction

) extends TestComponent;

  Environment #(T) env;

  function new();

    env = new();

  endfunction

  virtual task run_test();

  endtask

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

TestBad #(BadTransaction) TestBad_Handle = new();

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

  static function void display();

    foreach (registry[i]) $display("key=%s value=%p", i, registry[i]);

  endfunction

endclass


`endif
