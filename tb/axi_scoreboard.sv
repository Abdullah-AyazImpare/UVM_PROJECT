`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class axi_scrbd extends uvm_scoreboard;
  `uvm_component_utils(axi_scrbd)
   uvm_analysis_imp_wr#(axi_trans,axi_scrbd) wr_scrbd_port;
   uvm_analysis_imp_rd#(axi_trans,axi_scrbd) rd_scrbd_port;
  function new(string name = "scrbd",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   wr_scrbd_port = new("wr_scrbd_port",this);
   rd_scrbd_port = new("rd_scrbd_port",this);
  endfunction
  
 function void write_wr(axi_trans a1);
  // use the actual and expected outputs to compare the results
  `uvm_info("scrbd","This is the write scoreboard ",UVM_MEDIUM);
 endfunction

 function void write_rd(axi_trans a1);
  // use the actual and expected outputs to compare the results
  `uvm_info("scrbd","This is the  read scoreboard ",UVM_MEDIUM);
 endfunction
endclass
