class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
  
  fifo_env env_h;
  fifo_virtual_sequence v_seq;

  function new(string name ="fifo_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = fifo_env::type_id::create("env_h",this);
  endfunction 

  task run_phase(uvm_phase phase);
    uvm_objection phase_done = phase.get_objection();
    v_seq = fifo_virtual_sequence::type_id::create("v_seq");
    phase.raise_objection(this);
    v_seq.start(env_h.v_seqr); // start an virtual sequence !!
    phase.drop_objection(this);
    phase_done.set_drain_time(this,20);
  endtask

endclass
