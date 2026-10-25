`ifndef COVERAGE_SVH
`define COVERAGE_SVH

class coverage;

  virtual tinyalu_bfm bfm;

  byte unsigned A;
  byte unsigned B;

  operation_t op_set;

  covergroup op_cov;

    coverpoint op_set {

      bins single_cycle[] = {[add_op : xor_op], no_op, rst_op};

      bins multi_cycle = {mul_op};

      bins opn_rst[] = (add_op => rst_op), (and_op => rst_op), (xor_op => rst_op), (mul_op => rst_op);

      bins rst_opn[] = (rst_op => add_op), (rst_op => and_op), (rst_op => xor_op), (rst_op => mul_op);

      bins sngl_mul[] = (add_op => mul_op), (and_op => mul_op), (xor_op => mul_op), (no_op => mul_op);

      bins mul_sngl[] = (mul_op => add_op), (mul_op => and_op), (mul_op => xor_op), (mul_op => no_op);

      bins twoops[] = (add_op => add_op), (and_op => and_op), (xor_op => xor_op), (mul_op => mul_op);

      bins manymult[] = (mul_op [* 3: 5]);

    }

  endgroup

  covergroup zeros_or_ones_on_ops;

    // aqui no esta definido el bin

    all_ops: coverpoint op_set {

      bins valid_ops[] = {add_op, and_op, xor_op, mul_op}; ignore_bins null_ops = {rst_op, no_op};

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

  // no son tipos
  // op_cov oc;
  // zeros_or_ones_on_ops zeros;
  // es como un singleton

  function new(virtual tinyalu_bfm bfm);

    this.bfm = bfm;

    op_cov = new();
    zeros_or_ones_on_ops = new();

  endfunction

  task execute();

    forever begin

      @(negedge bfm.clk);

      // aqui estas conectando las variables del coverage con las variables del bus
      A = bfm.A;
      B = bfm.B;
      op_set = bfm.op_set;

      // el sampler no puede ver el bus 

      op_cov.sample();
      zeros_or_ones_on_ops.sample();

    end

  endtask

endclass

`endif
