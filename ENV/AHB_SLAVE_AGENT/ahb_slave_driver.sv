/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_DRIVER_SV
`define AHB_SLAVE_DRIVER_SV

typedef enum {NOWAIT, WAIT} wait_enum;

class ahb_slave_driver #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) 
  extends uvm_driver #(ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)); 

  `uvm_component_utils(ahb_slave_driver #(ADDR_WIDTH, DATA_WIDTH))
 // wait_enum wenum;
  virtual ahb_slave_if #(ADDR_WIDTH, DATA_WIDTH) m_ahb_slave_vif;
  ahb_common_object m_cobj_h;
  ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) m_slave_txn_h;
  int m_slave_burst_len = 0;

  extern function new (string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task initialize();
  extern task mem_write(int addr, int data);
  extern task mem_read(int addr);
  extern task burst_len_calculation();
  extern task wait_for_reset();
  extern task send_to_interface();
endclass :ahb_slave_driver

// constructor
function ahb_slave_driver::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase for geting common object using config_db
function void ahb_slave_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  m_slave_txn_h = ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_slave_txn_h");
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", m_cobj_h)) begin
      `uvm_fatal(get_full_name(), "common object is not available in slave driver")
  end
endfunction :build_phase

// run phase
task ahb_slave_driver::run_phase(uvm_phase phase);
    wait_for_reset();
    forever begin
      @(negedge m_ahb_slave_vif.hclk);
      m_slave_txn_h.m_transaction_type = transaction_type_t'(m_ahb_slave_vif.hwrite); 
      m_slave_txn_h.m_burst_type = burst_type_t'(m_ahb_slave_vif.hburst);
      m_slave_txn_h.m_transfer_type = transfer_type_t'(m_ahb_slave_vif.htrans);
      if (m_slave_txn_h.m_transfer_type == 2 || m_slave_txn_h.m_transfer_type == 3) begin
        burst_len_calculation();
	m_slave_txn_h.m_haddr = new[m_slave_burst_len];
        m_slave_txn_h.m_hwdata = new[m_slave_burst_len];
	send_to_interface();
      end 
    end
endtask :run_phase

// task to set initial value
task ahb_slave_driver::initialize();
  m_ahb_slave_vif.hready_out <= 1'b1;
  m_ahb_slave_vif.hrdata     <= '0;
  //m_ahb_slave_vif.hresp     <= '0;
  //wenum = NOWAIT;
  //count = 0;
  //rand_count = $urandom_range(1,4);
endtask :initialize    

//reset task
task ahb_slave_driver::wait_for_reset();
  @(negedge m_ahb_slave_vif.hrst_n);
  initialize();
  @(posedge m_ahb_slave_vif.hrst_n);
endtask :wait_for_reset

task ahb_slave_driver::send_to_interface();
  int read_addr;
  @(posedge m_ahb_slave_vif.hclk);
  `uvm_info(get_full_name(),$sformatf("--m_slave_txn_h.m_transaction_type = %0b--",m_slave_txn_h.m_transaction_type),UVM_MEDIUM)
  if(m_slave_txn_h.m_transaction_type) begin
    for(int i = 0; i < m_slave_burst_len; i++) begin
      if(m_ahb_slave_vif.hready_out) begin
        m_slave_txn_h.m_haddr[i] = m_ahb_slave_vif.haddr;
	@(posedge m_ahb_slave_vif.hclk);
	m_slave_txn_h.m_hwdata[i] = m_ahb_slave_vif.hwdata;
        `uvm_info(get_full_name(), $sformatf("hwdata : %0h | hwdata _arr : %0p", 
	   m_ahb_slave_vif.hwdata, m_slave_txn_h.m_hwdata),UVM_MEDIUM)
	mem_write(m_slave_txn_h.m_haddr[i],m_slave_txn_h.m_hwdata[i]);
      end
    end
  end else begin
    read_addr = m_ahb_slave_vif.haddr;
    mem_read(read_addr);
  end
endtask :send_to_interface

// Memory write task
task ahb_slave_driver::mem_write(int addr, int data); 
  m_cobj_h.write(addr, data);
  `uvm_info(get_full_name(), $sformatf("mem : %0p", m_cobj_h.memory), UVM_MEDIUM)  
endtask :mem_write  

// Memory read task 
task ahb_slave_driver::mem_read(int addr);
  m_cobj_h.read(addr);
  m_ahb_slave_vif.hrdata <= m_cobj_h.mem_hrdata;
  `uvm_info(get_full_name(), $sformatf("Read: Addr=%0d, Data=%0d", addr, m_cobj_h.mem_hrdata), UVM_MEDIUM)
endtask :mem_read

// burst len calculation
task ahb_slave_driver::burst_len_calculation();
  case(m_slave_txn_h.m_burst_type)
     0 : m_slave_burst_len = 1;  //single
     1 : m_slave_burst_len = 20; //incr   //TODO
     2 : m_slave_burst_len = 4;  //wrap4
     3 : m_slave_burst_len = 4;  //incr4
     4 : m_slave_burst_len = 8;  //wrap8
     5 : m_slave_burst_len = 8;  //incr8
     6 : m_slave_burst_len = 16; //wrap16
     7 : m_slave_burst_len = 16; //incr16
    default :m_slave_burst_len = 0;
  endcase
endtask :burst_len_calculation


 // if (wenum == NOWAIT) begin
 //     m_ahb_slave_vif.hready_out <= 1'b1;
 // end else begin
 //     count++;
 //     if ((rand_count <= count) && (count < (rand_count + 2))) begin       
 //       m_ahb_slave_vif.hready_out <= 1'b0;
 //     end else begin       
 //       m_ahb_slave_vif.hready_out <= 1'b1;
 //     end
 //   end
`endif // AHB_SLAVE_DRIVER_SV
