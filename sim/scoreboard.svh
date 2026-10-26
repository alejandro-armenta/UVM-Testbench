`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

class scoreboard extends uvm_component;

  `uvm_component_utils(scoreboard)

  virtual tinyalu_bfm bfm;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
      $fatal(2, "Couldnt get pointer to bfm");

  endfunction : build_phase

  task run_phase(uvm_phase phase);

    shortint unsigned predicted;

    forever begin : self_checker

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

    end : self_checker

  endtask : run_phase


endclass : scoreboard

`endif
