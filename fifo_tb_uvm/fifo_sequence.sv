// Contains various sequences depending on type of test.


// WRITE ONLY
class fifo_write_sequence extends uvm_sequence#(fifo_transaction);
  `uvm_object_utils(fifo_write_sequence)
  fifo_transaction tx;
  
  function new(string name = "fifo_write_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    set_response_queue_depth(30);
    repeat(20)  begin
      tx = fifo_transaction::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize() with {tx.winc==1; tx.rinc==0; });
      finish_item(tx);
    end
  endtask
endclass

// READ ONLY
class fifo_read_sequence extends uvm_sequence#(fifo_transaction);
  `uvm_object_utils(fifo_read_sequence)
  fifo_transaction tx;
  function new(string name = "fifo_read_sequence"); 
    super.new(name);
  endfunction
  
  virtual task body();
    set_response_queue_depth(30);
    repeat(20)  begin
      tx = fifo_transaction::type_id::create("tx");
      start_item(tx);
      assert(tx.randomize() with {tx.winc==0; tx.rinc==1; });
      finish_item(tx);
    end
  endtask
endclass

// FILL FIFO THEN EMPTY
class fifo_wr_then_rd_virtual_sequence extends uvm_sequence#(fifo_transaction);
  `uvm_object_utils(fifo_wr_then_rd_virtual_sequence)
  
  fifo_write_sequencer write_seqr; 
  fifo_read_sequencer  read_seqr;
  
  function new(string name = "fifo_wr_then_rd_virtual_sequence"); 
    super.new(name);
  endfunction
  
  task body();
    fifo_write_sequence write_seq; 
    fifo_read_sequence  read_seq; 
    
    write_seq = fifo_write_sequence::type_id::create("write_seq");
    read_seq  = fifo_read_sequence ::type_id::create("read_seq");
    
    
    write_seq.set_sequencer(write_seqr);
    read_seq.set_sequencer(read_seqr); 
    
    `uvm_info(get_type_name(), "Starting WRITE sequence", UVM_LOW)
    write_seq.start(write_seqr);
    
    `uvm_info(get_type_name(), "Starting READ sequence", UVM_LOW)
    read_seq.start(read_seqr);
    
  endtask
endclass

// WRITE AND READ IN PARALLEL
class fifo_wr_rd_parallel_virtual_sequence extends uvm_sequence#(fifo_transaction); 
  `uvm_object_utils(fifo_wr_rd_parallel_virtual_sequence)
  
  fifo_write_sequencer write_seqr;
  fifo_read_sequencer  read_seqr;
  
  function new(string name = "fifo_wr_rd_parallel_virtual_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    fifo_write_sequence write_seq;
    fifo_read_sequence  read_seq;
    
    write_seq = fifo_write_sequence::type_id::create("write_seq");
    read_seq  = fifo_read_sequence ::type_id::create("read_seq");
    
    write_seq.set_sequencer(write_seqr);
    read_seq.set_sequencer(read_seqr);
    
    `uvm_info(get_type_name(), "Starting WRITE and READ sequences in parallel", UVM_LOW)
    
    fork
      write_seq.start(write_seqr);
      read_seq.start(read_seqr);
    join
  endtask
endclass


