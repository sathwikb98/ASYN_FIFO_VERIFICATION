/*
class fifo_scoreboard extends uvm_scoreboard;

  bit [7:0] expect_q[$];
  bit [7:0] full_q[$];

  int pass_count, fail_count;

  uvm_tlm_analysis_fifo #(fifo_write_seq_item)  exp_port;
  uvm_tlm_analysis_fifo #(fifo_read_seq_item)  act_port;

  `uvm_component_utils(fifo_scoreboard)

  function new( string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    fifo_write_seq_item get_expect;
    fifo_read_seq_item get_actual;
    bit[7:0] tmp_trans;

    fork
      forever begin
        exp_port.get(get_expect);
        expect_q.push_back(get_expect.wdata);
        full_q.push_back(get_expect.wdata);
        if(full_q.size() == 14) begin
          if(get_expect.wfull)
            $display("THE FIFO FULL CORRECTLY ASSERTED");
          else
            $display("THE FIFO FULL WAS NOT ASSERTED");
        end
      end
      forever begin
        act_port.get(get_actual);
        if(expect_q.size() > 0) begin
          tmp_trans = expect_q.pop_front();
          if(tmp_trans == get_actual.rdata) begin
            pass_count++;
            `uvm_info("SCB", "MATCHED", UVM_LOW);
            $display("The expected pkt-data is");
            $display("%0d", tmp_trans);
            $display("The actual pkt-data is");
            $display("%0d", get_actual.rdata);
          end
          else if( get_expect.wfull) begin
            `uvm_error("SCB", "FULL CONDITION THEREFORE NO COMPARISION");
          end
          else begin
            fail_count++;
            `uvm_error("SCB", "MISMATCHED");
            $display("The expected pkt-data is");
            $display("%0d", tmp_trans);
            $display("The actual pkt-data is");
            $display("%0d", get_actual.rdata);
          end
        end
        else begin
          `uvm_error("SCB", "Received from DUT, while Expect Queue is empty\n");
          $display("The unexpected pkt which is read....\n");
          get_actual.print_seq; // prints the data that is recived from dut !
        end
      end
    join_none
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("");
    `uvm_info("SCB", $sformatf("TOTAL PASS: %0d", pass_count), UVM_NONE)
    `uvm_info("SCB", $sformatf("TOTAL FAIL: %0d", fail_count), UVM_NONE)
  endfunction
endclass
*/

class fifo_scoreboard extends uvm_scoreboard;

  bit [`DSIZE-1:0] expect_q[$:`DEPTH-1];

  int pass_count, fail_count;
  int WRITE_F_P, WRITE_F_F;     // write full pass/fail
  int READ_EMP_P, READ_EMP_F;   // read empty pass/fail

  uvm_tlm_analysis_fifo #(fifo_write_seq_item)  exp_port;
  uvm_tlm_analysis_fifo #(fifo_read_seq_item)   act_port;

  `uvm_component_utils(fifo_scoreboard)

  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    fifo_write_seq_item get_expect;
    fifo_read_seq_item get_actual;
    bit [`DSIZE-1:0] tmp_trans;

    fork
      forever begin // WRITE OPERATION.......!
        exp_port.get(get_expect);
        if(get_expect.winc == 1) begin
          expect_q.push_back(get_expect.wdata);
          $display("---------------------------------------------------------------------");
          $display("FIFO_MEM : %0p",expect_q);
          $display("---------------------------------------------------------------------");

          if(get_expect.wfull ==1 && expect_q.size() ==`DEPTH-1) begin
             $display("-----------------------------------------------------------------");
             `uvm_info(get_full_name(),"FIFO FULL is correctly asserted.",UVM_MEDIUM)
             $display("-----------------------------------------------------------------");
             WRITE_F_P++;
          end
          else if(get_expect.wfull ==0 && expect_q.size() ==`DEPTH-1) begin
            $display("-----------------------------------------------------------------");
            `uvm_info(get_full_name(),"FIFO FULL is not correctly asserted !!",UVM_MEDIUM)
            $display("-----------------------------------------------------------------");
            WRITE_F_F++;
          end
        end
      end

      forever begin // READ OPERATION........ !!
        act_port.get(get_actual);

        if(expect_q.size() > 0 && get_actual.rinc == 1) begin
          tmp_trans = expect_q.pop_front();

          if(tmp_trans == get_actual.rdata) begin
            pass_count++;
            `uvm_info("SCB", "MATCHED", UVM_LOW);
            $display("The expected pkt-data is");
            $display("%0d", tmp_trans);
            $display("The actual pkt-data is");
            $display("%0d", get_actual.rdata);
          end
      /*  else if( get_expect.wfull) begin
            `uvm_error("SCB", "......FULL CONDITION THEREFORE CAN'T COMPARE........");
          end   */
          else begin
            fail_count++;
            `uvm_error("SCB", "MISMATCHED");
            $display("The expected pkt-data is");
            $display("%0d", tmp_trans);
            $display("The actual pkt-data is");
            $display("%0d", get_actual.rdata);
          end
        end
        else begin
          `uvm_error("SCB", "Received from DUT, while Expect Queue[REFERENCE_FIFO_MEM] is empty\n");
          $display("The unexpected pkt which is read....\n");
          get_actual.print_seq; // prints the data that is recived from dut !
          $display("");
        end
        
        if(expect_q.size ==0 && get_actual.rempty == 1) begin
           $display("-----------------------------------------------------------------");
           `uvm_info(get_full_name(),"FIFO EMPTY is correctly asserted.",UVM_MEDIUM)
            $display("-----------------------------------------------------------------");
            READ_EMP_P++;
        end
        else if(expect_q.size ==0 && get_actual.rempty == 0) begin
            $display("-----------------------------------------------------------------");
            `uvm_info(get_full_name(),"FIFO EMPTY is not correctly asserted !!",UVM_MEDIUM)
            $display("-----------------------------------------------------------------");
            READ_EMP_F++;
        end
      end
    
    join_none
  
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("");
    `uvm_info("SCB", $sformatf("TOTAL PASS: %0d", pass_count), UVM_NONE)
    `uvm_info("SCB", $sformatf("TOTAL FAIL: %0d", fail_count), UVM_NONE)
    $display("--------------------------------------------------------------------");
    `uvm_info("SCB", $sformatf("\nFIFO_WRITE_FULL_PASS : %0d  |   FIFO_WRITE_FULL_FAIL : %0d\nFIFO_READ_EMPTY_PASS :%0d  | FIFO_READ_EMPTY_FAIL : %0d",WRITE_F_P,WRITE_F_F,READ_EMP_P,READ_EMP_F),UVM_MEDIUM)
    $display("--------------------------------------------------------------------");
  endfunction
endclass
