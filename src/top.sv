`include "uvm_macros.svh"
`include "defines.svh"
`include "fifo_write_inf.sv"
`include "fifo_read_inf.sv"
`include "asyn_fifo_pkg.sv"

module top;
  import uvm_pkg::*;
  import asyn_fifo_pkg::*;

  bit wclk,rclk;

  fifo_write_inf intf_w(.wclk(wclk));
  fifo_read_inf  intf_r(.rclk(rclk));

  always #5 wclk = ~wclk;
  always #5 rclk = ~rclk;

  //FIFO dut (.wclk(wclk), .rclk(rclk), .winc(intf_w.winc), .wrst_n(intf_w.wrst_n), .rinc(intf_r.rinc), .rrst_n(intf_r.rrst_n), .wdata(intf_w.wdata), .wfull(intf_w.wfull), .rdata(intf_r.rdata), .rempty(intf_r.rempty));

  initial begin
    uvm_config_db#(virtual fifo_write_inf)::set(uvm_root::get(), "*", "vif_w", intf_w);
    uvm_config_db#(virtual fifo_read_inf)::set(uvm_root::get(), "*", "vif_r", intf_r);
  end

  initial begin
    run_test("fifo_test");
    #100; $finish;
  end

endmodule
