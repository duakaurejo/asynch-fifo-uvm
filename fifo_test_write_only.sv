class fifo_test_write_only extends fifo_base_test;
  `uvm_component_utils(fifo_test_write_only)
  
  fifo_write_sequence seq;
  
  function new(string name = "fifo_test_write_only", uvm_component parent = null);
    super.new(name, parent);
    seq = fifo_write_sequence::type_id::create("seq");
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    wait (vif.wrst_n === 1'b1 && vif.rrst_n === 1'b1); 
    
    // Start sequence
    seq.start(env.write_agent.seqr); 
    
    phase.drop_objection(this);
  endtask
  
endclass