`include "Driver.sv"

program automatic test #(
    parameter NUM_XI = 2
);

  virtual X_if.TB vxi[NUM_XI];

  Driver driver[];

  initial begin

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
