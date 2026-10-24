`ifndef BFM_SV
`define BFM_SV

`include "package.sv"

interface tinyalu_bfm;

  import tinyalu_pkg::*;

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

  endtask : reset_alu

  // protocol is stimulus
  task send_op(byte unsigned iA, byte unsigned iB, operation_t iop);

    op_set = iop;

    case (iop)

      rst_op: begin

        // aqui acaba de pasar un negedge clk

        @(posedge clk);

        // reset

        reset_n = 0;
        start   = 0;

        // te esperas tantito para que se estabilize todas las senales de reseteo
        @(posedge clk);
        #1;

        reset_n = 1;

      end

      default: begin

        // aqui acaba de pasar un negedge clk

        @(negedge clk);

        A = iA;
        B = iB;

        start = 1;

        if (iop == no_op) begin

          @(posedge clk);
          #1;

          start = 0;

        end else begin

          do begin
            @(negedge clk);

            // esto se evalua en el negedge clk
          end while (done == 0);

          // esto se evalua en el negedge clk
          start = 0;

          // posedge clk

        end

      end

    endcase


  endtask : send_op

endinterface

`endif


