class fifo_write_sequence extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence)
  int count;
  function new(string name = "fifo_write_sequence");
    super.new(name);
  endfunction 

  task body();
    req = fifo_write_seq_item::type_id::create("req");
    repeat(`no_of_transaction) begin
      count++;
      start_item(req);
      assert(req.randomize() with {req.winc == 1;} )
      finish_item(req);
      //$display("-------------------> [%0d] WRITE_SEQUENCE_FINISHED <-----------------------",count);
    end
  endtask

endclass

class fifo_write_sequence2 extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence2)

  fifo_write_seq_item req;

  function new(string name = "fifo_write_sequence2");
    super.new(name);
  endfunction: new

  task body();
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 1;})
    end
  endtask: body

endclass

class fifo_write_sequence3 extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence3)

  fifo_write_seq_item req;

  function new( string name = "fifo_write_sequence3");
      super.new(name);
  endfunction

  task body();
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 1;})
    end
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 0;})
    end
  endtask

endclass 
