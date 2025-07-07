`define DRIV_IF_RD vif.cb_rd_drv

class fifo_read_driver extends uvm_driver #(fifo_transaction);
  `uvm_component_utils(fifo_read_driver)
  
  virtual fifo_interface vif;
  
  function new(string name = "fifo_read_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for fifo_read_driver")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    fifo_transaction tx;
    
    // Initialize signals at start
    `DRIV_IF_RD.rinc <= 0;
    
    forever begin
      seq_item_port.get_next_item(tx);
      if (tx == null) break; // sequence done
      drive(tx);
      seq_item_port.item_done(tx);
    end
  endtask
  
  task drive(fifo_transaction tx);
    
      `DRIV_IF_RD.rinc <= tx.rinc;

      // Wait for data to appear on next clock cycle
      //@(posedge vif.rclk); 
      @(`DRIV_IF_RD)
      `uvm_info(get_type_name(), $sformatf("Read data: rdata=0x%0h", tx.rdata), UVM_MEDIUM)
    
     //`DRIV_IF_RD.rinc <= 0;      
  endtask

endclass