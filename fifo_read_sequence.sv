class fifo_read_sequence extends uvm_sequence#(fifo_read_seq_item); // read sequence 
  `uvm_object_utils(fifo_read_sequence)
  function new(string name = "fifo_read_sequence");
    super.new(name);
  endfunction

  task body();
    req = fifo_read_seq_item::type_id::create("req");
    repeat(`no_of_transaction) begin
      start_item(req);
      assert(req.randomize() with {req.rinc == 1; req.rrst_n== 1;} )
      finish_item(req);
    end
  endtask
endclass
