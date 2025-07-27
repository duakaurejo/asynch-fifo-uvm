class fifo_write_agent extends uvm_agent;
  `uvm_component_utils(fifo_write_agent)
  
  fifo_write_driver    drv;
  fifo_write_monitor   mon; 
  fifo_write_sequencer seqr;
  
  function new(string name = "fifo_write_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(get_is_active() == UVM_ACTIVE) begin
      `uvm_info(get_type_name(), "Write agent is active", UVM_LOW)

      drv  = fifo_write_driver   ::type_id::create("drv", this);
      seqr = fifo_write_sequencer::type_id::create("seqr", this); 
    end
    
    mon =  fifo_write_monitor  ::type_id::create("mon", this); 
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
     drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass
  