
`ifndef TESTBENCH_SV
`define TESTBENCH_SV

`include "Top.sv"
`include "Driver.sv"

program automatic test (
    X_if xi[NUM_XI]
);

  vx_if vxi[NUM_XI];

  Driver driver[];

  initial begin

    vxi = xi;

    driver = new[NUM_XI];

    foreach (driver[i]) driver[i] = new(vxi[i], i);

    foreach (driver[i]) begin
      automatic int j = i;
      fork
        begin
          driver[j].reset();
          driver[j].load_op();
        end
      join
    end

  end

endprogram

`endif
