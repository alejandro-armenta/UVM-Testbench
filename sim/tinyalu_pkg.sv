
package tinyalu_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  typedef enum bit [2:0] {
    no_op  = 3'b000,
    add_op = 3'b001,
    and_op = 3'b010,
    xor_op = 3'b011,
    mul_op = 3'b100,
    rst_op = 3'b111
  } operation_t;

  // CONIGURATIONS

  `include "env_config.svh"

  `include "tinyalu_agent_config.svh"


  // SEQUENCER

  `include "sequence_item.svh"

  typedef uvm_sequencer#(sequence_item) sequencer;


  `include "fibonacci_sequence.svh"

  `include "reset_sequence.svh"

  `include "maxmult_sequence.svh"

  `include "random_sequence.svh"


  `include "runall_sequence.svh"




  `include "result_transaction.svh"

  // STRUCTURE

  `include "coverage.svh"

  `include "scoreboard.svh"

  `include "driver.svh"

  `include "command_monitor.svh"

  `include "result_monitor.svh"

  `include "tinyalu_agent.svh"

  `include "env.svh"

  `include "tinyalu_base_test.svh"

  `include "fibonacci_test.svh"

  `include "full_test.svh"

  `include "dual_test.svh"

  `include "parallel_test.svh"


endpackage







