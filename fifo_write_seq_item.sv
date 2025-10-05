class fifo_write_seq_item extends uvm_sequence_item;
  rand logic winc;
  rand logic wrst_n;
  rand logic [`DSIZE-1:0] wdata;
  logic wfull;

  `uvm_object_utils_begin(fifo_write_seq_item)
  `uvm_field_int(winc, UVM_ALL_ON)
  `uvm_field_int(wrst_n, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_object_utils_end

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    $display("winc : %0b  |  wrst_n : %0b  |  wdata : %d  |  wfull : %0b",winc,wrst_n,wdata,wfull);
  endfunction 

  function new(string name = "fifo_write_seq_item");
    super.new(name);
  endfunction 

endclass
