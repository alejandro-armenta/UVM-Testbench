module top;

  import tinyalu_pkg::*;

  tinyalu_bfm bfm ();

  testbench t;

  tinyalu DUT (

      .A (bfm.A),
      .B (bfm.B),
      .op(bfm.op),

      .clk(bfm.clk),
      .reset_n(bfm.reset_n),
      .start(bfm.start),

      .done  (bfm.done),
      .result(bfm.result)
  );

  initial begin

    t = new(bfm);

    t.execute();

  end

endmodule


