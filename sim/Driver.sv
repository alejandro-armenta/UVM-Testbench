`ifndef DRIVER_SV
`define DRIVER_SV

`include "Transaction.sv"

class Driver #(
    type T = BaseTR
);

  Driver_cbs cbs[$];

  mailbox #(T) gen2drv;

  mailbox #(T) agent2drv;

  function new(mailbox#(T) gen2drv, mailbox#(T) agent2drv);

    this.gen2drv   = gen2drv;

    this.agent2drv = agent2drv;

  endfunction

  virtual task transmit(T tr);

  endtask

  virtual task run();

    // bit drop;

    // BaseTR tr;

    // forever begin

    //   drop = 0;

    //   agent2drv.get(tr);

    //   foreach (cbs[i]) begin
    //     cbs[i].pre_tx(tr, drop);
    //   end

    //   if (drop) continue;

    //   transmit(tr);

    //   foreach (cbs[i]) begin
    //     cbs[i].post_tx(tr);
    //   end

    // end

  endtask

endclass

`endif
