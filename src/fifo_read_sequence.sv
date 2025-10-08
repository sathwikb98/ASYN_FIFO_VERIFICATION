class fifo_read_sequence extends uvm_sequence#(fifo_read_seq_item); // read sequence 
  `uvm_object_utils(fifo_read_sequence)
  int count;

  function new(string name = "fifo_read_sequence");
    super.new(name);
  endfunction

  task body();
    req = fifo_read_seq_item::type_id::create("req");
    repeat(`no_of_transaction) begin
      count++;
      start_item(req);
      assert(req.randomize() with {req.rinc == 1;})
      finish_item(req); 
      //$display("-------------------> [%0d] READ_SEQUENCE_FINISHED <-----------------------",count);
    end
  endtask
endclass

  class fifo_read_sequence2 extends uvm_sequence#(fifo_read_seq_item);
  `uvm_object_utils(fifo_read_sequence2)

  fifo_read_seq_item req;

  function new( string name = "fifo_read_sequence2");
      super.new(name);
  endfunction: new
  task body();
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 0;})
    end
 endtask: body
endclass : fifo_read_sequence2

class fifo_read_sequence3 extends uvm_sequence#(fifo_read_seq_item);
  `uvm_object_utils(fifo_read_sequence3)

  fifo_read_seq_item req;

  function new( string name = "fifo_rsequence3");
      super.new(name);
  endfunction: new

  task body();
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 0;})
    end
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 1;})
    end
 endtask: body
endclass : fifo_read_sequence3
