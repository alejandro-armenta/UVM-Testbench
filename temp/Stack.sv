
`ifndef STACK_SV
`define STACK_SV

class Stack #(
    type T = int
);

  parameter int SIZE = 100;

  local T   stack[SIZE];
  local int top;

  function void push(T i);
    stack[top++] = i;
  endfunction

  function T pop();
    return stack[--top];
  endfunction

endclass

`endif
