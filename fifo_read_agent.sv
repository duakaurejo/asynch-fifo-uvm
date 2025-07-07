class fifo_read_agent extends uvm_agent;
  `uvm_component_utils(fifo_read_agent)
  
  fifo_read_driver    drv; 
  fifo_read_monitor   mon; 
  fifo_read_sequencer seqr;
  
  function new(string name = "fifo_read_agent", uvm_component parent = null); 
    super.new(name, parent); 
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    
    if(get_is_active() == UVM_ACTIVE) begin
      drv  = fifo_read_driver   ::type_id::create("drv", this);
      seqr = fifo_read_sequencer::type_id::create("seqr", this); 
    end
    
    mon =  fifo_read_monitor  ::type_id::create("mon", this);
  endfunction
  
  function void connect_phase(uvm_phase phase); 
    super.connect_phase(phase); 
    
    if(get_is_active() == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
    
  endfunction
endclass
