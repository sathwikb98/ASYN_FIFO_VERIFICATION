class fifo_write_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_write_monitor)

  virtual fifo_write_inf.MON intf_w;
  uvm_analysis_port#(fifo_write_seq_item) analysis_port_monitor_w;
  fifo_write_seq_item req;

  function new(string name ="fifo_write_monitor", uvm_component parent =null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_write_inf)::get(this,"","vif_w",intf_w))
      `uvm_error(get_full_name(),"VIF not in write monitor !!")
    analysis_port_monitor_w = new("analysis_port_mon_w",this);
  endfunction
  
  task body();
    repeat(5) @(intf_w.mon_cb);
    forever begin
      req = fifo_write_seq_item::type_id::create("req");
      set_req();
      analysis_port_monitor_w.write(req);
      repeat(2) @(intf_w.mon_cb);
    end
  endtask

  task set_req();
    req.winc = intf_w.mon_cb.winc;
    req.wdata = intf_w.mon_cb.wdata;
    req.wrst_n = intf_w.mon_cb.wrst_n;
    req.wfull = intf_w.mon_cb.wfull;
  endtask
  
endclass
