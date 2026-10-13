`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"
`include "Config_Database.sv"
`include "Test_Registry.sv"


module automatic test;

  TestComponent b;

  initial begin

    TestRegistry::display();

  end

endmodule

