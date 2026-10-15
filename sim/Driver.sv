`ifndef DRIVER_SV
`define DRIVER_SV

class Driver;

  virtual X_if.TB xi;

  int id;

  function new(virtual X_if.TB xi, int id);

    this.xi = xi;
    this.id = id;

  endfunction

  task reset();

    $display("Start Reset");

    xi.reset   <= 1;
    xi.cb.load <= 0;
    xi.cb.din  <= '0;

    @(xi.cb) xi.reset <= 0;

    @(xi.cb) xi.reset <= 1;

    $display("End Reset");

  endtask

  task load_op();

    // wait for one clocking block event 

    $display("Start load");

    @(xi.cb);

    xi.cb.load <= 1;
    xi.cb.din  <= id + 10;

    @(xi.cb);

    xi.cb.load <= 0;

    repeat (5) @(xi.cb);

    $display("End load");

  endtask

endclass

`endif
