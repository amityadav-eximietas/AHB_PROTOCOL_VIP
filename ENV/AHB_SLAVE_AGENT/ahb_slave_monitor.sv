/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_monitor.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave monitor class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_MON_SV
`define AHB_SLAVE_MON_SV

class ahb_slave_monitor #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_monitor;

  `uvm_component_utils(ahb_slave_monitor #(ADDR_WIDTH, DATA_WIDTH))
  virtual ahb_slave_if #(ADDR_WIDTH, DATA_WIDTH) m_ahb_slave_vif;
  ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) m_slave_txn_h;

  // analysis port declaration
  uvm_analysis_port #(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)) m_ahb_mon_ap;

  // common object handal
  ahb_common_object m_cobj_h;

  extern function new (string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task monitor();
endclass :ahb_slave_monitor

// Constructor
function ahb_slave_monitor::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void ahb_slave_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  m_ahb_mon_ap = new("m_ahb_mon_ap", this);
  m_slave_txn_h = ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_slave_txn_h");
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", m_cobj_h)) begin
    `uvm_fatal("COMMON_OBJECT_MON", "common object is not available in slave monitor")
  end
endfunction :build_phase

// Run phase
task ahb_slave_monitor::run_phase(uvm_phase phase);
  forever begin
    @(posedge m_ahb_slave_vif.hclk); 
    monitor();
    m_ahb_mon_ap.write(m_slave_txn_h);
  end
endtask :run_phase

// Monitor task for sampling signal
task ahb_slave_monitor::monitor();
 // m_slave_txn_h.hready_out = m_ahb_slave_vif.hready_out;  
 // m_slave_txn_h.hwrite     = m_ahb_slave_vif.hwrite; 
 // m_slave_txn_h.hburst     = m_ahb_slave_vif.hburst;
 // m_slave_txn_h.hsize      = m_ahb_slave_vif.hsize;
 // m_slave_txn_h.htrans     = m_ahb_slave_vif.htrans;
 // m_slave_txn_h.hstrb      = m_ahb_slave_vif.hstrb; 
 // m_slave_txn_h.hresp      = m_ahb_slave_vif.hresp; 
 // m_slave_txn_h.haddr_q.push_back(m_ahb_slave_vif.haddr);
 // if (m_slave_txn_h.hwrite) begin
 //   m_slave_txn_h.hwdata_q.push_back(m_ahb_slave_vif.hwdata);
 // end else begin	  
 //   m_slave_txn_h.hrdata_q.push_back(m_ahb_slave_vif.hrdata);
 // end
endtask :monitor

`endif // AHB_SLAVE_MON_SV

