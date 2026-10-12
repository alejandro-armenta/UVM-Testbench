`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"

module automatic test_stack;

  real b;

  Stack #(real) a;

  initial begin

    a = new();

    for (int i = 0; i < a.SIZE; ++i) a.push(real'(i));

    for (int i = 0; i < a.SIZE; ++i) $display("%f", a.pop());

  end


endmodule
