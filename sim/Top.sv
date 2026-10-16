`ifndef TOP_SV
`define TOP_SV

`timescale 1ns / 1ps

parameter NUM_XI = 2;

module top;

  bit clk;

  initial begin
    clk <= '0;
    forever #5 clk = ~clk;
  end

  X_if xi[NUM_XI] (clk);

  test tb (xi);

  generate

    for (genvar i = 0; i < NUM_XI; i++) begin : counter_gen

      counter c (xi[i]);

    end

  endgenerate

endmodule

`endif
