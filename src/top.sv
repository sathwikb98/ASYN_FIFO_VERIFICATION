`include "uvm_macros.svh"
`include "defines.svh"
`include "fifo_inf.sv"
`include "asyn_fifo_pkg.sv"

`include "design/FIFO_memory.v"
`include "design/rptr_empty.v"
`include "design/two_ff_sync.v"
`include "design/wptr_full.v"
`include "design/FIFO.v"

module top;
  import uvm_pkg::*;
  import asyn_fifo_pkg::*;

  bit wclk,rclk;
  bit rrst_n, wrst_n; 
  int sel_t;

  fifo_inf intf(.wclk(wclk), .rclk(rclk), .wrst_n(wrst_n), .rrst_n(rrst_n));

  always #5 wclk = ~wclk;
  always #10 rclk = ~rclk;

  FIFO dut (.wclk(wclk), .rclk(rclk), .winc(intf.winc), .wrst_n(intf.wrst_n), .rinc(intf.rinc), .rrst_n(intf.rrst_n), .wdata(intf.wdata), .wfull(intf.wfull), .rdata(intf.rdata), .rempty(intf.rempty));

  initial begin
    sel_t = 1;
    wclk = 0; 
    rclk = 0;
    wrst_n = 0;
    rrst_n = 0;
    #20
    rrst_n = 1;
    #20
    wrst_n = 1;
  end

  initial begin
    uvm_config_db#(virtual fifo_inf)::set(uvm_root::get(), "*", "vif", intf);
    uvm_config_db#(int)::set(uvm_root::get(),"*","select_test",sel_t);
  end

  initial begin
    run_test("fifo_test");
    #100; $finish;
  end

endmodule
