class axi_env extends uvm_env;
  `uvm_component_utils(axi_env)
   axi_agent agent;
   axi_scrbd scrbd;
   axi_coverage cov;

   function new(string name = "env",uvm_component parent = null);
    super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   agent = axi_agent::type_id::create("agent",this);
   scrbd = axi_scrbd::type_id::create("scrbd",this);
   cov = axi_coverage::type_id::create("coverage",this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agent.monitor.mon_port.connect(scrbd.scrbd_port);
     agent.monitor.mon_port.connect(cov.analysis_export);     
   endfunction
endclass
