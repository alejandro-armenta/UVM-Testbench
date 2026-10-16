`timescale 1ns / 1ps

module top;

  parameter NUM_XI = 2;

  bit clk;

  initial begin
    clk <= '0;
    forever #5 clk = ~clk;
  end

  X_if xi[NUM_XI] (clk);

  test #(.NUM_XI(NUM_XI)) tb ();

  generate

    for (genvar i = 0; i < NUM_XI; i++) begin : counter_gen

      counter c (xi[i]);

    end

  endgenerate

endmodule
