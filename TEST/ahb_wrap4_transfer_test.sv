/////////////////////////////////////////////////////////////////
//  file name     : ahb_wrap4_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb wrap 4 transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_WRAP4_TRANSFER_TEST_SV
`define AHB_WRAP4_TRANSFER_TEST_SV

class ahb_wrap4_transfer_test extends ahb_base_test;
	
  `uvm_component_utils(ahb_wrap4_transfer_test)
  ahb_wrap4_transfer_seqs m_wrap4_seqs_h;

  extern function new(string name = "", uvm_component parent = null);		
  extern task run_phase (uvm_phase phase);
  extern function void build_phase(uvm_phase phase);
		
endclass :ahb_wrap4_transfer_test

// constructor
function ahb_wrap4_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 

//build phase
function void ahb_wrap4_transfer_test::build_phase(uvm_phase phase);
  // Create and override config before env is built
  cfg_h = ahb_env_config::type_id::create("cfg_h");
  cfg_h.scr_disable = 0;
  cfg_h.time_out = 10;
  // Set env config for environment 
  uvm_config_db #(ahb_env_config)::set(this, "*", "m_env_config_h", cfg_h);
  super.build_phase(phase);
endfunction :build_phase

// run phase
task ahb_wrap4_transfer_test::run_phase(uvm_phase phase);
  phase.raise_objection(this);
  m_wrap4_seqs_h = ahb_wrap4_transfer_seqs::type_id::create("m_wrap4_seqs_h");
  m_wrap4_seqs_h.start(env_h.m_master_agnt_h[0].m_master_seqr_h);
  #10;
  phase.drop_objection(this);	  
endtask :run_phase
`endif // AHB_INCR_TRANSFER_TEST_SV  
