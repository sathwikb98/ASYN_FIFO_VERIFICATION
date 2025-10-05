class fifo_read_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_read_monitor)

  virtual fifo_read_inf.MON intf_r;
  uvm_analysis_port#(fifo_read_seq_item) analysis_port_monitor_r;
  fifo_read_seq_item req;

  function new(string name ="fifo_read_monitor", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_read_inf)::get(this,"","vif_r",intf_r))
    analysis_port_monitor_r = new("analysis_port_mon_r",this);
  endfunction

  task body();
    repeat(5) @(intf_r.mon_cb);
    forever begin
      req = fifo_read_seq_item::type_id::create("req");
      set_req();
      analysis_port_monitor_r.write(req);
      repeat(2) @(intf_r.mon_cb);
    end
  endtask

  task set_req();
    req.rinc = intf_r.mon_cb.rinc;
    req.rdata = intf_r.mon_cb.rdata;
    req.rrst_n = intf_r.mon_cb.rrst_n;
    req.rempty = intf_r.mon_cb.rempty;
  endtask

endclass
