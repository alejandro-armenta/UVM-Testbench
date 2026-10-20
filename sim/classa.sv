
`ifndef CLASS_A
`define CLASS_A

`include "uvm_macros.svh"

import uvm_pkg::*;

class class_A extends uvm_object;

  int cl_int;

  string cl_string;

  int cl_int_arr[];

  int unsigned logic_data[int];

  `uvm_object_utils_begin(class_A)

    `uvm_field_int(cl_int, UVM_DEFAULT)

    `uvm_field_string(cl_string, UVM_DEFAULT)

    `uvm_field_array_int(cl_int_arr, UVM_DEFAULT)

    `uvm_field_aa_int_longint_unsigned(logic_data, UVM_DEFAULT)

  `uvm_object_utils_end

  function new(string name = "");

    super.new(name);

    cl_int = 10;

    cl_string = name;

    cl_int_arr = new[cl_int];

    foreach (cl_int_arr[i]) begin
      cl_int_arr[i] = i;
    end

  endfunction

endclass

`endif
