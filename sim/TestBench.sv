`include "Driver.sv"

module automatic test #(
    NUM_XI = 2
);

  virtual X_if.TB vxi[NUM_XI];

  Driver driver[];

  initial begin

    // estas interfaces son las de arriba

    vxi = top.xi;

    driver = new[NUM_XI];

    foreach (driver[i]) driver[i] = new(vxi[i], i);

    foreach (driver[i]) begin

      automatic int j = i;

      // cada driver tiene su interface a el dut?

      fork
        begin
          driver[j].reset();
          driver[j].load_op();
        end
      join_none

    end

    repeat (10) @(vxi[0].cb);


  end
endmodule
