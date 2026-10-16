

`timescale 1ns / 1ps

module counter (
    X_if.DUT xi
);

  logic [7:0] count;

  assign xi.dout = count;

  always @(posedge xi.clk or negedge xi.reset) begin

    if (!xi.reset) count <= '0;
    else if (xi.load) count <= xi.din;
    else count <= count + 1;

  end

endmodule

