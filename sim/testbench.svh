class testbench;

  virtual tinyalu_bfm bfm;

  tester tester_h;

  function new(virtual tinyalu_bfm bfm);
    this.bfm = bfm;
  endfunction

endclass
