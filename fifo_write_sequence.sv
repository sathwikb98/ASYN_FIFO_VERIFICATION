class fifo_write_sequence extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence)
  function new(string name = "fifo_write_sequence");
    super.new(name);
  endfunction 

  task body();
    req = fifo_write_seq_item::type_id::create("req");
    repeat(`no_of_transaction) begin
      start_item(req);
      assert(req.randomize() with {req.winc == 1; req.wrst_n== 1;} )
      finish_item(req);
    end
  endtask
endclass
