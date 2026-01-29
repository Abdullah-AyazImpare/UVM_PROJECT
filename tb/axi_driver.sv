class axi_driver extends uvm_driver#(axi_trans);
  `uvm_component_utils(axi_driver)
   axi_trans a1;
   logic [31:0] add_ready,data_c;
   virtual interface axi_if if1;
  function new(string name = "axi_driver",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",if1)) 
     `uvm_fatal("DRV","Interface not set for the driver"); 
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    seq_item_port.get_next_item(a1);
    wait(if1.ARESETN);
    @(negedge if1.ACLK );
    `uvm_info("DRV","The Driver has started",UVM_NONE);

     fork
      add_wr(a1);
      write(a1);
      wr_resp(a1);
     join
    a1.print();
    seq_item_port.item_done();
    //@(posedge if1.ACLK);
    end


  endtask
 
  task add_wr(axi_trans a1);
    if(a1.AWVALID)
    begin
     @(posedge if1.ACLK);
     if1.AWVALID <= a1.AWVALID;
     if1.AWADDR <= a1.AWADDR;
     if1.ARVALID <= 0;
     
     wait(if1.AWREADY);
      
    end
  endtask


  task write(axi_trans a1);
    if(a1.WVALID)
    begin
     @(posedge if1.ACLK);
      wait(if1.AWREADY);
      if1.WVALID <= a1.WVALID;
      if1.WDATA <= a1.WDATA;
      if1.WSTRB <= a1.WSTRB;
      wait(if1.WREADY);
    end
  endtask

  task wr_resp(axi_trans a1);
    if1.BREADY<= a1.BREADY;
    wait(if1.BVALID);
   
  endtask

endclass
