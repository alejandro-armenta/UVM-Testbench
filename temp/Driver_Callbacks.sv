`ifndef DRIVER_CALLBACKS_SV
`define DRIVER_CALLBACKS_SV

`include "Scoreboard.sv"
`include "Transaction.sv"

virtual class Driver_cbs;

  virtual task pre_tx(ref BaseTR tr, ref bit drop);
  endtask

  virtual task post_tx(ref BaseTR tr);
  endtask

endclass

class Driver_cbs_drop extends Driver_cbs;

  virtual task pre_tx(ref BaseTR tr, ref bit drop);
    drop = $urandom_range(0, 99) == 0;
  endtask

endclass


class Driver_cbs_scoreboard extends Driver_cbs;

  Scoreboard scb;

  function new(Scoreboard scb);
    this.scb = scb;
  endfunction

  virtual task pre_tx(ref BaseTR tr, ref bit drop);
    Transaction trup;
    if ($cast(trup, tr)) scb.save_expected(trup);
    else
      assert (0)
      else begin
        $display("Not a transaction");
      end
  endtask


endclass

`endif
