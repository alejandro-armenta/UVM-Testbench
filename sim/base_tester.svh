virtual class base_tester extends uvm_component;

  `uvm_component_utils(base_tester);

  virtual tinyalu_bfm bfm;

  function new(string name, uvm_component parent);

    super.new(name, parent);

  endfunction

  pure virtual function operation_t get_op();

  pure virtual function byte get_data();

  function void build_phase(uvm_phase phase);

    if (!uvm_config_db#(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))

      $fatal(2, "Couldnt get pointer to bfm");

  endfunction : build_phase


  task run_phase(uvm_phase phase);

    byte unsigned A;
    byte unsigned B;

    operation_t   op_set;

    phase.raise_objection(this);

    bfm.reset_alu();

    repeat (1000) begin : random_loop

      op_set = get_op();

      A = get_data();

      B = get_data();

      bfm.send_op(A, B, op_set);

    end : random_loop

    #500;

    phase.drop_objection(this);

  endtask : run_phase


endclass
