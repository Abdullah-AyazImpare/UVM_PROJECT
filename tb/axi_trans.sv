import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_trans extends uvm_sequence_item;

//declare the signals
//Global signals
  logic ARESETN;
//Write address channel 
  rand logic AWVALID;
  logic AWREADY;
  rand logic [31:0]AWADDR;
  logic AWPROT;
//write data channel
  rand logic WVALID;
  logic WREADY;
  rand logic [31:0]WDATA;
  rand logic [3:0]WSTRB;
//Write response channel
  logic BVALID;
  rand logic BREADY;
  logic BRESP;
//Read address channel
  rand logic ARVALID;
  logic ARREADY;
  rand logic [31:0]ARADDR;
  logic ARPROT;
//Read data channel
  logic RVALID;
  rand logic RREADY;
  rand logic [31:0]RDATA;
  logic RRESP;
//factory registration
 `uvm_object_utils_begin(axi_trans)
   `uvm_field_int(AWVALID,UVM_ALL_ON)
   `uvm_field_int(AWREADY,UVM_ALL_ON)
   `uvm_field_int(WVALID,UVM_ALL_ON)
   `uvm_field_int(WREADY,UVM_ALL_ON)
   `uvm_field_int(AWADDR,UVM_ALL_ON)
   `uvm_field_int(WDATA,UVM_ALL_ON)
   `uvm_field_int(RRESP,UVM_ALL_ON)
   `uvm_field_int(ARVALID,UVM_ALL_ON)
   `uvm_field_int(ARREADY,UVM_ALL_ON)
   `uvm_field_int(RVALID,UVM_ALL_ON)
   `uvm_field_int(RREADY,UVM_ALL_ON)
   `uvm_field_int(ARADDR,UVM_ALL_ON)
   `uvm_field_int(RDATA,UVM_ALL_ON)
   `uvm_field_int(BREADY,UVM_ALL_ON)
   `uvm_field_int(BVALID,UVM_ALL_ON)
   `uvm_field_int(BRESP,UVM_ALL_ON)
   `uvm_field_int(WSTRB,UVM_ALL_ON)   
 `uvm_object_utils_end

//Initilization of non-random variables
//Global signals

 function new(string name = "axi_trans");
   super.new(name);  
 endfunction
endclass
