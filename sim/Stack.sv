
class IntStack;

  parameter int SIZE = 100;
  local int stack[SIZE];

  local int top;

  function void push(int i);
    stack[top++] = i;
  endfunction

  function int pop();
    // top--;
    return stack[--top];
  endfunction
endclass
