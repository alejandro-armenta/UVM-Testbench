
`ifndef TRANSACTION_SV
`define TRANSACTION_SV


`include "Utils.sv"

virtual class BaseTR;

  static int count;
  int id;

  function new();
    id = count++;
  endfunction

  pure virtual function bit compare(BaseTR to);

  pure virtual function BaseTR copy(BaseTR to = null);

  pure virtual function void display();

endclass

class Transaction extends BaseTR;

  rand bit [31:0] src, dst, data[8], csm;

  extern function new();

  extern virtual function bit compare(BaseTR to);

  extern virtual function BaseTR copy(BaseTR to = null);

  extern virtual function void display();

endclass

function Transaction::new();
  super.new();
endfunction

function bit Transaction::compare(BaseTR to);

  Transaction tr;

  if ($cast(tr, to)) begin
    $finish;
  end else begin
    bit a = (
    
    this.src == tr.src && 
      this.dst == tr.dst && 
      this.csm == tr.csm && 
      this.data == tr.data 
      );

    return a;

  end

endfunction

function BaseTR Transaction::copy(BaseTR to = null);

  Transaction tr;

  if (to == null) tr = new();
  else $cast(tr, to);

  tr.src  = this.src;
  tr.dst  = this.dst;
  tr.data = this.data;
  tr.csm  = this.csm;

  return tr;

endfunction

function void Transaction::display();
  $display("Transaction %0d src=%0h dst=%0x csm=%0x", id, src, dst, csm);
endfunction


class Nearby extends Transaction;

  constraint c {dst inside {[src - 100 : src + 100]};}

  extern function new();

  extern virtual function bit compare(BaseTR to);

  extern virtual function BaseTR copy(BaseTR to = null);

  extern virtual function void display();

endclass

function Nearby::new();
  super.new();
endfunction

function bit Nearby::compare(BaseTR to);
  return super.compare(to);
endfunction

function BaseTR Nearby::copy(BaseTR to = null);
  Nearby nb;
  if (to == null) nb = new();
  else $cast(nb, to);
  void'(super.copy(nb));
  return nb;

endfunction

function void Nearby::display();
  super.display();
endfunction

class BadTransaction extends Transaction;

  rand bit bad_csm;

  extern function new();

  extern virtual function bit compare(BaseTR to);

  extern virtual function BaseTR copy(BaseTR to = null);

  extern virtual function void display();

endclass

function BadTransaction::new();
  super.new();
endfunction

function bit BadTransaction::compare(BaseTR to);

  BadTransaction tr;

  if ($cast(tr, to)) begin
    $finish;
  end

  if (!super.compare(tr)) begin
    $finish;
  end

  return this.bad_csm == tr.bad_csm;

endfunction

function BaseTR BadTransaction::copy(BaseTR to = null);

  BadTransaction bad;

  if (to == null) bad = new();
  else $cast(bad, to);

  void'(super.copy(bad));

  bad.bad_csm = this.bad_csm;

  return bad;

endfunction

function void BadTransaction::display();

  $write("%b\n", bad_csm);
  super.display();

endfunction

`endif
