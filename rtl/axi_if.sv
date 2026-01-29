interface axi_if(input logic ACLK);
//Global signals
  logic ARESETN;
//Write address channel 
  logic AWVALID;
  logic AWREADY;
  logic [31:0]AWADDR;
  logic AWPROT;
//write data channel
  logic WVALID;
  logic WREADY;
  logic [31:0]WDATA;
  logic [3:0]WSTRB;
//Write response channel
  logic BVALID;
  logic BREADY;
  logic [1:0]BRESP;
//Read address channel
  logic ARVALID;
  logic ARREADY;
  logic [31:0]ARADDR;
  logic ARPROT;
//Read data channel
  logic RVALID;
  logic RREADY;
  logic [31:0]RDATA;
  logic [1:0]RRESP;
endinterface
