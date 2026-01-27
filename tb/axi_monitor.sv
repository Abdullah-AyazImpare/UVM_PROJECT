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

  task run_phase(uvm_phase phase);
   //drive transaction signals with the interface signals 
   forever begin
   @(posedge if1.ACLK iff ((if1.AWREADY && if1.WREADY)||(if1.ARREADY && if1.RVALID)));
    a1 = axi_trans::type_id::create("a1");
    `uvm_info("MON","MONITOR HAS STARTED",UVM_MEDIUM);
    $display("",);
    //For WRITE Transaction 
    if(if1.AWREADY && if1.WREADY)begin
    a1.AWADDR = if1.AWADDR;
    a1.WDATA = if1.WDATA;
    a1.AWREADY = if1.AWREADY;
    a1.BVALID = if1.BVALID;
    a1.WREADY = if1.WREADY;
    
    end
    //For READ Transaction 
    if(if1.ARREADY && if1.RVALID)begin
    a1.ARADDR = if1.ARADDR;
    a1.RDATA = if1.RDATA;
    a1.ARREADY = if1.ARREADY;
    a1.RVALID = if1.RVALID;
    //a1.print();
    end 
    a1.print(); 
   //@(posedge if1.ACLK);   
   mon_port.write(a1); 
   end
  endtask
endclass
