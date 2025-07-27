class fifo_write_sequencer extends uvm_sequencer #(fifo_transaction);
  `uvm_component_utils(fifo_write_sequencer)
  
  function new(string name = "fifo_write_sequencer", uvm_component parent = null); 
    super.new(name, parent);
  endfunction
endclass

