/////////////////////////////////////////////////////////////////
//  file name     : ahb_env_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb environment config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_ENV_CONFIG_SVH
`define AHB_ENV_CONFIG_SVH

class ahb_env_config extends uvm_object;
   
   // To set No of AHB Master and Slave Agents
   int no_of_master_agnt = 1;
   int no_of_slave_agnt = 1;
   
   // variable to disable the scoreboard
   int scr_disable = 0;

   // variable for timeout
   int time_out = 10; 
  
  // Factory Registration
  `uvm_object_utils_begin(ahb_env_config)
  `uvm_field_int(no_of_master_agnt, UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(no_of_slave_agnt, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end
  
   extern function new (string name=""); 
endclass

// constructor
function ahb_env_config::new (string name="");
  super.new(name);
endfunction

`endif // AHB_ENV_CONFIG_SVH
