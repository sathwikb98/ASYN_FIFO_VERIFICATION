class fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(fifo_virtual_sequence)
  fifo_write_sequence wr_seq;
  fifo_read_sequence rd_seq;

  //fifo_write_sequencer wr_seqr;
  //fifo_read_sequencer rd_seqr;

  //`uvm_declare_p_sequencer(fifo_virtual_sequencer)

  task body();
    fifo_env env_s;

    wr_seq = fifo_write_sequence::type_id::create("wr_seq");
    rd_seq = fifo_read_sequence::type_id::create("rd_seq");
    
    if(!$cast(env_s,uvm_top.find("uvm_test_top.env_h"))) `uvm_error(get_full_name()," env_h is not found !")

    wr_seq.start(env_s.v_seqr.wr_seqr);
    rd_seq.start(env_s.v_seqr.rd_seqr);
  endtask

endclass
