class fifo_write_driver extends uvm_driver#(fifo_write_seq_item);
  `uvm_component_utils(fifo_write_driver)
  virtual fifo_write_inf.DRV intf_w;

  function new(string name= "fifo_write_driver", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_write_inf)::get(this,"","vif_w",intf_w))
      `uvm_info(get_full_name(),": VIF_W not found",UVM_LOW) 
  endfunction 

  task run_phase(uvm_phase phase);
    repeat(3) @(intf_w.drv_cb);
    forever begin
      req = fifo_write_seq_item::type_id::create("req");
      seq_item_port.get_next_item(req);
      drive_intf();
      repeat(2) @(intf_w.drv_cb);
      seq_item_port.item_done();
    end
  endtask

  task drive_intf();
    intf_w.drv_cb.winc  <= req.winc;
    intf_w.drv_cb.wrst_n <= req.wrst_n;
    intf_w.drv_cb.wdata <= req.wdata;
  endtask

endclass
