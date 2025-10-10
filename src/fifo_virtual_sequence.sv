class fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(fifo_virtual_sequence)

  int sel_t;

  fifo_write_sequence seq_w;
  fifo_read_sequence seq_r;

  fifo_write_sequence2 seq_w2;
  fifo_read_sequence2 seq_r2;

  fifo_write_sequence3 seq_w3;
  fifo_read_sequence3 seq_r3;


  //`uvm_declare_p_sequencer(fifo_virtual_sequencer)

  task body();
    fifo_env env_s;
    
    // 1.
    seq_w = fifo_write_sequence::type_id::create("wr_seq");
    seq_r = fifo_read_sequence::type_id::create("rd_seq");
    // 2. ...
    seq_w2 = fifo_write_sequence2::type_id::create("wr2_seq");
    seq_r2 = fifo_read_sequence2::type_id::create("rd2_seq");
    // 3
    seq_w3 = fifo_write_sequence3::type_id::create("wr3_seq");
    seq_r3 = fifo_read_sequence3::type_id::create("rd3_seq");

    if(!$cast(env_s,uvm_top.find("uvm_test_top.env_h"))) `uvm_error(get_full_name()," env_h is not found !")

    if(!uvm_config_db#(int)::get(null,"","select_test",sel_t))
      `uvm_error(get_type_name(),": Test was not correctly selected !!")

    if(sel_t == 1) begin
      fork  // 1st sequence ...
         seq_w.start(env_s.v_seqr.seqr_w);
         seq_r.start(env_s.v_seqr.seqr_r);
      join
    end
    else if(sel_t == 2) begin
      fork // 2nd sequence ...
        seq_w2.start(env_s.v_seqr.seqr_w);
        seq_r2.start(env_s.v_seqr.seqr_r);
      join
    end
    else if(sel_t == 3) begin
      fork // 3rd sequence ... first write then read sequence !!
        seq_w3.start(env_s.v_seqr.seqr_w);
        seq_r3.start(env_s.v_seqr.seqr_r);
      join
    end
    else begin // regression....
      fork  // 1st sequence ...
         seq_w.start(env_s.v_seqr.seqr_w);
         seq_r.start(env_s.v_seqr.seqr_r);
      join
      fork // 2nd sequence ...
         seq_w2.start(env_s.v_seqr.seqr_w);
         seq_r2.start(env_s.v_seqr.seqr_r);
      join
      fork // 3rd sequence ... first write then read sequence !!
         seq_w3.start(env_s.v_seqr.seqr_w);
         seq_r3.start(env_s.v_seqr.seqr_r);
      join
    end

  endtask

endclass
