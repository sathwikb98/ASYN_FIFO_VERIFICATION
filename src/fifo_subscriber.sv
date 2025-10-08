`uvm_analysis_imp_decl(_mon_wr_cg)
class fifo_subscriber extends uvm_component;
  `uvm_component_utils(fifo_subscriber)

  uvm_analysis_imp_mon_wr_cg#(fifo_write_seq_item, fifo_subscriber) mon_w_port;
  uvm_analysis_imp#(fifo_read_seq_item, fifo_subscriber) mon_r_port;

  fifo_write_seq_item wmon_item;
  fifo_read_seq_item rmon_item;

  real w_cov, r_cov;

  covergroup input_cvg;
    winc_cp : coverpoint wmon_item.winc {
      bins hl_winc[] = {0, 1};
    }
    rinc_cp : coverpoint rmon_item.rinc {
      bins hl_rinc[] = {0, 1};
    }
    wdata_cp : coverpoint wmon_item.wdata {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }
    winc_cp_x_wdata_cp : cross wmon_item.winc, wmon_item.wdata;
  endgroup

  covergroup output_cvg;
    rdata_cp: coverpoint rmon_item.rdata {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }

    wfull_cp: coverpoint wmon_item.wfull {
      bins hl_wfull[] = {0, 1};
    }

    rempty_cp: coverpoint rmon_item.rempty {
      bins hl_rempty[] = {0, 1};
    }

  endgroup

  function new(string name = "apb_coverage", uvm_component parent);
    super.new(name, parent);
    input_cvg = new;
    output_cvg = new;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_w_port = new("mon_w_port", this);
    mon_r_port = new("mon_r_port", this);
    wmon_item = fifo_write_seq_item::type_id::create("wmon_item", this);
    rmon_item = fifo_read_seq_item::type_id::create("rmon_item", this);
  endfunction

  function void write(fifo_read_seq_item t);
    rmon_item = t;
    input_cvg.sample();
    output_cvg.sample();
  endfunction

  function void write_mon_wr_cg(fifo_write_seq_item t);
    wmon_item = t;
    input_cvg.sample();
    output_cvg.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    w_cov = input_cvg.get_coverage();
    r_cov = output_cvg.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name, $sformatf("Input Coverage ------> %0.2f%%,", w_cov), UVM_MEDIUM);
    `uvm_info(get_type_name, $sformatf("Output Coverage ------> %0.2f%%", r_cov), UVM_MEDIUM);
  endfunction

endclass
