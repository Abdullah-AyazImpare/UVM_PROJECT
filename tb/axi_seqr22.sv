class axi_seqr22 extends uvm_sequencer#(axi_trans);
 `uvm_component_utils(axi_seqr22)
  
  function new(string name = "axi_seqr22",uvm_component parent = null);
   super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  endfunction
endclass
