`ifndef DRIVER_SV
`define DRIVER_SV

`include "Transaction.sv"


// como estan separados tienes que mandar informacion a otro proceso
// no me puedo conectar con memoria shared.

// a transactor is designed for a single source.

// use callbacks

// tlm analysis port for connecting monitors to scoreboards 
// a mailbox with an optional consumer 


class Driver;

  Driver_cbs cbs[$];

  mailbox #(BaseTR) gen2drv;

  mailbox #(BaseTR) agent2drv;

  function new(mailbox#(BaseTR) gen2drv, mailbox#(BaseTR) agent2drv);

    this.gen2drv   = gen2drv;
    this.agent2drv = agent2drv;

  endfunction

  virtual task transmit(BaseTR tr);

  endtask

  virtual task run();

    bit drop;

    BaseTR tr;

    forever begin

      drop = 0;

      agent2drv.get(tr);

      foreach (cbs[i]) begin
        cbs[i].pre_tx(tr, drop);
      end

      if (drop) continue;

      transmit(tr);

      foreach (cbs[i]) begin
        cbs[i].post_tx(tr);
      end

    end

  endtask

endclass

`endif
