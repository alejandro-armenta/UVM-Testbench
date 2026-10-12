`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"
`include "config_database.sv"

module automatic test;

  config_db #(int) a;

  initial begin

    a = new();

    a.set("ale", 2);

    $display("%p", a);

  end
endmodule

