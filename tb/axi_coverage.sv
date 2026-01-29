`uvm_analysis_imp_decl(_WR)
`uvm_analysis_imp_decl(_RD)
class axi_coverage extends uvm_component;
  `uvm_component_utils(axi_coverage)

  bit add_valid;
  bit data_valid;
  bit add_ready;
  bit data_ready;
  bit [31:0] addr;
  bit [31:0] data; 
   uvm_analysis_imp_WR#(axi_trans,axi_coverage) wr_cov_port;
   uvm_analysis_imp_RD#(axi_trans,axi_coverage) rd_cov_port;
 covergroup write_coverage;

  // Address coverage (example ranges)
  addr_cp : coverpoint addr {
    bins low  = {[32'h0  : 32'h0F]};
    bins mid  = {[32'h10 : 32'h7F]};
    bins high = {[32'h80 : 32'hFF]};
  }

  // Data coverage (simple)
  data_cp : coverpoint data {
    bins zero = {32'h0};
    bins ones = {32'hFFFFFFFF};
    bins others = default;
  }
//Address VALID for READ and WRITE
  rw_cp : coverpoint add_valid {
    bins write = {1};
    bins read  = {0};
  }
 coverpoint add_ready;
 coverpoint data_valid;
 coverpoint data_ready;
 endgroup:write_coverage

function new(string name = "coverage",uvm_component parent = null);
  super.new(name,parent);
  write_coverage = new;
endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   wr_cov_port = new("wr_cov_port",this);
   rd_cov_port = new("rd_cov_port",this);
  endfunction
virtual  function void write_WR(axi_trans t);
   uvm_printer p = uvm_default_printer; 
   `uvm_info("coverage","This is the write coverage function",UVM_NONE); 
   addr = t.AWADDR;
   $display("the write addresss is: %0d",t.AWADDR);
   data = t.WDATA;
   $display("the write data is: %0d",t.WDATA);
   data_valid = t.WVALID;
   data_ready = t.WREADY;
   add_valid  = t.AWVALID; 
   add_ready  = t.AWREADY;

   t.print(p);

  write_coverage.sample();
 endfunction

  virtual function void write_RD(axi_trans t);
   uvm_printer p = uvm_default_printer; 
   `uvm_info("coverage","This is the read coverage function",UVM_NONE); 
   addr = t.ARADDR;
   $display("the read addresss is: %0d",t.ARADDR);
   data = t.RDATA;
   $display("the read data is: %0d",t.RDATA);
   data_valid = t.RVALID;
   data_ready = t.RREADY;
   add_valid  = t.ARVALID; 
   add_ready  = t.ARREADY;

   t.print(p);

  write_coverage.sample();
 endfunction
endclass
