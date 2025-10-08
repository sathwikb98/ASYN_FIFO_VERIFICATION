`include "defines.svh"

interface fifo_inf(input bit wclk, bit rclk, logic wrst_n, rrst_n);
  logic [`DSIZE-1:0] wdata;
  logic winc;
  logic wfull;
  logic [`DSIZE-1:0] rdata;
  logic rinc;
  logic rempty;

  clocking write_drv_cb@(posedge wclk);
    default input #0 output #0;
    output winc, wdata;
  endclocking 

  clocking write_mon_cb@(posedge wclk);
    default input #0 output #0;
    input winc, wdata, wfull;
  endclocking

  clocking read_drv_cb@(posedge rclk);
     default input #0 output #0;
     output rinc;
  endclocking

  clocking read_mon_cb@(posedge rclk);
     default input #0 output #0;
     input rempty, rdata, rinc; // capture these outputs here !!
  endclocking

endinterface
