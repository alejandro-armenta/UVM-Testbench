module top;

  typedef enum bit [2:0] {
    no_op  = 3'b000,
    add_op = 3'b001,
    and_op = 3'b010,
    xor_op = 3'b011,
    mul_op = 3'b100,
    rst_op = 3'b111
  } operation_t;

  // se definen las variables aleatorias

  byte unsigned        A;
  byte unsigned        B;

  bit                  clk;
  bit                  reset_n;
  bit                  start;

  operation_t          op_set;

  logic         [ 2:0] op;
  logic                done;
  logic         [15:0] result;

  // este es un bus
  assign op = op_set;

  tinyalu dut (
      .A      (A),
      .B      (B),
      .op     (op),
      .clk    (clk),
      .reset_n(reset_n),
      .start  (start),
      .done   (done),
      .result (result)
  );

  `include "op_cov.svh"

op_cov oc;

  zeros_or_ones_on_ops c_00_FF;

  initial begin : clock

    clk = 0;

    forever begin

      #10;

      clk = ~clk;

    end

  end : clock

  initial begin : coverage

    oc = new();

    c_00_FF = new();

    forever begin

      @(negedge clk);

      // para que lea las senales estables

      oc.sample();
      c_00_FF.sample();

    end

  end : coverage

  `include "functions.svh"

  always @(posedge done) begin : scoreboard

    shortint unsigned predicted;

    #1;

    case (op_set)

      add_op: predicted = A + B;
      and_op: predicted = A & B;
      xor_op: predicted = A ^ B;
      mul_op: predicted = A * B;

    endcase

    if (op_set != no_op && op_set != rst_op) begin
      if (predicted != result) begin
        $error("Failed %0t A: %0h B: %0h op: %s result: %0h predicted: %0h", $time, A, B,
               op_set.name(), result, predicted);

        // $error("FAILED A: %0h B: %0h op: %s result: %0h ", A, B, op_set.name(), result);
      end else begin
        $display("SUCCESS %0t A: %0h B: %0h op: %s result: %0h predicted: %0h", $time, A, B,
                 op_set.name(), result, predicted);
      end
    end else begin

      $display("%0t A: %0h B: %0h op: %s", $time, A, B, op_set.name());

    end


  end : scoreboard

  initial begin : tester

    reset_n = 0;

    @(negedge clk);
    // aqui pasa el reset
    @(negedge clk);

    reset_n = 1;
    start   = 0;

    repeat (1000) begin

      @(negedge clk);

      op_set = get_op();

      A = get_data();

      B = get_data();

      start = 1'b1;

      case (op_set)

        no_op: begin

          // clock

          @(posedge clk);

          start = 0;

          // en todas se apaga la senal despues de un clock 

        end

        rst_op: begin

          // clock

          reset_n = 0;
          start   = 0;

          @(negedge clk);

          reset_n = 1;

        end

        default: begin
          // esta cosa no importa lo que se tarde esta cosa se va a esperar
          // se apaga done y el start no ha cambiado entonces empieza a computar la data con las datas  que estan ahi guardadas y sigue 
          wait (done);
          start = 0;
        end

      endcase

    end

    $stop;

  end : tester

endmodule
