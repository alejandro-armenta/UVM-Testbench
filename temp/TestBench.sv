
`ifndef TESTBENCH_SV
`define TESTBENCH_SV

// `include "Top.sv"
`include "Driver.sv"

program automatic test #(
    parameter NUM_XI = 2,
    parameter BIT_WIDTH = 8
);

  virtual X_if #(.BIT_WIDTH(BIT_WIDTH)).TB vxi[NUM_XI];

  Driver #(.BIT_WIDTH(BIT_WIDTH)) driver[];

  initial begin

    // todo you are here
    vxi = top.xi;

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
