`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

class scoreboard;

  virtual tinyalu_bfm bfm;

  function new(virtual tinyalu_bfm bfm);

    this.bfm = bfm;

  endfunction

  task execute();

    shortint unsigned predicted;

    forever begin

      @(posedge bfm.done);

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

        $display("SUCCESS %0t A: %0h B: %0h op: %s result: %0h predicted: %0h", $time, bfm.A,
                 bfm.B, bfm.op_set.name(), bfm.result, predicted);

      end

    end

  endtask : execute

endclass

`endif
