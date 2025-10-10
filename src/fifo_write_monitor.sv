class fifo_write_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_write_monitor)

  virtual fifo_inf intf;
  uvm_analysis_port#(fifo_write_seq_item) analysis_port_monitor_w;
  fifo_write_seq_item req;

  function new(string name ="fifo_write_monitor", uvm_component parent =null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this,"","vif",intf))
      `uvm_error(get_full_name(),"VIF not in write monitor !!")
    analysis_port_monitor_w = new("analysis_port_mon_w",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    repeat(4) @(intf.write_mon_cb);
    forever begin
      req = fifo_write_seq_item::type_id::create("req");
      repeat(1) @(intf.write_mon_cb);
      set_req();
      $display("\n--------------WRITE MONITOR------------------------");
      $display("------------------> [time : %0t] write_monitor sequence :",$time);
      req.print_seq; // prints the data that is given from dut !
      $write("| wrst_n : %0b \n",intf.wrst_n);
      $display("--------------WRITE MONITOR--------------------------\n");
      analysis_port_monitor_w.write(req);
      //repeat(1) @(intf.write_mon_cb);
    end
  endtask

  task set_req();
    req.winc = intf.winc;
    req.wdata = intf.wdata;
    req.wfull = intf.wfull;
  endtask
  
endclass
