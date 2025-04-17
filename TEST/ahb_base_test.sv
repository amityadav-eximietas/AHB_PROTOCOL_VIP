/////////////////////////////////////////////////////////////////
//  file name     : ahb_base_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb base test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_BASE_TEST_SV
`define AHB_BASE_TEST_SV

class ahb_base_test extends uvm_test;
	
  // factory registration
  `uvm_component_utils(ahb_base_test)
	
  // environment class handle
  ahb_env env_h;
  ahb_env_config cfg_h;
	
  // all function 
  extern function new(string name = "", uvm_component parent = null);
  extern function void end_of_elaboration_phase (uvm_phase phase);
  extern function void build_phase (uvm_phase phase);
	  
endclass : ahb_base_test

// constructor
function ahb_base_test::new(string name = "", uvm_component parent = null);
  super.new(name,parent);
endfunction

// end of elaboration	
function void ahb_base_test::end_of_elaboration_phase (uvm_phase phase);
  uvm_top.print_topology();
endfunction

// build phase
function void ahb_base_test::build_phase (uvm_phase phase);
  //creating environment
  env_h=ahb_env::type_id::create("env_h",this);
endfunction 

`endif 
