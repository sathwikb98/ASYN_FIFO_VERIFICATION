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

  modport DRV_R(clocking read_drv_cb, input rclk, rrst_n);
  modport MON_R(clocking read_mon_cb, input rclk, rrst_n);
  modport DRV_W(clocking write_drv_cb, input wclk,wrst_n);
  modport MON_W(clocking write_mon_cb, input wclk,wrst_n);

  property VALID_CHECK_WRITE;
    @(posedge wclk) wrst_n |-> not($isunknown({winc,wdata}));
  endproperty
  assert property(VALID_CHECK_WRITE)begin
    $info("VALID INPUTS");
  end
  else begin
    $error("INVALID INPUTS");
  end

  property VALID_CHECK_READ;
    @(posedge rclk) rrst_n |-> not($isunknown({rinc}));
  endproperty
  assert property(VALID_CHECK_READ)begin
    $info("VALID INPUTS");
  end
  else begin
    $error("INVALID INPUTS");
  end

  property RESET_READ_CHECK;
    @(posedge rclk) !rrst_n |-> (rempty == 1);
  endproperty

  assert property(RESET_READ_CHECK)
    $info("RESET PASSED");
  else begin
    $error("RESET FAILED");
  end

  property RESET_WRITE_CHECK;
    @(posedge wclk) !wrst_n |-> (wfull == 0);
  endproperty

  assert property(RESET_WRITE_CHECK)
    $info("RESET PASSED");
  else begin
    $error("RESET FAILED");
  end
 
endinterface
