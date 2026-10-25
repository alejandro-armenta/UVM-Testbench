module tinyalu (
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [2:0] op,
    input logic clk,
    input logic reset_n,
    input logic start,
    output logic done,
    output logic [15:0] result
);

  logic [15:0] result_aax, result_mult;

  logic done_aax, done_mult;

  logic start_single, start_mult;

  assign start_single = start & ~op[2];
  assign start_mult   = start & op[2];

  single_cycle and_add_xor (
      .A,
      .B,
      .op,
      .clk,
      .reset_n,
      .start (start_single),
      .done  (done_aax),
      .result(result_aax)
  );

  three_cycle mult (
      .A,
      .B,
      .clk,
      .reset_n,
      .start (start_mult),
      .done  (done_mult),
      .result(result_mult)
  );

  assign result = (op[2]) ? result_mult : result_aax;
  assign done   = (op[2]) ? done_mult : done_aax;

endmodule


module single_cycle (
    input logic [7:0] A,
    input logic [7:0] B,
    input logic [2:0] op,
    input logic clk,
    input logic reset_n,
    input logic start,
    output logic done,
    output logic [15:0] result
);

  always @(posedge clk) begin

    if (!reset_n) begin

      result <= '0;

    end else begin

      case (op)

        3'b001: result <= A + B;
        3'b010: result <= A & B;
        3'b011: result <= A ^ B;

      endcase

    end

  end

  always @(posedge clk) begin

    if (!reset_n) begin

      done <= 0;

    end else begin

      // aqui se apaga 
      done <= (start == 1'b1) && (op != 3'b000);

    end


  end

endmodule : single_cycle


module three_cycle (
    input logic [7:0] A,
    input logic [7:0] B,
    input logic clk,
    input logic reset_n,
    input logic start,
    output logic done,
    output logic [15:0] result
);

  logic [7:0] a_int, b_int;

  logic [15:0] mult1, mult2;

  logic done1, done2, done3;

  always @(posedge clk) begin

    if (!reset_n) begin

      done   <= 0;

      done3  <= 0;
      done2  <= 0;
      done1  <= 0;

      a_int  <= 0;
      b_int  <= 0;

      mult1  <= 0;
      mult2  <= 0;

      result <= 0;

    end else begin

      a_int  <= A;

      b_int  <= B;

      mult1  <= a_int * b_int;

      mult2  <= mult1;

      result <= mult2;

      // hasta que este apagado puedes empezar otra vez si quieres
      // esta es independiente no la puedes controlar
      // el done si la puedes controlar 4 segundos

      done3  <= start & !done;

      done2  <= done3 & !done;

      done1  <= done2 & !done;

      done   <= done1 & !done;

    end

  end

endmodule : three_cycle





