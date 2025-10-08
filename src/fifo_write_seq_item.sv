class fifo_write_seq_item extends uvm_sequence_item;
  `uvm_object_utils(fifo_write_seq_item)
  rand logic winc;
  //rand logic wrst_n;
  rand logic [`DSIZE-1:0] wdata;
  logic wfull;
/*  
  `uvm_object_utils_begin(fifo_write_seq_item)
  `uvm_field_int(winc, UVM_ALL_ON | UVM_DEC)
  //`uvm_field_int(wrst_n, UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(wdata, UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(wfull, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end


  function void do_print(uvm_printer printer);
    super.do_print(printer);
    //`uvm_info(get_type_name(),$sformatf("winc : %0b  |  wrst_n : %0b  |  wdata : %d  |  wfull : %0b",winc,wrst_n,wdata,wfull),UVM_LOW);
  endfunction 
*/

  function void print_seq();
    $write("winc : %0b  |  wdata : %0d  |  wfull : %0b ",winc,wdata,wfull);
  endfunction 

  function new(string name = "fifo_write_seq_item");
    super.new(name);
  endfunction 

endclass
