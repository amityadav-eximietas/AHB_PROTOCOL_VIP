/////////////////////////////////////////////////////////////////
//  file name     : ahb_env.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb environment class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_ENV_SV
`define AHB_ENV_SV

class ahb_env extends uvm_env;

  `uvm_component_utils(ahb_env)
  ahb_env_config m_env_config_h;
  ahb_master_agent #(32, 32) m_master_agnt_h[];
  ahb_slave_agent  #(32, 32) m_slave_agnt_h[];
  ahb_scoreboard m_scoreboard_h;
  ahb_master_config m_master_config_h[];
  ahb_slave_config  m_slave_config_h[];
	
  extern function new(string name = "", uvm_component parent = null);
  extern function void build_phase (uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);     	
endclass : ahb_env

// constructor
function ahb_env::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// build phase
function void ahb_env::build_phase (uvm_phase phase);
  super.build_phase(phase);
  
  //getting env config from base test
  if (!uvm_config_db #(ahb_env_config)::get(this, "", "m_env_config_h", m_env_config_h)) begin
    `uvm_fatal("CONFIG_NOT_FOUND", "m_env_config_h not set in config_db")
  end
		
  // Create environment configuration
  m_env_config_h.no_of_master_agnt = 1;  // Change as per requirement
  m_env_config_h.no_of_slave_agnt = 1;  // Change as per requirement
		
  uvm_config_db #(ahb_env_config)::set(this, "*", "m_env_config_h", m_env_config_h);
		
  // ---- Create Master Agents ----
  m_master_agnt_h = new[m_env_config_h.no_of_master_agnt];
  m_master_config_h = new[m_env_config_h.no_of_master_agnt];

  foreach (m_master_agnt_h[i]) begin
    m_master_config_h[i] = ahb_master_config::type_id::create($sformatf("m_master_config_h[%0d]", i));
    case(i)
      'h0: m_master_config_h[i].is_active = UVM_ACTIVE;
      'h1: m_master_config_h[i].is_active = UVM_PASSIVE;
    endcase
  // creating agent		
  m_master_agnt_h[i] = ahb_master_agent #(32, 32)::type_id::create(
    $sformatf("m_master_agnt_h[%0d]", i), this);
  // set configdb for mas agent
  uvm_config_db #(ahb_master_config)::set(this,
    $sformatf("m_master_agnt_h[%0d]", i), "mas_config", m_master_config_h[i]);
  end
						
  // ---- Create Slave Agents ----
  m_slave_agnt_h = new[m_env_config_h.no_of_slave_agnt];
  m_slave_config_h = new[m_env_config_h.no_of_slave_agnt];

  foreach (m_slave_agnt_h[i]) begin
    m_slave_config_h[i] = ahb_slave_config::type_id::create($sformatf("m_slave_config_h[%0d]", i));
      case(i)
	'h0: m_slave_config_h[i].is_active = UVM_ACTIVE;  // First slave agent ACTIVE
	'h1: m_slave_config_h[i].is_active = UVM_PASSIVE; // Second slave agent PASSIVE
      endcase
    // creating slave agent
    m_slave_agnt_h[i] = ahb_slave_agent #(32,32)::type_id::create(
      $sformatf("m_slave_agnt_h[%0d]", i), this);
    // set configdb for slave agent			
    uvm_config_db #(ahb_slave_config)::set
      (this, $sformatf("m_slave_agnt_h[%0d]", i), "slave_config", m_slave_config_h[i]);
  end
		
  // creating scoreboard
  if (m_env_config_h.scr_disable == 0) begin
   m_scoreboard_h = ahb_scoreboard::type_id::create("m_scoreboard_h", this);
  end	
endfunction :build_phase

// Connect phase for connecting monitor and scoreboard
function void ahb_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if (m_env_config_h.scr_disable == 0) begin
  // m_master_agnt_h[0].mas_mon_h.ahb_mon_ap.connect(m_scoreboard_h.mas_mon_export);	  //TODO
  // m_slave_agnt_h[0].slv_mon_h.ahb_mon_ap.connect(m_scoreboard_h.slv_mon_export);
  end
endfunction :connect_phase
`endif // AHB_ENV_SV
