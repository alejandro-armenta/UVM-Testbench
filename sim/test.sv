`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"

module automatic test;

  Environment env;

  Transaction tr;

  Scoreboard  scb;

  initial begin
    env = new();

    scb = new();

    tr  = new();

    env.build(tr);

    begin

      Driver_cbs_scoreboard dcs = new(scb);
      env.drv.cbs.push_back(dcs);

    end

    env.run();

    env.wrap_up();

  end

endmodule
