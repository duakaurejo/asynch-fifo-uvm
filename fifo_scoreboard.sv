// Declare suffixes to be appended to imps and functions
`uvm_analysis_imp_decl(_WR)
`uvm_analysis_imp_decl(_RD)

class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  
  uvm_analysis_imp_WR#(fifo_transaction, fifo_scoreboard)  write_ap;
  uvm_analysis_imp_RD#(fifo_transaction, fifo_scoreboard)  read_ap; 
  
  bit [7:0] fifo_mem[$]; // reference model
  bit [7:0] tx_data;
  
  int unsigned mismatch_count = 0;
  
  function new(string name = "fifo_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void write_WR(fifo_transaction tx);
    if(!tx.wfull && tx.winc) begin
      `uvm_info("SCOREBOARD", $sformatf("WRITE accepted: wdata=0x%0h", tx.wdata), UVM_LOW)
      fifo_mem.push_back(tx.wdata);
    end else begin
      `uvm_info("SCOREBOARD", $sformatf("WRITE ignored:  winc=%b, wfull=%b, wdata=0x%0h", tx.winc, tx.wfull, tx.wdata), UVM_LOW)
    end
  endfunction
  
  function void write_RD(fifo_transaction tx);
    if(tx.rinc && !tx.rempty) begin
      if(fifo_mem.size()==0) begin
        `uvm_warning("SCOREBOARD", "READ valid but reference model is empty!")
         return;
      end
      
      tx_data = fifo_mem.pop_front();
      if(tx.rdata === tx_data) begin
      `uvm_info("SCOREBOARD", $sformatf("MATCH: Expected 0x%0h, Got 0x%0h", tx_data, tx.rdata), UVM_MEDIUM)
      end else begin
        mismatch_count++;
      `uvm_info("SCOREBOARD", $sformatf("MISMATCH: Expected 0x%0h, Got 0x%0h", tx_data, tx.rdata), UVM_MEDIUM)
      end
      
    end else begin
      `uvm_info("SCOREBOARD", $sformatf("READ ignored (rempty=%0b, rinc=%0b)", tx.rempty, tx.rinc), UVM_LOW)
    end
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_ap = new("write_ap", this);
    read_ap  = new("read_ap", this);
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCOREBOARD", $sformatf("Total mismatches: %0d", mismatch_count), UVM_NONE)
  endfunction
  
endclass
  
  