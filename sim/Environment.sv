`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"

class Environment;

  Generator #(Transaction) gen;

  Driver drv;

  mailbox #(Transaction) gen2drv;

  mailbox #(BaseTR) agent2drv;

  virtual function void build();

    this.gen2drv = new();

    this.agent2drv = new();

    this.gen = new(this.gen2drv);

    this.drv = new(this.gen2drv, agent2drv);

  endfunction

  virtual task run();

    fork
      gen.run();
      drv.run();
    join

  endtask

  virtual task wrap_up();
    // call scoreboard for report
  endtask

endclass

`endif
