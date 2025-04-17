/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_monitor.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master monitor class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_MON_SV
`define AHB_MASTER_MON_SV

class ahb_master_monitor #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_monitor;
  
  `uvm_component_utils(ahb_master_monitor #(ADDR_WIDTH, DATA_WIDTH))
  ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) m_master_txn_h;
  virtual ahb_master_if #(ADDR_WIDTH, DATA_WIDTH) m_ahb_master_vif;

  // Analysis Port declaration 
  uvm_analysis_port #(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)) ahb_mon_ap;
  
  extern function new (string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task monitor();
endclass

// constructor
function ahb_master_monitor::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase
function void ahb_master_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  ahb_mon_ap = new("ahb_mon_ap", this);
  m_master_txn_h = ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_master_txn_h");
endfunction :build_phase

// run phase
task ahb_master_monitor::run_phase(uvm_phase phase);
  forever begin
   @(posedge m_ahb_master_vif.hclk); 
   monitor();
   // analysis port write method
   ahb_mon_ap.write(m_master_txn_h);
 end  
endtask :run_phase

// monitor task for sample the signal
task ahb_master_monitor::monitor();  
    
endtask :monitor

`endif // AHB_MASTER_MON_SV
