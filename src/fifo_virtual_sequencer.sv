class fifo_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(fifo_virtual_sequencer)
  
  fifo_write_sequencer seqr_w;
  fifo_read_sequencer  seqr_r;

  function new(string name = "fifo_virtual_sequencer", uvm_component parent =null);
    super.new(name,parent);
  endfunction

endclass
