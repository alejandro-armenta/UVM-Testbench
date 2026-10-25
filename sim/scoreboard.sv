class scoreboard;

  virtual tinyalu_bfm bfm;

  function new(virtual tinyalu_bfm bfm);

    this.bfm = bfm;

  endfunction


endclass

module scoreboard (
    tinyalu_bfm bfm
);

  import tinyalu_pkg::*;

  always @(posedge bfm.done) begin : scoreboard

    shortint unsigned predicted;

    #1;

    case (bfm.op_set)

      add_op: predicted = bfm.A + bfm.B;
      and_op: predicted = bfm.A & bfm.B;
      xor_op: predicted = bfm.A ^ bfm.B;
      mul_op: predicted = bfm.A * bfm.B;

    endcase

    if (predicted != bfm.result) begin

      $error("Failed %0t A: %0h B: %0h op: %s result: %0h predicted: %0h", $time, bfm.A, bfm.B,
             bfm.op_set.name(), bfm.result, predicted);

    end else begin

      $display("SUCCESS %0t A: %0h B: %0h op: %s result: %0h predicted: %0h", $time, bfm.A, bfm.B,
               bfm.op_set.name(), bfm.result, predicted);

    end

  end : scoreboard


endmodule
