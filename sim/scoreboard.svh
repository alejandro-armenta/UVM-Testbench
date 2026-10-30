
class scoreboard extends uvm_subscriber #(result_transaction);

  // este es un sink y llega desde el ap de result monitor

  `uvm_component_utils(scoreboard)

  // command monitor sink

  uvm_tlm_analysis_fifo #(command_transaction) cmd_f;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  function void build_phase(uvm_phase phase);
    cmd_f = new("cmd_f", this);
  endfunction

  function compare(command_transaction cmd, result_transaction predicted,
                   result_transaction result);

    string data_str;

    if (cmd == null || predicted == null || result == null)
      `uvm_fatal("SCOREBOARD", "Invalid value to compare.")


    data_str = {

      cmd.convert2string(),

      " ===> Actual ",

      result.convert2string(),

      " Predicted ",

      predicted.convert2string()

    };

    if (!predicted.compare(result)) `uvm_fatal("SCOREBOARD", {"\nFAIL ", data_str})

    else `uvm_info("SCOREBOARD", {"\nPASS ", data_str}, UVM_MEDIUM)

  endfunction : compare

  function result_transaction predict_result(command_transaction cmd);

    result_transaction predicted;

    predicted = new("predicted");

    case (cmd.op)

      add_op: predicted.result = cmd.A + cmd.B;
      and_op: predicted.result = cmd.A & cmd.B;
      xor_op: predicted.result = cmd.A ^ cmd.B;
      mul_op: predicted.result = cmd.A * cmd.B;

    endcase

    return predicted;

  endfunction

  function void write(result_transaction t);

    result_transaction  predicted;
    command_transaction cmd;

    do begin

      if (!cmd_f.try_get(cmd)) `uvm_fatal("SCOREBOARD", "No command in self checker")

    end while ((cmd.op == no_op) || (cmd.op == rst_op));

    predicted = this.predict_result(cmd);

    void'(this.compare(cmd, predicted, t));

  endfunction : write

endclass : scoreboard
