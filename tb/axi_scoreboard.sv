class axi_scrbd extends uvm_scoreboard;
  `uvm_component_utils(axi_scrbd)
   uvm_analysis_imp#(axi_trans,axi_scrbd) scrbd_port;

  function new(string name = "scrbd",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   scrbd_port = new("scrbd_port",this);
  endfunction
  
 function void write(axi_trans a1);
  // use the actual and expected outputs to compare the results
  `uvm_info("scrbd","This is the scoreboard ",UVM_MEDIUM);
 endfunction
endclass
