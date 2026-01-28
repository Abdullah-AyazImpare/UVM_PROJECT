//Write Transaction//
class axi_seq extends uvm_sequence#(axi_trans);
 `uvm_object_utils(axi_seq)
  axi_trans a1;

  function new(string name = "axi_seq");
   super.new(name);
  endfunction
 
  task body();
  a1 = axi_trans::type_id::create("axi_trans");
  start_item(a1);
  `uvm_info("SEQ","The  write sequence has started",UVM_MEDIUM);
   assert(a1.randomize()with{
   AWADDR== 32'd10;
   WDATA==32'd35;
   ARADDR == 32'd0;
   RDATA==32'd0;
   AWVALID==1'b1;
   WVALID==1'b1;
   BREADY==1'b1;
   ARVALID==1'b0;
   RREADY==1'b0;
   WSTRB == 4'b1111;}); 
  finish_item(a1);  

  endtask
endclass
//----------------//
//Read Transaction//
class axi_seq_rd extends axi_seq;
 `uvm_object_utils(axi_seq_rd)

  function new(string name = "axi_seq_rd");
   super.new(name);
  endfunction
 
  task body();
  a1 = axi_trans::type_id::create("axi_trans");
  start_item(a1);
  `uvm_info("SEQ_RD","The read sequence has started",UVM_MEDIUM);
   assert(a1.randomize()with{
   AWADDR== 32'd0;
   WDATA==32'd0;
   ARADDR == 32'd10;
   RDATA==32'd0;
   AWVALID==1'b0;
   WVALID==1'b0;
   BREADY==1'b0;
   ARVALID==1'b1;
   RREADY==1'b1;
   WSTRB == 4'b0000;}); 
  finish_item(a1);  
  endtask

endclass
