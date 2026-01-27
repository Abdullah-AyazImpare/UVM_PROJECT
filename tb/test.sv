class test extends uvm_test;
  `uvm_component_utils(test)
    axi_seq seq;
    axi_seq_rd rd_seq;
   axi_env env;
   function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
   endfunction
 
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = axi_seq::type_id::create("seq",this);
    env = axi_env::type_id::create("env",this);    
   endfunction

   task run_phase(uvm_phase phase);
    phase.raise_objection(this);
     `uvm_info("TEST","This is the test component",UVM_MEDIUM);
      seq.start(env.agent.sequencer);
    phase.phase_done.set_drain_time(this, 1000ns);
    phase.drop_objection(this);
   endtask
   
   function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
   endfunction

   function void report_phase(uvm_phase phase);
    $display($get_coverage());
   endfunction
endclass
