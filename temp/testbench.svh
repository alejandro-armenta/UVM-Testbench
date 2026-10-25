`ifndef TESTBENCH_SVH
`define TESTBENCH_SVH

class testbench;

  virtual tinyalu_bfm bfm;

  tester tester_h;

  coverage coverage_h;

  scoreboard scoreboard_h;

  function new(virtual tinyalu_bfm bfm);
    this.bfm = bfm;
  endfunction

  task execute();

    tester_h = new(bfm);
    coverage_h = new(bfm);
    scoreboard_h = new(bfm);

    fork
      tester_h.execute();
      coverage_h.execute();
      scoreboard_h.execute();
    join

  endtask

endclass

`endif
