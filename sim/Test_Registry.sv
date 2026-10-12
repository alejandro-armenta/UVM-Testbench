virtual class TestBase;

  Environment env;

  pure virtual task run_test();

  function new();
    env = new();
  endfunction

endclass


class TestRegistry;

  TestBase registry[string];

  function void register(string name, TestBase t);
    registry[name] = t;
  endfunction

  function TestBase get_test();

    string name;

    if (!$value$plusargs("TESTNAME=%s", name)) begin
      $display("Error no TESTNAME switch found");
      $finish;
    end

    return registry[name];

  endfunction

endclass
