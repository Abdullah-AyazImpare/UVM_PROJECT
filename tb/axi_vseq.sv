class axi_vseq extends uvm_sequence;
  `uvm_object_utils(axi_vseq)
  `uvm_declare_p_sequencer(axi_vseqr)
   
   function new(string name ="axi_vseq");
     super.new(name);
   endfunction 
   
   axi_seq seq1;
   axi_seq_rd seq2;
   
   task pre_body();
    seq1 = axi_seq::type_id::create("seq1");
    seq2 = axi_seq_rd::type_id::create("seq2");
   endtask
   
   task body();
     
      seq1.start(p_sequencer.seqr1);
      
      seq2.start(p_sequencer.seqr2);
     
   endtask
endclass
