class fifo_read_driver extends uvm_driver#(fifo_read_seq_item);
  `uvm_component_utils(fifo_read_driver)
  virtual fifo_inf intf;

  function new(string name= "fifo_read_driver", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this,"","vif",intf))
      `uvm_info(get_full_name(),": VIF_R not found in driver",UVM_LOW)
  endfunction

  task run_phase(uvm_phase phase);
    repeat(3) @(intf.read_drv_cb);  
    forever begin
      seq_item_port.get_next_item(req);
      drive_intf();
      repeat(2) @(intf.read_drv_cb);
      $display("-----------------READ DRIVER------------------------");
      $display("-----------> [time : %0t]  read driver sequence :",$time);
      req.print_seq; // prints the data that is sent to dut !
      $write("| rrst_n : %0b \n",intf.rrst_n);
      $display("-----------------READ DRIVER------------    ------------"); 
      seq_item_port.item_done();
    end
  endtask

  task drive_intf();
    intf.rinc  <= req.rinc;
  endtask

endclass
