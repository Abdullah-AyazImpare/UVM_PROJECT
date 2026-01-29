class axi_drv2 extends uvm_driver#(axi_trans);
  `uvm_component_utils(axi_drv2)
   axi_trans a1;
   logic [31:0] add_ready,data_c;
   virtual interface axi_if if1;
  function new(string name = "axi_drv2",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",if1)) 
     `uvm_fatal("DRV2","Interface not set for the driver2"); 
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    seq_item_port.get_next_item(a1);
    wait(if1.ARESETN);
    @(negedge if1.ACLK );
    `uvm_info("DRV2","The Driver2 has started",UVM_NONE);
     if1.AWVALID <= 0;
     if1.AWADDR <= 32'd0;
     if1.WVALID <= 0;
     if1.WDATA <= 32'd0;
     if1.BVALID <= 0;
     if1.WSTRB <= a1.WSTRB;
     fork
      add_rd(a1);
      read(a1);
      //rd_resp(a1);
     join
    a1.print();
    repeat(2) @(posedge if1.ACLK);
    seq_item_port.item_done();
    //@(posedge if1.ACLK);
    end


  endtask
 
  task add_rd(axi_trans a1);
    if(a1.ARVALID)
    begin
     @(posedge if1.ACLK);
     if1.ARVALID <= a1.ARVALID;
     if1.ARADDR <= a1.ARADDR;
     if1.AWVALID <= 0;
     
     wait(if1.ARREADY);
      
    end
  endtask


  task read(axi_trans a1);
    if(a1.RREADY)
    begin
     @(posedge if1.ACLK);
      wait(if1.ARREADY);
      //if1.RVALID <= a1.RVALID;
      if1.RREADY <= a1.RREADY;
      //if1.RDATA <= a1.WDATA;
      wait(if1.RVALID);
    end
  endtask


endclass
