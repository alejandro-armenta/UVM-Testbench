`ifndef TOP_SV
`define TOP_SV

`timescale 1ns / 1ps

module top;

  parameter NUM_XI = 2;
  parameter BIT_WIDTH = 3;

  bit clk;

  initial begin
    clk <= '0;
    forever #5 clk = ~clk;
  end

  X_if #(.BIT_WIDTH(BIT_WIDTH)) xi[NUM_XI] (clk);

  test #(
      .NUM_XI(NUM_XI),
      .BIT_WIDTH(BIT_WIDTH)
  ) tb ();

  generate

    for (genvar i = 0; i < NUM_XI; i++) begin : counter_gen

      counter #(.BIT_WIDTH(BIT_WIDTH)) c (xi[i]);

    end

  endgenerate

endmodule

`endif
