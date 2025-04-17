/////////////////////////////////////////////////////////////////
//  file name     : ahb_singal_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb single transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SINGAL_TRANSFER_SEQS_SV
`define AHB_SINGAL_TRANSFER_SEQS_SV

class ahb_single_transfer_seqs extends ahb_master_base_seqs #(32,32);

  `uvm_object_utils(ahb_single_transfer_seqs)

  extern function new (string name = "ahb_single_transfer_seqs");
  extern task body();
endclass :ahb_single_transfer_seqs

// Constructor implementation
function ahb_single_transfer_seqs::new(string name = "ahb_single_transfer_seqs");
  super.new(name);
endfunction	

// Sequence body implementation
task ahb_single_transfer_seqs::body();
  repeat (1) begin
    // WRITE transaction
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h"); 	
    start_item(m_master_txn_h);
    if (!m_master_txn_h.randomize() with 
      {m_transaction_type == HWRITE; 
       m_burst_type == SINGLE; 
       m_size_type == WORD; 
       m_start_addr == 596;}) begin
      `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
    end
    finish_item(m_master_txn_h);
    	
    // READ transaction
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h");
    start_item(m_master_txn_h);
    if (!m_master_txn_h.randomize() with
      {m_transaction_type == HREAD; 
       m_burst_type == SINGLE; 
       m_size_type == WORD;
       m_start_addr == 596;}) begin
      `uvm_error(get_type_name(), "Randomization failed for READ transaction")
    end
    finish_item(m_master_txn_h); 
  end
endtask :body

`endif // AHB_SINGAL_TRANSFER_SEQS_SV

