/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_CONFIG_SVH
`define AHB_SLAVE_CONFIG_SVH

class ahb_slave_config extends uvm_object;
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  static int no_of_agts=1;   
     
  `uvm_object_utils_begin(ahb_slave_config)
  `uvm_field_int(no_of_agts, UVM_ALL_ON | UVM_DEC)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end
  
  extern  function new (string name="");
endclass

// constructor
function ahb_slave_config::new (string name="");
  super.new(name);
endfunction
`endif // AHB_SLAVE_CONFIG_SVH
