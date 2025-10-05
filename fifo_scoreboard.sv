`uvm_analysis_imp_decl(_wr_mon)
`uvm_analysis_imp_decl(_rd_mon)
//`include "defines.svh"

class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)
  uvm_analysis_imp_wr_mon#(fifo_write_seq_item, fifo_scoreboard) analysis_write_imp;
  uvm_analysis_imp_rd_mon#(fifo_read_seq_item, fifo_scoreboard) analysis_read_imp;

  fifo_write_seq_item wr_seq_item;
  fifo_read_seq_item rd_seq_item;

  fifo_write_seq_item wr_queue[$];
  fifo_read_seq_item rd_queue[$];

  fifo_read_seq_item ref_rd_seq;
  fifo_write_seq_item ref_wr_seq;


  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name,parent);
    analysis_write_imp = new("analysis_write_imp", this);
    analysis_read_imp = new("analysis_read_imp",this);
  endfunction

  function void write_wr_mon(fifo_write_seq_item req);
    wr_queue.push_back(req);
    $display("write data received here @ %0t", $time);
  endfunction

  function void write_rd_mon(fifo_read_seq_item req);
    rd_queue.push_back(req);
    $display("read data received here @ %0t", $time);
  endfunction

  task wr_scb;

  endtask

  task rd_scb;

  endtask

  task run_phase(uvm_phase phase);
    fork
      begin // process 1 : write 
        @(wr_queue.size() > 0);
        wr_seq_item = wr_queue.pop_front();
        // scoreboard write reference model task
      end
      begin // process 2 : read 
        @(rd_queue.size() > 0);
        rd_seq_item = rd_queue.pop_front();
        //scoreboard read reference model task
      end
      join_any 

  endtask


endclass
