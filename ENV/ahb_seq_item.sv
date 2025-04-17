/////////////////////////////////////////////////////////////////
//  file name     : ahb_seq_item.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb sequence item  class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SEQ_ITEM_SV
`define AHB_SEQ_ITEM_SV
				   
class ahb_seq_item #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_sequence_item;
 
  // all enum handle
  rand burst_type_t       m_burst_type;
  rand size_type_t        m_size_type;
  rand transfer_type_t    m_transfer_type;
  rand transaction_type_t m_transaction_type;
  
  // all signal declaration 
  bit      [ADDR_WIDTH-1:0] m_haddr[];
  rand bit [DATA_WIDTH-1:0] m_hwdata[];
  bit      [DATA_WIDTH-1:0] m_hrdata[];
	   
  // local signal for calculation
  rand int m_burst_len;   
  rand int m_start_addr; 
  
  constraint solve_order_c {
    solve m_burst_type before m_burst_len;
    solve m_burst_len  before m_hwdata;
  }

  // constraint for burst type
  constraint hburst_c {
    soft m_burst_type == INCR8;
  }
     
  // constraint for transfer size
  constraint hsize_c {
    soft m_size_type == WORD;
  }
			   
  // constraint for starting address
  constraint addr_c {
    soft m_start_addr inside {[1:1000]};
  }	
  
  // constraint for align address
  constraint align_addr_c {
    m_start_addr % 4 == 0;
  }         
			   
  // constraint for transaction type
  constraint sig_enb_c {
    soft m_transaction_type == HWRITE;
  }

  // constarint for burst len calculation                  
  constraint burst_length_c {
    if (m_burst_type == SINGLE) {
      m_burst_len == 1;
    }
    else if (m_burst_type == INCR) {
      soft m_burst_len == 20; 
    }
    else if (m_burst_type inside {INCR4, WRAP4}) {
      m_burst_len == 4;
    }
    else if (m_burst_type inside {INCR8, WRAP8}) {
      m_burst_len == 8;
    }
    else if (m_burst_type inside {INCR16, WRAP16}) {
      m_burst_len == 16;
    }
  }

  // constraint for hwdata array size 
  constraint hwdata_c {
    m_hwdata.size() == m_burst_len;
  }
 
  // factory registration 	   
  `uvm_object_utils_begin(ahb_seq_item #(ADDR_WIDTH,DATA_WIDTH))
    `uvm_field_enum(burst_type_t, m_burst_type, UVM_ALL_ON)
    `uvm_field_enum(size_type_t, m_size_type, UVM_ALL_ON)
    `uvm_field_enum(transfer_type_t, m_transfer_type, UVM_ALL_ON)
    `uvm_field_enum(transaction_type_t, m_transaction_type, UVM_ALL_ON)
    `uvm_field_array_int(m_haddr, UVM_ALL_ON | UVM_HEX)
    `uvm_field_array_int(m_hwdata, UVM_ALL_ON | UVM_HEX)
    `uvm_field_array_int(m_hrdata, UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

  extern function new (string name = "ahb_seq_item");		
endclass :ahb_seq_item

// constructor 
function ahb_seq_item::new(string name = "ahb_seq_item");
  super.new(name);
endfunction 

`endif // AHB_SEQ_ITEM_SV
