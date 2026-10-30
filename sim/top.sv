module top;

  import uvm_pkg::*;
  import tinyalu_pkg::*;

  `include "uvm_macros.svh"


tinyalu_bfm class_bfm ();

  tinyalu class_dut (

      .A (class_bfm.A),
      .B (class_bfm.B),
      .op(class_bfm.op),

      .clk(class_bfm.clk),
      .reset_n(class_bfm.reset_n),
      .start(class_bfm.start),

      .done  (class_bfm.done),
      .result(class_bfm.result)
  );

  // /////////////////////////////////////////////////////

  tinyalu_bfm module_bfm ();

  tinyalu module_dut (

      .A (module_bfm.A),
      .B (module_bfm.B),
      .op(module_bfm.op),

      .clk(module_bfm.clk),
      .reset_n(module_bfm.reset_n),
      .start(module_bfm.start),

      .done  (module_bfm.done),
      .result(module_bfm.result)
  );

  // este modulo controla el dut

  tinyalu_tester_module stim_module (module_bfm);

  initial begin

    // solo vas a ver el del modulo y el otro lo vas a accionar con un tester instanciador y el otro no va a tener tester porqu eel tester esta aca.

    uvm_config_db#(virtual interface tinyalu_bfm)::set(null, "*", "class_bfm", class_bfm);
    uvm_config_db#(virtual interface tinyalu_bfm)::set(null, "*", "module_bfm", module_bfm);

    run_test();

  end

endmodule


