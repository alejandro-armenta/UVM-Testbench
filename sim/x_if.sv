interface X_if (
    input logic clk
);

  logic [7:0] din, dout;

  logic reset, load;

  clocking cb @(posedge clk);

    output din, load;

    input dout;

  endclocking

  modport DUT(input clk, din, reset, load, output dout);

  modport TB(clocking cb, output reset);

endinterface
