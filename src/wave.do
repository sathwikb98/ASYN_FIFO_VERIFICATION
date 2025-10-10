onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top/dut/rdata
add wave -noupdate -radix unsigned /top/dut/wfull
add wave -noupdate -radix unsigned /top/dut/rempty
add wave -noupdate -radix unsigned /top/dut/wdata
add wave -noupdate -radix unsigned /top/dut/winc
add wave -noupdate -radix unsigned /top/dut/wclk
add wave -noupdate -radix unsigned /top/dut/wrst_n
add wave -noupdate -radix unsigned /top/dut/rinc
add wave -noupdate -radix unsigned /top/dut/rclk
add wave -noupdate -radix unsigned /top/dut/rrst_n
add wave -noupdate -radix unsigned /top/dut/waddr
add wave -noupdate -radix unsigned /top/dut/raddr
add wave -noupdate -radix unsigned /top/dut/wptr
add wave -noupdate -radix unsigned /top/dut/rptr
add wave -noupdate -radix unsigned /top/dut/wq2_rptr
add wave -noupdate -radix unsigned /top/dut/rq2_wptr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {135 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2945 ns}
