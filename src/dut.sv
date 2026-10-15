module counter (
    X_if.DUT xi
);

  always @(posedge xi.clk or negedge xi.reset) begin

    // it changes from 1 to 0 por eso tengo que checar zero

    if (!xi.reset) xi.dout <= '0;
    else if (xi.load) xi.dout <= xi.din;
    else xi.dout <= xi.dout + 1;

  end

endmodule

