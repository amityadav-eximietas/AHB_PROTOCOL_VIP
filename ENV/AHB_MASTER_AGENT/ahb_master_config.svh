/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_CONFIG_SVH
`define AHB_MASTER_CONFIG_SVH

class ahb_master_config extends uvm_object;

  uvm_active_passive_enum is_active = UVM_ACTIVE;
   
  // To set No of AHB Master Agent
  static int no_of_agts=1; 

  `uvm_object_utils_begin(ahb_master_config)
    `uvm_field_int(no_of_agts, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  extern function new(string name="");  
endclass :ahb_master_config

// constructor
function ahb_master_config::new(string name="");
  super.new(name);
endfunction

`endif // AHB_MASTER_CONFIG_SVH
