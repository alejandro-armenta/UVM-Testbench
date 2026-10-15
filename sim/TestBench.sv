`include "UVM_Object.sv"

// el proxy se instancia staticamente 

module automatic test;

  initial begin

    svm_component test_obj;

    svm_factory::display();

    // apenas aqui se instancia mi test
    test_obj = svm_factory::get_test();

    test_obj.run_test();

  end
endmodule

