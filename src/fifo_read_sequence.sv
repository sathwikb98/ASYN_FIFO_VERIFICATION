class fifo_read_sequence extends uvm_sequence#(fifo_read_seq_item); // read sequence
  `uvm_object_utils(fifo_read_sequence)

  function new(string name = "fifo_read_sequence");
    super.new(name);
  endfunction

  task body();
    $display("\n*-------------------> [0] READ_SEQUENCE1_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 1;})
      start_item(req);
      assert(req.randomize() with {req.rinc == 1;})
      finish_item(req); 
    end
    $display("\n*-------------------> [0] READ_SEQUENCE1_FINISHED <----------------------*\n",$time);
  endtask
endclass

class fifo_read_sequence2 extends uvm_sequence#(fifo_read_seq_item);
  `uvm_object_utils(fifo_read_sequence2)

  fifo_read_seq_item req;

  function new( string name = "fifo_read_sequence2");
      super.new(name);
  endfunction: new
  task body();
    bit prev_rinc = 1'b1;
    $display("\n*-------------------> [1] READ_SEQUENCE2_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == prev_rinc;})
      prev_rinc = ~prev_rinc;
    end
    $display("\n*-------------------> [1] READ_SEQUENCE2_FINISHED <-----------------------*\n",$time);
 endtask: body
endclass : fifo_read_sequence2

class fifo_read_sequence3 extends uvm_sequence#(fifo_read_seq_item);
  `uvm_object_utils(fifo_read_sequence3)

  fifo_read_seq_item req;

  function new( string name = "fifo_read_sequence3");
      super.new(name);
  endfunction: new

  task body();
    int count ;
    bit prev_rinc = 1;
    $display("\n*-------------------> [2] READ_SEQUENCE3_START <-----------------------*\n",$time);
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == prev_rinc;}) 
      if(count == 1)begin
        prev_rinc = 0;
      end
      count++;
    end
    repeat(`no_of_transaction) begin
      req = fifo_read_seq_item::type_id::create("req");
      `uvm_rand_send_with(req,{req.rinc == 1;})
    end
    $display("\n*-------------------> [2] READ_SEQUENCE3_FINISHED <-----------------------*\n",$time);
 endtask: body
endclass : fifo_read_sequence3
