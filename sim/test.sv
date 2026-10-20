
`include "classa.sv"
`include "classp.sv"

program test;

  class_P a;

  initial begin

    a = new("Alejandro");

    $display("%p", a);

  end

endprogram


function ale();


endfunction
