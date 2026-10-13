`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"
`include "Config_Database.sv"
`include "Test_Registry.sv"


module automatic test;

  TestBase b;

  initial begin

    b = TestRegistry::get_test();

    b.run_test();

  end

endmodule

