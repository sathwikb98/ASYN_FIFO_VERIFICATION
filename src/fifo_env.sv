class fifo_env extends uvm_env;
`uvm_component_utils(fifo_env)

  fifo_virtual_sequencer v_seqr;
  fifo_write_agent agt_w;
  fifo_read_agent agt_r;
  fifo_scoreboard scb;
  //fifo_subscriber sub;

  function new(string name ="fifo_env", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    v_seqr = fifo_virtual_sequencer::type_id::create("v_seqr",this);
    agt_w = fifo_write_agent::type_id::create("agent_w",this);
    agt_r = fifo_read_agent::type_id::create("agent_r",this);
    scb = fifo_scoreboard::type_id::create("scoreboard",this);
    //sub = fifo_subscriber::type_id::create("subscriber",this);
  endfunction 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //v_seqr.seqr_w = agt_w.seqr_w;
    //v_seqr.seqr_r = agt_r.seqr_r;

    agt_w.mon_w.analysis_port_monitor_w.connect(scb.analysis_write_imp);
    agt_r.mon_r.analysis_port_monitor_r.connect(scb.analysis_read_imp);
    // subscriber ....
  endfunction

endclass
