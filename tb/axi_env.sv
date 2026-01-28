class axi_env extends uvm_env;
  `uvm_component_utils(axi_env)
   axi_agent agent;
   axi_agent2 agent2;
   axi_scrbd scrbd;
   axi_coverage cov;
   axi_vseqr vseqr;

   function new(string name = "env",uvm_component parent = null);
    super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   agent = axi_agent::type_id::create("agent",this);
   agent2 = axi_agent2::type_id::create("agent2",this);
   scrbd = axi_scrbd::type_id::create("scrbd",this);
   cov = axi_coverage::type_id::create("coverage",this);
   vseqr = axi_vseqr::type_id::create("vseqr",this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     vseqr.seqr1 = agent.sequencer;
     vseqr.seqr2 = agent2.sequencer;
     agent.monitor.mon_port.connect(scrbd.wr_scrbd_port);
     //agent.monitor.mon_port.connect(cov.analysis_export); 
       agent2.monitor.mon_port.connect(scrbd.rd_scrbd_port);
     agent2.monitor.mon_port.connect(cov.analysis_export);   
   endfunction
endclass
