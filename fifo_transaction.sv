class fifo_transaction extends uvm_sequence_item;
  `uvm_object_utils(fifo_transaction);
  rand bit [7:0] wdata;
  rand bit       rinc; 
  rand bit       winc;
  
  bit [7:0] rdata;
  bit       rempty;
  bit       wfull;
  
  function new(string name = "fifo_transaction");
    super.new(name);
  endfunction
  
endclass