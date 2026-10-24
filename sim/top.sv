module top;

  tinyalu_bfm bfm ();

  // este hace escritura al bfm
  tester t (bfm);

  // esta madre solo es de lectura
  coverage c (bfm);

  

endmodule


