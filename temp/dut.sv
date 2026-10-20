`timescale 1ns / 1ps

module counter #(
    parameter BIT_WIDTH = 8
) (
    X_if.DUT xi
);

  always @(posedge xi.clk or negedge xi.reset) begin

    if (!xi.reset) xi.dout <= '0;
    else if (xi.load) xi.dout <= xi.din;
    else xi.dout <= xi.dout + 1;

  end

endmodule
