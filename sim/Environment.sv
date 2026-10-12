`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"

// class Environment;

//   Generator gen;
//   Driver drv;

//   mailbox #(BaseTR) gen2drv;

//   mailbox #(BaseTR) agent2drv;

//   virtual function void build(BaseTR blueprint);

//     this.gen2drv = new();

//     this.agent2drv = new();

//     this.gen = new(this.gen2drv, blueprint);

//     this.drv = new(this.gen2drv, agent2drv);

//   endfunction

//   // se lo cambiaste aqui

//   virtual task run();

//     fork
//       gen.run();
//       drv.run();
//     join

//   endtask

//   virtual task wrap_up();
//     // call scoreboard for report
//   endtask

// endclass

`endif
