module top;

  typedef enum bit [2:0] {
    no_op  = 3'b000,
    add_op = 3'b001,
    and_op = 3'b010,
    xor_op = 3'b011,
    mul_op = 3'b100,
    rst_op = 3'b111
  } operation_t;

  // se definen las variables aleatorias 

  byte unsigned A;
  byte unsigned B;

  bit clk;
  bit reset_n;
  bit start;

  operation_t op_set;

  logic [2:0] op;
  logic done;
  logic [15:0] result;

  // este es un bus
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

  // se miden las stadisticas de cada variable aleatoria

  // test 0

  covergroup op_cov;

    coverpoint op_set {

      bins single_cycle[] = {[add_op : xor_op], no_op, rst_op};
      bins multi_cycle = {mul_op};

      bins opn_rst[] = ([add_op : mul_op] => rst_op);
      bins rst_opn[] = (rst_op => [add_op : mul_op]);

      bins sngl_mul[] = ([add_op : xor_op], no_op => mul_op);
      bins muk_sngl[] = (mul_op => [add_op : xor_op], no_op);

      bins twoops[] = ({add_op, and_op, xor_op, mul_op} [* 2]);
      bins manymult[] = ({mul_op} [* 3: 5]);

    }

  endgroup


  // test 1

  covergroup zeros;

    coverpoint op_set {ignore_bins null_ops = {rst_op, no_op};}

    coverpoint A {bins zeros = {'h00}; bins other = {['h01 : 'hFE]}; bins ones = {'hFF};}

  endgroup

endmodule
