//`define MON_IF_WR vif
`define MON_IF_WR vif.mp_wr_mon.cb_wr_mon

class fifo_write_monitor extends uvm_monitor; 
  `uvm_component_utils(fifo_write_monitor)
  
  virtual fifo_interface vif; 
  
  uvm_analysis_port #(fifo_transaction) ap; 
  
  function new(string name = "fifo_write_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for fifo_write_monitor")
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    fifo_transaction tx;
    tx = fifo_transaction::type_id::create("tx");
    forever begin
      
      @(`MON_IF_WR);
      if(`MON_IF_WR.winc) begin
        tx.winc  = `MON_IF_WR.winc;
        tx.wdata = `MON_IF_WR.wdata;
        tx.wfull = `MON_IF_WR.wfull;

        `uvm_info(get_type_name(), $sformatf("Wrote: wdata=0x%0h, winc=%b, wfull=%b ", tx.wdata, tx.winc, tx.wfull), UVM_MEDIUM)
        ap.write(tx); // Send to scoreboard
      end
    end
  endtask
endclass
