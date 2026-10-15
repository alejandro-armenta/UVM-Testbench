module top;

  parameter NUM_XI = 2;

  bit clk;

  initial begin
    clk <= '0;

    forever #20 clk = ~clk;
  end

  X_if xi[NUM_XI] (clk);

  // multiple drivers con una interace de aqui 
  test #(.NUM_XI(NUM_XI)) tb ();

  generate

for (int i=0;i<NUM_XI;i++)begin end
  endgenerate

endmodule
