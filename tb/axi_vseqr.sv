class axi_vseqr extends uvm_sequencer;
  `uvm_component_utils(axi_vseqr)

   function new(string name = "axi_vseqr",uvm_component parent = null);
    super.new(name,parent);
   endfunction
  
  axi_sequencer seqr1;
  axi_seqr22 seqr2;
endclass
