`define DRIV_IF_WR vif.mp_wr_drv.cb_wr_drv

class fifo_write_driver extends uvm_driver #(fifo_transaction);
  `uvm_component_utils(fifo_write_driver)
  
  virtual fifo_interface vif; 
  
  function new(string name = "fifo_write_driver", uvm_component parent = null); 
    super.new(name, parent);
  endfunction
  
  // Build phase: get virtual interface
  function void build_phase(uvm_phase phase); 
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for fifo_write_driver")
    end
  endfunction
       
  task run_phase(uvm_phase phase);
     fifo_transaction tx;
    
     forever begin
       seq_item_port.get_next_item(tx);
       if (tx == null) break; // sequence done
       drive(tx);
       seq_item_port.item_done(tx);
     end
  endtask
  
  task drive(fifo_transaction tx);
    
    
	// Write data
    @(`DRIV_IF_WR);
    `DRIV_IF_WR.winc <= tx.winc; 
    `DRIV_IF_WR.wdata <= tx.wdata; 
    `uvm_info(get_type_name(), $sformatf("Writing data: wdata=0x%0h", tx.wdata), UVM_MEDIUM)
     
    // Reset after drive
    @(`DRIV_IF_WR); 
    `DRIV_IF_WR.winc <= 0;
    
    
  endtask
       
endclass
       
       
       
       