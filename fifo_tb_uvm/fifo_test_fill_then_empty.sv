class fifo_test_fill_then_empty extends fifo_base_test;
  `uvm_component_utils(fifo_test_fill_then_empty)

  fifo_wr_then_rd_virtual_sequence seq; 
  
  function new(string name = "fifo_test_fill_then_empty", uvm_component parent=null);
    super.new(name, parent);
    seq = fifo_wr_then_rd_virtual_sequence::type_id::create("seq");
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    wait ((vif.wrst_n === 1'b1) && (vif.rrst_n === 1'b1));
    
    seq.write_seqr = env.write_agent.seqr; 
    seq.read_seqr  = env.read_agent.seqr; 
    
    seq.start(null);
    
    phase.drop_objection(this);
    
  endtask
  
endclass