class fifo_read_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_read_monitor)

  virtual fifo_inf intf;
  uvm_analysis_port#(fifo_read_seq_item) analysis_port_monitor_r;
  fifo_read_seq_item req;

  function new(string name ="fifo_read_monitor", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this,"","vif",intf))
      `uvm_error(get_full_name()," : Couldnt get read_VIF handle")
    analysis_port_monitor_r = new("analysis_port_mon_r",this);
  endfunction

  task run_phase(uvm_phase phase);
    repeat(4) @(intf.read_mon_cb);
    forever begin
      req = fifo_read_seq_item::type_id::create("req");
      repeat(1) @(intf.read_mon_cb);
      set_req();
      $display("\n----------READ MONITOR-------------------------------");
      $display("################## [time: %0t] read_monitor sequence : ",$time);
      req.print_seq; // prints the data that is given from dut !
      $write("| rrst_n : %0b \n",intf.rrst_n);
      analysis_port_monitor_r.write(req);
      $display("----------READ MONITOR-------------------------------\n");
      //repeat(2) @(intf.read_mon_cb);
    end
  endtask

  task set_req();
    req.rinc = intf.rinc;
    req.rdata = intf.rdata;
    req.rempty = intf.rempty;
  endtask

endclass
