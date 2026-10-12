`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"

module automatic test_stack;

  Generator #(Transaction) gen;

  mailbox #(Transaction)   gen2drv;

  initial begin

    gen2drv = new(1);

    gen = new(gen2drv);

    fork
      // genera varios mensajes y los mando por el mailbox yo tengo que recibirlos por el mailbox usando get()
      gen.run();

      repeat (20) begin

        // bloque secuencial

        Transaction tr;

        gen2drv.get(tr);

        $display("%p", tr);

      end


    join
  end

endmodule
