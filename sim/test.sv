`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"
`include "config_database.sv"

module automatic test;

  class Tiny;
    int i;
  endclass

  typedef config_db#(int) db_int;
  typedef config_db#(real) db_real;
  typedef config_db#(Tiny) db_tiny;

  int  x_;
  real x;

  Tiny t;
  Tiny otherT;

  initial begin

    t = new();

    db_int::set("i", 42);

    db_real::set("pi", 22.0 / 7.0);

    db_tiny::set("t", t);

    db_tiny::get("t", otherT);

    db_real::get("pi", x);

    db_int::get("pi", x_);

    $display("%p", otherT);

  end
endmodule

