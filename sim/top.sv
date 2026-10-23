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

  byte unsigned        A;
  byte unsigned        B;

  bit                  clk;
  bit                  reset_n;
  bit                  start;

  operation_t          op_set;

  logic         [ 2:0] op;
  logic                done;
  logic         [15:0] result;

  // este es un bus
  assign op = op_set;

  tinyalu dut (
      .A      (A),
      .B      (B),
      .op     (op),
      .clk    (clk),
      .reset_n(reset_n),
      .start  (start),
      .done   (done),
      .result (result)
  );

  `include "test.svh"

  covergroup zeros_or_ones_on_ops;

    // aqui no esta definido el bin

    all_ops: coverpoint op_set {
      ignore_bins null_ops = {rst_op, no_op};
    }

    // toma ese valor
    a_leg: coverpoint A {
      bins zeros = {'h00}; bins others = {['h01 : 'hFE]}; bins ones = {'hFF};
    }

    // toma ese valor
    b_leg: coverpoint B {
      bins zeros = {'h00}; bins others = {['h01 : 'hFE]}; bins ones = {'hFF};
    }

    // 36 combinanciones
    cross a_leg, b_leg, all_ops{

      bins add_00            = binsof (all_ops) intersect {add_op} && (binsof (a_leg.zeros) || binsof (b_leg.zeros));

      bins add_FF            = binsof (all_ops) intersect {add_op} && (binsof (a_leg.ones) || binsof(b_leg.ones));

      bins and_00            = binsof (all_ops) intersect {and_op} && (binsof (a_leg.zeros) || binsof(b_leg.zeros));

      bins and_FF            = binsof (all_ops) intersect {and_op} && (binsof (a_leg.ones) || binsof(b_leg.ones));

      bins xor_00            = binsof (all_ops) intersect {xor_op} && (binsof (a_leg.zeros) || binsof(b_leg.zeros));

      bins xor_FF            = binsof (all_ops) intersect {xor_op} && (binsof (a_leg.ones) || binsof(b_leg.ones));

      bins mul_00            = binsof (all_ops) intersect {mul_op} && (binsof (a_leg.zeros) || binsof(b_leg.zeros));

      bins mul_FF            = binsof (all_ops) intersect {mul_op} && (binsof (a_leg.ones) || binsof(b_leg.ones));

      bins mul_max           = binsof (all_ops) intersect {mul_op} && (binsof (a_leg.ones) && binsof(b_leg.ones));

      ignore_bins other_only = binsof (a_leg.others) && binsof (b_leg.others);

    }

  endgroup

  initial begin
    clk = 0;
    forever begin
      #10;
      clk = ~clk;
    end
  end

  op_cov oc;

  zeros_or_ones_on_ops c_00_FF;


  initial begin : coverage

    oc = new();

    c_00_FF = new();

    forever begin

      @(negedge clk);

      // para que lea las senales estables

      oc.sample();
      c_00_FF.sample();

    end

  end : coverage


  function operation_t get_op();

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

  function byte get_data();

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


  initial begin : tester

    reset_n = 0;

    @(negedge clk);
    // aqui pasa el reset
    @(negedge clk);

    reset_n = 1;
    start   = 0;

    repeat (20) begin

      @(negedge clk);

      op_set = get_op();

      A = get_data();

      B = get_data();

      start = 1'b1;

      $displayb(op_set,, A,, B);

      case (op_set)

        no_op: begin

          @(posedge clk);

          start = 0;

          // done nunca se levanta y result es zero

        end

        rst_op: begin

          reset_n = 0;
          start   = 0;

          @(negedge clk);

          reset_n = 1;

        end

        default: begin
          wait (done);
          start = 0;
        end

      endcase

    end

    $stop;

  end : tester

endmodule


function ale();

endfunction
