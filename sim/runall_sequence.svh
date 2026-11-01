class runall_sequence extends uvm_sequence #(sequence_item);

  `uvm_object_utils(runall_sequence)

  reset_sequence reset_h;

  maxmult_sequence maxmult_h;

  sequencer sequencer_h;


  function new(string name = "");

    uvm_component uvm_component_h;

    super.new(name);

    uvm_component_h = uvm_top.find("*.agent_h.sequencer_h");

    if (uvm_component_h == null) `uvm_fatal("RUNALL_SEQUENCE", "");

    if (!$cast(this.sequencer_h, uvm_component_h)) `uvm_fatal("RUNALL_SEQUENCE", "");

    this.reset_h   = reset_sequence::type_id::create("reset");

    this.maxmult_h = maxmult_sequence::type_id::create("maxmult");

  endfunction

  task body();

    this.reset_h.start(this.sequencer_h);

    this.maxmult_h.start(this.sequencer_h);

  endtask

endclass
