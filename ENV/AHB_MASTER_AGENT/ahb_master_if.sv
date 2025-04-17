/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_if.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master interface
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_IF_SV
`define AHB_MASTER_IF_SV

interface ahb_master_if (input logic hclk);

  parameter ADDR_WIDTH = 32, DATA_WIDTH = 32; 			
  logic                      hrst_n; // Active Low Reset
  logic                      hwrite;
  logic [ADDR_WIDTH-1:0]     haddr; 
  logic [DATA_WIDTH-1:0]     hwdata; 
  logic [DATA_WIDTH-1:0]     hrdata; 
  logic [2:0]                hburst;
  logic [2:0]                hsize;
  logic [1:0]                htrans;
  logic                      hready;     
  logic                      hsel;        
  logic                      hresp;
  logic [(DATA_WIDTH/8)-1:0] hstrb;
			
endinterface :ahb_master_if

`endif // AHB_MASTER_IF_SV
	
  
  
