`ifndef COVERAGE_SV
`define COVERAGE_SV

module coverage (
    tinyalu_bfm bfm
);

  import tinyalu_pkg::*;

  byte unsigned A;
  byte unsigned B;

  operation_t   op_set;

  `include "op_cov.svh"

op_cov oc;

  zeros_or_ones_on_ops c_00_FF;

  initial begin : coverage_block

    oc = new();
    c_00_FF = new();

    forever begin

      @(negedge bfm.clk);

      // aqui estas conectando las variables del coverage con las variables del bus
      A = bfm.A;
      B = bfm.B;
      op_set = bfm.op_set;

      // el sampler no puede ver el bus 

      oc.sample();
      c_00_FF.sample();

    end

  end

endmodule

`endif
