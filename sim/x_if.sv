`timescale 1ns / 1ps

interface X_if (
    input logic clk
);

  logic [7:0] din, dout;

  logic reset, load;

  clocking cb @(posedge clk);

    output din, load;

    input dout;

  endclocking

  always @cb $strobe("%t %m out=%d in=%d load=%d reset=%d", $time, dout, din, load, reset);

  modport DUT(input clk, din, reset, load, output dout);

  modport TB(clocking cb, output reset);

endinterface

typedef virtual X_if.TB vx_if;
