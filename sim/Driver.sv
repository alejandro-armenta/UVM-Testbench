`ifndef DRIVER_SV
`define DRIVER_SV

`include "x_if.sv"

class Driver #(
    parameter BIT_WIDTH = 8
);

  virtual X_if #(.BIT_WIDTH(BIT_WIDTH)).TB xi;

  int id;

  function new(virtual X_if #(.BIT_WIDTH(BIT_WIDTH)).TB xi, int id);

    this.xi = xi;
    this.id = id;

  endfunction

  task reset();

    $display("%t %d Start Reset", $time, id);

    xi.reset   <= 1;
    xi.cb.load <= 0;
    xi.cb.din  <= '0;

    @(xi.cb) xi.reset = 0;

    @(xi.cb) xi.reset = 1;

    $display("%t %d End Reset", $time, id);

  endtask

  task load_op();

    $display("%t %d Start Load", $time, id);

    repeat (3) @(xi.cb);

    xi.cb.load <= 1;
    xi.cb.din  <= id + 10;

    @(xi.cb);

    xi.cb.load <= 0;

    repeat (5) @(xi.cb);

    $display("%t %d End Load", $time, id);

  endtask

endclass

`endif
