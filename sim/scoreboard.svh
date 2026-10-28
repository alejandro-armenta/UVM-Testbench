`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

class scoreboard extends uvm_subscriber #(shortint unsigned);

  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(command_s) cmd_f;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);
    cmd_f = new("cmd_f", this);
  endfunction

  function void write(shortint unsigned t);

    shortint unsigned predicted;
    command_s cmd;

    do begin
      if (!cmd_f.try_get(cmd)) $fatal(2, "No command in self checker");
    end while ((cmd.op == no_op) || (cmd.op == rst_op));

    case (cmd.op)

      add_op: predicted = cmd.A + cmd.B;
      and_op: predicted = cmd.A & cmd.B;
      xor_op: predicted = cmd.A ^ cmd.B;
      mul_op: predicted = cmd.A * cmd.B;

    endcase

    if (predicted != t)
      $fatal(
          2,
          "Failed %0t A: %0h B: %0h op: %s result: %0h predicted: %0h",
          $time,
          cmd.A,
          cmd.B,
          cmd.op.name(),
          t,
          predicted
      );
    else
      $display(
          "SUCCESS %0t A: %0h B: %0h op: %s result: %0h predicted: %0h",
          $time,
          cmd.A,
          cmd.B,
          cmd.op.name(),
          t,
          predicted
      );
  endfunction : write

endclass : scoreboard

`endif
