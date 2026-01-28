class axi_mon2 extends uvm_monitor;
  `uvm_component_utils(axi_mon2)
   virtual interface axi_if if1; 
   axi_trans a1;
  uvm_analysis_port#(axi_trans)mon_port;
  function new(string name = "axi_mon2",uvm_component parent = null);
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
    `uvm_info("MON2","MONITOR2 HAS STARTED",UVM_MEDIUM);
    $display("",);
    //For READ Transaction 
    wait(if1.ARREADY && if1.ARVALID)begin
    a1.ARADDR = if1.ARADDR;
    a1.ARVALID = if1.ARVALID;
    a1.ARREADY = if1.ARREADY;
    `uvm_info("MON2",$sformatf("The received DUT address is: %0d",a1.ARADDR),UVM_NONE);
    end
   @(posedge if1.ACLK);
    wait(if1.RREADY && if1.RVALID)begin
    a1.RDATA = if1.RDATA;
    a1.RVALID = if1.RVALID;
    a1.RREADY = if1.RREADY;
    `uvm_info("MON2",$sformatf("The received DUT data is: %0d",a1.RDATA),UVM_NONE);
    end
   //@(posedge if1.ACLK); 
    a1.print();   
   mon_port.write(a1); 
   end

  endtask
endclass
