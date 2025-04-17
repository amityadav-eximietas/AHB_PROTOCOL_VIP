/////////////////////////////////////////////////////////////////
//  file name     : ahb_b2b_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb b2b transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_B2B_TRANSFER_SEQS_SV
`define AHB_B2B_TRANSFER_SEQS_SV

class ahb_b2b_transfer_seqs extends ahb_master_base_seqs #(32,32);

  `uvm_object_utils(ahb_b2b_transfer_seqs)

  extern function new (string name = "ahb_b2b_transfer_seqs");
  extern task body();

endclass :ahb_b2b_transfer_seqs

// Constructor implementation
function ahb_b2b_transfer_seqs::new(string name = "ahb_b2b_transfer_seqs");
  super.new(name);
endfunction	

// Sequence body implementation
task ahb_b2b_transfer_seqs::body();
  repeat (1) begin
    // ------------------------------------- INCR8 WRITE READ ------------
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h"); 	
    start_item(m_master_txn_h);
    if (!m_master_txn_h.randomize() with 
     {m_transaction_type == HWRITE; 
      m_burst_type == INCR8; 
      m_size_type == WORD; 
      m_start_addr==596;}) begin
      `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
    end
    finish_item(m_master_txn_h);
    	
    // READ transaction
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h");
    start_item(m_master_txn_h);
      if (!m_master_txn_h.randomize() with { m_transaction_type == HREAD; m_burst_type == INCR8; m_size_type == WORD; m_start_addr==596; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(m_master_txn_h); 

    //----------------------------- WRAP 8 WRITE READ ------------------
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h"); 	
    start_item(m_master_txn_h);
    if (!m_master_txn_h.randomize() with 
     {m_transaction_type == HWRITE; 
      m_burst_type == WRAP8; 
      m_size_type == WORD; 
      m_start_addr==52;}) begin
      `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
    end
    finish_item(m_master_txn_h);
    	
    // READ transaction
    m_master_txn_h = ahb_seq_item#(32,32)::type_id::create("m_master_txn_h");
    start_item(m_master_txn_h);
      if (!m_master_txn_h.randomize() with { m_transaction_type == HREAD; m_burst_type == WRAP8; m_size_type == WORD; m_start_addr==52; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(m_master_txn_h); 

  end
endtask :body

`endif // AHB_B2B_TRANSFER_SEQS_SV



