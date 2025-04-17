/////////////////////////////////////////////////////////////////
//  file name     : ahb_test_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb test package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_TEST_PKG_SV
`define AHB_TEST_PKG_SV

package ahb_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  //`include "ahb_defines.svh"
 // `include "ahb_seq_item.sv"

  // all package
  //import ahb_master_pkg::*;
 // import ahb_slave_pkg::*;
  import ahb_env_pkg::*;
  
  // Sequences
  `include "ahb_incr_transfer_seq.sv"
  `include "ahb_incr4_transfer_seq.sv"
  `include "ahb_incr8_transfer_seq.sv"
  `include "ahb_incr16_transfer_seq.sv"
  `include "ahb_wrap4_transfer_seq.sv"
  `include "ahb_wrap8_transfer_seq.sv"
  `include "ahb_wrap16_transfer_seq.sv"
  `include "ahb_singal_transfer_seq.sv"
  `include "ahb_multiple_transfer_seq.sv"
  `include "ahb_b2b_transfer_seq.sv"
  `include "ahb_error_transfer_seq.sv"
  `include "ahb_base_test.sv"
  
   // test
  `include "ahb_incr_transfer_test.sv"
  `include "ahb_incr4_transfer_test.sv"
  `include "ahb_incr8_transfer_test.sv"
  `include "ahb_incr16_transfer_test.sv"
  `include "ahb_wrap4_transfer_test.sv"
  `include "ahb_wrap8_transfer_test.sv"
  `include "ahb_wrap16_transfer_test.sv"
  `include "ahb_singal_transfer_test.sv"
  `include "ahb_multiple_transfer_test.sv"
  `include "ahb_b2b_transfer_test.sv"
  `include "ahb_error_transfer_test.sv"
endpackage

`endif
