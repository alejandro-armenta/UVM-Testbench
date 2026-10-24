
interface ale;

  byte unsigned        A;
  byte unsigned        B;

  bit                  clk;
  bit                  reset_n;
  bit                  start;

  operation_t          op_set;

  logic         [ 2:0] op;
  logic                done;
  logic         [15:0] result;

  assign op = op_set;

  initial begin : clock

    clk = 0;

    forever begin

      #10;

      clk = ~clk;

    end

  end : clock

  task reset_alu();

    reset_n = 0;

    @(negedge clk);
    // aqui pasa el reset
    @(negedge clk);

    reset_n = 1;

    start   = 0;

  endtask

  task send_op();

  endtask

endinterface
