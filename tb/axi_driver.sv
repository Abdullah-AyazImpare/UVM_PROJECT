class axi_driver extends uvm_driver#(axi_trans);
  `uvm_component_utils(axi_driver)
   axi_trans a1;
   logic [31:0] add_c,data_c;
   virtual interface axi_if if1;
  function new(string name = "axi_driver",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",if1)) 
     `uvm_fatal("DRV","Interface not set for the driver"); 
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
    seq_item_port.get_next_item(a1);
     @(posedge if1.ACLK);
    `uvm_info("DRV","DRIVER HAS STARTED",UVM_MEDIUM);
   //drive interface signals with transaction signals
    if1.ARESETN  <= a1.ARESETN;
    //For WRITE Transaction 
    if(a1.AWVALID && a1.WVALID)begin

    if1.AWADDR <= a1.AWADDR;
    if1.WDATA <= a1.WDATA;
    if1.AWVALID <= a1.AWVALID;
    if1.BREADY <= a1.BREADY;
    if1.WVALID <= a1.WVALID;
    if1.WSTRB <= a1.WSTRB;
    if1.ARADDR <= 32'd0;
    if1.ARVALID <= 1'b0;
    if1.RREADY <= 1'b0;
    a1.print();
    end
    
    @(posedge if1.ACLK);
    add_c <= if1.AWADDR;
    @(posedge if1.ACLK);
    `uvm_info("DRV",$sformatf("interface addr:%0d",add_c),UVM_NONE);
    data_c <= if1.WDATA;
    @(posedge if1.ACLK);
    `uvm_info("DRV",$sformatf("interface data:%0d",data_c),UVM_NONE);
    //For READ Transaction 
    if(a1.ARVALID && a1.RREADY)begin
    if1.ARADDR = a1.ARADDR;
    if1.ARVALID = a1.ARVALID;
    if1.RREADY = a1.RREADY;
    if1.AWADDR <= 32'd0;
    if1.WDATA <=  32'd0;
    if1.AWVALID <= 1'b0;
    if1.BREADY <= 1'b0;
    if1.WVALID <= 1'b0;
    if1.WSTRB <= 4'd0;
    a1.print();
    end
    //@(posedge if1.ACLK);
    seq_item_port.item_done();
    end


  endtask
endclass
