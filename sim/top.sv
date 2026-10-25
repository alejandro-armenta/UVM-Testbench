module top;

  import tinyalu_pkg::*;

  tinyalu_bfm bfm ();

  tester t;

  coverage c (bfm);

  scoreboard s (bfm);

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

  end

endmodule


