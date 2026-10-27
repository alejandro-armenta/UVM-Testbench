`ifndef BFM_SV
`define BFM_SV

interface tinyalu_bfm;

  import tinyalu_pkg::*;

  command_monitor        command_monitor_h;

  result_monitor         result_monitor_h;

  byte unsigned          A;
  byte unsigned          B;

  bit                    clk;
  bit                    reset_n;
  bit                    start;

  operation_t            op_set;

  logic           [ 2:0] op;
  logic                  done;
  logic           [15:0] result;

  assign op = op_set;

  initial begin : clock

    clk = 0;

    forever begin

      #10;

      clk = ~clk;

    end

  end : clock

  initial begin

    // $monitor("%0t %b %s %h %h", $time, done, op_set.name(), A, B);

  end

  task reset_alu();

    reset_n = 0;

    @(negedge clk);
    // aqui pasa el reset
    @(negedge clk);

    reset_n = 1;

    start   = 0;

  endtask : reset_alu

  // protocol is stimulus
  task send_op(input byte unsigned iA, input byte unsigned iB, input operation_t iop);

    @(negedge clk);

    op_set = iop;

    A = iA;

    B = iB;

    start = 1;

    case (iop)

      no_op: begin

        @(posedge clk);

        start = 0;

      end

      rst_op: begin

        // esperemos que funcione 

        reset_n = 0;

        @(negedge clk);

        start   = 0;
        reset_n = 1;

      end

      default: begin

        @(posedge done);

        start = 0;

        @(posedge clk);

      end

    endcase


  endtask : send_op

  always @(posedge start) begin : command_monitor_b
    command_monitor_h.write_to_monitor(A, B, operation_t'(op));
  end : command_monitor_b

  always @(posedge done) begin : result_monitor_b
    result_monitor_h.write_to_monitor(result);
  end : result_monitor_b

endinterface : tinyalu_bfm

`endif


