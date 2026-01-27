class axi_coverage extends uvm_subscriber#(axi_trans);
  `uvm_component_utils(axi_coverage)

  bit add_valid;
  bit data_valid;
  bit add_ready;
  bit data_ready;
  bit [31:0] addr;
  bit [31:0] data; 
 
 covergroup write_coverage;
  coverpoint addr {
   bins a[256] = {[0:255]};
}
  coverpoint data {
   bins d[256] = {[0:255]};
}
 coverpoint add_valid;
 coverpoint data_valid;
 coverpoint add_ready;
 coverpoint data_ready;
 endgroup

function new(string name = "coverage",uvm_component parent = null);
  super.new(name,parent);
  write_coverage = new;
endfunction

 virtual function void write(axi_trans t);
  
   addr = t.AWADDR;
   data = t.WDATA;
   data_valid = t.WVALID;
   data_ready = t.WREADY;
   add_valid  = t.AWVALID; 
   add_ready  = t.AWREADY;
   `uvm_info("wqw",$psprintf("The coverage class received: %s",t.convert2string()),UVM_NONE);
  write_coverage.sample();
 endfunction
endclass
