`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "Utils.sv"
`include "Transaction.sv"

virtual class GenBase;
  pure virtual task run(int num_tr = 10);
endclass


class Generator #(
    type T = BaseTR
) extends GenBase;

  mailbox #(Transaction) gen2drv;
  T blueprint;

  function new(mailbox#(Transaction) gen2drv);

    this.gen2drv   = gen2drv;

    this.blueprint = new();

    // $display("Blueprint type: %s", $typename(this.blueprint));

  endfunction

  virtual task run(int num_tr = 10);

    T other;

    repeat (num_tr) begin

      `SV_RAND_CHECK(blueprint.randomize);

      // es de tipo base necesitas regresarlo al tipo donde era
      $cast(other, blueprint.copy());

      $display("Other type: %s", $typename(other));

      gen2drv.put(other);

    end

  endtask

endclass

`endif
