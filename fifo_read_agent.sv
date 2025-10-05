class fifo_read_agent extends uvm_agent;
  `uvm_component_utils(fifo_read_agent)
  fifo_read_sequencer seqr_r;
  fifo_read_driver drv_r;
  fifo_read_monitor mon_r;

  function new(string name="fifo_read_agent",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr_r = fifo_read_sequencer::type_id::create("seqr_r",this);
    drv_r = fifo_read_driver::type_id::create("drv_r",this);
    mon_r = fifo_read_monitor::type_id::create("mon_r",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv_r.seq_item_port.connect(seqr_r.seq_item_export);
  endfunction

endclass

