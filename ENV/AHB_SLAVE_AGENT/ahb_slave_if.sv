/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_if.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave interface
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_IF_SV
`define AHB_SLAVE_IF_SV

interface ahb_slave_if (input logic hclk);

  parameter ADDR_WIDTH = 32;
  parameter DATA_WIDTH = 32; 
			
  logic                      hrst_n;	// Active Low Reset
  logic                      hwrite;
  logic                      hready_out;
  logic                      hsel;       
  logic                      hresp;
  logic [ADDR_WIDTH-1:0]     haddr; 
  logic [DATA_WIDTH-1:0]     hwdata; 
  logic [DATA_WIDTH-1:0]     hrdata; 
  logic [2:0]                hburst;
  logic [2:0]                hsize;
  logic [1:0]                htrans;
  logic [(DATA_WIDTH/8)-1:0] hstrb;
			
endinterface
`endif // AHB_SLAVE_IF_SV
