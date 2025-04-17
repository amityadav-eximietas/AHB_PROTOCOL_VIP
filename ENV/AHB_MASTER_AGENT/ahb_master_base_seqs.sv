/////////////////////////////////////////////////////////////////
//  file name     : ahb_masterter_base_seqs.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master base sequence class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_BASE_SEQS_SV
`define AHB_MASTER_BASE_SEQS_SV

class ahb_master_base_seqs #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) 
  extends uvm_sequence #(ahb_seq_item #(ADDR_WIDTH,DATA_WIDTH));
	
  `uvm_object_utils(ahb_master_base_seqs #(ADDR_WIDTH, DATA_WIDTH))
  ahb_seq_item #(ADDR_WIDTH,DATA_WIDTH) m_master_txn_h;
	
  extern function new(string name = ""); 		
endclass :ahb_master_base_seqs

// constructor
function ahb_master_base_seqs::new(string name = "");
  super.new(name);
  m_master_txn_h=new();
endfunction

`endif // AHB_MASTER_BASE_SEQS_SV
