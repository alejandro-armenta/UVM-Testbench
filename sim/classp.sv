`ifndef CLASS_P
`define CLASS_P

`include "uvm_macros.svh"

import uvm_pkg::*;

class class_P extends uvm_object;

  rand int par_int;
  rand byte par_address;

  string par_string;

  class_A c11;
  class_A c13;

  `uvm_object_utils_begin(class_P)

    `uvm_field_int(par_int, UVM_DEFAULT)

    `uvm_field_int(par_address, UVM_DEFAULT)

    `uvm_field_string(par_string, UVM_DEFAULT)

    `uvm_field_object(c11, UVM_DEFAULT)

    `uvm_field_object(c13, UVM_DEFAULT)

  `uvm_object_utils_end


  function new(string name = "");

    super.new(name);

    c11 = new(name);

    c13 = new(name);

    par_string = name;

  endfunction


endclass

`endif
