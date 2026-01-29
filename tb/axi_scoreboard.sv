`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class axi_scrbd extends uvm_scoreboard;
  `uvm_component_utils(axi_scrbd)
   uvm_analysis_imp_wr#(axi_trans,axi_scrbd) wr_scrbd_port;
   uvm_analysis_imp_rd#(axi_trans,axi_scrbd) rd_scrbd_port;

// QUEUE 
axi_trans exp_q[$];
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
   exp_q.push_back(a1);
 endfunction

 function void write_rd(axi_trans a1);
   axi_trans exp_item;
  // use the actual and expected outputs to compare the results
  `uvm_info("scrbd","This is the  read scoreboard ",UVM_MEDIUM);
   
   if (exp_q.size()==0)begin
     `uvm_error("scrbd","No write available");
   end
   else begin 
   exp_item = exp_q.pop_front();
   end   
   if((exp_item.AWADDR == a1.ARADDR)&&(exp_item.WDATA==a1.RDATA)) begin
     `uvm_info("scrbd","TEST PASSED!",UVM_NONE);
   end
   else begin
   `uvm_info("scrbd","TEST FAILED!",UVM_NONE);
   end

 endfunction
endclass
