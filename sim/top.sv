module top;

  typedef enum bit [2:0] {
    no_op  = 3'b000,
    add_op = 3'b001,
    and_op = 3'b010,
    xor_op = 3'b011,
    mul_op = 3'b100,
    rst_op = 3'b111
  } operation_t;


  byte unsigned A;
  byte unsigned B;

  bit clk;
  bit reset_n;
  bit start;

  operation_t op_set;

  logic [2:0] op;
  logic done;
  logic [15:0] result;

  assign op = op_set;

  tinyalu dut (
      .A(A),
      .B(B),
      .op(op),
      .clk(clk),
      .reset_n(reset_n),
      .start(start),
      .done(done),
      .result(result)
  );

endmodule
