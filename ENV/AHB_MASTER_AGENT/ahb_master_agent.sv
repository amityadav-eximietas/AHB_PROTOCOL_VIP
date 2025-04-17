/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_agent.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master agent class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_AGENT_SV
`define AHB_MASTER_AGENT_SV

class ahb_master_agent #(int ADDR_WIDTH = 32, int DATA_WIDTH = 32) extends uvm_agent;
  
  `uvm_component_utils(ahb_master_agent #(ADDR_WIDTH, DATA_WIDTH))

  ahb_master_config m_master_config_h;    
  virtual ahb_master_if #(ADDR_WIDTH, DATA_WIDTH) m_ahb_master_vif; 
  ahb_master_driver  #(ADDR_WIDTH, DATA_WIDTH) m_master_drv_h;
  ahb_master_seqr    #(ADDR_WIDTH, DATA_WIDTH) m_master_seqr_h;
  ahb_master_monitor #(ADDR_WIDTH, DATA_WIDTH) m_master_mon_h;

  extern function new(string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass :ahb_master_agent

// constructor
function ahb_master_agent::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build_phase for creating handal and config_db
function void ahb_master_agent::build_phase(uvm_phase phase);
  m_master_config_h = ahb_master_config::type_id::create("m_master_config_h", this);
  
  // get master configuration 
  if (!uvm_config_db #(ahb_master_config)::get(this, "", "mas_config", m_master_config_h))begin
    `uvm_fatal("AGENT_CONFIG_GET", "Master config is not available")
  end
  
  // if agent is active create driver and sequencer 
  if (m_master_config_h.is_active == UVM_ACTIVE) begin
    m_master_drv_h = ahb_master_driver #(ADDR_WIDTH, DATA_WIDTH)::type_id::create(
     "m_master_drv_h", this);
    m_master_seqr_h = ahb_master_seqr #(ADDR_WIDTH, DATA_WIDTH)::type_id::create(
     "m_master_seqr_h", this);
  end 
    m_master_mon_h = ahb_master_monitor #(ADDR_WIDTH, DATA_WIDTH)::type_id::create(
     "m_master_mon_h", this);
  
  // get virtual interface 
  if (!uvm_config_db #(virtual ahb_master_if #(ADDR_WIDTH, DATA_WIDTH))::
	  get(this, "", "ahb_master_vif", m_ahb_master_vif))begin
    `uvm_fatal("AGENT_VIRTUAL_INTERFACE", "Master Interface is not available") 
  end
endfunction :build_phase

// connect phase for connecting driver, sequencer
function void ahb_master_agent::connect_phase(uvm_phase phase); 
  super.connect_phase(phase); 

  if (m_master_config_h.is_active == UVM_ACTIVE) begin
    m_master_drv_h.seq_item_port.connect(m_master_seqr_h.seq_item_export); 
    m_master_drv_h.m_ahb_master_vif = this.m_ahb_master_vif; 	
  end 
  // connect master interface with this interface 
  m_master_mon_h.m_ahb_master_vif = this.m_ahb_master_vif;
endfunction :connect_phase

`endif // AHB_MASTER_AGENT_SV
