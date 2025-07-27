`timescale 1ns/1ps

 import uvm_pkg::*; 
`include "uvm_macros.svh"
  
  
`include "fifo_interface.sv"

`include "fifo_transaction.sv"
`include "fifo_write_sequencer.sv"
`include "fifo_read_sequencer.sv"
`include "fifo_sequence.sv"

`include "fifo_write_driver.sv"
`include "fifo_read_driver.sv"

`include "fifo_write_monitor.sv"
`include "fifo_read_monitor.sv"



`include "fifo_write_agent.sv"
`include "fifo_read_agent.sv"

`include "fifo_scoreboard.sv"
`include "fifo_env.sv"

`include "fifo_base_test.sv"
`include "fifo_test_write_only.sv"
`include "fifo_test_fill_then_empty.sv"
`include "fifo_test_rd_wr_parallel.sv"

module testbench; 
 
  
  // Instantiate interface
  fifo_interface #(.DSIZE(8), .ASIZE(4)) fifo_if();
  
  // Clock generation
  initial begin
    fifo_if.wclk = 0; 
    forever #5 fifo_if.wclk = ~fifo_if.wclk; // 100 MHz
  end
  
  initial begin
    fifo_if.rclk = 0; 
    forever #7 fifo_if.rclk = ~fifo_if.rclk; // 71 MHz
  end
  
  initial begin
    // Reset (synchronous)
    fifo_if.wrst_n = 0; 
    fifo_if.rrst_n = 0; 
    repeat (2) @(posedge fifo_if.wclk);
    repeat (2) @(posedge fifo_if.rclk);
    fifo_if.wrst_n = 1; 
    fifo_if.rrst_n = 1; 
  end

  // Instantiate DUT
  fifo1 #(.DSIZE(8), .ASIZE(4)) dut (
    .wdata		(fifo_if.wdata),
    .winc 		(fifo_if.winc),
    .wfull		(fifo_if.wfull),
    .wclk 		(fifo_if.wclk),
    .wrst_n		(fifo_if.wrst_n),
    
    .rdata		(fifo_if.rdata),
    .rinc		(fifo_if.rinc),
    .rempty		(fifo_if.rempty),
    .rclk		(fifo_if.rclk),
    .rrst_n		(fifo_if.rrst_n)
    
  );

  initial begin
    uvm_config_db#(virtual fifo_interface)::set(null, "*", "vif", fifo_if);
  end
  
  initial begin
    $display("Starting UVM Test..."); 
    run_test("fifo_test_rd_wr_parallel");
    //run_test("fifo_test_fill_then_empty");
    //run_test("fifo_test_write_only");
  end
  
  initial begin
    $dumpfile("dump.vcd");        
    $dumpvars(0, testbench);       
  end


  always @(posedge fifo_if.wclk) begin
  if (fifo_if.wfull)
    $display("[%0t] WARNING: wfull is HIGH", $time);
  end

endmodule