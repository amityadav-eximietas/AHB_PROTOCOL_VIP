/////////////////////////////////////////////////////////////////
//  file name    : ahb_defines.svh
//  owner name   : amit yadav & anupam mathur
//  module name  : ahb define file
//  company name : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_DEFINES_SVH
`define AHB_DEFINES_SVH

// enum for htransfer to set no of transfer or beat
typedef enum bit [2:0] {SINGLE,
                        INCR,
		        WRAP4,
	                INCR4,
		        WRAP8,
			INCR8,
			WRAP16,
			INCR16} burst_type_t;

// enum for hsize
typedef enum bit [2:0] {BYTE = 1,
                        HALF_WORD = 2,
		        WORD = 4} size_type_t;

// enum for decide the transaction type
typedef enum bit [1:0] {IDLE,
                        BUSY, 
			NON_SEQ, 
			SEQ} transfer_type_t;

// for write or read permission
typedef enum bit {HREAD, 
                  HWRITE} transaction_type_t;      
               
`endif // AHB_MASTER_DEFINES_SVH
