/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_seqr.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master sequencer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_SEQR_SV
`define AHB_MASTER_SEQR_SV

class ahb_master_seqr #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) 
  extends uvm_sequencer #(ahb_seq_item #(ADDR_WIDTH,DATA_WIDTH));	
 
  `uvm_component_utils(ahb_master_seqr #(ADDR_WIDTH,DATA_WIDTH))
  extern function new (string name = "", uvm_component parent = null);
  extern function void connect_phase(uvm_phase phase);    
endclass

// constructor
function ahb_master_seqr::new (string name = "", uvm_component parent = null);
  super.new(name,parent);
endfunction

// connect phase
function void ahb_master_seqr::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction :connect_phase

`endif  //AHB_MASTER_SEQR_SV
