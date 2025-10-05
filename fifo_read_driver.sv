class fifo_read_driver extends uvm_driver#(fifo_read_seq_item);
  `uvm_component_utils(fifo_read_driver)
  virtual fifo_read_inf.DRV intf_r;

  function new(string name= "fifo_read_driver", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_read_inf)::get(this,"","vif_r",intf_r))
      `uvm_info(get_full_name(),": VIF_R not found in driver",UVM_LOW)
  endfunction

  task run_phase(uvm_phase phase);
    repeat(4) @(intf_r.drv_cb); // at 4th clock edge dut gets the input 
    forever begin
      req = fifo_read_seq_item::type_id::create("req");
      seq_item_port.get_next_item(req);
      @(intf_r.drv_cb);
      drive_intf();
      @(intf_r.drv_cb);
      seq_item_port.item_done();
    end
  endtask

  task drive_intf();
    intf_r.drv_cb.rinc  <= req.rinc;
    intf_r.drv_cb.rrst_n <= req.rrst_n;
  endtask

endclass
