module top;

  tinyalu_bfm bfm ();

  // este hace escritura al bfm
  tester t (bfm);

  // esta madre solo es de lectura
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

endmodule


