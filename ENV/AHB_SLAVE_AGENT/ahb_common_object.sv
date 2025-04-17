/////////////////////////////////////////////////////////////////
//  file name     : ahb_common_object.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb common object class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////
`ifndef COMMON_OBJECT_SV
`define COMMON_OBJECT_SV

class ahb_common_object extends uvm_object;
 
  `uvm_object_utils(ahb_common_object)

  int mem_hrdata;
  bit [31:0] memory [int];

  extern function new(string name = "ahb_common_object");
  extern task write(int addr, int data);
  extern task read(int addr);
endclass :ahb_common_object

// Constructor
function ahb_common_object::new(string name = "ahb_common_object");
  super.new(name);
endfunction

// Write task with read-only address check
task ahb_common_object::write(int addr, int data);
    memory[addr] = data;
endtask :write

// Read task
task ahb_common_object::read(int addr);
  mem_hrdata = memory[addr];
endtask :read
`endif // COMMON_OBJECT_SV
