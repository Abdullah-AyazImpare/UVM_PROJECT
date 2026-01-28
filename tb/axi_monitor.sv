class axi_monitor extends uvm_monitor;
  `uvm_component_utils(axi_monitor)
   virtual interface axi_if if1; 
   axi_trans a1;
  uvm_analysis_port#(axi_trans)mon_port;
  function new(string name = "axi_monitor",uvm_component parent = null);
   super.new(name,parent);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   mon_port = new("mon_port",this);
   if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",if1))
    `uvm_fatal("MON","Interface NOT set foe the monitor class");   
  endfunction 

 virtual task run_phase(uvm_phase phase);

    super.run_phase(phase);
   //drive transaction signals with the interface signals 
   forever begin    
   @(posedge if1.ACLK );
   //@(posedge if1.ACLK );
    //#0;
    a1 = axi_trans::type_id::create("a1");
    `uvm_info("MON","MONITOR HAS STARTED",UVM_MEDIUM);
    $display("",);
    //For WRITE Transaction 
    wait(if1.AWREADY && if1.AWVALID)begin
    a1.AWADDR = if1.AWADDR;
    a1.AWVALID = if1.AWVALID;
    a1.AWREADY = if1.AWREADY;
    `uvm_info("MON",$sformatf("The received DUT address is: %0d",a1.AWADDR),UVM_NONE);
    end
   @(posedge if1.ACLK);
    wait(if1.WREADY && if1.WVALID)begin
    a1.WDATA = if1.WDATA;
    a1.WVALID = if1.WVALID;
    a1.WREADY = if1.WREADY;
    `uvm_info("MON",$sformatf("The received DUT data is: %0d",a1.WDATA),UVM_NONE);
    end
   //@(posedge if1.ACLK); 
    a1.print();   
   mon_port.write(a1); 
   end

  endtask
endclass
