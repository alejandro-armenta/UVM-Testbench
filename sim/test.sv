`include "Transaction.sv"
`include "Environment.sv"
`include "Driver_Callbacks.sv"
`include "Stack.sv"


module automatic test;

  mailbox #(Transaction) gen2drv;

  GenBase gen_queue[$];

  Generator #(Transaction) a;

  Generator #(Nearby) b;

  Generator #(BadTransaction) c;

  initial begin

    gen2drv = new();

    a = new(gen2drv);

    b = new(gen2drv);

    c = new(gen2drv);

    gen_queue.push_back(a);

    gen_queue.push_back(b);

    gen_queue.push_back(c);

    foreach (gen_queue[i]) begin
      automatic int e = i;
      fork
        gen_queue[e].run();
      join
    end

    // tengo 3 generadores y tienen el mismo mailbox

  end
endmodule

