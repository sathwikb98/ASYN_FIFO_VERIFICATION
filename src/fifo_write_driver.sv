class fifo_write_driver extends uvm_driver#(fifo_write_seq_item);
  `uvm_component_utils(fifo_write_driver)
  virtual fifo_inf intf;

  function new(string name= "fifo_write_driver", uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_inf)::get(this,"","vif",intf))
      `uvm_info(get_full_name(),": VIF_W not found",UVM_LOW) 
  endfunction 

  task run_phase(uvm_phase phase);
    repeat(3) @(intf.write_drv_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive_intf();
      repeat(1) @(intf.write_drv_cb);
      $display("\n------------------ WRITE DRIVER -------------------");
      $display("-------------------->[time : %0t]  write driver sequence :",$time);
      req.print_seq; // prints the data that is sent to dut !
      $write("| wrst_n : %0b \n",intf.wrst_n);
      $display("------------------ WRITE DRIVER -------------------\n");
      //repeat(2) @(intf.write_drv_cb); // this delay for monitor end to recieve and process !!
      seq_item_port.item_done();
    end
  endtask

  task drive_intf();
    intf.winc  <= req.winc;
    intf.wdata <= req.wdata;
  endtask

endclass
