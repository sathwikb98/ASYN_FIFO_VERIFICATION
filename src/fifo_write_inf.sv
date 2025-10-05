`include "defines.svh"

interface fifo_write_inf(input bit wclk);
  logic [`DSIZE-1:0] wdata;
  logic winc;
  logic wrst_n;
  logic wfull;

  clocking drv_cb@(posedge wclk);
    default input #0 output #0;
    output winc, wrst_n, wdata;
  endclocking 

  clocking mon_cb@(posedge wclk);
    default input #0 output #0;
    input winc, wrst_n, wdata, wfull;
  endclocking

  modport DRV(clocking drv_cb);
  modport MON(clocking mon_cb);

endinterface
