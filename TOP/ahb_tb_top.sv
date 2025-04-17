/////////////////////////////////////////////////////////////////
//  file name     : ahb_tb_top.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb top
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

module ahb_tb_top();

  import uvm_pkg::*;
  import ahb_test_pkg::*;

  bit clk;
  // clock generation
  always #5 clk = ~clk;
 
  //insterface instance
  ahb_master_if #(32,32) m_ahb_master_vif_0 (clk);
  ahb_slave_if  #(32,32) m_ahb_slave_vif_0 (clk);

  //-----------connecting interface
  // Connect master to slave directly using interface signals
  assign m_ahb_slave_vif_0.haddr   = m_ahb_master_vif_0.haddr;
  assign m_ahb_slave_vif_0.hwrite  = m_ahb_master_vif_0.hwrite;
  assign m_ahb_slave_vif_0.hwdata  = m_ahb_master_vif_0.hwdata;
  assign m_ahb_slave_vif_0.hburst  = m_ahb_master_vif_0.hburst;
  assign m_ahb_slave_vif_0.hsize   = m_ahb_master_vif_0.hsize;
  assign m_ahb_slave_vif_0.htrans  = m_ahb_master_vif_0.htrans;
  assign m_ahb_slave_vif_0.hstrb   = m_ahb_master_vif_0.hstrb;
  assign m_ahb_slave_vif_0.hrst_n  = m_ahb_master_vif_0.hrst_n;

  // Connect slave response back to master
  assign m_ahb_master_vif_0.hready = m_ahb_slave_vif_0.hready_out;
  assign m_ahb_master_vif_0.hrdata = m_ahb_slave_vif_0.hrdata;
  assign m_ahb_master_vif_0.hresp  = m_ahb_slave_vif_0.hresp;


  initial 
    begin
      @(posedge clk);
      m_ahb_master_vif_0.hrst_n = 1'b0;
      repeat(3)
      @(posedge clk);
      m_ahb_master_vif_0.hrst_n = 1'b1;
      //  repeat(5) @(negedge clk);
      //  m_ahb_master_vif_0.hrst_n = 1'b0;
  end
 
  initial begin
    uvm_config_db #(virtual ahb_master_if  #(32,32))::set
      (uvm_root::get(),"uvm_test_top.env_h.m_master_agnt_h[0]","ahb_master_vif",m_ahb_master_vif_0);
    uvm_config_db #(virtual ahb_slave_if   #(32,32))::set
      (uvm_root::get(),"uvm_test_top.env_h.m_slave_agnt_h[0]","ahb_slave_vif",m_ahb_slave_vif_0);
    uvm_top.set_report_verbosity_level(UVM_LOW);
    run_test("ahb_incr8_transfer_test");
  end 

 // initial begin
 //   #90;
 //   m_ahb_master_vif_0.hrst_n = 1'b0; 
 //  end 
 endmodule
 
