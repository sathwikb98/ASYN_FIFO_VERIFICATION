class fifo_read_seq_item extends uvm_sequence_item;

  rand logic rinc;
  rand logic rrst_n;
  logic [`DSIZE-1:0] rdata;
  logic rempty;

  `uvm_object_utils_begin(fifo_read_seq_item)
  `uvm_field_int(rinc, UVM_ALL_ON)
  `uvm_field_int(rrst_n, UVM_ALL_ON)
  `uvm_object_utils_end

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    $display("rinc : %0b  |  rrst_n : %0b  |  rdata : %0d  | rempty : %0b",rinc,rrst_n,rdata,rempty);
  endfunction 

  function new(string name ="fifo_read_seq_item");
    super.new(name);
  endfunction

endclass
