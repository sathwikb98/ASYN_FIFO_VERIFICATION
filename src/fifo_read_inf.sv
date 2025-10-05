`include "defines.svh"

interface fifo_read_inf(input bit rclk);
  logic [`DSIZE-1:0] rdata;
  logic rinc;
  logic rrst_n;
  logic rempty;

  clocking drv_cb@(posedge rclk);
    default input #0 output #0;
    output rinc, rrst_n;
  endclocking 

  clocking mon_cb@(posedge rclk);
    default input #0 output #0;
    input rempty, rdata, rinc, rrst_n; // capture these outputs here !!
  endclocking 

  modport DRV(clocking drv_cb, input rclk);
  modport MON(clocking mon_cb, input rclk);
endinterface 
