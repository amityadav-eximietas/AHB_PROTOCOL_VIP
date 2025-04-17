/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_agent.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave agent class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLVAVE_AGENT_SV
`define AHB_SLVAVE_AGENT_SV

class ahb_slave_agent #(int ADDR_WIDTH = 32, int DATA_WIDTH = 32) extends uvm_agent;
  
  `uvm_component_param_utils(ahb_slave_agent #(ADDR_WIDTH,DATA_WIDTH))
  ahb_slave_config m_slave_config_h;
  virtual ahb_slave_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slave_vif;
  
  // Handles for components and config
  ahb_slave_driver  #(ADDR_WIDTH, DATA_WIDTH) m_slave_drv_h;
  ahb_slave_monitor #(ADDR_WIDTH, DATA_WIDTH) m_slave_mon_h;
  ahb_common_object m_cobj_h;
  
  extern function new (string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase); 
  extern function void connect_phase(uvm_phase phase);
endclass

// constructor
function ahb_slave_agent::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase for handal creation and config set-get
function void ahb_slave_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create the common object
  m_cobj_h = ahb_common_object::type_id::create("m_cobj_h", this);

  //passing common object to slave driver and monitor
  uvm_config_db #(ahb_common_object)::set(this,"*", "common_object", m_cobj_h);

  // Create config handle
  m_slave_config_h = ahb_slave_config::type_id::create("m_slave_config_h", this);
    
  // Get config from UVM database
  if (!uvm_config_db #(ahb_slave_config)::get(this, "", "slave_config", m_slave_config_h)) begin
    `uvm_fatal("AGENT_CONFIG_GET", "Slave config is not available")
  end
    
  // If agent is active, create driver and sequencer
  if (m_slave_config_h.is_active == UVM_ACTIVE) begin
    m_slave_drv_h = ahb_slave_driver #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_slave_drv_h", this);
  end
    
  // Create monitor
  m_slave_mon_h = ahb_slave_monitor #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_slave_mon_h", this);
    
  // Get virtual interface
  if (!uvm_config_db #(virtual ahb_slave_if #(ADDR_WIDTH, DATA_WIDTH))::get(
    this, "", "ahb_slave_vif", ahb_slave_vif)) begin
    `uvm_fatal("AGENT_VIRTUAL_INTERFACE", "Slave Interface is not available")
  end
endfunction :build_phase

//connect phase connecting interface
function void ahb_slave_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  m_slave_drv_h.m_ahb_slave_vif = this.ahb_slave_vif;
  m_slave_mon_h.m_ahb_slave_vif = this.ahb_slave_vif;
endfunction :connect_phase
  
`endif // AHB_SLVAVE_AGENT_SV
