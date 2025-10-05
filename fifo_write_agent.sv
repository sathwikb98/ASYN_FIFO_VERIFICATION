class fifo_write_agent extends uvm_agent;
  `uvm_component_utils(fifo_write_agent)
  fifo_write_sequencer seqr_w;
  fifo_write_driver drv_w;
  fifo_write_monitor mon_w;

  function new(string name="fifo_write_agent",uvm_component parent);
    super.new(name,parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr_w = fifo_write_sequencer::type_id::create("seqr_w",this);
    drv_w = fifo_write_driver::type_id::create("drv_w",this);
    mon_w = fifo_write_monitor::type_id::create("mon_w",this);
  endfunction 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv_w.seq_item_port.connect(seqr_w.seq_item_export);
  endfunction

endclass
