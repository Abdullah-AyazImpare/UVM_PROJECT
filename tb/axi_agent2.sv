class axi_agent2 extends uvm_agent;
  `uvm_component_utils(axi_agent2)
  axi_drv2 driver;
  axi_mon2 monitor;
  axi_seqr22 sequencer;

  function new(string name = "axi_agent",uvm_component parent = null);
   super.new(name,parent);
   
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   driver = axi_drv2::type_id::create("driver",this);  
   monitor = axi_mon2::type_id::create("monitor",this);  
   sequencer = axi_seqr22::type_id::create("sequencer",this);  
  endfunction

  virtual function void connect_phase(uvm_phase phase);
   if(get_is_active() == UVM_ACTIVE)
   begin
   driver.seq_item_port.connect(sequencer.seq_item_export);
   end
  endfunction
endclass
