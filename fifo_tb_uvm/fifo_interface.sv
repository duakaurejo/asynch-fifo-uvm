interface fifo_interface #(parameter DSIZE = 8, ASIZE = 4); 
  
  // Write domain signals
  logic [DSIZE-1:0] wdata;
  logic             winc;
  logic             wfull;
  logic				wclk; 
  logic 			wrst_n;

  // Read domain signals
  logic [DSIZE-1:0] rdata;
  logic             rinc;
  logic             rempty;
  logic				rclk; 
  logic 			rrst_n;
  
  ///**
  // Clocking block for write driver
  clocking cb_wr_drv @(posedge wclk); 
    //default input #1 output #1;
    output wdata, winc; 
    input wfull; 
  endclocking
  
  // Clocking block for write monitor
  clocking cb_wr_mon @(posedge wclk); 
   //default input #1;
   input wdata, winc, wfull; 
  endclocking
  
  // Clocking block for read driver
  clocking cb_rd_drv @(posedge rclk); 
    //default input #1 output #1;
    output rinc;
    input rdata, rempty;
  endclocking
  
  // Clocking block for read monitor
  clocking cb_rd_mon @(posedge rclk); 
    //default input #1; 
    input rdata, rinc, rempty; 
  endclocking
  
  modport mp_wr_drv (clocking cb_wr_drv, input wclk, wrst_n); 
  modport mp_wr_mon (clocking cb_wr_mon, input wclk, wrst_n); 
  
  modport mp_rd_drv (clocking cb_rd_drv, input rclk, rrst_n); 
  modport mp_rd_mon (clocking cb_rd_mon, input rclk, rrst_n); 
 //   */
   
    
endinterface