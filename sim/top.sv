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

  `include "op_cov.svh"

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

  op_cov oc;

  zeros_or_ones_on_ops c_00_FF;


  initial begin : clock

    clk = 0;

    forever begin

      #10;

      clk = ~clk;

    end

  end : clock

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

  `include "functions.svh"

  always @(posedge done) begin : scoreboard

    shortint unsigned predicted;

    #1;

    case (op_set)

      add_op: predicted = A + B;
      and_op: predicted = A & B;
      xor_op: predicted = A ^ B;
      mul_op: predicted = A * B;

    endcase



  end : scoreboard

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
