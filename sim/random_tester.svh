`ifndef TESTER_SVH
`define TESTER_SVH

class random_tester extends base_tester;

  `uvm_component_utils(random_tester)

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction : new

  virtual function operation_t get_op();

    bit [2:0] op_choice;

    // this truncates into 3 bits
    op_choice = $random;

    case (op_choice)

      3'b000: return no_op;

      3'b001: return add_op;

      3'b010: return and_op;

      3'b011: return xor_op;

      3'b100: return mul_op;

      3'b101: return no_op;

      3'b110: return rst_op;

      3'b111: return rst_op;

    endcase

  endfunction : get_op

  virtual function byte get_data();

    bit [1:0] zero_ones;

    zero_ones = $random;

    // para que sea mas probable 00 y 11
    if (zero_ones == 2'b00) begin

      return 8'h00;

    end else if (zero_ones == 2'b11) begin

      return 8'hFF;

    end else begin

      return $random;

    end

  endfunction : get_data

endclass : random_tester

`endif
