`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`include "Transaction.sv"

class Scoreboard;

  // expected transactions 
  Transaction scb[$];

  function void save_expected(Transaction tr);

    scb.push_back(tr);

  endfunction

  function void compare_equal(Transaction tr);

    int q[$];

    q = scb.find_index(x) with (x.src == tr.src);

    case (q.size())
      0: $display("No match found");
      1: scb.delete(q[0]);
      default: $display("Error, multiple matches found");
    endcase

  endfunction

endclass

`endif
