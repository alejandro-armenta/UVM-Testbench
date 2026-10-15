
`ifndef UTILS_SV
`define UTILS_SV

`define SV_RAND_CHECK(r) \
do begin\
  if (!(r)) begin\
    $finish;\
  end\
end while(0) 


`endif
