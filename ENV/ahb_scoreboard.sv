/////////////////////////////////////////////////////////////////
//  file name     : ahb_scoreboard.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb scoreboard class
//  company name  : eximietas design
/////////////////////////////////////////////////////////////////

`ifndef AHB_SCOREBOARD_SV
`define AHB_SCOREBOARD_SV

`uvm_analysis_imp_decl(_mas_mon)
`uvm_analysis_imp_decl(_slv_mon)

class ahb_scoreboard extends uvm_scoreboard;

  parameter ADDR_WIDTH = 32, DATA_WIDTH = 32;

  `uvm_component_utils(ahb_scoreboard)

  // Data queues
  bit [DATA_WIDTH-1:0] hrdata_q[$]; 
  bit [DATA_WIDTH-1:0] hwdata_q[$];  
  bit [ADDR_WIDTH-1:0] haddr_q[$];  

  // Analysis exports
  uvm_analysis_imp_mas_mon #(ahb_seq_item, ahb_scoreboard) mas_mon_export;
  uvm_analysis_imp_slv_mon #(ahb_seq_item, ahb_scoreboard) slv_mon_export;

  // Constructor and phases
  extern function new(string name = "ahb_scoreboard", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void write_mas_mon(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h);
  extern function void write_slv_mon(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h);
  extern function void check_phase(uvm_phase phase);

endclass: ahb_scoreboard

// Constructor
function ahb_scoreboard::new(string name = "ahb_scoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void ahb_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  mas_mon_export = new("mas_mon_export", this);
  slv_mon_export = new("slv_mon_export", this);
endfunction :build_phase

// Write method for slave monitor
function void ahb_scoreboard::write_slv_mon(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h);
 
endfunction :write_slv_mon

// Write method for master monitor
function void ahb_scoreboard::write_mas_mon(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h);

endfunction :write_mas_mon

// Check phase 
function void ahb_scoreboard::check_phase(uvm_phase phase);

endfunction

`endif // AHB_SCOREBOARD_SV
