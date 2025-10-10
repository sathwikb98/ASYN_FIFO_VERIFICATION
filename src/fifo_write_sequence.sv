class fifo_write_sequence extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence)

  function new(string name = "fifo_write_sequence");
    super.new(name);
  endfunction

  task body();
    req = fifo_write_seq_item::type_id::create("req");
    $display("\n*-------------------> [0] WRITE_SEQUENCE_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      start_item(req);
      assert(req.randomize() with {req.winc == 1;} )
      finish_item(req);
      //$display("-------------------> [%0d] WRITE_SEQUENCE_FINISHED <-----------------------",count);
    end
    $display("\n*-------------------> [0] WRITE_SEQUENCE1_START <-----------------------*\n",$time);
  endtask

endclass

class fifo_write_sequence2 extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence2)

  fifo_write_seq_item req;

  function new(string name = "fifo_write_sequence2");
    super.new(name);
  endfunction: new

  task body();
    int count;
    bit prev_winc = 1'b1; // starts with write operation high 
    $display("\n*-------------------> [1] WRITE_SEQUENCE2_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == prev_winc;})
      if(count < 1) prev_winc = 1'b1; // initially start with winc as high !
      else  prev_winc = ~prev_winc;
      count++;
    end
    $display("\n*-------------------> [1] WRITE_SEQUENCE2_FINISHED <-----------------------*\n",$time);
  endtask: body

endclass

class fifo_write_sequence3 extends uvm_sequence#(fifo_write_seq_item);
  `uvm_object_utils(fifo_write_sequence3)

  fifo_write_seq_item req;

  function new( string name = "fifo_write_sequence3");
      super.new(name);
  endfunction

  task body();
    $display("\n*-------------------> [2] WRITE_SEQUENCE3_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 1;})
    end
    repeat(`no_of_transaction) begin
      req = fifo_write_seq_item::type_id::create("req");
      `uvm_rand_send_with(req, {req.winc == 0;})
    end
    $display("\n*-------------------> [2] WRITE_SEQUENCE3_FINISHED <-----------------------*\n",$time);
  endtask

endclass
