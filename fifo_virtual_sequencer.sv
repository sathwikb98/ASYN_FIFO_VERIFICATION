class fifo_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(fifo_virtual_sequencer)
  
  fifo_write_sequencer wr_seqr;
  fifo_read_sequencer rd_seqr;

  function new(string name = "fifo_virtual_sequencer", uvm_component parent =null);
    super.new(name,parent);
  endfunction
/*
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_seqr = fifo_write_sequencer::type_id::create("wr_seqr",this);
    rd_seqr = fifo_read_sequencer::type_id::create("rd_seqr",this);
  endfunction 
*/
endclass
