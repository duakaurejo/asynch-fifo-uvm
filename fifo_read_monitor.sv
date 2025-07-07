`define MON_IF_RD vif.cb_rd_mon

class fifo_read_monitor extends uvm_monitor; 
  `uvm_component_utils(fifo_read_monitor)
  
  virtual fifo_interface vif; 
  
  uvm_analysis_port #(fifo_transaction) ap;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for fifo_read_monitor.")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    fifo_transaction tx; 
    tx = fifo_transaction::type_id::create("tx");
    forever begin
      
      @(`MON_IF_RD);
      if(`MON_IF_RD.rinc) begin
        tx.rinc   = `MON_IF_RD.rinc;
        tx.rdata  = `MON_IF_RD.rdata; 
        tx.rempty = `MON_IF_RD.rempty;
        `uvm_info(get_type_name(), $sformatf("Read: rdata= 0x%0h, rinc=%b, rempty=%b ", tx.rdata, tx.rinc, tx.rempty), UVM_MEDIUM)
        ap.write(tx); // Send to scoreboard
      end
    end
     
  endtask
  
endclass

    