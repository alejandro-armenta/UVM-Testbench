covergroup op_cov;

    coverpoint op_set {

      bins single_cycle[] = {[add_op : xor_op], no_op, rst_op};
      bins multi_cycle    = {mul_op};

      bins opn_rst[]      = ([add_op : mul_op] => rst_op);
      bins rst_opn[]      = (rst_op => [add_op : mul_op]);

      bins sngl_mul[]     = ([add_op : xor_op], no_op => mul_op);
      bins muk_sngl[]     = (mul_op => [add_op : xor_op], no_op);

      bins twoops[]       = ([add_op:mul_op] [* 2]);

      bins manymult[]     = (mul_op [* 3: 5]);

    }

  endgroup
